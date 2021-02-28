local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}
  
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
      
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
      
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
      
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
  
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
  
function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end
  
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
  
function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetAllPeds()
    local peds = {}
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) then
            table.insert(peds, ped)
        end
    end
    return peds
end

function GetAllVehicles()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end


-------------------------------


local illegalWeapons = {
	"WEAPON_KNIFE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_REVOLVER",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG_MK2",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
}
										
										
-------------------------------




lastGtaWantedLevel = 0
pedsWhoSpotted = {}

function IsPedBlacklisted(oPed)
	return pedsWhoSpotted[oPed] ~= nil
end

function BlacklistPed(oPed)
	pedsWhoSpotted[oPed] = true
end

function UnblacklistPed(oPed)
	pedsWhoSpotted[oPed] = nil
end

function CallCops(coords, target, report)
	TriggerServerEvent('wild-trainer:call911', coords.x, coords.y, coords.z, report)

	Citizen.CreateThread(function()

		Citizen.Wait(3000)
		CreateIncident(7, coords.x, coords.y, coords.z, 50, 20.0, 0)
		CreateIncident(5, coords.x, coords.y, coords.z, 50, 20.0, 0)
		CreateIncident(7, coords.x, coords.y, coords.z, 50, 220.0, 1)
		CreateIncidentWithEntity(7, target, 50, 120.0, 1)
	end)
end


function IsHommie(oPed)
	local Gangs = {
		{
			Group = "AMBIENT_GANG_BALLAS",
			Models = {
				"g_m_y_ballasout_01",
				"g_m_y_ballaorig_01",
				"csb_ballasog",
				"g_m_y_ballaeast_01",
				"a_m_y_soucent_02",
				"g_m_y_strpunk_01",
				"ig_ballasog",
				"g_f_y_ballas_01",
				"csb_grove_str_dlr"
			}
		},
		{
			Group = "AMBIENT_GANG_FAMILY",
			Models = {
				"g_f_y_families_01",
				"g_m_y_famfor_01",
				"g_m_y_famdnf_01",
				"g_m_y_famca_01",
				"mp_m_famdd_01",
				"csb_ramp_gang",
				"ig_ramp_gang"
			}
		}
	}
	
	
	local bIsHommie = false
	
	for a = 1, #Gangs do
        for b = 1, #Gangs[a].Models do
            if IsPedModel(oPed, GetHashKey(Gangs[a].Models[b])) then
                --return Gangs[a].Group
				bIsHommie = true
            end
        end
    end	

 	return bIsHommie
end

AddEventHandler("wild-trainer:cl_loadWanted", function(wantedLevel)
	lastGtaWantedLevel = wantedLevel
end)
RegisterNetEvent("wild-trainer:cl_loadWanted")

Citizen.CreateThread(function()
    while true do
        Wait(5000)
		
        --ShowNotification("Last wanted level: " .. lastGtaWantedLevel)
    end
end)

-- Server triggered event when anyone spawns
AddEventHandler("cl_playerSpawned", function(spawn)
	lastGtaWantedLevel = 0
	--TriggerServerEvent('wild-trainer:saveWanted', lastGtaWantedLevel) experimental?
end)

-- Check current wanted levels

