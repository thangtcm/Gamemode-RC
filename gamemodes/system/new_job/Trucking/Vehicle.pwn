////Out Car Player      OnVehicleSpawn
stock IsHasCarTrucker(playerid)
{
    for(new i=0; i<MAX_PLAYERVEHICLES; i++)
        if(PlayerVehicleInfo[playerid][i][pvId] != INVALID_PLAYER_VEHICLE_ID && PlayerVehicleInfo[playerid][i][pvIsRegisterTrucker] == 1)
            return 1;
    return -1;
}

stock IsValidCarTrucker(playerid)
{
    new maxCarTruckWorking;
    for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
	{
		if(IsPlayerInVehicle(playerid, PlayerVehicleInfo[playerid][d][pvId]))
		{
            maxCarTruckWorking = sizeof(CarTruckWorking);
            for(new i; i < maxCarTruckWorking; i++)
            {
                if(CarTruckWorking[i][CarModel] == PlayerVehicleInfo[playerid][d][pvModelId]){
                    PlayerVehicleInfo[playerid][d][pvIsRegisterTrucker] = true;
                    PlayerVehicleInfo[playerid][d][pvMaxSlotTrucker] = CarTruckWorking[i][Weight];
                    PlayerInfo[playerid][pRegisterCarTruck] = d;
                    g_mysql_SaveVehicle(playerid, d);
                    return true;
                }
            }
		}
	}
    return false;
}

stock GetPlayerCarID(playerid, PlayerVehicleID) //SQL ID
{
    for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
        if(PlayerVehicleInfo[playerid][d][pvSlotId] == PlayerVehicleID)
            return d;
    return -1;
}

stock LoadVehicleTrucker(playerid)
{
	new string[2085];
	new GetPlayerId = GetPlayerSQLId(playerid);
	format(string, sizeof(string), "SELECT * FROM vehicletrucker WHERE vtPSQL = '%d'", GetPlayerId);
	mysql_function_query(MainPipeline, string, true, "VEHICLETRUCKER_LOAD", "i", playerid);
	printf("[VEHICLE TRUCKER LOAD] Loading data from database...");
}

public VEHICLETRUCKER_LOAD(playerid)
{
    for(new j; j < MAX_OBJECTTRUCKER; j++)
    {
        VehicleTruckerData[playerid][j][vtId] = -1;
        VehicleTruckerData[playerid][j][vtObject] = INVALID_OBJECT_ID;
        VehicleTruckerData[playerid][j][vtProductID] = -1;
        VehicleTruckerData[playerid][j][vtFactoryID] = -1;
    }
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);
	while(i < rows)
	{
		cache_get_field_content(i, "vtId", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtId] = strval(tmp);
		cache_get_field_content(i, "vtSlotId", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtSlotId] = strval(tmp);
		cache_get_field_content(i, "vtProductID", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtProductID] = strval(tmp);
		cache_get_field_content(i, "vtFactoryID", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtFactoryID] = strval(tmp);
        cache_get_field_content(i, "vtPos1", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][0] = floatstr(tmp);
        cache_get_field_content(i, "vtPos2", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][1] = floatstr(tmp);
        cache_get_field_content(i, "vtPos3", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][2] = floatstr(tmp);
        cache_get_field_content(i, "vtPos4", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][3] = floatstr(tmp);
        cache_get_field_content(i, "vtPos5", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][4] = floatstr(tmp);
        cache_get_field_content(i, "vtPos6", tmp, MainPipeline); VehicleTruckerData[playerid][i][vtPos][5] = floatstr(tmp);

  		i++;
 	}
	if(i > 0) printf("[Load Vehicle Trucker] %d du lieu product trong xe cua %s da duoc tai.", i, GetPlayerNameEx(playerid));
	else printf("[Load Vehicle Trucker] Khong co du lieu de tai");
}

