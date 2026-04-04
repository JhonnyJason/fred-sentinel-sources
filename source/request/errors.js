export class ApiError extends Error {
    constructor(message, options = {}) {
        super(message);
        this.name = 'ApiError';
        this.statusCode = options.statusCode ?? null;
        this.body = options.body ?? null;       // raw server response, if any
        this.cause = options.cause ?? null;     // original error, if wrapping one
    }
}

export class NetworkError extends ApiError {
    constructor(err) {
        super(`Request failed: ${err.message}`, { cause: err });
        this.name = 'NetworkError';
    }
}

export class HttpError extends ApiError {
    constructor(statusCode, body) {
        super(`HTTP ${statusCode}`, { statusCode, body });
        this.name = 'HttpError';
    }
}

export class ParseError extends ApiError {
    constructor(cause) {
        super('Failed to parse response', { cause });
        this.name = 'ParseError';
    }
}

export class DataShapeError extends ApiError {
    constructor(message, body) {
        super(message, { body });
        this.name = 'DataShapeError';
    }
}