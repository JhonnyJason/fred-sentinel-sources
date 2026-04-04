import { NetworkError, HttpError, ParseError } from "./errors.js"

export async function request(url, options = {}) {
    let response
    let data

    // 1. Network failure (DNS, timeout, CORS, no connection)
    try { response = await fetch(url, options) } 
    catch (err) { throw new NetworkError(err) }

    // 2. HTTP-level failure (4xx, 5xx)
    if (!response.ok) {
        let body = null
        try { body = await response.text() } catch (_) {}
        throw new HttpError(response.status, body)
    }

    // 3. Empty response
    if (response.status === 204) return

    // 4. Parse failure
    try { data = await response.json() } 
    catch (err) { throw new ParseError(err) }

    return data
}