-- Some rounding func
function round(num) 
	if num >= 0 then return math.floor(num+.5) 
	else return math.ceil(num-.5) end
end
-- end

local isNukeMissionRunning = false
local isRadioPaused = false
local isNukeExploding = false

local dogModel = "a_c_rottweiler"

RegisterNUICallback('lua_startNukeMission', function()
	print("Phone says to start the mission.")
	TriggerServerEvent('sv_startNukeMission')
end)

RegisterNUICallback('lua_carRadio', function(data)
	isRadioPaused = data.pauseRadio
	print("Pause car radio? ->"..tostring(data.pauseRadio))
end)

RegisterNUICallback('lua_resumeRadio', function()
	isRadioPaused = false
end)

AddEventHandler("cl_startNukeMission", function()
	print("Nuke mission started!")
	
	if isNukeMissionRunning then
		return
	end
	
	isNukeMissionRunning = true
	isNukeExploding = false --temp
	lastGtaWantedLevel = 0
	
	local playerPed = GetPlayerPed(-1)
	-- Client Nuke mission start /////////////////////////////////
	
	Citizen.Wait(30000)
	
	--print("startEAS")
	SendNUIMessage({nukeMission = 'startEAS'})
	
	
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(60000 * 999) --after 20 mins
			isNukeMissionRunning = false
			isNukeExploding = false
			DisablePostNukeWorld()
			StopBlackOut()			
			if not isNukeMissionRunning then break end
		end
	end)
	
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(60000 * 6) --after 6 minutes
			isNukeExploding = true
			if not isNukeMissionRunning then break end
		end
	end)	
	
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			local playerPed = GetPlayerPed(-1)			
			local playerInsideCar = IsPedInAnyVehicle(playerPed)
			
			if isRadioPaused or bIsPostNuke then
				if playerInsideCar then
					print("Pause??")
					SetUserRadioControlEnabled(false)
					
					--FreezeRadioStation(GetPlayerRadioStationName())
					SetFrontendRadioActive(false)
					StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE");
				end
			else
				SetUserRadioControlEnabled(true)
				SetFrontendRadioActive(true)
				StopAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE");
				--break
			end
			
			local cameraRot = GetGameplayCamRot(0)
			
			SendNUIMessage({
				nukeMission = 'playerLocationStatus',
				--heading = GetEntityHeading(playerPed),
				camera = {x = cameraRot.x, y = cameraRot.y, z = cameraRot.z},
				isPlayerInVehicle = playerInsideCar,
				isPlayerIndoors = (GetInteriorFromEntity(playerPed) ~= 0 and true or false)
			})
			
			if not isNukeMissionRunning then break end
		end
	end)
	
	
	-- NPCs
	
	Citizen.CreateThread(function()
		while true do
			Wait(5000)	
			local playerPed = GetPlayerPed(-1)
			local coords = GetEntityCoords(playerPed)			
			CreateIncident(7, coords.x, coords.y, coords.z, 50, 20.0, 0)
			CreateIncident(7, coords.x, coords.y, coords.z, 50, 220.0, 1)
			CreateIncidentWithEntity(7, playerPed, 50, 120.0, 1)
			
			if not isNukeMissionRunning then break end
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Wait(2000)
			
			-- DON'T GET WANTED
			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), true)				
			
			-- SCARE ALL PEDS
			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					--local playerPed = GetPlayerPed(-1)
					SetPedAlertness(ped, 3)
					local playerPed = GetPlayerPed(-1)
					local playerCoords = GetEntityCoords(playerPed)
					local pedCoords = GetEntityCoords(ped)
					AddShockingEventAtPosition(86, playerCoords.x, playerCoords.y, playerCoords.z, 10.0)


					--if isNukeExploding then
					--	StartEntityFire(ped)
					--	--StartScriptFire(pedCoords.x, pedCoords.y, pedCoords.z, 25, 0)
						
					--	if IsEntityOnFire(ped) then
					--		print("Ped was set on fire!")
					--	end
					--end
				end
			end
			
			if not isNukeMissionRunning then break end
		end
	end)
	
	
	Citizen.Wait(60000 * 5)
		
	SetPlayerWantedLevel(PlayerId(), 0, false)
	SetPlayerWantedLevelNow(PlayerId(), true)	
	
	StartBlackOut()

	Citizen.Wait(60000 * 1)
	
	CreateFlash()
	
	Citizen.Wait(5000)

	CreateShockwave()
	
	EnablePostNukeWorld()
