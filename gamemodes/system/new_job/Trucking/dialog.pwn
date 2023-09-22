Dialog:DIALOG_STARTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
        {
            case 0:{
                new string[4096];
                format(string, sizeof(string), "{FFFFFF}ID\t\tTen Nha May\t\tVi Tri\t\tMet");
                new zone[MAX_ZONE_NAME],Float:Distance;
                for(new i; i < sizeof(FactoryData); i++)
                {
                    Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[i][FactoryPos][0], FactoryData[i][FactoryPos][1], FactoryData[i][FactoryPos][2]);
                    Get3DZone(FactoryData[i][FactoryPos][0], FactoryData[i][FactoryPos][1], FactoryData[i][FactoryPos][2], zone, sizeof(zone));
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t%s\t\t%0.2f Met",string, i, FactoryData[i][FactoryName], zone, Distance);
                }
                Dialog_Show(playerid, DIALOG_LISTFACTORY ,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
            }
            case 1:{
                new string[4096];
                format(string, sizeof(string), "{FFFFFF}ID\t\tTen Nha May\t\tVi Tri\t\tMet");
                new zone[MAX_ZONE_NAME],Float:Distance;
                for(new i; i < sizeof(FactoryExportData); i++)
                {
                    Distance = GetPlayerDistanceFromPoint(playerid, FactoryExportData[i][FactoryPos][0], FactoryExportData[i][FactoryPos][1], FactoryExportData[i][FactoryPos][2]);
                    Get3DZone(FactoryExportData[i][FactoryPos][0], FactoryExportData[i][FactoryPos][1], FactoryExportData[i][FactoryPos][2], zone, sizeof(zone));
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t%s\t\t%0.2f Met",string, i, FactoryExportData[i][FactoryName], zone, Distance);
                }
                Dialog_Show(playerid, DIALOG_LISTFACTORY2 ,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
            }
        }
	}
	return 1;
}

Dialog:DIALOG_STARTFACTORY2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
        {
            case 0:{
                new numFoundFactories = 0;
                new MaxFactiory = sizeof(FactoryData);
                for (new i = 0; i < MaxFactiory; i++) {
                    new productNameLength = strlen(FactoryData[i][ProductName]);
                    for (new j = 0; j < productNameLength; j++) {
                        if(IsProductValid(playerid, FactoryData[i][ProductName][j])) {
                            PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                            break;
                        }
                    }
                }
                new str[560], zone[MAX_ZONE_NAME],Float:Distance;
                format(str, sizeof(str), "Ten Nha May\t\tVi Tri\t\tMet");
                for(new i; i < numFoundFactories;i++)
                {
                    Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2]);
                    Get3DZone(FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2], zone, sizeof(zone));
                    format(str, sizeof(str), "%s\n%s\t\t%s\t\t%0.2f Met", str, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryName], zone, Distance);
                }
                Dialog_Show(playerid, DIALOG_SUGGESTFACTORY, DIALOG_STYLE_TABLIST_HEADERS, "Cong viec Trucker", str, "Lua chon", "Huy bo");
            }
            case 1:{
                new numFoundFactories = 0;
                new MaxFactiory = sizeof(FactoryExportData);
                for (new i = 0; i < MaxFactiory; i++) {
                    new productNameLength = strlen(FactoryExportData[i][ProductName]);
                    for (new j = 0; j < productNameLength; j++) {
                        if(IsProductValid(playerid, FactoryExportData[i][ProductName][j])) {
                            PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                            break;
                        }
                    }
                }
                new str[560], zone[MAX_ZONE_NAME],Float:Distance;
                format(str, sizeof(str), "Ten Nha May\t\tVi Tri\t\tMet");
                for(new i; i < numFoundFactories;i++)
                {
                    Distance = GetPlayerDistanceFromPoint(playerid, FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2]);
                    Get3DZone(FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2], zone, sizeof(zone));
                    format(str, sizeof(str), "%s\n%s\t\t%s\t\t%0.2f Met", str, FactoryExportData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryName], zone, Distance);
                }
                Dialog_Show(playerid, DIALOG_SUGGESTFACTORY2, DIALOG_STYLE_TABLIST_HEADERS, "Cong viec Trucker", str, "Lua chon", "Huy bo");
            }
        }
	}
	return 1;
}

