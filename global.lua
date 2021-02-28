function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetClosestPed()
    local closestPed = 0
  
    for ped in EnumeratePeds() do
        local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true)
        if distanceCheck <= 15.0 and ped ~=GetPlayerPed(-1) then
            closestPed = ped
            break
        end
    end

    return closestPed
end

function LoadModel( modelName )
	local model = GetHashKey(modelName)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)	
	end
	return model
end

function ReleaseModel( modelName )
	SetModelAsNoLongerNeeded(modelName)
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

rsCharset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(rsCharset, string.char(c)) end
    for c = 65, 90  do table.insert(rsCharset, string.char(c)) end
end

function randomString(length)
    if not length or length <= 0 then return '' end
    return randomString(length - 1) .. rsCharset[math.random(1, #rsCharset)]
end

function IsCop(oPed)
	local pedType = GetPedType(oPed)
	
	if pedType == 6 or pedType == 27 then
		return true
	else
		return false
	end
end


-- 911

REPORT = {
  DRUGDEAL = "Reports of possible drug deal.",
  SIGHTING = "Wanted fugitive sighted.",
  GUNDRAWN = "Reports of armed civilian.",
  DANGEROUS = "Armed and dangerous suspect sighted.",
  REDLIGHT = "Vehicle ran past red light.",
  WRONGWAY = "Vehicle driving wrong-way.",
  SPEEDING = "Speeding vehicle."
}

AddEventHandler("wild-trainer:cl_call911", function(posX, posY, posZ, msg)
	SendNUIMessage({type = 'playScanner'})

    local blip = AddBlipForCoord(posX, posY, posZ)
    SetBlipSprite(blip, 66)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911: '.. msg)
    EndTextCommandSetBlipName(blip)
	
	SetNotificationTextEntry('STRING')
	--AddTextComponentSubstringWebsite("")
	SetNotificationMessage('CHAR_CALL911', 'CHAR_CALL911', false, 4, "911 Call", msg)
	DrawNotification(false, false)	
	
    Wait(5000 * 60) -- Five minute blip
    
    RemoveBlip(blip)
end)
RegisterNetEvent("wild-trainer:cl_call911")


-----------------------------------------------------------------------------
--=========================================================================--
-----------------------------------------------------------------------------

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	
	while ESX.PlayerData.lastPosition == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.PlayerData.loadout == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	---ESX.PlayerData = ESX.GetPlayerData()	
end)

bFirstPlayerSpawned = false

players = {}

iPlayerHunger = 70

bHandsUp = false
bSuspectInCustody = false

AddEventHandler("cl_get_bFirstPlayerSpawned", function(boolValue)
	bFirstPlayerSpawned = boolValue
end)
RegisterNetEvent("cl_get_bFirstPlayerSpawned")



-- Wild Player information +skin too
WildPlayer = {}
WildPlayer.Skin = {}
WildPlayer.Skin.Model = "a_m_m_beach_01"
WildPlayer.Skin.Name = "Beach"
WildPlayer.Skin.HeadVar = 0
WildPlayer.Skin.HeadTexture = 0
WildPlayer.Skin.BeardMaskVar = 0
WildPlayer.Skin.BeardMaskTexture = 0
WildPlayer.Skin.HairHatVar = 0
WildPlayer.Skin.HairHatTexture = 0
WildPlayer.Skin.UpperBodyVar = 0
WildPlayer.Skin.UpperBodyTexture = 0
WildPlayer.Skin.LowerBodyVar = 0
WildPlayer.Skin.LowerBodyTexture = 0

WildPlayer.Vehicles = {}

iPlayerCar = 0
playerCarBlip = 0


-- |||||| NUKE MISSION ||||||

bIsPostNuke = false

-- ||||||||||||||||||||||||||



-- **0**: Head
-- **1**: BeardMask
-- **2**: HairHat
-- **3**: UpperBody
-- **4**: LowerBody
-- **5**: Parachute
-- **6**: Shoes
-- **7**: Accessory
-- **8**: Undershirt
-- **9**: Kevlar
-- **10**: Badge
-- **11**: Torso

	--SetPedComponentVariation(GetPlayerPed(-1), 5, WildPlayer.Skin.ParachuteVar, WildPlayer.Skin.ParachuteTexture, GetPedPaletteVariation(GetPlayerPed(-1), 5))
	--SetPedComponentVariation(GetPlayerPed(-1), 6, WildPlayer.Skin.ShoesVar, WildPlayer.Skin.ShoesTexture, GetPedPaletteVariation(GetPlayerPed(-1), 6))
	--SetPedComponentVariation(GetPlayerPed(-1), 7, WildPlayer.Skin.AccessoryVar, WildPlayer.Skin.AccessoryTexture, GetPedPaletteVariation(GetPlayerPed(-1), 7))
	--SetPedComponentVariation(GetPlayerPed(-1), 8, WildPlayer.Skin.UndershirtVar, WildPlayer.Skin.UndershirtTexture, GetPedPaletteVariation(GetPlayerPed(-1), 8))
	--SetPedComponentVariation(GetPlayerPed(-1), 9, WildPlayer.Skin.KevlarVar, WildPlayer.Skin.KevlarTexture, GetPedPaletteVariation(GetPlayerPed(-1), 9))
	--SetPedComponentVariation(GetPlayerPed(-1), 10, WildPlayer.Skin.BadgeVar, WildPlayer.Skin.BadgeTexture, GetPedPaletteVariation(GetPlayerPed(-1), 10))
	--SetPedComponentVariation(GetPlayerPed(-1), 11, WildPlayer.Skin.TorsoVar, WildPlayer.Skin.TorsoTexture, GetPedPaletteVariation(GetPlayerPed(-1), 11))

AddEventHandler("wild-trainer:cl_loadPlayerData", function(JSONString)
	print("Loaded data!!!!!!!!!!!!!")
	
	WildPlayer = json.decode(JSONString)
	
	print("global.lua: WildPlayer->" ..tostring(WildPlayer))
	
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		TriggerEvent("playerDataIsReady")
	end)
end)
RegisterNetEvent("wild-trainer:cl_loadPlayerData")


