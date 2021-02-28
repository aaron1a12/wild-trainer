--x: ,   200.79
bIsDynamic = false
netItem = nil
itemObj = nil
bIsPickingUp = false
bIsCarrying = false
bIsClose = false

bItemIsResetting = false

itemEnterExitDelay = 0
itemEnterExitDelayMax = 600


iDistance = 0

AddEventHandler("wild-trainer:cl_spawnCarryItems", function( bResetProcedure )
	if bResetProcedure == true then
		Wait(2000)
	end

	local itemModel = "prop_ld_case_01"
	RequestModel(GetHashKey(itemModel))
	while not HasModelLoaded(GetHashKey(itemModel)) do
		Citizen.Wait(100)
	end
	
	print("Spawning carry items!")
	local obj = CreateObject(GetHashKey(itemModel), -812.86, 177.55, 71.15, 1, 1, bIsDynamic)
	
	-- Network Sync
	NetworkRegisterEntityAsNetworked(obj)
	NetworkRequestControlOfEntity(obj)
	while not NetworkHasControlOfEntity(obj) do Wait(0) end	
	netItem = ObjToNet(obj)
	
	
	SetNetworkIdExistsOnAllMachines(netItem, true)
	NetworkSetNetworkIdDynamic(netItem, false)
	SetNetworkIdCanMigrate(netItem, true)
	
	SetEntityAsMissionEntity(netItem, true, true)
	
	bItemIsResetting = false
	TriggerServerEvent('wild-trainer:sv_setItemId', netItem)
end)
RegisterNetEvent("wild-trainer:cl_spawnCarryItems")


AddEventHandler("wild-trainer:cl_loadItem", function(briefCaseID)
	print("Loading item information from network...")
	Wait(1000)
	
	netItem = briefCaseID
	
	itemObj = NetToObj(netItem)
	
	
	if bItemIsResetting == false then
		Citizen.CreateThread(function()
			while true do	

				
				Wait(1000)
				
				


				if netItem ~= nil then
					
					local playerPed = GetPlayerPed(-1)
					local coords = GetEntityCoords(playerPed)
					local itemCoords = GetEntityCoords(itemObj)
					local currentDistance = GetDistanceBetweenCoords(coords, itemCoords.x, itemCoords.y, itemCoords.z, true)
					
					iDistance = currentDistance
					--print( iDistance )
					
					if(currentDistance < 2) then
						bIsClose = true
					else
						bIsClose = false
					end
				else
					print("netItem is nil")
				end
			end
		end)
	end

end)
RegisterNetEvent("wild-trainer:cl_loadItem")




AddEventHandler("wild-trainer:cl_deleteItem", function()
	bItemIsResetting = true
	
	DetachEntity(itemObj, 1, 1)
	DeleteObject(itemObj)

	netItem = nil
	itemObj = nil	
	
	bIsClose = false
	bIsCarrying = false
	bIsPickingUp = false	
end)
RegisterNetEvent("wild-trainer:cl_deleteItem")



