
stock InventoryCH_Load(playerid)
{
    for(new pItemId = 0; pItemId != MAX_INVENTORYCH; pItemId++)
	{
		InventoryCH[playerid][pItemId][invExists] = false;
		InventoryCH[playerid][pItemId][invQuantity] = 0;
		InventoryCH[playerid][pItemId][invTimer] = 0;
		InventoryCH[playerid][pItemId][pvSQLID] = 0;
		InventoryCH[playerid][pItemId][hSQLID] = 0;
	}
    new PlayerSQLId = GetPlayerSQLId(playerid),
        str[1080];
    format(str, sizeof(str), "SELECT * FROM `inventorych` WHERE `ID` = '%d'", PlayerSQLId);
    mysql_function_query(MainPipeline, str, true, "OnLoadInventoryCH", "i", playerid);
}

public OnLoadInventoryCH(playerid)
{
    new i, rows, fields, tmp[128];
    cache_get_data(rows, fields, MainPipeline);
    while(i < rows)
    {
        cache_get_field_content(i, "invID", tmp, MainPipeline); InventoryCH[playerid][i][invID] = strval(tmp);
        cache_get_field_content(i, "invModel", InventoryCH[playerid][i][invModel], MainPipeline, 64);
        cache_get_field_content(i, "invQuantity", tmp, MainPipeline); InventoryCH[playerid][i][invQuantity] = strval(tmp);
		cache_get_field_content(i, "invTimer", tmp, MainPipeline); InventoryCH[playerid][i][invTimer] = strval(tmp);
        cache_get_field_content(i, "invItem", InventoryCH[playerid][i][invItem], MainPipeline, 32); 
        cache_get_field_content(i, "pvSQLID", tmp, MainPipeline); InventoryCH[playerid][i][pvSQLID] = strval(tmp);
		cache_get_field_content(i, "hSQLID", tmp, MainPipeline); InventoryCH[playerid][i][hSQLID] = strval(tmp);
        InventoryCH[playerid][i][invExists] = true;
        i++;
    }
    if(i > 0) printf("[LOAD INVENTORY CAR HOUSE] %d du lieu inventory cua %s (ID: %d) da duoc tai.", i, GetPlayerNameEx(playerid), playerid);
}

stock OpenInventoryCarHouse(playerid, const header[])
{
	if(!IsPlayerConnected(playerid))
		return 0;
	new
		items[MAX_MENU_ITEMCHS][64],
		quantitys[MAX_MENU_ITEMCHS],
		itemName[MAX_MENU_ITEMCHS][32],
		expirys[MAX_MENU_ITEMCHS];
    
	for(new i = 0; i < MAX_MENU_ITEMCHS; i++)
	{
		if (InventoryCH[playerid][i][invExists] && (InventoryCH[playerid][i][pvSQLID] != 0 || InventoryCH[playerid][i][hSQLID] != 0))
		{
            if(GetPVarInt(playerid, "InvPlayerVehicle") != -1 && InventoryCH[playerid][i][pvSQLID] == PlayerVehicleInfo[playerid][GetPVarInt(playerid, "InvPlayerVehicle")][pvSlotId])
            {
                strcpy(items[i], InventoryCH[playerid][i][invModel], 64);
                quantitys[i] = InventoryCH[playerid][i][invQuantity];
                strcpy(itemName[i], InventoryCH[playerid][i][invItem], 32);
                expirys[i] = InventoryCH[playerid][i][invTimer] == 0 ? 0 : InventoryCH[playerid][i][invTimer] - gettime();
            }
            else if(GetPVarInt(playerid, "InvPlayerHouse") != -1 && InventoryCH[playerid][i][hSQLID] == HouseInfo[GetPVarInt(playerid, "InvPlayerHouse")][hSQLId])
            {
                strcpy(items[i], InventoryCH[playerid][i][invModel], 64);
                quantitys[i] = InventoryCH[playerid][i][invQuantity];
                strcpy(itemName[i], InventoryCH[playerid][i][invItem], 32);
                expirys[i] = InventoryCH[playerid][i][invTimer] == 0 ? 0 : InventoryCH[playerid][i][invTimer] - gettime();
            }
			
		}
		else
		{
			strcpy(items[i], "_", 64);
			quantitys[i] = -1;
			expirys[i] = 0;
			strcpy(itemName[i], "_", 32);
		}
	}
	new str[128];
	format(str, sizeof str, "%s", header);
	return ShowModelSelectionInvCarHouse(playerid, str ,MODEL_SELECTION_INVENTORYCH, items, sizeof(items), true, quantitys, itemName, true, expirys);
}

