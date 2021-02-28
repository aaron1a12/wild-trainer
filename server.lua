ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print("Wild-Trainer Loaded!")

--The server starts with this BOOL set to FALSE, which means we can setup the map
--by spawning constant peds or other stuff. If a player joins, it sets to true.
--When all players leave, we set it back to false to setup everything again.
bFirstPlayerSpawned = false

briefCaseID = nil

bIsCarried = false


itemCarrier = -2

bPlayerLoaded = false

-- CAR SHOP
local playerVehicles = {}
local playerGarages = {}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000) -- Every second
		--print("GetNumPlayerIndices() ->"..GetNumPlayerIndices())
		--TriggerClientEvent("spawnAssassin", -1)--The "-1" makes it so it does it on everyones client not only yours
		--Citizen.Trace("\nwew")
	end
end)



AddEventHandler("playerDropped", function(source, reason)
	Citizen.Wait(1000)
	if GetNumPlayerIndices() < 1 then
		print("All players have left. Reset everything!")
		bFirstPlayerSpawned = false
		pedJohnDoe = 0
		briefCaseID = nil
	end
end)

AddEventHandler("sv_get_bFirstPlayerSpawned", function()
	TriggerClientEvent("cl_get_bFirstPlayerSpawned", -1, bFirstPlayerSpawned)  
	
	bFirstPlayerSpawned = true
end)
RegisterServerEvent("sv_get_bFirstPlayerSpawned")







AddEventHandler("sv_playerSpawned", function()
	TriggerClientEvent("cl_playerSpawned", -1) 
end)
RegisterServerEvent("sv_playerSpawned")


local playerVehTable = {}

function onWildPlayerLoad(source, bIsResourceRestarting)
	bPlayerLoaded = true
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	
	print("User loaded as ".. xPlayer.identifier)
	
	if bIsResourceRestarting then Citizen.Wait(2000) end
	
	local hungerLevel = 0
	local wantedLevel = 0
	
	local wildPlayerJSONData = nil

	--local WildPlayer = {}
	
	local result = MySQL.Sync.fetchAll('SELECT hunger, wanted, playerdata, vehicle, garage FROM wild_trainer WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	
	if #result ~= 0 then
		hungerLevel = result[1].hunger
		wantedLevel = result[1].wanted
		
		if result[1].playerdata ~= "" then
			wildPlayerJSONData = result[1].playerdata
		end
		
		if result[1].vehicle ~= "" then
			playerVehicles[source] = json.decode(result[1].vehicle)
		end
		
		if result[1].garage ~= "" then
			playerGarages[source] = json.decode(result[1].garage)
		end		
		
		print("Loaded hunger level: "..hungerLevel)
		print("Loaded persistent wanted level: "..wantedLevel)
		--print("Loaded player data: "..wildPlayerJSONData)
	else
		print("User " .. xPlayer.identifier .. " does not exist.")
		MySQL.Sync.execute('INSERT INTO wild_trainer (identifier, hunger, wanted, playerdata, vehicle, garage) VALUES (@identifier, @hunger, @wanted, @playerdata, @vehicle, @garage)',
		{
			['@identifier'] = xPlayer.identifier,
			['@hunger'] = hungerLevel,
			['@wanted'] = wantedLevel,
			['@playerdata'] = '',
			['@vehicle'] = '{}',
			['@garage'] = '{}'
		})
	end
	
	print("Call client event on: " .. _source)
	
	TriggerClientEvent('wild-trainer:cl_loadHunger', _source, hungerLevel)
	TriggerClientEvent('wild-trainer:cl_loadWanted', _source, wantedLevel)
	
	if wildPlayerJSONData ~= nil and wildPlayerJSONData ~= "null" then
		TriggerClientEvent('wild-trainer:cl_loadPlayerData', _source, wildPlayerJSONData)
		print("Please send data to player id: ".._source)
	end
	
	if briefCaseID == nil then
		print("briefCaseID was nil so trigger: wild-trainer:cl_spawnCarryItems")
		TriggerClientEvent('wild-trainer:cl_spawnCarryItems', _source, false)
	else
		print("briefCaseID was not nil so trigger: wild-trainer:cl_loadItem")
		TriggerClientEvent('wild-trainer:cl_loadItem', _source, briefCaseID)
	end
	
	if playerVehicles[_source] == nil then playerVehicles[_source] = {} end
	if playerGarages[_source] == nil then playerGarages[_source] = {} end
	
	for plate, vehicle in pairs(playerVehicles[_source]) do
		playerGarages[_source][plate].pos = playerVehicles[_source][plate].pos
		
		print("Spawn vehicle at "..playerGarages[_source][plate].pos.x)

		TriggerClientEvent('wild-trainer:cl_loadVehicle', _source, plate, playerGarages[_source][plate], false)		
	end
	
	TriggerClientEvent("cl_playerSpawned", -1) 
end

AddEventHandler('esx:playerLoaded', function(source)
	print("esx:playerLoaded so lets call onWildPlayerLoad")
	onWildPlayerLoad(source, false)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users) do
				--print("Deleting leftover vehicles... ".. tostring(playerVehicles[k]) )
				
				--Citizen.Wait(1000)
				
			
				print('USER: '..k)
				print("RESOURCE IS RESTARTING so lets call onWildPlayerLoad")
				onWildPlayerLoad(k, true)
			end
		end)
		--tonumber(source)
		--onWildPlayerLoad(source, true)
	end
