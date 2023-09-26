hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        new carid = GetPlayerVehicleID(playerid);
        new closestcar = GetClosestCar(playerid,carid);
        if(pLoadProduct[playerid] != -1)
        {
            foreach(new i: Player)
            {
                new v = GetPlayerVehicle(i, closestcar);
                if(v != -1)
                {
                    if(PlayerVehicleInfo[i][v][pvIsRegisterTrucker])    return SendErrorMessage(playerid, "Hien tai xe nay chua duoc dang ky lam xe van chuyen.");
                    new MaxSlot = VehicleTruckerCount(playerid, PlayerVehicleInfo[i][v][pvSlotId]);
                    if (MaxSlot == PlayerVehicleInfo[i][v][pvMaxSlotTrucker])
                    {
                        SendClientMessageEx(playerid, COLOR_WHITE,  "Chiec xe nay da bi gioi han hang hoa tren xe.");
                        return 1;
                    }
                    else
                    {
                        AttachProductToVehicle(playerid, closestcar, PlayerVehicleInfo[i][v][pvSlotId]);
                        SendServerMessage(playerid, "Ban da chat thung hang len xe.");
                        RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                        ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
                        new string[MAX_PLAYER_NAME + 44];
                        format(string, sizeof(string), "* %s da dua thung hang len xe.", GetPlayerNameEx(playerid));
                        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        return 1;
                    }
                }
            }
        }
        else{
            foreach(new i: Player)
            {
                new v = GetPlayerVehicle(i, closestcar);
                if(v != -1)
                {
                    if(PlayerVehicleInfo[i][v][pvIsRegisterTrucker])    return SendErrorMessage(playerid, "Hien tai xe nay chua duoc dang ky lam xe van chuyen.");
                    new MaxSlot = VehicleTruckerCount(playerid, PlayerVehicleInfo[i][v][pvSlotId]);
                    if (MaxSlot == 0)
                    {
                        return 1;
                    }
                    else
                    {
                        SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                        ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
                        new string[MAX_PLAYER_NAME + 44];
                        format(string, sizeof(string), "* %s da lay thung hang tren xe xuong.", GetPlayerNameEx(playerid));
                        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        return 1;
                    }
                }
            }
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    ClearTrucker(playerid);
    return 1;
}