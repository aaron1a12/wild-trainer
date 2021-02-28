handsup = false
damn = false
easyNow = false
andy = false
finger = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("random@mugging3")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 19) then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("random@mugging3")
						while not HasAnimDictLoaded("random@mugging3") do
							Citizen.Wait(100)
						end

						if not handsup then
							handsup = true
							bHandsUp = true
							TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 4.0, -8, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
			end
		end
		if IsControlReleased(1, 19) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if handsup then
						handsup = false
						bHandsUp = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("gestures@m@standing@casual")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 323) then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("gestures@m@standing@casual")
						while not HasAnimDictLoaded("gestures@m@standing@casual") do
							Citizen.Wait(100)
						end

						if not damn then
							damn = true
							TaskPlayAnim(lPed, "gestures@m@standing@casual", "gesture_damn", 1.0, -1.0, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
			end
		end
		if IsControlReleased(1, 323) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("gestures@m@standing@casual")
					while not HasAnimDictLoaded("gestures@m@standing@casual") do
						Citizen.Wait(100)
					end

					if damn then
						damn = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("gestures@m@standing@casual")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 20) then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("gestures@m@standing@casual")
						while not HasAnimDictLoaded("gestures@m@standing@casual") do
							Citizen.Wait(100)
						end

						if not easyNow then
							easyNow = true
							TaskPlayAnim(lPed, "gestures@m@standing@casual", "gesture_easy_now", 1.0, -1.0, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
			end
		end
		if IsControlReleased(1, 20) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("gestures@m@standing@casual")
					while not HasAnimDictLoaded("gestures@m@standing@casual") do
						Citizen.Wait(100)
					end

					if easyNow then
						easyNow = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("special_ped@andy_moon@monologue_11@monologue_11e")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 301) then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("special_ped@andy_moon@monologue_11@monologue_11e")
						while not HasAnimDictLoaded("special_ped@andy_moon@monologue_11@monologue_11e") do
							Citizen.Wait(100)
						end

						if not andy then
							andy = true
							TaskPlayAnim(lPed, "special_ped@andy_moon@monologue_11@monologue_11e", "andy_ig_1_p11_dontworrywhentheyroastyou_4", 1.0, -1.0, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
			end
		end
		if IsControlReleased(1, 301) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("special_ped@andy_moon@monologue_11@monologue_11e")
					while not HasAnimDictLoaded("special_ped@andy_moon@monologue_11@monologue_11e") do
						Citizen.Wait(100)
					end

					if andy then
						andy = false
						ClearPedSecondaryTask(lPed)
					end
				end)
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("mp_player_int_upperup_yours")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 249) then
				if DoesEntityExist(lPed) then
					SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("mp_player_int_upperup_yours")
						while not HasAnimDictLoaded("mp_player_int_upperup_yours") do
							Citizen.Wait(100)
						end

						if not finger then
							finger = true
							TaskPlayAnim(lPed, "mp_player_int_upperup_yours", "mp_player_int_up_yours", 1.0, -1.0, -1, 49, 0, 0, 0, 0)
							
							TriggerServerEvent('wild-trainer:insultingPed', 1)
						end   
					end)
				end
			end
		end
		if IsControlReleased(1, 249) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("mp_player_int_upperup_yours")
					while not HasAnimDictLoaded("mp_player_int_upperup_yours") do
						Citizen.Wait(100)
					end

					if finger then
						finger = false
						ClearPedSecondaryTask(lPed)
						
						TriggerServerEvent('wild-trainer:insultingPed', 0)
					end
				end)
			end
		end
	end
end)