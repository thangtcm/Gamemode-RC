hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        new vehicleid = PlayerInfo[playerid][pRegisterCarTruck];
        if(IsPlayerNearCar(playerid, vehicleid))
        {
            if(GetPVarInt(playerid, "CarryProductToCar") == 1)
            {
                new CarTruckID = GetCarTruckID(PlayerInfo[playerid][pRegisterCarTruck]);
                
                if(SaveWeigth[playerid]++ >= CarTruckWorking[CarTruckID][Weight] )
                {
                    SendServerMessage(playerid, "Ban da chat tat ca thung hang len xe.");
                    SetPVarInt(playerid, "MaxSlotProductTruck", 1);
                }
                if(!AttachProductToVehicle(playerid)) return SendErrorMessage(playerid, "Xe cho hang cua ban khong con slot de chat hang.");
                SendServerMessage(playerid, "Ban da chat thung hang len xe.");
                RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
                DeletePVar(playerid, "CarryProductToCar");
            }
            else{
                SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1271, 5, 0.137832, 0.176979, 0.151424, 96.305931, 185.363006, 20.328088, 0.699999, 0.800000, 0.699999);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
                for(new i; i < MAX_PLAYERPRODUCT; i++)
                {
                    if(PlayerTruckerData[playerid][ClaimProduct][i] != -1)
                    {
                        PlayerTruckerData[playerid][MissionProduct][i] = PlayerTruckerData[playerid][ClaimProduct][i];
                        PlayerTruckerData[playerid][ClaimProduct][i] = -1;
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