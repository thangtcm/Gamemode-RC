#define MAX_INVENTORY (120)
#define MAX_INVENTORYCH (30)
#define MODEL_SELECTION_INVENTORY (1)
#define MODEL_SELECTION_INVENTORYCH (1)
#define MODEL_SELECTION_RANSACK (2)

enum inventoryData
{
	invExists,
	invID,
	invItem[32],
	invModel[64],
	invQuantity,
	invTimer
};

enum inventoryDataTemp
{
	invExists,
	invID,
	invItem[32],
	invModel[64],
	invQuantity,
	pvSQLID,// ID xe sql sở hữu
	hSQLID, //ID House
	invTimer
};

enum e_InventoryItems
{
	e_InventoryItem[32],
	e_InventoryModel[64]
};
new Timer:myItemTimer[MAX_PLAYERS] = {Timer:-1, ...};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
new InventoryCH[MAX_PLAYERS][MAX_INVENTORYCH][inventoryDataTemp];
forward OnLoadInventory(playerid);
forward OnInventoryAdd(playerid, pItemId, timer);
forward OnInventoryAddCH(playerid, pItemId, timer);
forward OnLoadInventoryCH(playerid);

/* new const g_facInventory[][] = {
	"9mm",
	"Dong",
	"Sat",
	"Chat hoa hoc I",
	"Chat hoa hoc II",
	"Codeine",
	"Ecstacy",
	"LSD",
	"sdpistol",
	"Deagle",
	"Shotgun",
	"Spas",
	"Mp5",
	"AK47",
	"M4",
	"uzi",
	"tec_9",
	"Deagle-AS",
	"Shotgun-AS",
	"Spas-AS",
	"M4-AS",
	"Sniper-AS",
	"Rifle-AS",
	"Dan Sung Luc",
	"Dan Shot Gun",
	"Dan Tieu Lien",
	"Dan sung truong",
	"Dan Sniper",
	"Dan Sung Luc SAAS",
	"Dan SHotgun SAAS",
	"Dan Tieu Lien SAAS",
	"Dan sung truong SAAS",
	"Dan Sniper SAAS",
	"Mat na",
	"Vat lieu",
	"Thuoc Sung",
	"May Cua"
}; */

new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Dirty", "img dirty"},
	{"Pickaxe", "item_Pickaxe"},
	{"Dien thoai", "item_Phone"},
	{"GPS", "item_GPS"},
    {"Binh xang", "item_gas"},
	{"Boombox", "item_boombox"},
	{"Radio", "item_PRadio"},
	{"Pizza", "item_pizza"},
	{"Hamburger", "item_buger"},
	{"Bread", "item_bread"},
	{"Juice", "item_juice"},
	{"Beer", "beer"},
	// {"Da", 905},
	{"Da", "item_stone"},
	{"Dong", "item_copper"},
	{"Sat", "item_iron"},
	{"Vang", "item_gold"},
	{"Chat hoa hoc I", "chh_1"},
	{"Chat hoa hoc II", "chh_2"},
	{"Codeine", "Codeine"},
	{"Cocain", "Cocain"},
	{"Ecstacy", "Ecstacy"},
	{"LSD", "LSD"},

        //fish
	{"Can cau", "item_cancau"},
	{"Moi cau", "item_moicau"},
	{"Ca", "item_fish"},

	// ammo & weapon item
	{"9mm", "9mm"}, // ammo type = 1
	{"Sdpistol", "Sdpistol"}, // ammo type = 1
	{"Deagle", "Deagle"},// ammo type = 1
	{"Shotgun", "Shotgun"},// ammo type = 2
	{"Spas", "Spas"},// ammo type = 2
	{"MP5", "MP5"}, /// type 3
	{"AK47", "AK47"}, // TYPE 4
	{"M4", "M4"}, // TYPE 4
	{"Micro SMG Uzi", "uzi"}, // type 5
	{"Tec-9", "tec_9"}, // type 5

	{"Deagle-AS", "Deagle-AS"},// ammo type = 1
	{"Shotgun-AS", "Shotgun-AS"},// ammo type = 2
	{"Spas-AS", "Spas-AS"},// ammo type = 2
	{"MP5-AS", "MP5-AS"}, /// type 3
	{"M4-AS", "M4-AS"}, // TYPE 4
	{"Sniper-AS", "Sniper-AS"}, // type 5
	{"Rifle-AS", "Rifle-AS"}, // type 5

	{"Dan sung luc", "Ammo1"}, // type 5
	{"Dan shotgun", "Ammo2"}, // type 5
	{"Dan tieu lien", "Ammo3"}, // type 5
	{"Dan sung truong", "Ammo4"}, // type 5
	{"Dan sniper", "Ammo5"}, // type 5

	{"Dan sung luc SAAS", "Ammo1-AS"}, // type 5
	{"Dan shotgun SAAS", "Ammo2-AS"}, // type 5
	{"Dan tieu lien SAAS", "Ammo3-AS"}, // type 5
	{"Dan sung truong SAAS", "Ammo4-AS"}, // type 5
	{"Dan sniper SAAS", "Ammo5-AS"}, // type 5
	{"Medkit", "item_medkit"},  
	//NameTag
	{"Mat na", "Mask"},
	{"Go", "Go"}  ,
	{"Vat lieu", "Vat_lieu"},
	{"Thuoc sung", "thuoc_sung"},
	{"Hat Giong Lua", "seed_paddy"},
	{"Hat Giong Duoc Lieu", "seed_herbal"},
	{"Hat Giong Cam", "seed_herbal"},
	{"Thao Duoc", "herbal"},
	{"Lua", "rice"},
	{"Thit", "meat"},
	{"Giong Bo", "ticket_cow"},
	{"Giong Nai", "ticket_deer"},
	{"Bot Mi", "flour"},
	{"Trai Cay", "fruit"},
	{"May Cua", "sawder"},
	{"Bo so cuu", "firstaidkit"},
	{"Santa Hat", "santahat"}
};

