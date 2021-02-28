devonsHanger = {
	['x'] = -995.0,  ['y'] = -2966.0,  ['z'] = 13.0,
	['id'] = 163585,
	['cam'] = {
		['x'] = -1065.32,  ['y'] = -3178.0,  ['z'] = 15.31, ['h'] = 5.0							   
	},
	['spawn'] = {
		['x'] = -1067.85,  ['y'] = -3155.47,  ['z'] = 14.05, ['h'] = 59.98						   
	},
	['delivery'] = {
		['x'] = -979.95,  ['y'] = -2995.47,  ['z'] = 13.95, ['h'] = 60.16						   
	}
}

gtaAircraft = {
    {"cuban800", "Cuban 800", 145000},
    {"dodo", "Dodo", 422000},
    {"frogger", "Frogger", 1325000},
    {"havok", "Havok", 104000},    
    {"mammatus", "Mammatus", 350000},
    {"maverick", "Maverick", 315000},
    {"microlight", "Micro Light", 35000},
	{"buzzard2", "Nagasaki Buzzard", 225000},
	{"thruster", "Mammoth Thruster Jetpack", 98000},
	{"velum", "JoBuilt Velum", 985000},
	{"velum2", "JoBuilt Velum 5-Seater", 1050000},
	{"seabreeze", "Western Company Seabreeze", 225000},
    {"seasparrow", "Sea Sparrow", 272000},
    {"skylift", "Skylift", 1525000},
    {"supervolito", "Super Volito", 2250000},
    {"supervolito2", "Super Volito (Carbon)", 2350000},
    {"swift", "Swift", 2350000},
    {"swift2", "Swift Deluxe", 2450000},
    {"volatus", "Volatus", 5000000},
	
	{"nimbus", "Buckingham Nimbus", 5000000}
}

function GetVehicleName( modelName )
    for _,aircraftModel in ipairs(gtaAircraft) do
        if modelName == aircraftModel[1] then
            return aircraftModel[2]
        end
    end

    return modelName
end

function GetAircraftSellPrice( modelName )
    for _,aircraftModel in ipairs(gtaAircraft) do
        if modelName == aircraftModel[1] then
            return round((aircraftModel[3]/100)*98)
        end
    end

    return 1
end

_aircraftPool = NativeUI.CreatePool()
aircraftMenu = NativeUI.CreateMenu("Devon Weston", "~b~Buy Aircraft here!")

_aircraftPool:Add(aircraftMenu)

local airCam = 0
local camOffset = 0.0
local aircraftSelection = {
	['model'] = gtaAircraft[1][1],
	['name'] = gtaAircraft[1][2],
	['price'] = gtaAircraft[1][3],
	['used'] = false,
}
local previewModel = nil
local activeAircraft = nil

aircraftMenu.OnMenuClosed = function(menu)
	SetPlayerControl(PlayerId(), true)
	SetCamActive(airCam, false)
	RenderScriptCams(false, 1, 0, 300, 300)
	--enderScriptCams(false, 1, 4000, 300, 300)
	
	DestroyCam(airCam,false)
    --ShowNotification("Close")

	if DoesEntityExist(previewModel) then
		SetEntityAsMissionEntity(previewModel, true, true)
		DeleteVehicle(previewModel)
		DeleteEntity(previewModel)
	end    
end

local function AddBlipForActiveAircraft()
	local blippo = AddBlipForEntity(activeAircraft.aircraft)
	
	SetBlipSprite(blippo, 251)
	SetBlipColour(blippo, 8)		
	
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Registered Aircraft")
	EndTextCommandSetBlipName(blippo)	
	
	activeAircraft.blip = blippo
end

AddEventHandler("populateOwnedAircraftList", function()
    if _aircraftPool:IsAnyMenuOpen() then
        RefreshOwnedAircraftMenu()
    end
end)

