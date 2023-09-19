CMD:registercartruck(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(PlayerInfo[playerid][pJob] != 20) return SendErrorMessage(playerid, "Ban khong phai la Trucker!!");
    if(!IsPlayerInAnyVehicle(playerid) || IsValidCarTruck(vehicleid)) return SendErrorMessage(playerid, "Ban can phai lai chiec xe van chuyen de dang ky!!");
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 90.3602,-303.6159,1.5823))
    {
        PlayerInfo[playerid][pRegisterCarTruck] = vehicleid;
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}Ban da hoan thanh viec dang ky xe %s cho viec van chuyen hang hoa. \n\nBan can phai lam theo yeu cau cua {FF0000}Ong Chu{FFFFFF} dua ra.\n\nDe bat dau cong viec, ban hay den gap {FF0000}Ong Chu{FFFFFF} de nhan thong tin lam viec.", "Dong lai", "", GetVehicleName(vehicleid));
    }
    else    return SendErrorMessage(playerid, "Ban can den vi tri dang ky xe van chuyen");
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
        TogglePlayerControllable(playerid, 0);
        SetPlayerFacingAngle(playerid, 88.0);
        InterpolateCameraPos(playerid, 54.1970,-183.9300,22.3937, 58.6004,-291.1005,1.5781, 10000, CAMERA_MOVE);
        InterpolateCameraLookAt(playerid, 54.1970,-183.9300,22.3937, 58.6004,-291.1005,3.5781, 5000, CAMERA_MOVE);
        SetTimerEx("ToggleCameraMove", 10000, false, "d", playerid);
    }
    return 1;
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
        format(string, sizeof(string),"%s\n%d\t\t%s\t\t%s\t\t%0.f Met",string, i, FactoryData[i][FactoryName], zone, Distance);
    }
    Dialog_Show(playerid, DIALOG_LISTFACTORY ,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
    return 1;
}