Citizen.CreateThread(function()
    while true do
        Wait(2000)
		
		local gtaWantedLevel = GetPlayerWantedLevel(PlayerId())
		
		if gtaWantedLevel > lastGtaWantedLevel then
			lastGtaWantedLevel = gtaWantedLevel
			
			TriggerServerEvent('wild-trainer:saveWanted', lastGtaWantedLevel)
		end
		
		-- Player is still wanted by the law. Also, don't do this for 1 star.
		if lastGtaWantedLevel > 1 then
			--Exponential (power of 2.5) growth of chance of recognition. 90 = Max chance.
			local detectionChance = math.pow(lastGtaWantedLevel,2.5)/math.pow(5,2.5)*90
		
		
			local playerPed = GetPlayerPed(-1)	
			local playerCoords = GetEntityCoords(PlayerPedId())		
			
			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					local pedCoords = GetEntityCoords(ped)
					local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)
					
					--if distance < 100.0 then
						--ShowNotification("Spot?")
					--end
					
					--Check if Cop
					--if GetPedType(ped)==6 and distance < 100.0 and HasEntityClearLosToEntity(ped, playerPed, 17) then --less laggy method
					if IsCop(ped) and IsPedAPlayer(ped)==false and IsPedDeadOrDying(ped,1)==false and distance < 20.0 and HasEntityClearLosToEntityInFront(ped, playerPed) then 
						SetPlayerWantedLevel(PlayerId(), lastGtaWantedLevel, false)
						SetPlayerWantedLevelNow(PlayerId(), true)
					elseif IsCop(ped) and IsPedAPlayer(ped)==false and IsPedDeadOrDying(ped,1)==false and distance < 100.0 and HasEntityClearLosToEntityInFront(ped, playerPed) then 
						Citizen.CreateThread(function()
							Citizen.Wait(4000)
							
							if HasEntityClearLosToEntityInFront(ped, playerPed) then
								SetPlayerWantedLevel(PlayerId(), lastGtaWantedLevel, false)
								SetPlayerWantedLevelNow(PlayerId(), true)							
							end
						end)
					elseif IsCop(ped)==false and distance < 10.0 and IsPedAPlayer(ped)==false and IsPedDeadOrDying(ped,1)==false and GetPedType(ped)~=28 and IsHommie(ped)==false and IsPedBlacklisted(ped)==false then
						BlacklistPed(ped) -- So we avoid processing the same ped later
						
						local veh = 0
						local vehSpeed = 0
						
						if IsPedInVehicle(ped) then
							veh = GetVehiclePedIsIn(ped, false)
							vehSpeed = GetEntitySpeed(veh)* 2.236936
						end					
					
						--ShowNotification("Distance: "..distance)

						
						-- Track this ped
						
						Citizen.CreateThread(function()
							Citizen.Wait(3000)
							
							-- Check if still close after 3 seconds
							pedCoords = GetEntityCoords(ped)
							distance = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)
							
							local bContinue = false
							
							if distance < 20.0 then
								bContinue = true

								-- If in a car, check if the car is slow
								if veh ~=0 then
									bContinue = false
									if vehSpeed < 5 then
										local currentSpeed = GetEntitySpeed(veh)* 2.236936
										if currentSpeed < 5 and math.random(100) < 10 and lastGtaWantedLevel > 3 then --less than 10 percent chance this will activate
											bContinue = true --Car is still really slow, slow enough to recognize player
										end
									end
								end
							end
							
							--detectionChance is multiplied by 2  because we test our chance 2 times.
							if math.random(100) < detectionChance*2 and bContinue == true then
								SetPedPrimaryLookat(ped, playerPed)
								ClearPedTasks(ped)
								--TaskGoStraightToCoord(ped, pedCoords.x, pedCoords.y, pedCoords.z,  1.0,  -1,  0.0,  0.0)
								TaskChatToPed(ped, playerPed, 16, 0.0, 0.0, 0.0, 0.0, 0.0)
								--TaskStandStill(ped, time)
								--TaskTurnPedToFaceEntity(ped, entity, duration)
								TaskLookAtEntity(ped, playerPed, -1, 2048, 3)
								
								SetPedAlertness(ped, 3)
								
								Citizen.CreateThread(function()
									Citizen.Wait(5000)
									
									if math.random(100) < detectionChance*2 and IsPedDeadOrDying(ped,1)==false and HasEntityClearLosToEntityInFront(ped, playerPed) then
										PlayAmbientSpeech1(ped, "GENERIC_FRIGHTENED_MED", "SPEECH_PARAMS_FORCE")
										PlayAmbientSpeech1(ped, "GENERIC_FRIGHTENED_HIGH", "SPEECH_PARAMS_FORCE")
										PlayAmbientSpeech1(ped, "CALL_COPS_THREAT_RANDOM", "SPEECH_PARAMS_FORCE")
										PlayAmbientSpeech1(ped, "CALL_COPS_COMMIT_01", "SPEECH_PARAMS_FORCE")
										PlayAmbientSpeech1(ped, "CALL_COPS_THREAT_RANDOM", "SPEECH_PARAMS_FORCE")
										PlayAmbientSpeech1(ped, "CALL_COPS_THREAT_01", "SPEECH_PARAMS_FORCE")
										
										TaskTurnPedToFaceEntity( ped, playerPed, 1000)
										TaskStartScenarioInPlace( ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)
										
										--Wait to finish call animation
										Citizen.Wait(3000)
										
										--ShowNotification("Call the cops!")
										if not IsPedHurt(ped) then
											CallCops(  GetEntityCoords(PlayerPedId()), ped, REPORT.SIGHTING )
										end
																
										Citizen.CreateThread(function()
											Citizen.Wait(3000)
											TaskReactAndFleePed(ped, playerPed)
										end)
									else
										--Just walk away
										ClearPedTasks(ped)
										
										if veh ~=0 then
											TaskVehicleDriveWander(ped, veh, 100.0, 32)
										end
										
									end -- END FINAL CHANCE
							
								end)						
							end -- END CHANCE
					

						end)					

						break					
					end
					
				end
			end			
		end -- END [ if lastGtaWantedLevel > 0 ]	
		
    end
