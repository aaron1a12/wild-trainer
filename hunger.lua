function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        local ui = GetMinimapAnchor()
        local thickness = 8 -- Defines how many pixels wide the border is
        --drawRct(ui.x, ui.y, ui.width, thickness * ui.yunit, 0, 0, 0, 255)
		--ShowNotification( ui.height )
		
		
        drawRct(ui.x, ui.y + ui.height - 0.025, ui.width / 100 * iPlayerHunger, -thickness * ui.yunit, 100, 50, 0, 125)  --0.015
        --drawRct(ui.x, ui.y, thickness * ui.xunit, ui.height, 255, 0, 0, 255)
        --drawRct(ui.x + ui.width, ui.y, -thickness * ui.xunit, ui.height, 255, 0, 0, 255)
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(1000)
		
        iPlayerHunger = iPlayerHunger + 0.03
		
		if iPlayerHunger < 50 then
			-- Infinite Stamina for healthy players!
			SpecialAbilityFillMeter(PlayerId(), 1)
			RestorePlayerStamina(PlayerId(), 1.0)		
		end
		
		if iPlayerHunger > 80 and iPlayerHunger < 90 then
			ShowNotification("You are currently starving!")
			local playerPed = GetPlayerPed(-1)
			RequestAnimSet("move_m@hobo@a")
			SetPedMovementClipset(playerPed, "move_m@hobo@a", true)
		end
		
		if iPlayerHunger > 90 then
			
			PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
			
			ShowNotification("You are about to die! Get some food ASAP!")
			local playerPed = GetPlayerPed(-1)
			RequestAnimSet("move_m@drunk@verydrunk")
			SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
		end		
		
		if iPlayerHunger > 99 then
			local playerPed = GetPlayerPed(-1)

			RequestAnimDict("random@drunk_driver_1")
			while not HasAnimDictLoaded("random@drunk_driver_1") do
				Citizen.Wait(100)
			end
		
			TaskPlayAnim(playerPed,"random@drunk_driver_1","drunk_fall_over",1.0,-1.0, 5000, 0, 1, true, true, true)					
			
			Citizen.Wait(5000)
			
			SetEntityHealth(playerPed, 50)
			iPlayerHunger = iPlayerHunger-25
			
			if iPlayerHunger < 0 then
				iPlayerHunger = 0
			end
		end
    end
end)




AddEventHandler("wild-trainer:cl_loadHunger", function(hungerLevel)
	iPlayerHunger = hungerLevel
end)
RegisterNetEvent("wild-trainer:cl_loadHunger")

Citizen.CreateThread(function()
    while true do
        Wait(5000)
		
        TriggerServerEvent('wild-trainer:saveHunger', iPlayerHunger)
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	iPlayerHunger = 0
	TriggerServerEvent('wild-trainer:removeMoney', 0)
end)






foodLocations = {
	{ ['x'] = -803.38,  ['y'] = 185.64,  ['z'] = 72.61 }, --michael's fridge
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 1392.4129638672, ['y'] = 3604.47265625, ['z'] = 34.980926513672 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.79, ['y'] = 793.87, ['z'] = 138.13920593262 },  
	{ ['x'] = -1223.6690673828, ['y'] = -906.67517089844, ['z'] = 12.326356887817 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
	{ ['x'] = 373.8, ['y'] = 325.87, ['z'] = 103.57 },  
	{ ['x'] = 1136.31, ['y'] = -982.06, ['z'] = 46.42 },
	{ ['x'] = 2678.63, ['y'] = 3280.87, ['z'] = 55.24 },      
	{ ['x'] = 1698.33, ['y'] = 4925.01, ['z'] = 42.06 }, 
	{ ['x'] = -56.95, ['y'] = 6521.37, ['z'] = 31.49 },
	{ ['x'] = -2968.23, ['y'] = 391.28, ['z'] = 15.04 },   
	{ ['x'] = -1487.88, ['y'] = -379.11, ['z'] = 40.16 },     
	{ ['x'] = -47.23, ['y'] = -1756.5, ['z'] = 29.42 },
	{ ['x'] = -10.2, ['y'] = -1430.18, ['z'] = 31.1 }, 
	{ ['x'] = -1153.82, ['y'] = -1520.25, ['z'] = 10.63 },
	{ ['x'] = -560.16, ['y'] = 287.2, ['z'] = 82.18 },
	{ ['x'] = 1728.83, ['y'] = 6414.49, ['z'] = 35.04 },
	{ ['x'] = 1163.32, ['y'] = -322.24, ['z'] = 69.21 }  
}


foodDrawDistance = 3
foodMarkerSize = {x = 0.8, y = 0.8, z = 1.0}
foodMarkerColor = {r = 0, g = 255, b = 0, a = 25}

foodEnterExitDelay = 0
foodEnterExitDelayMax = 600

