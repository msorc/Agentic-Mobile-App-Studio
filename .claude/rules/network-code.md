---
paths:
  - "lib/**/data/**"
  - "lib/shared/services/**"
---

# Network Code Rules

- All API calls should be through repository interfaces (dependency injection)
- Handle offline gracefully — cache data locally when possible
- All API responses must be validated before use (null checks, type checks)
- Use retry logic with exponential backoff for transient failures
- Rate-limit API calls — debounce search, paginate lists
- All API keys/tokens must be stored securely — use environment variables or secure storage
- Log network errors at ERROR level with request context (endpoint, status code)
- All network code belongs in the `data/` layer, never in `presentation/`
- For REST: use `dio` package with interceptors for auth, logging, error handling
- For Firebase: use the official SDK with offline persistence enabled
