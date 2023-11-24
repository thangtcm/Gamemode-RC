// 
#include <a_samp>
#include <YSI_Coding\y_hooks>


new PrisonCP[MAX_PLAYERS];
new PrisonCPCount[MAX_PLAYERS];


new Float:Prison_CP[7][3] = {
{-1422.1245,1056.9213,1038.5179},
{-1422.1245,1056.9213,1038.5179},
{-1314.4272,949.4390,1036.5382},
{-1423.1418,996.2273,1024.1703},
{-1517.7050,1001.7429,1037.7595},
{-1317.8480,945.9881,1036.4901},
{-1506.8130,1018.9573,1038.0334}
};
// onplayerload
 /*   if(PrisonCP[playerid] == 1) {
        ActSetPlayerPos(playerid,-1398.103515,937.631164,1036.479125);
        SetPlayerInterior(playerid, 15);
        SetPVarInt(playerid,"PrisonCP",1);
        SetPlayerCheckPointEx(playerid,Prison_CP[GetPVarInt(playerid,"PrisonCP")][0], Prison_CP[GetPVarInt(playerid,"PrisonCP")][1],Prison_CP[GetPVarInt(playerid,"PrisonCP")][2], 4);
    }
 
    */
   // SavePlayerInteger(query, GetPlayerSQLId(playerid), "PrisonCP", PrisonCP[playerid]);
   // SavePlayerInteger(query, GetPlayerSQLId(playerid), "PrisonCPCount", PrisonCPCount[playerid]);
   // cache_get_field_content(row,  "PrisonCP", szResult, MainPipeline); PrisonCP[playerid] = strval(szResult);
   // cache_get_field_content(row,  "PrisonCPCount", szResult, MainPipeline); PrisonCPCount[playerid] = strval(szResult);

CMD:cpprison(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new string[128], giveplayerid, minutes, reason[64];
		if(sscanf(params, "uds[64]", giveplayerid, minutes, reason)) return SendUsageMessage(playerid, " /prison [player] [checkpoint] [reason]");

		if(IsPlayerConnected(giveplayerid))
		{
			SetPlayerArmedWeapon(giveplayerid, 0);
			if(GetPVarInt(giveplayerid, "Injured") == 1)
			{
				KillEMSQueue(giveplayerid);
				ClearAnimations(giveplayerid);
			}
			if(GetPVarInt(giveplayerid, "IsInArena") >= 0) LeavePaintballArena(giveplayerid, GetPVarInt(giveplayerid, "IsInArena"));
			ResetPlayerWeaponsEx(giveplayerid);
			format(string, sizeof(string), "AdmCmd: %s da bi phat tu %d checkpoint boi %s, ly do: %s", GetPlayerNameEx(giveplayerid),minutes, GetPlayerNameEx(playerid), reason);
			Log("logs/admin.log", string);
			format(string, sizeof(string), "AdmCmd: %s da bi phat tu %d checkpoint boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), minutes,GetPlayerNameEx(playerid), reason);
			SendClientMessageToAllEx(COLOR_LIGHTRED, string);
			ActSetPlayerPos(giveplayerid,-1398.103515,937.631164,1036.479125);
        	SetPlayerInterior(giveplayerid, 15);
        	PrisonCP[giveplayerid] = 1;
        	PrisonCPCount[giveplayerid] = minutes;
        	SetPVarInt(playerid,"PrisonCP",1);
       	 	SetPlayerCheckPointEx(playerid,Prison_CP[GetPVarInt(playerid,"PrisonCP")][0], Prison_CP[GetPVarInt(playerid,"PrisonCP")][1],Prison_CP[GetPVarInt(playerid,"PrisonCP")][2], 4);
		}
	}
	else SendErrorMessage(playerid, "Ban khong the su dung lenh nay");
	return 1;
}
hook OnPlayerDeath(playerid) {
	if(PrisonCP[playerid] == 1) {
		SetTimerEx("ChetTrongTu", 2500, 0, "d", playerid);
	}
}
forward ChetTrongTu(playerid);
public ChetTrongTu(playerid) {
	TogglePlayerControllable(playerid, 1);
	KillEMSQueue(playerid);
   	ClearAnimations(playerid);
   	SetPlayerHealth(playerid, 100);
	ActSetPlayerPos(playerid,-1398.103515,937.631164,1036.479125);
    SetPlayerInterior(playerid, 15);
    return 1;
}
hook OnPlayerEnterCheckpoint(playerid) {
    if(PrisonCP[playerid] == 1) {
    	PrisonCPCount[playerid] -= 1;
    	SetPVarInt(playerid, "PrisonCP", GetPVarInt(playerid,"PrisonCP")+1);
    	printf("cp: %d",GetPVarInt(playerid,"PrisonCP"));
    	if(GetPVarInt(playerid,"PrisonCP") >= 7) {
    		SetPVarInt(playerid,"PrisonCP",1);
    	}
    	new string[129];
    	format(string, sizeof(string), "So checkpoint con lai la %d", PrisonCPCount[playerid]);
		GameTextForPlayer(playerid, string, 10000, 3);
        SetPlayerCheckPointEx(playerid,Prison_CP[GetPVarInt(playerid,"PrisonCP")][0], Prison_CP[GetPVarInt(playerid,"PrisonCP")][1],Prison_CP[GetPVarInt(playerid,"PrisonCP")][2], 4);
        if(PrisonCPCount[playerid] <= 0) {
        	ActSetPlayerPos(playerid, 1541.6099,-1671.7644,13.5529);
        	SetPlayerFacingAngle(playerid, 82.8185);
        	SetPlayerInterior(playerid, 0);
        	DisablePlayerCheckpoint(playerid);
        	PrisonCPCount[playerid] = 0;
        	PrisonCP[playerid] = 0;
        	DeletePVar(playerid, "PrisonCP");
        }
    }
    return 1;
}
  