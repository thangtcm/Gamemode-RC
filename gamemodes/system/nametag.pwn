
#include <YSI\YSI_Coding\y_hooks>
new Timer:myNameTagTimer[MAX_PLAYERS] = {Timer:-1, ...};

new TakeNameTagDMG[MAX_PLAYERS];

new IsPlayerAFK[MAX_PLAYERS];
new kickafk = 0;
new Float:PlayerPosii[MAX_PLAYERS][6];
new LastMove[MAX_PLAYERS];
new twominutestimer;
forward TwoMinutesTimer();

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	TakeNameTagDMG[playerid] = gettime() + 8;
	return 1;
}
hook OnGamemodeInt()
{
    twominutestimer = SetTimer("TwoMinutesTimer", 120000, true);
}   

CMD:togkickafk(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_RED, "Ban khong phai admin");
	if(kickafk == 1)
	{
	    kickafk = 0;
	    SendClientMessage(playerid,COLOR_WHITE,"Ban da tat AFK Kick.");
	    return 1;
	}
	else
	{
	    SendClientMessage(playerid,COLOR_WHITE,"Ban da tat AFK Kick.");
	    kickafk = 1;
	}
	return 1;
}

public TwoMinutesTimer()
{
    if(kickafk == 1)
	{
		new name[30],string[128];
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{				
				if(IsPlayerAFK[i] >= 1680)
				{
					SendClientMessage(i, COLOR_LIGHTRED, "Neu khong di chuyen ban se bi kick trong 2 phut toi nua.");
				}
				if(IsPlayerAFK[i] >= 1800)
				{
					SendClientMessage(i, COLOR_RED, "Ban da AFK qua lau va bi kick.");
					GetPlayerName(i, name, sizeof(name));
					format(string, sizeof(string),"%s da bi kick boi BOT vi AFK hon 30 phut.",name);
					SendClientMessageToAll(COLOR_LIGHTRED, string);
					new var100[300];
					KickEx(i);
				}									
			}
		}
	}
	return 1;
}

timer UpdateNameTagTimer[1000](playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    //CHECK AFK			
		GetPlayerPos(playerid, PlayerPosii[playerid][0], PlayerPosii[playerid][1], PlayerPosii[playerid][2]);
		if(PlayerPosii[playerid][0] == PlayerPosii[playerid][3] && PlayerPosii[playerid][1] == PlayerPosii[playerid][4] && PlayerPosii[playerid][2] == PlayerPosii[playerid][5])
		{
			if(LastMove[playerid] >= 30)
			{
				IsPlayerAFK[playerid]++;
			}
			else
			{
				LastMove[playerid]++;
			}
		}
		else
		{
			IsPlayerAFK[playerid] = 0;
			LastMove[playerid] = 0;
		}
		PlayerPosii[playerid][3] = PlayerPosii[playerid][0];
		PlayerPosii[playerid][4] = PlayerPosii[playerid][1];
		PlayerPosii[playerid][5] = PlayerPosii[playerid][2];
	
		if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))
		{
			new nametag[388];
			if(IsPlayerAFK[playerid] > 0)
			{
			    if(PlayerInfo[playerid][pMaskOn])
				{
					format(nametag, sizeof(nametag), "{f53636}[AFK - %d giay]{FFFFFF} Mask %d%d{FFFFFF} (%d)",  IsPlayerAFK[playerid], PlayerInfo[playerid][pMaskID][0], playerid, playerid);
				}
				else
				{
					format(nametag, sizeof(nametag), "{f53636}[AFK - %d giay]{FFFFFF} %s{FFFFFF} (%d)", IsPlayerAFK[playerid], GetPlayerNameEx(playerid), playerid);
				}
			}
			else
			{
				if(PlayerInfo[playerid][pMaskOn])
				{
					format(nametag, sizeof(nametag), "Mask %d%d{FFFFFF} (%d)", PlayerInfo[playerid][pMaskID][0], playerid, playerid);
				}
				else
				{
					format(nametag, sizeof(nametag), "%s{FFFFFF} (%d)", GetPlayerNameEx(playerid), playerid);
				}
			}
			if(gettime() < TakeNameTagDMG[playerid]) 
			{
				nametag[0] = EOS;
				if(PlayerInfo[playerid][pMaskOn])
				{
					format(nametag, sizeof(nametag), "{C32C37}Mask %d%d (%d)", PlayerInfo[playerid][pMaskID][0], playerid, playerid);
				}
				else
				{
					format(nametag, sizeof(nametag), "{C32C37}%s (%d)", GetPlayerNameEx(playerid), playerid);
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
	TakeNameTagDMG[playerid] = 0;
	PlayerInfo[playerid][pDarkAFK] = 0;
	IsPlayerAFK[playerid] = 0;
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

