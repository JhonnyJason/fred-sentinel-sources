import { request } from "./throttledrequest.js"
import * as extr from "./dataextraction.js"
import * as urlCreate from "./urlcreate.js"

############################################################
toYYYYMMDD = (date) ->
    date = new Date(date)
    return date.toISOString().slice(0, 10)

############################################################
export class FRED
    constructor: (@key) ->
        @req = request
        @minDate = "1990-01-01"
        @maxDate = "9999-12-31"

    getCurrentMRR: =>
        url = urlCreate.latestMRR(@key)
        result = await @req(url)
        return extr.currentMRR(result)


    getTodaysDataReleases: =>
        url = urlCreate.todaysDataReleases(@key)
        result = await @req(url)
        return extr.dataReleases(result)        

    getDataReleasesForDate: (date) =>
        date = toYYYYMMDD(date)
        url = urlCreate.dataReleasesForDate(@key, date)
        result = await @req(url)
        return extr.dataReleases(result)        
    

    getReleaseDatesForId: (id) =>
        url = urlCreate.releaseDatesForId(@key, id, @minDate, @maxDate)
        result = await @req(url)
        return extr.releaseDates(result)

    getFutureReleaseDatesForId: (id) =>
        startDate = toYYYYMMDD(new Date()) # start from today

        url = urlCreate.releaseDatesForId(@key, id, startDate, @maxDate)
        result = await @req(url)
        return extr.releaseDates(result)
