stock LoadFarms()
{
	printf("[LoadFarms] Loading data from database...");
	mysql_function_query(MainPipeline, "SELECT OwnerName.Username, f.* FROM farms f LEFT JOIN accounts OwnerName ON f.OwnerPlayer = OwnerName.id", true, "OnLoadFarms", "");
}

public OnLoadFarms()
{
    for(new i; i < MAX_FARM; i++)
    {
        FarmInfo[i][Exsits] = false;
        FarmInfo[i][fPickupID] = -1;
        FarmInfo[i][fTextID] = INVALID_3DTEXT_ID;
    }
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);

	while(i < rows)
	{
		cache_get_field_content(i, "Id", tmp, MainPipeline); FarmInfo[i][Id] = strval(tmp);
		cache_get_field_content(i, "OwnerPlayer", tmp, MainPipeline); FarmInfo[i][OwnerPlayerId] = strval(tmp);
		cache_get_field_content(i, "Username", FarmInfo[i][OwnerName], MainPipeline, MAX_PLAYER_NAME);
		cache_get_field_content(i, "VirtualWorld", tmp, MainPipeline); FarmInfo[i][VirtualWorld] = strval(tmp);
		cache_get_field_content(i, "ExteriorX", tmp, MainPipeline); FarmInfo[i][ExteriorX] = floatstr(tmp);
		cache_get_field_content(i, "ExteriorY", tmp, MainPipeline); FarmInfo[i][ExteriorY] = floatstr(tmp);
		cache_get_field_content(i, "ExteriorZ", tmp, MainPipeline); FarmInfo[i][ExteriorZ] = floatstr(tmp);
		cache_get_field_content(i, "FarmType", tmp, MainPipeline); FarmInfo[i][FarmType] = strval(tmp);
		cache_get_field_content(i, "FarmPrice", tmp, MainPipeline); FarmInfo[i][FarmPrice] = strval(tmp);
		cache_get_field_content(i, "RentFee", tmp, MainPipeline); FarmInfo[i][RentFee] = strval(tmp);
		cache_get_field_content(i, "RentTimer", tmp, MainPipeline); FarmInfo[i][RentTimer] = strval(tmp);
        FarmInfo[i][Exsits] = true;
        Farm_Reload(i);
  		i++;
 	}
	if(i > 0) printf("[LoadFarms] %d du lieu nong trai da duoc tai.", i);
}

stock FARM_UPDATE(farmid)
{
	new string[2048];
	format(string, sizeof(string), "UPDATE `farms` SET \
		`OwnerPlayer`=%d, \
		`VirtualWorld`=%d, \
		`ExteriorX`=%f, \
		`ExteriorY`=%f, \
		`ExteriorZ`=%f, \
		`FarmType`=%d, \
		`RentFee`=%d, \
		`FarmPrice`=%d, \
		`RentTimer`=%d WHERE `Id`=%d",
		FarmInfo[farmid][OwnerPlayerId],
		FarmInfo[farmid][VirtualWorld],
        FarmInfo[farmid][ExteriorX],
        FarmInfo[farmid][ExteriorY],
        FarmInfo[farmid][ExteriorZ],
        FarmInfo[farmid][FarmType],
        FarmInfo[farmid][RentFee],
        FarmInfo[farmid][FarmPrice],
        FarmInfo[farmid][RentTimer],
        FarmInfo[farmid][Id]
	);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    Farm_Reload(farmid);
    return 1;
}

stock FARM_ADD(farmid)
{
	new string[2048];
    format(string, sizeof(string), "INSERT INTO `farms` (\
		`OwnerPlayer`, \
		`VirtualWorld`, \
		`ExteriorX`,\
		`ExteriorY`, \
		`ExteriorZ`, \
		`FarmType`, \
		`RentFee`, \
        `FarmPrice`,\
        `RentTimer`) \
		VALUES ('%d', '%d', '%f', '%f', '%f', '%d', '%d', '%d', '%d')", 
		FarmInfo[farmid][OwnerPlayerId],
		FarmInfo[farmid][VirtualWorld],
        FarmInfo[farmid][ExteriorX],
        FarmInfo[farmid][ExteriorY],
        FarmInfo[farmid][ExteriorZ],
        FarmInfo[farmid][FarmType],
        FarmInfo[farmid][RentFee],
        FarmInfo[farmid][FarmPrice],
        FarmInfo[farmid][RentTimer]
	);
	mysql_function_query(MainPipeline, string, false, "OnCreateFarmFinish", "iii", -1, farmid, SENDDATA_FARM);
	return 1;
}

