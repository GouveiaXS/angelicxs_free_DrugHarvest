ESX = nil
QBcore = nil
PlayerJob = nil
PlayerData = nil
local GatherBusy = false

CreateThread(function()
    if Config.UseESX then
        ESX = exports["es_extended"]:getSharedObject()
        while not ESX.IsPlayerLoaded() do
            Wait(100)
        end
        CreateThread(function()
            while true do
                PlayerData = ESX.GetPlayerData()
                if PlayerData ~= nil then
                    break
                end
                Wait(100)
            end
        end)
    elseif Config.UseQBCore then
        QBCore = exports['qb-core']:GetCoreObject()
        CreateThread(function ()
			while true do
                PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.citizenid ~= nil then
					break
				end
				Wait(100)
			end
		end)
    end
end)

RegisterNetEvent('angelicxs-drugHarvest:Notify', function(message, type)
	if Config.UseCustomNotify then
        TriggerEvent('angelicxs-drugHarvest:CustomNotify',message, type)
	elseif Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBCore then
		QBCore.Functions.Notify(message, type)
	end
end)

CreateThread(function()
    for harvestName, harvestInfo in pairs(Config.HarvestList) do
        for index, data in pairs (harvestInfo) do
            if index == 'pickLocations' then
                for i = 1, #data, 1 do
                    CreateThread(function()
                        while true do
                            local Player = PlayerPedId()
                            local Pos = GetEntityCoords(PlayerPedId())
                            local Sleep = 2000
                            local Dist = #(Pos - data[i])
                            if Dist <= 50 then
                                Sleep = 1000
                                if Dist <= 10 then
                                    Sleep = 500
                                    if Dist <= 5 then
                                        Sleep = 0
                                        if Config.Show3DMarker then
                                            Draw3DMarker(data[i][1],data[i][2],data[i][3])
                                        end
                                        if Dist <= 3 then
                                            if IsControlJustReleased(0, 38) and not GatherBusy then
						GatherBusy = true
						HarvestItem(harvestInfo)                                       
                                            end
                                            if Config.Show3DText then
                                                DrawText3Ds(data[i][1],data[i][2],data[i][3], Config.Lang['harvest'])
                                            end
                                        end
                                    end
                                end
                            end
			    Wait(Sleep)
                        end
                    end)
                end 
            end
        end
    end
end)

function HarvestItem(harvestInfo)
    local Player = PlayerPedId()
    FreezeEntityPosition(Player, true)
    Animation(harvestInfo.dictionary, harvestInfo.animation)
    Wait(harvestInfo.gatherTime*1000)
    GatherBusy = false
    FreezeEntityPosition(Player, false)
    ClearPedTasks(Player)
    TriggerServerEvent('angelicxs-drugHarvest:Server:ReceiveItem', harvestInfo, PlayerJob)
end

function Animation(dict, anim)
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    TaskPlayAnim(ped,dict,anim, 8.0, 8.0, -1, 1, 0, 0, 0, 0)
end

function Draw3DMarker(x,y,z)
    DrawMarker(Config.MarkerIcon, x, y, (z+2), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 200, false, true, 2, nil, nil, false)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
