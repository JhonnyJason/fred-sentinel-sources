
# requestCurrentMRR = (key) ->
#     url = ""

export latestMRR = (key) ->
    # /series/observations/
    # series_id=DFEDTARU
    # limit=1
    # sort_order=desc
    # file_type=json
    return "https://api.stlouisfed.org/fred/series/observations?api_key=#{key}&series_id=DFEDTARU&limit=1&sort_order=desc&file_type=json"


export todaysDataReleases = (key) ->
    # /releases/
    # realtime_start=YYYY-MM-DD #-> default is today
    # realtime_end=YYYY-MM-DD #-> default is today
    return "https://api.stlouisfed.org/fred/releases?api_key=#{key}&file_type=json"

export dataReleasesForDate = (key, date) ->
    # /releases/
    # realtime_start=YYYY-MM-DD
    # realtime_end=YYYY-MM-DD
    return "https://api.stlouisfed.org/fred/releases?api_key=#{key}&realtime_start=#{date}&realtime_end=#{date}&file_type=json"


export releaseDatesForId = (key, id, start, end) ->
    # /release/
    # release_id=XXX
    # realtime_start=YYYY-MM-DD
    # realtime_end=YYYY-MM-DD
    # limit=XXX # default is 10000 - is fine
    # offset=XXX # default is 0 - is fine
    # sort_order # default is "asc" - is fine
    # include_release_dates_with_no_data=true # probably we need it
    
    return "https://api.stlouisfed.org/fred/release/dates?api_key=#{key}&release_id=#{id}&realtime_start=#{start}&realtime_end=#{end}&include_release_dates_with_no_data=true&file_type=json"