end)
RegisterNetEvent("cl_startNukeMission")


local flashIntensity = 0.0

function CreateFlash() 
	CreateLightningThunder()
	
	StartScreenEffect("SwitchShortTrevorIn", 15000, true)
	Citizen.Wait(0)
	
	flashIntensity = 200.0
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
			flashIntensity = flashIntensity / 1.1
			
			if flashIntensity < 1.0 then break end
		end
	end)
	
	Citizen.CreateThread(function()
		
		while true do
			Citizen.Wait(0)
			
			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			
			DrawLightWithRangeAndShadow(coords.x, coords.y, coords.z+100, 255, 255, 255, 1000.0, flashIntensity, 104.0)
			
			if flashIntensity < 1.0 then break end
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
				
					local bContinue = true
				
					if ped == playerPed then
						local isPlayerIndoors = (GetInteriorFromEntity(playerPed) ~= 0 and true or false)
						
						if isPlayerIndoors then
							bContinue = false
						end
					end
						
					
					if bContinue then
						StartEntityFire(ped)
					end
				end
			end
			
			Citizen.CreateThread(function()
				Citizen.Wait(3000)
				SetPlayerWantedLevel(PlayerId(), 0, false)
				SetPlayerWantedLevelNow(PlayerId(), true)
			end)
						
			
			if flashIntensity < 1.0 then break end
		end
	end)
	--StopScreenEffect("DrugsTrevorClownsFightIn")
	
	--StartScreenEffect("Rampage", 200, false)
	--Citizen.Wait(1000)
	--StopScreenEffect("Rampage")
	--StartScreenEffect("RampageOut", 2000, false)
end

function CreateShockwave() 
	ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.200)
	
	local playerPed = GetPlayerPed(-1)
	
	for obj in EnumerateObjects() do
		if DoesEntityExist(obj) then	
			ApplyForceToEntityCenterOfMass(obj, 1, 0.0, 100.0, 0.0, 0, 0, 1, 0)
		end
	end
	
	for veh in EnumerateVehicles() do
		--if DoesEntityExist(veh) then	
			--Citizen.Wait(100)
			ApplyForceToEntityCenterOfMass(veh, 1, 0.0, 100.0, 0.0, 0, 0, 1, 0)
			--ExplodeVehicle(veh, isAudible, isInvisible)
			NetworkExplodeVehicle(veh, true, false, false)
		--end
	end	
	
	for ped in EnumeratePeds() do
		if DoesEntityExist(ped) then	
			local bContinue = true
		
			if ped == playerPed then
				local isPlayerIndoors = (GetInteriorFromEntity(playerPed) ~= 0 and true or false)
				
				if isPlayerIndoors then
					bContinue = false
				end
			end
			
			if bContinue then
				SetPedToRagdoll(ped, 2000, 2000, 0, false, false, false)
				
				SetEntityHealth(ped, 0)
				--Citizen.Wait(100)
				ApplyForceToEntityCenterOfMass(ped, 1, 0.0, 100.0, 0.0, 0, 0, 1, 0)
				
			end
		end
	end			
end


local maxDogCount = 50
local maxCarCount = 5


