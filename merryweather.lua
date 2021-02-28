local merryweatherBase  = {483.51, -3205.32, 6.07}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		local currentDist  = GetDistanceBetweenCoords(playerCoords, merryweatherBase[1], merryweatherBase[2], merryweatherBase[3], false)
		
		if currentDist < 150 then	
			
			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					if IsPedInCombat(ped, PlayerPedId()) then
						--Citizen.Wait(5000)
						-- Call cops
						CreateIncidentWithEntity(7, ped, 50, 120.0, 1)
					end
				end
			end				
			
		end
	end
end)	