end)


--Cleanup
Citizen.CreateThread(function()
    while true do
        --Wait(60000) -- Every minute
		Wait(5000)
		for key,value in pairs(pedsWhoSpotted) do
			if DoesEntityExist(key) == false then
				--ShowNotification("Removed ped from blacklist")
				UnblacklistPed(key)
			end
		end
	end
end)











Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(1)	
		
		if not bIsPostNuke then
			SetRandomTrains(1)
			SetCreateRandomCops(1)
			SetCreateRandomCopsNotOnScenarios(1)
			SetCreateRandomCopsOnScenarios(1)
			SetGarbageTrucks(1)
			SetRandomBoats(1)
			
			EnableDispatchService(1,true)
			--
			EnableDispatchService(3,true)
			EnableDispatchService(4,true)
			EnableDispatchService(5,true)
			EnableDispatchService(6,true)
			EnableDispatchService(7,true)
			EnableDispatchService(8,true)
			EnableDispatchService(9,true)
			EnableDispatchService(10,true)
			EnableDispatchService(11,true)
			--
			EnableDispatchService(13,true)
			EnableDispatchService(14,true)
			EnableDispatchService(15,true)		
			
			if lastGtaWantedLevel < 5 then
				EnableDispatchService(2,false)
				EnableDispatchService(12,false)
			else
				EnableDispatchService(2,true)
				EnableDispatchService(12,true)
			end	
		else
			SetRandomTrains(0)
			SetCreateRandomCops(0)
			SetCreateRandomCopsNotOnScenarios(0)
			SetCreateRandomCopsOnScenarios(0)
			SetGarbageTrucks(0)
			SetRandomBoats(0)
			EnableDispatchService(1, false)
			EnableDispatchService(2, false)
			EnableDispatchService(3, false)
			EnableDispatchService(4, false)
			EnableDispatchService(5, false)
			EnableDispatchService(6, false)
			EnableDispatchService(7, false)
			EnableDispatchService(8, false)
			EnableDispatchService(9, false)
			EnableDispatchService(10, false)
			EnableDispatchService(11, false)
			EnableDispatchService(12, false)
			EnableDispatchService(13, false)
			EnableDispatchService(14, false)
			EnableDispatchService(15, false)
		end
    end
end)		

-- Driving against traffic is illegal. Also speeding.

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(1000)	
		
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		
			local playerCoords = GetEntityCoords(PlayerPedId())	
			
			-- In meters
			local range = 100
			local copsNear = IsCopPedInArea_3d(playerCoords.x-range, playerCoords.y-range, playerCoords.z-range, playerCoords.x+range, playerCoords.y+range, playerCoords.z+range)		
			
			if copsNear then
				local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed = GetEntitySpeed(veh)* 2.236936
			
				for ped in EnumeratePeds() do
					if DoesEntityExist(ped) then					
						local pedCoords = GetEntityCoords(ped)
						local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)

						if speed > 80 and not IsPedInAnyHeli(GetPlayerPed(-1)) and not IsPedInAnyPlane(GetPlayerPed(-1)) and IsCop(ped) and IsPedDeadOrDying(ped,1)==false and distance < range and HasEntityClearLosToEntity(ped, veh) then
							if GetPlayerWantedLevel(PlayerId()) == 0 and ESX.PlayerData.job.name ~= "police"  then
								TriggerServerEvent('wild-trainer:call911', playerCoords.x, playerCoords.y, playerCoords.z, REPORT.SPEEDING)
								SetPlayerWantedLevel(PlayerId(), 1, false)
								SetPlayerWantedLevelNow(PlayerId(), true)		
							end					
						end

						if GetTimeSincePlayerDroveAgainstTraffic(PlayerId()) == 0 then
							Citizen.Wait(2000)	
							if GetTimeSincePlayerDroveAgainstTraffic(PlayerId()) == 0 and IsCop(ped) and IsPedDeadOrDying(ped,1)==false and distance < range and HasEntityClearLosToEntity(ped, veh) then 
							
								if GetPlayerWantedLevel(PlayerId()) == 0  then
									TriggerServerEvent('wild-trainer:call911', playerCoords.x, playerCoords.y, playerCoords.z, REPORT.WRONGWAY)
									SetPlayerWantedLevel(PlayerId(), 1, false)
									SetPlayerWantedLevelNow(PlayerId(), true)		
								end
							end
						end						
					end
				end		
			end
		end
	end
