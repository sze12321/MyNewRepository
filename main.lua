loadstring(game:HttpGet("https://raw.githubusercontent.com/zakater5/LuaRepo/main/YBA/MainGui.lua"))()

function sellAllEquiped() 
    local args = {
        [1] = "EndDialogue",
        [2] = {
            ["Option"] = "Option2",
            ["Dialogue"] = "Dialogue5",
            ["NPC"] = "Merchant"
        }
    }
    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
end    
function contain(table, element)
    for _, value in ipairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end
local notSellableList = {"Lucky Arrow", "Requiem Arrow","Christmas Present"}
local Players = game:GetService("Players")
speaker = Players.LocalPlayer
char = speaker.Character 
human = char:WaitForChild("Humanoid")
function EquipItem(item)
    item.Parent = char
end

luckyArrowCount = 0
function SellAllAbleTosell()
    local playerBag = game:GetService("Players").LocalPlayer.Backpack
    luckyArrowCount = 0
    soldList = {}
    for _,item in ipairs(playerBag:GetChildren()) do
        if (not contain(notSellableList,item.Name)) and (not contain(soldList,item.Name)) then
            EquipItem(item)
            task.wait(0.1)
            sellAllEquiped()
            table.insert(soldList,item.Name)
            
            
            human:UnequipTools()
            task.wait(5)
            
            
        end
        if(item.Name == "Lucky Arrow") then
            luckyArrowCount = luckyArrowCount + 1
        end
    end
end



function BuyLuckyArrow()
    local args = {
        [1] = "PurchaseShopItem",
        [2] = {
            ["ItemName"] = "1x Lucky Arrow"
        }
    }
    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
end

function SeeIfBuyLuckyArrow()
    playerMoney = game:GetService("Players").LocalPlayer.PlayerStats.Money.Value
    if(playerMoney > 950000) and (luckyArrowCount < 9) then
        print("Have enough money:",playerMoney,luckyArrowCount)
        BuyLuckyArrow()
    else 
        print("No enough money:" ,playerMoney,luckyArrowCount)
    end
end

Loop = true

local Player = game. Players. LocalPlayer 
local PlayerName = Player.Name print(PlayerName)



if contain(G_.AllowedPlayer, PlayerName)  then 
        while Loop do
        SellAllAbleTosell()
        SeeIfBuyLuckyArrow()
        task.wait(60)
    end
end

