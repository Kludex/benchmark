## FastAPI JSON

Study the performance of FastAPI using different JSON response classes.

## Results

| Application | Server | Requests | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | -----------: |-----------: | ---------------: | ---------------: | ---------------: |
| fastapi | uvicorn | 97564 | 6504 | 9.08 | 10.49 | 9.85
| fastapi-rapidjson | uvicorn | 96319 | 6421 | 9.35 | 9.88 | 9.99
| fastapi-orjson | uvicorn | 93537 | 6236 | 9.53 | 10.68 | 10.31
| fastapi-ujson | uvicorn | 91687 | 6112 | 9.55 | 11.12 | 10.52