end)	



-- Illegal weapon

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(1000)	
		
		local pos = GetEntityCoords(PlayerPedId())	
		local playerPed = GetPlayerPed(-1)	

		local bContinue = false
		
		if IsPedArmed(playerPed, 7) then
			for i,weaponName in pairs(illegalWeapons) do
				local wep = GetSelectedPedWeapon(playerPed)
				if wep == GetHashKey(weaponName) then
					bContinue = true
				end
			end
		end
		
		if bContinue then

			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					local playerCoords = GetEntityCoords(PlayerPedId())	
					local pedCoords = GetEntityCoords(ped)
					local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)
					
					--ShowNotification("Spot?")
					
					--if distance < 100.0 then
						--ShowNotification("Spot?")
					--end
					
					--Check if Cop
					--if GetPedType(ped)==6 and distance < 100.0 and HasEntityClearLosToEntity(ped, playerPed, 17)  -> laggy method HasEntityClearLosToEntityInFront  ,,,,   HasEntityClearLosToEntity(ped, playerPed) 
					if IsCop(ped) and IsPedDeadOrDying(ped,1)==false and distance < 20.0 and HasEntityClearLosToEntityInFront(ped, playerPed) and ESX.PlayerData.job.name ~= "police" then
						if GetPlayerWantedLevel(PlayerId()) < 1  then
							SetPlayerWantedLevel(PlayerId(), 1, false)
							SetPlayerWantedLevelNow(PlayerId(), true)	
							CallCops(  GetEntityCoords(PlayerPedId()), ped, REPORT.DANGEROUS )
						end					
					elseif IsPedAPlayer(ped)==false and GetPedType(ped)~=28 and IsPedDeadOrDying(ped,1)==false and IsPedInAnyVehicle(ped,false)==false and distance < 5.0 and HasEntityClearLosToEntity(ped, playerPed) and GetPedAlertness(ped) ~= 3 and math.random(100) < 10 then 
					
						if ESX.PlayerData.job.name ~= "police" then
							TaskTurnPedToFaceEntity( ped, playerPed, 1000)
							TaskStartScenarioInPlace( ped, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)
							
							--ShowNotification("Call the cops!")
					
							CallCops(  GetEntityCoords(PlayerPedId()), ped, REPORT.GUNDRAWN )
							SetPedAlertness(ped, 3)
							
							Citizen.CreateThread(function()
								Citizen.Wait(3000)
								TaskReactAndFleePed(ped, playerPed)
							end)					
						end
						
						
						break
					end
				end
			end
			
			
		end
	end
end)	




-- Dealing with POLICE NPCs

arrestingCop = 0
local bDidCopGetBackInVehicle = false

