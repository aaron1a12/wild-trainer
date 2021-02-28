-- es_extended/client/main.lua:69 makes the player respawn at the same last location. You must edit that file.



Citizen.CreateThread(function()    
	-- main loop thing
    while true do
		Citizen.Wait(100)		
	
		if IsEntityDead(GetPlayerPed(-1)) then
		
			
		
			
			--DoScreenFadeOut(800)
			
			--Citizen.Wait(2000)
			
			--DoScreenFadeIn(800)
			--ShowNotification("Alive again?")
			--RemoveItemsAfterRPDeath()
		end	
        
    end
end)

