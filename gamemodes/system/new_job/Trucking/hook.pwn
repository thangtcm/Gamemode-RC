hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        if(GetPVarInt(playerid, "CarryProductToCar") == 1)
        {
            SendServerMessage(playerid, "Ban da chat thung hang len xe.");
            RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
            if(TestTruck[playerid][0] != -1)    TestTruck[playerid][0] = PlayerTruckerData[playerid][ClaimProduct][0];
            else if(TestTruck[playerid][1] != -1){
                SendServerMessage(playerid, "Ban da chat hang len xe xong");
                TestTruck[playerid][1] = PlayerTruckerData[playerid][ClaimProduct][1];
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