#include <YSI\y_hooks>
#define MAX_INVENTORY (120)

enum inventoryData
{
	invExists,
	invID,
	invItem[32 char],
	invModel,
	invQuantity
};

enum e_InventoryItems
{
	e_InventoryItem[32],
	e_InventoryModel
};

new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
forward OnLoadInventory(playerid);
forward OnInventoryAdd(playerid, itemid);
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Marijuana", 1578},
	{"Cocaine", 1575},
	{"Heroin", 1577},
	{"Steroids", 1241},
	{"Marijuana Seeds", 1578},
	{"Cocaine Seeds", 1575},
	{"Heroin Opium Seeds", 1577},
	{"Golf Club", 333},
	{"Knife", 335},
	{"Shovel", 337},
	{"Katana", 339},
	{"Colt 45", 346},
	{"Desert Eagle", 348},
	{"Micro SMG", 352},
	{"Tec-9", 372},
	{"MP5", 353},
	{"Shotgun", 349},
	{"AK-47", 355},
	{"M4", 356},
	{"Rifle", 357},
	{"Sniper", 358},
	{"Magazine", 2039},
	{"Burger", 2703},
	{"Pizza", 2702},
	{"Bang lai xe oto", 1581},
	{"Dien thoai", 330},
	{"GPS", 18875},
	{"Binh son", 365},
	{"Nuoc uong", 2958},
	{"Soda", 1543},
    {"Binh xang", 1650},
	{"Xa beng", 18634},
	{"Boombox", 2226},
	{"Mask", 19036},
	{"Medkit", 1580},
	{"Bo dung cu", 920},
	{"Nitro", 1010},
	{"Ammo Cartridge", 2358},
	{"Armored Vest", 19142},
	{"Cardboard", 928},
	{"Radio", 18868},
	{"But", 322},
	{"Bat lua", 19998},
	{"Tua vit", 18644},
	{"The ngan hang", 1581},
	{"Bang lai xe moto", 1581},
	{"Bang lai xe truck", 1581},
	{"Bang lai may bay", 1581},
	{"Bang lai truc thang", 1581},
	{"Giay phep sung B", 1581},
	{"Giay phep sung C", 1581}
};

stock Inventory_Load(playerid)
{
    new PlayerSQLId = GetPlayerSQLId(playerid),
        str[1080];
    format(str, sizeof(str), "SELECT * FROM `inventory` WHERE `ID` = '%d'", PlayerSQLId);
    mysql_function_query(MainPipeline, str, true, "OnLoadInventory", "i", playerid);
}

public OnLoadInventory(playerid)
{
    new i, rows, fields, tmp[128];
    cache_get_data(rows, fields, MainPipeline);
    while(i < rows)
    {
        cache_get_field_content(i, "invID", tmp, MainPipeline); InventoryData[playerid][i][invID] = strval(tmp);
        cache_get_field_content(i, "invModel", tmp, MainPipeline); InventoryData[playerid][i][invModel] = strval(tmp);
        cache_get_field_content(i, "invQuantity", tmp, MainPipeline); InventoryData[playerid][i][invQuantity] = strval(tmp);
        cache_get_field_content(i, "invItem", tmp, MainPipeline); InventoryData[playerid][i][invItem] = strval(tmp);
        InventoryData[playerid][i][invExists] = true;
        i++;
    }
    if(i > 0) printf("[LOAD INVENTORY]  du lieu inventory cua %s (ID: %d) da duoc tai.", GetPlayerNameEx(playerid), playerid);
}

public OnInventoryAdd(playerid, itemid)
{
	InventoryData[playerid][itemid][invID] = mysql_insert_id(MainPipeline);
	return 1;
}

stock Inventory_Clear(playerid)
{
	static
		string[64];
    new PlayerSQLId = GetPlayerSQLId(playerid);
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(InventoryData[playerid][i][invExists])
		{
			InventoryData[playerid][i][invExists] = 0;
			InventoryData[playerid][i][invModel] = 0;
			InventoryData[playerid][i][invQuantity] = 0;
		}
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerSQLId);
	return mysql_tquery(g_iHandle, string);
}

