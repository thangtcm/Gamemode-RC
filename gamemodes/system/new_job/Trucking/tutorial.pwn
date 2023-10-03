#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
	LoadTutorialTruck(playerid);
    TutorialTruck_Timer[playerid] = -1;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i = 0 ; i < 6; i++)
		PlayerTextDrawDestroy(playerid, Tutorial_Truck[playerid][i]);
    KillTimer(TutorialTruck_Timer[playerid]);
	return 1;
}

stock LoadTutorialTruck(playerid)
{
    Tutorial_Truck[playerid][0] = CreatePlayerTextDraw(playerid, 400.000, 300.000, "_");
    PlayerTextDrawLetterSize(playerid, Tutorial_Truck[playerid][0], 0.870, 11.998);
    PlayerTextDrawTextSize(playerid, Tutorial_Truck[playerid][0], 89.000, 532.000);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][0], 2);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, Tutorial_Truck[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, Tutorial_Truck[playerid][0], 150);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][0], 1);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][0], 1);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][0], 150);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][0], 1);

    Tutorial_Truck[playerid][1] = CreatePlayerTextDraw(playerid, 19.000, 167.000, "_");
    PlayerTextDrawTextSize(playerid, Tutorial_Truck[playerid][1], 250.000, 250.000);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][1], 1);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][1], 0);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][1], 0);
    PlayerTextDrawSetPreviewModel(playerid, Tutorial_Truck[playerid][1], 133);
    PlayerTextDrawSetPreviewRot(playerid, Tutorial_Truck[playerid][1], 0.000, 0.000, 33.000, 1.000);
    PlayerTextDrawSetPreviewVehCol(playerid, Tutorial_Truck[playerid][1], 0, 0);

    Tutorial_Truck[playerid][2] = CreatePlayerTextDraw(playerid, 190.000, 300.000, "Tutorial");
    PlayerTextDrawLetterSize(playerid, Tutorial_Truck[playerid][2], 0.660, 2.599);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][2], 1);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][2], -764862721);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][2], 150);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][2], 2);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][2], 1);

    Tutorial_Truck[playerid][3] = CreatePlayerTextDraw(playerid, 194.000, 336.000, "Ong Chu:");
    PlayerTextDrawLetterSize(playerid, Tutorial_Truck[playerid][3], 0.400, 1.600);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][3], 1);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][3], 1);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][3], 150);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][3], 1);

    Tutorial_Truck[playerid][4] = CreatePlayerTextDraw(playerid, 197.000, 359.000, "Xin chao va chuc mung ban den voi Red County!~n~Toi la Mike, va toi da thay rang ban co the tro thanh mot tai xe xuat sac.");
    PlayerTextDrawLetterSize(playerid, Tutorial_Truck[playerid][4], 0.300, 1.498);
    PlayerTextDrawTextSize(playerid, Tutorial_Truck[playerid][4], 598.000, 178.000);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][4], 1);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][4], 1);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][4], 150);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][4], 1);

    Tutorial_Truck[playerid][5] = CreatePlayerTextDraw(playerid, 580.000, 388.000, "Bo qua");
    PlayerTextDrawLetterSize(playerid, Tutorial_Truck[playerid][5], 0.300, 1.500);
    PlayerTextDrawAlignment(playerid, Tutorial_Truck[playerid][5], 1);
    PlayerTextDrawColor(playerid, Tutorial_Truck[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, Tutorial_Truck[playerid][5], 1);
    PlayerTextDrawSetOutline(playerid, Tutorial_Truck[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, Tutorial_Truck[playerid][5], 255);
    PlayerTextDrawFont(playerid, Tutorial_Truck[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, Tutorial_Truck[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, Tutorial_Truck[playerid][5], 1);
}

stock ShowTutorialTruck(playerid, const header[], const message[])
{
    new string[5018], strHeader[128];
	format(string, sizeof(string), "%s", message); 
    format(strHeader, sizeof(strHeader), "%s", header);
    PlayerTextDrawSetString(playerid, Tutorial_Truck[playerid][2], strHeader);
    CreateTextdrawAnimation(playerid, Tutorial_Truck[playerid][4], 25, "~p~", string);
    SelectTextDraw(playerid, 0x7A342CFF);
    for(new i = 0 ; i < 6; i++)
		PlayerTextDrawShow(playerid, Tutorial_Truck[playerid][i]);
	return 1;
}

stock HideTutorialTruck(playerid)
{
    for(new i = 0 ; i < 6; i++)
		PlayerTextDrawHide(playerid, Tutorial_Truck[playerid][i]);
	return 1;
}
