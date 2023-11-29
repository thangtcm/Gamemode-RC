
CMD:thongtinnhamay(playerid, params[])
{
    FactoryInformation(playerid);
    return 1;
}

CMD:cuophang(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 20 || PlayerInfo[playerid][pJob2] == 20)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            foreach(new i: Player)
            {
                new v = GetPlayerVehicle(i, vehicleid);
                if(v != -1)
                {
                    if(!PlayerVehicleInfo[i][v][pvIsRegisterTrucker]) return 1;
                    if(GetPVarInt(playerid, "LoadTruckTime") > 0)
                    {
                        SendServerMessage(playerid, " Ban dang trong qua trinh cuop hang hoa tren xe nay!");
                        return 1;
                    }
                    TogglePlayerControllable(playerid, 0);
                    SetPVarInt(playerid, "IsFrozen", 1);
                    SetPVarInt(playerid, "LoadTruckTime", 10);
                    SetTimerEx("HijackTruck", 1000, 0, "ddd", playerid, i, v);
                }
            }
        }
	    else return SendErrorMessage(playerid, " Ban dang khong o tren bat ki xe nao!");
	}
	else return SendErrorMessage(playerid, " Ban khong phai la nguoi van chuyen hang hoa");
    return 1;
}

CMD:goiynhamay(playerid, params[])
{
    if(GetPVarInt(playerid, "MissionTruck") == 0)   return SendErrorMessage(playerid, "Chuc nang nay chi ap dung cho lam nhiem vu trucker.");
    FactorySuggest(playerid);
    return 1;
}

CMD:goiygiaohang(playerid, params[])
{
    new numFoundFactories = 0,
        MaxFactiory = sizeof(FactoryData);

    new d = PlayerInfo[playerid][pRegisterCarTruck];
    
    for (new i = 0; i < MaxFactiory; i++) {
        for (new j = 0; j < MAX_PRODUCT; j++) {
            if(FactoryData[i][ProductImportName][j] != -1)
            {
                for(new index = 0; index < MAX_OBJECTTRUCKER; index++)
                {
                    if(VehicleTruckerData[playerid][index][vtId] != -1 && VehicleTruckerData[playerid][index][vtSlotId] == PlayerVehicleInfo[playerid][d][pvSlotId]
                        && VehicleTruckerData[playerid][index][vtProductID] == FactoryData[i][ProductImportName][j]){
                        PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                        j = MAX_PRODUCT;
                        break;
                    }
                }
            }
            else break;
        }
    }
    new str[1200], zone[MAX_ZONE_NAME],Float:Distance;
    format(str, sizeof(str), "Ten Nha May\t\tVi Tri\t\tKhoang cach");
    for(new i; i < numFoundFactories;i++)
    {
        Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2]);
        Get3DZone(FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2], zone, sizeof(zone));
        format(str, sizeof(str), "%s\n%s\t\t%s\t\t%0.2f Met", str, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryName], zone, Distance);
    }
    Dialog_Show(playerid, DIALOG_LISTFACTORY, DIALOG_STYLE_TABLIST_HEADERS, "Cong viec Trucker", str, "Lua chon", "Huy bo");
    return 1;
}

