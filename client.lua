local PERPGamer_HoverOn = false

RegisterCommand('hover', function()
  local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped,true)
	if GetVehicleClass(vehicle) == 15 then
		PERPGamer_HoverOn = not PERPGamer_HoverOn
		if PERPGamer_HoverOn then
			Citizen.CreateThread(function()
				HelpMessage('Auto Hover has been ~g~Engaged', false, true, 8000)
				while GetVehiclePedIsIn(ped,true) == vehicle and PERPGamer_HoverOn and GetHeliMainRotorHealth(vehicle) > 0 and GetHeliTailRotorHealth(vehicle) > 0 and GetVehicleEngineHealth(vehicle) > 300 do Citizen.Wait(0)
				local currentvelocity = GetEntityVelocity(vehicle)
				SetEntityVelocity(vehicle, currentvelocity.x, currentvelocity.y, 0.0)
				end
				HelpMessage('Auto Hover has been ~r~Disengaged', false, true, 8000)
				PERPGamer_HoverOn = false
			end)
		else
			HelpMessage('Auto Hover has been ~r~Disengaged', false, true, 8000)
		end
	end
end)

RegisterKeyMapping('hover', 'Heli Hover', 'keyboard', '')

function HelpMessage(msg, thisFrame, beep, duration)
	AddTextEntry('PERPHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('PERPHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('PERPHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end