AddEventHandler("wild-trainer:cl_pickUpItem", function(_pSource)
	if netItem ~= nil then
		bIsPickingUp = true
		local ped = GetPlayerPed(GetPlayerFromServerId(_pSource))
		AttachEntityToEntity(itemObj, ped, GetPedBoneIndex(ped, 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
		bIsCarrying = true
		bIsPickingUp = false
	end
end)
RegisterNetEvent("wild-trainer:cl_pickUpItem")

AddEventHandler("wild-trainer:cl_dropItem", function()
	if netItem ~= nil then
		DetachEntity(itemObj, 1, 1)
		bIsCarrying = false
		bIsPickingUp = false
	end
end)
RegisterNetEvent("wild-trainer:cl_dropItem")

AddEventHandler("wild-trainer:cl_setExplosionTimer", function()
	Citizen.Wait(5000)
	
	local itemCoords = GetEntityCoords(itemObj)
	AddExplosion(itemCoords.x, itemCoords.y, itemCoords.z, "EXPLOSION_STICKYBOMB", 10000, true, false, true)
end)
RegisterNetEvent("wild-trainer:cl_setExplosionTimer")




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if (bIsClose == true and bIsPickingUp == false) then
		
			if bIsCarrying == false then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to Pick Up")
			else
				DisplayHelpText("Press ~INPUT_DROP_WEAPON~ to Drop")
			end
		
		
			if IsControlPressed(0,51) then
				TriggerServerEvent('wild-trainer:sv_pickUpItem')
			end
			
			if IsControlPressed(0,56) then
				TriggerServerEvent('wild-trainer:sv_dropItem')
			end
			
			if IsControlPressed(0,105) then
				TaskStartScenarioInPlace( GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
				
				Citizen.Wait(3000)

				TriggerServerEvent('wild-trainer:sv_armItem')
				
				ClearPedTasks(GetPlayerPed(-1))	
				
				if netItem ~= nil then
					DetachEntity(itemObj, 1, 1)
					bIsCarrying = false
					bIsPickingUp = false
				end
			end
		end
	end
end)


bIsTrackerOn = false
trackerNetId = nil


function openTracker()
	local playerPed = GetPlayerPed(-1)
	
	
	RequestAnimDict('cellphone@')
	while not HasAnimDictLoaded('cellphone@') do
		Citizen.Wait(0)
	end
	TaskPlayAnim(playerPed, 'cellphone@', 'cellphone_call_listen_base', 2.0, -1, -1, 50, 0, false, false, false)	
	
					
	local trackerModel = "prop_npc_phone_02"
	RequestModel(GetHashKey(trackerModel))
	while not HasModelLoaded(GetHashKey(trackerModel)) do
		Citizen.Wait(100)
	end	
	
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local trackerObj = CreateObject(GetHashKey(trackerModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)	
	
	NetworkRegisterEntityAsNetworked(trackerObj)
	trackerNetId = ObjToNet(trackerObj)
	SetNetworkIdExistsOnAllMachines(trackerNetId, true)
	NetworkSetNetworkIdDynamic(trackerNetId, true)
	SetNetworkIdCanMigrate(trackerNetId, false)	
	
	AttachEntityToEntity(trackerObj, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
	--AttachEntityToEntity(object, playerPed, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
end

function closeTracker()
		DetachEntity(NetToObj(trackerNetId), 1, 1)
		DeleteEntity(NetToObj(trackerNetId))
		trackerNetId = nil		
		
		local playerPed = GetPlayerPed(-1)
		
		RequestAnimDict('cellphone@')
		while not HasAnimDictLoaded('cellphone@') do
			Citizen.Wait(0)
		end
		TaskPlayAnim(playerPed, 'cellphone@', 'cellphone_call_out', 2.0, -1, -1, 50, 0, false, false, false)		
		
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())		
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsControlPressed(0,171) then
			if bIsTrackerOn == false then
				openTracker()
			end
			
			bIsTrackerOn = true
		else
			if bIsTrackerOn == true then
				closeTracker()
			end
			bIsTrackerOn = false
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if bIsTrackerOn == true then
			--local beepTime = 100 + math.ceil(iDistance * math.log(iDistance+1))
			local beepTime = iDistance + 1 * 100
			--local beepTimeAlt = iDistance + 1 * 250
			
			--if beepTime < 5000 then
				Citizen.Wait( beepTime )
				
				if bIsTrackerOn == true then
					PlaySoundFrontend(-1, 'MP_5_SECOND_TIMER', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
				end
				
			--elseif beepTimeAlt < 5000 then
			--	Citizen.Wait( beepTimeAlt )
				
			--	if bIsTrackerOn == true then
			--		PlaySoundFrontend(-1, 'MP_5_SECOND_TIMER', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
			--	end
			--end
		end
	end
end)





Citizen.CreateThread(function()
    -- drop item on death
    while true do
		Citizen.Wait(250)		
		
		local playerPed = GetPlayerPed(-1)

		if IsEntityDead(playerPed) then
			if netItem ~= nil then
				DetachEntity(itemObj, 1, 1)
				bIsCarrying = false
				bIsPickingUp = false
			end
		end	
        
    end
end)