-- Create another loop, this one has to be ran every tick.
Citizen.CreateThread(function()
    while true do
        
        -- Wait 0ms, makes the loop run every tick.
        Citizen.Wait(0)
        
        -- If the player is currently cuffed....
        if bSuspectInCustody then
            
            -- ...don't allow them to do one of the following actions by
            -- disabling all of those buttons on controller/keyboard+mouse.
            -- We don't want them to be able to use any type of attack,
            -- obviously you can't pull out your rocket launcher if you're cuffed.....
            DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
            DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(0, 257, true) -- INPUT_ATTACK2
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
            DisableControlAction(0, 24, true) -- INPUT_ATTACK
            DisableControlAction(0, 25, true) -- INPUT_AIM
		end
	end
end)

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(500)	--? or 1000
		--SetPlayerControl(PlayerId(), true)
		local WantedLevel = GetPlayerWantedLevel(PlayerId())
		local playerPed = GetPlayerPed(-1)
		
		
		if WantedLevel > 2 and arrestingCop~=0  then
			RemovePedFromGroup(arrestingCop)
			arrestingCop = 0
			print("Remove arresting cop? Too wanted")
		end
		
		if WantedLevel~=0 and WantedLevel < 3 then
			
			
			-- While arresting
			if arrestingCop ~= 0 then
				print("We have an arresting cop")

				
				--cleanup. stop arresting when too far...
				if DoesEntityExist(arrestingCop) and not IsPedDeadOrDying(arrestingCop, 1) then
				
					if not bSuspectInCustody then
						if not IsPedInAnyVehicle(playerPed, false) and not bHandsUp and not bSuspectInCustody then --SHOOT TO KILL!
							RemovePedFromGroup(arrestingCop)
							arrestingCop = 0	
							--print("Remove arresting cop? Not surrendering")
						else
							--print("Arrest , is surrendering")
						
							local pedCoords = GetEntityCoords(arrestingCop)
							local playerCoords = GetEntityCoords(GetPlayerPed(-1))	
							local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)				
						
							if distance < 0.7 then
								--PLAY ANIMATION (FRISKING)
								RequestAnimDict("anim@heists@load_box")
								while not HasAnimDictLoaded("anim@heists@load_box") do
									Citizen.Wait(100)
								end
								TaskPlayAnim( arrestingCop,"anim@heists@load_box","idle",2.0,-1.0, 5000, 49, 0, 0, 0, 0)
								
								Wait(2000)
								
								TaskGoStraightToCoord(arrestingCop, playerCoords.x, playerCoords.y, playerCoords.z,  1.0,  -1,  0.0,  0.0)
								
								
								local bArrest = false
								
								-- Check for weapons

								for i,weaponName in pairs(illegalWeapons) do
									local bHasWeapon = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weaponName),false)
									
									if bHasWeapon then
										ShowNotification("Illegal weapon found!")
										bArrest = true
									end
								end				

								
								ResetPlayerArrestState(PlayerId())
								
								-- Arrest or not
								if bArrest == false then
									TriggerServerEvent('wild-trainer:removeMoney', 0)
									PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
									
									
									-- Arrest the player
									
									lastGtaWantedLevel = 0
									SetPlayerWantedLevel(PlayerId(), 0, false)
									SetPlayerWantedLevelNow(PlayerId(), true)
									
									local copCar =  GetVehiclePedIsIn(arrestingCop, true)
									
									--if DoesEntityExist(copCar) and GetVehicleEngineHealth(copCar) > 300	and WantedLevel > 1	then --NOT WORKING
									if false then
										--Cuff the player, we're going for a ride
										bSuspectInCustody = true
										bHandsUp = false
										handsup = false --actionKeys.lua
										SetEnableHandcuffs(GetPlayerPed(-1), true)
										

										-- Load the animation dictionary.
										RequestAnimDict("mp_arresting")
										
										-- If it's not loaded (yet), wait until it's done loading.
										while not HasAnimDictLoaded("mp_arresting") do
											Citizen.Wait(100)
										end		
										
										TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
										--AttachEntityToEntity(GetPlayerPed(-1), arrestingCop, 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
										
										
										Citizen.Wait(1000)
										
										
										
										Citizen.CreateThread(function ()
											while true do
												Citizen.Wait(0)
												
												if arrestingCop~=0 and bSuspectInCustody==true then
													SetPlayerWantedLevel(PlayerId(), 0, false)
													SetPlayerWantedLevelNow(PlayerId(), true)

													local copCar = GetVehiclePedIsIn(arrestingCop, true)
													
													--Seems to be useless on cops
													empty, driver_group = AddRelationshipGroup("cop_driver")
													SetRelationshipBetweenGroups(0, driver_group, GetHashKey("PLAYER"))
													SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), driver_group)
													SetPedRelationshipGroupHash(arrestingCop, driver_group)
													
													
													SetPedInVehicleContext(GetPedInVehicleSeat(vehicle, -1), GetHashKey("MISSFBI2_MICHAEL_DRIVEBY"))
													
													--Teleport the sucker back in cuz he really wants to leave that car!
													if bDidCopGetBackInVehicle then 
														--SetPedIntoVehicle(arrestingCop, copCar, -1)
														TaskWarpPedIntoVehicle(arrestingCop, copCar, -1)
														ClearPedTasks(arrestingCop)
														ClearPedSecondaryTask(arrestingCop)
														SetVehicleDoorShut(copCar, 0, true)
														SetVehicleDoorShut(copCar, 1, true)
														SetVehicleDoorShut(copCar, 2, true)
														SetVehicleDoorShut(copCar, 3, true)
														SetVehicleDoorShut(copCar, 4, true)
														SetVehicleDoorShut(copCar, 5, true)
														SetVehicleDoorShut(copCar, 6, true)
														
														--ShowNotification(GetIsTaskActive(ped, taskNumber))
														--SetPedConfigFlag(arrestingCop, PED_FLAG_IS_STILL, true)
													end
													
													
													
													--Set the player as a prostitute passenger so he doesn't automatically leave the car!
													SetPedInVehicleContext(GetPlayerPed(-1), GetHashKey("MINI_PROSTITUTE_LOW_RESTRICTED_PASSENGER"))
													
													SetVehicleSiren(copCar, false) --please stop the noise!
												else
													break
												end
											end
										end)
										
										TaskEnterVehicle(playerPed, copCar, 20000, 1, 1.0, 1, 0)
										--TaskVehicleDriveToCoord(arrestingCop, copCar, -356.81, -134.26, 38.92, 26.0, 0, GetEntityModel(copCar), 411, 10.0)
										
										Citizen.CreateThread(function()
											while true do
												Citizen.Wait(0)
												if IsPedInAnyVehicle(GetPlayerPed(-1),false) then SetVehicleDoorsLocked(copCar, 4) SetVehicleDoorsLockedForAllPlayers(copCar, true) end
											end
										end)
										
										Citizen.CreateThread(function()
											while true do
												Citizen.Wait(0)
												if IsPedInAnyVehicle(arrestingCop,false) then bDidCopGetBackInVehicle=true end
											end
										end)
										
										Citizen.CreateThread(function()
											while true do
												Citizen.Wait(2000)
												if arrestingCop~=0 and bSuspectInCustody==true then
													if IsPedInAnyVehicle(GetPlayerPed(-1),false) then
														TaskVehicleDriveToCoord(arrestingCop, copCar, -356.81, -134.26, 38.92, 26.0, 0, GetEntityModel(copCar), 411, 10.0)
														--TaskVehicleDriveToCoordLongrange(arrestingCop, copCar, -34.552, -673.060, 31.944, 20.0,  447, 1.0)
														ShowNotification("Drive you f!@#!")
														SetPedKeepTask(arrestingCop, true)
													end
												else
													break
												end
											end
										end)										
										
										
										SetEntityAsMissionEntity(arrestingCop, true, true)
										SetEntityAsMissionEntity(copCar, true, true)
										
										Citizen.CreateThread(function()
											while true do
												Citizen.Wait(1000)
												
												if bSuspectInCustody == false then
													SetEntityAsNoLongerNeeded(arrestingCop)
													SetEntityAsNoLongerNeeded(copCar)
												end
											end
										end)


									else	
										RemovePedFromGroup(arrestingCop)
										arrestingCop = 0
										bSuspectInCustody = falses
									end
								
								else
									--Stop frisking... kill 'em!
									RemovePedFromGroup(arrestingCop)
									arrestingCop = 0
				
									SetPlayerWantedLevel(PlayerId(), 3, false)
									SetPlayerWantedLevelNow(PlayerId(), true)											
								end	
							elseif distance <= 3 then
								TaskGoStraightToCoord(arrestingCop, playerCoords.x, playerCoords.y, playerCoords.z,  1.0,  -1,  0.0,  0.0)
							elseif distance > 3 then
								TaskArrestPed(arrestingCop, GetPlayerPed(-1))
							elseif distance > 20.0 then
								RemovePedFromGroup(arrestingCop)
								arrestingCop = 0
								print("Remove arresting cop? Too far...")
							else
								TaskGoStraightToCoord(arrestingCop, playerCoords.x, playerCoords.y, playerCoords.z,  1.0,  -1,  0.0,  0.0)
							end
							



							
						end					
					else
						--Suspect is in custody
					end
	

				else
					arrestingCop = 0 --cop is dead or does not exist?
					print("Remove arresting cop? --cop is dead or does not exist?")
				end
			elseif not IsPedInAnyVehicle(GetPlayerPed(-1), false) and bHandsUp then --No cop is arresting. Create arresting cop?
				print("Create arresting cop?")
				for ped in EnumeratePeds() do
					if DoesEntityExist(ped) then
						local pedCoords = GetEntityCoords(ped)
						local playerPed = GetPlayerPed(-1)
						local playerCoords = GetEntityCoords(playerPed)	
						
						local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)
						
						--if IsCop(ped) and IsPedAPlayer(ped)==false and HasEntityClearLosToEntityInFront(ped, GetPlayerPed(-1)) and distance < 30.0 then
						--	arrestingCop = ped
						--	print("candidate:"..tostring(arrestingCop))
						--end
						
						if IsCop(ped) and IsPedAPlayer(ped)==false and HasEntityClearLosToEntityInFront(ped, GetPlayerPed(-1)) and distance < 30.0 then
							--Maybe we took too long to din??
							if arrestingCop==0 then
								print("NO ARRESTING COP?" .. tostring(ped) .. ",  Arrestingcop==".. tostring(arrestingCop))
								arrestingCop = ped
								
								SetPedAsCop(arrestingCop, false)--no effct :(
								
								local _GroupHandle = GetPlayerGroup(PlayerId())
								SetGroupSeparationRange(_GroupHandle, 999999.9)
								SetPedAsGroupLeader(playerPed, _GroupHandle)
								SetPedAsGroupMember(arrestingCop, _GroupHandle)
								SetPedNeverLeavesGroup(arrestingCop, true)							
								
								ClearPedTasks(arrestingCop)	
							else
								print("We couldn't create arresting cop: " .. tostring(ped) .. ",  Arrestingcop==".. tostring(arrestingCop))
							end
						end
					end
				end
			
			end
		end
	end
end)

