

#include <a_samp>
#include <YSI\y_hooks>


//new Text3D:cNametag[MAX_PLAYERS];
new Text3D:Player3DText[MAX_PLAYERS];
GetHealthDots(playerid)
{
    new
        dots[64], Float: HP;

    GetPlayerHealth(playerid, HP);

    if(HP >= 100)
        dots = "";
    else if(HP >= 90)
        dots = "{660000}";
    else if(HP >= 80)
        dots = "{660000}";
    else if(HP >= 70)
        dots = "{660000}";
    else if(HP >= 60)
        dots = "{660000}";
    else if(HP >= 50)
        dots = "{660000}";
    else if(HP >= 40)
        dots = "{660000}";
    else if(HP >= 30)
        dots = "{660000}";
    else if(HP >= 20)
        dots = "{660000}";
    else if(HP >= 10)
        dots = "{660000}";
    else if(HP >= 0)
        dots = "{660000}";

    return dots;
}

GetArmorDots(playerid)
{
    new
        dots[64], Float: AR;

    GetPlayerArmour(playerid, AR);

    if(AR >= 100)
        dots = "";
    else if(AR >= 90)
        dots = "{666666}";
    else if(AR >= 80)
        dots = "{666666}";
    else if(AR >= 70)
        dots = "{666666}";
    else if(AR >= 60)
        dots = "{666666}";
    else if(AR >= 50)
        dots = "{666666}";
    else if(AR >= 40)
        dots = "{666666}";
    else if(AR >= 30)
        dots = "{666666}";
    else if(AR >= 20)
        dots = "{666666}";
    else if(AR >= 10)
        dots = "{666666}";
    else if(AR >= 0)
        dots = "{666666}";

    return dots;
}
forward UpdateNametag();
public UpdateNametag()
{
    for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
    {
        if(IsPlayerConnected(i))
        {
            new nametag[128], playername[MAX_PLAYER_NAME], Float:armour;
            GetPlayerArmour(i, armour);
            GetPlayerName(i, playername, sizeof(playername));
            if(GetPVarInt(i, "NameTagTime") <= gettime())
            {
            	if(armour > 1.0)
            	{
               	    format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i);
            	}
           	 	else
            	{
                	format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i);
           		}
           		if(playerAFK[i] != 0)
           		{
           			if(armour > 1.0)
            		{
               	    	format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8,GetPlayerNameEx(i), i);
            		}
            		else
            		{
                		format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8,GetPlayerNameEx(i), i);
           			}
           		}
            }
            else if(GetPVarInt(i, "NameTagTime") > gettime())
            {
                if(armour > 1.0)
                {
                    format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF} (%i)\n{FFFFFF}%s\n{FF0000}%s", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i, GetArmorDots(i), GetHealthDots(i));
                }
                else
                {
                    format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF} (%i)\n{FF0000}%s", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i, GetHealthDots(i));
                }
                if(playerAFK[i] != 0)
           		{
           			if(armour > 1.0)
            		{
               	    	format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s {FFFFFF} (%i)\n{FFFFFF}%s\n{FF0000}%s", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i, GetArmorDots(i), GetHealthDots(i));
            		}
           	 		else
            		{
                		format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s {FFFFFF} (%i)\n{FF0000}%s", GetPlayerColor(i) >>> 8, GetPlayerNameEx(i), i, GetHealthDots(i));
           			}
           		}
            }
            else if(PlayerInfo[i][pAdmin] >= 1)
            {
                if(armour > 1.0)
                {
                    format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8, PlayerInfo[i][pNameCode], i);
                }
                else
                {
                    format(nametag, sizeof(nametag), "{%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8, PlayerInfo[i][pNameCode], i);
                }
                if(playerAFK[i] != 0)
                {
                    if(armour > 1.0)
                    {
                        format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8,GetPlayerNameEx(i), i);
                    }
                    else
                    {
                        format(nametag, sizeof(nametag), "{F81414}[AFK]{FFFFFF} {%06x}%s{FFFFFF} (%i)", GetPlayerColor(i) >>> 8,GetPlayerNameEx(i), i);
                    }
                }
            }
   //         UpdateDynamic3DTextLabelText(cNametag[i], 0xFFFFFFFF, nametag);
            Update3DTextLabelText( Player3DText[i], 0xFFFFFFFF, nametag);
        }
    }
    return 1;
}
hook OnPlayerUpdate(playerid) {
	UpdateNametag();
}

hook OnPlayerConnect(playerid) {
    Player3DText[playerid] = Create3DTextLabel("LoadingNameTag", 0x008080FF, 0.0, 0.0, 0.1, 40.0,GetPlayerVirtualWorld(playerid));
    Attach3DTextLabelToPlayer(Player3DText[playerid], playerid, 0.0, 0.0, 0.1);
	
}
hook OnPlayerDisconnect(playerid, reason) {
    
    Delete3DTextLabel(  Player3DText[playerid] );
	//if(IsValidDynamic3DTextLabel(cNametag[playerid]))
   //     DestroyDynamic3DTextLabel(cNametag[playerid]);
}