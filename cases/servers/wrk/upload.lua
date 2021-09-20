function read_txt_file(path)
    local file, errorMessage = io.open(path, "r")
    if not file then
        error("Could not read the file:" .. errorMessage .. "\n")
    end

    local content = file:read "*all"
    file:close()
    return content
end

local Boundary = "----WebKitFormBoundaryePkpFF7tjBAqx29L"
local BodyBoundary = "--" .. Boundary
local LastBoundary = "--" .. Boundary .. "--"
local CRLF = "\r\n"
local ContentDisposition = "Content-Disposition: form-data; name=\"file\"; filename=\"test.txt\""
local FileBody = read_txt_file("/scripts/1kb.txt")

wrk.method = "POST"
wrk.headers["content-type"] = "multipart/form-data; boundary=" .. Boundary
wrk.body = BodyBoundary .. CRLF .. ContentDisposition .. CRLF .. CRLF .. FileBody .. CRLF .. LastBoundary

-- Save report

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
