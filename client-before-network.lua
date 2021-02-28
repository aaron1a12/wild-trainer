modelSelection = "a_f_y_bevhills_01"
weaponSelection = "None"
pedSelection = 1


uiModelList = nil
uiWeaponList = nil

uiPedSelectSlider = nil
uiEditBodyguard_TopSlider = nil

bodyguards = {}

mySkin = 0

Hat = nil
HatTexture = nil
Glasses = nil
GlassesTexture = nil
EarPiece = nil
EarPieceTexture = nil
Watch = nil
WatchTexture = nil
Face = nil
FaceTexture = nil
Mask = nil
MaskTexture = nil
Hair = nil
HairTexture = nil
UpperBody = nil
UpperBodyTexture = nil
Legs = nil
LegsTexture = nil
Parachute = nil
ParachuteTexture = nil
Shoes = nil
ShoesTexture = nil
TiesScarfsetc = nil
TiesScarfsetcTexture = nil
Undershirt = nil
UndershirtTexture = nil
Armor = nil
ArmorTexture = nil
Embleme = nil
EmblemeTexture = nil
Top = nil
TopTexture = nil
bool, shapeMotherID, shapeFatherID, shapeExtraID, skinMotherID, skinFatherID, skinExtraID, shapeMix, skinMix, thirdMix = nil
newShapeMix = nil
newSkinMix = nil
newThirdMix = nil
ModelHash = nil
Blemishes = nil
FacialHair = nil
Eyebrows = nil
Ageing = nil
Makeup = nil
Blush = nil
Complexion = nil
SunDamage = nil
Lipstick = nil
MolesFreckles = nil
ChestHair = nil
BodyBlemishes = nil
AddBodyBlemishes = nil

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("WILD-TRAINER", "~b~SOME FUN STUFF")
submenu = _menuPool:AddSubMenu(mainMenu, "> Edit Current Bodyguards")
_menuPool:Add(mainMenu)



function AddMenuModels(menu)
    local modelList = {
		"a_f_y_bevhills_01",
		"a_f_y_bevhills_02",
		"a_f_y_bevhills_03",
        "a_f_y_epsilon_01",
        "a_f_y_hipster_01",
		"a_f_y_hipster_02",
		"a_f_y_hipster_03",
		"a_f_y_hipster_04",
		"player_zero",
		"ig_amandatownley",
		"ig_tracydisanto",
		"ig_jimmydisanto",
		"s_m_y_cop_01",
		"a_c_rottweiler",
		"a_c_chimp",
		"lana",
		"saved_skin",
    }
    uiModelList = NativeUI.CreateListItem("Models", modelList, 1)
    menu:AddItem(uiModelList)
end


function AddMenuWeapons(menu)
    local weaponList = {
		"None",
		"WEAPON_NIGHTSTICK",
		"WEAPON_KNIFE",
		"WEAPON_STUNGUN",
		"WEAPON_PISTOL",
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_BAT",
		"WEAPON_CROWBAR",
		"WEAPON_MACHETE",
		"WEAPON_MUSKET",
		"WEAPON_SNOWBALL",
		"WEAPON_HATCHET",
		"WEAPON_SWITCHBLADE",
		"WEAPON_DAGGER",
		"WEAPON_MOLOTOV",
		"WEAPON_REVOLVER",
    }
    uiWeaponList = NativeUI.CreateListItem("Weapon", weaponList, 2)
    menu:AddItem(uiWeaponList)
end

function handleListChange(menu)
    menu.OnListChange = function(sender, item, index)
		--ShowNotification(item)	
        if item == uiWeaponList then
            weaponSelection = item:IndexToItem(index)
			--ShowNotification("New weapon will be: " .. weaponSelection)
        end		
		
        if item == uiModelList then
            modelSelection = item:IndexToItem(index)
			--ShowNotification("New model will be: " .. modelSelection)	
		end		
    end
end

function handleSliderChange(menu)
	menu.OnSliderChange = function(sender, item, index)
		
        if item == uiPedSelectSlider then
			pedSelection = item:IndexToItem(index)
            uiPedSelectSlider:Text("Selected Ped ("..pedSelection..")")
        end
    end