Dialog:DIALOG_LISTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100];
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryData[listitem][FactoryName], listitem);
        format(string, sizeof(string), "San Pham\t\tGia\t\tTon Kho");
        for(new i; i < strlen(FactoryData[listitem][ProductName]); i++)
        {
            format(string, sizeof(string), "%s\n{FF8000}Mat Hang: {FFFFFF}%s({FF8000}ID: {FFFFFF}%i)\n{FF8000}Gia tien: {FFFFFF}$%d\n{FF8000}Ton Kho: {FFFFFF}%d/%d{FFFFFF}\
            \n\t\t----------------\t\t", 
                string, ProductData[FactoryData[listitem][ProductName][i]][ProductName], listitem, FactoryData[listitem][ProductPrice][i], FactoryData[listitem][WareHouse][i], FactoryData[listitem][MaxWareHouse][i]);
        }
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, szString, string, "<", "");
	}
	return 1;
}

Dialog:DIALOG_LISTFACTORY2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100];
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryExportData[listitem][FactoryName], listitem);
        format(string, sizeof(string), "San Pham\t\tGia\t\tSo Luong Da Nhap Khau");
        for(new i; i < strlen(FactoryExportData[listitem][ProductName]); i++)
        {
            format(string, sizeof(string), "%s\n{FF8000}Mat Hang: {FFFFFF}%s({FF8000}ID: {FFFFFF}%i)\n{FF8000}Gia tien: {FFFFFF}$%d\n{FF8000}Nhap Khau: {FFFFFF}%d/%d{FFFFFF}\
            \n\t\t----------------\t\t", 
                string, ProductData[FactoryExportData[listitem][ProductName][i]][ProductName], listitem, FactoryExportData[listitem][ProductPrice][i], FactoryExportData[listitem][WareHouse][i], FactoryExportData[listitem][MaxWareHouse][i]);
        }
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, szString, string, "<", "");
	}
	return 1;
}

Dialog:DIALOG_SUGGESTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100], index = PlayerTruckerData[playerid][SuggestFactory][listitem];
        SetPVarInt(playerid, "SelectFactoryID", index);
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryData[index][FactoryName], index);
        format(string, sizeof(string), "San Pham\t\tGia\t\tTon Kho");
        for(new i; i < strlen(FactoryData[index][ProductName]); i++)
        {
            format(string, sizeof(string), "%s\n{FF8000}Mat Hang: {FFFFFF}%s({FF8000}ID: {FFFFFF}%i)\n{FF8000}Gia tien: {FFFFFF}$%d\n{FF8000}Kho ton: {FFFFFF}%d/%d{FFFFFF}\
            \n\t\t----------------\t\t", 
                string, ProductData[FactoryData[index][ProductName][i]][ProductName], FactoryData[index][ProductName][i], FactoryData[index][ProductPrice][i], FactoryData[index][WareHouse][i], FactoryData[index][MaxWareHouse][i]);
        }
        Dialog_Show(playerid, DIALOG_SETPOINTFACTORY, DIALOG_STYLE_MSGBOX, szString, string, "Toi Dia Diem", "<");
	}
	return 1;
}