end)

RegisterCommand('clean', function(source, args)
	--for playerID, vehicleTable in pairs(playerVehicles) do
	--	TriggerClientEvent("wild-trainer:cl_deletePlayerVehicles", -1, playerVehicles[playerID])  
	--end

	for playerID, vehicleTable in pairs(playerGarages) do
		--2021 changes: delete from garage instead, that way we include aircraft too
		TriggerClientEvent('wild-trainer:cl_deletePlayerVehicles', -1, playerGarages[playerID]) 
	end

	TriggerClientEvent("wild-trainer:cl_deleteItem", -1)  
	
	print("Server cleaned and ready for restart.")
end)


RegisterServerEvent('wild-trainer:saveWildPlayerData')
AddEventHandler('wild-trainer:saveWildPlayerData', function(JSON)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE wild_trainer SET playerdata = @playerdata WHERE identifier = @identifier',
	{
		['@playerdata'] = JSON,
		['@identifier'] = xPlayer.identifier
	})	
end)

RegisterServerEvent('wild-trainer:saveHunger')
AddEventHandler('wild-trainer:saveHunger', function(level)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE wild_trainer SET hunger = @level WHERE identifier = @identifier',
	{
		['@level'] = level,
		['@identifier'] = xPlayer.identifier
	})	
end)

RegisterServerEvent('wild-trainer:saveWanted')
AddEventHandler('wild-trainer:saveWanted', function(level)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE wild_trainer SET wanted = @level WHERE identifier = @identifier',
	{
		['@level'] = level,
		['@identifier'] = xPlayer.identifier
	})	
end)


AddEventHandler("wild-trainer:buyFood", function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	

	local bCanAfford = true
	
	if xPlayer.getMoney() < price then
		bCanAfford = false
	else
		xPlayer.removeMoney(price)
	end
	TriggerClientEvent('wild-trainer:cl_eatFood', _source, bCanAfford)
end)
RegisterServerEvent("wild-trainer:buyFood")


AddEventHandler("wild-trainer:removeMoney", function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	

	
	if amount == 0 then
		xPlayer.removeMoney( xPlayer.getMoney() )
	else
		xPlayer.removeMoney( amount )
	end
end)
RegisterServerEvent("wild-trainer:removeMoney")



AddEventHandler("wild-trainer:addMoney", function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.addMoney(amount)
end)
RegisterServerEvent("wild-trainer:addMoney")



AddEventHandler("wild-trainer:sv_setItemId", function(netItemId)
	print("wild-trainer:sv_setItemId")
	
	briefCaseID = netItemId
	
	TriggerClientEvent('wild-trainer:cl_loadItem', source, briefCaseID)
end)
RegisterServerEvent("wild-trainer:sv_setItemId")



