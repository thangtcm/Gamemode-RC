////////////////////////////////////FACTION/////////////////////////////////////////
#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{	
	switch(dialogid)
	{
		case DIALOG_THANHVIEN_FACTION:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pLeader] != INVALID_GROUP_ID) 
				{
					SetPVarString(playerid, "FactionKickName", inputtext);

					new string[1280];
					format(string, sizeof(string), "{FFFFFF}> Ban co dong y kick %s ra khoi %s khong?", inputtext,  arrGroupData[PlayerInfo[playerid][pMember]][g_szGroupName]);
					ShowPlayerDialog(playerid, DIALOG_FACTION_KICK, DIALOG_STYLE_MSGBOX, "Faction Kick", string, "Dong y", "Huy bo");
					return 1;
				}
			}
		}
		case DIALOG_FACTION_KICK:
		{
			if(response)
			{
				new name[128];
				GetPVarString(playerid, "FactionKickName", name, sizeof(name));
				KickFactionOff(playerid, name);
				return 1;
			}
		}	
	}
	return 1;
}	
CMD:faction(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] != INVALID_GROUP_ID) 
	{
		new Cache: Result, pNameget[128], vzstr[100000];
		Result = mysql_query(MainPipeline, "SELECT `LastLogin`, `Username`, `Member`, `Leader`, `Rank`, `Online` FROM `accounts` WHERE `Member` >= 0");
		new count;
		new leader;
		// new level;
		new rank;
		new LastLoginEx[255], Online;
		if(cache_num_rows())
		{
			for(new i = 0; i < cache_num_rows(); i++)
			{
				cache_get_field_content(i, "LastLogin", LastLoginEx);
				cache_get_field_content(i, "Username", pNameget);
				count = cache_get_field_content_int(i, "Member");
				leader = cache_get_field_content_int(i, "Leader");
				rank = cache_get_field_content_int(i, "Rank");
				// level = cache_get_field_content_int(i, "Level");
				Online = cache_get_field_content_int(i, "Online");
				if(count == PlayerInfo[playerid][pMember])
				{
					if(leader == INVALID_GROUP_ID)
						format(vzstr, sizeof(vzstr), "%s%s\t%d\t%s\t%s\n", vzstr, pNameget, rank, (!Online) ? "{AA3333}Offline" : "{33AA33}Online", LastLoginEx);
					else
						format(vzstr, sizeof(vzstr), "%s%s {FFFF00}(L){FFFFFF}\t%d\t%s\t%s\n", vzstr, pNameget, rank, (!Online) ? "{AA3333}Offline" : "{33AA33}Online", LastLoginEx);
				}
			}
		}
		else
		{
			return SendClientMessage(playerid, COLOR_WHITE, "Khong xu ly duoc du lieu");
		}
		cache_delete(Result);
		new danhsach[100000];
		format(danhsach, sizeof(danhsach), "Nguoi choi\tRank\tStatus\tLast Login\n%s", vzstr);
		ShowPlayerDialog(playerid, DIALOG_THANHVIEN_FACTION, DIALOG_STYLE_TABLIST_HEADERS, "List Faction Member", danhsach, "Dong y", "Huy bo");
	}
	return 1;
}
stock KickFactionOff(playerid, playername[]) {
	new giveplayerid = ReturnUser(playername);
	if(IsPlayerConnected(giveplayerid))
	{
	    if(PlayerInfo[giveplayerid][pLeader] == INVALID_GROUP_ID)
	    {
			new string[1280];
			format(string, sizeof(string), "[FACTION KICK ONLINE]: %s da kick %s ra khoi to chuc %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), arrGroupData[PlayerInfo[playerid][pMember]][g_szGroupName]);
			ABroadCast(COLOR_YELLOW, string, 1);
			Log("admins/factionkick.log", string);

            format(string, sizeof(string), "{FFFF00}[+]{FFFFFF} Ban da kick %s ra khoi to chuc cua minh", GetPlayerNameEx(giveplayerid));
            SendClientMessage(playerid, -1, string);
			SendClientMessageEx(giveplayerid, -1, "{AA3333}[!]{FFFFFF} Ban da bi lanh dao duoi khoi to chuc");

			PlayerInfo[giveplayerid][pDuty] = 0;
			PlayerInfo[giveplayerid][pMember] = INVALID_GROUP_ID;
			PlayerInfo[giveplayerid][pRank] = INVALID_RANK;
			PlayerInfo[giveplayerid][pLeader] = INVALID_GROUP_ID;
			PlayerInfo[giveplayerid][pDivision] = INVALID_DIVISION;
			if(!IsValidSkin(GetPlayerSkin(giveplayerid)))
			{
				new rand = random(sizeof(CIV));
				SetPlayerSkin(giveplayerid,CIV[rand]);
				PlayerInfo[giveplayerid][pModel] = CIV[rand];
			}
			player_remove_vip_toys(giveplayerid);
			pTazer{giveplayerid} = 0;
			SetPlayerToTeamColor(giveplayerid);
			return 1;
		}else SendClientMessageEx(playerid, COLOR_LIGHTRED, "> Ban khong duoc phep kick nhung thanh vien Leader.");
	}
	else
	{
		new query[128], tmpName[24];
		mysql_escape_string(playername, tmpName);
		format(query, sizeof(query), "UPDATE `accounts` SET `Member`=-1,`Leader`=-1,`OnDuty`=0,`Rank`=255, WHERE `Username`='%s'", tmpName);
		mysql_tquery(MainPipeline, query, "FactionTakeOffline", "i", playerid);

        new string[1280];
		format(string, sizeof(string), "[FACTION KICK OFFLINE]: %s da kick %s ra khoi %s.", GetPlayerNameEx(playerid), tmpName, arrGroupData[PlayerInfo[playerid][pMember]][g_szGroupName]);
		ABroadCast(COLOR_YELLOW, string, 1);
		Log("admins/factionkick.log", string);
        format(string, sizeof(string), "{FFFF00}[+]{FFFFFF} Ban da kick %s ra khoi to chuc cua minh", tmpName);
        SendClientMessage(playerid, -1, string);
        return 1;
	}
	return 1;
}