public OnModelSelectionResponseInvCH(playerid, extraid, index, modelid[], response)
{
	if((extraid == MODEL_SELECTION_INVENTORYCH && response) && InventoryCH[playerid][index][invExists])
	{
		new
			name[48], str[128];
		strunpack(name, InventoryCH[playerid][index][invItem]);
		PlayerInfo[playerid][pInventoryItem] = index;
		format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon lay item nay:", name, InventoryCH[playerid][index][invQuantity]);
		Dialog_Show(playerid, InventoryCar, DIALOG_STYLE_LIST, name, "Lay ra", "Lua chon", "<");
	}
	return 1;
}

stock InventoryCH_SendRemoveTimer(playerid, pItemId, quantity)
{
	new str[128];
	format(str, sizeof(str), "Vat Pham %s (so luong : %d) cua ban da het han - he thong da tu dong tich thu vat pham", InventoryCH[playerid][pItemId][invItem], quantity);
	SendClientMessageEx(playerid, COLOR_YELLOW, str);
	InventoryCH_Remove(playerid, pItemId, quantity);
}

stock InventoryCH_GetItemID(playerid, item[], quantity = 1, pVehicleId = -1, pHouseId = -1)
{
    pVehicleId = pVehicleId == -1 ? 0 : PlayerVehicleInfo[playerid][pVehicleId][pvSlotId];
    pHouseId = pHouseId == -1 ? 0 :  HouseInfo[pHouseId][hSQLId];
	for(new i = 0; i < MAX_INVENTORYCH; i++)
	{
		if(!InventoryCH[playerid][i][invExists])
			continue;
		if(!strcmp(InventoryCH[playerid][i][invItem], item) && InventoryCH[playerid][i][invQuantity] >= quantity &&
            InventoryCH[playerid][i][pvSQLID] == pVehicleId &&
            InventoryCH[playerid][i][hSQLID] ==  pHouseId)
			return i;
	}
	return -1;
}

stock InventoryCH_Items(playerid)
{
	new count;
	for(new i = 0; i != MAX_INVENTORYCH; i++) if(InventoryData[playerid][i][invExists])
	{
		count++;
	}
	return count;
}

stock InventoryCH_GetFreeID(playerid)
{
	if(InventoryCH_Items(playerid) >= MAX_INVENTORYCH)
		return -1;

	for(new i = 0; i < MAX_INVENTORYCH; i++)
	{
		if(!InventoryCH[playerid][i][invExists])
			return i;
	}
	return -1;
}


