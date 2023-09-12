
new PlayerText:CharacterMain[MAX_PLAYERS][7];
new PlayerText:Characterexist[MAX_PLAYERS][4];
new PlayerText:Characternotexist[MAX_PLAYERS][4];
new PlayerText:NameCharacter[MAX_PLAYERS][4];
stock ShowPlayerCharacter(playerid) {
	for(new i = 0 ; i < 4 ; i++) {
    	if (!TempCharacter[playerid][i][IsCreated]) {

    		PlayerTextDrawHide(playerid, NameCharacter[playerid][i]);
    		PlayerTextDrawHide(playerid, Characterexist[playerid][i]);
    		PlayerTextDrawShow(playerid, Characternotexist[playerid][i]);
    	}
    	else
    	{
    	    PlayerTextDrawSetString(playerid, NameCharacter[playerid][i], TempCharacter[playerid][i][Name]);
    		PlayerTextDrawSetPreviewModel(playerid, Characterexist[playerid][i], TempCharacter[playerid][i][Skin]);
    		PlayerTextDrawSetPreviewRot(playerid, Characterexist[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
    		PlayerTextDrawShow(playerid, NameCharacter[playerid][i]);
    		PlayerTextDrawShow(playerid, Characterexist[playerid][i]);
    	}
	}
	SetPlayerCameraPos(playerid, 2301.3403, -1301.3948, 52.4688);
	SetPlayerCameraLookAt(playerid, 2300.3408, -1301.4949, 52.1188);
	SetPlayerPos(playerid, 2234.2881,-1329.2982,24.5313);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][0]);
//	PlayerTextDrawShow(playerid, CharacterMain[playerid][1]);
	//PlayerTextDrawShow(playerid, CharacterMain[playerid][2]);
	SelectTextDraw(playerid, COLOR_LIGHTRED);
	SetPVarInt(playerid,"TextDrawCharacter",1);
	return 1;
}
stock HideTDCharacter(playerid) {
	for(new i = 0 ; i <  4 ; i++) {
		PlayerTextDrawHide(playerid, Characterexist[playerid][i]);
		PlayerTextDrawHide(playerid, Characternotexist[playerid][i]);
		PlayerTextDrawHide(playerid, NameCharacter[playerid][i]);
	}
	PlayerTextDrawHide(playerid, CharacterMain[playerid][0]);
	PlayerTextDrawHide(playerid, CharacterMain[playerid][1]);
	PlayerTextDrawHide(playerid, CharacterMain[playerid][2]);
	PlayerTextDrawHide(playerid, CharacterMain[playerid][3]);
	PlayerTextDrawHide(playerid, CharacterMain[playerid][4]);
    PlayerTextDrawHide(playerid, CharacterMain[playerid][5]);
	PlayerTextDrawHide(playerid, CharacterMain[playerid][6]);
	return 1;
}
stock ShowInfoCharacter(playerid,i) {
	new string[129];
	format(string, sizeof string, "Ten_tai_khoan: ~y~%s", TempCharacter[playerid][i][Name]);
	PlayerTextDrawSetString(playerid,CharacterMain[playerid][3],string);
	format(string, sizeof string, "Cap do: ~y~%d", TempCharacter[playerid][i][Lv]);
	PlayerTextDrawSetString(playerid,CharacterMain[playerid][4],string);
	format(string, sizeof string, "Cong viec: ~y~%s", GetJobName(TempCharacter[playerid][i][Job]));
	PlayerTextDrawSetString(playerid,CharacterMain[playerid][5],string);
	new zone[MAX_ZONE_NAME];
	Get3DZone(TempCharacter[playerid][i][SPos_x],TempCharacter[playerid][i][SPos_y],TempCharacter[playerid][i][SPos_z], zone, sizeof(zone));
	format(string, sizeof string, "Vi tri cuoi cung: ~y~%s", zone);
	PlayerTextDrawSetString(playerid,CharacterMain[playerid][6],string);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][1]);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][2]);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][3]);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][4]);
    PlayerTextDrawShow(playerid, CharacterMain[playerid][5]);
	PlayerTextDrawShow(playerid, CharacterMain[playerid][6]);
	return 1;

}
// click

stock LoadCharacterTD(playerid) {
CharacterMain[playerid][0] = CreatePlayerTextDraw(playerid, 158.177169, 59.533329, "mdl-2017:main");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][0], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterMain[playerid][0], 328.000000, 223.000000);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][0], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][0], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][0], 0);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][0], 0);

CharacterMain[playerid][1] = CreatePlayerTextDraw(playerid, 239.594375, 239.466598, "mdl-2017:main_tt");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][1], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterMain[playerid][1], 176.000000, 82.000000);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][1], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][1], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][1], 0);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][1], 0);


