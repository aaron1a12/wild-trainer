local isNukeMissionRunning = false
local bIsPostNuke = false

AddEventHandler("sv_startNukeMission", function()
	print("Start the mission everywhere!")
	isNukeMissionRunning = true
	bIsPostNuke = false
	TriggerClientEvent("cl_startNukeMission", -1)
end)
RegisterServerEvent("sv_startNukeMission")


-- Make sure that players that join after will get a proper nuke world after the bomb.

AddEventHandler("sv_enablePostNukeWorld", function()
	bIsPostNuke = true
	
	TriggerClientEvent("cl_spawnSurvivor", -1)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(60000*1) --minutes
		
			
			TriggerClientEvent("cl_spawnSurvivor", -1)	

			if not bIsPostNuke then break end
		end
	end)	
end)
RegisterServerEvent("sv_enablePostNukeWorld")

AddEventHandler("sv_getNukeWorldStatus", function()
	TriggerClientEvent("cl_receiveNukeWorldStatus", source, bIsPostNuke)
end)
RegisterServerEvent("sv_getNukeWorldStatus")




-- Don't let people join while nuke is in progress

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    deferrals.defer()

	if isNukeMissionRunning and not bIsPostNuke then
		deferrals.done("An attack on San Andreas is in progress. Please join later.")
	else
		deferrals.done()
	end
end
AddEventHandler("playerConnecting", OnPlayerConnecting)