function EnablePostNukeWorld()
	if bIsPostNuke then return end

	bIsPostNuke = true
	
	TriggerServerEvent('sv_enablePostNukeWorld')
	
	TriggerServerEvent('vSync:smog', true)

	--StopScreenEffect("ChopVision")
	
	Citizen.Wait(6000)
	
	--StopScreenEffect("HeistLocate")
	
	SendNUIMessage({nukeMission = 'setMusic', setMusic = true })
	

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
		
			StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
			
			SetWind(1000.0)
			
			if not bIsPostNuke then break end
		end
	end)
	
	-- Disable normal peds
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), true)
			
			if bIsPostNuke then
				SetPedDensityMultiplierThisFrame(0.0)
				SetVehicleDensityMultiplierThisFrame(0.0)
				SetParkedVehicleDensityMultiplierThisFrame(0.0)
			else
				SetPedDensityMultiplierThisFrame(1.0)
				SetVehicleDensityMultiplierThisFrame(1.0)				
				SetParkedVehicleDensityMultiplierThisFrame(1.0)
			end
			
			if not bIsPostNuke then break end
		end
	end)
	
	
	Citizen.CreateThread(function()
		for _,pedModel in ipairs(gtaAmbientMalePeds) do
			SetPedModelIsSuppressed(GetHashKey(pedModel[1]), 1)
		end
	end)
	
	Citizen.CreateThread(function()
		for _,pedModel in ipairs(gtaAmbientFemalePeds) do
			SetPedModelIsSuppressed(GetHashKey(pedModel[1]), 1)
		end
	end)	
	
	-- Spawn nasty dogs
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			
			local spawnedDogsCount = 0

			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					if GetPedType(ped) == 28 then
						spawnedDogsCount = spawnedDogsCount + 1
					end
				end
			end
			
			if spawnedDogsCount < maxDogCount then
				for i=1, maxDogCount-spawnedDogsCount, 1 do 
				   SpawnDog()
				end			
			end
			
			if not bIsPostNuke then break end
		end
	end)
	
	--Spawn broken cars
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			
			local spawnedCarsCount = 0

			for veh in EnumerateVehicles() do
				if DoesEntityExist(veh) then
					if GetEntityHealth(veh) == 0.0 then
						spawnedCarsCount = spawnedCarsCount + 1
					end
				end
			end
			
			if spawnedCarsCount < maxCarCount then
				for i=1, maxCarCount-spawnedCarsCount, 1 do 
				   --SpawnRandomCar()
				end			
			end
			
			if not bIsPostNuke then break end
		end
	end)		

end

function SpawnDog()
	local nodePos = nil
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	
	empty, dog_group = AddRelationshipGroup("nuke_dog")
	SetRelationshipBetweenGroups(5, dog_group, GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), dog_group)	
	
	--local found, outPos, outHeading = GetClosestVehicleNodeWithHeading(playerCoords.x, playerCoords.y, playerCoords.z, 1, 3.0, 0)
	
	local found, outPos = FindSpawnPointInDirection(playerCoords.x, playerCoords.y, playerCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, 100.0) --was 100.0
	
	RequestModel( GetHashKey( dogModel ) )
	while ( not HasModelLoaded( GetHashKey( dogModel ) ) ) do
		Citizen.Wait( 1 )
	end

	--Randomize pos a bit

	local posX = outPos.x + (math.random()*5)
	local posY = outPos.y + (math.random()*5)
	--outPos.x = outPos.x --+ (math.random()*5)
	--outPos.y = outPos.y --+ (math.random()*5)
	
	local dogPed = CreatePed(pedType, dogModel, posX, posY, outPos.z, (math.random() * 360), true, true)
	SetPedRandomComponentVariation(dogPed, false)
	
	SetPedAsEnemy(dogPed, true)
	SetPedRelationshipGroupHash(dogPed, dog_group)	
	
	TaskWanderStandard(dogPed, 10.0, 10)	
	SetEntityAsNoLongerNeeded(dogPed)

	-- 2021 changes

	local randomVar = round((GetNumberOfPedTextureVariations(dogPed, 4, GetPedDrawableVariation(dogPed, 4))-1)*math.random())

	SetPedComponentVariation(dogPed, 4, GetPedDrawableVariation(dogPed, 4), randomVar, GetPedPaletteVariation(dogPed, 4))
	SetPedComponentVariation(dogPed, 3, 1, 0, GetPedPaletteVariation(dogPed, 3))
	
end

Citizen.CreateThread(function()
    while true do
		Wait(1000)
		--SpawnDog()
	end
end)