stock Inventory_Set(playerid, item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if(itemid == -1 && amount > 0)
		Inventory_Add(playerid, item, model, amount);

	else if(amount > 0 && itemid != -1)
		Inventory_SetQuantity(playerid, item, amount);

	else if(amount < 1 && itemid != -1)
		Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_GetItemID(playerid, item[])
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;

		if(!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if(Inventory_Items(playerid) >= PlayerInfo[playerid][pCapacity])
		return -1;

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
	new count;

	for(new i = 0; i != MAX_INVENTORY; i++) if(InventoryData[playerid][i][invExists])
	{
		count++;
	}
	return count;
}

stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if(itemid != -1)
		return InventoryData[playerid][itemid][invQuantity];

	return 0;
}

stock Inventory_HasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_SetQuantity(playerid, item[], quantity)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(itemid != -1)
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
		mysql_tquery(g_iHandle, string);

		InventoryData[playerid][itemid][invQuantity] = quantity;
	}
	return 1;
}

stock Inventory_Add(playerid, item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(itemid == -1)
	{
		itemid = Inventory_GetFreeID(playerid);

		if(itemid != -1)
		{
			InventoryData[playerid][itemid][invExists] = true;
			InventoryData[playerid][itemid][invModel] = model;
			InventoryData[playerid][itemid][invQuantity] = quantity;

			strpack(InventoryData[playerid][itemid][invItem], item, 32 char);
            format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", PlayerSQLId, item, model, quantity);
            mysql_tquery(g_iHandle, string, "OnInventoryAdd", "dd", playerid, itemid);
			return itemid;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
		mysql_tquery(g_iHandle, string);

		InventoryData[playerid][itemid][invQuantity] += quantity;
	}
	return itemid;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(itemid != -1)
	{
		if(InventoryData[playerid][itemid][invQuantity] > 0)
		{
			InventoryData[playerid][itemid][invQuantity] -= quantity;
		}
		if(quantity == -1 || InventoryData[playerid][itemid][invQuantity] < 1)
		{
			InventoryData[playerid][itemid][invExists] = false;
			InventoryData[playerid][itemid][invModel] = 0;
			InventoryData[playerid][itemid][invQuantity] = 0;

			format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerSQLId, InventoryData[playerid][itemid][invID]);
			mysql_tquery(g_iHandle, string);
		}
		else if(quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
			mysql_tquery(g_iHandle, string);
		}
		return 1;
	}
	return 0;
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          DROP
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
DropPlayerItem(playerid, itemid, quantity = 1)
{
	if(itemid == -1 || !InventoryData[playerid][itemid][invExists])
		return 0;

	new
		Float:x,
		Float:y,
		Float:z,
		Float:angle,
		string[32];

	strunpack(string, InventoryData[playerid][itemid][invItem]);

	if(InventoryData[playerid][itemid][invQuantity] < 2)
	{
		if(!strcmp(string, "Colt 45") && PlayerData[playerid][pHoldWeapon] == 22)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "Desert Eagle") && PlayerData[playerid][pHoldWeapon] == 24)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "Shotgun") && PlayerData[playerid][pHoldWeapon] == 25)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "Micro SMG") && PlayerData[playerid][pHoldWeapon] == 28)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "MP5") && PlayerData[playerid][pHoldWeapon] == 29)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "Tec-9") && PlayerData[playerid][pHoldWeapon] == 32)
			HoldWeapon(playerid, 0);

		else if(!strcmp(string, "AK-47") && PlayerData[playerid][pHoldWeapon] == 30)
			HoldWeapon(playerid, 0);

        else if(!strcmp(string, "M4") && PlayerData[playerid][pHoldWeapon] == 31)
			HoldWeapon(playerid, 0);

	 	else if(!strcmp(string, "Rifle") && PlayerData[playerid][pHoldWeapon] == 33)
		 	HoldWeapon(playerid, 0);

		else if(!strcmp(string, "Sniper") && PlayerData[playerid][pHoldWeapon] == 34)
			HoldWeapon(playerid, 0);
	}
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	DropItem(string, ReturnName(playerid, 0), InventoryData[playerid][itemid][invModel], quantity, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	Inventory_Remove(playerid, string, quantity);

	ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s da vut item \"%s\" xuong dat.", ReturnName(playerid, 0), string);
	return 1;
}

IsWeaponModel(model)
{
	new const g_aWeaponModels[] =
	{
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
	};
	for(new i = 0; i < sizeof(g_aWeaponModels); i++) if(g_aWeaponModels[i] == model)
	{
		return 1;
	}
	return 0;
}

GetWeaponModel(weaponid)
{
	new const g_aWeaponModels[] =
	{
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
	};
	if (1 <= weaponid <= 46)
		return g_aWeaponModels[weaponid];

	return 0;
}