stock VEHICLETRUCKER_UPDATE(playerid, index)
{
	new string[2048],
        GetPlayerId = GetPlayerSQLId(playerid);
        format(string, sizeof(string), "UPDATE `vehicletrucker` SET \
        `vtSlotId`=%d, \
        `vtProductID`='%d', \
        `vtFactoryID`='%d', \
        WHERE `vtId`=%d AND `vtPSQL`=%d",
        VehicleTruckerData[playerid][index][vtSlotId],
        VehicleTruckerData[playerid][index][vtProductID],
        VehicleTruckerData[playerid][index][vtFactoryID],
        VehicleTruckerData[playerid][index][vtId],
        GetPlayerId
    );
    mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    return 1;
}

stock VEHICLETRUCKER_ADD(playerid, vehicleid, modelid, pCarSlotID, ProductID, Float:x, Float:y, Float:z, Float:ox, Float:oy, Float:oz)
{
	new string[2048],
        GetPlayerId = GetPlayerSQLId(playerid),
        index = GetVehicleTruckerFree(playerid);
    if(index == -1) return SendErrorMessage(playerid, "Xe cua ban da chat day hang, khong the chat them hang hoa len xe.");
    new Float:playerPos[3];
    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
    if(IsValidDynamicObject(VehicleTruckerData[playerid][index][vtObject]))
        DestroyDynamicObject(VehicleTruckerData[playerid][index][vtObject]);
    VehicleTruckerData[playerid][index][vtObject] = CreateDynamicObject(modelid, playerPos[0], playerPos[1], playerPos[2], 0, 0, 0);
    AttachDynamicObjectToVehicle(VehicleTruckerData[playerid][index][vtObject], vehicleid, x, y, z, ox, oy, oz);
    VehicleTruckerData[playerid][index][vtSlotId] = pCarSlotID,
    VehicleTruckerData[playerid][index][vtProductID] = ProductID,
    VehicleTruckerData[playerid][index][vtPos][0] = x,
    VehicleTruckerData[playerid][index][vtPos][1] = y,
    VehicleTruckerData[playerid][index][vtPos][2] = z,
    VehicleTruckerData[playerid][index][vtPos][3] = ox,
    VehicleTruckerData[playerid][index][vtPos][4] = oy,
    VehicleTruckerData[playerid][index][vtPos][5] = oz,
    VehicleTruckerData[playerid][index][vtFactoryID] = PlayerTruckerData[playerid][ClaimFactoryID];

    format(string, sizeof(string), "INSERT INTO `vehicletrucker` (`vtSlotId`, `vtProductID`, `vtPSQL`,`vtPos1`,`vtPos2`,`vtPos3`,`vtPos4`,`vtPos5`,`vtPos6`, `vtFactoryID`)\
		VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%d')",  pCarSlotID, ProductID, GetPlayerId, x, y, z, ox, oy, oz, VehicleTruckerData[playerid][index][vtFactoryID]);
	mysql_function_query(MainPipeline, string, false, "OnAddVehicleTruckerFinish", "ii", playerid, index);
    printf("Nguoi choi %s da dua san pham %s vao xe %s ", GetPlayerNameEx(playerid), ProductData[ProductID][ProductName], GetVehicleName(vehicleid));
	return 1;
}

public OnAddVehicleTruckerFinish(playerid, index)
{
    VehicleTruckerData[playerid][index][vtId] = mysql_insert_id(MainPipeline);
    return 1;
}