function RefreshOwnedAircraftMenu()
    if subMenu_ownedAircraft ~= nil then
        subMenu_ownedAircraft:Clear()
    end

    for acPlate, aircraft in pairs(globalPlayerGarage) do

        if aircraft.type == 2 then
            local newSub = _aircraftPool:AddSubMenu(subMenu_ownedAircraft, "» ".. GetVehicleName(aircraft.model))

            local spawnBtn = UIMenuColouredItem.New("Spawn Now", "Current model", {R = 0, G = 255, B = 255, A = 255}, {R = 0, G = 255, B = 255, A = 255})
            newSub:AddItem(spawnBtn)

            local sellBtn = NativeUI.CreateItem("Sell", '') 
            sellBtn:RightLabel("$"..comma_value(tonumber(GetAircraftSellPrice(aircraft.model))), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})
            newSub:AddItem(sellBtn)

            newSub.OnItemSelect = function(sender, item, index)
                if item == spawnBtn then

                    newSub:GoBack()
                    subMenu_ownedAircraft:GoBack()
                    aircraftMenu:GoBack()

                    SpawnAircraft( acPlate, aircraft )

                elseif item == sellBtn then
                    newSub:GoBack()
                    subMenu_ownedAircraft:GoBack()
                    aircraftMenu:GoBack()
                                        
                    TriggerServerEvent('wild-trainer:unregisterVehicle', acPlate)
                    TriggerServerEvent('wild-trainer:addMoney', GetAircraftSellPrice(aircraft.model))

                    if activeAircraft~=nil and DoesEntityExist(activeAircraft.aircraft) then
                        SetEntityAsMissionEntity(activeAircraft.aircraft, true, true)
                        DeleteVehicle(activeAircraft.aircraft)
                        DeleteEntity(activeAircraft.aircraft)
                        RemoveBlip(activeAircraft.blip)
                    end                    
                end
            end
        end
    end
end

function RefreshAircraftMenu()
    TriggerServerEvent('wild-trainer:getGarage')
    -- Player ctrl

    SetPlayerControl(PlayerId(), false)

    -- Cam

    airCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamActive(airCam, true)

    RenderScriptCams(true, true, 0, true, true)
    SetCamCoord(airCam, devonsHanger.cam.x, devonsHanger.cam.y, devonsHanger.cam.z)
    SetCamRot(airCam, -10.0, 0.0, devonsHanger.cam.h, true)		

    Citizen.CreateThread(function()
        while _aircraftPool:IsAnyMenuOpen() do Citizen.Wait(1)
        --while false do Citizen.Wait(1)
            if camOffset < -1.1 then
                camBobbingRight = true
            elseif camOffset > 3.5 then
                camBobbingRight = false
            end
            
            if camBobbingRight then camOffset = camOffset + 0.002 else camOffset = camOffset - 0.002 end
            
            SetCamFov(airCam, 20.0 + camOffset*10)
            SetCamCoord(airCam, devonsHanger.cam.x - (camOffset*6), devonsHanger.cam.y + (camOffset*6), devonsHanger.cam.z + (camOffset/4))
            --SetCamRot(airCam, ((camOffset-camOffset-camOffset)*2), 0.0, devonsHanger.cam.h + ((camOffset-camOffset-camOffset)*10), true)

            local camPos = GetCamCoord(airCam)
            local camRot = GetCamRot(airCam)
            local camAngle = ( 360 - math.deg(math.atan2((devonsHanger.spawn.x - camPos.x), (devonsHanger.spawn.y - camPos.y))) ) % 360

            SetCamRot(airCam, 0.0, 0.0, camAngle, 2)
            --ShowNotification(camAngle)
        end
    end)

    -------------------------------------------------------------------------------
    aircraftMenu:Clear()

    --carModelNamePreview = UIMenuColouredItem.New("", "Current model", {0, 0, 0}, {0, 128, 128})
    --carModelNamePreview:SetLeftBadge(BadgeStyle.Car)
    --aircraftMenu:AddItem(carModelNamePreview)
    
    subMenu_buyAircraft = _aircraftPool:AddSubMenu(aircraftMenu, "» Buy New Aircraft")
    subMenu_buyAircraft:Clear()

    aircraftNamePreview = UIMenuColouredItem.New("", "Current model", {0, 0, 0}, {0, 128, 128})
    aircraftNamePreview:SetLeftBadge(BadgeStyle.Car)
    subMenu_buyAircraft:AddItem(aircraftNamePreview)

    local changeCarModelMenu = _aircraftPool:AddSubMenu(subMenu_buyAircraft, "[ Change Model ]")
    changeCarModelMenu:Clear()

    local uiBuyCar = UIMenuColouredItem.New("Buy Vehicle", "", {0, 0, 0}, {0, 128, 128})
    subMenu_buyAircraft:AddItem(uiBuyCar)

    for _,aircraftModel in ipairs(gtaAircraft) do
        local newItem = NativeUI.CreateItem(aircraftModel[2], '') --'Retail Price: $'..comma_value(tonumber(aircraftModel[3]))

        newItem:RightLabel("$"..comma_value(tonumber(aircraftModel[3])), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})

        --local newItem = UIMenuColouredItem.New(aircraftModel[2], 'Retail Price: $'..comma_value(tonumber(aircraftModel[3])), {R = 0, G = 255, B = 255, A = 255}, {R = 0, G = 255, B = 255, A = 255})

        changeCarModelMenu:AddItem(newItem)
    end    

    
    changeCarModelMenu.OnItemSelect = function(sender, item, index)
        PreviewAircraft(gtaAircraft[index][1], gtaAircraft[index][2], gtaAircraft[index][3], false)
    end


    subMenu_buyAircraft.OnItemSelect = function(sender, item, index)
        if item == uiBuyCar and DoesEntityExist(previewModel) then
            TriggerServerEvent('wild-trainer:buyAircraft', aircraftSelection.price)
        end
    end    

    subMenu_buyAircraft.OnMenuChanged = function(sender, item, index)
        --ShowNotification("ITEM SELECT")

        if DoesEntityExist(previewModel) then
            SetEntityAsMissionEntity(previewModel, true, true)
            DeleteVehicle(previewModel)
            DeleteEntity(previewModel)
        end
    end


    subMenu_ownedAircraft = _aircraftPool:AddSubMenu(aircraftMenu, "» Manage Owned")

    RefreshOwnedAircraftMenu()

    _autoMenuPool:RefreshIndex()