--When not to shoot
Citizen.CreateThread(function()
    while true do
        --Wait(60000) -- Every minute
		Wait(1000)
		
		if arrestingCop~=0 or bHandsUp then
			if lastGtaWantedLevel < 3 then
				SetPoliceIgnorePlayer(PlayerId(), true)
			end
		else
			SetPoliceIgnorePlayer(PlayerId(), false)
		end
		
	end
end)


























-- PARAMETERS --
local SEARCH_STEP_SIZE = 10.0                   -- Step size to search for traffic lights
local SEARCH_MIN_DISTANCE = 20.0                -- Minimum distance to search for traffic lights
local SEARCH_MAX_DISTANCE = 60.0                -- Maximum distance to search for traffic lights
local SEARCH_RADIUS = 5.0                      -- Radius to search for traffic light after translating coordinates
local HEADING_THRESHOLD = 20.0                  -- Player must match traffic light orientation within threshold (degrees)
local TRAFFIC_LIGHT_POLL_FREQUENCY_MS = 500    -- How often to check if a light is red (ms)
local TRAFFIC_LIGHT_DURATION_MS = 5000          -- Duration to turn light green (ms)

-- Array of all traffic light hashes
local trafficLightObjects = {
    [0] = 0x3e2b73a4,   -- prop_traffic_01a
    [1] = 0x336e5e2a,   -- prop_traffic_01b
    [2] = 0xd8eba922,   -- prop_traffic_01d
    [3] = 0xd4729f50,   -- prop_traffic_02a
    [4] = 0x272244b2,   -- prop_traffic_02b
    [5] = 0x33986eae,   -- prop_traffic_03a
    [6] = 0x2323cdc5    -- prop_traffic_03b
}

