Dialog:DIALOG_LISTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100], strImport[1000], checkMax, islocker[50], strExport[1000];
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryData[listitem][FactoryName], listitem);
        islocker = FactoryData[listitem][IsLocked] == 0 ? "Dang mo cua" : "Dong Cua"; 
        format(string, sizeof(string), "Chao mung ban den voi {69FF00}%s {00E0FF}(%s)", FactoryData[listitem][FactoryName], islocker);
        new MaxExport = strlen(FactoryData[listitem][ProductName]),
            MaxImport = strlen(FactoryData[listitem][ProductImportName]);
        if(MaxExport > 0){
            format(strExport, sizeof(strExport), "{69FF00}Xuat Khau:\nMat Hang\t\tGia\t\tNang Suat/Gio\t\tKho Hang");
        }
        if(MaxImport > 0){
            format(strImport, sizeof(strImport), "{69FF00}Nhap Khau:\nMat Hang\t\tGia\t\tNang Suat/Gio\t\tKho Hang");
        }
        if(MaxExport > MaxImport)   checkMax = MaxExport;
        else    checkMax = MaxImport;
        for(new i; i < checkMax; i++){
            if(i <MaxExport )
            {
                format(strExport, sizeof(strExport), "%s\n{FFFFFF}%s\t\t$%d\t\t%d\t\t%d/%d{FFFFFF}", strExport, ProductData[FactoryData[listitem][ProductName][i]][ProductName], FactoryData[listitem][ProductPrice][i], FactoryData[listitem][Productivity][i], FactoryData[listitem][WareHouse][i], FactoryData[listitem][MaxWareHouse][i]);
            }
            if(i < MaxImport)
            {
                format(strImport, sizeof(strImport), "%s\n{FFFFFF}%s\t\t$%d\t\t%d\t\t%d/%d{FFFFFF}", strImport, ProductData[FactoryData[listitem][ProductImportName][i]][ProductName], FactoryData[listitem][ProductImportPrice][i], FactoryData[listitem][ProductImport][i], FactoryData[listitem][ImportWareHouse][i], FactoryData[listitem][ImportMaxWareHouse][i]);
            }
        }
        format(string, sizeof(string), "%s\n\n%s\n\n%s", string, strExport, strImport);
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, szString, string, "<", "");
	}
	return 1;
}


Dialog:DIALOG_SUGGESTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100], strImport[1000], checkMax, islocker[50], strExport[1000], 
            index = PlayerTruckerData[playerid][SuggestFactory][listitem];
        SetPVarInt(playerid, "SelectFactoryID", index);
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryData[index][FactoryName], index);
        islocker = FactoryData[index][IsLocked] == 0 ? "Dang mo cua" : "Dong Cua"; 
        format(string, sizeof(string), "Chao mung ban den voi {69FF00}%s {00E0FF}(%s)", FactoryData[index][FactoryName], islocker);
        new MaxExport = strlen(FactoryData[index][ProductName]),
            MaxImport = strlen(FactoryData[index][ProductImportName]);
        if(MaxExport > 0){
            format(strExport, sizeof(strExport), "{69FF00}Xuat Khau:\nMat Hang\t\tGia\t\tNang Suat/Gio\t\tKho Hang");
        }
        if(MaxImport > 0){
            format(strImport, sizeof(strImport), "{69FF00}Nhap Khau:\nMat Hang\t\tGia\t\tNang Suat/Gio\t\tKho Hang");
        }
        if(MaxExport > MaxImport)   checkMax = MaxExport;
        else    checkMax = MaxImport;
        for(new i; i < checkMax; i++){
            if(i <MaxExport )
            {
                format(strExport, sizeof(strExport), "%s\n{FFFFFF}%s\t\t$%d\t\t%d\t\t%d/%d{FFFFFF}", strExport, 
                    ProductData[FactoryData[index][ProductName][i]][ProductName], 
                    FactoryData[index][ProductPrice][i], FactoryData[index][Productivity][i], 
                    FactoryData[index][WareHouse][i], FactoryData[index][MaxWareHouse][i]);
            }
            if(i < MaxImport)
            {
                format(strImport, sizeof(strImport), "%s\n{FFFFFF}%s\t\t$%d\t\t%d\t\t%d/%d{FFFFFF}", strImport, 
                    ProductData[FactoryData[index][ProductImportName][i]][ProductName], 
                    FactoryData[index][ProductImportPrice][i], FactoryData[index][ProductImport][i], 
                    FactoryData[index][ImportWareHouse][i], FactoryData[index][ImportMaxWareHouse][i]);
            }
        }
        format(string, sizeof(string), "%s\n\n%s\n\n%s", string, strExport, strImport);
        Dialog_Show(playerid, DIALOG_SETPOINTFACTORY, DIALOG_STYLE_MSGBOX, szString, string, "Toi Dia Diem", "<");
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
                new iVehicleID = GetPlayerCarID(playerid, PlayerInfo[playerid][pRegisterCarTruck]);
                if(PlayerVehicleInfo[playerid][iVehicleID][pvSpawned] == 0) return SendErrorMessage(playerid, "Ban can lay chiec xe da dang ky van chuyen de lam viec.");
                SetPVarInt(playerid, "MissionTruck", 1);
                new CarTruckID = GetCarTruckID(PlayerVehicleInfo[playerid][iVehicleID][pvId]);
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
        new index = PlayerTruckerData[playerid][MissionBuy][listitem];
        new productID = FactoryData[factoryID][ProductName][index];
        format(str, sizeof(str), "Mua san pham %s thanh cong.", ProductData[productID][ProductName]);
        new money = FactoryData[factoryID][ProductPrice][index] * -1;
        GivePlayerCash(playerid, money);
        SetPVarInt(playerid, "ClaimProduct", productID);
        RemoveMissionProduct(playerid, productID);
        pLoadProduct[playerid] = productID;
        SendClientMessageEx(playerid, COLOR_1YELLOW, str);
        SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
        SetPVarInt(playerid, "CarryProductToCar", 1);
    }
    return 1;
}

Dialog:DIALOG_SELLPRODUCT(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new str[256];
        new factoryID = GetPVarInt(playerid, "Sell_ProductID");
        if(GetPVarInt(playerid, "MissionTruck") == 1)
        {
            listitem = PlayerTruckerData[playerid][ClaimProduct][listitem];
        }
        format(str, sizeof(str), "Ban da ban san pham %s thanh cong.", ProductData[FactoryData[factoryID][ProductName][listitem]][ProductName]);
        GivePlayerCash(playerid, FactoryData[factoryID][ProductPrice][listitem]);
        SendClientMessageEx(playerid, COLOR_1YELLOW, str);
        RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

Dialog:DIALOG_CARCLAIMPRODUCT(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new index = PlayerTruckerData[playerid][ClaimFromCar][listitem],
            ProductId = VehicleTruckerData[playerid][index][vtProductID];
        pLoadProduct[playerid] = ProductId;
        VEHICLETRUCKER_DELETE(playerid, index);
        SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
        new string[MAX_PLAYER_NAME + 44];
        format(string, sizeof(string), "* %s da lay thung hang %s tren xe xuong.", GetPlayerNameEx(playerid), ProductData[ProductId][ProductName]);
        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    return 1;
}
