#include <YSI_Coding\y_hooks>
#include "./system/inventory/inventoryitem.pwn"
#define MAX_INVENTORY (120)
#define MODEL_SELECTION_INVENTORY (1)

enum inventoryData
{
	invExists,
	invID,
	invItem[32],
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
forward OnInventoryAdd(playerid, itemid, index, timer);
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Pickaxe", 2228},
	{"Dien thoai", 330},
	{"GPS", 18875},
    {"Binh xang", 1650},
	{"Boombox", 2226},
	{"Radio", 18868},
	{"Pizza", 2702},
	{"Hamburger", 19094},
	{"Bread", 19579},
	{"Juice", 19562},
	{"Beer", 1544},
	{"Da", 905},
	{"Dong", 2952},
	{"Sat", 19845},
	{"Vang", 19941}
};

hook OnPlayerConnect(playerid)
{
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
	for(new index = 0; index != MAX_INVENTORY; index++)
	{
		InventoryData[playerid][index][invExists] = false;
		InventoryData[playerid][index][invModel] = 0;
		InventoryData[playerid][index][invQuantity] = 0;
	}
    while(i < rows)
    {
        cache_get_field_content(i, "invID", tmp, MainPipeline); InventoryData[playerid][i][invID] = strval(tmp);
        cache_get_field_content(i, "invModel", tmp, MainPipeline); InventoryData[playerid][i][invModel] = strval(tmp);
        cache_get_field_content(i, "invQuantity", tmp, MainPipeline); InventoryData[playerid][i][invQuantity] = strval(tmp);
        cache_get_field_content(i, "invItem", InventoryData[playerid][i][invItem], MainPipeline, 32); 
        InventoryData[playerid][i][invExists] = true;
        i++;
    }
    if(i > 0) printf("[LOAD INVENTORY]  du lieu inventory cua %s (ID: %d) da duoc tai.", GetPlayerNameEx(playerid), playerid);
	ITEMTIMER_LOAD(playerid);
}

public OnInventoryAdd(playerid, itemid, index, timer)
{
	InventoryData[playerid][itemid][invExists] = true;
	InventoryData[playerid][itemid][invID] = mysql_insert_id(MainPipeline);
	if(timer != 0)	ITEMTIMER_ADD(playerid, index, InventoryData[playerid][itemid][invQuantity], timer);
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

stock Inventory_Set(playerid, index, amount, timer)
{
	new itemid = Inventory_GetItemID(playerid, index);
	if(itemid == -1 && amount > 0)
		Inventory_Add(playerid, index, amount, timer);

	else if(amount > 0 && itemid != -1)
		Inventory_SetQuantity(playerid, index, amount, timer);

	else if(amount < 1 && itemid != -1)
		Inventory_Remove(playerid, index, amount);

	return 1;
}

stock Inventory_GetItemID(playerid, index, amount = -1)
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;
		if(amount != -1 && InventoryData[playerid][i][invQuantity] >= amount && !strcmp(InventoryData[playerid][i][invItem], g_aInventoryItems[index][e_InventoryItem]))
			return i;
		if(!strcmp(InventoryData[playerid][i][invItem], g_aInventoryItems[index][e_InventoryItem]) && amount == -1) 
			return i;
	}
	return -1;
}