AddEventHandler("sv_get_bIsCarried", function()
	TriggerClientEvent("cl_get_bIsCarried", -1, bFirstPlayerSpawned)  
	
	bFirstPlayerSpawned = true
end)
RegisterServerEvent("sv_get_bFirstPlayerSpawned")



AddEventHandler("wild-trainer:sv_pickUpItem", function()
	if itemCarrier ~= -2 then
		TriggerClientEvent("wild-trainer:cl_dropItem", itemCarrier)
	end
	
	--Citizen.Wait(100)
	-- Make everyone attach the object to the source's ped, including the object owner
	TriggerClientEvent("wild-trainer:cl_pickUpItem", -1, source)
	itemCarrier = source
end)
RegisterServerEvent("wild-trainer:sv_pickUpItem")


AddEventHandler("wild-trainer:sv_dropItem", function()
	TriggerClientEvent("wild-trainer:cl_dropItem", source)
end)
RegisterServerEvent("wild-trainer:sv_dropItem")



AddEventHandler("wild-trainer:sv_resetItem", function()
	TriggerClientEvent("wild-trainer:cl_dropItem", -1)
	TriggerClientEvent("wild-trainer:cl_deleteItem", -1)
	TriggerClientEvent("wild-trainer:cl_spawnCarryItems", source, true)
end)
RegisterServerEvent("wild-trainer:sv_resetItem")



AddEventHandler("wild-trainer:sv_armItem", function()
	TriggerClientEvent("wild-trainer:cl_setExplosionTimer", -1)
end)
RegisterServerEvent("wild-trainer:sv_armItem")








AddEventHandler("wild-trainer:sv_revivePed", function( netPed )
	TriggerClientEvent("wild-trainer:cl_revivePed", -1, netPed)
end)
RegisterServerEvent("wild-trainer:sv_revivePed")



--911



AddEventHandler("wild-trainer:call911", function(posX, posY, posZ, report)
	TriggerClientEvent('wild-trainer:cl_call911', -1, posX, posY, posZ, report)
end)
RegisterServerEvent("wild-trainer:call911")




-- Insulting Peds


AddEventHandler('wild-trainer:insultingPed', function(bIsInsulting)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	TriggerClientEvent("wild-trainer:cl_insultingPed", source, bIsInsulting)
end)
RegisterServerEvent('wild-trainer:insultingPed')

--////////////////////////////////////////////////////////////////////////
-- Car Shop
--////////////////////////////////////////////////////////////////////////

function SavePlayerVehicle(playerID)
	if playerID == nil then return end
	local ip = GetPlayerEndpoint(playerID)
	if ip == nil then return end
	
	local playerIpIdentifier = 'ip:'..ip
	
	MySQL.Async.execute('UPDATE wild_trainer SET vehicle = @vehiclesJSON WHERE identifier = @identifier',
	{
		['@vehiclesJSON'] = json.encode( playerVehicles[playerID] ),
		['@identifier'] = playerIpIdentifier
	})	
end

function SavePlayerGarage(playerID)
	if playerID == nil then return end
	local ip = GetPlayerEndpoint(playerID)
	if ip == nil then return end
	
	local playerIpIdentifier = 'ip:'..GetPlayerEndpoint(playerID)
	
	for plate, vehicle in pairs(playerVehicles[playerID]) do
		playerGarages[playerID][plate].body = vehicle.body
		playerGarages[playerID][plate].engine = vehicle.engine
		playerGarages[playerID][plate].fuel = vehicle.fuel			
	end
	
	MySQL.Async.execute('UPDATE wild_trainer SET garage = @garageJSON WHERE identifier = @identifier',
	{
		['@garageJSON'] = json.encode( playerGarages[playerID] ),
		['@identifier'] = playerIpIdentifier
	})	
end

