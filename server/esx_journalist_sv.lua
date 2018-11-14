ESX = nil
local debug = Config.debug

local playersInterimHarvest = {}
local playersInterimHarvestExit = {}

local playersInterimSell = {}
local playersInterimSellExit = {}

local playersJournalistHarvest = {}
local playersJournalistHarvestExit = {}

local playersJournalistSell = {}
local playersJournalistSellExit = {}

-- debug msg
function printDebug(msg)
  if Config.debug then print('[esx_journalist]\t'.. msg) end
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'journalist', 'Client Weazel News', false, false)
TriggerEvent('esx_society:registerSociety', 'journalist', 'Weazel News', 'society_weazel', 'society_weazel', 'society_weazel', {type = 'private'})

-- get Storage
ESX.RegisterServerCallback('esx_journalist:getStockItems', function(source, cb)
  printDebug('getStockItems')
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    cb(inventory.items)
  end)
end)
RegisterServerEvent('esx_journalist:getStockItem')
AddEventHandler('esx_journalist:getStockItem', function(itemName, count)
  printDebug('getStockItem')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    local item = inventory.getItem(itemName)
    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
  end)
end)
-- put Storage 
ESX.RegisterServerCallback('esx_journalist:getPlayerInventory', function(source, cb)
  printDebug('getPlayerInventory')
  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)
RegisterServerEvent('esx_journalist:putStockItems')
AddEventHandler('esx_journalist:putStockItems', function(itemName, count)
  printDebug('putStockItems')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count
    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
  end)
end)