CMD:truckergo(playerid, params[])
{
    new type[24];
    if(sscanf(params, "s[24]", type))
	{
		SendServerMessage(playerid, "/truckergo [name]");
		SendServerMessage(playerid, "Lua chon: car, mission, buy, sell, suggest, ship, rob");
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
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 2431.9810,-2118.9050,13.5469))
        {
            if(!IsValidCarTrucker(playerid)) return SendErrorMessage(playerid, "Ban can phai lai chiec xe duoc phep van chuyen de dang ky!!");
            new vehicleid = GetPlayerVehicleID(playerid);
            Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}Ban da hoan thanh viec dang ky xe %s cho viec van chuyen hang hoa. \n\nNeu ban can lam nhiem vu tu {FF0000}Ong Chu{FFFFFF} dua ra.\n\nDe bat dau cong viec, ban hay den gap {FF0000}Ong Chu{FFFFFF} de nhan thong tin lam viec (/truckergo mission).", "Dong lai", "", GetVehicleName(vehicleid));
        }
        else 
        { 
            SetPlayerCheckPointEx(playerid,  2431.9810,-2118.9050,13.5469, 5);
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
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 58.5952,-292.2914,1.5781))
        {
            Dialog_Show(playerid, DIALOG_STARTTRUCKER, DIALOG_STYLE_LIST, "Cong viec Trucker", "Nhan nhiem vu\nXem Huong Dan", "Lua chon", "Huy bo");
       }
    }
    else if(!strcmp(type, "buy", true))
	{
        if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
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
                    for(new j; j < MAX_PRODUCT; j++)
                    {
                        if(FactoryData[FactoryId][ProductName][j] == -1) break;
                        if(FactoryData[FactoryId][ProductName][j] == PlayerTruckerData[playerid][MissionProduct][i])
                        {
                            PlayerTruckerData[playerid][MissionBuy][BuyProductLenght++] =  j;
                            ProductId = FactoryData[FactoryId][ProductName][j];
                            format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][j]);
                            break;
                       }
                    }
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac San Pham", string, "Xac nhan", "<");
            }
            else
            {
                for(new i; i < MAX_PRODUCT; i++)
                {
                    if(FactoryData[FactoryId][ProductName][i] == -1) break;
                    PlayerTruckerData[playerid][MissionBuy][BuyProductLenght++] =  i;
                    ProductId = FactoryData[FactoryId][ProductName][i];
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac San Pham", string, "Xac nhan", "<");
            }
        }
    }
    else if(!strcmp(type, "sell", true))
	{
        if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
        if(FactoryId != -1)
        {
            SetPVarInt(playerid, "Sell_ProductID", FactoryId);
            format(string, sizeof(string), "{FFFFFF}ID\t\tSan Pham\t\tGia");
            new count=0;
            PlayerTruckerData[playerid][MAXPRODUCT] = 0;
            PlayerTruckerData[playerid][MAXPRODUCTIMPORT] = 0;
            if(PlayerTruckerData[playerid][ClaimFactoryID] == FactoryId)
            {
                for(new i; i < MAX_PRODUCT; i++)
                {
                    if(FactoryData[FactoryId][ProductName][i] == -1)
                        break;
                    ProductId = FactoryData[FactoryId][ProductName][i];
                    PlayerTruckerData[playerid][SellProduct][count++] = i;
                    PlayerTruckerData[playerid][MAXPRODUCT]++;
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
                }
            }
            
            for(new i; i < MAX_PRODUCT; i++)
            {
                if(FactoryData[FactoryId][ProductImportName][i] == -1) break;
                ProductId = FactoryData[FactoryId][ProductImportName][i];
                PlayerTruckerData[playerid][SellProduct][count++] = i;
                PlayerTruckerData[playerid][MAXPRODUCTIMPORT]++;
                format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductImportPrice][i]);
            }
            Dialog_Show(playerid, DIALOG_SELLPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac San Pham", string, "Xac nhan", "<");
        }
    }
    else if(!strcmp(type, "suggest", true))
	{
        return cmd_goiynhamay(playerid, "\1");
    }
    else if(!strcmp(type, "ship", true))
	{
        return cmd_goiygiaohang(playerid, "\1");
    }
    else if(!strcmp(type, "rob", true))
	{
        return cmd_cuophang(playerid, "\1");
    }
    return 1;
}
stock RandomName()
{
    new name[MAX_PLAYER_NAME];
    for (new i = 0; i < 14; i++)
    {
        if(i == 7)
        {
            name[i] = '_'; 
        }
        else
        {
            if(random(2))
            {
                name[i] = random(26) + 'A'; 
            }
            else
            {
                name[i] = random(26) + 'a'; 
            }
        }
    }
    name[14] = '\0';
    return name;
}

CMD:setnameinquery(playerid, params[])
{
    new str[24];
    format(str, sizeof(str), "Mask_%d_%d\0", PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1]);
	SendClientMessageEx(playerid, COLOR_YELLOW, str);
    new name[MAX_PLAYER_NAME];
    strcat(name, str, MAX_PLAYER_NAME);
    printf("name %s", name);
    if(SetPlayerName(playerid, name) == 1)
    {
        printf("RUN");
    }
    else
    {
        printf("NO");
    }
	return 1;
}