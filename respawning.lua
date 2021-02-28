-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
end)



bHasPlayerEverDied = false
bSpawnLock = false	

local HospitalLocations = {
	{ {-449.63, -346.05, 34.5, 100.0}, {-456.63, -338.18, 34.36, 258.0} },
	{ {359.93, -584.82, 28.82, 247.36}, {365.78, -580.52, 28.69, 23.26} },
	{ {306.7, -1433.3, 29.9, 138.17}, {283.08, -1425.95, 33.0, 224.11} },
	{ {-247.32, 6331.7, 32.43, 232.2}, {-233.85, 6317.27, 31.49, 75.29} }, --twin peaks
	{ {-874.8, -309.03, 39.53, 345.29}, {-871.65, -293.55, 45.61, 33.02} },
	{ {-676.62, 311.6, 83.08, 179.02}, {-687.77, 300.9, 91.61, 327.16} },
	
	{ {1150.82, -1530.27, 35.39, 323.32}, {1154.06, -1529.52, 36.00, 114.36} },
	{ {1827.66, 3692.61, 34.22, 75.89}, {1828.00, 3702.34, 34.58, 170.88} }
}

function AddHospitalBlips()
	Citizen.CreateThread(function()
		for _, hospitalLoc in pairs(HospitalLocations) do
		  hospitalLoc.blip = AddBlipForCoord(hospitalLoc[1][1], hospitalLoc[1][2], hospitalLoc[1][3])
		  SetBlipSprite(hospitalLoc.blip, 61)
		  SetBlipDisplay(hospitalLoc.blip, 4)
		  SetBlipScale(hospitalLoc.blip, 0.9)
		  SetBlipColour(hospitalLoc.blip, 1)
		  SetBlipAsShortRange(hospitalLoc.blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Medical Center")
		  EndTextCommandSetBlipName(hospitalLoc.blip)
		end
	end)
end
AddHospitalBlips()

AddEventHandler('playerSpawned', function()
	bSpawnLock = false
		
	local playerPed = GetPlayerPed(-1)
	
	
	while ESX == nil do
		Citizen.Wait(0)
	end
	
	while ESX.PlayerData.lastPosition == nil do
		Citizen.Wait(0)
	end
	
	
	if ESX.PlayerData.lastPosition ~= nil then
	
		if bHasPlayerEverDied then

		else
			print("Teleport to saved location...")	
			SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z)
		end
		
		--DoScreenFadeIn(250)
	end	
	
	-- Enable pvp
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(playerPed, true, true)
end)







function respawnPed(ped)
	ResetPedMovementClipset( ped, 0) --Reset walkstyle. TODO: Load from cloth shop
	SetEnableHandcuffs(GetPlayerPed(-1), false)
	bSuspectInCustody = false
	SetPlayerControl(PlayerId(), true)

	--Find nearest hospital
	local deathCoords = GetEntityCoords(PlayerPedId())
	local nearestHospital = nil
	for _, hospital in pairs(HospitalLocations) do
		if nearestHospital == nil then
			nearestHospital = hospital
			
			print("Hospital distance: ".. GetDistanceBetweenCoords(deathCoords, nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][2], false))
		else
			local lastDist  = GetDistanceBetweenCoords(deathCoords, nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][2], false)			
			local currentDist  = GetDistanceBetweenCoords(deathCoords, hospital[1][1], hospital[1][2], hospital[1][2], false)
			
			--print("Last dist: ".. tostring(lastDist))
			--print("Current dist: ".. tostring(currentDist))
			
			if currentDist < lastDist then
				nearestHospital = hospital
			end
			
			print("Hospital distance: ".. GetDistanceBetweenCoords(deathCoords, nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][2], false))
		end
	end
	
	
	--local finalDist  = GetDistanceBetweenCoords(deathCoords, nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][2], false)	
	--print("Final dist: ".. tostring(finalDist))
	
	RemoveAllPedWeapons(ped)
	
	DoScreenFadeOut(2000)

	while IsScreenFadingOut() do
		Citizen.Wait(0)
	end

	--///
	
	print("Player died! Respawn at nearest hospital.")	
	local hospital = 1 
			
	--SetEntityCoords(playerPed, HospitalLocations[1][1], HospitalLocations[1][2], HospitalLocations[1][3])
	
	
	spawnCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	SetCamActive(spawnCam, true)
	
	local playerOffset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
	SetCamCoord(spawnCam, nearestHospital[2][1], nearestHospital[2][2], nearestHospital[2][3]+2)
	RenderScriptCams(true, false, 0, true, true)
	local heading = GetEntityHeading(ped)
	SetCamRot(spawnCam, -10.0, 0.0, nearestHospital[2][4], true)
	
	Citizen.CreateThread(function()
		Citizen.Wait(2000)	
		SetCamActive(spawnCam, false)
		RenderScriptCams(false, 1, 4000, 300, 300)
		
		Citizen.CreateThread(function() Citizen.Wait(3000) SetPlayerControl(PlayerId(), true) end)
		Citizen.CreateThread(function() Citizen.Wait(4000) DestroyCam(spawnCam,false) end)
	end)
	
	
	TriggerEvent("cl_playerSpawned")
	
	SetEntityCoordsNoOffset(ped, nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][3], false, false, false, true)
	NetworkResurrectLocalPlayer(nearestHospital[1][1], nearestHospital[1][2], nearestHospital[1][3], nearestHospital[1][4], true, false) 
	SetPlayerControl(PlayerId(), false)

	SetPlayerInvincible(ped, false) 
	ClearPedBloodDamage(ped)
	
	bSpawnLock = false	
	--///

	ShutdownLoadingScreen()

	DoScreenFadeIn(2000)

	while IsScreenFadingIn() do
		Citizen.Wait(0)
	end
	
	--///
	if not bIsPostNuke then
		local bill = 0
		
		if ESX.PlayerData.job.name == "unemployed" then
			bill = 4000
			
			SendNUIMessage({
				notificationTitle = 'Los Santos United Healthcare',
				notificationText = 'Your hospital bill has totaled $'..comma_value(bill)..'.',
				notificationIcon = 'icon-notify-generic.png',
			})	

			TriggerServerEvent('wild-trainer:hospitalBill', bill)
		else
			bill = 0
			
			SendNUIMessage({
				notificationTitle = 'Los Santos United Healthcare',
				notificationText = 'Your employer has covered your hospital bills.',
				notificationIcon = 'icon-notify-generic.png',
			})		

			SetupPlayerCop()
		end

	end
end



Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(250)		
		
		
		if not bSpawnLock then
		
			local playerPed = GetPlayerPed(-1)

			if IsEntityDead(playerPed) then
				bHasPlayerEverDied = true
				bSpawnLock = true
				
				print("DIED!!!???")
				
				
				--SetCustomRespawnPosition(HospitalLocations[1][1], HospitalLocations[1][2], HospitalLocations[1][3], 90.0)
				
				--DoScreenFadeIn(250)
				
				Citizen.Wait(3000)
				
				respawnPed(playerPed)
				
				--DoScreenFadeOut(250)
			end	
		end
        
    end
end)