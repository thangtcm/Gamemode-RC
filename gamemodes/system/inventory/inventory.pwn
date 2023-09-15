#include <YSI_Coding\y_hooks>
#define MAX_INVENTORY (120)
#define MODEL_SELECTION_INVENTORY (1)

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

hook OnPlayerConnect(playerid)
{
	for(new i = 0; i != MAX_INVENTORY; i++)
	{
		InventoryData[playerid][i][invExists] = false;
		InventoryData[playerid][i][invModel] = 0;
		InventoryData[playerid][i][invQuantity] = 0;
	}
	PlayerInfo[playerid][pGiveItem] = INVALID_PLAYER_ID;
}

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
	printf("%d",itemid);
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
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);

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
		printf("%d", itemid);
		if(itemid != -1)
		{
			InventoryData[playerid][itemid][invExists] = true;
			InventoryData[playerid][itemid][invModel] = model;
			InventoryData[playerid][itemid][invQuantity] = quantity;

			strpack(InventoryData[playerid][itemid][invItem], item, 32 char);
            format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", PlayerSQLId, g_mysql_ReturnEscaped(item, MainPipeline), model, quantity);
			mysql_function_query(MainPipeline, string, false, "OnInventoryAdd", "ii", playerid, itemid);
			printf("[CREATE INVENTORY] %s (ID %d) da duoc them vao du lieu cua %s", item, itemid, GetPlayerNameEx(playerid));
			return itemid;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);

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
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		else if(quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		return 1;
	}
	return 0;
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
	if((extraid == MODEL_SELECTION_INVENTORY && response) && InventoryData[playerid][index][invExists])
	{
		new
			name[48];
		strunpack(name, InventoryData[playerid][index][invItem]);
		PlayerInfo[playerid][pInventoryItem] = index;

		format(name, sizeof(name), "%s (%d)", name, InventoryData[playerid][index][invQuantity]);
		Dialog_Show(playerid, Inventory, DIALOG_STYLE_LIST, name, "Su dung item\nCho item\nVut item", "Lua chon", "Huy bo");
	}
	return 1;
}

forward OpenInventory(playerid);
public OpenInventory(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;
	static
		items[MAX_INVENTORY],
		amounts[MAX_INVENTORY];

	for(new i = 0; i < PlayerInfo[playerid][pCapacity]; i++)
	{
		if (InventoryData[playerid][i][invExists])
		{
			items[i] = InventoryData[playerid][i][invModel];
			amounts[i] = InventoryData[playerid][i][invQuantity];
		}
		else
		{
			items[i] = -1;
			amounts[i] = -1;
		}
	}
	return ShowModelSelectionInventory(playerid, "Inventory", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          CMD
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CMD:setinventory(playerid, params[])
{
	static
		giveplayerid,
		capacity;

	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "dd", giveplayerid, capacity))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setinventory [playerid/name] [amount]");

	if(giveplayerid == INVALID_PLAYER_ID)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Nguoi choi khong hop le.");

	if(capacity < 1 || capacity > MAX_INVENTORY)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Item khong the duoi 1 hoac cao hon 120.");

	PlayerInfo[giveplayerid][pCapacity] = capacity;
	new string[128];
	format(string, sizeof(string), "Ban da cho %s so luong item %d.", GetPlayerNameEx(giveplayerid), capacity);
	SendClientMessageEx(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "%s da cho ban so luong item %d.", GetPlayerNameEx(playerid), capacity);
	SendClientMessageEx(giveplayerid, COLOR_YELLOW, string);
	return 1;
}

CMD:inventory(playerid, params[]) return cmd_inv(playerid, params);
CMD:inv(playerid, params[])
{
	if(PlayerInfo[playerid][pHospital])
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the mo tui do ngay bay gio.");

	if(PlayerInfo[playerid][pJailTime] > 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the mo tui do khi ban dang trong tu.");

	OpenInventory(playerid);
	return 1;
}

CMD:setitem(playerid, params[])
{
	static
		userid,
		item[32],
		amount;

	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "uds[32]", userid, amount, item))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setitem [playerid/name] [amount] [item name]");

	for(new i = 0; i < sizeof(g_aInventoryItems); i++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
	{
		if(!strcmp(item, "Dien thoai", true))
		{
			PlayerInfo[userid][pPhoneBook] = 1;
			PlayerInfo[userid][pPnumber] = random(90000) + 10000;
		}
		Inventory_Set(userid, g_aInventoryItems[i][e_InventoryItem], g_aInventoryItems[i][e_InventoryModel], amount);
		new string[128];
		format(string, sizeof(string), "Ban da cho %s item \"%s\" voi so luong %d.", GetPlayerNameEx(userid), item, amount);
		return SendClientMessageEx(playerid, COLOR_YELLOW, string);
	}
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "Item khong hop le (su dung [/itemlist] de xem).");
	return 1;
}

