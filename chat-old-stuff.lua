Citizen.CreateThread(function()
    while true do
        Wait(1)
		
		if gbIsInsulting == true then
		
			

			
			-- Get player position, heading and search coordinates
			local playerPosition = GetEntityCoords(GetPlayerPed(-1))

			local Ent = nil
			local CoB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 10.0, 0.0)
			local RayHandle = CastRayPointToPoint(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, 10, GetPlayerPed(-1), 0)
			local A,B,C,D,Ent = GetRaycastResult(RayHandle)
			
			if GetEntityType(Ent) == 1 then
				local ped = Ent
				if IsPedFacingPed(ped, GetPlayerPed(-1), 90.0) then
					--SetEntityHealth(Ent, 0)	
					SetPedAsEnemy(ped, true)
					TaskCombatPed(ped, GetPlayerPed(-1),0,16)
				end
			end
			
		
			DrawLine(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, 0, 0, 100, 255)
		end
    end
end)

function MyClosestVehicle(x, y, z, radius)
    for i = 1,  72, 1 do
		print(">>>"..i)
        local angle = (i * 5) * math.pi / 180;

        local sx = (50.0 * math.cos(angle)) + x;
        local sy = (50.0 * math.sin(angle)) + y;

        local ex = x - (sx - x);
        local ey = y - (sy - y);

        local rayHandle = StartShapeTestCapsule(sx, sy, z, ex, ey, z, radius, 10, PlayerPedId(), 1000)

        local ent = GetShapeTestResult(rayHandle, false)

		if GetEntityType(ent) == 2 then
		    return ent;
		end
    end
end


rideEnterExitDelay = 0
rideEnterExitDelayMax = 600

Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(10)		
		
		-- Get player position, heading and search coordinates
		local playerPosition = GetEntityCoords(GetPlayerPed(-1))

		local Ent = nil
		local CoB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
		local RayHandle = CastRayPointToPoint(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, 2, GetPlayerPed(-1), 0)
		local A,B,C,D,Ent = GetRaycastResult(RayHandle)
		
		--DrawLine(playerPosition.x, playerPosition.y, playerPosition.z, CoB.x, CoB.y, CoB.z, 0, 0, 100, 255)
		
		if GetEntityType(Ent) == 2 then
			local veh = Ent
			
			
			
			--if CanCreateRandomCops() then
			DisplayHelpText("Press ~INPUT_MP_TEXT_CHAT_TEAM~ to Ask For Ride")
			--end
			
			if(IsControlPressed(0,246) and (GetGameTimer() - rideEnterExitDelay) > rideEnterExitDelayMax) then -- G
				
				local driver = GetPedInVehicleSeat(veh, -1)
				SetPedCanBeKnockedOffVehicle(driver, 0)
				CanKnockPedOffVehicle(GetPlayerPed(-1), 0)
				SetVehicleUndriveable(veh, true)
				
				
				SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				
				SetPedConfigFlag(GetPlayerPed(-1), 184, 1)
				TaskEnterVehicle(GetPlayerPed(-1), veh, 10000, 0, 1.0, 1, 0)
				SetPedConfigFlag(GetPlayerPed(-1), 184, 1)
				
				
				Citizen.CreateThread(function()
					while true do
						Citizen.Wait(0)
						if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
							if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
								if GetIsTaskActive(GetPlayerPed(-1), 165) then
									SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
								end
							end
						end
					end
				end)				
				
			end
		end
        
    end
end)