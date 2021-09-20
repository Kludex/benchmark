import time
from typing import Any
from uuid import uuid4

import rapidjson
from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse, PlainTextResponse, Response


class RapidJSONResponse(JSONResponse):
    def render(self, content: Any) -> bytes:
        return rapidjson.dumps(content, ensure_ascii=False).encode("utf-8")


app = FastAPI(default_response_class=RapidJSONResponse)


@app.get("/html")
async def html():
    """Return HTML content and a custom header."""
    content = "<b>HTML OK</b>"
    headers = {"x-time": f"{time.time()}"}
    return HTMLResponse(content, headers=headers)


@app.post("/upload")
async def upload(request: Request):
    """Load multipart data and store it as a file."""
    formdata = await request.form()
    if "file" not in formdata:
        return Response("ERROR", status_code=400)

    with open(f"/tmp/{uuid4().hex}", "wb") as target:
        target.write(await formdata["file"].read())

    return PlainTextResponse(target.name)


@app.put("/api/users/{user}/records/{record}")
async def api(request: Request, user: int, record: int):
    """Check headers for authorization, load JSON/query data and return as JSON."""
    if request.headers.get("authorization") is None:
        return Response("ERROR", status_code=401)

    return {
        "params": {"user": user, "record": record},
        "query": dict(request.query_params),
        "data": await request.json(),
    }
