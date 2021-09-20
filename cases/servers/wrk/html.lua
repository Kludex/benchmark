wrk.method = "GET"
wrk.scheme = "http"
wrk.host = "localhost"
wrk.port = 8080

app = os.getenv("APP")
server = os.getenv("SERVER")
filename = os.getenv("FILENAME")
workers = os.getenv("WORKERS")

done = function(summary, latency, requests)
    file = assert(io.open(filename, "a"))
    file.write(
        file,
        string.format(
            "%s,%s,%d,%d,%.2f,%.2f,%.2f,%.2f,%d,%d,%d\n",
            app,
            server,
            workers,
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
