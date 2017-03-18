require "paypal"

function post()
    if not app.PayPal.Enabled then
        http:redirect("/")
        return
    end

    if not session:isLogged() then
        http:redirect("/subtopic/login")
        return
    end

    local payment = cache:get("paypal_payment_" .. http.postValues["paymentId"])

    if payment == nil then
        session:setFlash("validationError", "Invalid payment")
        http:redirect("/subtopic/shop/paypal")
        return
    end

    local pkg = paypalList[payment.Name]

    if pkg == nil then
        session:setFlash("validationError", "Invalid package")
        http:redirect("/subtopic/shop/paypal")
        return
    end

    paypal:executePayment(payment.PaymentID, payment.PayerID)

    db:execute("UPDATE castro_accounts a, accounts b SET a.points = points + ? WHERE a.account_id = b.id AND b.name = ?", pkg.points, payment.Custom)

    cache:delete("paypal_payment_" .. http.postValues["paymentId"])

    session:setFlash("success", "Package purchased. " .. pkg.points .. " points given")

    http:redirect("/subtopic/shop/paypal")
end