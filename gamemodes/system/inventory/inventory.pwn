#include <YSI_Coding\y_hooks>
#include "./system/inventory/inventoryitem.pwn"
#define MAX_INVENTORY (120)
#define MODEL_SELECTION_INVENTORY (1)

enum inventoryData
{
	invExists,
	invID,
	invItem[32],
	invModel[64],
	invQuantity
};

enum e_InventoryItems
{
	e_InventoryItem[32],
	e_InventoryModel[64]
};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
forward OnLoadInventory(playerid);
forward OnInventoryAdd(playerid, pItemId, timer);
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Pickaxe", "mdl-2023:item_Pickaxe"},
	{"Dien thoai", "mdl-2023:item_GPS"},
	{"GPS", "mdl-2023:item_GPS"},
    {"Binh xang", "mdl-2023:item_gas"},
	{"Boombox", "mdl-2023:item_boombox"},
	{"Radio", "mdl-2023:item_PRadio"},
	{"Pizza", "mdl-2023:item_pizza"},
	{"Hamburger", "mdl-2023:item_buger"},
	{"Bread", "mdl-2023:item_bread"},
	{"Juice", "mdl-2023:item_juice"},
	// {"Beer", 1544},
	// {"Da", 905},
	{"Dong", "mdl-2023:item_cropper"},
	{"Sat", "mdl-2023:item_iron"},
	{"Vang", "mdl-2023:item_gold"}
};

hook OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pGiveItem] = INVALID_PLAYER_ID;
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 0) return 1;
	else if (PRESSED(KEY_YES) && CheckKeyInventory(playerid)) //Nhớ bổ sung các trường hợp sử dụng key Y để không bật inventory, ví dụ như Pizza
    {
		return cmd_inv(playerid, "\1"); 
	}
	return 1;
}

stock CheckKeyInventory(playerid)
{
	//if(GetPVarInt(playerid, "SomeThing") == value) return 0;
	return 1;
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
	for(new pItemId = 0; pItemId != MAX_INVENTORY; pItemId++)
	{
		InventoryData[playerid][pItemId][invExists] = false;
		InventoryData[playerid][pItemId][invQuantity] = 0;
	}
    while(i < rows)
    {
        cache_get_field_content(i, "invID", tmp, MainPipeline); InventoryData[playerid][i][invID] = strval(tmp);
        cache_get_field_content(i, "invModel", InventoryData[playerid][i][invModel], MainPipeline, 64);
        cache_get_field_content(i, "invQuantity", tmp, MainPipeline); InventoryData[playerid][i][invQuantity] = strval(tmp);
        cache_get_field_content(i, "invItem", InventoryData[playerid][i][invItem], MainPipeline, 32); 
        InventoryData[playerid][i][invExists] = true;
        i++;
    }
    if(i > 0) printf("[LOAD INVENTORY]  du lieu inventory cua %s (ID: %d) da duoc tai.", GetPlayerNameEx(playerid), playerid);
	ITEMTIMER_LOAD(playerid);
}

public OnInventoryAdd(playerid, pItemId, timer)
{
	InventoryData[playerid][pItemId][invExists] = true;
	InventoryData[playerid][pItemId][invID] = mysql_insert_id(MainPipeline);
	if(timer != 0)	ITEMTIMER_ADD(playerid, InventoryData[playerid][pItemId][invID], InventoryData[playerid][pItemId][invQuantity], timer);
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
			InventoryData[playerid][i][invExists] = false;
			InventoryData[playerid][i][invQuantity] = 0;
		}
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerSQLId);
	return mysql_tquery(g_iHandle, string);
}

stock Inventory_Set(playerid, item[], quantity, timer)
{
	new pItemId = Inventory_GetItemID(playerid, item);
	if(pItemId == -1 && quantity > 0)
		Inventory_Add(playerid, item, quantity, timer);

	else if(quantity > 0 && pItemId != -1)
		Inventory_SetQuantity(playerid, item, quantity, timer);

	else if(quantity < 1 && pItemId != -1)
	{
		pItemId = Inventory_GetItemID(playerid, item);
		Inventory_Remove(playerid, pItemId, quantity);
	}
	return 1;
}

stock Inventory_GetItemID(playerid, item[], quantity = -1)
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;
		if(quantity != -1 && InventoryData[playerid][i][invQuantity] >= quantity && !strcmp(InventoryData[playerid][i][invItem], item))
			return i;
		if(!strcmp(InventoryData[playerid][i][invItem], item) && quantity == -1) 
			return i;
	}
	return -1;
}

stock Get_GInventoryItem(item[])
{
	for(new i = 0; i < sizeof(g_aInventoryItems); i++)
	{
		if(!strcmp(g_aInventoryItems[i][e_InventoryItem], item)) 
		{
			return i;
		}
	}
	return 0;
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
	new pItemId = Inventory_GetItemID(playerid, item);

	if(pItemId != -1)
		return InventoryData[playerid][pItemId][invQuantity];

	return 0;
}

