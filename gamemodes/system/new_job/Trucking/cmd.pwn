CMD:registercartruck(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(PlayerInfo[playerid][pJob] != 20) return SendErrorMessage(playerid, "Ban khong phai la Trucker!!");
    if(!IsPlayerInAnyVehicle(playerid) || IsValidCarTruck(vehicleid)) return SendErrorMessage(playerid, "Ban can phai lai chiec xe van chuyen de dang ky!!");
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 90.3602,-303.6159,1.5823))
    {
        PlayerInfo[playerid][pRegisterCarTruck] = vehicleid;
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}Ban da hoan thanh viec dang ky xe %s cho viec van chuyen hang hoa. \n\nNeu ban can lam nhiem vu tu {FF0000}Ong Chu{FFFFFF} dua ra.\n\nDe bat dau cong viec, ban hay den gap {FF0000}Ong Chu{FFFFFF} de nhan thong tin lam viec (/truckergo mission).", "Dong lai", "", GetVehicleName(vehicleid));
    }
    else 
    { 
        SetPlayerCheckpoint(playerid,  90.3602, -303.6159, 1.5823, 7.0);
        return SendErrorMessage(playerid, "Ban can den vi tri tren cham do de dang ky xe van chuyen hang hoa.");
    }
    return 1;
}

CMD:layhang(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != 20) return SendErrorMessage(playerid, "Ban khong phai la Trucker!!");
    if(PlayerInfo[playerid][pRegisterCarTruck] == 0) return SendErrorMessage(playerid, "Ban chua dang ky xe van chuyen hang hoa !!");
    if(JobTime[pLockTrucker] == 1)
    {
        SendErrorMessage(playerid, " Cong viec nay da bi khoa");
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 58.5952,-292.2914,1.5781))
    {
        // TogglePlayerControllable(playerid, 0);
        // SetPlayerFacingAngle(playerid, 88.0);
        // InterpolateCameraPos(playerid, 54.1970,-183.9300,22.3937, 58.6004,-291.1005,1.5781, 10000, CAMERA_MOVE);
        // InterpolateCameraLookAt(playerid, 54.1970,-183.9300,22.3937, 58.6004,-291.1005,3.5781, 5000, CAMERA_MOVE);
        // SetTimerEx("ToggleCameraMove", 10000, false, "d", playerid);
        Dialog_Show(playerid, DIALOG_STARTTRUCKER, DIALOG_STYLE_LIST, "Cong viec Trucker", "Nhan nhiem vu\nXem Huong Dan", "Lua chon", "Huy bo");
    }
    return 1;
}

CMD:thongtinnhamay(playerid, params[])
{
    Dialog_Show(playerid, DIALOG_STARTFACTORY, DIALOG_STYLE_LIST, "Status Factory", "Nha may xuat khau\nNha may nhap khau", "Lua chon", "<");
    return 1;
}

CMD:goiynhamay(playerid, params[])
{
    if(GetPVarInt(playerid, "MissionTruck") == 0)   return 1;
    Dialog_Show(playerid, DIALOG_STARTFACTORY2, DIALOG_STYLE_LIST, "Status Factory", "Nha may xuat khau\nNha may nhap khau", "Lua chon", "<");
    return 1;
}

CMD:truckergo(playerid, params[])
{
    new type[24];
    if(sscanf(params, "s[24]", type))
	{
		SendServerMessage(playerid, "/truckergo [name]");
		SendServerMessage(playerid, "Lua chon: mission, buy, sell, place.");
		return 1;
	}
    if(PlayerInfo[playerid][pJob] != 20) return SendErrorMessage(playerid, "Ban khong phai la Trucker!!");
    if(PlayerInfo[playerid][pRegisterCarTruck] == 0) return SendErrorMessage(playerid, "Ban chua dang ky xe van chuyen hang hoa !!");
    if(JobTime[pLockTrucker] == 1)
    {
        SendErrorMessage(playerid, " Cong viec nay da bi khoa");
        return 1;
    }
    new FactoryId = IsPlayerInFactory(playerid);
    new string[560], ProductId;
    if(!strcmp(type, "mission", true))
	{
        // if(GetPVarInt(playerid, "MissionTruck") == 1)
        // {
        //     ShowMissionTrucker(playerid);
        //     return SendErrorMessage(playerid, "Ban da nhan nhiem vu giao hang trucker, hay xem lai thong tin.");
        // } 
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 58.5952,-292.2914,1.5781))
        {
            Dialog_Show(playerid, DIALOG_STARTTRUCKER, DIALOG_STYLE_LIST, "Cong viec Trucker", "Nhan nhiem vu\nXem Huong Dan", "Lua chon", "Huy bo");
        }
    }
    else if(!strcmp(type, "buy", true))
	{
        if(FactoryId != -1)
        {
            SetPVarInt(playerid, "BUY_FactoryID", FactoryId);
            format(string, sizeof(string), "{FFFFFF}ID\t\tSan Pham\t\tGia");
            if(GetPVarInt(playerid, "MissionTruck") == 1)
            {
                new BuyProductLenght = 0; 
                for(new i; i < strlen(PlayerTruckerData[playerid][MissionProduct]); i++)
                {
                    for(new j; j < strlen(FactoryData[FactoryId][ProductName]); i++)
                    {
                        if(FactoryData[FactoryId][ProductName][j] == PlayerTruckerData[playerid][MissionProduct][i])
                        {
                            PlayerTruckerData[playerid][MissionBuy][BuyProductLenght++] =  j;
                            ProductId = FactoryData[FactoryId][ProductName][i];
                            format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
                            break;
                        }
                    }
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
            }
            else
            {
                for(new i; i < strlen(FactoryData[FactoryId][ProductName]); i++)
                {
                    ProductId = FactoryData[FactoryId][ProductName][i];
                    format(string, sizeof(string),"%s\n%d\t\t%s\t\t$%d",string, i, ProductData[ProductId][ProductName], FactoryData[FactoryId][ProductPrice][i]);
                }
                Dialog_Show(playerid, DIALOG_BUYPRODUCT,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
            }
        }
    }
    return 1;
}