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
	printf("Saving Farm ID %d", farmid);
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

public OnCreateFarmFinish(playerid, farmid, type)
{
    switch(type)
    {
        case SENDDATA_FARM: 
        {
            FarmInfo[farmid][Id] = mysql_insert_id(MainPipeline);
            FarmInfo[farmid][Exsits] = true;
            Farm_Reload(farmid);
        }
        // case SENDDATA_CROPTIMER: 
        // {
        //     FarmCropInfo[playerid][farmid][c_Id] = mysql_insert_id(MainPipeline);
        // }
        // case SENDDATA_ANIMALTIMER: 
        // {
        //     FarmAnimalInfo[playerid][farmid][a_Id] = mysql_insert_id(MainPipeline);
        // }
    }
    return 1;
}
