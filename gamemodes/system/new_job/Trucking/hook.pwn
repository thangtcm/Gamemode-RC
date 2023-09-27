hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        new carid = GetPlayerVehicleID(playerid);
        new closestcar = GetClosestCar(playerid,carid);
        if(!IsPlayerInRangeOfVehicle(playerid, closestcar, 9.0))
            return 1;
        if(pLoadProduct[playerid] != -1)
        {
            foreach(new i: Player)
            {
                new v = GetPlayerVehicle(i, closestcar);
                if(v != -1)
                {
                    if(!PlayerVehicleInfo[i][v][pvIsRegisterTrucker])    return SendErrorMessage(playerid, "Hien tai xe nay chua duoc dang ky lam xe van chuyen.");
                    new MaxSlot = VehicleTruckerCount(playerid, PlayerVehicleInfo[i][v][pvSlotId]);
                    if (MaxSlot + 1 > PlayerVehicleInfo[i][v][pvMaxSlotTrucker])
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
                    new MaxSlot = VehicleTruckerCount(playerid, PlayerVehicleInfo[i][v][pvSlotId]);
                    if (MaxSlot == 0 || PlayerVehicleInfo[i][v][pvIsRegisterTrucker] == -1)
                        return 1;
                    else
                    {
                        
                        new str[1000];
                        format(str, sizeof(str), "ID\t\tSan Pham");
                        new count=0;
                        for(new index; index < MAX_OBJECTTRUCKER; index++)
                        {
                            if(VehicleTruckerData[i][index][vtId] != -1 && VehicleTruckerData[i][index][vtSlotId] == PlayerVehicleInfo[i][v][pvSlotId]
                                && VehicleTruckerData[i][index][vtProductID] != -1){
                                PlayerTruckerData[playerid][ClaimFromCar][count++] = index;
                                format(str, sizeof(str), "%s\n%d\t\t%s", str, index, ProductData[VehicleTruckerData[i][index][vtProductID]][ProductName]);
                            }
                        }
                        Dialog_Show(playerid, DIALOG_CARCLAIMPRODUCT, DIALOG_STYLE_TABLIST_HEADERS, "San Pham Trong Xe", str, "Lay", "<");
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