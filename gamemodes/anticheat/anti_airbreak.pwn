#include <YSI_Coding\y_hooks>

new VehicleCheck[MAX_PLAYERS],
	playerVehID[MAX_PLAYERS];


hook OnGameModeInit()
{
	return 1;
}

hook OnPlayerConnect(playerid)
{
	VehicleCheck[playerid] = 0;
	playerVehID[playerid] = 0;
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	VehicleCheck[playerid] = 0;
	playerVehID[playerid] = 0;
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string[128];
	if(VehicleCheck[playerid] > 5)
	{
		format(string, sizeof(string), "[RCRP-AC] %s (%d - %d) nghi van su dung hack Airbreak (001).", GetPlayerNameEx(playerid, false), playerid, GetPlayerSQLId(playerid));
   	    ABroadCast(COLOR_YELLOW, string, 2);
		format(string, sizeof(string), "[RCRP-AC] %s (%d) da bi kick khoi may chu [Reason: LSRP-AC Airbeak #1-001].", GetPlayerNameEx(playerid, false), playerid);
		SendClientMessageToAllEx(COLOR_LIGHTRED, string);
		SetTimerEx("KickEx", 1000, 0, "i", playerid);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		playerVehID[playerid] = vehicleid;
	}
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		playerVehID[playerid] = vehicleid;
	}
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
    	if(playerVehID[playerid] != GetPlayerVehicleID(playerid))
		{
			if(PlayerInfo[playerid][pAdmin] < 1)
			{
		 	    new string[128];
				VehicleCheck[playerid] += 1;
				if(VehicleCheck[playerid] > 5)
				{
					format(string, sizeof(string), "[RCRP-AC] %s (%d - %d) nghi van su dung hack Airbreak (002).", GetPlayerNameEx(playerid, false), playerid, GetPlayerSQLId(playerid));
			   	    ABroadCast(COLOR_YELLOW, string, 2);
					format(string, sizeof(string), "[RCRP-AC] %s (%d) da bi kick khoi may chu [Reason: Airbeak #1-002].",  GetPlayerNameEx(playerid, false), playerid);
					SendClientMessageToAllEx(COLOR_LIGHTRED, string);
					//RespawnNearbyVehicles(playerid, 30);
					SetTimerEx("KickEx", 1000, 0, "i", playerid);
				}
			}
		}
	}
	return 1;
}

hook OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat)
{
	new string[128];
    if(passenger_seat == 1)
    {
    	if(PlayerInfo[playerid][pAdmin] < 1 && FixLoi(playerid))
		{
            new playerip[32];
		    GetPlayerIp(playerid, playerip, sizeof(playerip));
	    	if(playerVehID[playerid] != GetPlayerVehicleID(playerid))
	    	{
                format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: Phuong tien (VID: %d) dang bi %s (ID: %d - IP: %s) hack Airbreak.", vehicleid, GetPlayerNameEx(playerid, false), playerid, playerip);
				ABroadCast(COLOR_YELLOW, string, 2);
	    		/*new string[128];
				VehicleCheck[playerid] += 1;
				if(VehicleCheck[playerid] > 5)
				{
					format(string, sizeof(string), "**[LS:RP AC - Airbreak Warning]** - **%s** có thể đang sử dụng Hack Airbreak #1.", GetCharacterNameT(playerid), playerid);
	        		DCC_SendChannelMessage(CheatDetect, string);
					format(string, sizeof(string), "[LSRP-AC] Phuong tien (VID: %d) dang bi %s (%d) lam Airbreak.", vehicleid, GetCharacterNameT(playerid),playerid);
			   	    foreach(new i : Player)
					{
						if(PlayerInfo[i][pAdmin] > 0)
						{
							SendClientMessageEx(i, COLOR_CHAT, string);
						}	
					}
				}*/
	    	}
		}
	}
	return 1;
}