-- Translate vector3 using 2D polar notation (ignoring z-axis)
function translateVector3(pos, angle, distance)
    local angleRad = angle * 2.0 * math.pi / 360.0
    return vector3(pos.x - distance*math.sin(angleRad), pos.y + distance*math.cos(angleRad), pos.z)
end


function WGetClosestVehicle(coords)
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	
	return closestVehicle, closestDistances
end
	
local bForgetLight = false	
	
Citizen.CreateThread(function()
	while false do -- DISABLE
    --while true do
        Wait(TRAFFIC_LIGHT_POLL_FREQUENCY_MS)
		
		--ShowNotification("In car...")
		
		-- Initialize local variables
		local lastTrafficLight = 0
		
		-- Get player and check traffic lights when in a vehicle and stopped
		local player = GetPlayerPed(-1)
		if IsPedInAnyVehicle(player) then
			-- Get player position, heading and search coordinates
			local playerPosition = GetEntityCoords(player)
			local playerHeading = GetEntityHeading(player)

			-- Search in front of car for traffic light that matches player heading
			local trafficLight = 0
			for searchDistance = SEARCH_MAX_DISTANCE, SEARCH_MIN_DISTANCE, -SEARCH_STEP_SIZE do
				-- Get search coordinates and search for all traffic lights using trafficLightObjects array
				local searchPosition = translateVector3(playerPosition, playerHeading, searchDistance)
				for _, trafficLightObject in pairs(trafficLightObjects) do
					-- Check if there is a traffic light in front of player
					trafficLight = GetClosestObjectOfType(searchPosition, SEARCH_RADIUS, trafficLightObject, false, false, false)
					if trafficLight ~= 0 then
						-- Check traffic light heading relative to player heading (to prevent setting the wrong lights)
						local lightHeading = GetEntityHeading(trafficLight)
						local headingDiff = math.abs(playerHeading - lightHeading)
						if ((headingDiff < HEADING_THRESHOLD) or (headingDiff > (360.0 - HEADING_THRESHOLD))) then
							-- Within threshold, stop searching
							break
						else
							-- Outside threshold, skip and keep searching
							trafficLight = 0
						end
					end
				end

				-- If traffic light found stop searching
				if trafficLight ~= 0 then
					break
				end
			end
			
            -- If traffic light found and not the same as the last one
            if (trafficLight ~= 0) and (trafficLight ~= lastTrafficLight) then -- OLD CODE
			--if (trafficLight ~= 0) then
                --ShowNotification("Found light...")
				bForgetLight = false
				
				local pos = GetEntityCoords(GetPlayerPed(-1),true)
				
				local veh = GetClosestVehicle(pos.x,pos.y,pos.z,10.00,0, 70)
				--local veh = WGetClosestVehicle(pos)
				
				
				if IsEntityAVehicle(veh) then
					
					--SetVehicleBodyHealth(veh,0)
					--SetEntityAlpha(veh, 128, 0)
					
					--local speed = (GetEntitySpeed(veh)* 2.236936)
					
					if IsVehicleStoppedAtTrafficLights(veh) then
						--ShowNotification( "Red light..." )
						
												
						Citizen.CreateThread(function()
							while not bForgetLight do
								Citizen.Wait(0)
								local playerPos = GetEntityCoords(GetPlayerPed(-1),true)
								local lightCoords = GetEntityCoords(trafficLight)
								local currentDistance = GetDistanceBetweenCoords(playerPos, lightCoords.x, lightCoords.y, lightCoords.z, true)										
								
								if currentDistance < 5 then
									TriggerServerEvent('wild-trainer:call911', playerPos.x, playerPos.y, playerPos.z, REPORT.REDLIGHT)
									
									SetPlayerWantedLevel(PlayerId(), 1, false)
									SetPlayerWantedLevelNow(PlayerId(), true)
	
								elseif currentDistance > 50 then
									bForgetLight = true
								end
							end							
						end)
					end
				end

                -- Save last light changed and delay to avoid setting other lights temporarily
                lastTrafficLight = trafficLight
                Citizen.Wait(TRAFFIC_LIGHT_DURATION_MS)
            end			

		end
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
	--- • Usage
	-- → Use this native inside a looped function.
	-- → Values:
	-- → 0.0 = no peds on streets
	-- → 1.0 = normal peds on streets		
		--SetPedDensityMultiplierThisFrame(1.0)
		--SetVehicleDensityMultiplierThisFrame(1.0)
	end
end)


Citizen.CreateThread(function()
  SwitchTrainTrack(0, true)
  SwitchTrainTrack(3, true)
  N_0x21973bbf8d17edfa(0, 120000)
  SetRandomTrains(1)
end)