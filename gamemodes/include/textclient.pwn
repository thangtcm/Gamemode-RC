#include <a_samp>
#include <YSI_Coding\y_hooks>

new SendClientText[MAX_PLAYERS];
new PlayerText:ClientText[MAX_PLAYERS][1];

hook OnPlayerConnect(playerid)
{
ClientText[playerid][0] = CreatePlayerTextDraw(playerid, 318.500000, 388.333404, "");
PlayerTextDrawLetterSize(playerid, ClientText[playerid][0], 0.230499, 1.494999);
PlayerTextDrawAlignment(playerid, ClientText[playerid][0], 2);
PlayerTextDrawColor(playerid, ClientText[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, ClientText[playerid][0], 1);
PlayerTextDrawSetOutline(playerid, ClientText[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, ClientText[playerid][0], 255);
PlayerTextDrawFont(playerid, ClientText[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, ClientText[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, ClientText[playerid][0], 1);

}

stock SendClientTextDraw(playerid, text[],time=0)
{
    if(GetPVarInt(playerid, "IsShowText") == 1) KillTimer(SendClientText[playerid]);
    PlayerTextDrawSetString(playerid,  ClientText[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientText[playerid][0]);
    SendClientText[playerid] = SetTimerEx("ClosedClientText", time*1000, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowText", 1);
    return 1;
}
forward ClosedClientText(playerid);
public ClosedClientText(playerid)
{
    PlayerTextDrawHide(playerid, ClientText[playerid][0]);
    DeletePVar(playerid, "IsShowText");
    return 1;
}

CMD:testcl(playerid,params[]) return SendClientTextDraw(playerid,"Ban khong adfsadsadsa");