AddEventHandler("wild-trainer:registerVehicle", function(vehicle)
	if playerVehicles[source] == nil then playerVehicles[source] = {} end
	if playerGarages[source] == nil then playerGarages[source] = {} end
	
	playerGarages[source][vehicle.plate] = {
		['networkID'] = vehicle.networkID,
		['model'] = vehicle.model,
		['type'] = vehicle.type,
		['colorPrimary'] = vehicle.colorPrimary,
		['colorSecondary'] = vehicle.colorSecondary,
		['pos'] = vehicle.pos,
		['body'] = vehicle.body,
		['engine'] = vehicle.engine,
		['fuel'] = vehicle.fuel,
		['used'] = vehicle.used,
	}
	
	SavePlayerGarage(source)
	
	if vehicle.type == 1 then -- 1 = car, 2 = aircraft

		-- Set as active vehicle
		playerVehicles[source][vehicle.plate] = playerGarages[source][vehicle.plate]

		-- Load the vehicle
		TriggerClientEvent('wild-trainer:cl_loadVehicle', source, vehicle.plate, vehicle, false)
	end
end)
RegisterServerEvent("wild-trainer:registerVehicle")


AddEventHandler("wild-trainer:unregisterVehicle", function(plateNumber)
	for playerID, vehicleTable in pairs(playerVehicles) do
	
		for plate, vehicleInfo in pairs(vehicleTable) do
			if plate == plateNumber then
				playerVehicles[playerID][plateNumber] = nil
				playerGarages[playerID][plateNumber] = nil
				
				SavePlayerGarage(playerID)
			end
		end

	end	
end)
RegisterServerEvent("wild-trainer:unregisterVehicle")

AddEventHandler("wild-trainer:updateVehicleCust", function(plate, customData)
	if playerGarages[source][plate] == nil then return end

	for key, val in pairs(playerGarages[source][plate]) do
		for custKey, custVal in pairs(customData) do
			if custKey == key then
				-- Set property...
				playerGarages[source][plate][key] = custVal

				SavePlayerGarage(source)
			end
		end
	end
end)
RegisterServerEvent("wild-trainer:updateVehicleCust")

AddEventHandler("wild-trainer:updateVehicleInfo", function(vehicleInfo)
	playerVehicles[source][vehicleInfo.plate].pos = {
		['x'] = vehicleInfo.x, ['y'] = vehicleInfo.y, ['z'] = vehicleInfo.z, ['h'] = vehicleInfo.h
	}
	
	playerVehicles[source][vehicleInfo.plate].body = vehicleInfo.body
	playerVehicles[source][vehicleInfo.plate].engine = vehicleInfo.engine
	playerVehicles[source][vehicleInfo.plate].fuel = vehicleInfo.fuel
end)
RegisterServerEvent("wild-trainer:updateVehicleInfo")

AddEventHandler("wild-trainer:updateVehicleNetworkID", function(vehicleInfo)
	--playerVehicles[source][vehicleInfo.plate] = {['networkID'] = vehicleInfo.networkID}	
	
	--playerGarages[source][vehicleInfo.plate] = {['networkID'] = vehicleInfo.networkID}
	
	if vehicleInfo.type == 1 then
		playerVehicles[source][vehicleInfo.plate] = {['networkID'] = vehicleInfo.networkID}	
	else
		playerGarages[source][vehicleInfo.plate].networkID = vehicleInfo.networkID
	end
	print("Setting new id as ".. vehicleInfo.networkID);
end)
RegisterServerEvent("wild-trainer:updateVehicleNetworkID")


AddEventHandler("wild-trainer:removeActiveVehicle", function(plate)
	-- Save and update the vehicle in the garage before despawning
	playerGarages[source][plate].body = playerVehicles[source][plate].body
	playerGarages[source][plate].engine = playerVehicles[source][plate].engine
	playerGarages[source][plate].fuel = playerVehicles[source][plate].fuel
	
	SavePlayerGarage(source)
	
	playerVehicles[source][plate] = nil
end)
RegisterServerEvent("wild-trainer:removeActiveVehicle")