end

function savePlayerSkin()
	local playerPed = GetPlayerPed(-1)
	
	mySkin = GetEntityModel(PlayerPedId())
	
	Hat = GetPedPropIndex(playerPed, 0)
	HatTexture = GetPedPropTextureIndex(playerPed, 0)
	Glasses = GetPedPropIndex(playerPed, 1)
	GlassesTexture = GetPedPropTextureIndex(playerPed, 1)
	EarPiece = GetPedPropIndex(playerPed, 2)
	EarPieceTexture = GetPedPropTextureIndex(playerPed, 2)
	Watch = GetPedPropIndex(playerPed, 3)
	WatchTexture = GetPedPropTextureIndex(playerPed, 3)
	Face = GetPedDrawableVariation(playerPed, 0)
	FaceTexture = GetPedTextureVariation(playerPed, 0)
	Mask = GetPedDrawableVariation(playerPed, 1)
	MaskTexture = GetPedTextureVariation(playerPed, 1)
	Hair = GetPedDrawableVariation(playerPed, 2)
	HairTexture = GetPedTextureVariation(playerPed, 2)
	UpperBody = GetPedDrawableVariation(playerPed, 3)
	UpperBodyTexture = GetPedTextureVariation(playerPed, 3)
	Legs = GetPedDrawableVariation(playerPed, 4)
	LegsTexture = GetPedTextureVariation(playerPed, 4)
	Parachute = GetPedDrawableVariation(playerPed, 5)
	ParachuteTexture = GetPedTextureVariation(playerPed, 5)
	Shoes = GetPedDrawableVariation(playerPed, 6)
	ShoesTexture = GetPedTextureVariation(playerPed, 6)
	TiesScarfsetc = GetPedDrawableVariation(playerPed, 7)
	TiesScarfsetcTexture = GetPedTextureVariation(playerPed, 7)
	Undershirt = GetPedDrawableVariation(playerPed, 8)
	UndershirtTexture = GetPedTextureVariation(playerPed, 8)
	Armor = GetPedDrawableVariation(playerPed, 9)
	ArmorTexture = GetPedTextureVariation(playerPed, 9)
	Embleme = GetPedDrawableVariation(playerPed, 10)
	EmblemeTexture = GetPedTextureVariation(playerPed, 10)
	Top = GetPedDrawableVariation(playerPed, 11)
	TopTexture = GetPedTextureVariation(playerPed, 11)
	bool, shapeMotherID, shapeFatherID, shapeExtraID, skinMotherID, skinFatherID, skinExtraID, shapeMix, skinMix, thirdMix = Citizen.InvokeNative(0x2746BD9D88C5C5D0, GetPlayerPed(-1), Citizen.PointerValueIntInitialized(shapeMotherID), Citizen.PointerValueIntInitialized(shapeFatherID), Citizen.PointerValueIntInitialized(shapeExtraID), Citizen.PointerValueIntInitialized(skinMotherID), Citizen.PointerValueIntInitialized(shapeFatherID), Citizen.PointerValueIntInitialized(skinExtraID), Citizen.PointerValueFloatInitialized(shapeMix), Citizen.PointerValueFloatInitialized(skinMix), Citizen.PointerValueFloatInitialized(thirdMix), Citizen.ReturnResultAnyway())
	newShapeMix = round(shapeMix, 2)
	newSkinMix = round(skinMix, 2)
	newThirdMix = round(thirdMix, 2)
	ModelHash = GetEntityModel(GetPlayerPed(-1))
	Blemishes = GetPedHeadOverlayValue(playerPed, 0)
	FacialHair = GetPedHeadOverlayValue(playerPed, 1)
	Eyebrows = GetPedHeadOverlayValue(playerPed, 2)
	Ageing = GetPedHeadOverlayValue(playerPed, 3)
	Makeup = GetPedHeadOverlayValue(playerPed, 4)
	Blush = GetPedHeadOverlayValue(playerPed, 5)
	Complexion = GetPedHeadOverlayValue(playerPed, 6)
	SunDamage = GetPedHeadOverlayValue(playerPed, 7)
	Lipstick = GetPedHeadOverlayValue(playerPed, 8)
	MolesFreckles = GetPedHeadOverlayValue(playerPed, 9)
	ChestHair = GetPedHeadOverlayValue(playerPed, 10)
	BodyBlemishes = GetPedHeadOverlayValue(playerPed, 11)
	AddBodyBlemishes = GetPedHeadOverlayValue(playerPed, 12)