hook OnPlayerDisconnect(playerid, reason)
{
	if(myItemTimer[playerid] != Timer:-1)
	{
		stop myItemTimer[playerid];
    	myItemTimer[playerid] = Timer:-1;
	}
    return 1;
}

hook OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pGiveItem] = INVALID_PLAYER_ID;
	SetPVarInt(playerid, "InvPlayerVehicle", -1);
	SetPVarInt(playerid, "InvPlayerHouse", -1);
	return 1;
}

stock Inventory_Load(playerid)
{
	for(new pItemId = 0; pItemId != MAX_INVENTORY; pItemId++)
	{
		InventoryData[playerid][pItemId][invExists] = false;
		InventoryData[playerid][pItemId][invQuantity] = 0;
		InventoryData[playerid][pItemId][invTimer] = 0;
	}
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
        cache_get_field_content(i, "invModel", InventoryData[playerid][i][invModel], MainPipeline, 64);
        cache_get_field_content(i, "invQuantity", tmp, MainPipeline); InventoryData[playerid][i][invQuantity] = strval(tmp);
		cache_get_field_content(i, "invTimer", tmp, MainPipeline); InventoryData[playerid][i][invTimer] = strval(tmp);
        cache_get_field_content(i, "invItem", InventoryData[playerid][i][invItem], MainPipeline, 32); 
        InventoryData[playerid][i][invExists] = true;
        i++;
    }
    if(i > 0) printf("[LOAD INVENTORY] %d du lieu inventory cua %s (ID: %d) da duoc tai.", i, GetPlayerNameEx(playerid), playerid);
	myItemTimer[playerid] = repeat ItemTimer(playerid);
}

public OnInventoryAdd(playerid, pItemId, timer)
{
	InventoryData[playerid][pItemId][invExists] = true;
	InventoryData[playerid][pItemId][invID] = mysql_insert_id(MainPipeline);
	DeletePVar(playerid, "IsAddingInv");
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
			InventoryData[playerid][i][invTimer] = 0;
		}
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerSQLId);
	return mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
}

stock Inventory_Set(playerid, item[], quantity, timer = 0)
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

stock Inventory_GetItemID(playerid, item[], quantity = 1)
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;
		if(!strcmp(InventoryData[playerid][i][invItem], item) && InventoryData[playerid][i][invQuantity] >= quantity)
			return i;
	}
	return -1;
}

stock Inventory_GetModel(item[])
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
		if(GetPVarInt(playerid, "IsAddingInv") == i) 
		{
			DeletePVar(playerid, "IsAddingInv");
			continue;
		}
		if(!InventoryData[playerid][i][invExists])
			return i;
	}
	return -1;
}

stock MaskHandle(playerid)
{
	PlayerInfo[playerid][pMaskOn] = !PlayerInfo[playerid][pMaskOn];
	new szName[MAX_PLAYER_NAME];
	if(PlayerInfo[playerid][pMaskOn]) // true la deo
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, PIZZA_INDEX)) RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
		SetPlayerAttachedObject(playerid, PIZZA_INDEX, 18912, 2, 0.078534, 0.041857, -0.001727, 268.970458, 1.533374, 269.223754);
		GetPlayerName(playerid, szName, sizeof(szName));
		SetPVarString(playerid, "TempNameName", szName);
		format(szName, sizeof(szName), "Mask_%d%d", PlayerInfo[playerid][pMaskID][0], playerid);
		SetPlayerName(playerid, szName);
		return 1;
	}
	else
	{
		GetPVarString(playerid, "TempNameName", szName, sizeof(szName));
		SetPlayerName(playerid, szName);
		if(IsPlayerAttachedObjectSlotUsed(playerid, PIZZA_INDEX)) RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
	}
	return 0;
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
	new count = 0;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;
		if(!strcmp(InventoryData[playerid][i][invItem], item)) 
			count+=InventoryData[playerid][i][invQuantity];
	}
	return count;
}
stock Inventory_HasItem(playerid, item[], quantity = 1)
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

stock Inventory_Add(playerid, item[], quantity = 1, timer = 0, isGive = false)
{
	new result = Inventory_AddEx(playerid, item, quantity, timer);
	new str[128];
	if(!isGive && result == -1)
	{
		format(str, sizeof(str), "{FF6347}ERROR:{FFFFFF}Ban khong con slot de chua vat pham %s, vui long nang cap tui do de chua nhieu vat pham hon.", item);
		SendClientMessageEx(playerid, COLOR_WHITE, str);
		return 0;
	}
	else if(isGive && result == -1)
	{
		format(str, sizeof(str), "{FF6347}ERROR:{FFFFFF}Tui do cua nguoi choi %s da dat gioi han chua vat pham.", GetPlayerNameEx(playerid));
		SendClientMessageEx(playerid, COLOR_WHITE, str);
		return 0;
	}
	return 1;
}