Dialog:DIALOG_SUGGESTFACTORY2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100], index = PlayerTruckerData[playerid][SuggestFactory][listitem];
        SetPVarInt(playerid, "SelectFactoryID", index);
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryExportData[index][FactoryName], index);
        format(string, sizeof(string), "San Pham\t\tGia\t\tTon Kho");
        for(new i; i < strlen(FactoryExportData[index][ProductName]); i++)
        {
            format(string, sizeof(string), "%s\n{FF8000}Mat Hang: {FFFFFF}%s({FF8000}ID: {FFFFFF}%i)\n{FF8000}Gia tien: {FFFFFF}$%d\n{FF8000}Kho ton: {FFFFFF}%d/%d{FFFFFF}\
            \n\t\t----------------\t\t", 
                string, ProductData[FactoryExportData[index][ProductName][i]][ProductName], FactoryExportData[index][ProductName][i], FactoryExportData[index][ProductPrice][i], FactoryExportData[index][WareHouse][i], FactoryExportData[index][MaxWareHouse][i]);
        }
        Dialog_Show(playerid, DIALOG_SETPOINTFACTORY2, DIALOG_STYLE_MSGBOX, szString, string, "Toi Dia Diem", "<");
	}
	return 1;
}

Dialog:DIALOG_SETPOINTFACTORY2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index = GetPVarInt(playerid, "SelectFactoryID");
        SetPlayerCheckpoint(playerid, FactoryExportData[index][FactoryPos][0], FactoryExportData[index][FactoryPos][1], FactoryExportData[index][FactoryPos][2], 5);
        SendServerMessage(playerid, "Ban da nhan duoc vi tri tren checkpoint.");
	}
	return 1;
}

Dialog:DIALOG_SETPOINTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index = GetPVarInt(playerid, "SelectFactoryID");
        SetPlayerCheckpoint(playerid, FactoryData[index][FactoryPos][0], FactoryData[index][FactoryPos][1], FactoryData[index][FactoryPos][2], 5);
        SendServerMessage(playerid, "Ban da nhan duoc vi tri tren checkpoint.");
	}
	return 1;
}

Dialog:DIALOG_STARTTRUCKER(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new str[256];
        switch(listitem)
        {
            case 0:{
                SetPVarInt(playerid, "MissionTruck", 1);
                new CarTruckID = GetCarTruckID(PlayerInfo[playerid][pRegisterCarTruck]);
                new UnitID = CarTruckWorking[CarTruckID][CarUnitType][GetUnitType(CarTruckID)];
                new matchingProducts[sizeof(ProductData)];
                new numMatchingProducts = 0;
                for (new i = 0; i < sizeof(ProductData); i++)
                {
                    if (ProductData[i][ProductUnitID] == UnitID)
                    {
                        matchingProducts[numMatchingProducts] = i;
                        numMatchingProducts++;
                    }
                }
                if (numMatchingProducts == 0)
                {
                    return -1;
                }
                for(new i; i < CarTruckWorking[CarTruckID][Weight]; i++)
                {
                    PlayerTruckerData[playerid][MissionProduct][i] = matchingProducts[random(numMatchingProducts)];
                    format(str, sizeof(str), "%s\nSan Pham %d: {FF0000}%s{FFFFFF}", str, i, ProductData[PlayerTruckerData[playerid][MissionProduct][i]][ProductName]);
                }
                format(str, sizeof(str), "Ban da nhan duoc nhiem vu lay san pham %s .\nSu dung lenh (/goiynhamay) :\nDe co the biet duoc nha may can den de lay san pham.", str);
                Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}%s", "<", "", str);
            }
        }
    }
    return 1;
}

Dialog:DIALOG_BUYPRODUCT(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new str[256];
        new factoryID = GetPVarInt(playerid, "BUY_FactoryID");
        if(GetPVarInt(playerid, "MissionTruck") == 1)
        {
            listitem = PlayerTruckerData[playerid][MissionBuy][listitem];
        }
        format(str, sizeof(str), "Mua san pham %s thanh cong.", ProductData[FactoryData[factoryID][ProductName][listitem]][ProductName]);
        GivePlayerCash(playerid, FactoryData[factoryID][ProductPrice][listitem]);
        RemoveMissionProduct(playerid, FactoryData[factoryID][ProductName][listitem]);
        SendClientMessageEx(playerid, COLOR_1YELLOW, str);
        SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1220, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
        SetPVarInt(playerid, "CarryProductToCar", 1);
    }
    return 1;
}