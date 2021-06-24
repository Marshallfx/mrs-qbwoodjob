QBCore = nil 

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(31)
	end
end)


CreateThread(function()
    while true do
        sleep = 2000
        for k in pairs(Config.odunbolge) do
            local ped = PlayerPedId()
            local kordinat = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(kordinat, Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z, false)
            if distance < 4 then
                sleep = 4
                DrawMarker(2, Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)
                if distance < 1.40 then
                    DrawText3Ds(Config.odunbolge[k].x, Config.odunbolge[k].y, Config.odunbolge[k].z + 0.5, '[E] Kütük Parçala')
                    if IsControlJustReleased(0, 38) then
                        QBCore.Functions.Progressbar("odunkes", "Odun kesiyorsun", math.random(8000, 15000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "amb@world_human_hammering@male@base",
                            anim = "base",
                            flags = 49,
                        }, {
                            model = "prop_tool_fireaxe",
                            bone = 57005,
                            coords = { x = 0.05, y = -0.4, z = -0.10 },
                            rotation = { x = 80.0, y = -20.0, z = 175.0 },
                        }, {}, function() -- Done
                            StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            ClearPedTasksImmediately(ped)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('mrs-woodjob:server:odunver')
                            QBCore.Functions.Notify("Odun elde ettin!", "success")
                        end, function() -- Cancel
                            StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            ClearPedTasksImmediately(ped)
                            ClearPedTasks(PlayerPedId())
                            QBCore.Functions.Notify("Eylem iptal ediliyor..", "error")
                        end)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end) 

CreateThread(function()
    while true do
        sleep = 2000
        for k in pairs(Config.odunislemebolge) do
            local ped = PlayerPedId()
            local kordinat = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(kordinat, Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z, false)
            if distance < 4 then
                sleep = 4
                DrawMarker(2, Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)
                if distance < 1.40 then
                    DrawText3Ds(Config.odunislemebolge[k].x, Config.odunislemebolge[k].y, Config.odunislemebolge[k].z + 0.5, '[E] Odun Parçala')
                    if IsControlJustReleased(0, 38) then
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FIRE", 0, true)
                        QBCore.Functions.Progressbar("test", "Odun parçalıyorsun", math.random(4000, 5000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            StopAnimTask(GetPlayerPed(-1))
                            ClearPedTasksImmediately(ped)
                            ClearPedTasks(PlayerPedId())
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                            TriggerServerEvent('mrs-woodjob:server:odunisle')
                            QBCore.Functions.Notify("Odun parçalandı!", "success")
                                else
                                    QBCore.Functions.Notify("Üzerinde odun yok!", "error")
                                end
                            end, 'wood')

                        end, function() -- Cancel
                            StopAnimTask(GetPlayerPed(-1))
                            ClearPedTasksImmediately(ped)
                            ClearPedTasks(PlayerPedId())
                            QBCore.Functions.Notify("Eylem iptal ediliyor..", "error")
                        end)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end) 

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end