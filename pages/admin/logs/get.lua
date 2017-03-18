function get()
if not session:isAdmin() then
    http:redirect("/")
end

local logsfile = io.open("logs/" .. logFile)
local data = {}
local line = logsfile:read("*l")

data.logs = {}

while line do
    table.insert(data.logs, json:unmarshal(line))
    line = logsfile:read("*l")
end

http:render("logs.html", data)
    end