DropItem(item[], player[], model, quantity, Float:x, Float:y, Float:z, interior, world, weaponid = 0, ammo = 0)
{
	new
		query[300];

	for(new i = 0; i != MAX_DROPPED_ITEMS; i++) if(!DroppedItems[i][droppedModel])
	{
		format(DroppedItems[i][droppedItem], 32, item);
		format(DroppedItems[i][droppedPlayer], 24, player);

		DroppedItems[i][droppedModel] = model;
		DroppedItems[i][droppedQuantity] = quantity;
		DroppedItems[i][droppedWeapon] = weaponid;
		DroppedItems[i][droppedAmmo] = ammo;
		DroppedItems[i][droppedPos][0] = x;
		DroppedItems[i][droppedPos][1] = y;
		DroppedItems[i][droppedPos][2] = z;

		DroppedItems[i][droppedInt] = interior;
		DroppedItems[i][droppedWorld] = world;

		if(IsWeaponModel(model))
		{
			DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 93.7, 120.0, 120.0, world, interior);
		}
		else
		{
			DroppedItems[i][droppedObject] = CreateDynamicObject(model, x, y, z, 0.0, 0.0, 0.0, world, interior);
		}
 		DroppedItems[i][droppedText3D] = CreateDynamic3DTextLabel(item, COLOR_CYAN, x, y, z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior);

		if(strcmp(item, "Demo Soda") != 0)
		{
			format(query, sizeof(query), "INSERT INTO `dropped` (`itemName`, `itemPlayer`, `itemModel`, `itemQuantity`, `itemWeapon`, `itemAmmo`, `itemX`, `itemY`, `itemZ`, `itemInt`, `itemWorld`) VALUES('%s', '%s', '%d', '%d', '%d', '%d', '%.4f', '%.4f', '%.4f', '%d', '%d')", item, player, model, quantity, weaponid, ammo, x, y, z, interior, world);
			mysql_tquery(g_iHandle, query, "OnDroppedItem", "d", i);
		}
		return i;
	}
	return -1;
}

Item_Nearest(playerid)
{
	for(new i = 0; i != MAX_DROPPED_ITEMS; i++) if(DroppedItems[i][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[i][droppedPos][0], DroppedItems[i][droppedPos][1], DroppedItems[i][droppedPos][2]))
	{
		if(GetPlayerInterior(playerid) == DroppedItems[i][droppedInt] && GetPlayerVirtualWorld(playerid) == DroppedItems[i][droppedWorld])
			return i;
	}
	return -1;
}

Item_SetQuantity(itemid, amount)
{
	new
		string[64];

	if(itemid != -1 && DroppedItems[itemid][droppedModel])
	{
		DroppedItems[itemid][droppedQuantity] = amount;

		format(string, sizeof(string), "UPDATE `dropped` SET `itemQuantity` = %d WHERE `ID` = '%d'", amount, DroppedItems[itemid][droppedID]);
		mysql_tquery(g_iHandle, string);
	}
	return 1;
}

Item_Delete(itemid)
{
	static
		query[64];

	if(itemid != -1 && DroppedItems[itemid][droppedModel])
	{
		DroppedItems[itemid][droppedModel] = 0;
		DroppedItems[itemid][droppedQuantity] = 0;
		DroppedItems[itemid][droppedPos][0] = 0.0;
		DroppedItems[itemid][droppedPos][1] = 0.0;
		DroppedItems[itemid][droppedPos][2] = 0.0;
		DroppedItems[itemid][droppedInt] = 0;
		DroppedItems[itemid][droppedWorld] = 0;

		DestroyDynamicObject(DroppedItems[itemid][droppedObject]);
		DestroyDynamic3DTextLabel(DroppedItems[itemid][droppedText3D]);

		format(query, sizeof(query), "DELETE FROM `dropped` WHERE `ID` = '%d'", DroppedItems[itemid][droppedID]);
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

PickupItem(playerid, itemid)
{
	if(itemid != -1 && DroppedItems[itemid][droppedModel])
	{
		new id = Inventory_Add(playerid, DroppedItems[itemid][droppedItem], DroppedItems[itemid][droppedModel], DroppedItems[itemid][droppedQuantity]);

		if(id == -1)
			return SendErrorMessage(playerid, "Ban khong con slot trong tui do.");

		Item_Delete(itemid);
	}
	return 1;
}*/