stock FARM_DELETE(farmid)
{
    if(FarmInfo[farmid][Exsits])
	{
        new
            string[64];
        format(string, sizeof(string), "DELETE FROM `farms` WHERE `Id`= '%d'", FarmInfo[farmid][Id]);
        mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
        FarmRemove(farmid);
    }
	return 1;
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          PLANT
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
stock FarmPlants_LOAD(playerid)
{
	printf("[LOAD PLANT] Loading data from database...");
    new str[128];
    format(str, sizeof(str), "SELECT c.* FROM farmplants c WHERE c.OwnerPlayerId = %d", GetPlayerSQLId(playerid));
	mysql_function_query(MainPipeline, str, true, "OnLoadPlants", "i", playerid);
	ActorFarmer[playerid] = CreateDynamicActor(158, -1420.0443, -1474.9486, 101.6293, 0, true, 100.0, GetPlayerSQLId(playerid), 0, -1);
	ApplyActorAnimation(ActorFarmer[playerid], "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0);
}

public OnLoadPlants(playerid)
{
    for(new i = 0; i < MAX_PLAYER_PLANT; i++)
    {
        PlantTreeInfo[playerid][i][Exsits] = false;
    }
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);

	while(i < rows)
	{
		cache_get_field_content(i, "Id", tmp, MainPipeline); PlantTreeInfo[playerid][i][Id] = strval(tmp);
		cache_get_field_content(i, "plantLevel", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantLevel] = strval(tmp);
		cache_get_field_content(i, "plantType", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantType] = strval(tmp);
		cache_get_field_content(i, "plantStatus", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantStatus] = strval(tmp);
		cache_get_field_content(i, "plantAmount", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantAmount] = strval(tmp);
		cache_get_field_content(i, "plantTimer", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantTimer] = strval(tmp);
		cache_get_field_content(i, "plantPos0", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantPos][0] = floatstr(tmp);
		cache_get_field_content(i, "plantPos1", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantPos][1] = floatstr(tmp);
		cache_get_field_content(i, "plantPos2", tmp, MainPipeline); PlantTreeInfo[playerid][i][plantPos][2] = floatstr(tmp);
  		PlantTreeInfo[playerid][i][Exsits] = true;
		PlantTree_Reload(playerid, i);
		i++;
 	}
	if(i > 0) printf("[LOAD PLANTS] %d du lieu cay trong da duoc tai.", i);
}

stock PLANT_UPDATE(playerid, index)
{
	new string[2048];
	format(string, sizeof(string), "UPDATE `farmplants` SET \
		`plantLevel` = %d, \
		`plantType` = %d, \
		`plantStatus` = %d, \
		`plantAmount` = %d, \
		`OwnerPlayerId` = %d, \
		`plantTimer` = %d, \
		`plantPos0` = %f,\
		`plantPos1` = %f,\
		`plantPos2` = %f\
         WHERE `Id` = %d",
		PlantTreeInfo[playerid][index][plantLevel],
		PlantTreeInfo[playerid][index][plantType],
		PlantTreeInfo[playerid][index][plantStatus],
		PlantTreeInfo[playerid][index][plantAmount],
        GetPlayerSQLId(playerid),
		PlantTreeInfo[playerid][index][plantTimer],
		PlantTreeInfo[playerid][index][plantPos][0],
		PlantTreeInfo[playerid][index][plantPos][1],
		PlantTreeInfo[playerid][index][plantPos][2],
		PlantTreeInfo[playerid][index][Id]
	);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    return 1;
}

stock PLANT_ADD(playerid, index)
{
	new string[2048];
    format(string, sizeof(string), "INSERT INTO `farmplants` (\
		`plantLevel`, \
		`plantType`, \
		`plantStatus`, \
		`plantAmount`, \
		`OwnerPlayerId`, \
		`plantTimer`, \
		`plantPos0`, \
		`plantPos1`, \
		`plantPos2`)\
		VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%f', '%f', '%f')", 
        PlantTreeInfo[playerid][index][plantLevel],
        PlantTreeInfo[playerid][index][plantType],
        PlantTreeInfo[playerid][index][plantStatus],
        PlantTreeInfo[playerid][index][plantAmount],
        GetPlayerSQLId(playerid),
        PlantTreeInfo[playerid][index][plantTimer],
		PlantTreeInfo[playerid][index][plantPos][0],
		PlantTreeInfo[playerid][index][plantPos][1],
		PlantTreeInfo[playerid][index][plantPos][2]
	);
	mysql_function_query(MainPipeline, string, false, "OnCreateFarmFinish", "iii", playerid, index, SENDDATA_PLANTS);
	return 1;
}

stock PLANT_DELETE(playerid, index)
{
    if(PlantTreeInfo[playerid][index][Id] != 0)
	{
        new
            string[64];
        format(string, sizeof(string), "DELETE FROM `farmplants` WHERE `Id`= '%d'", PlantTreeInfo[playerid][index][Id]);
        mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		PlantTree_Remove(playerid, index);
    }
	return 1;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          PLANT
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
stock CATTLE_LOAD(playerid)
{
	printf("[LOAD CATTLE] Loading data from database...");
    new str[128];
	for(new i = 0; i < MAX_CATTLES; i++)
    {
        RaiseCattleInfo[playerid][i][Exsits] = false;
    }
	LoadPutCattle(playerid);
    format(str, sizeof(str), "SELECT c.* FROM farmcattle c WHERE c.OwnerPlayerId = %d", GetPlayerSQLId(playerid));
	mysql_function_query(MainPipeline, str, true, "OnLoadCattles", "i", playerid);
}

public OnLoadCattles(playerid)
{
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);

	while(i < rows)
	{
		cache_get_field_content(i, "Id", tmp, MainPipeline); RaiseCattleInfo[playerid][i][Id] = strval(tmp);
		cache_get_field_content(i, "cattleStatus", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Status] = strval(tmp);
		cache_get_field_content(i, "cattleTimer", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Timer] = strval(tmp);
		cache_get_field_content(i, "cattleModel", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Model] = strval(tmp);
		cache_get_field_content(i, "cattlePos0", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Pos][0] = floatstr(tmp);
		cache_get_field_content(i, "cattlePos1", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Pos][1] = floatstr(tmp);
		cache_get_field_content(i, "cattlePos2", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Pos][2] = floatstr(tmp);
		cache_get_field_content(i, "spawnPos", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_SpawnPos] = strval(tmp);
		cache_get_field_content(i, "cattleRotZ", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Pos][3] = floatstr(tmp);
		cache_get_field_content(i, "cattleName", RaiseCattleInfo[playerid][i][c_Name], MainPipeline, 32);
		cache_get_field_content(i, "weight", tmp, MainPipeline); RaiseCattleInfo[playerid][i][c_Weight] = strval(tmp);
		RaiseCattleInfo[playerid][i][Exsits] = true;
		CattlePosData[playerid][RaiseCattleInfo[playerid][i][c_SpawnPos]][Exsits] = true;
		Cattle_Reload(playerid, i);
  		i++;
 	}
	if(i > 0) printf("[LOAD CATTLE] %d du lieu dong vat da duoc tai.", i);
}

stock CATTLE_UPDATE(playerid, index)
{
	new string[2048];
	format(string, sizeof(string), "UPDATE `farmcattle` SET \
		`cattleStatus`=%d, \
		`OwnerPlayerId`=%d, \
		`cattleName`= '%s', \
		`cattleTimer`=%d, \
		`cattleModel`=%d, \
		`cattlePos0`=%f,\
		`cattlePos1`=%f,\
		`cattlePos2`=%f,\
		`cattleRotZ`=%f,\
		`spawnPos`=%d,\
		`weight`=%d WHERE `Id`=%d",
		RaiseCattleInfo[playerid][index][c_Status],
        GetPlayerSQLId(playerid),
		g_mysql_ReturnEscaped(RaiseCattleInfo[playerid][index][c_Name], MainPipeline),
		RaiseCattleInfo[playerid][index][c_Timer],
		RaiseCattleInfo[playerid][index][c_Model],
		RaiseCattleInfo[playerid][index][c_Pos][0],
		RaiseCattleInfo[playerid][index][c_Pos][1],
		RaiseCattleInfo[playerid][index][c_Pos][2],
		RaiseCattleInfo[playerid][index][c_Pos][3],
		RaiseCattleInfo[playerid][index][c_SpawnPos],
		RaiseCattleInfo[playerid][index][c_Weight],
		RaiseCattleInfo[playerid][index][Id]
	);
	Cattle_Reload(playerid, index);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    return 1;
}

stock CATTLE_ADD(playerid, index)
{
	new string[2048];
    format(string, sizeof(string), "INSERT INTO `farmcattle` (\
		`cattleStatus`, \
		`OwnerPlayerId`, \
		`cattleName`, \
		`cattleTimer`, \
		`cattleModel`, \
		`cattlePos0`, \
		`cattlePos1`, \
		`cattlePos2`,\
		`cattleRotZ`,\
		`spawnPos`,\
		`weight`)\
		VALUES ('%d', '%d', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '%d')", 
        RaiseCattleInfo[playerid][index][c_Status],
        GetPlayerSQLId(playerid),
		g_mysql_ReturnEscaped(RaiseCattleInfo[playerid][index][c_Name], MainPipeline),
		RaiseCattleInfo[playerid][index][c_Timer],
		RaiseCattleInfo[playerid][index][c_Model],
		RaiseCattleInfo[playerid][index][c_Pos][0],
		RaiseCattleInfo[playerid][index][c_Pos][1],
		RaiseCattleInfo[playerid][index][c_Pos][2],
		RaiseCattleInfo[playerid][index][c_Pos][3],
		RaiseCattleInfo[playerid][index][c_SpawnPos],
		RaiseCattleInfo[playerid][index][c_Weight]
	);
	mysql_function_query(MainPipeline, string, false, "OnCreateFarmFinish", "iii", playerid, index, SENDDATA_CATTLE);
	return 1;
}

stock CATTLE_DELETE(playerid, index)
{
    if(RaiseCattleInfo[playerid][index][Id] != 0)
	{
        new
            string[64];
        format(string, sizeof(string), "DELETE FROM `farmcattle` WHERE `Id`= '%d'", RaiseCattleInfo[playerid][index][Id]);
        mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);

        RaiseCattleInfo[playerid][index][Exsits] = false;
        RaiseCattleInfo[playerid][index][Id] = 0;
		Cattle_Remove(playerid, index);
    }
	return 1;
}