-- interim harvest
function interimHarvest(source)
  printDebug('interimHarvest')
  SetTimeout(Config.iItemTime, function()
    if playersInterimHarvestExit[source] then playersInterimHarvest[source] = false end
    if playersInterimHarvest[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local bag = xPlayer.getInventoryItem(Config.iItemDb_name)
      local quantity = bag.count
      if quantity >= bag.limit then
        TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
        playersInterimHarvest[source] = false
      else
        xPlayer.addInventoryItem(Config.iItemDb_name, Config.iItemAdd)
        if quantity < bag.limit + Config.iItemAdd then
          interimHarvest(source)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
          playersInterimHarvest[source] = false
        end
      end
    else 
      TriggerClientEvent('esx:showNotification', source, _U('harvest_fail')) 
      playersInterimHarvest[source] = false
    end
  end)
end
RegisterServerEvent('esx_journalist:startInterimHarvest')
AddEventHandler('esx_journalist:startInterimHarvest', function()
  printDebug('startInterimHarvest')
  local _source = source
  if not playersInterimHarvest[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('harvest_start'))
    playersInterimHarvest[_source] = true
    playersInterimHarvestExit[_source] = false
    interimHarvest(_source)
  end
  if playersInterimHarvestExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent('esx_journalist:stopInterimHarvest')
AddEventHandler('esx_journalist:stopInterimHarvest', function()
  printDebug('stopInterimHarvest')
  local _source = source
  if playersInterimHarvest[_source] then playersInterimHarvestExit[_source] = true end
end)
-- interim sell
function interimSell(source)
  printDebug('interimSell')
  SetTimeout(Config.iItemTime, function()
    if playersInterimSellExit[source] then playersInterimSell[source] = false end
    if playersInterimSell[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local quantity = xPlayer.getInventoryItem(Config.iItemDb_name).count
      if quantity < Config.iItemRemove then
        TriggerClientEvent('esx:showNotification', source, _U('no_item_to_sell', Config.iItemDb_name))
        playersInterimSell[source] = false
      else
        xPlayer.removeInventoryItem(Config.iItemDb_name, Config.iItemRemove)
        local employeePrice = Config.iItemPrice
        local companyPrice = math.floor(employeePrice * Config.iCompanyRate)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weazel', function(compAccount)
          compAccount.addMoney(companyPrice)
          xPlayer.addMoney(employeePrice)
          TriggerClientEvent('esx:showNotification', source, _U('you_earned', employeePrice))
          TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', companyPrice))
        end)
        local gouvTaxe = math.floor(companyPrice * Config.gouvRate)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxe_weazel', function(taxeAccount)
          taxeAccount.addMoney(gouvTaxe)
        end)
        TriggerClientEvent('esx_journalist:nextBoxes', source)
      end
      playersInterimSell[source] = false
    else TriggerClientEvent('esx:showNotification', source, _U('sell_fail')) end
  end)
end
RegisterServerEvent('esx_journalist:startInterimSell')
AddEventHandler('esx_journalist:startInterimSell', function()
  printDebug('startInterimSell')
  local _source = source
  if not playersInterimSell[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('sell_start'))
    playersInterimSell[_source] = true
    playersInterimSellExit[_source] = false
    interimSell(_source)
  end
  if playersInterimSellExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent('esx_journalist:stopInterimSell')
AddEventHandler('esx_journalist:stopInterimSell', function()
  printDebug('stopInterimSell')
  local _source = source
  if playersInterimSell[_source] then playersInterimSellExit[_source] = true end
end)

-- journalist harvest
function journalistHarvest(source)
  printDebug('journalistHarvest')
  SetTimeout(Config.iItemTime, function()
    if playersJournalistHarvestExit[source] then playersJournalistHarvest[source] = false end
    if playersJournalistHarvest[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local bag = xPlayer.getInventoryItem(Config.jItemDb_name)
      local quantity = bag.count
      if quantity >= bag.limit then
        TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
        playersJournalistHarvest[source] = false
      else
        xPlayer.addInventoryItem(Config.jItemDb_name, Config.jItemAdd)
        if quantity < bag.limit + Config.jItemAdd then
          journalistHarvest(source)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
          playersJournalistHarvest[source] = false
        end
      end
    else 
      TriggerClientEvent('esx:showNotification', source, _U('harvest_fail')) 
      playersJournalistHarvest[source] = false
    end
  end)
end
RegisterServerEvent('esx_journalist:startJournalistHarvest')
AddEventHandler('esx_journalist:startJournalistHarvest', function()
  printDebug('startJournalistHarvest')
  local _source = source
  if not playersJournalistHarvest[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('harvest_start'))
    playersJournalistHarvest[_source] = true
    playersJournalistHarvestExit[_source] = false
    journalistHarvest(_source)
  end
  if playersJournalistHarvestExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent('esx_journalist:stopJournalistHarvest')
AddEventHandler('esx_journalist:stopJournalistHarvest', function()
  printDebug('stopJournalistHarvest')
  local _source = source
  if playersJournalistHarvest[_source] then playersJournalistHarvestExit[_source] = true end
end)

-- journalist sell
function journalistSell(source)
  printDebug('journalistSell')
  SetTimeout(Config.iItemTime, function()
    if playersJournalistSellExit[source] then playersJournalistSell[source] = false end
    if playersJournalistSell[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local quantity = xPlayer.getInventoryItem(Config.jItemDb_name).count
      if quantity < Config.iItemRemove then
        TriggerClientEvent('esx:showNotification', source, _U('no_item_to_sell', Config.jItemDb_name))
        playersJournalistSell[source] = false
      else
        xPlayer.removeInventoryItem(Config.jItemDb_name, Config.jItemRemove)
        local employeePrice = Config.jItemPrice
        local companyPrice = math.floor(employeePrice * Config.jCompanyRate)
        local gouvTaxe = math.floor(companyPrice * Config.gouvRate)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weazel', function(compAccount)
          compAccount.addMoney(companyPrice)
          xPlayer.addMoney(employeePrice)
          TriggerClientEvent('esx:showNotification', source, _U('you_earned', employeePrice))
          TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', companyPrice))
        end)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxe_weazel', function(taxeAccount)
          taxeAccount.addMoney(gouvTaxe)
        end)
        TriggerClientEvent('esx_journalist:nextBoxes', source)
      end
      playersJournalistSell[source] = false
    else TriggerClientEvent('esx:showNotification', source, _U('sell_fail')) end
  end)
end

RegisterServerEvent('esx_journalist:startJournalistSell')
AddEventHandler('esx_journalist:startJournalistSell', function()
  printDebug('startJournalistSell')
  local _source = source
  if not playersJournalistSell[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('sell_start'))
    playersJournalistSell[_source] = true
    playersJournalistSellExit[_source] = false
    journalistSell(_source)
  end
  if playersJournalistSellExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent('esx_journalist:stopJournalistSell')
AddEventHandler('esx_journalist:stopJournalistSell', function()
  printDebug('stopJournalistSell')
  local _source = source
  if playersJournalistSell[_source] then playersJournalistSellExit[_source] = true end
end)

