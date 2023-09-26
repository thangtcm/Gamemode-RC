CMD:factorystatus(playerid, params[])
{
    return cmd_thongtinnhamay(playerid, params);
}

CMD:thongtinnhamay(playerid, params[])
{
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
    return 1;
}

CMD:goiynhamay(playerid, params[])
{
    if(GetPVarInt(playerid, "MissionTruck") == 0)   return 1;
    new numFoundFactories = 0,
        MaxFactiory = sizeof(FactoryData),
        checkMax, MaxExport, MaxImport, bool:IsCheck;
    for (new i = 0; i < MaxFactiory; i++) {
        MaxExport = strlen(FactoryData[i][ProductName]),
        MaxImport = strlen(FactoryData[i][ProductImportName]);
        if(MaxExport > MaxImport)   checkMax = MaxExport;
        else    checkMax = MaxImport;
        for (new j = 0; j < checkMax; j++) {
            IsCheck = false;
            if(j < MaxExport)
            {
                if(IsProductValid(playerid, FactoryData[i][ProductName][j])) {
                    PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                    IsCheck = true;
                    break;
                }
            }
            if(j < MaxImport && IsCheck == false)
            {
                if(IsProductValid(playerid, FactoryData[i][ProductImportName][j])) {
                    PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                    break;
                }
            }
        }
    }
    new str[1200], zone[MAX_ZONE_NAME],Float:Distance;
    format(str, sizeof(str), "Ten Nha May\t\tVi Tri\t\tMet");
    for(new i; i < numFoundFactories;i++)
    {
        Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2]);
        Get3DZone(FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2], zone, sizeof(zone));
        format(str, sizeof(str), "%s\n%s\t\t%s\t\t%0.2f Met", str, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryName], zone, Distance);
    }
    Dialog_Show(playerid, DIALOG_SUGGESTFACTORY, DIALOG_STYLE_TABLIST_HEADERS, "Cong viec Trucker", str, "Lua chon", "Huy bo");
    return 1;
}

CMD:truckergo(playerid, params[])
{
    new type[24];
    if(sscanf(params, "s[24]", type))
	{
		SendServerMessage(playerid, "/truckergo [name]");
		SendServerMessage(playerid, "Lua chon: car, mission, buy, sell.");
		return 1;
	}
    if(PlayerInfo[playerid][pJob] != 20) return SendErrorMessage(playerid, "Ban khong phai la Trucker!!");
    if(JobTime[pLockTrucker] == 1)
    {
        SendErrorMessage(playerid, " Cong viec nay da bi khoa");
        return 1;
    }
    new FactoryId = IsPlayerInFactory(playerid);
    new string[560], ProductId;
    if(!strcmp(type, "car", true))
    {
        new playerCar = IsValidCarTrucker(playerid);
        if(!IsPlayerInAnyVehicle(playerid) || playerCar == -1) return SendErrorMessage(playerid, "Ban can phai lai chiec xe van chuyen de dang ky!!");
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 90.3602,-303.6159,1.5823))
        {
            PlayerVehicleInfo[playerid][playerCar][pvIsRegisterTrucker] = playerCar;
            Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}Ban da hoan thanh viec dang ky xe %s cho viec van chuyen hang hoa. \n\nNeu ban can lam nhiem vu tu {FF0000}Ong Chu{FFFFFF} dua ra.\n\nDe bat dau cong viec, ban hay den gap {FF0000}Ong Chu{FFFFFF} de nhan thong tin lam viec (/truckergo mission).", "Dong lai", "", GetVehicleName(PlayerVehicleInfo[playerid][playerCar][pvId]));
        }
        else 
        { 
            SetPlayerCheckpoint(playerid,  90.3602, -303.6159, 1.5823, 7.0);
            return SendErrorMessage(playerid, "Ban can den vi tri tren cham do de dang ky xe van chuyen hang hoa.");
        }
    }
    else if(!strcmp(type, "mission", true))
	{
        if(GetPVarInt(playerid, "MissionTruck") == 1)
        {
            ShowMissionTrucker(playerid);
            return SendErrorMessage(playerid, "Ban da nhan nhiem vu giao hang trucker, hay xem lai thong tin.");
        } 
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 58.5952,-292.2914,1.5781))
        {
            Dialog_Show(playerid, DIALOG_STARTTRUCKER, DIALOG_STYLE_LIST, "Cong viec Trucker", "Nhan nhiem vu\nXem Huong Dan", "Lua chon", "Huy bo");
       }
    }
    else if(!strcmp(type, "buy", true))
	{
        if(pLoadProduct[playerid] != -1) return SendErrorMessage(playerid, "Ban dang cam mot thung hang roi, hay dua len xe roi hay mua tiep.");
        if(FactoryId != -1)
        {
            new BuyProductLenght = 0; 
            SetPVarInt(playerid, "BUY_FactoryID", FactoryId);
            format(string, sizeof(string), "{FFFFFF}ID\t\tSan Pham\t\tGia");
            if(GetPVarInt(playerid, "MissionTruck") == 1)
            {
                for(new i; i < MAX_PLAYERPRODUCT; i++)
                {
                    if(PlayerTruckerData[playerid][MissionProduct][i] == -1) continue;
                    new MaxProductName = strlen(FactoryData[FactoryId][ProductName]);
                    for(new j; j < MaxProductName; j++)
                    {
                        if(FactoryData[FactoryId][ProductName][j] == PlayerTruckerData[playerid][MissionProduct][i])
                        {
                            PlayerTruckerData[playerid][MissionBuy][BuyProductLenght++] =  j;
                            ProductId = FactoryData[FactoryId][ProductName][j];
                            format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][j]);
                       }
                    }
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac San Pham", string, "Xac nhan", "<");
            }
            else
            {
                for(new i; i < strlen(FactoryData[FactoryId][ProductName]); i++)
                {
                    PlayerTruckerData[playerid][MissionBuy][BuyProductLenght++] =  i;
                    ProductId = FactoryData[FactoryId][ProductName][i];
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
            }
        }
    }
    else if(!strcmp(type, "sell", true))
	{
        if(FactoryId != -1)
        {
            SetPVarInt(playerid, "Sell_ProductID", FactoryId);
            format(string, sizeof(string), "{FFFFFF}ID\t\tSan Pham\t\tGia");
        
            for(new i; i < strlen(FactoryData[FactoryId][ProductName]); i++)
            {
                ProductId = FactoryData[FactoryId][ProductName][i];
                format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
            }
            for(new i; i < strlen(FactoryData[FactoryId][ProductImportName]); i++)
            {
                ProductId = FactoryData[FactoryId][ProductImportName][i];
                format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductImportPrice][i]);
            }
            Dialog_Show(playerid, DIALOG_SELLPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac San Pham", string, "Xac nhan", "<");
        }
    }
    return 1;
}