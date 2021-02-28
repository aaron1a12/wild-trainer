globalPlayerGarage = {}

--onGetGarage



local carCam = 0
local bIsCarMenuOpen = false


simeonsPlace = {
	['x'] = -38.11,  ['y'] = -1108.80,  ['z'] = 26.44,
	['id'] = 7170,
	['cam'] = {
		['x'] = -53.97,  ['y'] = -1093.95,  ['z'] = 26.50, ['h'] = 250.00							   
	},
	['spawn'] = {
		['x'] = -48.95,  ['y'] = -1095.44,  ['z'] = 26.42, ['h'] = 120.0							   
	},
	['delivery'] = {
		['x'] = -13.15,  ['y'] = -1090.84,  ['z'] = 26.67, ['h'] = 162.01							   
	}
}

carShops = {
	[234753] = { ['x'] = -356.81,  ['y'] = -134.26,  ['z'] = 38.92 },
	[153601] = { ['x'] = 723.013,  ['y'] = -1088.92,  ['z'] = 22.1829 },
	[164353] = { ['x'] = -1145.67,  ['y'] = -1991.17,  ['z'] = 13.162 },
	[201729] = { ['x'] = 1174.76,  ['y'] = 2645.46,  ['z'] = 37.7545 },
	[179457] = { ['x'] = 112.275,  ['y'] = 6619.83,  ['z'] = 31.8154 },
	[196609] = { ['x'] = -207.978,  ['y'] = -1309.64,  ['z'] = 31.2939 }
}

