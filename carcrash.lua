-- DO NOT CHANGE 
-- Speed in MPH
minSpeed = 45
fatalSpeed = 70


-- Do not edit bellow this line

interval = 0
prevSpeed = 0
prevHealth = 1000
prevHeight = 0
lastTimeChecked = 0

local isBlackedOut = false
local function blackout()
	--TransitionToBlurred(time)
	--TransitionFromBlurred(time)
	-- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
	if not isBlackedOut then
		isBlackedOut = true
		--StartScreenEffect("DrugsMichaelAliensFightIn", 100, 0)
		
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.200)
		
		StartScreenEffect("FocusOut", 5000, 1)
		
		-- This thread will black out the user's screen for the specified time
		Citizen.CreateThread(function()
			
			--DoScreenFadeOut(100)
			--while not IsScreenFadedOut() do
			--	Citizen.Wait(0)
			--end
			Citizen.Wait(1000)
			--DoScreenFadeIn(250)
			
			
			Citizen.Wait(1000)
			
			
			StartScreenEffect("FocusOut", 100, 0)
			StopScreenEffect("FocusOut")
			StopScreenEffect("FocusOut")
			
			--StartScreenEffect("DrugsDrivingOut", 5000, 0)
			
			--StopScreenEffect("DrugsDrivingOut")
			
			--StopScreenEffect("DrugsMichaelAliensFightOut")
			
			Citizen.Wait(2000)
			---StopScreenEffect("DrugsMichaelAliensFightIn")
			
			isBlackedOut = false
		end)
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1, 117) then
			SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 2, false, false, false)
			local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
			
						local frontx = GetEntityForwardX(GetPlayerPed(-1))
						local fronty = GetEntityForwardY(GetPlayerPed(-1))
						local heading = GetEntityHeading(GetPlayerPed(-1))
						
			--ApplyForceToEntityCenterOfMass(GetPlayerPed(-1), 0, 0, 0, -1000, p5, true, true, 0)
			--ApplyForceToEntityCenterOfMass(GetPlayerPed(-1), 0, frontx, fronty, heading, 0, false, true, 0)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)	
		
		local currentHeight = GetEntityHeightAboveGround(vehicle)
		
		--ShowNotification("Prev: " .. prevHeight .. ", current: " .. currentHeight)
		
		--GetEntityHeight()
		
		if currentHeight < 2 and prevHeight > 5 then
			SetVehicleBodyHealth(vehicle, health/3)
		end
		
		local vehicleClass = GetVehicleClass(vehicle)
		
		if vehicleClass == 13 then -- class #13 are bicycles		
			SetVehicleTyreBurst(vehicle, 0, 0, 1)
			if currentHeight < 2 and prevHeight > 8 then
				SetVehicleBodyHealth(vehicle, 0)
				SetEntityInvincible(GetPlayerPed(-1), true)
				NetworkExplodeVehicle(vehicle, true, false, false)
				SetEntityInvincible(GetPlayerPed(-1), false)
			end
        end

		if currentHeight < 2 and prevHeight > 10 then
			
			local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
			
			--NetworkExplodeVehicle(vehicle, true, false, false)
			SetVehicleBodyHealth(vehicle, 0.0)
			SetEntityHealth(vehicle, 0.0)
		end

		--print(currentHeight)
		
		lastTimeChecked = lastTimeChecked + 1
		
		if lastTimeChecked > 5 then
			prevHeight = currentHeight
			
			lastTimeChecked = 0
		end
		
	end
end)	

Citizen.CreateThread(function()
    while true do
        Wait(500)
		
		local playerPed = GetPlayerPed(-1)
		
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)		
			health = GetVehicleBodyHealth(vehicle)
			petrolHealth = GetVehiclePetrolTankHealth(vehicle)
			engineHealth = GetVehicleEngineHealth(vehicle)
			
			--if GetEntityHeightAboveGround

			local speed = (GetEntitySpeed(vehicle)* 2.236936)
			
			--if (prevSpeed - speed) > 10 and (prevHealth-health)>7 and prevSpeed > minSpeed  then
			if (prevSpeed - speed) > 10 and (prevHealth-health)>7 and prevSpeed > minSpeed  then
				blackout()
				SetVehicleEngineHealth(vehicle, engineHealth/1.2)
				
				if 100 * math.random() < 15 then
					--ShowNotification("Set tank health?")
					SetVehiclePetrolTankHealth(vehicle, petrolHealth/2)
					
					if 100 * math.random() < 35 then
						--ShowNotification("Set fire?")
						local vehicleCoords = GetEntityCoords(vehicle)
						StartScriptFire(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 25, true)
					end
				end	
				
				--TransitionToBlurred(500)
				--TransitionFromBlurred(4000)
			end
			
			--if speed < 20 and prevSpeed > minSpeed then
			if (prevSpeed - speed) > 10 and (prevHealth-health)>7  then
			
			
			
				local percentageMax = fatalSpeed - minSpeed
				local speedPercentage = prevSpeed - minSpeed
				
				if speedPercentage < 0 then
					speedPercentage = 0
				elseif speedPercentage > 25 then
					speedPercentage = 25
				end				
				
				--local percentage = (speedPercentage / percentageMax) * 100
				local percentage = math.pow(speedPercentage,3)/math.pow(percentageMax,3)*100;
				
				if percentage < 0 then
					percentage = 0
				elseif percentage > 99 then
					percentage = 99
				end
				
				--ShowNotification(percentage .. "% chance of dying...")
				--ShowNotification(speedPercentage .. " speedPercentage...")
				--ShowNotification(percentageMax .. " percentageMax...")
				
				if IsPedInAnyHeli(GetPlayerPed(-1)) or IsPedInAnyPlane(GetPlayerPed(-1)) then
					percentage = percentage / 20 -- super low chance when in aircraft
				end
				
				--Die depending on chance derived from percentage
				if 100 * math.random() < percentage then
					interval = interval + 1
					--ShowNotification("Dead " .. interval)
					
					SetVehicleBodyHealth(vehicle, health/3)
					SetEntityHealth(playerPed, 0)
				end
			
			end
			
			--if (prevSpeed - speed) > 10 then
			--	ShowNotification("Crash?" .. interval)
			--end
			
			prevSpeed = speed
			prevHealth = health
			
			
			-- GTA returns the `w` value last.
			--local x, y, z, w = GetEntityQuaternion(vehicle)
			--local q = quat(w, x, y, z)

			-- Prints the quaternion to your client console
			--ShowNotification(q)			
		end
    end
end)