CharacterMain[playerid][2] = CreatePlayerTextDraw(playerid, 293.043029, 300.200042, "mdl-2017:vaogame");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][2], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterMain[playerid][2], 69.000000, 32.000000);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][2], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][2], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawSetSelectable(playerid, CharacterMain[playerid][2], true);


CharacterMain[playerid][3] = CreatePlayerTextDraw(playerid, 244.322082, 251.833221, "Ten_tai_khoan:cuozg_cuozg_cuozg_cuozg");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][3], 0.148404, 1.209166);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][3], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][3], 0);

CharacterMain[playerid][4] = CreatePlayerTextDraw(playerid, 244.427566, 263.899902, "Cap_do:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][4], 0.148404, 1.209166);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][4], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][4], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][4], 0);

CharacterMain[playerid][5] = CreatePlayerTextDraw(playerid, 244.433044, 275.383270, "Cong_viec:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][5], 0.148404, 1.209166);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][5], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][5], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][5], 0);

CharacterMain[playerid][6] = CreatePlayerTextDraw(playerid, 244.701553, 286.916564, "Vi_tri_cuoi_cung:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][6], 0.148404, 1.209166);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][6], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][6], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][6], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][6], 0);

Characternotexist[playerid][0] = CreatePlayerTextDraw(playerid, 176.449508, 122.333374, "mdl-2017:click_character");
PlayerTextDrawLetterSize(playerid, Characternotexist[playerid][0], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characternotexist[playerid][0], 67.000000, 96.000000);
PlayerTextDrawAlignment(playerid, Characternotexist[playerid][0], 1);
PlayerTextDrawColor(playerid, Characternotexist[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, Characternotexist[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Characternotexist[playerid][0], 255);
PlayerTextDrawFont(playerid, Characternotexist[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, Characternotexist[playerid][0], 0);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, Characternotexist[playerid][0], true);

Characternotexist[playerid][1] = CreatePlayerTextDraw(playerid, 253.497955, 97.566749, "mdl-2017:click_character");
PlayerTextDrawLetterSize(playerid, Characternotexist[playerid][1], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characternotexist[playerid][1], 67.000000, 96.000000);
PlayerTextDrawAlignment(playerid, Characternotexist[playerid][1], 1);
PlayerTextDrawColor(playerid, Characternotexist[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, Characternotexist[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Characternotexist[playerid][1], 255);
PlayerTextDrawFont(playerid, Characternotexist[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, Characternotexist[playerid][1], 0);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][1], 0);
PlayerTextDrawSetSelectable(playerid, Characternotexist[playerid][1], true);

Characternotexist[playerid][2] = CreatePlayerTextDraw(playerid, 330.223449, 96.816741, "mdl-2017:click_character");
PlayerTextDrawLetterSize(playerid, Characternotexist[playerid][2], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characternotexist[playerid][2], 67.000000, 95.000000);
PlayerTextDrawAlignment(playerid, Characternotexist[playerid][2], 1);
PlayerTextDrawColor(playerid, Characternotexist[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, Characternotexist[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Characternotexist[playerid][2], 255);
PlayerTextDrawFont(playerid, Characternotexist[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, Characternotexist[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][2], 0);
PlayerTextDrawSetSelectable(playerid, Characternotexist[playerid][2], true);

Characternotexist[playerid][3] = CreatePlayerTextDraw(playerid, 409.757293, 120.733413, "mdl-2017:click_character");
PlayerTextDrawLetterSize(playerid, Characternotexist[playerid][3], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characternotexist[playerid][3], 67.000000, 95.000000);
PlayerTextDrawAlignment(playerid, Characternotexist[playerid][3], 1);
PlayerTextDrawColor(playerid, Characternotexist[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, Characternotexist[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Characternotexist[playerid][3], 255);
PlayerTextDrawFont(playerid, Characternotexist[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, Characternotexist[playerid][3], 0);
PlayerTextDrawSetShadow(playerid, Characternotexist[playerid][3], 0);
PlayerTextDrawSetSelectable(playerid, Characternotexist[playerid][3], true);

NameCharacter[playerid][0] = CreatePlayerTextDraw(playerid, 197.232818, 231.800018, "cuozg_nguyen_van");
PlayerTextDrawLetterSize(playerid, NameCharacter[playerid][0], 0.129663, 1.296666);
PlayerTextDrawAlignment(playerid, NameCharacter[playerid][0], 2);
PlayerTextDrawColor(playerid, NameCharacter[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, NameCharacter[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, NameCharacter[playerid][0], 255);
PlayerTextDrawFont(playerid, NameCharacter[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, NameCharacter[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][0], 0);

NameCharacter[playerid][1] = CreatePlayerTextDraw(playerid, 276.881408, 207.900054, "cuozg_nguyen_van");
PlayerTextDrawLetterSize(playerid, NameCharacter[playerid][1], 0.129663, 1.296666);
PlayerTextDrawAlignment(playerid, NameCharacter[playerid][1], 2);
PlayerTextDrawColor(playerid, NameCharacter[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, NameCharacter[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, NameCharacter[playerid][1], 255);
PlayerTextDrawFont(playerid, NameCharacter[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, NameCharacter[playerid][1], 1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][1], 0);

NameCharacter[playerid][2] = CreatePlayerTextDraw(playerid, 372.459960, 207.499984, "cuozg_nguyen_van");
PlayerTextDrawLetterSize(playerid, NameCharacter[playerid][2], 0.129663, 1.296666);
PlayerTextDrawAlignment(playerid, NameCharacter[playerid][2], 2);
PlayerTextDrawColor(playerid, NameCharacter[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, NameCharacter[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, NameCharacter[playerid][2], 255);
PlayerTextDrawFont(playerid, NameCharacter[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, NameCharacter[playerid][2], 1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][2], 0);

NameCharacter[playerid][3] = CreatePlayerTextDraw(playerid, 453.282897, 232.583297, "cuozg");
PlayerTextDrawLetterSize(playerid, NameCharacter[playerid][3], 0.129663, 1.296666);
PlayerTextDrawAlignment(playerid, NameCharacter[playerid][3], 2);
PlayerTextDrawColor(playerid, NameCharacter[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, NameCharacter[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, NameCharacter[playerid][3], 255);
PlayerTextDrawFont(playerid, NameCharacter[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, NameCharacter[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, NameCharacter[playerid][3], 0);


Characterexist[playerid][0] = CreatePlayerTextDraw(playerid, 142.715972, 90.833343, "");
PlayerTextDrawLetterSize(playerid, Characterexist[playerid][0], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characterexist[playerid][0], 132.000000, 129.000000);
PlayerTextDrawAlignment(playerid, Characterexist[playerid][0], 1);
PlayerTextDrawColor(playerid, Characterexist[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawFont(playerid, Characterexist[playerid][0], 5);
PlayerTextDrawSetProportional(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawSetPreviewModel(playerid, Characterexist[playerid][0], 0);
PlayerTextDrawSetPreviewRot(playerid, Characterexist[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid, Characterexist[playerid][0], true);

Characterexist[playerid][1] = CreatePlayerTextDraw(playerid, 219.084915, 75.083305, "");
PlayerTextDrawLetterSize(playerid, Characterexist[playerid][1], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characterexist[playerid][1], 132.000000, 129.000000);
PlayerTextDrawAlignment(playerid, Characterexist[playerid][1], 1);
PlayerTextDrawColor(playerid, Characterexist[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawFont(playerid, Characterexist[playerid][1], 5);
PlayerTextDrawSetProportional(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawSetPreviewModel(playerid, Characterexist[playerid][1], 0);
PlayerTextDrawSetPreviewRot(playerid, Characterexist[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid, Characterexist[playerid][1], true);

Characterexist[playerid][2] = CreatePlayerTextDraw(playerid, 298.733825, 73.333312, "");
PlayerTextDrawLetterSize(playerid, Characterexist[playerid][2], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characterexist[playerid][2], 132.000000, 129.000000);
PlayerTextDrawAlignment(playerid, Characterexist[playerid][2], 1);
PlayerTextDrawColor(playerid, Characterexist[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawFont(playerid, Characterexist[playerid][2], 5);
PlayerTextDrawSetProportional(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawSetPreviewModel(playerid, Characterexist[playerid][2], 0);
PlayerTextDrawSetPreviewRot(playerid, Characterexist[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid, Characterexist[playerid][2], true);

Characterexist[playerid][3] = CreatePlayerTextDraw(playerid, 378.851135, 93.166656, "");
PlayerTextDrawLetterSize(playerid, Characterexist[playerid][3], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, Characterexist[playerid][3], 132.000000, 129.000000);
PlayerTextDrawAlignment(playerid, Characterexist[playerid][3], 1);
PlayerTextDrawColor(playerid, Characterexist[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawFont(playerid, Characterexist[playerid][3], 5);
PlayerTextDrawSetProportional(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawSetShadow(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawSetPreviewModel(playerid, Characterexist[playerid][3], 0);
PlayerTextDrawSetPreviewRot(playerid, Characterexist[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);
PlayerTextDrawSetSelectable(playerid, Characterexist[playerid][3], true);

}