end

AddEventHandler("wild-trainer:cl_buyAircraft", function(bCanAfford)
	if bCanAfford then
		PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
        
        -- Buy Aircraft

	    -- Generate a new license plate
        local licensePlate = randomString(8)        

        -- Save colors
        local primary, secondary = GetVehicleColours(previewModel)    
        
        local bodyHealth = 1000.0
        local engineHealth = 1000.0   
        
        -- Register

        TriggerServerEvent('wild-trainer:registerVehicle', {
            ['plate'] = licensePlate,
            ['networkID'] = 0,
            ['model'] = aircraftSelection.model,
            ['type'] = 2,
            ['colorPrimary'] = primary,
            ['colorSecondary'] = secondary,
            ['pos'] = {
                ['x'] = devonsHanger.delivery.x, ['y'] = devonsHanger.delivery.y, ['z'] = devonsHanger.delivery.z, ['h'] = devonsHanger.delivery.h
            },
            ['body'] = bodyHealth,
            ['engine'] = engineHealth,
            ['fuel'] = 100.0,
            ['used'] = aircraftSelection.used,
        })
        
        -- Delete preview
        DeleteEntity(previewModel)	
        previewModel = nil

        -- Close menu
        subMenu_buyAircraft:GoBack()
        aircraftMenu:GoBack()
	else
		PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
		ShowNotification("You can't afford this!")	
	end
end)
RegisterNetEvent("wild-trainer:cl_buyAircraft")

