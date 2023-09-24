#include <YSI_Coding\y_hooks>
#define MAX_CARRENT (3)
enum carRentData
{
	carID,
	carExists,
	carModel,
	carOwner,
	Float:carPos[4],
	carColor1,
	carColor2,
	carLocked,
	Float:carFuel,
	carPlates[32],
    carProduct[7],
    carTime,
	carVehicle
};

new CarRentInfo[MAX_PLAYERS][MAX_CARRENT][CarRentInfo];
new Timer:carRentTime[MAX_PLAYERS] = {Timer:-1, ...};
forward CARRENT_LOAD(playerid);


stock LoadCarRent(playerid)
{
    new PlayerSQLId = GetPlayerSQLId(playerid),
        str[1080];
    format(str, sizeof(str), "SELECT * FROM `carrent` WHERE `ID` = '%d'", PlayerSQLId);
    mysql_function_query(MainPipeline, str, true, "CARRENT_LOAD", "i", playerid);
}

public CARRENT_LOAD(playerid)
{
    new i, rows, fields, tmp[128], str[128];
    cache_get_data(rows, fields, MainPipeline);
    for(new indexcar; indexcar < MAX_CARRENT; indexcar++)
        CarRentInfo[playerid][indexcar][carExists] = false;
    while(i < rows)
    {
        CarRentInfo[playerid][i][carExists] = true;
        cache_get_field_content(i, "carID", tmp, MainPipeline); CarRentInfo[playerid][i][carID] = strval(tmp);
        cache_get_field_content(i, "carModel", tmp, MainPipeline); CarRentInfo[playerid][i][carModel] = strval(tmp);
        cache_get_field_content(i, "carOwner", tmp, MainPipeline); CarRentInfo[playerid][i][carOwner] = strval(tmp);
		cache_get_field_content(i, "carPosX", tmp, MainPipeline); CarRentInfo[playerid][i][carPos][0] = floatstr(tmp);
        cache_get_field_content(i, "carPosY", tmp, MainPipeline); CarRentInfo[playerid][i][carPos][1] = floatstr(tmp);
        cache_get_field_content(i, "carPosZ", tmp, MainPipeline); CarRentInfo[playerid][i][carPos][2] = floatstr(tmp);
        cache_get_field_content(i, "carPosR", tmp, MainPipeline); CarRentInfo[playerid][i][carPos][3] = floatstr(tmp);
        cache_get_field_content(i, "carFuel", tmp, MainPipeline); CarRentInfo[playerid][i][carFuel] = floatstr(tmp);
        cache_get_field_content(i, "carColor1", tmp, MainPipeline); CarRentInfo[playerid][i][carColor1] = strval(tmp);
        cache_get_field_content(i, "carColor2", tmp, MainPipeline); CarRentInfo[playerid][i][carColor2] = strval(tmp);
        cache_get_field_content(i, "carLocked", tmp, MainPipeline); CarRentInfo[playerid][i][carLocked] = strval(tmp);
        cache_get_field_content(i, "carTime", tmp, MainPipeline); CarRentInfo[playerid][i][carTime] = strval(tmp);
		cache_get_field_content(i, "carPlates", CarRentInfo[playerid][i][carPlates], MainPipeline, 64);
        for(new j; j < 7; i++)
        {
            format(str, sizeof(str), "carProduct%d", j);
            cache_get_field_content(i, str, tmp, MainPipeline); CarRentInfo[playerid][i][carProduct][j] = strval(tmp);
        }
        Car_Spawn(playerid, i);
        i++;
    }
    if(i > 0) printf("[LOAD CAR RENT] du lieu car rent cua %s (ID: %d) da duoc tai.", GetPlayerNameEx(playerid), playerid);
	carRentTime[playerid] = repeat ItemTimer(playerid);
}

stock Car_Spawn(playerid, carid)
{
	if(carid != -1 && CarRentInfo[playerid][carid][carExists])
	{
		if(IsValidVehicle(CarRentInfo[playerid][carid][carVehicle]))
			DestroyVehicle(CarRentInfo[playerid][carid][carVehicle]);

		if(CarRentInfo[playerid][carid][carColor1] == -1)
			CarRentInfo[playerid][carid][carColor1] = random(127);

		if(CarRentInfo[playerid][carid][carColor2] == -1)
			CarRentInfo[playerid][carid][carColor2] = random(127);

		CarRentInfo[playerid][carid][carVehicle] = CreateVehicle(CarRentInfo[playerid][carid][carModel], CarRentInfo[playerid][carid][carPos][0], CarRentInfo[playerid][carid][carPos][1], CarRentInfo[playerid][carid][carPos][2], CarRentInfo[playerid][carid][carPos][3], CarRentInfo[playerid][carid][carColor1], CarRentInfo[playerid][carid][carColor2], (CarRentInfo[playerid][carid][carOwner] != 0) ? (-1) : (1200000));
		if(CarRentInfo[playerid][carid][carVehicle] != INVALID_VEHICLE_ID)
		{
			if(CarRentInfo[playerid][carid][carLocked])
			{
			    new
					engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(CarRentInfo[playerid][carid][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(CarRentInfo[playerid][carid][carVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
			}
			SetVehicleNumberPlate(CarRentInfo[playerid][carid][carVehicle], CarRentInfo[playerid][carid][carPlates]);
			CarRentInfo[playerid][carid][carFuel] = CoreVehicles[CarRentInfo[playerid][carid][carVehicle]][vehFuel];
			ResetVehicle(CarRentInfo[playerid][carid][carVehicle]);
			return 1;
		}
	}
	return 0;
}