stock Inventory_GetItemIndex(name[])
{
	for(new i = 0; i < sizeof(g_aInventoryItems); i++)
	{
		if(!strcmp(name, g_aInventoryItems[i][e_InventoryItem])) return i;
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

stock Inventory_Count(playerid, index)
{
	new itemid = Inventory_GetItemID(playerid, index);

	if(itemid != -1)
		return InventoryData[playerid][itemid][invQuantity];

	return 0;
}

stock Inventory_HasItem(playerid, index, amount = -1)
{
	return (Inventory_GetItemID(playerid, index, amount) != -1);
}

stock Inventory_SetQuantity(playerid, index, quantity, timer)
{
	new
		itemid = Inventory_GetItemID(playerid, index),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(itemid != -1)
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryData[playerid][itemid][invQuantity] += quantity;
		printf("[UPDATE INVENTORY] %s (ID %d) da duoc them %d so luong vao du lieu cua %s", InventoryData[playerid][itemid][invItem], itemid, quantity, GetPlayerNameEx(playerid));
		if(timer != 0)	ITEMTIMER_ADD(playerid, index, quantity, timer);
	}
	return 1;
}

stock Inventory_SendRemoveTimer(playerid, index, amount)
{
	new str[128];
	format(str, sizeof(str), "Vat Pham %s (so luong : %d) cua ban da het han - he thong da tu dong tich thu vat pham", g_aInventoryItems[index][e_InventoryItem], amount);
	SendClientMessageEx(playerid, COLOR_YELLOW, str);
	Inventory_Remove(playerid, index, amount);
}

stock Inventory_Add(playerid, index, quantity = 1, timer = 0) //timer là dữ liệu số phút - 1 ngay = 60*24 - 1 tuan = 60*24*7 
{
	new
		itemid = Inventory_GetItemID(playerid, index),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);
	if(itemid == -1)
	{
		itemid = Inventory_GetFreeID(playerid);
		if(itemid != -1)
		{
			InventoryData[playerid][itemid][invModel] = g_aInventoryItems[index][e_InventoryModel];
			InventoryData[playerid][itemid][invQuantity] = quantity;
			strcpy(InventoryData[playerid][itemid][invItem], g_aInventoryItems[index][e_InventoryItem], 32);
            format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%d', '%d')", 
				PlayerSQLId, g_mysql_ReturnEscaped(g_aInventoryItems[index][e_InventoryItem], MainPipeline), g_aInventoryItems[index][e_InventoryModel], quantity);
			mysql_function_query(MainPipeline, string, false, "OnInventoryAdd", "iiii", playerid, itemid, index, timer);
			printf("[CREATE INVENTORY] %s (ID %d) da duoc them vao du lieu cua %s", InventoryData[playerid][itemid][invItem], itemid, GetPlayerNameEx(playerid));
			return itemid;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][itemid][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryData[playerid][itemid][invQuantity] += quantity;
		printf("[UPDATE INVENTORY] %s (ID %d) da duoc them %d so luong vao du lieu cua %s", InventoryData[playerid][itemid][invItem], itemid, quantity, GetPlayerNameEx(playerid));
		if(timer != 0)	ITEMTIMER_ADD(playerid, index, quantity, timer);
	}
	return itemid;
}

stock Inventory_Remove(playerid, index, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, index),
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
	for(new i = PlayerInfo[playerid][pCapacity]; i < 120; i++)
	{
		items[i] = -1;
		amounts[i] = -1;
	}
	return ShowModelSelectionInventory(playerid, "Inventory", MODEL_SELECTION_INVENTORY, items, sizeof(items), 0.0, 0.0, 0.0, 1.0, -1, true, amounts);
}