end

function startFollowing( ped )
	local _PlayerPed = GetPlayerPed(-1)
	local _GroupHandle = GetPlayerGroup(PlayerId())

	SetGroupSeparationRange(_GroupHandle, 999999.9)
	SetPedAsGroupLeader(_PlayerPed, _GroupHandle)
	SetPedAsGroupMember(ped, _GroupHandle)
	SetPedNeverLeavesGroup(ped, true)
end

function AddMenuSpawnBodyguard(menu)
    local newitem = NativeUI.CreateItem("Spawn Ped", "Create bodyguard ped.")
	local save1 = NativeUI.CreateItem("Save Player Skin", "Save your player's current skin to saved_skin")
	local uiStopFollowing = NativeUI.CreateItem("Stop Following", "Make your bodyguards stop following you.")
	local uiResumeFollowing = NativeUI.CreateItem("Resume Following", "Make your bodyguards start following you again.")
	local uiKillAll = NativeUI.CreateItem("Kill All Bodyguards", "Elimiate all of your spawned bodyguards.")
	
	local uiSpawn = NativeUI.CreateItem("Spawn Assassin", "...")

    menu:AddItem(newitem)
	menu:AddItem(save1)
	menu:AddItem(uiStopFollowing)
	menu:AddItem(uiResumeFollowing)
	menu:AddItem(uiKillAll)
	menu:AddItem(uiSpawn)
	
    menu.OnItemSelect = function(sender, item, index)
		if item == uiSpawn then
		
			local assassinModel = "a_m_y_latino_01"
		
			RequestModel( GetHashKey( assassinModel ) )
			while ( not HasModelLoaded( GetHashKey( assassinModel ) ) ) do
				Citizen.Wait( 1 )
			end	
			
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local assassinPed = CreatePed(7, assassinModel, pos['x'], pos['y'], pos['z'], 0, true, true)	
			SetPedAsEnemy(assassinPed, true)
			TaskCombatPed(assassinPed, GetPlayerPed(-1),0,16)
			ShowNotification("Spawned!")
		end	
		
		if item == uiKillAll then
			for key,value in pairs(bodyguards) do
				--value[1] -> ped, value[2] - > pedBlip
				RemovePedFromGroup(value[1])
				SetPedAsNoLongerNeeded( value[1] )				
				SetEntityHealth( value[1], 0)
			end			
		end
		
		if item == uiStopFollowing then
			for key,value in pairs(bodyguards) do
				--value[1] -> ped, value[2] - > pedBlip
				RemovePedFromGroup(value[1])
			end			
		end		
		
		if item == uiResumeFollowing then
			for key,value in pairs(bodyguards) do
				--value[1] -> ped, value[2] - > pedBlip
				startFollowing( value[1] )

			end			
		end			
		
		if item == save1 then
			savePlayerSkin()
			ShowNotification("Skin saved!")
		end		
		
        if item == newitem then
		
			local playerPed = GetPlayerPed(-1)
			local GroupHandle = GetPlayerGroup(PlayerId())
			local bool, groupSize = GetGroupSize(GroupHandle)
			local pedModel = modelSelection
			local bLoadSavedProps = false
			
			local pos = GetEntityCoords(GetPlayerPed(-1))

			if (groupSize <= 6) then

				if pedModel == "saved_skin" then
					if mySkin==0 then
						ShowNotification("You must first save your player's skin!")
						
						do return end
					else
						pedModel = mySkin
						bLoadSavedProps = true
						
						RequestModel( pedModel )
						while ( not HasModelLoaded(  pedModel  ) ) do
							Citizen.Wait( 1 )
						end										
					end
				else
					RequestModel( GetHashKey( pedModel ) )
					while ( not HasModelLoaded( GetHashKey( pedModel ) ) ) do
						Citizen.Wait( 1 )
					end				
				end
				
				local pedType = 5
				
				if pedModel=="s_m_y_cop_01" then
					pedType = 6
				end
				
				local ped = CreatePed(pedType, pedModel, pos['x'], pos['y'], pos['z'], 0, true, true)	
				
				if bLoadSavedProps == true then
					ShowNotification("Loaded variation.")
					SetPedPropIndex(ped, 0, tonumber(Hat), tonumber(HatTexture), true)
					SetPedPropIndex(ped, 1, tonumber(Glasses), tonumber(GlassesTexture), true)
					SetPedPropIndex(ped, 2, tonumber(EarPiece), tonumber(EarPieceTexture), true)
					SetPedPropIndex(ped, 3, tonumber(Watch), tonumber(WatchTexture), true)
					SetPedComponentVariation(ped, 0, tonumber(Face), tonumber(FaceTexture), GetPedPaletteVariation(ped, 0))
					SetPedComponentVariation(ped, 1, tonumber(Mask), tonumber(MaskTexture), GetPedPaletteVariation(ped, 1))
					SetPedComponentVariation(ped, 2, tonumber(Hair), tonumber(HairTexture), GetPedPaletteVariation(ped, 2))
					SetPedComponentVariation(ped, 3, tonumber(UpperBody), tonumber(UpperBodyTexture), GetPedPaletteVariation(ped, 3))
					SetPedComponentVariation(ped, 4, tonumber(Legs), tonumber(LegsTexture), GetPedPaletteVariation(ped, 4))
					SetPedComponentVariation(ped, 5, tonumber(Parachute), tonumber(ParachuteTexture), GetPedPaletteVariation(ped, 5))
					SetPedComponentVariation(ped, 6, tonumber(Shoes), tonumber(ShoesTexture), GetPedPaletteVariation(ped, 6))
					SetPedComponentVariation(ped, 7, tonumber(TiesScarfsetc), tonumber(TiesScarfsetcTexture), GetPedPaletteVariation(ped, 7))
					SetPedComponentVariation(ped, 8, tonumber(Undershirt), tonumber(UndershirtTexture), GetPedPaletteVariation(ped, 8))
					SetPedComponentVariation(ped, 9, tonumber(Armor), tonumber(ArmorTexture), GetPedPaletteVariation(ped, 9))
					SetPedComponentVariation(ped, 10, tonumber(Embleme), tonumber(EmblemeTexture), GetPedPaletteVariation(ped, 10))
					SetPedComponentVariation(ped, 11, tonumber(Top), tonumber(TopTexture), GetPedPaletteVariation(ped, 11))				
				end
				
				local pedBlip = AddBlipForEntity(ped)
				
				SetBlipSprite(pedBlip, 270) --143
				SetBlipColour(pedBlip, 5)
				
				SetGroupSeparationRange(GroupHandle, 999999.9)
				SetPedAsGroupLeader(playerPed, GroupHandle)
				SetPedAsGroupMember(ped, GroupHandle)
				SetPedNeverLeavesGroup(ped, true)
				
				SetPedMaxHealth(ped, 200)
				SetEntityInvincible(ped, false)
				SetPedCanBeTargetted(ped, true)
				SetPedDropsWeaponsWhenDead(ped, false)
				
				if weaponSelection~="None" then
					GiveWeaponToPed(ped, GetHashKey(weaponSelection), 999999999, false, true)
				end
				
				SetPedInfiniteAmmo(ped, true)
				SetPedInfiniteAmmoClip(ped, true)		
				SetPedCombatAbility(ped, 2)
				
				
				if pedModel=="s_m_y_cop_01" then
					SetPedAsCop(ped, true)
				end

				SetModelAsNoLongerNeeded( pedModel )

				ShowNotification("Bodyguard spawned.")
				
				table.insert(bodyguards, {ped, pedBlip})
			end
		
        end
    end
