olog = (obj) -> console.log(JSON.stringify(obj, null, 4))

############################################################
export currentMRR = (result) ->
    # olog result
    mrr = parseFloat(result.observations[0].value)
    mrrDate = new Date(result.observations[0].date)
        
    return { mrr, mrrDate }

############################################################
export dataReleases = (result) ->
    # olog result
    # date = result.realtime_start
    releases = []
    for rel in result.releases
        obj = Object.create(null)
        obj.name = rel.name
        obj.id = rel.id
        obj.startDate = rel.realtime_start
        obj.endDate = rel.realtime_end
        releases.push(obj) 
    return releases


export releaseDates = (result) ->
    # olog result
    releases = []
    releases.push(rd.date) for rd in result.release_dates
    return releases

        