forward OnPlayerUseItem(playerid, itemid, name[]);
public OnPlayerUseItem(playerid, itemid, name[])
{
	if(!strcmp(name, "Dien thoai", true))
	{
		return cmd_phone(playerid, "\1");
	}
	else if(!strcmp(name, "Pizza", true))
	{
		PlayerInfo[playerid][pEat] += 20;
		PlayerInfo[playerid][pStrong] += 10;
		ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
	}
	else if(!strcmp(name, "Boombox", true))
	{
		SendClientMessageEx(playerid, COLOR_RED, "Vat pham nay chua duoc su dung");
	}
	else if(!strcmp(name, "Radio", true))
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "Hay su dung \"/pr [text]\" de chat kenh radio.");
	}
	else if(!strcmp(name, "Binh xang", true))
	{
		SendClientMessageEx(playerid, COLOR_RED, "Vat pham nay chua duoc su dung");
	}
	else if(!strcmp(name, "GPS", true))
	{
		return cmd_gps(playerid, "\1");
	}
	else if(!strcmp(name, "Hamburger", true))
	{
		PlayerInfo[playerid][pEat] += 16;
		PlayerInfo[playerid][pStrong] += 8;
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32201, 0.0, 0.0, 0.0);
	}
	else if(!strcmp(name, "Bread", true))
	{
		PlayerInfo[playerid][pEat] += 20;
		PlayerInfo[playerid][pStrong] += 10;
		ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
	}
	else if(!strcmp(name, "Juice", true))
	{
		PlayerInfo[playerid][pDrink] += 16;
		PlayerInfo[playerid][pStrong] += 8;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
	}
	else if(!strcmp(name, "Beer", true))
	{
		PlayerInfo[playerid][pDrink] += 16;
		PlayerInfo[playerid][pStrong] += 8;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl_F", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
	}
	else if(!strcmp(name, "Pickaxe", true))
	{
		if(GetPVarInt(playerid, #campickaxe) != 1)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Ban da trang bi Pickaxe thanh cong!");
			SetPVarInt(playerid, #campickaxe, 1);
		}
		else
		{
			SendErrorMessage(playerid, "Ban da trang bi Pickaxe roi!!");
		}
	}
	else if(!strcmp(name, "Da", true))
	{
		SendErrorMessage(playerid, " Ban chi co the dem da di ban, khong the su dung.");
	}
	else if(!strcmp(name, "Dong", true))
	{
		SendErrorMessage(playerid, " Ban chi co the dem dong di che tao gi do hoac ban, khong the su dung.");
	}
	else if(!strcmp(name, "Sat", true))
	{
		SendErrorMessage(playerid, " Ban chi co the dem sat di che tao gi do hoac ban, khong the su dung.");
	}
	else if(!strcmp(name, "Vang", true))
	{
		SendErrorMessage(playerid, " Ban chi co the dem dong di doi sang tien Credit hoac ban, khong the su dung.");
	}
	return 1;
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
	new
		giveplayerid,
		index,
		amount, 
		timer;

	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "uddd", giveplayerid, amount, index, timer))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setitem [playerid/name] [amount] [item id]");
	if(index == -1 || index >= sizeof(g_aInventoryItems))	return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Item khong hop le (su dung [/itemlist] de xem).");
	if(!strcmp(g_aInventoryItems[index][e_InventoryItem], "Dien thoai", true))
	{
		PlayerInfo[giveplayerid][pPhoneBook] = 1;
		PlayerInfo[giveplayerid][pPnumber] = random(90000) + 10000;
	}
	Inventory_Set(giveplayerid, index, amount, timer);
	new string[128];
	format(string, sizeof(string), "Ban da cho %s item \"%s\" voi so luong %d.", GetPlayerNameEx(giveplayerid), g_aInventoryItems[index][e_InventoryItem], amount);
	SendClientMessageEx(playerid, COLOR_YELLOW, string);
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
			format(string, sizeof(string), "%s[%d]%s\n", string, i, g_aInventoryItems[i][e_InventoryItem]);
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
		new
			giveplayerid = -1,
			itemid = -1,
		 itemName[32];

		if(sscanf(inputtext, "u", giveplayerid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(giveplayerid == INVALID_PLAYER_ID)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Nguoi choi khong hop le.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(!ProxDetectorS(6.0, playerid, giveplayerid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong dung gan nguoi choi do.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(giveplayerid == playerid)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong the dua item cho chinh minh.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		itemid = PlayerInfo[playerid][pInventoryItem];

		if(itemid == -1)
			return 0;

		strcpy(itemName, InventoryData[playerid][itemid][invItem], 32);
		new index = Inventory_GetItemIndex(itemName);
		if(InventoryData[playerid][itemid][invQuantity] == 1)
		{
			new id = Inventory_Add(giveplayerid, index), str[560];
			if(id == -1)
				return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");
			format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(giveplayerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), itemName);
			SendClientMessageEx(giveplayerid, COLOR_YELLOW, str);

			Inventory_Remove(playerid, index);
			new years,month,day,hourz,minz,sec,time[50];
			getdate(years,month,day);
			gettime(hourz,minz,sec);
			format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
			format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(giveplayerid), PlayerInfo[giveplayerid][pIP]);
			Log("logs/give_log.txt", str);
		}
		else
		{
			new str[128];
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong de dua item %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(giveplayerid));
			Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
			PlayerInfo[playerid][pGiveItem] = giveplayerid;
		}
	}
	return 1;
}

Dialog:GiveQuantity(playerid, response, listitem, inputtext[])
{
	if(response && PlayerInfo[playerid][pGiveItem] != INVALID_PLAYER_ID)
	{
		new
			giveplayerid = PlayerInfo[playerid][pGiveItem],
			itemid = PlayerInfo[playerid][pInventoryItem],
			itemName[32], str[560];

		strunpack(itemName, InventoryData[playerid][itemid][invItem]);

		if(isnull(inputtext))
		{
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(giveplayerid));
			return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemid][invQuantity])
		{
			format(str, sizeof(str), "Ban khong co nhieu item.\n\nItem: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemid][invQuantity], GetPlayerNameEx(giveplayerid));
			return  Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}
		new index = Inventory_GetItemIndex(itemName);
		new id = Inventory_Add(giveplayerid, index, strval(inputtext));

		if(id == -1)
			return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");

		format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(giveplayerid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), str);
		SendClientMessageEx(giveplayerid, COLOR_YELLOW, str);

		Inventory_Remove(playerid, index, strval(inputtext));
		new years,month,day,hourz,minz,sec,time[50];
		getdate(years,month,day);
		gettime(hourz,minz,sec);
		format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
		format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(giveplayerid), PlayerInfo[giveplayerid][pIP]);
		Log("logs/give_log.txt", str);
	}
	return 1;
}

