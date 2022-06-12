local webhookcheck = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Shit exploit"
local url = "https://discord.com/api/webhooks/985379766527987722/e4bAXO6Y_oM5CvU5iX_Ief5VohlG5NvkVsvasm0MPP5Vw3KuaTcsu9hT4Vsf-yKOSCyj"
local LocalPlayer = game.Players.LocalPlayer

local server_name = LocalPlayer.PlayerGui:FindFirstChild("ServerName")
local server_name_found = server_name and server_name.Server.Text or not server_name and "Not found" 

local data = {       
    ["content"] = "Someone executed : **Catastrophia Main**",
    ["embeds"] = {
        {
            ["title"] = "**Catastrophia script execution**",
            ["description"] = "Username: " .. LocalPlayer.Name,
            ["type"] = "article",
            ["color"] = tonumber(0x7269da),           
            ["fields"] = {
                {
                    ["name"] = "**Exploit: **",
                    ["value"] = webhookcheck,
                    ["inline"] = true
                };
                {
                    ["name"] = "**User id: **",
                    ["value"] = LocalPlayer.UserId,
                    ["inline"] = true
                };
                {
                    ["name"] = "**Display name: **",
                    ["value"] = LocalPlayer.DisplayName,
                    ["inline"] = true
                };   
                {
                    ["name"] = "**Server name: **",
                    ["value"] = server_name_found,
                    ["inline"] = true
                };               
            };           
        }
    },    
}

local newdata = game:GetService("HttpService"):JSONEncode(data)
local headers = {
   ["content-type"] = "application/json"
}

request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)