stock Inventory_HasItem(playerid, item[], quantity = -1)
{
	return (Inventory_GetItemID(playerid, item, quantity) != -1);
}

stock Inventory_SetQuantity(playerid, item[], quantity, timer = 0)
{
	new
		pItemId = Inventory_GetItemID(playerid, item),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);
	if(pItemId != -1 && timer == 0)
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][pItemId][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryData[playerid][pItemId][invQuantity] += quantity;
		printf("[UPDATE INVENTORY] %s (ID %d) da duoc them %d so luong vao du lieu cua %s", InventoryData[playerid][pItemId][invItem], pItemId, quantity, GetPlayerNameEx(playerid));
	}
	else if(timer != 0)	Inventory_Add(playerid, item, quantity, timer);
	return 1;
}

stock Inventory_SendRemoveTimer(playerid, pItemId, quantity)
{
	new str[128];
	format(str, sizeof(str), "Vat Pham %s (so luong : %d) cua ban da het han - he thong da tu dong tich thu vat pham", InventoryData[playerid][pItemId][invItem], quantity);
	SendClientMessageEx(playerid, COLOR_YELLOW, str);
	Inventory_Remove(playerid, pItemId, quantity);
}

stock Inventory_Add(playerid, item[], quantity = 1, timer = 0) //timer là dữ liệu số phút - 1 ngay = 60*24 - 1 tuan = 60*24*7 
{
	new
		pItemId = Inventory_GetItemID(playerid, item),
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid),
		model[64];
	strcpy(model, g_aInventoryItems[Get_GInventoryItem(item)][e_InventoryModel], 64);
	printf("%s", model);
	if(pItemId == -1 || timer != 0)
	{
		pItemId = Inventory_GetFreeID(playerid);
		if(pItemId != -1)
		{
			strcpy(InventoryData[playerid][pItemId][invModel], model);
			InventoryData[playerid][pItemId][invQuantity] = quantity;
			strcpy(InventoryData[playerid][pItemId][invItem], item, 32);
            format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`) VALUES('%d', '%s', '%s', '%d')", 
				PlayerSQLId, g_mysql_ReturnEscaped(item, MainPipeline), g_mysql_ReturnEscaped(model, MainPipeline), quantity);
			mysql_function_query(MainPipeline, string, false, "OnInventoryAdd", "iii", playerid, pItemId, timer);
			printf("[CREATE INVENTORY] %s (ID %d) da duoc them vao du lieu cua %s", InventoryData[playerid][pItemId][invItem], pItemId, GetPlayerNameEx(playerid));
			return pItemId;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][pItemId][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryData[playerid][pItemId][invQuantity] += quantity;
		printf("[UPDATE INVENTORY] %s (ID %d) da duoc them %d so luong vao du lieu cua %s", InventoryData[playerid][pItemId][invItem], pItemId, quantity, GetPlayerNameEx(playerid));
	}
	return pItemId;
}

stock Inventory_Remove(playerid, pItemId, quantity = 1) //ID cua InventoryData
{
	new
		string[128],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(InventoryData[playerid][pItemId][invExists])
	{
		if(InventoryData[playerid][pItemId][invQuantity] > 0)
		{
			InventoryData[playerid][pItemId][invQuantity] -= quantity;
		}
		if(quantity == -1 || InventoryData[playerid][pItemId][invQuantity] < 1)
		{
			InventoryData[playerid][pItemId][invExists] = false;
			InventoryData[playerid][pItemId][invQuantity] = 0;

			format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerSQLId, InventoryData[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
			format(string, sizeof(string), "DELETE FROM `itemtimer` WHERE `ItemId` = '%d'", InventoryData[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		else if(quantity != -1 && InventoryData[playerid][pItemId][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
			INVITEM_DELETE(playerid, pItemId, quantity);
		}
		return 1;
	}
	return 0;
}

public OnModelSelectionResponseInv(playerid, extraid, index, modelid[], response)
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
		items[MAX_INVENTORY][64],
		quantitys[MAX_INVENTORY],
		itemName[MAX_INVENTORY][32],
		expirys[MAX_INVENTORY];

	for(new i = 0; i < PlayerInfo[playerid][pCapacity]; i++)
	{
		if (InventoryData[playerid][i][invExists])
		{
			strcpy(items[i], InventoryData[playerid][i][invModel], 64);
			quantitys[i] = InventoryData[playerid][i][invQuantity];
			strcpy(itemName[i], InventoryData[playerid][i][invItem], 32);
		}
		else
		{
			strcpy(items[i], "_", 64);
			quantitys[i] = -1;
			strcpy(itemName[i], "_", 32);
		}
	}
	for(new i = PlayerInfo[playerid][pCapacity]; i < 120; i++)
	{
		quantitys[i] = -1;
		strcpy(itemName[i], "_", 32);
		strcpy(items[i], "_", 64);
	}
	return ShowModelSelectionInventory(playerid, "INVENTORY" ,MODEL_SELECTION_INVENTORY, items, sizeof(items), true, quantitys, itemName);
}

forward OnPlayerUseItem(playerid, pItemId, name[]);
public OnPlayerUseItem(playerid, pItemId, name[])
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
		Inventory_Remove(playerid, pItemId, 1);
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
		Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Bread", true))
	{
		PlayerInfo[playerid][pEat] += 20;
		PlayerInfo[playerid][pStrong] += 10;
		ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Juice", true))
	{
		PlayerInfo[playerid][pDrink] += 16;
		PlayerInfo[playerid][pStrong] += 8;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Beer", true))
	{
		PlayerInfo[playerid][pDrink] += 16;
		PlayerInfo[playerid][pStrong] += 8;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl_F", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
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
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setinventory [playerid/name] [quantity]");

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
		quantity, 
		timer;

	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "uddd", giveplayerid, quantity, index, timer))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setitem [playerid/name] [quantity] [item id] [timer]");
	if(index == -1 || index >= sizeof(g_aInventoryItems))	return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Item khong hop le (su dung [/itemlist] de xem).");
	if(!strcmp(g_aInventoryItems[index][e_InventoryItem], "Dien thoai", true))
	{
		PlayerInfo[giveplayerid][pPhoneBook] = 1;
		PlayerInfo[giveplayerid][pPnumber] = random(90000) + 10000;
	}
	Inventory_Set(giveplayerid, g_aInventoryItems[index][e_InventoryItem], quantity, timer);
	new string[128];
	format(string, sizeof(string), "Ban da cho %s item \"%s\" voi so luong %d.", GetPlayerNameEx(giveplayerid), g_aInventoryItems[index][e_InventoryItem], quantity);
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
			itemId = PlayerInfo[playerid][pInventoryItem],
			itemName[64], str[128];

		strunpack(itemName, InventoryData[playerid][itemId][invItem]);

		switch(listitem)
		{
			case 0:
			{

				CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemId, itemName);
			}
			case 1:
			{
				PlayerInfo[playerid][pInventoryItem] = itemId;
				Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Cho item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");
			}
			case 2:
			{
				if(IsPlayerInAnyVehicle(playerid))
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the vut item ngay bay gio.");
				else
				{
					format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
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
		itemId = PlayerInfo[playerid][pInventoryItem],
		itemName[32], string[128];

	strunpack(itemName, InventoryData[playerid][itemId][invItem]);

	if(response)
	{
		if(isnull(inputtext))
		{
			format(string, sizeof(string), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
			return Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Vut item", string, "Vut", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemId][invQuantity])
		{
			format(string, sizeof(string), "So luong khong hop le.\n\nItem: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
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
			itemId = -1,
		 itemName[32];

		if(sscanf(inputtext, "u", giveplayerid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(giveplayerid == INVALID_PLAYER_ID)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Nguoi choi khong hop le.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(!ProxDetectorS(6.0, playerid, giveplayerid))
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong dung gan nguoi choi do.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		if(giveplayerid == playerid)
			return Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Dua item", "Ban khong the dua item cho chinh minh.\n\nXin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");

		itemId = PlayerInfo[playerid][pInventoryItem];

		if(itemId == -1)
			return 0;

		strcpy(itemName, InventoryData[playerid][itemId][invItem], 32);
		if(InventoryData[playerid][itemId][invQuantity] == 1)
		{
			new id = Inventory_Add(giveplayerid, itemName), str[560];
			if(id == -1)
				return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");
			format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(giveplayerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), itemName);
			SendClientMessageEx(giveplayerid, COLOR_YELLOW, str);
			Inventory_Remove(playerid, itemId);
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
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong de dua item %s:", itemName, InventoryData[playerid][itemId][invQuantity], GetPlayerNameEx(giveplayerid));
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
			itemId = PlayerInfo[playerid][pInventoryItem],
			itemName[32], str[560];

		strunpack(itemName, InventoryData[playerid][itemId][invItem]);

		if(isnull(inputtext))
		{
			format(str, sizeof(str), "Item: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemId][invQuantity], GetPlayerNameEx(giveplayerid));
			return Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemId][invQuantity])
		{
			format(str, sizeof(str), "Ban khong co nhieu item.\n\nItem: %s (So luong: %d)\n\nXin vui long nhap so luong %s:", itemName, InventoryData[playerid][itemId][invQuantity], GetPlayerNameEx(giveplayerid));
			return  Dialog_Show(playerid, GiveQuantity, DIALOG_STYLE_INPUT, "Dua item", str, "Dua", "Huy bo");
		}
		new id = Inventory_Add(giveplayerid, itemName, strval(inputtext));

		if(id == -1)
			return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");

		format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(giveplayerid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), str);
		SendClientMessageEx(giveplayerid, COLOR_YELLOW, str);

		Inventory_Remove(playerid, itemId, strval(inputtext));
		new years,month,day,hourz,minz,sec,time[50];
		getdate(years,month,day);
		gettime(hourz,minz,sec);
		format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
		format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(giveplayerid), PlayerInfo[giveplayerid][pIP]);
		Log("logs/give_log.txt", str);
	}
	return 1;
}

