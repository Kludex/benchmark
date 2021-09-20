## FastAPI JSON

Study the performance of FastAPI using different JSON response classes.

The study was made using the following applications:

- [`fastapi`](https://github.com/Kludex/benchmark/tree/main/apps/fastapi): FastAPI application using the default `JSONResponse` class.
- [`fastapi-ujson`](https://github.com/Kludex/benchmark/tree/main/apps/fastapi-ujson): FastAPI application using the `UJSONResponse` class.
- [`fastapi-orjson`](https://github.com/Kludex/benchmark/tree/main/apps/fastapi-orjson): FastAPI application using the `ORJSONResponse` class.
- [`fastapi-rapidjson`](https://github.com/Kludex/benchmark/tree/main/apps/fastapi-rapidjson): FastAPI application using a custom `RapidJSONResponse` class.

## Results

| Application | Requests | Requests/sec | Latency 50% (ms) | Latency 75% (ms) | Latency Avg (ms) |
| --------- | -----------: |-----------: | ---------------: | ---------------: | ---------------: |
| fastapi-orjson | 212457 | 3541 | 14.16 | 24.41 | 18.05
| fastapi-ujson | 204415 | 3407 | 15.10 | 25.08 | 18.77
| fastapi-rapidjson | 195479 | 3258 | 15.24 | 26.50 | 19.63
| fastapi | 194794 | 3247 | 16.06 | 26.07 | 19.69


## Observations

Results may vary depending on the JSON body. For more information about each JSON package used,
check [orjson](https://github.com/ijl/orjson), [ujson](https://github.com/ultrajson/ultrajson)
and [rapidjson](https://github.com/python-rapidjson/python-rapidjson).

The following JSON body was used here:
```json
{
    "timestamp": 1556283673.1523004,
    "task_uuid": "0ed1a1c3-050c-4fb9-9426-a7e72d0acfc7",
    "task_level": [1, 2, 3],
    "action_status": "started",
    "action_type": "main",
    "key": "value",
    "another_key": 123,
    "and_another": ["a", "b"]
}
```