public OnCreateFarmFinish(playerid, index, type)
{
    switch(type)
    {
        case SENDDATA_FARM: 
        {
            FarmInfo[index][Id] = mysql_insert_id(MainPipeline);
            FarmInfo[index][Exsits] = true;
            Farm_Reload(index);
        }
        case SENDDATA_PLANTS: 
        {
		    PlantTreeInfo[playerid][index][Id] = mysql_insert_id(MainPipeline);
            PlantTreeInfo[playerid][index][Exsits] = true;
        }
        case SENDDATA_CATTLE: 
        {
            RaiseCattleInfo[playerid][index][Id] = mysql_insert_id(MainPipeline);
            RaiseCattleInfo[playerid][index][Exsits] = true;
			CattlePosData[playerid][RaiseCattleInfo[playerid][index][c_SpawnPos]][Exsits] = true;
			Cattle_Reload(playerid, index);
        }
		case SENDDATA_ORDERPRODUCT:{
			OrderFlourInfo[playerid][index][Id] = mysql_insert_id(MainPipeline);
            OrderFlourInfo[playerid][index][Exsits] = true;
		}
    }
    return 1;
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          ORDER PRODUCT
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
stock ORDERPRODUCT_LOAD(playerid)
{
	printf("[LOAD ORDER PRODUCT] Loading data from database...");
    new str[128];
	LoadPutCattle(playerid);
    format(str, sizeof(str), "SELECT c.* FROM orderproducts c WHERE c.OwnerPlayerId = %d", GetPlayerSQLId(playerid));
	mysql_function_query(MainPipeline, str, true, "OnLoadOrderProduct", "i", playerid);
}

public OnLoadOrderProduct(playerid)
{
    for(new i = 0; i < MAX_ORDERPRODUCT; i++)
    {
        OrderFlourInfo[playerid][i][Exsits] = false;
    }
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);

	while(i < rows)
	{
		cache_get_field_content(i, "Id", tmp, MainPipeline); OrderFlourInfo[playerid][i][Id] = strval(tmp);
		cache_get_field_content(i, "Timer", tmp, MainPipeline); OrderFlourInfo[playerid][i][OrderTimer] = strval(tmp);
		cache_get_field_content(i, "Quantity", tmp, MainPipeline); OrderFlourInfo[playerid][i][OrderQuantity] = strval(tmp);
		cache_get_field_content(i, "productName", OrderFlourInfo[playerid][i][ProductName], MainPipeline, 32);
		OrderFlourInfo[playerid][i][Exsits] = true;
  		i++;
 	}
	if(i > 0) printf("[LOAD ORDER PRODUCT] %d du lieu che tao san pham da duoc tai.", i);
}

stock ORDERPRODUCT_ADD(playerid, index)
{
	new string[2048];
    format(string, sizeof(string), "INSERT INTO `orderproducts` (\
		`Timer`, \
		`Quantity`, \
		`productName`, \
		`OwnerPlayer`)\
		VALUES ('%d', '%d', '%s', '%d')", 
        OrderFlourInfo[playerid][index][OrderTimer],
        OrderFlourInfo[playerid][index][OrderQuantity],
		g_mysql_ReturnEscaped(OrderFlourInfo[playerid][index][ProductName], MainPipeline),
        GetPlayerSQLId(playerid)
	);
	mysql_function_query(MainPipeline, string, false, "OnCreateFarmFinish", "iii", playerid, index, SENDDATA_ORDERPRODUCT);
	return 1;
}

stock ORDERPRODUCT_DELETE(playerid, index)
{
    if(OrderFlourInfo[playerid][index][Id] != 0)
	{
        new
            string[64];
        format(string, sizeof(string), "DELETE FROM `orderproducts` WHERE `Id`= '%d'", OrderFlourInfo[playerid][index][Id]);
        mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
        OrderFlourInfo[playerid][index][Exsits] = false;
        OrderFlourInfo[playerid][index][Id] = 0;
    }
	return 1;
}