#include <a_samp>
#include <YSI_Coding\y_hooks>
new Timer:myNameTagTimer[MAX_PLAYERS] = {Timer:-1, ...};
stock GetHealthDots(playerid)
{
    new dots[64];
    new Float:HP;

    GetPlayerHealth(playerid, HP);
	if(HP == 100)
		dots = "----------";
	else if(HP >= 90 && HP < 100)
		dots = "---------{660000}-";
	else if(HP >= 80 && HP < 90)
		dots = "--------{660000}--";
	else if(HP >= 70 && HP < 80)
		dots = "-------{660000}---";
	else if(HP >= 60 && HP < 70)
		dots = "------{660000}----";
	else if(HP >= 50 && HP < 60)
		dots = "-----{660000}-----";
	else if(HP >= 40 && HP < 50)
		dots = "----{660000}------";
	else if(HP >= 30 && HP < 40)
		dots = "---{660000}-------";
	else if(HP >= 20 && HP < 30)
		dots = "--{660000}--------";
	else if(HP >= 10 && HP < 20)
		dots = "-{660000}---------";
	else if(HP >= 0 && HP < 10)
		dots = "{660000}----------";
	 
	return dots;
}

stock GetArmorDots(playerid)
{
	new dots[64];
	new Float:AR;
	 
	GetPlayerArmour(playerid, AR);
	 
	if(AR == 100)
		dots = "----------";
	else if(AR >= 90 && AR < 100)
		dots = "---------{666666}-";
	else if(AR >= 80 && AR < 90)
		dots = "--------{666666}--";
	else if(AR >= 70 && AR < 80)
		dots = "-------{666666}---";
	else if(AR >= 60 && AR < 70)
		dots = "------{666666}----";
	else if(AR >= 50 && AR < 60)
		dots = "-----{666666}-----";
	else if(AR >= 40 && AR < 50)
		dots = "----{666666}------";
	else if(AR >= 30 && AR < 40)
		dots = "---{666666}-------";
	else if(AR >= 20 && AR < 30)
		dots = "--{666666}--------";
	else if(AR >= 10 && AR < 20)
		dots = "-{666666}---------";
	else if(AR >= 0 && AR < 10)
		dots = "{666666}----------";

    return dots;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    SetPVarInt(playerid,"TakeNameTagDMG",gettime() + 8);
}

timer UpdateNameTagTimer[500](playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))
		{
			new nametag[388], Float:armour;
			GetPlayerArmour(playerid, armour);
			if(playerTabbed[playerid] != 0 && playerTabbed[playerid] > 10)
			{
				format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} %s (%d)", GetPlayerNameEx(playerid), playerid);
			}
			else
			{
				if(PlayerInfo[playerid][pMaskOn])
				{
					format(nametag, sizeof(nametag), "{%06x}[Mask %d_%d]{FFFFFF} (%d)", GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1], playerid);
				}
				else
				{
					format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%d)", GetPlayerColor(playerid) >>> 8, GetPlayerNameEx(playerid), playerid);
				}
			}
			if(gettime() < GetPVarInt(playerid, "TakeNameTagDMG") ) 
			{
				if(armour > 1.0)
				{
					format(nametag, sizeof(nametag), "%s\n{FFFFFF}%s\n{FF0000}%s", nametag, GetArmorDots(playerid), GetHealthDots(playerid));
				}
				else
				{
					format(nametag, sizeof(nametag), "%s\n{FF0000}%s", nametag, GetHealthDots(playerid));
				}
			}
			UpdateDynamic3DTextLabelText(PlayerInfo[playerid][pNameTag], COLOR_WHITE, nametag);
		}
		else if(!IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))  
		{
			DestroyDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]);
			PlayerInfo[playerid][pNameTag] = INVALID_3DTEXT_ID;
			PlayerInfo[playerid][pNameTag] = CreateDynamic3DTextLabel("", 0xFFFFFFFF, 0.0, 0.0, 0.1, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);
		}
	}
    return 1;
}

hook OnPlayerConnect(playerid) {
	if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))
        DestroyDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]);
    PlayerInfo[playerid][pNameTag] = CreateDynamic3DTextLabel("Loading nametag...", 0x008080FF, 0.0, 0.0, 0.1, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);
	myNameTagTimer[playerid] = repeat UpdateNameTagTimer(playerid);
	PlayerInfo[playerid][pMaskOn] = 0;
	return 1;
}
hook OnPlayerDisconnect(playerid, reason) {
    if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))
        DestroyDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]);
	PlayerInfo[playerid][pNameTag] = INVALID_3DTEXT_ID;
	if(myNameTagTimer[playerid] != Timer:-1)
	{
		stop myNameTagTimer[playerid];
    	myNameTagTimer[playerid] = Timer:-1;
	}
    return 1;
}

CMD:ispaused(playerid, params[])
{
	new
		targetid;

	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "Syntax: /ispaused [Player ID/Player Name/Part of Player Name]");
	if(!IsPlayerConnected(targetid) && targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "That player isn't connected!");

	switch(IsPlayerPaused(targetid))
	{
		case 0: SendClientMessage(playerid, -1, "Not-PAUSED!");
		case 1: SendClientMessage(playerid, -1, "PAUSED!");
	}

	return 1;
}