function AddBlips()
	Citizen.CreateThread(function()
		for _, carShopLocation in pairs(carShops) do
		  carShopLocation.blip = AddBlipForCoord(carShopLocation.x, carShopLocation.y, carShopLocation.z)
		  SetBlipSprite(carShopLocation.blip, 72)
		  SetBlipDisplay(carShopLocation.blip, 4)
		  SetBlipScale(carShopLocation.blip, 0.9)
		  SetBlipColour(carShopLocation.blip, 46)
		  SetBlipAsShortRange(carShopLocation.blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Auto Shop")
		  EndTextCommandSetBlipName(carShopLocation.blip)
		end
		
		local simeonBlip = AddBlipForCoord(simeonsPlace.x, simeonsPlace.y, simeonsPlace.z)
		SetBlipSprite(simeonBlip, 100)
		SetBlipDisplay(simeonBlip, 4)
		SetBlipScale(simeonBlip, 1.0)
		SetBlipColour(simeonBlip, 4)
		SetBlipAsShortRange(simeonBlip, true)		 
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Simeon's Auto Dealer")
		EndTextCommandSetBlipName(simeonBlip)
	end)
end

AddBlips()


Citizen.CreateThread(function()
	DecorRegister("_WILD_VEHICLE", 2)
	DecorRegister("_USED_VEHICLE", 2)
	DecorRegister("WildTrainer_BoostedCar", 2)
end)


_carMenuPool = NativeUI.CreatePool()
carMenu = NativeUI.CreateMenu("Simeon's", "~b~Buy Cars here!")

carModelNamePreview = UIMenuColouredItem.New("", "Current model", {0, 0, 0}, {0, 128, 128})
carModelNamePreview:SetLeftBadge(BadgeStyle.Car)
carMenu:AddItem(carModelNamePreview)

changeCarModelMenu = _carMenuPool:AddSubMenu(carMenu, "[ Change Model ]")

_carMenuPool:Add(carMenu)
_carMenuPool:RefreshIndex()



_autoMenuPool = NativeUI.CreatePool()
autoMenu = NativeUI.CreateMenu("AUTOSHOP", "~b~Buy autos here!")



--autoModelNamePreview = UIMenuColouredItem.New("", "Current model", {0, 0, 0}, {0, 128, 128})
--autoModelNamePreview:SetLeftBadge(BadgeStyle.auto)
--autoMenu:AddItem(autoModelNamePreview)

--changeCarModelMenu = _autoMenuPool:AddSubMenu(autoMenu, "[ Change Model ]")

_autoMenuPool:Add(autoMenu)
_autoMenuPool:RefreshIndex()

gtaVehicleEmergency = {
	{"police", "Vapid Police Cruiser", 0},
	{"sheriff", "Vapid Sheriff Cruiser", 0},
	{"police3", "Vapid Police Interceptor", 0},
	{"police4", "Vapid Unmarked Cruiser", 0},
	{"police2", "Bravado Police Buffalo", 0},
	{"fbi", "Bravado FIB Buffalo", 0},
	{"fbi2", "Declasse FIB Granger", 0},
	{"policet", "Declasse Police Transporter", 0},
	{"sheriff2", "Declasse Sheriff SUV", 0},
	{"policeb", "Western Police Bike", 0},
	{"hwaycar", "Ford Crown Victoria", 0},
	{"hwaycar7", "Ford Crown Victoria", 0},
}

gtaVehicleBicycles = {
	{"tribike2", "Endurex Race Bike", 5999},
	{"tribike", "Whippet Race Bike", 5999},
	{"tribike3", "Tri-Cycles Race Bike", 5999},
	{"scorcher", "Scorcher", 99},
	{"bmx", "BMX", 89},
	{"cruiser", "Cruiser", 98},
	{"fixter", "Fixter", 299},
}

gtaVehicleMuscle = {
	{"gauntlet", "Bravado Gauntlet", 25000},
	{"picador", "Cheval Picador", 10000},
	{"dominator", "Vapid Dominator", 30000},
	{"dominator3", "Vapid Dominator GTX", 35000},
	{"michelli", "Lampadati Michelli GT", 15000},
}

gtaVehicleSedans = {
	{"primo", "Albany Primo", 9000},
	{"primo2", "Albany Primo Custom", 19000},
	{"washington", "Albany Washington", 15000},
	{"schafter2", "Benefactor Schafter", 65000},
	{"romero", "Chariot Romero Hearse", 45000},
	{"fugitive", "Cheval Fugitive", 24000},
	{"surge", "Cheval Surge", 35000},	
	{"asea", "Declasse Asea", 12000},
	{"premier", "Declasse Premier", 10000},
	{"stretch", "Dundreary Stretch", 30000},
	{"cognoscenti", "Enus Cognoscenti", 254000},
	{"cog55", "Enus Cognoscenti 55", 154000},
	{"superd", "Enus Super Diamond", 250000},
	{"windsor", "Enus Windsor", 310000},
	{"windsor2", "Enus Windsor Drop", 320000},
	{"ruiner", "Imponte Ruiner", 36500},	
	{"asterope", "Karin Asterope", 26000},
	{"intruder", "Lincoln Continental", 48600},
	{"tailgater", "Obey Tailgater", 55000},
	{"oracle", "Übermacht Oracle XS", 11000},
	{"oracle2", "Übermacht Oracle", 15000},
	{"sentinel", "Übermacht Sentinel", 22000},
	{"sentinel2", "Übermacht Sentinel", 26000},
	{"stanier", "Vapid Stanier", 10000},
	{"ingot", "Vulcar Ingot", 9000},
	{"stratum", "Zirconium Stratum", 10000},
}

gtaVehicleCompacts = {
	{"panto", "Benefactor Panto", 25000},
	--{"weevil", "BF Weevil", 19000},
	{"rhapsody", "Declasse Rhapsody", 25000},
	{"blista", "Dinka Blista", 24000},
	--{"kanjo", "Dinka Blista Kanjo", 15000}, THESE CARS ARE FUTURE DLC!!!
	--{"brioso2", "Grotti Brioso 300", 14000},
	{"dilettante", "Karin Dilettante", 14000},
	--{"asbo", "Maxwell Asbo", 9000},
	{"issi2", "Weeny Issi", 15000},
	{"issi3", "Weeny Issi Classic", 28000},
}

gtaVehiclePickup = {
	{"TowTruck", "Tow Truck", 23000},
	{"bison", "Bravado Bison", 25000},
	{"yosemite", "Declasse Yosemite", 32000},
	{"rebel2", "Karin Rebel", 10000},
	{"BobcatXL", "Vapid Bobcat XL", 15000},
	{"riata", "Vapid Riata", 30000},
	{"retinue", "Vapid Retinue", 29500},
	{"sadler", "Vapid Sadler", 15000},
	{"sandking", "Vapid Sandking XL", 35000},
	{"sandking2", "Vapid Sandking", 40000},
	{"slamvan", "Vapid SlamVan", 10000},
}

gtaVehicleSUVs = {
	{"cavalcade", "Albany Cavalcade", 60000},
	{"cavalcade2", "Albany Cavalcade II", 65000},
	{"gresley", "Bravado Gresley", 34000},
	{"serrano", "Benefactor Serrano", 60000},
	{"xls", "Benefactor XLS", 58000},
	{"mesa", "Canis Mesa", 15000},
	{"seminole", "Canis Seminole", 39000},
	{"landstalker", "Dundreary Landstalker", 58000},
	{"granger", "Declasse Granger", 43000},
	{"habanero", "Emperor Habanero", 42000},
	{"huntley", "Enus Huntley S", 64000},
	{"fq2", "Fathom FQ 2", 38000},
	{"baller", "Gallivanter Baller", 54000},
	{"baller2", "Gallivanter Baller II", 58000},
	{"baller3", "Gallivanter Baller LE", 60000},
	{"baller4", "Gallivanter Baller LE LWB", 74000},
	{"patriot", "Mammoth Patriot", 64000},
	{"patriot2", "Mammoth Patriot Limo", 68000},
	{"rocoto", "Obey Rocoto", 75000},
	{"radi", "Vapid Radius", 32000},
}

gtaVehicleSports = {
	{"alpha", "Albany Alpha", 65000},
	{"elegy", "Annis Elegy Retro Custom", 149990},
	{"elegy2", "Annis Elegy RH8", 95000},
	{"feltzer2", "Benefactor Feltzer", 205000},
	{"banshee", "Bravado Banshee", 105000},
	{"banshee2", "Bravado Banshee 900R", 199500},
	{"buffalo", "Bravado Buffalo", 35000},
	{"buffalo2", "Bravado Buffalo S", 96000},
	{"raiden", "Coil Raiden", 94500},
	{"jester", "Dinka Jester", 240000},
	{"exemplar", "Dewbauchee Exemplar", 170000},
	{"rapidgt", "Dewbauchee Rapid GT", 140000},
	{"rapidgt2", "Dewbauchee Rapid GT Convertible", 150000},
	{"carbonizzare", "Grotti Carbonizzare", 195000},
	{"ninef", "Obey 9F", 100000},
	{"ninef2", "Obey 9F Cabrio", 110000},
	{"comet2", "Pfister Comet", 85000},
	{"comet3", "Pfister Comet Retro Custom", 645000},
	{"comet4", "Pfister Comet Safari", 710000},
	{"comet5", "Pfister Comet SR", 1145000},
	{"neon", "Pfister Neon", 135000},
}

gtaVehicleRacing = {
	{"buffalo3", "Bravado Buffalo", 535000},
	{"gauntlet2", "Bravado Gauntlet", 250000},
	{"jester2", "Dinka Jester", 350000},
	{"stalion2", "Declasse Stallion", 270000},
	{"dominator2", "Vapid Dominator", 315000},
}

gtaVehicleSuper = {
	{"adder", "Bugatti Chiron", 1500000},
	{"nero", "Truffade Nero", 2500000},
	{"nero2", "Truffade Nero Custom", 2700000},
	{"turismor", "Grotti Turismo R", 820000},
	{"infernus", "Pegassi Infernus", 350000},
	{"osiris", "Pegassi Osiris", 850000},
	{"reaper", "Pegassi Reaper", 320000},
	{"tempesta", "Pegassi Tempesta", 250000},
	{"zentorno", "Pegassi Zentorno", 850000},
	{"bullet", "Vapid Bullet", 195000},
	{"sc1", "Ubermacht SC1", 275000},
}

gtaVehicleVintage = {
	{"buccaneer", "Albany Buccaneer", 32000},
	{"emperor", "Albany Emperor", 34000},
	{"btype", "Albany Roosevelt", 45000},
	{"btype3", "Albany Roosevelt Custom", 45000},
	{"glendale", "Benefactor Glendale", 72500},
	{"feltzer3", "Benefactor Stirling GT", 1150000},
	{"youga2", "Bravado Youga Classic", 15200},
	{"impaler", "Declasse Impaler", 34500},
	{"tornado", "Declasse Tornado", 30000},
	{"tornado2", "Declasse Tornado Convertible", 32000},
	{"tulip", "Declasse Tulip", 34000},
	{"jb700", "Dewbauchee JB700", 450000},
	{"regina", "Dundreary Regina", 9000},
	{"stafford", "Enus Stafford", 90000},
	{"gt500", "Grotti GT500", 10000000},
	{"coquette3", "Invetero Coquette BlackFin", 64000},
	{"coquette2", "Invetero Coquette Classic", 67000},
	{"coquette", "Invetero Coquette", 70000},
	{"casco", "Lampadati Casco", 260000},
	{"cheburek", "Rune Cheburek", 7000},
	{"clique", "Vapid Clique", 34000},
	{"peyote", "Vapid Peyote", 17000},
	{"fagaloa", "Vulcar Fagaloa", 100000},
	{"warrener", "Vulcar Warrener", 60000},
	{"issi3", "Weeny Issi Classic", 10000},
}

gtaVehicleUsed = {
	{"emperor2", "Albany Emperor Classic", 500},
	{"asea", "Declasse Asea", 6000},
	{"regina", "Dundreary Regina", 4200},
	{"tornado3", "Declasse Tornado", 3500},
	{"rebel", "Karin Rebel", 4000},
}

function IsEmergencyVehicle(veh)
	local model = GetEntityModel(veh)
	local bFoundModel = false
	
	for i = 1, #gtaVehicleEmergency do		
		if model == GetHashKey(gtaVehicleEmergency[i][1]) then
			bFoundModel = true
			break
		end
	end
	
	return bFoundModel
end

function CalculateEngineRepairCost(veh)
	if IsEmergencyVehicle(veh) and ESX.PlayerData.job.name=="police" then
		return 0
	end

	local fullCost = 20000
	local cost = math.ceil(((100-(GetVehicleEngineHealth(veh)/1000)*100)*fullCost)/100)
	local exponentialCost = math.ceil(((math.pow(cost,2)/math.pow(fullCost,2)*100)*fullCost)/100)
	
	if exponentialCost < 100 then
		return 100
	else
		return  exponentialCost
	end
end

function CalculateCosmeticRepairCost(veh)
	if IsEmergencyVehicle(veh) and ESX.PlayerData.job.name=="police" then
		return 0
	end
		
	local fullCost = 2000
	local cost = math.ceil(((100-(GetEntityHealth(veh)/1000)*100)*fullCost)/100)	
	
	if cost < 50 then
		return 50
	else
		return cost
	end	
end

function GetVehicleScrapValue(fullValue)
	-- Hardcoded min and max values of vehicles
	print(fullValue)
	local min = 200
	local max = 30000

	-- Min and max scrap prices
	local maxScrapPrice = 2000
	local minScrapPrice = 200

	return math.floor(
		minScrapPrice+(maxScrapPrice-minScrapPrice)/100*((fullValue - min) / (max - min)*100)
	)
end

function GetVehicleValue(veh)
	local value = 0
	local model = GetEntityModel(veh)
	
	local devalue = 1.5
	
	if not DecorExistOn(veh, "_WILD_VEHICLE") then
		devalue = 10.0
	end
	
	local bFoundModel = false
	local cost = 500

	if not bFoundModel then
		for i = 1, #gtaVehicleBicycles do		
			if model == GetHashKey(gtaVehicleBicycles[i][1]) then
				bFoundModel = true
				cost = gtaVehicleBicycles[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehicleMuscle do		
			if model == GetHashKey(gtaVehicleMuscle[i][1]) then
				bFoundModel = true
				cost = gtaVehicleMuscle[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehiclePickup do		
			if model == GetHashKey(gtaVehiclePickup[i][1]) then
				bFoundModel = true
				cost = gtaVehiclePickup[i][3]
				break
			end
		end	
	end	
	
	if not bFoundModel then
		for i = 1, #gtaVehicleRacing do		
			if model == GetHashKey(gtaVehicleRacing[i][1]) then
				bFoundModel = true
				cost = gtaVehicleRacing[i][3]
				break
			end
		end	
	end		
		
	if not bFoundModel then
		for i = 1, #gtaVehicleSedans do		
			if model == GetHashKey(gtaVehicleSedans[i][1]) then
				bFoundModel = true
				cost = gtaVehicleSedans[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehicleCompacts do		
			if model == GetHashKey(gtaVehicleCompacts[i][1]) then
				bFoundModel = true
				cost = gtaVehicleCompacts[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehicleSports do		
			if model == GetHashKey(gtaVehicleSports[i][1]) then
				bFoundModel = true
				cost = gtaVehicleSports[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehicleSuper do		
			if model == GetHashKey(gtaVehicleSuper[i][1]) then
				bFoundModel = true
				cost = gtaVehicleSuper[i][3]
				break
			end
		end	
	end		
	
	if not bFoundModel then
		for i = 1, #gtaVehicleVintage do		
			if model == GetHashKey(gtaVehicleVintage[i][1]) then
				bFoundModel = true
				cost = gtaVehicleVintage[i][3]
				break
			end
		end	
	end
	
	if not bFoundModel then
		for i = 1, #gtaVehicleVintage do		
			if model == GetHashKey(gtaVehicleVintage[i][1]) then
				bFoundModel = true
				cost = gtaVehicleVintage[i][3]
				break
			end
		end	
	end		
	
	if not bFoundModel then
		for i = 1, #gtaVehicleUsed do		
			if model == GetHashKey(gtaVehicleUsed[i][1]) then
				bFoundModel = true
				cost = gtaVehicleUsed[i][3]
				break
			end
		end	
	end		
	
	value = (cost/devalue) - CalculateEngineRepairCost(veh) - CalculateCosmeticRepairCost(veh)
	
	if value < 200 then value = 200	end
	
	return math.floor(value)
end

local uiRepairCar = nil
local uiRepairCarEngine = nil
local uiSubMenuPaintJob = nil
local uiPrimaryColorSlider = nil
local uiSecondaryColorSlider = nil
local uiBuyPaintJob = nil

local playerVeh = nil
local prevPrimaryColor = 0;
local prevSecondaryColor = 0;

function ResetColors()
	SetVehicleColours(playerVeh, prevPrimaryColor, prevSecondaryColor)
end

function RefreshAutoMenu()
	autoMenu:Clear()
	
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	playerVeh = veh
	
	local cosmeticCost = CalculateCosmeticRepairCost(veh)
	local engineCost = CalculateEngineRepairCost(veh)
	local vehicleValue = GetVehicleValue(veh)
	local scrapValue = GetVehicleScrapValue(vehicleValue)
	
	-- Paint Job
	prevPrimaryColor, prevSecondaryColor = GetVehicleColours(veh)

	uiSubMenuPaintJob = _autoMenuPool:AddSubMenu(autoMenu, "» Paint Job")

    local amount = {}
    for i = 1, 160 do amount[i] = i end
	uiPrimaryColorSlider = UIMenuSliderItem.New("Primary Color", amount, 1, false)	
	uiSubMenuPaintJob:AddItem(uiPrimaryColorSlider)

	uiSecondaryColorSlider = UIMenuSliderItem.New("Secondary Color", amount, 1, false)	
	uiSubMenuPaintJob:AddItem(uiSecondaryColorSlider)

	uiSubMenuPaintJob.OnSliderChange = function(sender, item, index)
        if item == uiPrimaryColorSlider or item == uiSecondaryColorSlider then
			newColor = item:IndexToItem(index) - 1 -- Real range is 0-159 not 1-160
			local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local primary, secondary = GetVehicleColours(veh)

			if item == uiPrimaryColorSlider then
				SetVehicleColours(veh, newColor, secondary)
			else
				SetVehicleColours(veh, primary, newColor)
			end
		end
	end

	uiSubMenuPaintJob.OnItemSelect = function(sender, item, index)
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		local money = ESX.PlayerData.money

		if item == uiBuyPaintJob then

			if money < 499 then
				PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				ShowNotification("You can't afford this!")
			else
				ShowNotification("BUY PAINT")

				TriggerServerEvent('wild-trainer:removeMoney', 499)
				PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)

				local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local primary, secondary = GetVehicleColours(veh)

				-- Don't let ResetColors() reset again!
				prevPrimaryColor = primary
				prevSecondaryColor = secondary

				-- Save in DB
				TriggerServerEvent('wild-trainer:updateVehicleCust', GetVehicleNumberPlateText(veh), {
					['colorPrimary'] = primary,
					['colorSecondary'] = secondary		
				})			
			end

		end		
	end

	uiBuyPaintJob = NativeUI.CreateItem("Confirm Paint Job", "")
	uiBuyPaintJob:RightLabel("$"..comma_value(tonumber(499)), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
	uiSubMenuPaintJob:AddItem(uiBuyPaintJob)

	-- End Paint Job
	
	if GetEntityHealth(veh) < 1000 then
		uiRepairCar = NativeUI.CreateItem("Repair Vehicle Appearance", "")
		uiRepairCar:RightLabel("$"..comma_value(cosmeticCost), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
		autoMenu:AddItem(uiRepairCar)
	end
	
	if GetVehicleEngineHealth(veh) < 1000 then
		uiRepairCarEngine = NativeUI.CreateItem("Repair Vehicle Engine", "")
		uiRepairCarEngine:RightLabel("$"..comma_value(engineCost), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
		autoMenu:AddItem(uiRepairCarEngine)	
	end
	
	local uiScrapCar = NativeUI.CreateItem("Scrap Vehicle", "")
	uiScrapCar:RightLabel("$"..comma_value(scrapValue), {R = 100, G = 200, B = 100, A = 255},  {R = 0, G = 60, B = 0, A = 255})	
	autoMenu:AddItem(uiScrapCar)
	
	local uiSellCar = nil
	
	if DecorExistOn(veh, "_WILD_VEHICLE") then
		uiSellCar = NativeUI.CreateItem("Sell Vehicle", "")
	elseif vehicleValue > 4000 and ESX.PlayerData.job.name~="police" then
		uiSellCar = NativeUI.CreateItem("Sell Vehicle (Illegal)", "")
	end
	
	if uiSellCar ~= nil then
		uiSellCar:RightLabel("$"..comma_value(vehicleValue), {R = 100, G = 200, B = 100, A = 255},  {R = 0, G = 60, B = 0, A = 255})	
		autoMenu:AddItem(uiSellCar)	
	end

    autoMenu.OnItemSelect = function(sender, item, index)
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local cosmeticCost = CalculateCosmeticRepairCost(veh)
		local engineCost = CalculateEngineRepairCost(veh)
		local vehicleValue = GetVehicleValue(veh)
		local scrapValue = GetVehicleScrapValue(vehicleValue)
		
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		local money = ESX.PlayerData.money
		
        if item == uiRepairCar then
			if money < cosmeticCost then
				PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				ShowNotification("You can't afford this!")
			else
				TriggerServerEvent('wild-trainer:removeMoney', cosmeticCost)
				PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
				
				local engineHealth = GetVehicleEngineHealth(veh)
				local fuelLevel = GetVehicleFuelLevel(veh)

				SetEntityHealth(veh, 1000.0)
				SetVehicleFixed(veh)
				
				SetVehicleEngineHealth(veh, engineHealth)
				SetVehicleFuelLevel(veh, fuelLevel)
				RefreshAutoMenu()
			end
        end
		
		
        if item == uiRepairCarEngine then
			if money < engineCost then
				PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				ShowNotification("You can't afford this!")
			else
				TriggerServerEvent('wild-trainer:removeMoney', engineCost)
				PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
				
				SetVehicleEngineHealth(veh, 1000.0)
				RefreshAutoMenu()
			end
        end		

		if item == uiScrapCar or (item == uiSellCar and DecorExistOn(veh, "_WILD_VEHICLE")) then			
			CloseCarMenu()
			
			if DecorExistOn(veh, "_WILD_VEHICLE") then
				TriggerServerEvent('wild-trainer:unregisterVehicle', GetVehicleNumberPlateText(veh))
			end			
			
			TaskLeaveVehicle(GetPlayerPed(-1), veh, 0)	
			
			autoMenu:Visible( false )
			
			Citizen.Wait(2000)
			
			autoMenu:Visible( false )
			
			DeleteEntity(veh)	


			PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
			
			if item == uiScrapCar then
				TriggerServerEvent('wild-trainer:addMoney', scrapValue)
			else
				TriggerServerEvent('wild-trainer:addMoney', vehicleValue)
			end
			
			RefreshAutoMenu()
        elseif item == uiSellCar and not DecorExistOn(veh, "_WILD_VEHICLE") then
			autoMenu:Visible( false )
			
			StartVehicleDeliveryMission(GetVehiclePedIsIn(PlayerPedId(), false))
		end
		
    end
end




local carSelection = {
	['model'] = gtaVehicleSedans[1][1],
	['name'] = gtaVehicleSedans[1][2],
	['price'] = gtaVehicleSedans[1][3],
	['used'] = false,
}

local previewModel = nil

function PreviewCar(model, name, price, used)
	carSelection = {
		['model'] = model,
		['name'] = name,
		['price'] = price,
		['used'] = used,
	}
	
	ClearArea(simeonsPlace.spawn.x, simeonsPlace.spawn.y, simeonsPlace.spawn.z, 10.0, true, false, false, false)	
	
	if DoesEntityExist(previewModel) then
		print("Delete old preview model: "..tostring(previewModel))
		SetEntityAsMissionEntity(previewModel, true, true)
		DeleteVehicle(previewModel)		
		--DeleteEntity(previewModel)
	end
	
	local vehicle = GetHashKey(carSelection.model)
	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Wait(1)	
	end
	
	previewModel = CreateVehicle(vehicle, simeonsPlace.spawn.x, simeonsPlace.spawn.y, simeonsPlace.spawn.z, simeonsPlace.spawn.h, false, false)
	
	
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

local activeTrailer = nil

function MissionText(text,time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(text)
	DrawSubtitleTimed(time, 1)
end

local bIsRunningCarMission = false
local bIsDrivingToCarMission = false
local missionCar = nil
local smugglerTruck = nil
local smugglerTrailer = nil
local smugglerPed = nil
local smugglerBlip = nil
local bIsCarInTruck = false
local smugglerSpawnID = 0
local hornFrame = 0

function StartVehicleDeliveryMission( veh )
	if bIsRunningCarMission then ShowNotification("Finish your deal first.") return end
	
	TriggerServerEvent("wild-trainer:findCarSmuggler")
end

function IsVehicleInsideTrailer(veh, trailer)
end

function ShowGiantText()
	local timeShown = 0
	local alpha = 255
	local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
		
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(1)	
	end		

	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	BeginTextComponent("STRING")
	AddTextComponentString("~b~SOLD!")
	EndTextComponent()
	PopScaleformMovieFunctionVoid()


	PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)	
	PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
	
	Citizen.CreateThread(function()
		while true do Citizen.Wait(0)
		  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, alpha)
		  
		  alpha = alpha - 1
		  timeShown = timeShown + 1
		  
		  
		  if timeShown > 200 then break end
		end
	end)
end


function EndVehicleDeliveryMission()
	bIsRunningCarMission = false
	
	bIsCarInTruck = false
	
	RemoveBlip(smugglerBlip)
	
	SetEntityAsNoLongerNeeded(smugglerTruck)
	SetEntityAsNoLongerNeeded(smugglerTrailer)
	SetEntityAsNoLongerNeeded(smugglerPed)

	TriggerServerEvent("wild-trainer:lockCarSmuggler", smugglerID, false)
end

-- Server triggered event when anyone spawns
AddEventHandler("cl_playerSpawned", function(spawn)
	EndVehicleDeliveryMission()
end)

AddEventHandler("wild-trainer:cl_foundCarSmuggler", function(bFound, smugglerID, smuggler)
	if bFound and IsPedInAnyVehicle(PlayerPedId()) then
		bIsRunningCarMission = true
		
		
		
		TriggerServerEvent("wild-trainer:lockCarSmuggler", smugglerID, true)
		smugglerSpawnID = smugglerID
		
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		
		missionCar = veh
		--DecorSetBool(veh, "WildTrainer_BoostedCar", true)
		
		--SetNewWaypoint(smuggler.x, smuggler.y)
		
		bIsDrivingToCarMission = true
		
		--//// The smuggler ////
		ClearArea(smuggler.x, smuggler.y, smuggler.z, 10.0, true, false, false, false)
		
		local truckModel = LoadModel("hauler")
		smugglerTruck = CreateVehicle(truckModel, smuggler.x, smuggler.y, smuggler.z, smuggler.h, true, false)
		SetEntityAsMissionEntity(smugglerTruck, true, true)
		
		local trailerModel = LoadModel("Trailers3")   --tr2
		smugglerTrailer = CreateVehicle(trailerModel, smuggler.x, smuggler.y, smuggler.z, smuggler.h, 0.0, true, false)	
		SetEntityAsMissionEntity(smugglerTrailer, true, true)

		-- 2021 Changes: Collision fix?
		RequestCollisionAtCoord(smuggler.x, smuggler.y, smuggler.z)
		while not HasCollisionLoadedAroundEntity(smugglerTrailer) do
			RequestCollisionAtCoord(smuggler.x, smuggler.y, smuggler.z)
			Citizen.Wait(0)
		end
		
		local netTrailer = NetworkGetNetworkIdFromEntity(smugglerTrailer)
		SetNetworkIdExistsOnAllMachines(netTrailer, true)
		NetworkSetNetworkIdDynamic(netTrailer, false)
		SetNetworkIdCanMigrate(netTrailer, true)
		NetworkRegisterEntityAsNetworked(smugglerTrailer) 		
		
		ReleaseModel(truckModel)
		ReleaseModel(trailerModel)
		
		SetVehicleOnGroundProperly(smugglerTruck)
		AttachVehicleToTrailer(smugglerTruck, smugglerTrailer, 1065353216)
		N_0x95cf53b3d687f9fa(smugglerTruck)
		
		--SetVehicleDoorsLockedForAllPlayers(smugglerTruck, true)
		SetVehicleIsConsideredByPlayer(smugglerTruck, false)
		
		
		local smugglerModel = LoadModel("a_m_y_latino_01")
		
		smugglerPed = CreatePedInsideVehicle(smugglerTruck, 4, smugglerModel, -1, true, false)
		SetEntityAsMissionEntity(smugglerPed, true, true)		
		
		ReleaseModel(smugglerModel)
	
		smugglerBlip = AddBlipForEntity(smugglerTrailer)
		SetBlipRoute(smugglerBlip, true) 
		
		SetBlipSprite(smugglerBlip, 545)
		SetBlipColour(smugglerBlip, 38)
		SetBlipRouteColour(smugglerBlip, 38)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Car Smuggler")
		EndTextCommandSetBlipName(smugglerBlip)		
		
		SetVehicleDoorOpen(smugglerTrailer, 5, 0, 0);		
		
		
		Citizen.CreateThread(function()
			while true do Wait(1)
				local CoB = GetOffsetFromEntityInWorldCoords(smugglerTrailer, 0.0, -1.0, -2.0)
				
				local markerSize = {x = 1.0, y = 1.0, z = 1.0}
				local markerColor = {r = 0, g = 255, b = 255, a = 25}
				DrawMarker(36, CoB.x, CoB.y, CoB.z+1.8, 0.0, 0.0, 0.0, 0, 0.0, 0.0, markerSize.x, markerSize.y, markerSize.z, markerColor.r, markerColor.g, markerColor.b, markerColor.a, true, true, 2, false, false, false, false)
				
				if bIsCarInTruck then break end 
				if not bIsRunningCarMission then break end 
			end
		end)
		
		-- Safe Checking
		Citizen.CreateThread(function()
			while true do Wait(1000)
			
				local bCancelMission = false

				if DoesEntityExist(missionCar) and DoesEntityExist(smugglerTruck) and DoesEntityExist(smugglerTrailer) and DoesEntityExist(smugglerPed) then
					if IsPedDeadOrDying(smugglerPed, 1) or not IsPedInAnyVehicle(smugglerPed, false) or not IsVehicleAttachedToTrailer(smugglerTruck) or IsEntityDead(smugglerTruck) or IsEntityDead(missionCar) then
						bCancelMission = true
					end
				else
					bCancelMission = true
				end

				if bCancelMission then
					EndVehicleDeliveryMission()
				end

				if not bIsRunningCarMission then break end 
			end
		end)		
		
		
		
		Citizen.CreateThread(function()
			while true do Wait(1000)
			
				local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), smuggler.x, smuggler.y, smuggler.z, false)
				
				if dist < 50 then
					bIsDrivingToCarMission = false
					--//// Close to smuggler ////
					
					Citizen.CreateThread(function()
						while true do Wait(500)
	

							local coords = GetEntityCoords(missionCar)	
							local CoB = GetOffsetFromEntityInWorldCoords(smugglerTrailer, 0.0, -1.0, 0.0)
							
							local dist = GetDistanceBetweenCoords(CoB, coords)
							
							

							if IsEntityAtEntity(missionCar, smugglerTrailer, 2.0, 6.0, 1.5, 0, 1, 0) then								
								bIsCarInTruck = true
								if IsPedInAnyVehicle(PlayerPedId()) then
									MissionText("Leave the ~b~vehicle~w~ to complete the delivery.", 500)
								elseif IsEntityAtEntity(PlayerPedId(), smugglerTrailer, 3.0, 8.0, 20.0, 0, 1, 0) then	
									MissionText("Please leave the truck.", 500)
									
									
									Citizen.CreateThread(function()
										while true do Wait(0)
											
											hornFrame = hornFrame + 1
											
											if hornFrame < 200 then
												SoundVehicleHornThisFrame(smugglerTruck)
											end
											
											if hornFrame > 200 then break end
											if not bIsRunningCarMission then break end
										end
									end)
									
									SetVehicleEngineOn(missionCar, false, true, false)
									SetVehicleEngineOn(smugglerTruck, true, true, false)
								else
									-- SOLD!!!!!!!
									
									bIsRunningCarMission = false
									
									bIsCarInTruck = false
									
									Citizen.Wait(2000)
									
									SetVehicleDoorShut(smugglerTrailer, 5, 1)
									
									local carValue = GetVehicleValue(missionCar)
									
									if DecorExistOn(missionCar, "_WILD_VEHICLE") then
										TriggerServerEvent('wild-trainer:unregisterVehicle', GetVehicleNumberPlateText(missionCar))
									end	
									
									TriggerServerEvent("wild-trainer:deleteVehicle", VehToNet(missionCar))
									
									RemoveBlip(smugglerBlip)
									
									--TaskVehicleDriveWander(smugglerPed, smugglerTruck, 26.0, 0)
									--local switchToCoords = vector3(129.063, 6616.838, 31.827)
									--TaskVehicleDriveToCoord(smugglerPed, smugglerTruck, 129.063, 6616.838, 31.827, 26.0, 0, GetEntityModel(smugglerTruck), 411, 10.0)
									TaskVehicleDriveWander(smugglerPed, smugglerTruck, 20.0, 0)
							
									SetEntityAsNoLongerNeeded(smugglerTruck)
									SetEntityAsNoLongerNeeded(smugglerTrailer)
									SetEntityAsNoLongerNeeded(smugglerPed)
									
									
									
									
									ShowGiantText()
									
									Citizen.Wait(3000)
									
									PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
									TriggerServerEvent('wild-trainer:addMoney', carValue)
									
									Citizen.Wait(5000)
									
									
									
									TriggerServerEvent("wild-trainer:lockCarSmuggler", smugglerID, false)
								end
							else
							
								if IsPedInAnyVehicle(PlayerPedId()) then
									MissionText("Park the ~b~vehicle~w~ in the truck's trailer.", 500)
								else	
									MissionText("Get back into the ~b~vehicle~w~.", 500)
								end
							end

							
							if not bIsRunningCarMission then break end
						end
					end)					
					--///////////////////////////
				else
					MissionText("Deliver the ~b~vehicle~w~. Don't damage it.", 1000)
				end
				
				if not bIsDrivingToCarMission then break end
				if not bIsRunningCarMission then break end
			end
		end)
	else
		ShowNotification("A buyer could not be located for your vehicle at this time.")
	end
end)
RegisterNetEvent("wild-trainer:cl_foundCarSmuggler")



Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustPressed (1, 10) then
			--SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("AMBIENT_GANG_BALLAS")
			
			--DisablePostNukeWorld()
			--StopBlackOut()

		end
			
		if IsControlJustPressed (1, 11) then
			--StartBlackOut()
			--EnablePostNukeWorld()		
			--ShowNotification("Spawn?")
			
			if IsPedInAnyVehicle(PlayerPedId()) then
				--StartVehicleDeliveryMission()
			end
			
			
		end
	end
end)

iPlayerCar = nil 
playerCarBlip = nil

function BuyCar()	
	-- Generate a new license plate
	local licensePlate = randomString(8)
	-- Save colors
	local primary, secondary = GetVehicleColours(previewModel)
	
	local bodyHealth = 1000.0
	local engineHealth = 1000.0
	
	if carSelection.used then
		bodyHealth = math.random(400.0, 900.0) 
		math.randomseed(GetGameTimer()+1)
		engineHealth = math.random(400.0, 900.0)
	end
	
	TriggerServerEvent('wild-trainer:registerVehicle', {
		['plate'] = licensePlate,
		['networkID'] = netCar,
		['model'] = carSelection.model,
		['type'] = 1,
		['colorPrimary'] = primary,
		['colorSecondary'] = secondary,
		['pos'] = {
			['x'] = simeonsPlace.delivery.x, ['y'] = simeonsPlace.delivery.y, ['z'] = simeonsPlace.delivery.z, ['h'] = simeonsPlace.delivery.h
		},
		['body'] = bodyHealth,
		['engine'] = engineHealth,
		['fuel'] = 100.0,
		['used'] = carSelection.used,
	})
	
	DeleteEntity(previewModel)	
	previewModel = nil
	CloseCarMenu()
	
	ShowNotification("Your vehicle has been delivered behind the dealer. Thank you!")
end

AddEventHandler("wild-trainer:cl_registerVehicle", function(vehicle)
	local veh = NetToVeh( vehicle.networkID )
	
	if DoesEntityExist(veh) then
		local coords = GetEntityCoords(veh)
		WildPlayer.Vehicles[vehicle.plate] = {
			['networkID'] = vehicle.networkID,
			['blip'] = AddBlipForEntity(veh),
			['pos'] = {
				['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['h'] = GetEntityHeading(veh)
			},
			['body'] = 1000.0,
			['engine'] = 1000.0,
			['fuel'] = 100.0,		
		}
		
		--TriggerServerEvent('wild-trainer:saveWildPlayerData', json.encode(WildPlayer))	
		
	
		--if DoesEntityExist(iPlayerCar) then
		--	DeleteEntity(iPlayerCar)
		--	RemoveBlip(playerCarBlip)
		--end

		
		SetBlipSprite(WildPlayer.Vehicles[vehicle.plate].blip, 225) --143
		SetBlipColour(WildPlayer.Vehicles[vehicle.plate].blip, 24)
		SetEntityAsMissionEntity(veh, true, true)			
	end
end)
RegisterNetEvent("wild-trainer:cl_registerVehicle")

local activeVehicle = nil
local bIsDelivering = false
local activeDriver = nil

AddEventHandler("wild-trainer:cl_deletePlayerVehicles", function(vehicleTable)
	print("!!!!!!!!!!!!!!!!!! Player has left. Deleting his vehicles... ------------------")
	
	if vehicleTable ~= nil then

		print("Table is not nil")
	
		for plateNumber, vehicle in pairs(vehicleTable) do
			local netCar = NetToVeh( vehicle.networkID )

			if DoesEntityExist(netCar) then
				ShowNotification("Delete vehicle")
				DeleteEntity(netCar)
			end
		end
		
		if DoesEntityExist(activeDriver) then
			DeleteEntity(activeDriver)
		end	
	
	else
		ShowNotification("Table is nil! wtf")
	end
	
end)
RegisterNetEvent("wild-trainer:cl_deletePlayerVehicles")

AddEventHandler("wild-trainer:cl_getVehicleInfo", function(vehicleTable)	
	
	for plateNumber, vehicle in pairs(vehicleTable) do
		local netCar = NetToVeh( vehicle.networkID )
		
		if DoesEntityExist(netCar) then
			local coords = GetEntityCoords(netCar)
			local heading = GetEntityHeading(netCar)
			
			TriggerServerEvent('wild-trainer:updateVehicleInfo', {
				['plate'] = plateNumber,
				['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['h'] = heading,
				['body'] = GetVehicleBodyHealth(netCar),
				['engine'] = GetVehicleEngineHealth(netCar),
				['fuel'] = GetVehicleFuelLevel(netCar),				
			})			
		end
		
	end
end)
RegisterNetEvent("wild-trainer:cl_getVehicleInfo")




local function AddBlipForActiveVehicle()
	local blip = AddBlipForEntity(activeVehicle.veh)
	
	SetBlipSprite(blip, 225) --143
	SetBlipColour(blip, 24)		
	
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Registered Vehicle")
	EndTextCommandSetBlipName(blip)	
	
	activeVehicle.blip = blip
end

local pheading = nil
local parking = nil

local deliveryTimeout = 0

AddEventHandler("wild_blackout", function()
	if activeVehicle ~= nil then
		SetEntityAsNoLongerNeeded(activeVehicle.veh)
		TriggerServerEvent('wild-trainer:removeActiveVehicle', activeVehicle.plate)
		RemoveBlip(activeVehicle.blip)
	end
end)
--RegisterNetEvent('wild_blackout')

AddEventHandler("wild-trainer:cl_loadVehicle", function(plateNumber, vehicle, bDeliver)
	print("load vehicle!!!???->"..tostring(vehicle.engine))
	
	if bDeliver then		
		if bIsDelivering then
			SendNUIMessage({
				notificationTitle = 'Premium Deluxe Motorsport',
				notificationText = 'Delivery already in progress!',
				notificationIcon = 'app-car.png',
			})
			
			return
		else
			bIsDelivering = true
		end
	end
	
	print(plateNumber)
	
	if activeVehicle ~= nil then
	
		TriggerServerEvent('wild-trainer:removeActiveVehicle', activeVehicle.plate)
	
		if DoesEntityExist(activeVehicle.veh) then
			SetEntityAsNoLongerNeeded(activeVehicle.veh)
			DeleteEntity(activeVehicle.veh)
		end
		RemoveBlip(activeVehicle.blip)
	end
	
	ClearArea(vehicle.pos.x, vehicle.pos.y, vehicle.pos.z, 10.0, true, false, false, false)

	local model = GetHashKey(vehicle.model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)	
	end

	local veh = CreateVehicle(model, vehicle.pos.x, vehicle.pos.y, vehicle.pos.z, vehicle.pos.h, true, false)

	SetEntityAsMissionEntity(veh, true, false)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
	SetVehicleNeedsToBeHotwired(veh, false)	
	
	SetVehicleOnGroundProperly(veh)
	SetModelAsNoLongerNeeded(model)	
	
	RequestCollisionAtCoord(vehicle.pos.x, vehicle.pos.y, vehicle.pos.z)
	while not HasCollisionLoadedAroundEntity(veh) do
		RequestCollisionAtCoord(vehicle.pos.x, vehicle.pos.y, vehicle.pos.z)
		Citizen.Wait(0)
	end	

	SetVehicleNumberPlateText(veh, plateNumber)
	SetVehicleColours(veh, vehicle.colorPrimary, vehicle.colorSecondary)
	SetVehicleBodyHealth(veh, vehicle.body+.0)
	SetVehicleEngineHealth(veh, vehicle.engine+.0)
	SetVehicleFuelLevel(veh, vehicle.fuel)
	
	SetEntityOnlyDamagedByPlayer(veh, true)
	--SetEntityHealth(veh, vehicle.body)
	
	-- Compatability for LegacyFuel resource
	DecorSetFloat(veh, "_FUEL_LEVEL", vehicle.fuel)
	
	-- Register as a WILD-TRAINER owned car
	DecorSetBool(veh, "_WILD_VEHICLE", true)
	
	activeVehicle = {['plate'] = plateNumber, ['veh'] = veh, ['blip'] = blip}
	
	if not vehicle.used then
		SetVehicleDirtLevel(veh, 0.0)
	else
		SetVehicleDirtLevel(veh, 15.0)
		DecorSetBool(veh, "_USED_VEHICLE", true)
	end	
	
	-- Network sync
	
	NetworkRegisterEntityAsNetworked(veh)
	NetworkRequestControlOfEntity(veh)
	while not NetworkHasControlOfEntity(veh) do Wait(0) end
	
	local netCar = VehToNet(veh)
	SetNetworkIdExistsOnAllMachines(netCar, true)
	NetworkSetNetworkIdDynamic(netCar, false)
	SetNetworkIdCanMigrate(netCar, true)		

	TriggerServerEvent('wild-trainer:updateVehicleNetworkID', {
		['plate'] = plateNumber,
		['networkID'] = netCar,
		['type'] = 1
	})
	
	--AddBlipForActiveVehicle()
	
	if not bDeliver then
		AddBlipForActiveVehicle()
	else
	
		Citizen.CreateThread(function()
			while true do Citizen.Wait(1000)
				deliveryTimeout = deliveryTimeout + 1
				local vehCoords = GetEntityCoords(activeVehicle.veh)
				local dist = GetDistanceBetweenCoords(parking, vehCoords)
				
				if dist < 10 or deliveryTimeout > 20 then
					bIsDelivering = false
					deliveryTimeout = 0
					
					AddBlipForActiveVehicle()

					TaskLeaveVehicle(activeDriver, activeVehicle.veh, 0)
					TaskWanderStandard(activeDriver, 10.0, 10)	
					SetEntityAsNoLongerNeeded(activeDriver)
					activeDriver = nil
					
					SendNUIMessage({
						notificationTitle = 'Premium Deluxe Motorsport',
						notificationText = 'Your vehicle has been delivered!',
						notificationIcon = 'app-car.png',
					})
					
					SetEntityOnlyDamagedByPlayer(veh, false)
					break
				end
			end
		end)	
		
		
		
		local model = "a_m_y_latino_01"

		RequestModel( GetHashKey( model ) )
		while ( not HasModelLoaded( GetHashKey( model ) ) ) do
			Citizen.Wait( 1 )
		end	

		activeDriver = CreatePedInsideVehicle(activeVehicle.veh, 4, model, -1, true, true)
		SetEntityAsMissionEntity(activeDriver, true, true)
		
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		
		pheading, parking = GetNthClosestVehicleNodeFavourDirection(playerCoords.x, playerCoords.y, playerCoords.z,  playerCoords.x, playerCoords.y, playerCoords.z, 2, 1, 0x40400000, 0)
		
		SetDriveTaskDrivingStyle(activeDriver, 2883621)
		
		--TaskVehicleDriveToCoord(activeDriver, activeVehicle.veh, parking.x, parking.y, parking.z, 26.0, 0, GetEntityModel(activeVehicle.veh), 411, 10.0)
		TaskVehicleDriveToCoord(activeDriver, activeVehicle.veh, parking.x, parking.y, parking.z, 26.0, 0, GetEntityModel(activeVehicle.veh), 2883621, 1.0, true)
		--TaskVehiclePark(activeDriver, activeVehicle.veh, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0, 5.0, true)
		--TaskVehiclePark(activeDriver, activeVehicle.veh, playerCoords.x, playerCoords.y, playerCoords.z, pheading, 1, 60.0, 1)
	end
end)
RegisterNetEvent("wild-trainer:cl_loadVehicle")

AddEventHandler("wild-trainer:cl_buyVehicle", function(bCanAfford)
	if bCanAfford then
		PlaySound(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 0, 0, 1)
		BuyCar()
	else
		PlaySound(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
		ShowNotification("You can't afford this!")	
	end
end)
RegisterNetEvent("wild-trainer:cl_buyVehicle")


--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleBicycles = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Bicycles")
function AddVehicleBicycles(menu)
	for _,carModel in ipairs(gtaVehicleBicycles) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleBicycles:AddItem(newItem)
	end
	
	subMenu_VehicleBicycles.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleBicycles[index][1], gtaVehicleBicycles[index][2], gtaVehicleBicycles[index][3], false)
	end
end
AddVehicleBicycles(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleMuscle = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Muscle")
function AddVehicleMuscle(menu)
	for _,carModel in ipairs(gtaVehicleMuscle) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleMuscle:AddItem(newItem)
	end
	
	subMenu_VehicleMuscle.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleMuscle[index][1], gtaVehicleMuscle[index][2], gtaVehicleMuscle[index][3], false)
	end
end
AddVehicleMuscle(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehiclePickup = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Pickup")
function AddVehiclePickup(menu)
	for _,carModel in ipairs(gtaVehiclePickup) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehiclePickup:AddItem(newItem)
	end
	
	subMenu_VehiclePickup.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehiclePickup[index][1], gtaVehiclePickup[index][2], gtaVehiclePickup[index][3], false)
	end
end
AddVehiclePickup(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleRacing = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Racing")
function AddVehicleRacing(menu)
	for _,carModel in ipairs(gtaVehicleRacing) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleRacing:AddItem(newItem)
	end
	
	subMenu_VehicleRacing.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleRacing[index][1], gtaVehicleRacing[index][2], gtaVehicleRacing[index][3], false)
	end
end
AddVehicleRacing(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleSedans = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Sedans")
function AddVehicleSedans(menu)
	for _,carModel in ipairs(gtaVehicleSedans) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleSedans:AddItem(newItem)
	end
	
	subMenu_VehicleSedans.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleSedans[index][1], gtaVehicleSedans[index][2], gtaVehicleSedans[index][3], false)
	end
end
AddVehicleSedans(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleCompacts = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Compacts")
function AddVehicleCompacts(menu)
	for _,carModel in ipairs(gtaVehicleCompacts) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleCompacts:AddItem(newItem)
	end
	
	subMenu_VehicleCompacts.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleCompacts[index][1], gtaVehicleCompacts[index][2], gtaVehicleCompacts[index][3], false)
	end
end
AddVehicleCompacts(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleSports = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Sports")
function AddVehicleSports(menu)
	for _,carModel in ipairs(gtaVehicleSports) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleSports:AddItem(newItem)
	end
	
	subMenu_VehicleSports.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleSports[index][1], gtaVehicleSports[index][2], gtaVehicleSports[index][3], false)
	end
end
AddVehicleSports(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleSuper = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Super")
function AddVehicleSuper(menu)
	for _,carModel in ipairs(gtaVehicleSuper) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleSuper:AddItem(newItem)
	end
	
	subMenu_VehicleSuper.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleSuper[index][1], gtaVehicleSuper[index][2], gtaVehicleSuper[index][3], false)
	end
end
AddVehicleSuper(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleVintage = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Vintage")
function AddVehicleVintage(menu)
	for _,carModel in ipairs(gtaVehicleVintage) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleVintage:AddItem(newItem)
	end
	
	subMenu_VehicleVintage.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleVintage[index][1], gtaVehicleVintage[index][2], gtaVehicleVintage[index][3], false)
	end
end
AddVehicleVintage(changeCarModelMenu)
--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleUsed = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Used Vehicles")
function AddVehicleUsed(menu)
	for _,carModel in ipairs(gtaVehicleUsed) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleUsed:AddItem(newItem)
	end
	
	subMenu_VehicleUsed.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleUsed[index][1], gtaVehicleUsed[index][2], gtaVehicleUsed[index][3], true)
	end
end
AddVehicleUsed(changeCarModelMenu)

--//////////////////////////////////////////////////////////////////////////////
subMenu_VehicleEmergency = _carMenuPool:AddSubMenu(changeCarModelMenu, "» Emergency")
function AddVehicleEmergency(menu)
	for _,carModel in ipairs(gtaVehicleEmergency) do
		local newItem = NativeUI.CreateItem(carModel[2], 'Retail Price: $'..comma_value(tonumber(carModel[3])))
		subMenu_VehicleEmergency:AddItem(newItem)
	end
	
	subMenu_VehicleEmergency.OnItemSelect = function(sender, item, index)
		PreviewCar(gtaVehicleEmergency[index][1], gtaVehicleEmergency[index][2], gtaVehicleEmergency[index][3], false)
	end
end
AddVehicleEmergency(changeCarModelMenu)

--//////////////////////////////////////////////////////////////////////////////

--//////////// BUYING CAR

local carSpawnPoint = nil
local carHeading = 0.0

local uiBuyCar = UIMenuColouredItem.New("Buy Vehicle", "", {0, 0, 0}, {0, 128, 128})
carMenu:AddItem(uiBuyCar)

local camOffset = 0.0
local camBobbingRight = false


function RefreshCarMenu()
	--carMenu:Clear()
	uiBuyCar:Text("Buy Now")
	uiBuyCar:RightLabel("$"..comma_value(tonumber(carSelection.price)), {R = 100, G = 200, B = 255, A = 255},  {R = 0, G = 60, B = 128, A = 255})	
	carModelNamePreview:Text(carSelection.name)

	
	carMenu.OnItemSelect = function(sender, item, index)
		if item==uiBuyCar then
		
			local bContinue = true
		
			if IsEmergencyVehicle(previewModel) and ESX.PlayerData.job.name~="police" then
				bContinue = false
				
				ShowNotification("Only EMS personnel may purchase this vehicle.")
			end
			
			
			if bContinue then
				TriggerServerEvent('wild-trainer:buyVehicle', carSelection.price)
			end 
			
			
			
		else
			

		end
	end
end


function CloseCarMenu()
	carMenu:Visible( false )
	bIsCarMenuOpen = false
	
	--ClearPedTasksImmediately(GetPlayerPed(-1))	
	SetPlayerControl(PlayerId(), true)
	SetCamActive(carCam, false)
	RenderScriptCams(false, 1, 600, 300, 300)
	--enderScriptCams(false, 1, 4000, 300, 300)
	
	DestroyCam(carCam,false)
	--DestroyAllCams(true)
	
--	ShowNotification("Close menu")
	
	if DoesEntityExist(previewModel) then
		SetEntityAsMissionEntity(previewModel, true, true)
		DeleteVehicle(previewModel)
		DeleteEntity(previewModel)
	end
end

local prevInterior = 0
local bPlayerIsInCarLastFrame = false

-- Main logic/magic loop
Citizen.CreateThread(function()
    local radius = 1.0  
	local waitForPlayerToLeave = false

	local bWasPlayerInCar = false

	while true do Citizen.Wait(1)
	
		local current = GetInteriorFromEntity(GetPlayerPed(-1))
		local bPlayerIsInCar = IsPedInAnyVehicle(GetPlayerPed(-1))

		if bPlayerIsInCar and bPlayerIsInCarLastFrame == false then
			bPlayerIsInCarLastFrame = true
		elseif bPlayerIsInCar == false and bPlayerIsInCarLastFrame == true then
			bWasPlayerInCar = true
		end		
		
		if current == 0 then
			bIsCarMenuOpen = false		
		end
		
		
		-- Auto shop fix (pay n spray). Fixes leaving while menu is open
		if prevInterior ~= 0 and current == 0 then
			--ShowNotification("Goodbye!")
			--RefreshAutoMenu()
			autoMenu:Clear()
			autoMenu:Visible( false )
			CloseCarMenu()
			prevInterior = 0
			ResetColors()
		else
			prevInterior = current
		end
		
		--if inside pay 'n sprays or simeons
		if current ~= 0 and carShops[current]~=nil or current  == simeonsPlace.id then

			if not _autoMenuPool:IsAnyMenuOpen() then
				ResetColors()
			end
			
			if _autoMenuPool:IsAnyMenuOpen() and not bPlayerIsInCar then autoMenu:Visible( false ) uiSubMenuPaintJob:Visible( false ) end
			
			if bPlayerIsInCar and current ~= simeonsPlace.id then
				DisplayHelpText("Press ~INPUT_CONTEXT~ To Modify/Repair Your Car")
			elseif current  == simeonsPlace.id then
				DisplayHelpText("Press ~INPUT_CONTEXT~ To Buy Cars")
			end
			
			_carMenuPool:ProcessMenus()		
			_autoMenuPool:ProcessMenus()	
			
			if IsControlJustPressed(1,51) then
				Citizen.CreateThread(function()
					while true do Citizen.Wait(1)
						if bIsCarMenuOpen then
							if not _carMenuPool:IsAnyMenuOpen() then CloseCarMenu() end
						else
							CloseCarMenu()
							break
						end
					end
				end)				
			
				-- Pay and spray
				if bPlayerIsInCar and current  ~= simeonsPlace.id then
					RefreshAutoMenu()
					
					bIsCarMenuOpen = true;
					autoMenu:Visible( true )
				elseif current == simeonsPlace.id then
				-- Simeon's
					bIsCarMenuOpen = true;
		
					RefreshCarMenu()
					
					Citizen.CreateThread(function()
						PreviewCar(carSelection.model, carSelection.name, carSelection.price, false)
					end)					
					
					
					carMenu:Visible( true )
					
					local playerPed = GetPlayerPed(-1)
					local coords = GetEntityCoords(playerPed)
			
					carCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
					SetCamActive(carCam, true)
					
					local playerOffset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
					carSpawnPoint = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 4.0, 0.0)
					SetCamCoord(carCam, simeonsPlace.cam.x, simeonsPlace.cam.y, simeonsPlace.cam.z)
					
					RenderScriptCams(true, true, 500, true, true)
					local heading = GetEntityHeading(playerPed)
					carHeading = heading + 90
					--SetEntityHeading(carCam, heading+180)
					SetCamRot(carCam, -10.0, 0.0, simeonsPlace.cam.h, true)		

					
					Citizen.CreateThread(function()
						while true do Citizen.Wait(1)
							if bIsCarMenuOpen then
							
							--local camOffset = 0.0
							--local camBobbingRight = false
							
								if camOffset < -1.1 then
									camBobbingRight = true
								elseif camOffset > 3.5 then
									camBobbingRight = false
								end
								
								if camBobbingRight then camOffset = camOffset + 0.005 else camOffset = camOffset - 0.005 end
								
								SetCamFov(carCam, 50.0 + camOffset*5)
								SetCamCoord(carCam, simeonsPlace.cam.x + (camOffset/3), simeonsPlace.cam.y + camOffset, simeonsPlace.cam.z + (camOffset/4))
								SetCamRot(carCam, ((camOffset-camOffset-camOffset)*2), 0.0, simeonsPlace.cam.h + ((camOffset-camOffset-camOffset)*10), true)
							else
								break
							end
						end
					end)					
					
				end			
				
			end

			if bWasPlayerInCar then
				ResetColors()
			end

		end

		if bWasPlayerInCar then
			bPlayerIsInCarLastFrame = false
			bWasPlayerInCar = false
		end
	end
end)



-- Restore look upon respawn
AddEventHandler('playerSpawned', function(spawn)
    ---LoadPlayercar()
end)




RegisterNUICallback('getGarage', function()
	TriggerServerEvent('wild-trainer:getGarage')	
end)
AddEventHandler("wild-trainer:cl_getGarage", function(garage)
	globalPlayerGarage = garage

	TriggerEvent("populateOwnedAircraftList")

	local currentVehicle = ""
	if activeVehicle ~= nil then currentVehicle = activeVehicle.plate end
	SendNUIMessage({
		receiveGarage = "receiveGarage",
		playerGarage = garage,
		activePlate = currentVehicle,
	})
end)
RegisterNetEvent("wild-trainer:cl_getGarage")


RegisterNUICallback('requestVehicle', function(data)
	--data.plate
	local bContinue = true
	
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	
	if activeVehicle ~= nil then
		if DoesEntityExist(activeVehicle.veh) then
			if data.plate ~= activeVehicle.plate then
			else
				local vehCoords = GetEntityCoords(activeVehicle.veh)
				
				local dist = GetDistanceBetweenCoords(playerCoords, vehCoords)
				
				if dist < 500 then
					ShowNotification("Your vehicle is too close to you to request a delivery!")
					bContinue = false
				end
			end
		end
	end	
	
	
	if bContinue then
		local heading, outPos = GetNthClosestVehicleNode(playerCoords.x, playerCoords.y, playerCoords.z, 100, 0, 0, 0)
	
		TriggerServerEvent('wild-trainer:requestVehicle', data.plate, outPos)
	end
		
end)




AddEventHandler("wild-trainer:cl_registerVehicle", function(vehicle)
	local veh = NetToVeh( vehicle.networkID )
	
	if DoesEntityExist(veh) then
		local coords = GetEntityCoords(veh)
		WildPlayer.Vehicles[vehicle.plate] = {
			['networkID'] = vehicle.networkID,
			['blip'] = AddBlipForEntity(veh),
			['pos'] = {
				['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['h'] = GetEntityHeading(veh)
			},
			['body'] = 1000.0,
			['engine'] = 1000.0,
			['fuel'] = 100.0,		
		}
		
		--TriggerServerEvent('wild-trainer:saveWildPlayerData', json.encode(WildPlayer))	
		
	
		--if DoesEntityExist(iPlayerCar) then
		--	DeleteEntity(iPlayerCar)
		--	RemoveBlip(playerCarBlip)
		--end

		
		SetBlipSprite(WildPlayer.Vehicles[vehicle.plate].blip, 225) --143
		SetBlipColour(WildPlayer.Vehicles[vehicle.plate].blip, 24)
		SetEntityAsMissionEntity(veh, true, true)			
	end
end)
RegisterNetEvent("wild-trainer:cl_registerVehicle")


AddEventHandler("wild-trainer:cl_deleteVehicle", function(netID)
	local veh = NetToVeh(netID)
	
	if DoesEntityExist(veh) then 
		SetEntityAsMissionEntity(veh, true, true)
		DeleteVehicle(veh)
		if DoesEntityExist(veh) then DeleteEntity(veh) end
	end
end)
RegisterNetEvent("wild-trainer:cl_deleteVehicle")