function SpawnRandomCar()
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	--local found, outPos, outHeading = GetClosestVehicleNodeWithHeading(playerCoords.x, playerCoords.y, playerCoords.z, 1, 3.0, 0)
	
	--local found, outPos = FindSpawnPointInDirection(playerCoords.x, playerCoords.y, playerCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, 100.0)
	
	local heading, vector = GetNthClosestVehicleNode(playerCoords.x, playerCoords.y, playerCoords.z, 500, 0, 0, 0)
	
	--SetEntityHeading(entity, heading)
	
	-- Set random seed!
	math.randomseed(outPos.x)
	local randomHeading = math.random(360)
	
	local vehicle = GetHashKey("emperor2")
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)	
	end

	--local spawned_car = CreateVehicle(vehicle, outPos.x, outPos.y, outPos.z, randomHeading, true, false)
	--SetVehicleFuelLevel(spawned_car, 0)
	--SetEntityHeading(spawned_car, randomHeading)
	--SetEntityHealth(spawned_car, 0)
	--SetEntityAsNoLongerNeeded(spawned_car)
	
	--TaskVehicleDriveWander(ped, vehicle, speed, drivingStyle)
	
	--ShowNotification(randomHeading)
end

function DisablePostNukeWorld()
	if not bIsPostNuke then return end
	
	bIsPostNuke = false
	TriggerServerEvent('vSync:smog', false)
	
	SendNUIMessage({nukeMission = 'setMusic', setMusic = false })
end

function StartBlackOut()
	TriggerEvent("wild_blackout")
	TriggerServerEvent('vSync:blackOut', true)
	SendNUIMessage({nukeMission = 'setBlackout', blackOutStatus = true})
end

function StopBlackOut()
	TriggerServerEvent('vSync:blackOut', false)
	SendNUIMessage({nukeMission = 'setBlackout', blackOutStatus = false})
end

Citizen.CreateThread(function()
   while true do
      Wait(0)
     if IsControlJustPressed (1, 10) then
	 
		
		--SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("AMBIENT_GANG_BALLAS")
		
		--DisablePostNukeWorld()
		--StopBlackOut()
		end
		
 if IsControlJustPressed (1, 11) then
		--StartBlackOut()
		--EnablePostNukeWorld()
		end		
	end
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent('sv_getNukeWorldStatus')	
end)
AddEventHandler("cl_receiveNukeWorldStatus", function(currentStatus)
	if currentStatus == true then
		StartBlackOut()
		EnablePostNukeWorld()
	end
end)
RegisterNetEvent("cl_receiveNukeWorldStatus")



local devBlip = nil
local survivor = nil
local survivorPartner = nil
local survivorCar = nil
local maskObj = nil
local maskObjPartner = nil

local survivorPeds = {
	"g_m_y_lost_01",
	"g_m_y_lost_02",
	"g_m_y_lost_03",
}

local survivorCars = {
	"bfinjection",
	"bodhi2",
	"BRUISER",
	"boxville5",
	"CERBERUS",
	"dloader",
	"dune",
	"dune3",
	"dune4",
	"dune5",
	"halftrack",
	"issi3",
	"barrage",
	"journey",
	"emperor3",
	"wastelander",
	"pbus2",
	"ratloader",
	"rebel",
	"surfer2",
	"technical",
	"technical2",
	"technical3",
	"tornado3",
	"tornado4",
	"tornado6",
	"voodoo2",
}


