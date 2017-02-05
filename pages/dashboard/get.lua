if not session:isLogged() then
    http:redirect("/subtopic/login")
    return
end

local data = {}

data.success = session:getFlash("success")
data.list = db:query("SELECT name, vocation, level FROM players WHERE account_id = ? ORDER BY id DESC", session:loggedAccount().ID)

http:render("dashboard.html", data)