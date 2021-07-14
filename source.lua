-- Everything gets checked on the server, the client side doesn't matter

function Notify(text)
	game.StarterGui:SetCore("SendNotification",{
		Title = "backdoor.exe V6", Text = text
	})
end

http_request = http_request
if syn then http_request = syn.request end

local LocalPlayer = game.Players.LocalPlayer

local WEBSERVER_INDEX = "https://k4scripts.xyz/backdoor/Verify.php"
local URL = WEBSERVER_INDEX.."?way=GetWhitelist&whitelistKey=".. getgenv().whitelist_key .. "&usr=".. LocalPlayer.Name

Notify("Sending Request to server.")
local response = http_request({Url = (URL),Method = "GET"})

getgenv().whitelist_key = nil

if response.StatusCode == 200 then
	local response = response.Body
	if response == "Success!" then
		kickReason = "\nWhitelist Successful!\nDo ',getScript' to receive your script!"
	else
		kickReason = "\nWhitelist Failed!\nPlease check your key and try again."
	end

	LocalPlayer:Kick(kickReason)
	wait(0.1)
	while true do end

else
	Notify("Error Code: "..response.StatusCode)
end