AddEventHandler("cl_spawnSurvivor", function()
	if math.random(100) < 50 then return end

	print("spawnSurvivor")
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))

	local heading, outPos = GetNthClosestVehicleNode(playerCoords.x, playerCoords.y, playerCoords.z, 200, 0, 0, 0)
	
	-- Set random seed!
	--math.randomseed(outPos.x)
	--local randomHeading = math.random(360)
	
	-- THE CAR
	
	local vehicleModel = GetHashKey( survivorCars[ math.random( #survivorCars ) ])
	RequestModel(vehicleModel)
	while not HasModelLoaded(vehicleModel) do
		Wait(1)	
	end

	survivorCar = CreateVehicle(vehicleModel, outPos.x, outPos.y, outPos.z, 90.0, true, false)
	SetEntityAsMissionEntity(survivorCar, true, true)
	SetModelAsNoLongerNeeded( vehicleModel )
	
	-- THE DRIVERS
	
	local survivorModel = survivorPeds[ math.random( #survivorPeds ) ]
	RequestModel( GetHashKey( survivorModel ) )
	while ( not HasModelLoaded( GetHashKey( survivorModel ) ) ) do
		Citizen.Wait( 1 )
	end
	
	local survivorPartnerModel = survivorPeds[ math.random( #survivorPeds ) ]
	RequestModel( GetHashKey( survivorPartnerModel ) )
	while ( not HasModelLoaded( GetHashKey( survivorPartnerModel ) ) ) do
		Citizen.Wait( 1 )
	end			
	
	survivor = CreatePedInsideVehicle(survivorCar, 4, survivorModel, -1, true, true)
	survivorPartner = CreatePedInsideVehicle(survivorCar, 4, survivorPartnerModel, 0, true, true)
	
	SetPedIntoVehicle(survivorPartner, survivorCar, 0)
	
	SetEntityAsMissionEntity(survivor, true, true)
	SetEntityAsMissionEntity(survivorPartner, true, true)
	SetModelAsNoLongerNeeded( survivorModel )
	SetModelAsNoLongerNeeded( survivorPartnerModel )
	
	-- MORE DRIVER STUFF
	
	empty, survivor_group = AddRelationshipGroup("nuke_survivor")
	SetRelationshipBetweenGroups(5, survivor_group, GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), survivor_group)
	
	SetPedRelationshipGroupHash(survivor, survivor_group)	
	SetPedRelationshipGroupHash(survivorPartner, survivor_group)	
	SetPedAsEnemy(survivor, true)
	SetPedAsEnemy(survivorPartner, true)
	
	GiveWeaponToPed(survivor, GetHashKey("WEAPON_PISTOL"), 999999999, false, true)
	GiveWeaponToPed(survivorPartner, GetHashKey("WEAPON_PISTOL"), 999999999, false, true)
	
	SetPedShootRate(survivor, 500)
	SetPedAccuracy(survivor, 10)	
	
	-- GAS MASKS

	local maskModel = "prop_player_gasmask"
	RequestModel(GetHashKey(maskModel))
	while not HasModelLoaded(GetHashKey(maskModel)) do
		Citizen.Wait(1)
	end
	
	local pedCoords = GetOffsetFromEntityInWorldCoords(survivor, 0.0, 0.0, -5.0)
	--maskObj = CreateObject(GetHashKey(maskModel), pedCoords.x, pedCoords.y, pedCoords.z, 1, 1, 1)
	SetEntityAsMissionEntity(maskObj, true, true)
	AttachEntityToEntity(maskObj, survivor, GetPedBoneIndex(survivor, 31086), 0, 0.0, 0.0, 90.0, -90.0, 90.0, 1, 1, 0, 1, 0, 1)	
	
	--maskObjPartner = CreateObject(GetHashKey(maskModel), pedCoords.x, pedCoords.y, pedCoords.z, 1, 1, 1)
	SetEntityAsMissionEntity(maskObjPartner, true, true)
	AttachEntityToEntity(maskObjPartner, survivorPartner, GetPedBoneIndex(survivorPartner, 31086), 0, 0.0, 0.0, 90.0, -90.0, 90.0, 1, 1, 0, 1, 0, 1)	

	--SetEntityCollision(maskObj, false, false)
	--SetEntityCollision(maskObjPartner, false, false)
	
	SetModelAsNoLongerNeeded( maskModel )
	--Citizen.Wait(5000)		
	--DetachEntity(maskObj, 1, 1)
	--DeleteEntity(maskObj)	
	--Citizen.Wait(5000)	
	--test	
	
	--devBlip = AddBlipForEntity(survivor)
	
	-- DRIVE AROUND
	
	TaskVehicleDriveWander(survivor, survivorCar, 26.0, 2883621)
	
	-- DELETE AFTER WHILE
	
	Citizen.CreateThread(function()
		Citizen.Wait(30000)
		
		SetEntityAsNoLongerNeeded(survivorCar)
		SetEntityAsNoLongerNeeded(survivor)
		SetEntityAsNoLongerNeeded(survivorPartner)
		SetEntityAsNoLongerNeeded(maskObj)
		SetEntityAsNoLongerNeeded(maskObjPartner)
		--RemoveBlip(devBlip)
	end)
end)
RegisterNetEvent("cl_spawnSurvivor")