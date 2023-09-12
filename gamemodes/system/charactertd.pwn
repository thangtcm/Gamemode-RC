//Player TextDraws: 

//Player TextDraws: 


new Text:ButtonCharacter[2];
new PlayerText:CharacterMain[MAX_PLAYERS][7];

new PlayerText:CharacterButton[MAX_PLAYERS][4];
new PlayerText:CharacterName[MAX_PLAYERS][4];
stock LoadBTNC() {
ButtonCharacter[0] = TextDrawCreate(193.953155, 297.333343, "box");
TextDrawLetterSize(ButtonCharacter[0], 0.000000, 1.426063);
TextDrawTextSize(ButtonCharacter[0], 253.000000, 0.000000);
TextDrawAlignment(ButtonCharacter[0], 1);
TextDrawColor(ButtonCharacter[0], -1);
TextDrawUseBox(ButtonCharacter[0], 1);
TextDrawBoxColor(ButtonCharacter[0], -2139062110);
TextDrawSetShadow(ButtonCharacter[0], 0);
TextDrawSetOutline(ButtonCharacter[0], 0);
TextDrawBackgroundColor(ButtonCharacter[0], 255);
TextDrawFont(ButtonCharacter[0], 1);
TextDrawSetProportional(ButtonCharacter[0], 1);
TextDrawSetShadow(ButtonCharacter[0], 0);

ButtonCharacter[1] = TextDrawCreate(201.117919, 298.433380, "Vao_game");
TextDrawLetterSize(ButtonCharacter[1], 0.257100, 1.144999);
TextDrawAlignment(ButtonCharacter[1], 1);
TextDrawColor(ButtonCharacter[1], 255);
TextDrawSetShadow(ButtonCharacter[1], 0);
TextDrawSetOutline(ButtonCharacter[1], 0);
TextDrawBackgroundColor(ButtonCharacter[1], 255);
TextDrawFont(ButtonCharacter[1], 1);
TextDrawSetProportional(ButtonCharacter[1], 1);
TextDrawSetShadow(ButtonCharacter[1], 0);
TextDrawSetSelectable(ButtonCharacter[1], true);

}
stock LoadCharacterTD(playerid) {

CharacterMain[playerid][0] = CreatePlayerTextDraw(playerid, 189.736480, 139.833328, "box");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][0], 0.000000, 21.713029);
PlayerTextDrawTextSize(playerid, CharacterMain[playerid][0], 469.000000, 0.000000);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][0], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][0], -1);
PlayerTextDrawUseBox(playerid, CharacterMain[playerid][0], 1);
PlayerTextDrawBoxColor(playerid, CharacterMain[playerid][0], -1061109584);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][0], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][0], 0);

CharacterMain[playerid][1] = CreatePlayerTextDraw(playerid, 312.020538, 139.833389, "Nhan_vat");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][1], 0.277247, 1.302499);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][1], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][1], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][1], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][1], 0);

CharacterMain[playerid][2] = CreatePlayerTextDraw(playerid, 330.292968, 280.416656, "box");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][2], 0.000000, 5.549049);
PlayerTextDrawTextSize(playerid, CharacterMain[playerid][2], 447.000000, 0.000000);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][2], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][2], -1);
PlayerTextDrawUseBox(playerid, CharacterMain[playerid][2], 1);
PlayerTextDrawBoxColor(playerid, CharacterMain[playerid][2], 128);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][2], 95);
PlayerTextDrawFont(playerid, CharacterMain[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][2], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][2], 0);

CharacterMain[playerid][3] = CreatePlayerTextDraw(playerid, 331.698211, 279.250030, "Ten_nhan_vat:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][3], 0.228052, 1.325832);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][3], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][3], 0);

CharacterMain[playerid][4] = CreatePlayerTextDraw(playerid, 332.166748, 290.600219, "Level:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][4], 0.228052, 1.325832);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][4], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][4], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][4], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][4], 0);

CharacterMain[playerid][5] = CreatePlayerTextDraw(playerid, 332.503723, 303.283477, "Cong_viec:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][5], 0.228052, 1.325832);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][5], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][5], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][5], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][5], 0);

CharacterMain[playerid][6] = CreatePlayerTextDraw(playerid, 332.503662, 316.433563, "Gioi_da_choi:");
PlayerTextDrawLetterSize(playerid, CharacterMain[playerid][6], 0.228052, 1.325832);
PlayerTextDrawAlignment(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawColor(playerid, CharacterMain[playerid][6], -1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][6], 0);
PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][6], 255);
PlayerTextDrawFont(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][6], 1);
PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][6], 0);

