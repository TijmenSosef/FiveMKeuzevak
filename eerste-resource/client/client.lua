QBCore = exports['qb-core']:GetCoreObject()
ContractItem = "cocaine_bag"
PlayerInContract = false

-- start npc
CreateThread(function()
	local NPC_contractor = exports['qb-target']:SpawnPed({
		model = "u_m_y_pogo_01",
		coords = vector4(-28.39, -1093.92, 26.42, 27.02),
		minusOne = true,
		spawnNow = true,
		freeze = true,
		invincible = true,
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = {
			useModel = false,
			options = {
				{
					icon = 'fas fa-car',
					label = '(Start contract) - Pak Neon',
					action = function()
						TriggerServerEvent('eerste-resource:server:betaalBorg')
						SpawnCrackHead()
						SetNewWaypoint(497.73, -634.86)
						PlayerInContract = true
					end
				},
				{
					icon = 'fas fa-car',
					label = 'Finish contract',
					action = function()
						if QBCore.Functions.HasItem(ContractItem) then
							QBCore.Functions.Notify('Contract complete', 'success')
							TriggerServerEvent('eerste-resource:server:finishContract', ContractItem)
							PlayerInContract = false
						else
							QBCore.Functions.Notify('You do not have the contract item', 'error')
						end
					end
				},
				{
					icon = 'fas fa-car',
					label = 'Return Neon',
					action = function()
						if IsPedInAnyVehicle(PlayerPedId(), true) then
							TriggerServerEvent('eerste-resource:server:returnBorg')
							DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
						else
							QBCore.Functions.Notify('Please enter verchile to return', 'success')
						end
					end
				}
			},
			distance = 2.5,
		},
	})
end)

-- Crackhead npc
function SpawnCrackHead()
	CreateThread(function()
		local pedModel = "a_m_y_acult_02"
		local pedCoords = vector4(495.85, -631.59, 23.87, 229.77)

		RequestModel(GetHashKey(pedModel))
		while not HasModelLoaded(GetHashKey(pedModel)) do
			Wait(10)
		end

		NPC_crackhead = CreatePed(4, GetHashKey(pedModel), pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, true, true)
		SetEntityAsMissionEntity(NPC_crackhead, true, true)
		SetModelAsNoLongerNeeded(GetHashKey(pedModel))
		SetBlockingOfNonTemporaryEvents(NPC_crackhead, true)
		TaskStartScenarioInPlace(NPC_crackhead, 'WORLD_HUMAN_BUM_FREEWAY', 0, false)
		SetPedHasAiBlip(NPC_crackhead, true)
		SetPedAiBlipForcedOn(NPC_crackhead, true)

		Wait(500)

		while true do
			Wait(500)
			if IsPedDeadOrDying(NPC_crackhead, true) then
				SetEntityAsMissionEntity(NPC_crackhead, false, false)
				QBCore.Functions.Notify('Return to contractor', 'success')
				SetNewWaypoint(-31.33, -1088.87)
				TriggerServerEvent('eerste-resource:server:giveItem', ContractItem, 1)
				break
			end
		end
	end)
end
