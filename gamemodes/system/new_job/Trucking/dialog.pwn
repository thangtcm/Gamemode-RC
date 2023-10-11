Dialog:DIALOG_LISTFACTORY(playerid, response, listitem, inputtext[])
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
        new CheckValid = 0;
        for(new i; i < checkMax; i++){
            if(i < MaxExport && CheckValid == 0)
            {
                if(FactoryData[index][ProductName][i] != -1)
                {
                    format(strExport, sizeof(strExport), "%s\n{FFFFFF}%s\t\t$%d\t\t%d\t\t%d/%d{FFFFFF}", strExport, 
                    ProductData[FactoryData[index][ProductName][i]][ProductName], 
                    FactoryData[index][ProductPrice][i], FactoryData[index][Productivity][i], 
                    FactoryData[index][WareHouse][i], FactoryData[index][MaxWareHouse][i]);
                }
                else
                {
                    CheckValid = 1;
                }
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
        DeletePVar(playerid, "SelectFactoryID");
	}else
    {
        if(GetPVarInt(playerid, "IsPlayerSuggest") != 0)
        {
            FactorySuggest(playerid);
        }
        else
        {
            FactoryInformation(playerid);
        }
    }
	return 1;
}

Dialog:DIALOG_STARTTRUCKER(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new str[1065];
        switch(listitem)
        {
            case 0:{
                new iVehicleID = PlayerInfo[playerid][pRegisterCarTruck];
                if(PlayerVehicleInfo[playerid][iVehicleID][pvSlotId] == 0) return SendErrorMessage(playerid, "Ban chua dang ky xe van chuyen.");
                if(PlayerVehicleInfo[playerid][iVehicleID][pvSpawned] == 0) return SendErrorMessage(playerid, "Ban can lay chiec xe da dang ky van chuyen ra khoi kho xe de lam viec.");
                if(VehicleTruckerCount(playerid, PlayerVehicleInfo[playerid][iVehicleID][pvSlotId]) > 0) return SendErrorMessage(playerid, "Dang ky nhiem vu that bai (Ban can ban' het hang hoa co trong phuong tien van chuyen cua ban truoc).");
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
                    return 1;
                }
                SetPVarInt(playerid, "MaxMissionTruck", CarTruckWorking[CarTruckID][Weight]);
                printf("RNNNN");
                for(new i; i < CarTruckWorking[CarTruckID][Weight]; i++)
                {
                    PlayerTruckerData[playerid][MissionProduct][i] = matchingProducts[random(numMatchingProducts)];
                    format(str, sizeof(str), "%s\nSan Pham %d: {FF0000}%s{FFFFFF}", str, i, ProductData[PlayerTruckerData[playerid][MissionProduct][i]][ProductName]);
                }
                format(str, sizeof(str), "Ban da nhan duoc nhiem vu lay san pham %s .\nSu dung lenh (/goiynhamay) :\nDe co the biet duoc nha may can den de lay san pham.", str);
                Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}%s", "<", "", str);
            }
            case 1:{
                DeletePVar(playerid, "ViewTutorialTruck");
                NextTutorialTruck(playerid);
            }
        }
    }
    return 1;
}