end


function AddMenuEditBodyguard(menu)
	local amount = {}
	local topAmount = {}
	
	for i = 1, 7 do amount[i] = i end
    uiPedSelectSlider = UIMenuSliderItem.New("Selected Ped (1)", amount, 1, false)
	submenu:AddItem( uiPedSelectSlider )
	
	for i = 1, 3 do topAmount[i] = i end
	uiEditBodyguard_TopSlider = UIMenuSliderItem.New("Top Shape (1)", amount, 1, false)
	submenu:AddItem( uiEditBodyguard_TopSlider )
	
    --for i = 1, 20, 1 do
    --    submenu:AddItem(UIMenuItem.New("PageFiller", "Sample description that takes more than one line. Moreso, it takes way more than two lines since it's so long. Wow, check out this length!"))
    --end
end

AddMenuModels(mainMenu)
AddMenuWeapons(mainMenu)
AddMenuSpawnBodyguard(mainMenu)
AddMenuEditBodyguard(mainMenu)
handleListChange(mainMenu)
handleSliderChange(submenu)
_menuPool:RefreshIndex()

function spawnShopKeeper()
	local pModel = "mp_m_shopkeep_01"
	RequestModel( GetHashKey( pModel ) )
	while ( not HasModelLoaded( GetHashKey( pModel ) ) ) do
		Citizen.Wait( 1 )
	end	
	
	local pos = { x =1959.07, y = 3741.27, z = 32.34, h = 303.69 }
	local shopKeepPed = CreatePed(7, pModel, pos['x'], pos['y'], pos['z'], 0, true, true)
	SetEntityInvincible(shopKeepPed, true)
	SetPedMaxHealth(ped, 9999)
	
	TaskStartScenarioInPlace( shopKeepPed, "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
	--ShowNotification(type(assassinPed))
end


AddEventHandler("playerSpawned", function(spawn)
	TriggerServerEvent("sv_playerSpawned")
	TriggerServerEvent("sv_get_bFirstPlayerSpawned")
	Citizen.Wait(1000)
	
	--spawnCarryItems()

	if bFirstPlayerSpawned == false then
		-- We are the first player to spawn on this server!
		spawnShopKeeper()
		--spawnCarryItems()
	else
		-- We are not the first to join this server so do not set up anything.
	end
end)


-- Server triggered event when anyone spawns
AddEventHandler("cl_playerSpawned", function(spawn)
	-- Update Player List
	players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end)
RegisterNetEvent("cl_playerSpawned")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 243) then
            mainMenu:Visible(not mainMenu:Visible())
        end
		
		if IsControlJustPressed(1, 304) then
			
			local playerPed = GetPlayerPed(-1)
			
			if not IsPedInAnyVehicle(playerPed, false)
				and not IsPedSwimming(playerPed)
				and not IsPedShooting(playerPed)
				and not IsPedClimbing(playerPed)
				and not IsPedCuffed(playerPed)
				and not IsPedDiving(playerPed)
				and not IsPedFalling(playerPed)
				and not IsPedJumping(playerPed)
				and not IsPedJumpingOutOfVehicle(playerPed)
				and IsPedOnFoot(playerPed)
				and not IsPedRunning(playerPed)
				and not IsPedUsingAnyScenario(playerPed)
				and not IsPedInParachuteFreeFall(playerPed) then
			
				
				local targetPed = GetClosestPed()

				--SetEntityHealth(target, 0)

				--GetEntityPlayerIsFreeAimingAt
				
				--for key,value in pairs(bodyguards) do
					--value[1] -> ped, value[2] - > pedBlip
					--targetPed = value[1]
					local playerPos = GetEntityCoords(GetPlayerPed(-1))
					local pedPos = GetEntityCoords(targetPed)
					
					if GetDistanceBetweenCoords(playerPos['x'], playerPos['y'], playerPos['z'], pedPos['x'], pedPos['y'], pedPos['z'], 1) < 2.0 then
						local frontx = GetEntityForwardX(GetPlayerPed(-1))
						local fronty = GetEntityForwardY(GetPlayerPed(-1))
						local heading = GetEntityHeading(GetPlayerPed(-1))
						
		
						local _, gZ = GetGroundZFor_3dCoord( playerPos['x'] + (frontx+0.2), playerPos['y'] + (fronty+0.2), playerPos['z'] )
						
						SetEntityCoords(targetPed, playerPos['x'] + (frontx+0.2), playerPos['y'] + (fronty+0.2), gZ, 0, 0, 0, false)
						SetEntityHeading(targetPed, (heading - 180))
						
						RequestAnimDict("mp_ped_interaction")
						while not HasAnimDictLoaded("mp_ped_interaction") do
							Citizen.Wait(100)
						end

						TaskPlayAnim(targetPed,"mp_ped_interaction","hugs_guy_a",1.0,-1.0, 5000, 0, 1, true, true, true)						
						TaskPlayAnim(GetPlayerPed(-1),"mp_ped_interaction","hugs_guy_b",1.0,-1.0, 5000, 0, 1, true, true, true)		
					end
				--end
			end
		end
		
        if IsControlJustPressed(1, 46) then
			for key,value in pairs(bodyguards) do
				--value[1] -> ped, value[2] - > pedBlip
				if IsEntityDead(value[1]) then
					local playerPos = GetEntityCoords(GetPlayerPed(-1))
					local pedPos = GetEntityCoords(value[1])
					
					if GetDistanceBetweenCoords(playerPos['x'], playerPos['y'], playerPos['z'], pedPos['x'], pedPos['y'], pedPos['z'], 1) < 1.0 then
						ShowNotification("Reviving bodyguard...")
						
						TaskStartScenarioInPlace( GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
						
						Citizen.Wait(3000)
						
						--Revive
						SetEntityHealth( value[1], 200 )
						ResurrectPed( value[1] )
						SetEntityCollision(value[1], true, true)						
						ClearPedTasksImmediately( value[1] )
						ClearPedBloodDamage( value[1] )
						ClearPedLastDamageBone( value[1] )	
						SetEntityHealth(value[1], 200)
						SetPedMaxHealth(value[1], 200)	

						--local newPed = ClonePed(value[1], 0, true, true)
						
						--Delete old ped
						--DeleteEntity(value[1])
						--RemoveBlip(value[2])
						
						--Replace ped
						--value[1] = newPed
						--value[2] = AddBlipForEntity(newPed)
						

						RequestAnimDict("amb@world_human_stupor@male@exit")
						while not HasAnimDictLoaded("amb@world_human_stupor@male@exit") do
							Citizen.Wait(100)
						end
						TaskPlayAnim(value[1],"amb@world_human_stupor@male@exit","exit",1.0,-1.0, 5000, 0, 1, true, true, true)	
						
						SetBlipColour(value[2], 5)
						startFollowing( value[1] )
						
						ClearPedTasks(GetPlayerPed(-1))						
					end
				end
			end
        end		
    end
end)



Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(2000)		
		
		for key,value in pairs(bodyguards) do
			--value[1] -> ped, value[2] - > pedBlip
	
			if IsEntityDead(value[1]) then
			
				SetBlipColour(pedBlip, 19)
				Citizen.Wait(50000)	
				
				if IsEntityDead(value[1]) then
					DeleteEntity(value[1])
					RemoveBlip(value[2])
					
					table.remove(bodyguards, key)
				end
			end			
		end
		
		--local playerPed = GetPlayerPed(-1)

		--if IsEntityDead(playerPed) then
		--	playerDied();
		--end	
        
    end
end)




Citizen.CreateThread(function()
    -- main loop thing
    while true do
		Citizen.Wait(4000)		
		
		for key,value in pairs(bodyguards) do
			--value[1] -> ped, value[2] - > pedBlip
	
			if IsEntityDead(value[1]) then
			
				SetBlipColour(value[2], 19)
			end			
		end
		
		--local playerPed = GetPlayerPed(-1)

		--if IsEntityDead(playerPed) then
		--	playerDied();
		--end	
        
    end
end)