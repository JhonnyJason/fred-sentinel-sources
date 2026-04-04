# fred-sentinel 

A minimal FRED API client with built-in request throttling.  
Created for the sentinel-backend with a focused feature set.

## Installation

```
npm install fred-sentinel
```

## Usage

```javascript
import { FRED } from 'fred-sentinel'

const fred = new FRED('your-api-key')
```

## API

### `getCurrentMRR()`
Returns the current Maximum Reserve Rate.
```javascript
const { mrr, mrrDate } = await fred.getCurrentMRR()
```

### `getTodaysDataReleases()`
Returns data releases scheduled for today.
```javascript
const releases = await fred.getTodaysDataReleases()
// Returns: [{ name, id, startDate, endDate }, ...]
```

### `getDataReleasesForDate(date)`
Returns data releases for a specific date.
```javascript
const releases = await fred.getDataReleasesForDate('2024-01-15')
// Also accepts Date objects
```

### `getReleaseDatesForId(id)`
Returns all release dates for a release ID.
```javascript
const dates = await fred.getReleaseDatesForId(123)
// Returns: ['2024-01-01', '2024-01-15', ...]
```

### `getFutureReleaseDatesForId(id)`
Returns future release dates for a release ID (from today onwards).
```javascript
const dates = await fred.getFutureReleaseDatesForId(123)
```

## Features

- **Throttled requests** - Respects FRED's 2 requests/second limit with burst support
- **Request deduplication** - Identical concurrent requests are coalesced
- **Minimal dependencies** - Lightweight and focused

## API Key

Get a free API key at [https://fred.stlouisfed.org/docs/api/api_key.html](https://fred.stlouisfed.org/docs/api/api_key.html)

# License
[CC0](https://creativecommons.org/publicdomain/zero/1.0/)