AddEventHandler("wild-trainer:getGarage", function()
	print("server: wild-trainer:getGarage")
	TriggerClientEvent('wild-trainer:cl_getGarage', source, playerGarages[source])
end)
RegisterServerEvent("wild-trainer:getGarage")

AddEventHandler("wild-trainer:requestVehicle", function(plate, spawnPoint)
	print("requestVehicle")

	playerGarages[source][plate].pos = {
		['x'] = spawnPoint.x, ['y'] = spawnPoint.y, ['z'] = spawnPoint.z
	}
	
	TriggerClientEvent('wild-trainer:cl_loadVehicle', source, plate, playerGarages[source][plate], true)
end)
RegisterServerEvent("wild-trainer:requestVehicle")


AddEventHandler("wild-trainer:buyVehicle", function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	

	local bCanAfford = true
	
	if xPlayer.getBank() < price then
		bCanAfford = false
	else
		xPlayer.removeAccountMoney('bank', price)
	end
	
	TriggerClientEvent('wild-trainer:cl_buyVehicle', _source, bCanAfford)
end)
RegisterServerEvent("wild-trainer:buyVehicle")

AddEventHandler("wild-trainer:buyAircraft", function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	

	local bCanAfford = true
	
	if xPlayer.getBank() < price then
		bCanAfford = false
	else
		xPlayer.removeAccountMoney('bank', price)
	end
	
	TriggerClientEvent('wild-trainer:cl_buyAircraft', _source, bCanAfford)
end)
RegisterServerEvent("wild-trainer:buyAircraft")


-- When players disconnect, the surviving players must delete his/her leftover vehicles
AddEventHandler("playerDropped", function(source, reason)
	-- Unregister all vehicles
	--TriggerClientEvent('wild-trainer:cl_deletePlayerVehicles', -1, playerVehicles[source])

	--2021 changes: delete from garage instead, that way we include aircraft too
	TriggerClientEvent('wild-trainer:cl_deletePlayerVehicles', -1, playerGarages[source])
	
	Citizen.Wait(4000)
	
	playerVehicles[source] = nil
	playerGarages[source] = nil	
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(1000)
		for playerID, vehicleTable in pairs(playerVehicles) do
			TriggerClientEvent('wild-trainer:cl_getVehicleInfo', playerID, playerVehicles[playerID])
		end
	end
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(5000)
		for playerID, vehicleTable in pairs(playerVehicles) do
			if playerVehicles[playerID] ~= nil then
				SavePlayerVehicle(playerID)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(1000*60)
		for playerID, vehicleTable in pairs(playerVehicles) do
			if playerGarages[playerID] ~= nil then
				SavePlayerGarage(playerID)
			end
		end
	end
end)




--- GRAND THEFT AUTO MISSION

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local carSmugglers = {
	{['x'] = 1621.32, ['y'] = 3569.61, ['z'] = 35.38, ['h'] = 210.94, ['inuse'] = false},
	{['x'] = 2309.01, ['y'] = 3137.04, ['z'] = 47.96, ['h'] = 210.94, ['inuse'] = false},
	{['x'] = 2054.37, ['y'] = 3222.15, ['z'] = 45.25, ['h'] = 30.0, ['inuse'] = false}, 
	{['x'] = 1937.79, ['y'] = 3736.61, ['z'] = 32.54, ['h'] = 210.94, ['inuse'] = false}, 
}

