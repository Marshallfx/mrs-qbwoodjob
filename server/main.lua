QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('mrs-woodjob:server:odunver')
AddEventHandler('mrs-woodjob:server:odunver', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local miktar = math.random(2,6)  --- miktar burdan ayarlanabilir.
    if Player ~= nil then   
        Player.Functions.AddItem('wood', miktar)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wood'], 'add')
    end
end)

RegisterServerEvent('mrs-woodjob:server:odunisle')
AddEventHandler('mrs-woodjob:server:odunisle', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cuttedwood = 'cutted_wood'
    local odun = 'wood'

    if Player ~= nil then
        Player.Functions.RemoveItem('wood', 1)
        Player.Functions.AddItem('phone', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[odun], 'remove')
    end
end)
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2mrs-woodjob^0] - Script başlatıldı!')
	end
end)