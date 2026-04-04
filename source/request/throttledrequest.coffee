import { request as immediateRequest } from "./request.js"

############################################################
#region Throttled Request Queue
# FRED API limit: 2 requests/second
# Strategy: allow bursts of 2, only wait if the burst was faster than 1s
# Deduplication: identical URL + options pairs are coalesced — fetched once, result shared
queue = []
pending = new Map()  # key → {url, options, waiters: [{resolve, reject}, ...] }

processing = false
windowStart = 0
windowCount = 0
maxPerWindow = 2
windowMS = 1001  # 1s + 1ms safety margin

############################################################
waitMS = (ms) -> new Promise((res) -> setTimeout(res, ms))

############################################################
processQueue = ->
    return if processing or queue.length == 0 ## Queue is empty or active
    processing = true # set queu active

    while queue.length > 0
        # Start new measurement window
        if windowCount == 0 then windowStart = performance.now()
        windowCount++

        key = queue.shift()
        { url, options, waiters } = pending.get(key)
        
        try
            result = await immediateRequest(url, options)
            pending.delete(key)
            w.resolve(result) for w in waiters
        catch err
            pending.delete(key)
            w.reject(err) for w in waiters

        # After max requests, check if we need to slow down
        if windowCount >= maxPerWindow
            elapsed = performance.now() - windowStart
            remaining = windowMS - elapsed
            if remaining > 0 then await waitMS(remaining)
            windowCount = 0

    processing = false
    processQueue()
    return

############################################################
export request = (url, options = {}) -> # rate limited request
    # Deduplicating requests - sensitive to differing options
    try key = url + JSON.stringify(options)
    catch err then throw new Error("corrupted options passed!")
    # Notice: if two options objects are mutations in prop orders 
    #    even when the content is the same 
    #    it is still causing a separated request
    #    While this is suboptimal, it is very rare, causes no harm
    #    and no worthy solution was found yet
 
    promFun = (resolve, reject) ->
        if pending.has(key)
            pending.get(key).waiters.push({ resolve, reject })
            return
        pending.set(key, { url, options, waiters: [{ resolve, reject }] })
        queue.push(key)
        return

    prom = new Promise(promFun)
    processQueue() unless processing
    return prom

#endregion