policeStations = {
	{ ['x'] = 638.16,  ['y'] = 1.76,  ['z'] = 82.79 },
	{ ['x'] = 440.32,  ['y'] = -981.07,  ['z'] = 30.69 },
	{ ['x'] = 360.94,  ['y'] = -1584.63,  ['z'] = 29.29 },
	{ ['x'] = 827.35,  ['y'] = -1290.11,  ['z'] = 28.24 },
	{ ['x'] = -1107.68,  ['y'] = -844.66,  ['z'] = 19.32 },
	{ ['x'] = 1853.43,  ['y'] = 3687.89,  ['z'] = 34.27 },
	{ ['x'] = -447.26,  ['y'] = 6013.19,  ['z'] = 31.72 },	  
}

		

function AddPoliceStationBlips()
	Citizen.CreateThread(function()
		for _, station in pairs(policeStations) do
		  station.blip = AddBlipForCoord(station.x, station.y, station.z)
		  SetBlipSprite(station.blip, 60)
		  SetBlipDisplay(station.blip, 4)
		  SetBlipScale(station.blip, 0.9)
		  SetBlipColour(station.blip, 3)
		  SetBlipAsShortRange(station.blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Police Station")
		  EndTextCommandSetBlipName(station.blip)
		end
	end)
end
AddPoliceStationBlips()


local bIsCloseToStation = false

Citizen.CreateThread(function()
	while true do Wait(1000)
		local playerPos = GetEntityCoords(GetPlayerPed(-1))
			
		for _, station in pairs(policeStations) do
			local dist = tonumber(GetDistanceBetweenCoords(playerPos, station.x, station.y, station.z, false))
			
			
			
			if dist < 4 then
				bIsCloseToStation = true
				break
			else
				bIsCloseToStation = false
			end
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do Wait(10)
			
		if bIsCloseToStation then
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			
			--ShowNotification(ESX.PlayerData.job.name)
		

			
			if ESX.PlayerData.job.name ~= "police" then
				DisplayHelpText("Press ~INPUT_CONTEXT~ To Join The Police Force")		
				
				if lastGtaWantedLevel < 2 then
					if IsControlJustPressed (0, 51) then Citizen.Wait(2000)
						ESX.PlayerData.job.name = "police"
						TriggerServerEvent("wild-trainer:setJob", "police", 0)
						
						SetupPlayerCop()
					end
				else
					SetPlayerWantedLevel(PlayerId(), lastGtaWantedLevel, false)
					SetPlayerWantedLevelNow(PlayerId(), true)
				end
			elseif ESX.PlayerData.job.name == "police" then
				DisplayHelpText("Press ~INPUT_CONTEXT~ To Leave The Police Force")
				
				if IsControlJustPressed (0, 51) then Citizen.Wait(2000)
					ESX.PlayerData.job.name = "unemployed"
					TriggerServerEvent("wild-trainer:setJob", "unemployed", 0)
					SetupPlayerCop(true)
				end
			end
			
		end
		
	end
end)

AddEventHandler('cl_playerSpawned', function(spawn)
	Citizen.Wait(5000)
	
    SetupPlayerCop()
end)

local bWasPlayerCop = false

function SetupPlayerCop(bLeaving)
	if bLeaving == nil then bLeaving = false end
	
	while ESX.PlayerData.job == nil do Citizen.Wait(100) end
	
	if ESX.PlayerData.job.name == "police" then
		ShowNotification("Welcome to the LSPD!")
		SetPedAsCop(PlayerPedId(), true)
		
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), 99, false, true)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK"), 99, false, true)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"), 99, false, true)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 99, false, true)
		
		SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("COP"))
		
		TriggerServerEvent("wild-trainer:updateCopStatus", false)
		
	elseif bLeaving then
		ShowNotification("Enjoy life as a civilian.")
		
		
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_APPISTOL"))
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_NIGHTSTICK"))
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"))
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"))
		--Reset player skin due to SetPedAsCop()
		LoadPlayerSkin(false)
		
		TriggerServerEvent("wild-trainer:updateCopStatus", true)
	end
	
	
