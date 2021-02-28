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

chatOpenCloseDelay = 0
chatOpenCloseDelayMax = 600
bIsChatOpen = false

chattingPed = 0

local drugPrice = 120
local DrugBuyers = {
	"g_m_y_ballasout_01",
	"g_m_y_ballaorig_01",
	"csb_ballasog",
	"g_m_y_ballaeast_01",
	"a_m_y_soucent_02",
	"g_m_y_strpunk_01",
	"ig_ballasog",
	"g_f_y_ballas_01",
	"csb_grove_str_dlr",
	"g_f_y_families_01",
	"g_m_y_famfor_01",
	"g_m_y_famdnf_01",
	"g_m_y_famca_01",
	"mp_m_famdd_01",
	"csb_ramp_gang",
	"ig_ramp_gang",
	"a_m_y_salton_01",
	"a_m_y_salton_02",
	"a_m_m_trampbeac_01",
	"a_m_y_hippy_01",
	"a_m_y_hipster_01",
	"a_m_y_hipster_02",
	"a_m_y_hipster_03",
	"a_m_m_mexcntry_01",
	"a_m_m_mexlabor_01",
	"a_m_y_mexthug_01",
	"s_f_y_hooker_01",
	"s_f_y_hooker_02",
	"s_f_y_hooker_03",
	"g_m_y_famca_01",
	"a_m_m_og_boss_01",
	"a_m_y_soucent_01",
	"a_m_y_soucent_02",
	"a_m_y_soucent_03",
	"a_m_y_methhead_01",
	"a_m_m_rurmeth_01",
	"csb_burgerdrug"
}

function PedCallCops(coords, target)
	TriggerServerEvent('wild-trainer:call911', coords.x, coords.y, coords.z, REPORT.DRUGDEAL)

	local playerPed = GetPlayerPed(-1)

	SetPedPrimaryLookat(ped, playerPed)
	ClearPedTasks(target)
	TaskChatToPed(target, playerPed, 16, 0.0, 0.0, 0.0, 0.0, 0.0)
	TaskLookAtEntity(target, playerPed, -1, 2048, 3)
	
	SetPedAlertness(target, 3)

	PlayAmbientSpeech1(target, "GENERIC_FRIGHTENED_MED", "SPEECH_PARAMS_FORCE")
	PlayAmbientSpeech1(target, "GENERIC_FRIGHTENED_HIGH", "SPEECH_PARAMS_FORCE")
	PlayAmbientSpeech1(target, "CALL_COPS_THREAT_RANDOM", "SPEECH_PARAMS_FORCE")
	PlayAmbientSpeech1(target, "CALL_COPS_COMMIT_01", "SPEECH_PARAMS_FORCE")
	PlayAmbientSpeech1(target, "CALL_COPS_THREAT_RANDOM", "SPEECH_PARAMS_FORCE")
	PlayAmbientSpeech1(target, "CALL_COPS_THREAT_01", "SPEECH_PARAMS_FORCE")
	
	
	
	TaskTurnPedToFaceEntity( target, playerPed, 1000)
	TaskStartScenarioInPlace( target, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)

	Citizen.CreateThread(function()
		Citizen.Wait(3000)
		
		if not IsPedHurt(target) and not IsPedDeadOrDying(target,1) then
			CreateIncident(7, coords.x, coords.y, coords.z, 50, 20.0, 0)
			CreateIncident(5, coords.x, coords.y, coords.z, 50, 20.0, 0)
			CreateIncident(7, coords.x, coords.y, coords.z, 50, 220.0, 1)
			CreateIncidentWithEntity(7, target, 50, 120.0, 1)
		end
	end)
end


function CloseChat()
	bIsChatOpen = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeGUI'})

	ClearPedTasks(chattingPed)
	chattingPed = nil
end

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(10)		

		
		-- Get player position, heading and search coordinates
		local playerPed = GetPlayerPed(-1)	
		local playerPosition = GetEntityCoords(playerPed)

		local Ent = nil
		local CoB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 2.0, 0.0)
		local RayHandle = CastRayPointToPoint(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, -1, GetPlayerPed(-1), 0)
		local A,B,C,D,Ent = GetRaycastResult(RayHandle)
		
		--DrawLine(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, 0, 0, 100, 255)		
		
		local ped = 0
		
		if IsEntityAPed(Ent) then
			ped = Ent
		end
		
		--if(IsControlPressed(0,51) and (GetGameTimer() - chatOpenCloseDelay) > chatOpenCloseDelayMax)  then -- G
		--	ShowNotification("Speak?")
			--PlayAmbientSpeech1(playerPed, "CHAT_RESP", "SPEECH_PARAMS_FORCE")
		--	SetPedTalk(GetPlayerPed(-1))
		--	PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
		--end
		
		if ped ~= 0 and not IsPedAPlayer(ped) and GetPedType(ped)~=28 and bIsChatOpen==false and GetPedAlertness(ped) ~= 3 then -- is ped?	

			--ShowNotification(GetEntityModel(ped))
			
			DisplayHelpText("Press ~INPUT_CONTEXT~ To Chat")
			
			if(IsControlPressed(0,51) and (GetGameTimer() - chatOpenCloseDelay) > chatOpenCloseDelayMax)  then -- G
				
				bIsChatOpen = true
				chattingPed = ped
				
				Citizen.CreateThread(function()
					--AttachEntityToEntity(chattingPed, GetPlayerPed(-1), 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
					ClearPedTasks(ped)
					TaskChatToPed(ped, playerPed, 16, 0.0, 0.0, 0.0, 0.0, 0.0)			
					
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGUI'})
					--Citizen.CreateThread(function()
					--	Citizen.Wait(4000)
					--	DeleteEntity(chattingPed)
					--end)
					
				end)
			end
		end
        
    end
end)