CMD:itemlist(playerid, params[])
{
	static
		string[1024];

	if(!strlen(string))
	{
		for(new i = 0; i < sizeof(g_aInventoryItems); i++)
		{
			format(string, sizeof(string), "%s%s\n", string, g_aInventoryItems[i][e_InventoryItem]);
		}
	}
	return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, "Item list", string, "Lua chon", "Huy bo");
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          INVENTORY
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dialog:ShowOnly(playerid, response, listitem, inputtext[])
{
	playerid = INVALID_PLAYER_ID;
	response = 0;
	listitem = 0;
	inputtext[0] = '\0';
}

Dialog:Inventory(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			itemid = PlayerInfo[playerid][pInventoryItem],
			itemName[64], str[128];

		strunpack(itemName, InventoryData[playerid][itemid][invItem]);

		switch(listitem)
		{
			case 0:
			{

				CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemid, itemName);
			}
			case 1:
			{
				PlayerInfo[playerid][pInventoryItem] = itemid;
				Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Cho item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");
			}
			case 2:
			{
				new id = -1;
				if(IsPlayerInAnyVehicle(playerid))
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the vut item ngay bay gio.");
				else
				{
					format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemid][invQuantity]);
					Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Vut Item", str, "Vut", "Huy bo");
				}
			}
		}
	}
	return 1;
}

Dialog:DropItem(playerid, response, listitem, inputtext[])
{
	new
		itemid = PlayerInfo[playerid][pInventoryItem],
		itemName[32], string[128];

	strunpack(itemName, InventoryData[playerid][itemid][invItem]);

	if(response)
	{
		if(isnull(inputtext))
		{
			format(string, sizeof(string), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemid][invQuantity]);
			return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Vut item", string, "Vut", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
		{
			format(string, sizeof(string), "So luong khong hop le.\n\nItem: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemid][invQuantity]);
			return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Vut item", string, "Vut", "Huy bo");
		}
		SendClientMessageEx(playerid, COLOR_YELLOW, "Chuc nang nay dang duoc bao tri, item cua ban se khong bi anh huong.");
	}
	return 1;
}

Dialog:GiveItem(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static
			userid = -1,
			itemid = -1,
		 itemName[32];

		if(sscanf(inputtext, "u", userid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(userid == INVALID_PLAYER_ID)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Nguoi choi khong hop le.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(!ProxDetectorS(6.0, playerid, userid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong dung gan nguoi choi do.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(userid == playerid)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong the dua item cho chinh minh.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		itemid = PlayerInfo[playerid][pInventoryItem];

		if(itemid == -1)
			return 0;

		strunpack(itemName, InventoryData[playerid][itemid][invItem]);

		if(InventoryData[playerid][itemid][invQuantity] == 1)
		{
			new id = Inventory_Add(userid, itemName, InventoryData[playerid][itemid][invModel]), str[560];
			if(id == -1)
				return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");
			format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(userid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), itemName);
			SendClientMessageEx(userid, COLOR_YELLOW, str);

			Inventory_Remove(playerid, itemName);
			new years,month,day,hourz,minz,sec,time[50];
			getdate(years,month,day);
			gettime(hourz,minz,sec);
			format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
			format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(userid), PlayerInfo[userid][pIP]);
			Log("logs/give_log.txt", str);
		}
		else
		{
			new str[128];
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong de dua item %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(userid));
			Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
			PlayerInfo[playerid][pGiveItem] = userid;
		}
	}
	return 1;
}

Dialog:GiveQuantity(playerid, response, listitem, inputtext[])
{
	if(response && PlayerInfo[playerid][pGiveItem] != INVALID_PLAYER_ID)
	{
		new
			userid = PlayerInfo[playerid][pGiveItem],
			itemid = PlayerInfo[playerid][pInventoryItem],
			itemName[32], str[560];

		strunpack(itemName, InventoryData[playerid][itemid][invItem]);

		if(isnull(inputtext))
		{
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(userid));
			return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
		{
			format(str, sizeof(str), "Ban khong co nhieu item.\n\nItem: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(userid));
			return  Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}

		new id = Inventory_Add(userid, itemName, InventoryData[playerid][itemid][invModel], strval(inputtext));

		if(id == -1)
			return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");

		format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(userid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), str);
		SendClientMessageEx(userid, COLOR_YELLOW, str);

		Inventory_Remove(playerid, itemName, strval(inputtext));
		new years,month,day,hourz,minz,sec,time[50];
		getdate(years,month,day);
		gettime(hourz,minz,sec);
		format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
		format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(userid), PlayerInfo[userid][pIP]);
		Log("logs/give_log.txt", str);
	}
	return 1;
}