end

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(0)	
		
		if IsCop(PlayerPedId()) then
			if GetPlayerWantedLevel(PlayerId()) > 0 then
				SetPlayerWantedLevel(PlayerId(), 0, false)
				SetPlayerWantedLevelNow(PlayerId(), true)
				lastGtaWantedLevel = 0
			end
		end
	end
end)



AddEventHandler("wild-trainer:cl_refreshCopBlips", function()
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		
		
		if IsCop(ped) then
			local pedBlip = AddBlipForEntity(ped)
			SetBlipColour(pedBlip, 38)
			SetBlipSprite(pedBlip, 3)
			SetBlipScale(pedBlip, 0.7)
			SetBlipAsShortRange(pedBlip, true)
		end
	end
end)
RegisterNetEvent("wild-trainer:cl_refreshCopBlips")


-- COP MISSIONS

function ShowMissionEndText(label)
	local timeShown = 0
	local alpha = 255
	local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
		
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(1)	
	end		

	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	BeginTextComponent("STRING")
	AddTextComponentString(label)
	EndTextComponent()
	PopScaleformMovieFunctionVoid()


	PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)	
	PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
	
	Citizen.CreateThread(function()
		while true do Citizen.Wait(0)
		  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, alpha)
		  
		  alpha = alpha - 1
		  timeShown = timeShown + 1
		  
		  
		  if timeShown > 200 then break end
		end
	end)
end

ShooterBlip = nil