RegisterNUICallback('NUIClose', function()
	CloseChat()
end)


RegisterNUICallback('Chat', function(data)
	local bCanStillChat = true
	
	if chattingPed ~= nil then
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))	
		local pedCoords = GetEntityCoords(chattingPed)
		local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)	
		
		if distance > 4 or IsPedInCombat(chattingPed, GetPlayerPed(-1)) then
			bCanStillChat = false
			CloseChat()
		end
	end

	if bCanStillChat then
		if data.message == "SELL" then
		
			bIsBuyer = false
		
			for a = 1, #DrugBuyers do
				if IsPedModel(chattingPed, GetHashKey(DrugBuyers[a])) then
					bIsBuyer = true
				end
			end	
			
			local buyingChance = 20
			local timeOfDay = GetClockHours()
			
			if timeOfDay > 19 or timeOfDay < 5 then
				buyingChance = 60
			end
			
			if not IsPedMale(chattingPed) then
				buyingChance = buyingChance / 1.5
			end

			if bIsBuyer == false then
				if math.random(100) < buyingChance then
					bIsBuyer = true
				end
			end
			
			if bIsBuyer then
				
				local money = GetPedMoney(chattingPed) * 10
				
				if money > drugPrice then
				
					SendNUIMessage({receivedMessage = 'Sure bro...'})
					PlayAmbientSpeech1(chattingPed, "CHAT_RESP", "SPEECH_PARAMS_FORCE")
				
					PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
				
					SetPedMoney(chattingPed, math.floor((money-drugPrice)/10))
					TriggerServerEvent('wild-trainer:addMoney', drugPrice)
					
					--Witnesses
					for ped in EnumeratePeds() do
						if DoesEntityExist(ped) then
							local pedCoords = GetEntityCoords(ped)
							local playerCoords = GetEntityCoords(GetPlayerPed(-1))	
							local distance  = GetDistanceBetweenCoords(pedCoords, playerCoords.x, playerCoords.y, playerCoords.z, true)
							
							if IsPedAPlayer(ped)==false and chattingPed~=ped and HasEntityClearLosToEntityInFront(ped, GetPlayerPed(-1)) then
							
								if IsCop(ped) then
									SetPlayerWantedLevel(PlayerId(), 1, false)
									SetPlayerWantedLevelNow(PlayerId(), true)
								elseif distance < 20.0 and math.random(100) < 10 then
									
									PedCallCops(  GetEntityCoords(PlayerPedId()), ped )
															
									Citizen.CreateThread(function()
										Citizen.Wait(3000)
										ClearPedTasks(ped)
									end)
								end									
								
								break
							end
						end
					end							
					
				else
					SendNUIMessage({receivedMessage = 'Sorry bro... I have no money on me :('})
				end
			else
				-- ///////////////////////////////////////////////////////////////////
				-- Ped does NOT do drugs
				-- ///////////////////////////////////////////////////////////////////
		
				SetPedAlertness(chattingPed, 3)
				
				PlayAmbientSpeech1(chattingPed, "GENERIC_FRIGHTENED_MED", "SPEECH_PARAMS_FORCE")
				
				Citizen.CreateThread(function()
					Wait(2000)
					
					
					
					
					--if math.random(100) < 50 then
					--	PedCallCops(GetEntityCoords(PlayerPedId()), chattingPed)
					--end
					
					
					
					if math.random(100) < 20 then
						
						PedCallCops(  GetEntityCoords(PlayerPedId()), chattingPed )
												
						Citizen.CreateThread(function()
							Citizen.Wait(3000)
							ClearPedTasks(chattingPed)
							CloseChat()
						end)
					else
						ClearPedTasks(chattingPed)
						CloseChat()
					end				
					
					
					
					
				end)			
				
				
			end
		
			
		end
	
	else
		CloseChat()
	end
end)