function SpawnAircraft( plate, aircraft )
	if activeAircraft~=nil and DoesEntityExist(activeAircraft.aircraft) then
		SetEntityAsMissionEntity(activeAircraft.aircraft, true, true)
		DeleteVehicle(activeAircraft.aircraft)
        DeleteEntity(activeAircraft.aircraft)
        RemoveBlip(activeAircraft.blip)
    end

    
    ClearArea(devonsHanger.delivery.x, devonsHanger.delivery.y, devonsHanger.delivery.z, 10.0, true, false, false, false)

	local model = GetHashKey(aircraft.model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)	
	end

    local veh = CreateVehicle(model, devonsHanger.delivery.x, devonsHanger.delivery.y, devonsHanger.delivery.z, devonsHanger.delivery.h, true, false)    
    
    RequestCollisionAtCoord(devonsHanger.delivery.x, devonsHanger.delivery.y, devonsHanger.delivery.z)
    while not HasCollisionLoadedAroundEntity(veh) do
        RequestCollisionAtCoord(devonsHanger.delivery.x, devonsHanger.delivery.y, devonsHanger.delivery.z)
        Citizen.Wait(0)
    end

	SetEntityAsMissionEntity(veh, true, false)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)	
	SetVehicleOnGroundProperly(veh)
    SetModelAsNoLongerNeeded(model)	   
    
    SetVehicleNumberPlateText(veh, plate)

	SetVehicleColours(veh, aircraft.colorPrimary, aircraft.colorSecondary)
	--SetVehicleBodyHealth(veh, aircraft.body+.0)
	--SetVehicleEngineHealth(veh, aircraft.engine+.0)
    SetVehicleFuelLevel(veh, aircraft.fuel)    
    
	-- Compatability for LegacyFuel resource
	DecorSetFloat(veh, "_FUEL_LEVEL", aircraft.fuel)
	
	-- Register as a WILD-TRAINER owned car
    DecorSetBool(veh, "_WILD_VEHICLE", true)
    
    activeAircraft = {['plate'] = plateNumber, ['aircraft'] = veh, ['blip'] = 0}

    AddBlipForActiveAircraft();

	-- Network sync
	
	NetworkRegisterEntityAsNetworked(veh)
	NetworkRequestControlOfEntity(veh)
	while not NetworkHasControlOfEntity(veh) do Wait(0) end
	
	local netCar = VehToNet(veh)
	SetNetworkIdExistsOnAllMachines(netCar, true)
	NetworkSetNetworkIdDynamic(netCar, false)
	SetNetworkIdCanMigrate(netCar, true)		

	TriggerServerEvent('wild-trainer:updateVehicleNetworkID', {
		['plate'] = plate,
        ['networkID'] = netCar,
        ['type'] = 2
	})    
end

function PreviewAircraft(model, name, price, used)
	aircraftSelection = {
		['model'] = model,
		['name'] = name,
		['price'] = price,
		['used'] = used,
    }
    
    aircraftNamePreview:Text(aircraftSelection.name)
	
	ClearArea(devonsHanger.spawn.x, devonsHanger.spawn.y, devonsHanger.spawn.z, 10.0, true, false, false, false)	
	
	if DoesEntityExist(previewModel) then
		print("Delete old preview model: "..tostring(previewModel))
		SetEntityAsMissionEntity(previewModel, true, true)
		DeleteVehicle(previewModel)		
		--DeleteEntity(previewModel)
	end
	
	local vehicle = GetHashKey(aircraftSelection.model)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)	
	end
	
	previewModel = CreateVehicle(vehicle, devonsHanger.spawn.x, devonsHanger.spawn.y, devonsHanger.spawn.z, devonsHanger.spawn.h, false, false)
	
	
	SetVehicleOnGroundProperly(previewModel)
	SetModelAsNoLongerNeeded(vehicle)	
	
	SetEntityAsNoLongerNeeded(previewModel)
	
	SetVehicleDoorsLockedForAllPlayers(previewModel, true)
	SetVehicleUndriveable(previewModel, true)
	SetVehicleIsConsideredByPlayer(previewModel, false)
	
	if not used then
		SetVehicleDirtLevel(previewModel, 0.0)
	else
		SetVehicleDirtLevel(previewModel, 15.0)
	end
	
	RefreshCarMenu()
end


-- Main logic/magic loop
Citizen.CreateThread(function()
    while true do Citizen.Wait(1)
        local interior = GetInteriorFromEntity(GetPlayerPed(-1))

        if interior==devonsHanger.id then
            DisplayHelpText("Press ~INPUT_CONTEXT~ To Manage Owned Aircraft")

            _aircraftPool:ProcessMenus()	

            if IsControlJustPressed(1,51) then
                RefreshAircraftMenu();
                aircraftMenu:Visible( true )
            end
        elseif _aircraftPool:IsAnyMenuOpen() then
            _aircraftPool:CloseAllMenus()
        end
        
    end
end)



function AddAircraftShopBlips()
	Citizen.CreateThread(function()	
		local hangerBlip = AddBlipForCoord(devonsHanger.x, devonsHanger.y, devonsHanger.z)
		SetBlipSprite(hangerBlip, 251)
		SetBlipDisplay(hangerBlip, 4)
		SetBlipScale(hangerBlip, 1.0)
		SetBlipColour(hangerBlip, 17)
		SetBlipAsShortRange(hangerBlip, true)		 
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Aircraft Dealer")
		EndTextCommandSetBlipName(hangerBlip)
	end)
end
AddAircraftShopBlips()