function SpawnMassShooter()
	local dogModel = "a_m_y_methhead_01"
	local nodePos = nil
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	
	empty, dog_group = AddRelationshipGroup("evil_dog")
	SetRelationshipBetweenGroups(5, dog_group, GetHashKey("CIVMALE"))
	SetRelationshipBetweenGroups(5, dog_group, GetHashKey("CIVFEMALE"))
	SetRelationshipBetweenGroups(5, dog_group, GetHashKey("PLAYER"))	
	
	--local found, outPos, outHeading = GetClosestVehicleNodeWithHeading(playerCoords.x, playerCoords.y, playerCoords.z, 1, 3.0, 0)
	
	local found, outPos = FindSpawnPointInDirection(playerCoords.x, playerCoords.y, playerCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, 200.0)
	
	RequestModel( GetHashKey( dogModel ) )
	while ( not HasModelLoaded( GetHashKey( dogModel ) ) ) do
		Citizen.Wait( 1 )
	end			
	
	local criminalPed = CreatePed(26, dogModel, outPos.x, outPos.y, outPos.z, 0, true, true) -- 26 = PED_TYPE_MISSION
	SetEntityAsMissionEntity(criminalPed, true, true)	
	
	--SetBlockingOfNonTemporaryEvents(dogModel, true)
	
	--
	
	print("Spawn? ".. outPos.x)
	SetPedRandomComponentVariation(criminalPed, false)
	
	--SetPedAsEnemy(criminalPed, true)
	SetPedRelationshipGroupHash(criminalPed, dog_group)	
	
	--TaskWanderStandard(criminalPed, 10.0, 10)	
	--SetPedConfigFlag(criminalPed, PED_FLAG_MELEE_COMBAT, true)
	--SetPedConfigFlag(criminalPed, PED_FLAG_DRUNK, true)
	
    --SetPedFleeAttributes(criminalPed, 512, true)
	--TaskSetBlockingOfNonTemporaryEvents(criminalPed, true)
	--SetPedEnableWeaponBlocking(dogModel, false)
	
    --SetPedCombatAttributes(criminalPed, 16, true)
    --SetPedCombatAttributes(criminalPed, 46, true)	
	
	--TaskCombatHatedTargetsAroundPed(criminalPed, 999.9, 0)
	
	--SetPedCombatMovement(criminalPed, 3)
	
	
	SetPedCombatAbility(criminalPed, 2)
	
	
	
	GiveWeaponToPed(criminalPed, GetHashKey("WEAPON_CARBINERIFLE"), 999999999, false, true)
	
	
	SetPedCombatAttributes(criminalPed, 0, false)	
	SetPedAccuracy(criminalPed, 50)
	SetPedShootRate(criminalPed, 1000)
	SetPedCombatAttributes(criminalPed, 1, false)	
	SetPedCombatAttributes(criminalPed, 3, true)	
	SetPedCombatRange(criminalPed, 0)
	SetPedCombatMovement(criminalPed, 2)
	SetCombatFloat(criminalPed, 5, 1.0)
	SetCombatFloat(criminalPed, 8, 0.0)
	TaskCombatHatedTargetsAroundPed(criminalPed, 999.9, 0)
	SetBlockingOfNonTemporaryEvents(criminalPed, true)
	
	TriggerServerEvent('wild-trainer:call911', outPos.x, outPos.y, outPos.z, REPORT.DANGEROUS)
	
	
	
	Citizen.CreateThread(function()
		-- main loop thing
		while true do
			Citizen.Wait(5000)
			
			if IsPedDeadOrDying(criminalPed, 1) or IsEntityDead(criminalPed) then
				ShowMissionEndText("~r~Threat neutralized")
				PlaySound(-1, "FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS", 0, 0, 1)
				SetEntityAsNoLongerNeeded(criminalPed)
				
				-- CRASH?
				RemoveBlip(ShooterBlip)
				
				TriggerServerEvent('wild-trainer:crimeInProgress', false)
				
				break
			else
				TaskCombatHatedTargetsAroundPed(criminalPed, 100.0, 0)
					
				local crimeCoords = GetEntityCoords(criminalPed)
				
				local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), crimeCoords.x, crimeCoords.y, crimeCoords.z, false)
				
				if dist < 100 then
				
					if not DoesBlipExist(ShooterBlip) then
						ShooterBlip = AddBlipForEntity(criminalPed)
						SetBlipAlpha(ShooterBlip, 64)
						SetBlipSprite(ShooterBlip, 9)
						SetBlipColour(ShooterBlip, 59)
						SetBlipAsShortRange(ShooterBlip, true)
						SetBlipScale(ShooterBlip, 1.5)
					end
					
					CreateIncidentWithEntity(7, GetPlayerPed(-1), 50, 120.0, 1)
				end
				
				
				
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 50, 20.0, 0)
				--CreateIncident(5, crimeCoords.x, crimeCoords.y, crimeCoords.z, 50, 20.0, 0)
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 50, 220.0, 1)
				
				--CreateIncidentWithEntity(7, GetPlayerPed(-1), 50, 120.0, 1)
				
				
				--CreateIncident(7, crimeCoords, 3, 0.0, 0, 0, 0)
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 2, 2.0, 0)
				
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 2, 3.0, 0);
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 2, 3.0);
				--CreateIncident(7, crimeCoords.x, crimeCoords.y, crimeCoords.z, 3, 0.0);
				
				--print(crimeCoords.x .." ".. crimeCoords.y .." ".. crimeCoords.z)
				--CreateIncidentWithEntity(7, criminalPed, 2, 3.0)
				
				print("Call cops")
			end
		end
	end)
end

AddEventHandler("wild-trainer:cl_createCrime", function()
	SpawnMassShooter()
end)
RegisterNetEvent("wild-trainer:cl_createCrime")


Citizen.CreateThread(function()
   while true do
      Wait(0)
     if IsControlJustPressed (1, 10) then
	 
		
		--SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("AMBIENT_GANG_BALLAS")
		
		--DisablePostNukeWorld()
		--StopBlackOut()
		end
		
		if IsControlJustPressed (1, 11) then
			--PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
			--PlaySoundFromEntity(-1, "VEHICLES_HORNS_POLICE_WARNING", GetPlayerPed(-1), 0, 0, 0)
			--PlaySound(-1, "Radio_On", "TAXI_SOUNDS", 0, 0, 1)
			SendNUIMessage({type = 'playScanner'})
		end		
	end
end)