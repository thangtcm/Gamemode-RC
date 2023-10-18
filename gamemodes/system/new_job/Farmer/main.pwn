#include <YSI\y_hooks>
#define JOB_FARMER 31
#include "system/new_job/Farmer/setting.pwn"
#include "system/new_job/Farmer/database.pwn"
#include "system/new_job/Farmer/map.pwn"
#include "system/new_job/Farmer/func.pwn"
#include "system/new_job/Farmer/dialog.pwn"
#include "system/new_job/Farmer/cmd.pwn"

hook OnGameModeInit()
{
	CreateFarmMap(); 
	return 1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingFarmMap(playerid);
	// for(new i = 0; i < MAX_PLAYER_PLANT; i++) {
	// 	PlantTreeInfo[playerid][i][pi_ID] = -1;
	// }
}