stock VehicleTrucker_Reload(playerid, pVehicleIndex, isAdd = false)
{
    if(PlayerInfo[playerid][pRegisterCarTruck] != pVehicleIndex)    return 1;
    for(new i; i < MAX_OBJECTTRUCKER; i++)
    {
        if(isAdd)
        {
            if(VehicleTruckerData[playerid][i][vtId] != -1 && VehicleTruckerData[playerid][i][vtSlotId] == PlayerVehicleInfo[playerid][pVehicleIndex][pvSlotId])
            {
                if(IsValidDynamicObject(VehicleTruckerData[playerid][i][vtObject]))
                {
                    DestroyDynamicObject(VehicleTruckerData[playerid][i][vtObject]);
                }
                VehicleTruckerData[playerid][i][vtObject] = CreateDynamicObject(1271, 
                    VehicleTruckerData[playerid][i][vtPos][0], VehicleTruckerData[playerid][i][vtPos][1], VehicleTruckerData[playerid][i][vtPos][2], 
                    0, 0, 0);
                AttachDynamicObjectToVehicle(VehicleTruckerData[playerid][i][vtObject], PlayerVehicleInfo[playerid][pVehicleIndex][pvId], 
                    VehicleTruckerData[playerid][i][vtPos][0], VehicleTruckerData[playerid][i][vtPos][1], VehicleTruckerData[playerid][i][vtPos][2], 
                    VehicleTruckerData[playerid][i][vtPos][3], VehicleTruckerData[playerid][i][vtPos][4], VehicleTruckerData[playerid][i][vtPos][5]);
            }
        }
        else
        {
            if(VehicleTruckerData[playerid][i][vtSlotId] == PlayerVehicleInfo[playerid][pVehicleIndex][pvSlotId] && VehicleTruckerData[playerid][i][vtId] != -1)
            {
                if(IsValidDynamicObject(VehicleTruckerData[playerid][i][vtObject]))
                {
                    DestroyDynamicObject(VehicleTruckerData[playerid][i][vtObject]);
                }
            }
        }
    }
    return 1;
}

stock VEHICLETRUCKER_DELETE(playerid, index)
{
    new
        string[64];
    format(string, sizeof(string), "DELETE FROM `vehicletrucker` WHERE `vtId`= '%d'", VehicleTruckerData[playerid][index][vtId]);
    mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);

    if(IsValidDynamicObject(VehicleTruckerData[playerid][index][vtObject]))
        DestroyDynamicObject(VehicleTruckerData[playerid][index][vtObject]);
    
    VehicleTruckerData[playerid][index][vtObject] = INVALID_OBJECT_ID;
    VehicleTruckerData[playerid][index][vtId] = -1;
    VehicleTruckerData[playerid][index][vtProductID] = -1;
    PlayerTruckerData[playerid][ClaimFactoryID] = VehicleTruckerData[playerid][index][vtFactoryID];
    VehicleTruckerData[playerid][index][vtFactoryID] = -1;
	return 1;
}

stock GetVehicleTruckerFree(playerid)
{
    for(new i; i < MAX_OBJECTTRUCKER; i++)
    {
        if(VehicleTruckerData[playerid][i][vtId] == -1)
            return i;
    }
    return -1;
}

stock GetVehicleProduct(playerid, pCarSlotID)
{
    new str[1000];
    format(str, sizeof(str), "ID\t\tSan Pham");
    for(new i; i < MAX_OBJECTTRUCKER; i++)
    {
        if(VehicleTruckerData[playerid][i][vtId] != -1 && VehicleTruckerData[playerid][i][vtSlotId] == pCarSlotID
            && VehicleTruckerData[playerid][i][vtProductID] != -1){
            format(str, sizeof(str), "%s\n%d\t\t%s", str, i);
        }
    }
    Dialog_Show(playerid, DIALOG_CARPRODUCT, DIALOG_STYLE_TABLIST_HEADER, "San Pham Trong Xe", str, "Lay", "<");
}


stock VehicleTruckerCount(playerid, pCarSlotID)
{
    new count = 0;
    for(new i; i < MAX_OBJECTTRUCKER; i++)
    {
        if(VehicleTruckerData[playerid][i][vtId] != -1 && VehicleTruckerData[playerid][i][vtSlotId] == pCarSlotID
            && VehicleTruckerData[playerid][i][vtProductID] != -1){
            count++;
        }
    }
    return count;
}