Dialog:DIALOG_BUYPRODUCT(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new factoryID = GetPVarInt(playerid, "BUY_FactoryID"), index = PlayerTruckerData[playerid][MissionBuy][listitem], 
            money, str[256], productID;
        money = FactoryData[factoryID][ProductPrice][index];
        printf("%d -- money %d", GetPlayerCash(playerid), money);
        if(GetPlayerCash(playerid) < money) return SendErrorMessage(playerid, "Ban khong du tien de mua thung hang nay.");
        if(FactoryData[factoryID][WareHouse][index] <= 0) return SendErrorMessage(playerid, "Nha may nay khong du so luong san pham de ban cho ban.");
        
        productID = FactoryData[factoryID][ProductName][index];
        
        if(GetPVarInt(playerid, "MissionTruck") == 1)  {
            MissionProduct_Update(playerid, productID);
        } 
        PlayerTruckerData[playerid][ClaimFactoryID] = factoryID;
        format(str, sizeof(str), "Mua san pham %s thanh cong.", ProductData[productID][ProductName]);
        
        FactoryData[factoryID][WareHouse][index] -= FactoryData[factoryID][Productivity][index];
        
        if(FactoryData[factoryID][WareHouse][index] <= 0)
            FactoryData[factoryID][WareHouse][index] = 0;
        new moneyzxc[30];
        format(moneyzxc, 30, "%d$", FactoryData[factoryID][ProductPrice][index]);
        SendLogToDiscordRoom("LOG MUA THÙNG HÀNG", "1157969036848668733", "Name", GetPlayerNameEx(playerid), "Đã mua", ProductData[productID][ProductName], "Giá tiền", moneyzxc, 0x992422);
        GivePlayerCash(playerid, money*-1);
        pLoadProduct[playerid] = productID;
        SendClientMessageEx(playerid, COLOR_MAIN, str);
        switch(ProductData[productID][ProductUnitID])
        {
            case 0, 6:
            {
                SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
            }
        }
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
        if(pLoadProduct[playerid] == -1) return SendErrorMessage(playerid, "Ban khong co san pham nay.");
        new index = PlayerTruckerData[playerid][SellProduct][listitem];
        if(IsProductImport(factoryID, pLoadProduct[playerid]))
        {
            if(pLoadProduct[playerid] != FactoryData[factoryID][ProductImportName][index]) return SendErrorMessage(playerid, "Ban khong co san pham nay.");
            if(FactoryData[factoryID][ImportWareHouse][index] > FactoryData[factoryID][ImportMaxWareHouse][index] - FactoryData[factoryID][ProductImport][index]) return SendErrorMessage(playerid, "Nha may nay khong du so luong san pham de ban cho ban.");
            new money;
            if(GetPVarInt(playerid, "MissionTruck") == 1)
            {
                money = FactoryData[factoryID][ProductImportPrice][index]*2;
                SendServerMessage(playerid, "Ban nhan duoc gia tien loi nhuan x2 thay vi 1 vi lam nhiem vu.");
                SetPVarInt(playerid, "MaxMissionTruck", GetPVarInt(playerid, "MaxMissionTruck") - 1);
            }
            else    money = FactoryData[factoryID][ProductImportPrice][index];
            GivePlayerCash(playerid, money);

            FactoryData[factoryID][ImportWareHouse][index] += FactoryData[factoryID][ProductImport][index];
            if(FactoryData[factoryID][ImportWareHouse][index] > FactoryData[factoryID][ImportMaxWareHouse][index])
                FactoryData[factoryID][ImportWareHouse][index] = FactoryData[factoryID][ImportMaxWareHouse][index];
            new moneyzxc[30];
            format(str, sizeof(str), "Ban da ban san pham %s thanh cong.", ProductData[pLoadProduct[playerid]][ProductName]);
            format(moneyzxc, 30, "%d$", FactoryData[factoryID][ProductImportPrice][index]);
            SendLogToDiscordRoom("LOG BÁN THÙNG HÀNG", "1157969051264503838", "Name", GetPlayerNameEx(playerid), "Đã bán", ProductData[pLoadProduct[playerid]][ProductName], "Giá tiền", moneyzxc, 0x229926);
            SendClientMessageEx(playerid, COLOR_1YELLOW, str);
        }
        else
        {
            if(pLoadProduct[playerid] != FactoryData[factoryID][ProductName][index]) return SendErrorMessage(playerid, "Ban khong co san pham nay.");
            new money;

            money = FactoryData[factoryID][ProductPrice][index];
            GivePlayerCash(playerid, money);
            if(GetPVarInt(playerid, "MissionTruck") == 1)  {
                MissionProduct_Update(playerid, pLoadProduct[playerid], true);
            } 
            FactoryData[factoryID][WareHouse][index] += FactoryData[factoryID][Productivity][index];
            if(FactoryData[factoryID][WareHouse][index] > FactoryData[factoryID][MaxWareHouse][index])
                FactoryData[factoryID][WareHouse][index] = FactoryData[factoryID][MaxWareHouse][index];
            new moneyzxc[30];
            format(str, sizeof(str), "Ban da ban san pham %s thanh cong.", ProductData[pLoadProduct[playerid]][ProductName]);
            format(moneyzxc, 30, "%d$", FactoryData[factoryID][ProductPrice][index]);
            SendLogToDiscordRoom("LOG BÁN THÙNG HÀNG", "1157969051264503838", "Name", GetPlayerNameEx(playerid), "Đã bán", ProductData[pLoadProduct[playerid]][ProductName], "Giá tiền", moneyzxc, 0x229926);
            SendClientMessageEx(playerid, COLOR_1YELLOW, str);
        }
        RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
        pLoadProduct[playerid] = -1;
        if(GetPVarInt(playerid, "MaxMissionTruck") <= 0 && GetPVarInt(playerid, "MissionTruck") == 1) {
            ClearTrucker(playerid);
        }
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
        for(new i; i < MAX_PLAYERPRODUCT; i++)
        {
            if(PlayerTruckerData[playerid][ClaimProduct][i] == ProductId)
            {
                PlayerTruckerData[playerid][ClaimProduct][i]  = -1;
                break;
            }
        }
        VEHICLETRUCKER_DELETE(playerid, index);
        switch(ProductData[ProductId][ProductUnitID])
        {
            case 0, 6:
            {
                SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
            }
        }
        new string[MAX_PLAYER_NAME + 44];
        format(string, sizeof(string), "* %s da lay thung hang %s tren xe xuong.", GetPlayerNameEx(playerid), ProductData[ProductId][ProductName]);
        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    return 1;
}
