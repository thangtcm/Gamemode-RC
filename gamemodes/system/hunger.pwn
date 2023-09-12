new PlayerText:Hunger_Bar[MAX_PLAYERS][6];

stock HienThiHunger(playerid) {
	new Float:size;
	size = PlayerInfo[playerid][pDoiBung] * 1.02;
	PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][1], 21.000000 + size, 0.000000);
	size = PlayerInfo[playerid][pKhatNuoc] * 1.02;
	PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][3], 21.000000 + size, 0.000000);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][0]);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][1]);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][2]);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][3]);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][4]);
	PlayerTextDrawShow(playerid, Hunger_Bar[playerid][5]);

	return 1;
}

LoadTextDrawDoiKhat(playerid) {

Hunger_Bar[playerid][0] = CreatePlayerTextDraw(playerid, 24.348484, 425.400054, "box");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][0], 0.000000, 0.254759);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][0], 123.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][0], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][0], -1);
PlayerTextDrawUseBox(playerid, Hunger_Bar[playerid][0], 1);
PlayerTextDrawBoxColor(playerid, Hunger_Bar[playerid][0], -4098642);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][0], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][0], 0);

Hunger_Bar[playerid][1] = CreatePlayerTextDraw(playerid, 24.348484, 425.400054, "box");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][1], 0.000000, 0.254759);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][1], 21.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][1], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][1], -1);
PlayerTextDrawUseBox(playerid, Hunger_Bar[playerid][1], 1);
PlayerTextDrawBoxColor(playerid, Hunger_Bar[playerid][1], -5963521);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][1], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][1], 1);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][1], 0);

Hunger_Bar[playerid][2] = CreatePlayerTextDraw(playerid, 24.348484, 437.784118, "box");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][2], 0.000000, 0.254759);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][2], 123.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][2], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][2], -1);
PlayerTextDrawUseBox(playerid, Hunger_Bar[playerid][2], 1);
PlayerTextDrawBoxColor(playerid, Hunger_Bar[playerid][2], -539426870);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][2], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][2], 1);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][2], 0);

Hunger_Bar[playerid][3] = CreatePlayerTextDraw(playerid, 24.148483, 437.700805, "box");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][3], 0.000000, 0.254759);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][3], 25.799999, 0.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][3], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][3], -1);
PlayerTextDrawUseBox(playerid, Hunger_Bar[playerid][3], 1);
PlayerTextDrawBoxColor(playerid, Hunger_Bar[playerid][3], 161087487);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][3], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][3], 0);

	
Hunger_Bar[playerid][4] = CreatePlayerTextDraw(playerid, 13.130043, 431.083343, "hud:radar_diner");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][4], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][4], 13.000000, 12.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][4], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][4], 161085951);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][4], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][4], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][4], 0);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][4], 0);

Hunger_Bar[playerid][5] = CreatePlayerTextDraw(playerid, 15.561532, 419.050048, "HUD:radar_burgerShot");
PlayerTextDrawLetterSize(playerid, Hunger_Bar[playerid][5], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Hunger_Bar[playerid][5], 9.000000, 14.000000);
PlayerTextDrawAlignment(playerid, Hunger_Bar[playerid][5], 1);
PlayerTextDrawColor(playerid, Hunger_Bar[playerid][5], -5963521);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][5], 0);
PlayerTextDrawSetOutline(playerid, Hunger_Bar[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, Hunger_Bar[playerid][5], 255);
PlayerTextDrawFont(playerid, Hunger_Bar[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, Hunger_Bar[playerid][5], 0);
PlayerTextDrawSetShadow(playerid, Hunger_Bar[playerid][5], 0);


}