CharacterName[playerid][0] = CreatePlayerTextDraw(playerid, 237.057067, 265.583374, "Cuozg_ng");
PlayerTextDrawLetterSize(playerid, CharacterName[playerid][0], 0.210248, 1.179998);
PlayerTextDrawAlignment(playerid, CharacterName[playerid][0], 2);
PlayerTextDrawColor(playerid, CharacterName[playerid][0], 255);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, CharacterName[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][0], 255);
PlayerTextDrawFont(playerid, CharacterName[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, CharacterName[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][0], 0);

CharacterName[playerid][1] = CreatePlayerTextDraw(playerid, 298.590911, 265.616821, "Chua_khoi_tao");
PlayerTextDrawLetterSize(playerid, CharacterName[playerid][1], 0.210248, 1.179998);
PlayerTextDrawAlignment(playerid, CharacterName[playerid][1], 2);
PlayerTextDrawColor(playerid, CharacterName[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, CharacterName[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][1], 255);
PlayerTextDrawFont(playerid, CharacterName[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, CharacterName[playerid][1], 1);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][1], 0);

CharacterName[playerid][2] = CreatePlayerTextDraw(playerid, 362.267517, 265.033508, "Chua_khoi_tao");
PlayerTextDrawLetterSize(playerid, CharacterName[playerid][2], 0.210248, 1.179998);
PlayerTextDrawAlignment(playerid, CharacterName[playerid][2], 2);
PlayerTextDrawColor(playerid, CharacterName[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, CharacterName[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][2], 255);
PlayerTextDrawFont(playerid, CharacterName[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, CharacterName[playerid][2], 1);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][2], 0);

CharacterName[playerid][3] = CreatePlayerTextDraw(playerid, 421.638275, 265.033538, "Chua_khoi_tao");
PlayerTextDrawLetterSize(playerid, CharacterName[playerid][3], 0.210248, 1.179998);
PlayerTextDrawAlignment(playerid, CharacterName[playerid][3], 2);
PlayerTextDrawColor(playerid, CharacterName[playerid][3], 255);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, CharacterName[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][3], 255);
PlayerTextDrawFont(playerid, CharacterName[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, CharacterName[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, CharacterName[playerid][3], 0);


CharacterButton[playerid][0] = CreatePlayerTextDraw(playerid, 208.077423, 181.466705, "");
PlayerTextDrawLetterSize(playerid, CharacterButton[playerid][0], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterButton[playerid][0], 58.000000, 83.000000);
PlayerTextDrawAlignment(playerid, CharacterButton[playerid][0], 1);
PlayerTextDrawColor(playerid, CharacterButton[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, CharacterButton[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterButton[playerid][0], 105);
PlayerTextDrawFont(playerid, CharacterButton[playerid][0], 5);
PlayerTextDrawSetProportional(playerid, CharacterButton[playerid][0], 0);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, CharacterButton[playerid][0], true);
PlayerTextDrawSetPreviewModel(playerid, CharacterButton[playerid][0], 0);
PlayerTextDrawSetPreviewRot(playerid, CharacterButton[playerid][0], 0.000000, 0.000000, 0.000000, 0.800000);

CharacterButton[playerid][1] = CreatePlayerTextDraw(playerid, 269.379943, 182.250000, "");
PlayerTextDrawLetterSize(playerid, CharacterButton[playerid][1], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterButton[playerid][1], 58.000000, 83.000000);
PlayerTextDrawAlignment(playerid, CharacterButton[playerid][1], 1);
PlayerTextDrawColor(playerid, CharacterButton[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, CharacterButton[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterButton[playerid][1], 76);
PlayerTextDrawFont(playerid, CharacterButton[playerid][1], 5);
PlayerTextDrawSetProportional(playerid, CharacterButton[playerid][1], 0);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][1], 0);
PlayerTextDrawSetSelectable(playerid, CharacterButton[playerid][1], true);
PlayerTextDrawSetPreviewModel(playerid, CharacterButton[playerid][1], 0);
PlayerTextDrawSetPreviewRot(playerid, CharacterButton[playerid][1], 0.000000, 0.000000, 0.000000, 0.800000);

CharacterButton[playerid][2] = CreatePlayerTextDraw(playerid, 331.287750, 181.683181, "");
PlayerTextDrawLetterSize(playerid, CharacterButton[playerid][2], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterButton[playerid][2], 58.000000, 83.000000);
PlayerTextDrawAlignment(playerid, CharacterButton[playerid][2], 1);
PlayerTextDrawColor(playerid, CharacterButton[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, CharacterButton[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterButton[playerid][2], 76);
PlayerTextDrawFont(playerid, CharacterButton[playerid][2], 5);
PlayerTextDrawSetProportional(playerid, CharacterButton[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][2], 0);
PlayerTextDrawSetSelectable(playerid, CharacterButton[playerid][2], true);
PlayerTextDrawSetPreviewModel(playerid, CharacterButton[playerid][2], 0);
PlayerTextDrawSetPreviewRot(playerid, CharacterButton[playerid][2], 0.000000, 0.000000, 0.000000, 0.800000);

CharacterButton[playerid][3] = CreatePlayerTextDraw(playerid, 391.889709, 181.516555, "");
PlayerTextDrawLetterSize(playerid, CharacterButton[playerid][3], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, CharacterButton[playerid][3], 58.000000, 83.000000);
PlayerTextDrawAlignment(playerid, CharacterButton[playerid][3], 1);
PlayerTextDrawColor(playerid, CharacterButton[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, CharacterButton[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, CharacterButton[playerid][3], 76);
PlayerTextDrawFont(playerid, CharacterButton[playerid][3], 5);
PlayerTextDrawSetProportional(playerid, CharacterButton[playerid][3], 0);
PlayerTextDrawSetShadow(playerid, CharacterButton[playerid][3], 0);
PlayerTextDrawSetSelectable(playerid, CharacterButton[playerid][3], true);
PlayerTextDrawSetPreviewModel(playerid, CharacterButton[playerid][3], 0);
PlayerTextDrawSetPreviewRot(playerid, CharacterButton[playerid][3], 0.000000, 0.000000, 0.000000, 0.800000);

}


stock ShowPlayerCharacter(playerid) {
    for(new i = 0 ; i < 4 ; i++) {
        if (TempCharacter[playerid][i][IsCreated]) {
            PlayerTextDrawSetString(playerid,CharacterName[playerid][i], TempCharacter[playerid][i][Name]);
            PlayerTextDrawSetPreviewModel(playerid, CharacterButton[playerid][i], TempCharacter[playerid][i][Skin]);
            PlayerTextDrawSetPreviewRot(playerid, CharacterButton[playerid][i], 0.000000, 0.000000, 0.000000, 0.800000);
        }
        else
        {
            PlayerTextDrawSetString(playerid,CharacterName[playerid][i], "Chua khoi tao");
        }
        PlayerTextDrawShow(playerid, CharacterButton[playerid][i]);
        PlayerTextDrawShow(playerid, CharacterName[playerid][i]);
    
    }
    SetPlayerCameraPos(playerid, 2301.3403, -1301.3948, 52.4688);
    SetPlayerCameraLookAt(playerid, 2300.3408, -1301.4949, 52.1188);
    SetPlayerPos(playerid, 2234.2881,-1329.2982,24.5313);
    PlayerTextDrawShow(playerid, CharacterMain[playerid][0]);
    PlayerTextDrawShow(playerid, CharacterMain[playerid][1]);
    SelectTextDraw(playerid, COLOR_RED);
    SetPVarInt(playerid,"TextDrawCharacter",1);
    return 1;
}
stock ShowInfoCharacter(playerid,i) {
    new string[129],gioitinh[10];
    switch(TempCharacter[playerid][i][GioiTinh]) {
        case 0: gioitinh = "Nu";
        case 1: gioitinh = "Nam";
    }

    PlayerTextDrawSetString(playerid,CharacterMain[playerid][5], TempCharacter[playerid][i][Name]);

    PlayerTextDrawSetPreviewModel(playerid, CharacterMain[playerid][3], TempCharacter[playerid][i][Skin]);
    PlayerTextDrawSetPreviewRot(playerid, CharacterMain[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

    format(string, sizeof string, "Ten_nhan_vat: ~y~%s", TempCharacter[playerid][i][Name]);
    PlayerTextDrawSetString(playerid,CharacterMain[playerid][3],string);
    format(string, sizeof string, "Level: ~y~%d", TempCharacter[playerid][i][Lv]);
    PlayerTextDrawSetString(playerid,CharacterMain[playerid][4],string);
    format(string, sizeof string, "Cong_viec: ~y~%s", GetJobName(TempCharacter[playerid][i][Job]));
    PlayerTextDrawSetString(playerid,CharacterMain[playerid][5],string);
    format(string, sizeof string, "Gio da choi: ~y~%d", TempCharacter[playerid][i][pPlayingHours]);
    PlayerTextDrawSetString(playerid,CharacterMain[playerid][6],string);
    TextDrawShowForPlayer(playerid, ButtonCharacter[0]);
    TextDrawShowForPlayer(playerid, ButtonCharacter[1]);
    for(new icc = 0; icc < 7 ; icc++) {
        PlayerTextDrawShow(playerid, CharacterMain[playerid][icc]);
    }
    return 1;

}
stock HideTDCharacter(playerid) {
	for(new i = 0 ; i <  4 ; i++) {
		PlayerTextDrawHide(playerid, CharacterButton[playerid][i]);
		PlayerTextDrawHide(playerid, CharacterName[playerid][i]);
	}
	for(new i = 0; i < 7 ; i++) {
		PlayerTextDrawHide(playerid, CharacterMain[playerid][i]);
	}
    TextDrawHideForPlayer(playerid, ButtonCharacter[0]);
    TextDrawHideForPlayer(playerid, ButtonCharacter[1]);
	return 1;
}
	