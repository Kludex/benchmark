## FastAPI JSON

Study the performance of FastAPI using different JSON response classes.

## Results

| Application | Server | Requests | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: | -----------: |-----------: | ---------------: | ---------------: | ---------------: |
| fastapi-rapidjson | uvicorn | 227106 | 3785 | 17.92 | 21.97 | 16.88
| fastapi-orjson | uvicorn | 225353 | 3756 | 15.84 | 22.23 | 17.01
| fastapi-ujson | uvicorn | 221650 | 3694 | 19.04 | 22.21 | 17.29
| fastapi | uvicorn | 207893 | 3465 | 18.48 | 24.10 | 18.44