stock Inventory_AddEx(playerid, item[], quantity = 1, timer = 0) //timer là dữ liệu số phút - 1 ngay = 60*24 - 1 tuan = 60*24*7 		
{
	new
		pItemId = Inventory_GetItemID(playerid, item),
		string[250],
        PlayerSQLId = GetPlayerSQLId(playerid),
		model[64];
	strcpy(model, g_aInventoryItems[Inventory_GetModel(item)][e_InventoryModel], 64);
	if(pItemId == -1 || timer != 0)
	{
		pItemId = Inventory_GetFreeID(playerid);
		if(pItemId != -1)
		{
			strcpy(InventoryData[playerid][pItemId][invModel], model);
			InventoryData[playerid][pItemId][invQuantity] = quantity;
			InventoryData[playerid][pItemId][invTimer] = timer == 0 ? 0 : gettime() + timer*60;
			strcpy(InventoryData[playerid][pItemId][invItem], item, 32);
            format(string, sizeof(string), "INSERT INTO `inventory` (`ID`, `invItem`, `invModel`, `invQuantity`, `invTimer`) VALUES('%d', '%s', '%s', '%d', '%d')", 
				PlayerSQLId, g_mysql_ReturnEscaped(item, MainPipeline), g_mysql_ReturnEscaped(model, MainPipeline), quantity, InventoryData[playerid][pItemId][invTimer]);
			SetPVarInt(playerid, "IsAddingInv", pItemId);
			mysql_function_query(MainPipeline, string, false, "OnInventoryAdd", "iii", playerid, pItemId, timer);
			printf("[CREATE INVENTORY] %s (ID %d) da duoc them vao du lieu cua %s", InventoryData[playerid][pItemId][invItem], pItemId, GetPlayerNameEx(playerid));
			new itemidzxc[10];
        	format(itemidzxc, 10, "%d", pItemId);
			SendLogToDiscordRoom("LOG ADD VẬT PHẨM", "1158001303033757716", "Name", GetPlayerNameEx(playerid, false), "ADDED", InventoryData[playerid][pItemId][invItem], "ITEMID", itemidzxc, 0x25b807);
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
		new itemidzxc[10];
        format(itemidzxc, 10, "%d", pItemId);
		new itemidzxcv[10];
        format(itemidzxcv, 10, "%d", quantity);
		SendLogToDiscordRoom4("LOG ADD VẬT PHẨM", "1158001303033757716", "Name", GetPlayerNameEx(playerid, false), "ADDED", InventoryData[playerid][pItemId][invItem], "Số lượng", itemidzxcv, "ITEMID", itemidzxc, 0x25b807);
	}
	return 1;
}


stock Inventory_RemoveTimer(playerid, item[], quantity)
{
	new arrTimer[MAX_INVENTORY] = {-1,...}, arrRemove[MAX_INVENTORY], quantityTemp = 0, countRemove = 0;
	new str[128], maxItem = 0;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(!InventoryData[playerid][i][invExists])
			continue;
		if(!strcmp(InventoryData[playerid][i][invItem], item) && InventoryData[playerid][i][invTimer] != 0) 
		{
			arrTimer[maxItem++] = i;
		}
	}
	for(new i = 0; i < maxItem - 1; i++)
	{
		if(arrTimer[i] == -1 || arrTimer[i+1] == -1)
			break;
		if(!InventoryData[playerid][i][invExists])
			continue;
		for(new j = 0; j < maxItem - i - 1 ; j++)
		{
			if (InventoryData[playerid][arrTimer[j]][invTimer] - gettime() > InventoryData[playerid][arrTimer[j + 1]][invTimer] - gettime()) {
				new temp = arrTimer[j];
				arrTimer[j] = arrTimer[j + 1];
				arrTimer[j + 1] = temp;
			}
		}
	}
	if(maxItem > 0)
	{
		for(new i; i < maxItem; i++)
		{
			if(InventoryData[playerid][arrTimer[i]][invQuantity] < quantity)
			{
				arrRemove[countRemove++] = arrTimer[i];
			}
			else
			{
				arrRemove[countRemove++] = arrTimer[i];
				quantityTemp = InventoryData[playerid][arrTimer[i]][invQuantity] - quantity;
				break;
			}
		}
		if(quantityTemp <= 0)
		{
			format(str, sizeof(str), "%d", InventoryData[playerid][arrRemove[0]][invID]);
			InventoryData[playerid][arrRemove[0]][invExists] = false;
			InventoryData[playerid][arrRemove[0]][invQuantity] = 0;
			for(new i = 1; i < countRemove; i++)
			{
				InventoryData[playerid][arrRemove[i]][invExists] = false;
				InventoryData[playerid][arrRemove[i]][invQuantity] = 0;
				format(str, sizeof(str), "%s, %d", str, InventoryData[playerid][arrRemove[i]][invID]);
			}
			format(str, sizeof(str), "DELETE FROM `inventory` WHERE `invID` IN(%s)", str);
			mysql_function_query(MainPipeline, str, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		else{
			new update_amount = 0;
			if(countRemove > 1)
			{
				format(str, sizeof(str), "%d", InventoryData[playerid][arrRemove[0]][invID]);
				InventoryData[playerid][arrRemove[0]][invExists] = false;
				InventoryData[playerid][arrRemove[0]][invQuantity] = 0;
				for(new i = 1; i < countRemove - 1; i++)
				{
					InventoryData[playerid][arrRemove[i]][invExists] = false;
					InventoryData[playerid][arrRemove[i]][invQuantity] = 0;
					format(str, sizeof(str), "%s, %d", str, InventoryData[playerid][arrRemove[i]][invID]);
				}
				format(str, sizeof(str), "DELETE FROM `inventory` WHERE `invID` IN(%s)", str);
				mysql_function_query(MainPipeline, str, false, "OnQueryFinish", "i", SENDDATA_THREAD);
			}
			new str2[128];
			update_amount = InventoryData[playerid][arrRemove[countRemove-1]][invQuantity] - quantityTemp;
			printf("%d -- %d -- %d -- %d", update_amount, countRemove, InventoryData[playerid][arrRemove[countRemove-1]][invQuantity], quantityTemp);
			InventoryData[playerid][arrRemove[countRemove-1]][invQuantity] -= update_amount;
			format(str2, sizeof(str2), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `invID` = '%d'", update_amount, InventoryData[playerid][arrRemove[countRemove-1]][invID]);
			mysql_function_query(MainPipeline, str2, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
	}
	return 1;
}

stock Inventory_Remove(playerid, pItemId, quantity = 1, isDrop = false) //ID cua InventoryData
{
	new
		string[258],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(InventoryData[playerid][pItemId][invExists])
	{
		if(InventoryData[playerid][pItemId][invTimer] != 0 && !isDrop)
		{
			return Inventory_RemoveTimer(playerid, InventoryData[playerid][pItemId][invItem], quantity);
		}
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
			printf("DELETE %s ", InventoryData[playerid][pItemId][invItem]);
		}
		else if(quantity != -1 && InventoryData[playerid][pItemId][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryData[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
			printf("UPDATE %s ", InventoryData[playerid][pItemId][invItem]);
		}
		return 1;
	}
	return 0;
}

public OnModelSelectionMenuInv(playerid, extraid, selectType, response)
{
	if((extraid == MODEL_SELECTION_INVENTORY && response))
	{
		switch(selectType){
			case SELECT_ICONUSER:{
				return cmd_thongtin(playerid, "\1");
			}
			case SELECT_ICONCAR:{
				return cmd_chinhxe(playerid, "\1");
			}
			case SELECT_ICONSETTING:{
				SendErrorMessage(playerid, "Chuc nang nay dang bao tri");
			}
		}
	}
	return 1;
}

public OnModelSelectionResponseInv(playerid, extraid, index, modelid[], response)
{
	if((extraid == MODEL_SELECTION_INVENTORY && response) && InventoryData[playerid][index][invExists])
	{
		new
			name[48],
			menu[228];
		strunpack(name, InventoryData[playerid][index][invItem]);
		PlayerInfo[playerid][pInventoryItem] = index;

		format(name, sizeof(name), "%s (%d)", name, InventoryData[playerid][index][invQuantity]);
		format(menu, sizeof(menu), "Su dung\nCho item\nVut item");
		new carid = GetPlayerVehicleID(playerid);
        new closestcar = GetClosestCar(playerid,carid);
        if(IsPlayerInRangeOfVehicle(playerid, closestcar, 5.0))
		{
			new v = GetPlayerVehicle(playerid, closestcar);
            if(v != -1)
            {
				SetPVarInt(playerid, "InvPlayerVehicle", v);
				format(menu, sizeof(menu), "%s\nCat vao xe", menu);
			}
		}
		if(Homes[playerid] > 0)
		{
			for(new i; i < MAX_HOUSES; i++)
			{
				if(GetPlayerSQLId(playerid) == HouseInfo[i][hOwnerID] && IsPlayerInRangeOfPoint(playerid, 50, HouseInfo[i][hInteriorX], HouseInfo[i][hInteriorY], HouseInfo[i][hInteriorZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hIntVW] && GetPlayerInterior(playerid) == HouseInfo[i][hIntIW])
				{
					SetPVarInt(playerid, "InvPlayerHouse", i);
					format(menu, sizeof(menu), "%s\nCat vao nha", menu);
				}
			}
		}
		Dialog_Show(playerid, Inventory, DIALOG_STYLE_LIST, name, menu, "Lua chon", "<");
	}
	else if((extraid == MODEL_SELECTION_RANSACK && response) && InventoryData[playerid][index][invExists])
	{
		new
			name[48], target = GetPVarInt(playerid, "GivePlayerid_Inventory");

		strunpack(name, InventoryData[target][index][invItem]);
		PlayerInfo[target][pInventoryItem] = index;
		format(name, sizeof(name), "%s (%d)", name, InventoryData[target][index][invQuantity]);
		Dialog_Show(playerid, Take_Inventory, DIALOG_STYLE_LIST, name, "Tich Thu", "Lua chon", "<");
	}
	return 1;
}

stock OpenInventory(playerid, bool:Ransack = false)
{
	if(!IsPlayerConnected(playerid))
		return 0;
	new
		items[MAX_INVENTORY][64],
		quantitys[MAX_INVENTORY],
		itemName[MAX_INVENTORY][32],
		expirys[MAX_INVENTORY],
		target;
	if(Ransack)
		target = GetPVarInt(playerid, "GivePlayerid_Inventory");
	else	target = playerid;


	for(new i = 0; i < PlayerInfo[target][pCapacity]; i++)
	{
		if (InventoryData[target][i][invExists])
		{
			strcpy(items[i], InventoryData[target][i][invModel], 64);
			quantitys[i] = InventoryData[target][i][invQuantity];
			strcpy(itemName[i], InventoryData[target][i][invItem], 32);
			expirys[i] = InventoryData[target][i][invTimer] == 0 ? 0 : InventoryData[target][i][invTimer] - gettime();
		}
		else
		{
			strcpy(items[i], "_", 64);
			quantitys[i] = -1;
			expirys[i] = 0;
			strcpy(itemName[i], "_", 32);
		}
	}
	for(new i = PlayerInfo[target][pCapacity]; i < 120; i++)
	{
		quantitys[i] = -1;
		strcpy(itemName[i], "_", 32);
		expirys[i] = 0;
		strcpy(items[i], "_", 64);
	}
	if(!Ransack)
		return ShowModelSelectionInventory(playerid, "INVENTORY" ,MODEL_SELECTION_INVENTORY, items, sizeof(items), true, quantitys, itemName, true, expirys);
	new str[128];
	format(str, sizeof(str), "Tui do cua %s", GetPlayerNameEx(target));
	return ShowModelSelectionInventory(playerid, str ,MODEL_SELECTION_RANSACK, items, sizeof(items), true, quantitys, itemName, true, expirys);
}

forward OnPlayerUseItem(playerid, pItemId, name[]);
public OnPlayerUseItem(playerid, pItemId, name[])
{
	new str[256];
	if(!strcmp(name, "Dien thoai", true))
	{
		return cmd_phone(playerid, "\1");
	}
	else if(!strcmp(name, "Pizza", true))
	{
		if(GetPVarInt(playerid, "TakeDamageFood") > gettime())
			return SendErrorMessage(playerid, "Ban khong the uong trong khi vua bi tan cong.");
		if(PlayerInfo[playerid][pEat] >= 100) return SendErrorMessage(playerid, "Ban da no roi, khong the an tiep.");
		PlayerInfo[playerid][pEat] = PlayerInfo[playerid][pEat] + 30 > 100 ? 100 : PlayerInfo[playerid][pEat] + 30;
		ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
		new Float:playerHeath;
		GetPlayerHealth(playerid, playerHeath);
		if(playerHeath + 5.0 > 100.0)
			SetPlayerHealth(playerid, 100.0);
		else
			SetPlayerHealth(playerid, playerHeath+10.0);
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
		if(GetPVarInt(playerid, "TakeDamageFood") > gettime())
			return SendErrorMessage(playerid, "Ban khong the an trong khi vua bi tan cong.");
		if(PlayerInfo[playerid][pEat] >= 100) return SendErrorMessage(playerid, "Ban da no roi, khong the an tiep.");
		PlayerInfo[playerid][pEat] = PlayerInfo[playerid][pEat] + 25 > 100 ? 100 : PlayerInfo[playerid][pEat] + 25;
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32201, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
		new Float:playerHeath;
		GetPlayerHealth(playerid, playerHeath);
		if(playerHeath + 5.0 > 100.0)
			SetPlayerHealth(playerid, 100.0);
		else
			SetPlayerHealth(playerid, playerHeath+5.0);
	}
	else if(!strcmp(name, "Bread", true))
	{
		if(GetPVarInt(playerid, "TakeDamageFood") > gettime())
			return SendErrorMessage(playerid, "Ban khong the an trong khi vua bi tan cong.");
		if(PlayerInfo[playerid][pEat] >= 100) return SendErrorMessage(playerid, "Ban da no roi, khong the an tiep.");
		PlayerInfo[playerid][pEat] = PlayerInfo[playerid][pEat] + 20 > 100 ? 100 : PlayerInfo[playerid][pEat] + 20;
		ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 5.0, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
		new Float:playerHeath;
		GetPlayerHealth(playerid, playerHeath);
		if(playerHeath + 5.0 > 100.0)
			SetPlayerHealth(playerid, 100.0);
		else
			SetPlayerHealth(playerid, playerHeath+5.0);
	}
	else if(!strcmp(name, "Juice", true))
	{
		if(GetPVarInt(playerid, "TakeDamageFood") > gettime())
			return SendErrorMessage(playerid, "Ban khong the uong trong khi vua bi tan cong.");
		if(PlayerInfo[playerid][pDrink] >= 100) return SendErrorMessage(playerid, "Ban da no roi, khong the uong tiep.");
		PlayerInfo[playerid][pDrink] = PlayerInfo[playerid][pDrink] + 25 > 100 ? 100 : PlayerInfo[playerid][pDrink] + 25;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
		new Float:playerHeath;
		GetPlayerHealth(playerid, playerHeath);
		if(playerHeath + 5.0 > 100.0)
			SetPlayerHealth(playerid, 100.0);
		else
			SetPlayerHealth(playerid, playerHeath+5.0);
	}
	else if(!strcmp(name, "Beer", true))
	{
        if(GetPVarInt(playerid, "TakeDamageFood") > gettime())
			return SendErrorMessage(playerid, "Ban khong the uong trong khi vua bi tan cong.");
		if(PlayerInfo[playerid][pDrink] >= 100) return SendErrorMessage(playerid, "Ban da no roi, khong the uong tiep.");
		PlayerInfo[playerid][pDrink] += 40;
		PlayerInfo[playerid][pDrink] = PlayerInfo[playerid][pDrink] + 40 > 100 ? 100 : PlayerInfo[playerid][pDrink] + 40;
		ApplyAnimation(playerid, "GANGS", "drnkbr_prtl_F", 2.67, 0, 1, 1, 1, 2000, 1);
		PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		Inventory_Remove(playerid, pItemId, 1);
        new Float:playerHeath;
		GetPlayerHealth(playerid, playerHeath);
		if(playerHeath + 15.0 > 100.0)
			SetPlayerHealth(playerid, 100.0);
		else
			SetPlayerHealth(playerid, playerHeath+15.0);
	}
	else if(!strcmp(name, "Codeine", true))
	{
	    UseDrug(playerid,0,pItemId);
	}
	else if(!strcmp(name, "Cocain", true))
	{
		UseDrug(playerid,1,pItemId);
	}
	else if(!strcmp(name, "Ecstacy", true))
	{
		UseDrug(playerid,2,pItemId);
	}
	else if(!strcmp(name, "LSD", true))
	{
		UseDrug(playerid,3,pItemId);
	}
	else if(!strcmp(name, "Mat na", true))
	{
		if(MaskHandle(playerid))
		{
			format(str, sizeof(str), "* %s da deo mat na.", GetPlayerNameEx(playerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		else{
			format(str, sizeof(str), "* %s da thao mat na.", GetPlayerNameEx(playerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	else if(!strcmp(name, "9mm", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g == 22 || weapon_g == 23 || weapon_g == 24) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 22, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~9mm~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "sdpistol", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g == 22 || weapon_g == 23 || weapon_g == 24) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 23, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Sdpistol~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Deagle", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g == 22 || weapon_g == 23 || weapon_g == 24) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 24, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Deagle~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Deagle-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g == 22 || weapon_g == 23 || weapon_g == 24) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 24, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Deagle~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Spas", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g == 25 || weapon_g == 26 || weapon_g == 27) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 27, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Spas-12~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Spas-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g == 25 || weapon_g == 26 || weapon_g == 27) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 27, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Spas-12~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Shotgun", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g == 25 || weapon_g == 26 || weapon_g == 27) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 25, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Shotgun~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Shotgun-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g == 25 || weapon_g == 26 || weapon_g == 27) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 25, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Shotgun~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "mp5", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g == 29 || weapon_g == 28 || weapon_g == 32 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 29, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~MP5~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Tec-9", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g == 29 || weapon_g == 28 || weapon_g == 32 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 32, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Tec-9~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
    else if(!strcmp(name, "Micro SMG Uzi", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g == 29 || weapon_g == 28 || weapon_g == 32 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 28, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Micro SMG Uzi~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "mp5-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g == 29 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 29, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~MP5~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "ak47", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
        if(weapon_g == 30 || weapon_g == 31) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 30, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~AK47~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "m4", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
        if(weapon_g == 30 || weapon_g == 31) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 31, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~M4~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "m4-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
        if(weapon_g == 30 || weapon_g == 31) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 31, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~M4~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Sniper", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 6, weapon_g, ammos_g);
        if(weapon_g == 34 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 34, 1);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Sniper~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Sniper-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 6, weapon_g, ammos_g);
        if(weapon_g == 34 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 34, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Sniper~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Rifle-AS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 6, weapon_g, ammos_g);
        if(weapon_g == 33 ) return SendClientMessage(playerid,-1,"Ban da trang bi mot loai vu khi tuong tu.");
        GivePlayerValidWeapon(playerid, 33, 1, true);
        SendClientTextDraw(playerid, "Ban da trang bi thanh cong vu khi ~r~Sniper~w~ voi ~r~1 vien dan");
        Inventory_Remove(playerid, pItemId, 1);
	}
	else if(!strcmp(name, "Dan sung luc", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g != 22 && weapon_g != 23 && weapon_g != 24) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung luc' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO1, DIALOG_STYLE_INPUT, "Trang bi - Dan sung luc", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan sung luc SAAS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
        if(weapon_g != 22 && weapon_g != 23 && weapon_g != 24) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung luc' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO1AS, DIALOG_STYLE_INPUT, "Trang bi - Dan sung luc", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan shotgun", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g != 25 && weapon_g != 26 && weapon_g != 27) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'sung shotgun' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO2, DIALOG_STYLE_INPUT, "Trang bi - Dan Shotgun", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan shotgun SAAS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
        if(weapon_g != 25 && weapon_g != 26 && weapon_g != 27) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'sung shotgun' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO2AS, DIALOG_STYLE_INPUT, "Trang bi - Dan Shotgun", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan tieu lien", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g != 29 && weapon_g != 32 && weapon_g != 28  ) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung tieu lien' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO3, DIALOG_STYLE_INPUT, "Trang bi - Dan tieu lien", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan tieu lien SAAS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
        if(weapon_g != 29 && weapon_g != 32 && weapon_g != 28  ) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung tieu lien' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO3AS, DIALOG_STYLE_INPUT, "Trang bi - Dan tieu lien", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan sung truong", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
        if(weapon_g != 30 && weapon_g != 31 ) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung truong' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO4, DIALOG_STYLE_INPUT, "Trang bi - Dan sung truong", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan sung truong SAAS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
        if(weapon_g != 30 && weapon_g != 31 ) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung truong' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO4AS, DIALOG_STYLE_INPUT, "Trang bi - Dan sung truong", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan sniper", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 6, weapon_g, ammos_g);
        if(weapon_g != 34 && weapon_g != 33) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sniper' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO5, DIALOG_STYLE_INPUT, "Trang bi - Dan Sniper", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Dan sniper SAAS", true))
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, 6, weapon_g, ammos_g);
        if(weapon_g != 34 && weapon_g != 33) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sniper' tren nguoi.");
        Dialog_Show(playerid, DIALOG_USEAMMO5AS, DIALOG_STYLE_INPUT, "Trang bi - Dan Sniper", "Ban muon nap bao nhieu vien dan ?", "Xac nhan", "Huy bo");
	}
	else if(!strcmp(name, "Medkit", true))
	{
		if(PlayerInfo[playerid][pTimeMedkit] == 0)
		{
			new Float: HP, string[256];
			new Float: HPz = BonusHealth[playerid];
			new Float: HPx = HPz + 100.0;
			GetPlayerHealth(playerid, HP);
			SetPlayerHealth(playerid, HP+30);
			if(HP >= HPx)
			{
				SetPlayerHealth(playerid, HPx);
			}
			PlayerInfo[playerid][pTimeMedkit] = 30 * 60;
            format(string, sizeof string, "{FF8000}* {C2A2DA}%s da su dung medkit.", GetPlayerNameEx(playerid));
            SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);
            format(string, sizeof string, "{FF8000}> {C2A2DA}%s da su dung medkit.", GetPlayerNameEx(playerid));
            SendClientMessage(playerid, COLOR_PURPLE, string);
            ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In", 4.0, 0, 0, 0, 0, 0, 1);
            Inventory_Remove(playerid, pItemId, 1);
		}
		else return SendErrorMessage(playerid, " Ban vua su dung Medkit trong vong 30 phut truoc roi, vui long doi.");
	}
	else if(!strcmp(name, "Hat Giong Lua", true))
	{
		PlantTree_Add(playerid, 0);
	}
	else if(!strcmp(name, "Hat Giong Duoc Lieu", true))
	{
		PlantTree_Add(playerid, 1);
	}
	else if(!strcmp(name, "Hat Giong Cam", true))
	{
		PlantTree_Add(playerid, 2);
	}
	else if(!strcmp(name, "Giong Bo", true))
	{
		Cattle_AddDefault(playerid, 0);
	}
	else if(!strcmp(name, "Giong Nai", true))
	{
		Cattle_AddDefault(playerid, 1);
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

	if(!IsPlayerConnected(giveplayerid) || giveplayerid == INVALID_PLAYER_ID)
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

CMD:clearinventory(playerid, params[])
{
	new
		giveplayerid, str[128];

	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "u", giveplayerid))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/clearinventory [playerid/name]");

	if(giveplayerid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Nguoi choi khong hop le.");

	Inventory_Clear(giveplayerid);

	SendServerMessage(playerid, "Ban da xoa tat ca item trong tui do %s.", GetPlayerNameEx(giveplayerid));
	SendServerMessage(giveplayerid, "%s da xoa tat ca item trong tui do cua ban.", GetPlayerNameEx(playerid));
	format(str, sizeof(str), "[Administrator]: %s da xoa tat ca item trong tui do %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
	ABroadCast( COLOR_YELLOW, str, 2);
	Log("logs/admin_inventory.log", str);
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

CMD:checkinv(playerid, params[])
{
	new
		giveplayerid, str[128];
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");
	if(sscanf(params, "u", giveplayerid))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/checkinv [playerid/name]");
	if(!IsPlayerConnected(giveplayerid)) 
		return SendErrorMessage(playerid, "Nguoi choi khong hop le.");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		SetPVarInt(playerid, "GivePlayerid_Inventory", giveplayerid);
		format(str, sizeof(str), "Ban dang xem tui do cua %s", GetPlayerNameEx(giveplayerid));
		SendClientMessageEx(playerid, COLOR_LIGHTRED, str);
	}
	else if(IsACop(playerid))
	{
		if(GetPlayerSpecialAction(giveplayerid) == SPECIAL_ACTION_HANDSUP || GetPVarInt(giveplayerid, "PlayerCuffed") == 2)
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(giveplayerid == playerid) { 
					SendErrorMessage(playerid, " Ban khong the luc soat chinh minh!"); return 1; 
				}
				SetPVarInt(playerid, "GivePlayerid_Inventory", giveplayerid);
				format(str, sizeof(str), "* %s da luc soat tui do cua %s.", GetPlayerNameEx(playerid),GetPlayerNameEx(giveplayerid));
				ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				SendErrorMessage(playerid, " Nguoi choi do khong gan ban.");
			}
		}else
		{
			SendErrorMessage(playerid, " Nguoi choi do can dau hang de ban luc soat.");
		}
	}
	OpenInventory(playerid, true);
	format(str, sizeof(str), "Ban dang xem tui do cua %s", GetPlayerNameEx(giveplayerid));
	SendClientMessageEx(playerid, COLOR_LIGHTRED, str);
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
	if(!IsPlayerConnected(giveplayerid)) 
		return SendErrorMessage(playerid, "Nguoi choi khong hop le.");
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

CMD:thaomatna(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(GetPVarInt(playerid, "Injured") == 1 || PlayerCuffed[ playerid ] >= 1 || PlayerInfo[ playerid ][ pJailTime ] > 0 || PlayerInfo[playerid][pHospital] > 0)
		{
			SendErrorMessage(playerid, " Ban khong the lam dieu nay bay gio.");
			return 1;
		}

		if(PlayerInfo[playerid][pHasCuff] < 1)
		{
		    SendServerMessage(playerid, " Ban khong co chiec cong tay nao!");
		    return 1;
		}

		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendUsageMessage(playerid, " /thaomatna [Player]");
		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(PlayerInfo[giveplayerid][pMaskOn] && GetPlayerSpecialAction(giveplayerid) == SPECIAL_ACTION_HANDSUP)
				{
					if(!MaskHandle(giveplayerid))
					{
						format(string, sizeof(string), "*%s da thao mat na %s xuong.", GetPlayerNameEx(playerid));
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
					format(string, sizeof(string), "* Ban da bi thao mat na boi %s.", GetPlayerNameEx(playerid));
					SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Ban da thao mat na cua %s xuong.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
					GameTextForPlayer(giveplayerid, "~r~Thao mat na", 2500, 3);
				}
				else
				{
					SendErrorMessage(playerid, " Nguoi do chua dau hang hoac chua bi cuong che !");
					return 1;
				}
			}
			else
			{
				SendErrorMessage(playerid, " Nguoi do khong o gan ban.");
				return 1;
			}
		}
		else
		{
			SendErrorMessage(playerid, " nguoi choi khong hop le.");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid, " Ban khong phai nhan vien chinh phu");
	}
	return 1;
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          TIMER
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

timer ItemTimer[1000](playerid)
{
    if(IsPlayerConnected(playerid))
    {
        for(new i; i < MAX_INVENTORY; i++)
            if(InventoryData[playerid][i][invExists] && InventoryData[playerid][i][invTimer] != 0 && InventoryData[playerid][i][invTimer] < gettime()) 
                Inventory_SendRemoveTimer(playerid, i, InventoryData[playerid][i][invQuantity]);
    }
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
			case 0:{

				CallLocalFunction("OnPlayerUseItem", "dds", playerid, itemId, itemName);
			}
			case 1:{
				PlayerInfo[playerid][pInventoryItem] = itemId;
				Dialog_Show(playerid, GiveItem, DIALOG_STYLE_INPUT, "Cho item", "Xin vui long nhap ten nguoi choi hoac ID:", "Xac nhan", "Huy bo");
			}
			case 2:{
				if(IsPlayerInAnyVehicle(playerid))
					return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the vut item ngay bay gio.");
				else
				{
					format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
					Dialog_Show(playerid, DropItem, DIALOG_STYLE_INPUT, "Vut Item", str, "Vut", "Huy bo");
				}
			}
			case 3:{
				format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon vut item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
				Dialog_Show(playerid, InventoryCH, DIALOG_STYLE_INPUT, "Cat Item", str, "Cat", "<");
			}
		}
	}
	else
	{
		SetPVarInt(playerid, "InvPlayerVehicle", -1);
		SetPVarInt(playerid, "InvPlayerHouse", -1);
	}
	return 1;
}

Dialog:Take_Inventory(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			target = GetPVarInt(playerid, "GivePlayerid_Inventory"),
			itemId = PlayerInfo[target][pInventoryItem],
			itemName[64], str[128];

		strunpack(itemName, InventoryData[target][itemId][invItem]);

		switch(listitem)
		{
			case 0:
			{
				Inventory_Remove(target, itemId, InventoryData[target][itemId][invQuantity]);
				format(str, sizeof(str), "%s da tich thu vat pham %s cua %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(target));
				ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
		else
		{
			Inventory_Remove(playerid, itemId, strval(inputtext), true);
			format(string, sizeof(string), "* %s da vut %d vat pham \"%s\" ra khoi tui do cua ho.", GetPlayerNameEx(playerid), strval(inputtext), itemName);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			new itemidzxc[10];
        	format(itemidzxc, 10, "%d", strval(inputtext));
			SendLogToDiscordRoom("LOG XÓA VẬT PHẨM", "1158001317931921429", "Name", GetPlayerNameEx(playerid, false), "REMOVED", itemName, "Số lượng", itemidzxc, 0xFF00FF);
		}
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
			new id, str[560];
			if(InventoryData[playerid][itemId][invTimer] == 0)
				id = Inventory_Add(giveplayerid, itemName);
			else
				id = Inventory_Add(giveplayerid, itemName, 1, floatround((InventoryData[playerid][itemId][invTimer] - gettime())/60, floatround_ceil));
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
			format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid, false), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(giveplayerid, false), PlayerInfo[giveplayerid][pIP]);
			Log("logs/give_log.txt", str);
			SendLogToDiscordRoom4("LOG ĐƯA VẬT PHẨM", "1166983700597186570", "Name", GetPlayerNameEx(playerid, false), "Người nhận", GetPlayerNameEx(giveplayerid, false), "Vật phẩm", itemName, "Số lượng", "1", 0x8d9922);
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
		printf("GiveQuantity %s", itemName);
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
		new id; 
		if(InventoryData[playerid][itemId][invTimer] == 0)	id = Inventory_Add(giveplayerid, itemName, strval(inputtext));
		else
			id = Inventory_Add(giveplayerid, itemName, strval(inputtext), floatround((InventoryData[playerid][itemId][invTimer] - gettime())/60, floatround_ceil));

		if(id == -1)
			return SendErrorMessage(playerid, "Nguoi choi do khong con slot trong tui do.");

		format(str, sizeof(str), "* %s da lay \"%s\" va dua cho %s.", GetPlayerNameEx(playerid), itemName, GetPlayerNameEx(giveplayerid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(str, sizeof(str), "%s da dua \"%s\" va da duoc them vao trong tui do.", GetPlayerNameEx(playerid), str);
		SendClientMessageEx(giveplayerid, COLOR_YELLOW, str);
		new itemidzxc[10];
		format(itemidzxc, 10, "%d", strval(inputtext));
		SendLogToDiscordRoom4("LOG ĐƯA VẬT PHẨM", "1166983700597186570", "Name", GetPlayerNameEx(playerid, false), "Người nhận", GetPlayerNameEx(giveplayerid, false), "Vật phẩm", itemName, "Số lượng", itemidzxc, 0x8d9922);
		Inventory_Remove(playerid, itemId, strval(inputtext));
		new years,month,day,hourz,minz,sec,time[50];
		getdate(years,month,day);
		gettime(hourz,minz,sec);
		format(time, sizeof time , "%d/%d/%d %d:%d:%d",day,month,years,hourz,minz,sec);
		format(str, sizeof(str), "[%s] %s (%s) da dua %s cho %s (%s).", time, GetPlayerNameEx(playerid, false), PlayerInfo[playerid][pIP], itemName, GetPlayerNameEx(giveplayerid, false), PlayerInfo[giveplayerid][pIP]);
		Log("logs/give_log.txt", str);
	}
	return 1;
}


