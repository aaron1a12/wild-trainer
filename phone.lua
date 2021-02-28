local bIsPhoneOpen = false
local bIsPhoneCamOpen = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
		--SetNuiFocus(false, false)
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(playerPed, false)

		--if DoesEntityExist(playerVeh) then
		--	DisplayRadar(true)
		--else
		--	DisplayRadar(false)
		--end
		
		
		--if not bIsPhoneOpen then
		--	SetNuiFocus(false, false)
		--end

        if IsControlJustPressed (1, 27) --[[ INPUT_PHONE ]] then
			Citizen.CreateThread(function()
				if not bIsPhoneOpen then
					bIsPhoneOpen = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openPhone'})
					
					local lPed = GetPlayerPed(-1)
					if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
						TaskStartScenarioInPlace( GetPlayerPed(-1), "WORLD_HUMAN_STAND_MOBILE", 0, true)
					end
				end			
			end)
			--print("Clicked")
        end
		
        if IsControlPressed(0, 177)--[[ INPUT_CELLPHONE_CANCEL ]] then --173 is INPUT_CELLPHONE_DOWN
			if bIsPhoneCamOpen then
				bIsPhoneCamOpen = false	
				CellCamActivate(false, false)	
				DestroyMobilePhone()				
			end
        end
		
		
		
		if bIsPhoneCamOpen == true then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()
		end		

    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(1000)
		if bIsPhoneOpen then
			SendNUIMessage({type = 'phoneSetTime', hour=GetClockHours(), minute=GetClockMinutes()})
		end
	end
end)


RegisterNUICallback('lua_openCamera', function()
	bIsPhoneCamOpen = true
	
	ClearPedTasksImmediately(GetPlayerPed(-1))
	
	Citizen.Wait(500)
	
	CreateMobilePhone(0)
	CellCamActivate(true, true)
end)


RegisterNUICallback('lua_closePhone', function()
	if bIsPhoneOpen then
		bIsPhoneOpen = false
		SetNuiFocus(false, false)
		ClearPedTasks(GetPlayerPed(-1))
	end
end)