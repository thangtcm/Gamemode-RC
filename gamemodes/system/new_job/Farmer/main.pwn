#include <a_samp>
#include <YSI_Coding\y_hooks>
#include "system/new_job/Farmer/setting.pwn"
#include "system/new_job/Farmer/database.pwn"
#include "system/new_job/Farmer/map.pwn"
#include "system/new_job/Farmer/func.pwn"
#include "system/new_job/Farmer/dialog.pwn"
#include "system/new_job/Farmer/cmd.pwn"

hook OnGameModeInit()
{
	CreateFarmMap(); 
	FarmPlantArea = CreateDynamicPolygon(farm_area_v1);
	FarmPlantOrangeArea = CreateDynamicPolygon(farm_area_v3);
	PlayerFarmArea = CreateDynamicPolygon(farm_area_v2);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingFarmMap(playerid);
	// for(new i = 0; i < MAX_PLAYER_PLANT; i++) {
	// 	PlantTreeInfo[playerid][i][pi_ID] = -1;
	// }
	
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsValidDynamicActor(ActorFarmer[playerid]))
		DestroyDynamicActor(ActorFarmer[playerid]);
	for(new i= 0; i < MAX_PLAYER_PLANT; i++)
    {
        if(PlantTreeInfo[playerid][i][Exsits] && PlayerInfo[playerid][pFarmerKey] != -1)
        {
			PLANT_UPDATE(playerid, i);
			PlantTree_Remove(playerid, i);
        }
    }
	for(new i= 0; i < MAX_CATTLES; i++)
    {
        if(RaiseCattleInfo[playerid][i][Exsits])
		{
            CATTLE_UPDATE(playerid, i);
			Cattle_Remove(playerid, i);
		}
    }
	LeaveAreaFarm(playerid);
	return 1;
}
