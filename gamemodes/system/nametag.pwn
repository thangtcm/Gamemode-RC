

#include <a_samp>
#include <YSI_Coding\y_hooks>


//new Text3D:cNametag[MAX_PLAYERS];
// new Text3D:Player3DText[MAX_PLAYERS];
new PlayerNameTag[MAX_PLAYERS][MAX_PLAYERS][128];
new PlayerNameTagType[MAX_PLAYERS][MAX_PLAYERS];
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
timer UpdateNameTagTimer[500](playerid)
{
    foreach(new i: Player)
    {
        if(IsPlayerConnected(i))
        {
            new nametag[388], Float:armour, Float:targetPos[3], Float:distance, bool:Ischeck = false;
            GetPlayerArmour(i, armour);
			GetPlayerPos(i, targetPos[0], targetPos[1], targetPos[2]);
			distance = GetPlayerDistanceFromPoint(playerid, targetPos[0], targetPos[1], targetPos[2]);
			if(PlayerInfo[i][pMaskOn])
			{
				format(nametag, sizeof(nametag), "{%06x}[Mask %d_%d]{FFFFFF} (%d)", GetPlayerColor(i) >>> 8, PlayerInfo[i][pMaskID][0], PlayerInfo[i][pMaskID][1], i);
			}
			else if(distance > 6.0 && !PlayerInfo[i][pMaskOn])
			{
            	format(nametag, sizeof(nametag), "{%06x}Stranger_%d_%d{FFFFFF} (%d)", GetPlayerColor(i) >>> 8, PlayerInfo[i][pMaskID][0], PlayerInfo[i][pMaskID][1], i);
				Ischeck = true;
			}
			else if(distance <= 6.0 && !PlayerInfo[i][pMaskOn] && Ischeck == false)
			{
				format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%d)", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i);
			}
			if(playerAFK[i] != 0 && playerAFK[i] > 60)
			{
				format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} %s", nametag);
			}
			if(armour > 1.0)
			{
				format(nametag, sizeof(nametag), "%s\n{FFFFFF}%s\n{FF0000}%s", nametag, GetArmorDots(i), GetHealthDots(i));
			}
			else
			{
				format(nametag, sizeof(nametag), "%s\n{FF0000}%s", nametag, GetHealthDots(i));
			}
			UpdateDynamic3DTextLabelText(PlayerInfo[i][pNameTag], COLOR_WHITE, nametag);
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid) {
    PlayerInfo[playerid][pNameTag] = CreateDynamic3DTextLabel("Loading nametag...", 0x008080FF, 0.0, 0.0, 0.1, 25.0, .attachedplayer = playerid, .testlos = 1);
	myNameTagTimer[playerid] = repeat UpdateNameTagTimer(playerid);
	PlayerInfo[playerid][pMaskOn] = 0;
	return 1;
}
hook OnPlayerDisconnect(playerid, reason) {
    if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]))
        DestroyDynamic3DTextLabel(PlayerInfo[playerid][pNameTag]);

    stop myNameTagTimer[playerid];
    myNameTagTimer[playerid] = Timer:-1;
    return 1;
}