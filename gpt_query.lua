local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("json")

local function queryChatGPT(prompt)
  local api_url = "http://localhost:5001/api/v1/generate"

  local requestBody = json.encode({
    prompt = prompt,
    max_length = 250
  })

  local responseBody = {}

  local res, code = http.request {
    url = api_url,
    method = "POST",
    source = ltn12.source.string(requestBody),
    sink = ltn12.sink.table(responseBody),
    headers = {
      ["Content-Type"] = "application/json",
      ["Content-Length"] = tostring(#requestBody)
    }
  }

  if not res then
    error("HTTP request failed: " .. (code or "unknown error"))
  end

  if code ~= 200 then
    print("Response code: " .. code)
    print("Response body: " .. table.concat(responseBody))
    error("Error querying API: " .. code)
  end

  local response = json.decode(table.concat(responseBody))
  return response.results[1].text
end

return queryChatGPT
