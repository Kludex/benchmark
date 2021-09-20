wrk.method = "PUT"
wrk.headers["content-type"] = "application/json"
wrk.headers["authorization"] = "user"
wrk.body   = [[{
    "timestamp": 1556283673.1523004,
    "task_uuid": "0ed1a1c3-050c-4fb9-9426-a7e72d0acfc7",
    "task_level": [1, 2, 3],
    "action_status": "started",
    "action_type": "main",
    "key": "value",
    "another_key": 123,
    "and_another": ["a", "b"]
}]]

app = os.getenv("APP")
server = os.getenv("SERVER")
filename = os.getenv("FILENAME")

done = function(summary, latency, requests)
    file = assert(io.open(filename, "a"))
    file.write(
        file,
        string.format(
            "%s,%s,%d,%.2f,%.2f,%.2f,%.2f,%d,%d,%d\n",
            app,
            server,
            summary.requests,
            latency:percentile(50) / 1000,
            latency:percentile(75) / 1000,
            latency:percentile(90) / 1000,
            latency.mean / 1000,
            summary.errors.status,
            summary.errors.read,
            summary.errors.timeout
            ));
    file.close()
end
