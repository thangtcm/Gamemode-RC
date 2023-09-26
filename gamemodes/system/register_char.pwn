#include <YSI\y_hooks>

new PlayerText: RegCharacter[MAX_PLAYERS][9];

hook OnPlayerConnect(playerid)
{
	RegCharacter[playerid][0] = CreatePlayerTextDraw(playerid, -0.500, -0.500, "mdl-3001:char-main");
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][0], 641.000, 449.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][0], 1);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][0], 255);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][0], 1);

	RegCharacter[playerid][1] = CreatePlayerTextDraw(playerid, 507.000, 178.000, "-----");
	PlayerTextDrawLetterSize(playerid, RegCharacter[playerid][1], 0.200, 1.399);
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][1], 17.000, 71.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][1], 2);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][1], 150);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][1], 1);

	RegCharacter[playerid][2] = CreatePlayerTextDraw(playerid, 507.000, 227.000, "-----");
	PlayerTextDrawLetterSize(playerid, RegCharacter[playerid][2], 0.200, 1.399);
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][2], 17.000, 71.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][2], 2);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][2], 150);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][2], 1);

	RegCharacter[playerid][3] = CreatePlayerTextDraw(playerid, 507.000, 275.000, "-----");
	PlayerTextDrawLetterSize(playerid, RegCharacter[playerid][3], 0.200, 1.399);
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][3], 17.000, 71.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][3], 2);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][3], 150);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][3], 1);

	RegCharacter[playerid][4] = CreatePlayerTextDraw(playerid, 467.000, 97.000, "Stanley Taellious");
	PlayerTextDrawLetterSize(playerid, RegCharacter[playerid][4], 0.240, 1.599);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][4], 2);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][4], 150);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][4], 1);

	RegCharacter[playerid][5] = CreatePlayerTextDraw(playerid, 421.500, 320.500, "mdl-3001:char-batdau");
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][5], 95.000, 41.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][5], 1);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][5], 255);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][5], 1);

	RegCharacter[playerid][6] = CreatePlayerTextDraw(playerid, -1.000, 45.000, "_");
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][6], 333.000, 362.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][6], 1);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][6], 0);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, RegCharacter[playerid][6], 1);
	PlayerTextDrawSetPreviewRot(playerid, RegCharacter[playerid][6], 0.000, 0.000, 0.000, 1.000);
	PlayerTextDrawSetPreviewVehCol(playerid, RegCharacter[playerid][6], 0, 0);

	RegCharacter[playerid][7] = CreatePlayerTextDraw(playerid, 222.500, 220.500, "mdl-3001:char-right");
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][7], 49.000, 56.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][7], 1);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][7], 255);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][7], 1);

	RegCharacter[playerid][8] = CreatePlayerTextDraw(playerid, 60.500, 220.500, "mdl-3001:char-left");
	PlayerTextDrawTextSize(playerid, RegCharacter[playerid][8], 49.000, 56.000);
	PlayerTextDrawAlignment(playerid, RegCharacter[playerid][8], 1);
	PlayerTextDrawColor(playerid, RegCharacter[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, RegCharacter[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, RegCharacter[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, RegCharacter[playerid][8], 255);
	PlayerTextDrawFont(playerid, RegCharacter[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, RegCharacter[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, RegCharacter[playerid][8], 1);
	return 1;
}

stock ShowRegCharTD(playerid) {
	ChangeSkin[playerid] = 1;
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	PlayerTextDrawSetString(playerid, RegCharacter[playerid][4], name);
    for(new i = 0 ; i < 9 ; i++)
    {
    	PlayerTextDrawShow(playerid, RegCharacter[playerid][i]);
    }
    SelectTextDraw(playerid, COLOR_LIGHTRED);
    return 1;
}
stock HideRegCharTD(playerid) {
    for(new i = 0 ; i < 9 ; i++)
    {
    	PlayerTextDrawHide(playerid, RegCharacter[playerid][i]);
    }
    CancelSelectTextDraw(playerid);
    return 1;
}