-- THIS SCRIPT SOMEHOW DISABLES FIRST-PERSON 

Citizen.CreateThread(function ()
	local context = GetHashKey("MINI_PROSTITUTE_LOW_RESTRICTED_PASSENGER")

	while true do
		ped = PlayerPedId()
		vehicle = GetVehiclePedIsIn(ped, false)

		-- Ped is in vehicle
		if DoesEntityExist(vehicle) then
			local engine = GetIsVehicleEngineRunning(vehicle)
			
			
			
			empty, driver_group = AddRelationshipGroup("bus_driver")
			SetRelationshipBetweenGroups(0, driver_group, GetHashKey("PLAYER"))
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), driver_group)


			SetPedRelationshipGroupHash(GetPedInVehicleSeat(vehicle, -1), driver_group)
			

			SetPedInVehicleContext(GetPedInVehicleSeat(vehicle, -1), GetHashKey("MISS_ARMENIAN3_FRANKLIN_TENSE"))
			--SetVehicleDoorsLocked(vehicle, 2)

			-- Ped is in drivers seat
			if GetPedInVehicleSeat(vehicle, -1) == ped then
				-- Listen for vehicle exit
				if IsControlJustPressed(0, 23) then
					local held = 0
					while GetIsTaskActive(ped, 159) do
						-- Accumulate held
						if IsControlPressed(0, 23) then held = held + 1
						else
							held = 0
						end

						-- Held - turn engine off
						if held > 20 then
							SetVehicleEngineOn(vehicle, false, false, false)
							SetVehicleJetEngineOn(vehicle, false)
							break

						-- Don't let the engine shut off
						else
							SetVehicleEngineOn(vehicle, true, false, false)
							SetVehicleJetEngineOn(vehicle, true)
						end

						Wait(0)
					end
					ResetPedInVehicleContext(ped)

				-- Engine is off | Prevent default engine on
				elseif not engine then
					SetPedInVehicleContext(ped, context)
					-- Listen for engine on
					if IsControlJustPressed(0, 32) then
						ResetPedInVehicleContext(ped)
						SetVehicleEngineOn(vehicle, true, false, false)
						SetVehicleJetEngineOn(vehicle, true)
					end
				end
			end

			-- Passenger
			if GetPedInVehicleSeat(vehicle, 0) == ped or GetPedInVehicleSeat(vehicle, 1) == ped or GetPedInVehicleSeat(vehicle, 2) == ped  then
				SetPedInVehicleContext(ped, context)
				--SetPedConfigFlag(ped, PED_FLAG_IS_STILL, true)
				--ShowNotification("??")
			end
		end

		Wait(0)
	end
end)

Citizen.CreateThread(function ()
	local b = false
	local ped = PlayerPedId()

	-- FIXME
	local VehicleInteractions = {
		{ --[[bone = "door_dside_f",]] door = 0, seat = -1 }, -- Door left front (driver)
		{ --[[bone = "door_pside_f",]] door = 1, seat =  0 }, -- Door right front
		{ --[[bone = "door_dside_r",]] door = 2, seat = 1 }, -- Door left back
		{ --[[bone = "door_pside_r",]] door = 3, seat = 2 }, -- Door right back
		{ bone = "bonnet", door = 4, range = 1.5 }, -- Vehicle hood - May not always be a door?
		{ bone = "boot", door = 5, range = 1.5 }, -- Vehicle trunk
		{ door = 6 }, -- Back | Trunk2 ?
		{ door = 7 }, -- Back2 ?
		{ bone = 'seat_dside_r2', seat = 3 }, -- seat in vehicle back or on vehicle side
		{ bone = 'seat_pside_r2', seat = 4 }, -- .. bone may not correspond to seat
		{ bone = 'seat_dside_r1',  seat = 5 },-- ..
		{ bone = 'seat_pside_r1', seat = 6 }, -- ..
	}

	while true do
		ped = PlayerPedId()

		if IsControlJustPressed(0, 23, true) then -- 23 INPUT_ENTER
			if GetIsTaskActive(ped, 160) then
				local nearest
				local dist = math.huge
				local ppos = GetEntityCoords(ped)
				local vehicle = GetVehiclePedIsTryingToEnter(ped)

				-- Override entering the drivers seat with the nearest interaction
				if DoesEntityExist(vehicle) and GetSeatPedIsTryingToEnter(ped) == -1 then
					local bone
					local len
					local coords

					for i, v in ipairs(VehicleInteractions) do
						coords = false

						-- Use bone coords
						if v.bone then
							bone = GetEntityBoneIndexByName(vehicle, v.bone)

							if bone ~= -1 then
								coords = GetWorldPositionOfEntityBone(vehicle, bone)
							end

						-- Use entry position
						elseif v.door and DoesVehicleHaveDoor(vehicle, v.door) then
							coords = GetEntryPositionOfDoor(vehicle, v.door)
						end

						-- Is interaction is nearest
						if coords then
							len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), coords)
							 -- Ignore out of interaction range
							if v.range and len > v.range then
							elseif len < dist then
								dist = len
								nearest = i
							end
						end
					end
				end

				if nearest then
					nearest = VehicleInteractions[nearest]

					-- If there's not a seat
					if not nearest.seat then
						local door = nearest.door
						if door then -- open the door specified
							ClearPedTasks(ped)
							ClearPedTasksImmediately(ped)

							if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
								SetVehicleDoorShut(vehicle, door, false)
								PlayVehicleDoorCloseSound(vehicle, 1)
							else
								-- TODO task and check if task starts otherwise SetVehicleDoorOpen
								--TaskOpenVehicleDoor(ped, vehicle, -1, door, 1.0)
								SetVehicleDoorOpen(vehicle, door, true, false)
								PlayVehicleDoorOpenSound(vehicle, 0)
							end
						end
					else
						local seat = nearest.seat
						local occupant = GetPedInVehicleSeat(vehicle, seat)

						if DoesEntityExist(occupant) then
							local rel1 = GetRelationshipBetweenPeds(ped, occupant)
							if seat ~= -1 then ClearPedTasks(ped) end
							if rel1 >= 3 and rel1 <= 5 or rel1 == 255 then
							end
						else
							ClearPedTasks(ped)
							CanShuffleSeat(vehicle, false)
							TaskEnterVehicle(ped, vehicle, 5000, seat, 1.0, 1, 0)
						end

						---- Failed to gain enter task
						-- Wait(0)
						-- if GetVehiclePedIsTryingToEnter(ped) == 0 then end
					end
				end
			end
		end

		Wait(0)
	end
end)