----------------------------------------------------------------------
-- Thanks for supporting AngelicXS Scripts!							--
-- Support can be found at: https://discord.gg/tQYmqm4xNb			--
-- More paid scripts at: https://angelicxs.tebex.io/ 				--
-- More FREE scripts at: https://github.com/GouveiaXS/ 				--
----------------------------------------------------------------------

Config = {}


Config.UseESX = true						-- Use ESX Framework
Config.UseQBCore = false					-- Use QBCore Framework (Ignored if Config.UseESX = true)

Config.UseCustomNotify = false				-- Use a custom notification script, must complete event below.
-- Only complete this event if Config.UseCustomNotify is true; mythic_notification provided as an example
RegisterNetEvent('angelicxs-drugHarvest:CustomNotify')
AddEventHandler('angelicxs-drugHarvest:CustomNotify', function(message, type)
    --exports.mythic_notify:SendAlert(type, message, 4000)
end)

-- https://docs.fivem.net/docs/game-references/markers/
Config.Show3DMarker = false					-- If true, will have a 3D marker hover over the harvest locations
Config.MarkerIcon = 42						-- If Config.Show3DMarker = true, is the marker hovering over harvest location
Config.Show3DText = true					-- If true, will show 3D text when near harvest point.

-- animation/dictionary list found here: https://alexguirre.github.io/animations-list/
Config.HarvestList = {
	[1] = {
		harvestName = "Weed",												-- Visual name of item (also how item is stored in DB - ONLY 1 of each TYPE of gathering allowed)
		dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",			-- Animation dictionary
		animation = "operate_press_basicmould_v3_pressoperator",			-- Animation choice
		gatherTime = 15,													-- How long to gather the item in seconds
		gatherChance = 100,													-- Chance of successfully gathering the item
		requireItem = false,												-- If true, requires an item to harvest
		requiredItemName = 'water',											-- Name of the required item
		requriedItemAmount = 1,												-- Amount needed of the required item
		removeRequireItem = false,											-- If true, removes the required item(s)
		itemRecieved = 'weed',												-- Name of item received
		itemAmount = 1,														-- How many items are recevied after a successful gather
		pickLocations = {													-- Locations they can harvest the item (must be AT LEAST 5 units apart)
			vector3(343.4191, -1389.8660, 32.5093),
			vector3(334.3511, -1384.7357, 32.5092),
		},
	},
	[2] = {
		harvestName = "Cocaine",											-- Visual name of item (also how item is stored in DB - ONLY 1 of each TYPE of gathering allowed)
		dictionary = "anim@amb@business@coc@coc_packing@",			-- Animation dictionary
		animation = "fill_basicmould_v1_pressoperator",							-- Animation choice
		gatherTime = 5,														-- How long to gather the item in seconds
		gatherChance = 50,													-- Chance of successfully gathering the item
		requireItem = false,													-- If true, requires an item to harvest
		requiredItemName = 'water',											-- Name of the required item
		requriedItemAmount = 1,												-- Amount needed of the required item
		removeRequireItem = true,											-- If true, removes the required item(s)
		itemRecieved = 'bread',											-- Name of item received
		itemAmount = 1,														-- How many items are recevied after a successful gather
		pickLocations = {													-- Locations they can harvest the item (must be AT LEAST 5 units apart)
			vector3(334.1769, -1399.1890, 32.5092),
			vector3(4,5,6),
		},
	},
	[3] = {
		harvestName = "Meth",												-- Visual name of item (also how item is stored in DB - ONLY 1 of each TYPE of gathering allowed)
		dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",			-- Animation dictionary
		animation = "machinic_loop_mechandplayer",							-- Animation choice
		gatherTime = 5,														-- How long to gather the item in seconds
		gatherChance = 50,													-- Chance of successfully gathering the item
		requireItem = false,												-- If true, requires an item to harvest
		requiredItemName = 'water',											-- Name of the required item
		requriedItemAmount = 1,												-- Amount needed of the required item
		removeRequireItem = true,											-- If true, removes the required item(s)
		itemRecieved = 'meth',												-- Name of item received
		itemAmount = 1,														-- How many items are recevied after a successful gather
		pickLocations = {													-- Locations they can harvest the item (must be AT LEAST 5 units apart)
			vector3(324.2972, -1391.2141, 32.5092),
			vector3(4,5,6),
		},
	},
}


-- Language Configuration
Config.LangType = {
	['error'] = 'error',
	['success'] = 'success',
	['info'] = 'primary'
}

Config.Lang = {
	['harvest'] = 'Press ~r~[E]~w~ to begin harvesting.',
	['harvest_collect'] = 'You have successfully gathered the ',
	['harvest_fail'] = 'You have failed to gather the ',
	['no_item'] = 'You do not have the required item to harvest this!',
}