AddEventHandler("wild-trainer:findCarSmuggler", function()
	local foundSpawnpoint = false
	
	local avaiableSpawnpoints = {}
	
	local i = 0
	for smugglerID, smuggler in pairs(carSmugglers) do
		if not smuggler.inuse then
			i = i + 1
			foundSpawnpoint = true
			
			avaiableSpawnpoints[i] = smugglerID
		end
	end
	
	if foundSpawnpoint then
		local randomAvailable = avaiableSpawnpoints[ math.random( #avaiableSpawnpoints ) ]
		local randomSmuggler = carSmugglers[ randomAvailable ]
		TriggerClientEvent('wild-trainer:cl_foundCarSmuggler', source, true, randomAvailable, randomSmuggler)
	else
		TriggerClientEvent('wild-trainer:cl_foundCarSmuggler', source, false)
	end
end)
RegisterServerEvent("wild-trainer:findCarSmuggler")

AddEventHandler("wild-trainer:lockCarSmuggler", function(smugglerID, bLock)
	if bLock == nil then return end
	
	print("Lock or unlock car smuggler? "..tostring(bLock))
	if bLock then
		carSmugglers[smugglerID].inuse = true
	else
		Citizen.Wait((1000*60)*5)
		carSmugglers[smugglerID].inuse = false
	end
	--if not block then  end
	
	
	
	--carSmugglers[smugglerID].inuse = bLock
	--TriggerClientEvent('wild-trainer:cl_lockCarSmugglerSpawnpoint', -1, spawnId, bLock)
end)
RegisterServerEvent("wild-trainer:lockCarSmuggler")



-- Hospital Bills


AddEventHandler("wild-trainer:hospitalBill", function(cost)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	

	xPlayer.removeAccountMoney('bank', cost)
end)
RegisterServerEvent("wild-trainer:hospitalBill")

AddEventHandler("wild-trainer:deleteVehicle", function(netID)
	TriggerClientEvent('wild-trainer:cl_deleteVehicle', -1, netID)
end)
RegisterServerEvent("wild-trainer:deleteVehicle")



AddEventHandler("wild-trainer:setJob", function(job, grade)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	xPlayer.setJob(job, grade)
	
	--print("setjob")
end)
RegisterServerEvent("wild-trainer:setJob")


-- COP MISSIONS

copPlayers = {}

AddEventHandler("wild-trainer:updateCopStatus", function(bRemoveCop)
	if bRemoveCop then
		for k, player in pairs(copPlayers) do
			if player == source then
				copPlayers[k] = nil
				print("Removed cop")
				break
			end
		end		
	else
		table.insert(copPlayers, source)
		print("Added cop")
	end
	
	TriggerClientEvent("wild-trainer:cl_refreshCopBlips", -1) 
end)
RegisterServerEvent("wild-trainer:updateCopStatus")

crimeInProgress = false

AddEventHandler("wild-trainer:crimeInProgress", function(bInProgress)
	crimeInProgress = bInProgress
end)
RegisterServerEvent("wild-trainer:crimeInProgress")

function CreateCrime()
	math.randomseed(GetGameTimer())
	
	if #copPlayers < 1 then return end
	if crimeInProgress then return end
	
	crimeInProgress = true
	
	-- Create a crime near a random cop player
	local targetCop = copPlayers[math.random( #copPlayers )]
	
	TriggerClientEvent("wild-trainer:cl_createCrime", targetCop)  
	
    --local players = GetPlayers()

    --for playerID, v in ipairs(players) do
	--	print(playerID)
    --end
	--for _, player in ipairs(GetActivePlayers()) do
		--local ped = GetPlayerPed(player)
		-- do stuff
	--	print(player)
	--end
	
	--TriggerClientEvent("wild-trainer:cl_createCrime", targetCop)  
	
	--print("")
end

RegisterCommand('crime', function(source, args)
	CreateCrime()
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000*1) --minutes
		--Citizen.Wait(5000) --minutes
		
		if math.random(0, 1) < 0.5 then	
			CreateCrime()
		end
		
	end
end)





-- Contacts
AddEventHandler("wild-trainer:getPlayers", function()
	local xPlayers = ESX.GetPlayers()
	local playerList = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	
		playerList[i] = {
			name = xPlayer.getName(),
			id = xPlayers[i]
		}
	end

	TriggerClientEvent('wild-trainer:cl_getPlayers', source, playerList)
end)
RegisterServerEvent("wild-trainer:getPlayers")

AddEventHandler("wild-trainer:sendTextMessage", function(data)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('wild-trainer:cl_receiveTextMessage', data.recipient, data.text, source, xPlayer.getName())
end)
RegisterServerEvent("wild-trainer:sendTextMessage")