stock InventoryCH_Add(playerid, item[], quantity = 1, timer = 0, pVehicleId = -1, pHouseId = -1)	
{
	new
		pItemId = InventoryCH_GetItemID(playerid, item, 1, pVehicleId, pHouseId),
		string[250],
        PlayerSQLId = GetPlayerSQLId(playerid),
		model[64];
	strcpy(model, g_aInventoryItems[Inventory_GetModel(item)][e_InventoryModel], 64);
	if(pItemId == -1 || timer != 0)
	{
		pItemId = InventoryCH_GetFreeID(playerid);
		if(pItemId != -1)
		{
            pVehicleId = pVehicleId == -1 ? 0 : PlayerVehicleInfo[playerid][pVehicleId][pvSlotId];
            pHouseId = pHouseId == -1 ? 0 :  HouseInfo[pHouseId][hSQLId];
            printf("%d ------- %d", pVehicleId, pHouseId);
			strcpy(InventoryCH[playerid][pItemId][invModel], model);
			InventoryCH[playerid][pItemId][invQuantity] = quantity;
			InventoryCH[playerid][pItemId][pvSQLID] = pVehicleId;
			InventoryCH[playerid][pItemId][hSQLID] = pHouseId;
			InventoryCH[playerid][pItemId][invTimer] = timer == 0 ? 0 : gettime() + timer*60;
			strcpy(InventoryCH[playerid][pItemId][invItem], item, 32);
            format(string, sizeof(string), "INSERT INTO `inventorych` (`ID`, `invItem`, `invModel`, `invQuantity`, `invTimer`, `pvSQLID`, `hSQLID`) VALUES('%d', '%s', '%s', '%d', '%d', '%d', '%d')", 
				PlayerSQLId, g_mysql_ReturnEscaped(item, MainPipeline), g_mysql_ReturnEscaped(model, MainPipeline), quantity, InventoryCH[playerid][pItemId][invTimer], pVehicleId, pHouseId);
			mysql_function_query(MainPipeline, string, false, "OnInventoryAddCH", "iii", playerid, pItemId, timer);
			printf("[CREATE INVENTORY CAR HOUSE] %s (ID %d) da duoc them vao du lieu cua %s", InventoryCH[playerid][pItemId][invItem], pItemId, GetPlayerNameEx(playerid));
			new itemidzxc[10];
            format(itemidzxc, 10, "%d", pItemId);
			new header[128];
			format(header, sizeof(header), "LOG ADD VẬT PHẨM CAR(%d)/HOUSE(%d)", pVehicleId, pHouseId);
            new itemidzxcv[10];
            format(itemidzxcv, 10, "%d", quantity);
			SendLogToDiscordRoom4(header, "1158001303033757716", "Name", GetPlayerNameEx(playerid, false), "UPDATE", InventoryCH[playerid][pItemId][invItem], "Số lượng", itemidzxcv, "ITEMID", itemidzxc, 0x25b807);
			return pItemId;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventorych` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryCH[playerid][pItemId][invID]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryCH[playerid][pItemId][invQuantity] += quantity;
		printf("[UPDATE INVENTORY] %s (ID %d) da duoc them %d so luong vao du lieu cua %s", InventoryCH[playerid][pItemId][invItem], pItemId, quantity, GetPlayerNameEx(playerid));
		new itemidzxc[10];
        format(itemidzxc, 10, "%d", pItemId);
        new itemidzxcv[10];
        format(itemidzxcv, 10, "%d", quantity);
		new header[128];
		format(header, sizeof(header), "LOG ADD VẬT PHẨM CAR(%d)/HOUSE(%d)", pVehicleId, pHouseId);
		SendLogToDiscordRoom4(header, "1158001303033757716", "Name", GetPlayerNameEx(playerid, false), "UPDATE", InventoryCH[playerid][pItemId][invItem], "Số lượng", itemidzxcv, "ITEMID", itemidzxc, 0x25b807);
	}
	return 1;
}

stock InventoryCH_Update(playerid, pItemId, quantity = 1, isAdd = true, pVehicleId = -1, pHouseId = -1)
{
    new itemTimer;
    printf("InventoryCH_Update %d -- %d", pVehicleId, pHouseId);
	if(isAdd)
	{
        itemTimer = InventoryData[playerid][pItemId][invTimer] == 0 ? 0 : floatround((InventoryData[playerid][pItemId][invTimer] - gettime())/60, floatround_ceil);
		InventoryCH_Add(playerid, InventoryData[playerid][pItemId][invItem], quantity, itemTimer,
		pVehicleId, pHouseId);
        printf("%d Item", quantity);
		Inventory_Remove(playerid, pItemId, quantity);
	}
	else
	{
        itemTimer = InventoryCH[playerid][pItemId][invTimer] == 0 ? 0 : floatround((InventoryCH[playerid][pItemId][invTimer] - gettime())/60, floatround_ceil);
		Inventory_AddEx(playerid, InventoryCH[playerid][pItemId][invItem], quantity, itemTimer);
		InventoryCH_Remove(playerid, pItemId, quantity);
	}
	return 1;
}


public OnInventoryAddCH(playerid, pItemId, timer)
{
	InventoryCH[playerid][pItemId][invExists] = true;
	InventoryCH[playerid][pItemId][invID] = mysql_insert_id(MainPipeline);
	return 1;
}

stock InventoryCH_Remove(playerid, pItemId, quantity = 1) //ID cua InventoryCH
{
	new
		string[258],
        PlayerSQLId = GetPlayerSQLId(playerid);

	if(InventoryCH[playerid][pItemId][invExists])
	{
		if(InventoryCH[playerid][pItemId][invQuantity] > 0)
		{
			InventoryCH[playerid][pItemId][invQuantity] -= quantity;
		}
		if(quantity == -1 || InventoryCH[playerid][pItemId][invQuantity] < 1)
		{
			InventoryCH[playerid][pItemId][invExists] = false;
			InventoryCH[playerid][pItemId][invQuantity] = 0;
			InventoryCH[playerid][pItemId][pvSQLID] = 0;
			InventoryCH[playerid][pItemId][hSQLID] = 0;
			format(string, sizeof(string), "DELETE FROM `inventorych` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerSQLId, InventoryCH[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		else if(quantity != -1 && InventoryCH[playerid][pItemId][invQuantity] > 0)
		{
			format(string, sizeof(string), "UPDATE `inventorych` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerSQLId, InventoryCH[playerid][pItemId][invID]);
			mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		}
		return 1;
	}
	return 0;
}

Dialog:InventoryCH(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			itemId = PlayerInfo[playerid][pInventoryItem],
			itemName[32], str[128];
		if(isnull(inputtext))
		{
			format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon cat item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
			return Dialog_Show(playerid, InventoryCH, DIALOG_STYLE_INPUT, "Cat item", str, "Cat", "Huy bo");
		}

		if(strval(inputtext) < 1 || strval(inputtext) > InventoryData[playerid][itemId][invQuantity])
		{
			format(str, sizeof(str), "So luong khong hop le.\n\nItem: %s - So luong: %d\n\nXin vui long nhap so luong ban muon cat item nay:", itemName, InventoryData[playerid][itemId][invQuantity]);
			return Dialog_Show(playerid, InventoryCH, DIALOG_STYLE_INPUT, "Cat item", str, "Cat", "Huy bo");
		}
		strunpack(itemName, InventoryData[playerid][itemId][invItem]);
		if(GetPVarInt(playerid, "InvPlayerVehicle") != -1)
		{
			if(InventoryCH_Items(playerid) >= MAX_INVENTORYCH)
			{
				SendErrorMessage(playerid, "Ban khong con slot de chua vat pham trong xe cua ban");
				return 1;
			} 
            printf("GetPVarInt(playerid %d", GetPVarInt(playerid, "InvPlayerVehicle"));
			InventoryCH_Update(playerid, itemId, strval(inputtext), .pVehicleId = GetPVarInt(playerid, "InvPlayerVehicle"));
			format(str, sizeof(str), "Ban da cat vat pham %s vao chiec xe cua ban.", itemName);
			SendClientMessageEx(playerid, COLOR_MAIN, str);
		}
		else if(GetPVarInt(playerid, "InvPlayerHouse") != -1)
		{
			InventoryCH_Update(playerid, itemId, strval(inputtext), .pHouseId = GetPVarInt(playerid, "InvPlayerHouse"));
			format(str, sizeof(str), "Ban da cat vat pham %s vao ngoi nha cua ban.", itemName);
			SendClientMessageEx(playerid, COLOR_MAIN, str);
		}
	}
	else
	{
		SetPVarInt(playerid, "InvPlayerVehicle", -1);
		SetPVarInt(playerid, "InvPlayerHouse", -1);
	}
	
	return 1;
}

Dialog:InventoryCar(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			itemId = PlayerInfo[playerid][pInventoryItem],
			itemName[64], str[128];
		if(isnull(inputtext))
		{
			format(str, sizeof(str), "Item: %s - So luong: %d\n\nXin vui long nhap so luong ban muon lay item nay:", itemName, InventoryCH[playerid][itemId][invQuantity]);
			return Dialog_Show(playerid, InventoryCar, DIALOG_STYLE_INPUT, "Lay item", str, "Lay", "Huy bo");
		}
		else if(strval(inputtext) < 1 || strval(inputtext) > InventoryCH[playerid][itemId][invQuantity])
		{
			format(str, sizeof(str), "So luong khong hop le.\n\nItem: %s - So luong: %d\n\nXin vui long nhap so luong ban muon lay item nay:", itemName, InventoryCH[playerid][itemId][invQuantity]);
			return Dialog_Show(playerid, InventoryCar, DIALOG_STYLE_INPUT, "Lay item", str, "Lay", "Huy bo");
		}
		else
		{
			strunpack(itemName, InventoryCH[playerid][itemId][invItem]);
			if(GetPVarInt(playerid, "InvPlayerVehicle") != -1)
			{
				if(InventoryCH_Items(playerid) >= PlayerInfo[playerid][pCapacity])
				{
					SendErrorMessage(playerid, "Tui do cua ban khong con cho trong de cat vao.");
					return 1;
				}
				InventoryCH_Update(playerid, itemId, strval(inputtext), false);
				format(str, sizeof(str), "Ban da lay vat pham %s tu chiec xe vao tui do cua ban.", itemName);
				SendClientMessageEx(playerid, COLOR_MAIN, str);
				format(str, sizeof(str), "* %s da lay vat pham \"%s\" ra khoi chiec xe.", GetPlayerNameEx(playerid), itemName);
				ProxDetector(20.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				OpenInventoryCarHouse(playerid, "Inventory Car");
				OpenInventory(playerid);
			}
			else if(GetPVarInt(playerid, "InvPlayerHouse") != -1)
			{
				if(InventoryCH_Items(playerid) >= PlayerInfo[playerid][pCapacity])
				{
					SendErrorMessage(playerid, "Tui do cua ban khong con cho trong de cat vao.");
					return 1;
				}
				InventoryCH_Update(playerid, itemId, strval(inputtext), false);
				format(str, sizeof(str), "Ban da lay vat pham %s tu chiec xe vao tui do cua ban.", itemName);
				SendClientMessageEx(playerid, COLOR_MAIN, str);
				format(str, sizeof(str), "* %s da lay vat pham \"%s\" ra khoi chiec xe.", GetPlayerNameEx(playerid), itemName);
				ProxDetector(20.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				OpenInventoryCarHouse(playerid, "Inventory House");
				OpenInventory(playerid);
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


CMD:invch(playerid, params[])
{
	if(PlayerInfo[playerid][pHospital])
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the mo tui do ngay bay gio.");

	if(PlayerInfo[playerid][pJailTime] > 0)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong the mo tui do khi ban dang trong tu.");
	new carid = GetPlayerVehicleID(playerid);
	new closestcar = GetClosestCar(playerid,carid);
	if(IsPlayerInRangeOfVehicle(playerid, closestcar, 5.0))
	{
		new v = GetPlayerVehicle(playerid, closestcar);
		if(v != -1)
		{
			SetPVarInt(playerid, "InvPlayerVehicle", v);
			OpenInventoryCarHouse(playerid, "INV CAR");
			OpenInventory(playerid);
			return 1;
		}
	}
	if(Homes[playerid] > 0)
	{
		for(new i; i < MAX_HOUSES; i++)
		{
			if(GetPlayerSQLId(playerid) == HouseInfo[i][hOwnerID] && IsPlayerInRangeOfPoint(playerid, 50, HouseInfo[i][hInteriorX], HouseInfo[i][hInteriorY], HouseInfo[i][hInteriorZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hIntVW] && GetPlayerInterior(playerid) == HouseInfo[i][hIntIW])
			{
				SetPVarInt(playerid, "InvPlayerHouse", i);
				OpenInventoryCarHouse(playerid, "INV HOUSE");
				OpenInventory(playerid);
				return 1;
			}
		}
	}
	return 1;
}