function AddBlips()
	Citizen.CreateThread(function()
		for _, foodLocation in pairs(foodLocations) do
		  foodLocation.blip = AddBlipForCoord(foodLocation.x, foodLocation.y, foodLocation.z)
		  SetBlipSprite(foodLocation.blip, 210)
		  SetBlipDisplay(foodLocation.blip, 4)
		  SetBlipScale(foodLocation.blip, 0.9)
		  SetBlipColour(foodLocation.blip, 2)
		  SetBlipAsShortRange(foodLocation.blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Food")
		  EndTextCommandSetBlipName(foodLocation.blip)
		end
	end)
end

AddBlips()

bIsEating = false
food_net = nil


-- Server triggered event when anyone eats
AddEventHandler("wild-trainer:cl_eatFood", function(bCanAfford)
	if bCanAfford then
		PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
		
		local playerPed = GetPlayerPed(-1)
						
		local foodModel = "prop_amb_donut"
		RequestModel(GetHashKey(foodModel))
		while not HasModelLoaded(GetHashKey(foodModel)) do
			Citizen.Wait(100)
		end					
		
		
		local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
		local foodSpawned = CreateObject(GetHashKey(foodModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
		--Citizen.Wait(1000)
		local netid = ObjToNet(foodSpawned)
		SetNetworkIdExistsOnAllMachines(netid, true)
		NetworkSetNetworkIdDynamic(netid, true)
		SetNetworkIdCanMigrate(netid, false)
		--AttachEntityToEntity(foodSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
		AttachEntityToEntity(foodSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
		food_net = netid
		
		--PLAY ANIMATION
		RequestAnimDict("amb@prop_human_seat_chair_food@male@idle_a")
		while not HasAnimDictLoaded("amb@prop_human_seat_chair_food@male@idle_a") do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed,"amb@prop_human_seat_chair_food@male@idle_a","idle_b",2.0,-1.0, 5000, 49, 0, 0, 0, 0)
		
		Citizen.Wait(5000)
		
		-- Clear!
		ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
		DetachEntity(NetToObj(food_net), 1, 1)
		DeleteEntity(NetToObj(food_net))
		food_net = nil			
		
		iPlayerHunger = iPlayerHunger - 25
		
		if iPlayerHunger < 80 then
			ResetPedMovementClipset( GetPlayerPed(PlayerId()), 0)
		end
		
		if iPlayerHunger < 0 then
			iPlayerHunger = 0
		end
		
		--Give Health
		SetEntityHealth(GetPlayerPed(PlayerId()), 200)
	else
		PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
		ShowNotification("You can't afford this!")
	end
	bIsEating = false
end)
RegisterNetEvent("wild-trainer:cl_eatFood")

Citizen.CreateThread(function()
	while true do		
		Wait(0)
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		
		--test
		--local foodModel = "prop_player_gasmask"
		--RequestModel(GetHashKey(foodModel))
		--while not HasModelLoaded(GetHashKey(foodModel)) do
		--	Citizen.Wait(100)
		--end					
		--local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
		--local foodSpawned = CreateObject(GetHashKey(foodModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
		--AttachEntityToEntity(foodSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 31086), 0, 0.0, 0.0,     90.0, -90.0, 90.0,    1, 1, 0, 1, 0, 1)	
		--Citizen.Wait(5000)		
		--DetachEntity(foodSpawned, 1, 1)
		--DeleteEntity(foodSpawned)	
		--Citizen.Wait(5000)	
		--test

		for i=1, #foodLocations, 1 do
			
			local foodLocation = foodLocations[i]
			local currentDistance = GetDistanceBetweenCoords(coords, foodLocation.x, foodLocation.y, foodLocation.z, true)
			if(currentDistance < foodDrawDistance) then
				foodMarkerColor.a = math.floor(100 - (currentDistance*currentDistance*10)) 
				--ShowNotification(foodMarkerColor.a)
				DrawMarker(1, foodLocation.x, foodLocation.y, foodLocation.z-1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, foodMarkerSize.x, foodMarkerSize.y, foodMarkerSize.z, foodMarkerColor.r, foodMarkerColor.g, foodMarkerColor.b, foodMarkerColor.a, false, true, 2, false, false, false, false)
			end
			if(GetDistanceBetweenCoords(coords, foodLocation.x, foodLocation.y, foodLocation.z, true) < foodMarkerSize.x / 2) then
				DisplayHelpText("Press ~INPUT_CONTEXT~ To Eat Food")
				if(IsControlPressed(0,51) and (GetGameTimer() - foodEnterExitDelay) > foodEnterExitDelayMax) and bIsEating == false then -- G
					foodEnterExitDelay = 0
					bIsEating = true
					Wait(60)
					
					-- Purchase
					TriggerServerEvent('wild-trainer:buyFood', 12)
			
					-- EAT FOOD
					
				end
			end
		end
	end
end)


