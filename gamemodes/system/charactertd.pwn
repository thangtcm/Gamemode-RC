
//Player TextDraws: 


new PlayerText:CharacterMain[MAX_PLAYERS][1];
new PlayerText:CharacterLevel[MAX_PLAYERS][3];
new PlayerText:CharacterSkin[MAX_PLAYERS][3];
new PlayerText:CharacterName[MAX_PLAYERS][3];


stock LoadCharacterTD(playerid) {

    CharacterMain[playerid][0] = CreatePlayerTextDraw(playerid, 114.000, 150.000, "mdl-3000:character");
    PlayerTextDrawTextSize(playerid, CharacterMain[playerid][0], 410.000, 124.000);
    PlayerTextDrawAlignment(playerid, CharacterMain[playerid][0], 1);
    PlayerTextDrawColor(playerid, CharacterMain[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharacterMain[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, CharacterMain[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterMain[playerid][0], 255);
    PlayerTextDrawFont(playerid, CharacterMain[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, CharacterMain[playerid][0], 1);

    CharacterSkin[playerid][0] = CreatePlayerTextDraw(playerid, 102.000, 106.000, "_");
    PlayerTextDrawTextSize(playerid, CharacterSkin[playerid][0], 126.000, 158.000);
    PlayerTextDrawAlignment(playerid, CharacterSkin[playerid][0], 1);
    PlayerTextDrawColor(playerid, CharacterSkin[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharacterSkin[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, CharacterSkin[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterSkin[playerid][0], 0);
    PlayerTextDrawFont(playerid, CharacterSkin[playerid][0], 5);
    PlayerTextDrawSetProportional(playerid, CharacterSkin[playerid][0], 0);
    PlayerTextDrawSetPreviewModel(playerid, CharacterSkin[playerid][0], 0);
    PlayerTextDrawSetPreviewRot(playerid, CharacterSkin[playerid][0], 19.000, 0.000, 0.000, 0.750);
    PlayerTextDrawSetPreviewVehCol(playerid, CharacterSkin[playerid][0], 0, 0);

    CharacterSkin[playerid][1] = CreatePlayerTextDraw(playerid, 254.000, 106.000, "_");
    PlayerTextDrawTextSize(playerid, CharacterSkin[playerid][1], 126.000, 158.000);
    PlayerTextDrawAlignment(playerid, CharacterSkin[playerid][1], 1);
    PlayerTextDrawColor(playerid, CharacterSkin[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharacterSkin[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, CharacterSkin[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterSkin[playerid][1], 0);
    PlayerTextDrawFont(playerid, CharacterSkin[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, CharacterSkin[playerid][1], 0);
    PlayerTextDrawSetPreviewModel(playerid, CharacterSkin[playerid][1], 0);
    PlayerTextDrawSetPreviewRot(playerid, CharacterSkin[playerid][1], 19.000, 0.000, 0.000, 0.750);
    PlayerTextDrawSetPreviewVehCol(playerid, CharacterSkin[playerid][1], 0, 0);

    CharacterSkin[playerid][2] = CreatePlayerTextDraw(playerid, 408.000, 106.000, "_");
    PlayerTextDrawTextSize(playerid, CharacterSkin[playerid][2], 126.000, 158.000);
    PlayerTextDrawAlignment(playerid, CharacterSkin[playerid][2], 1);
    PlayerTextDrawColor(playerid, CharacterSkin[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, CharacterSkin[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, CharacterSkin[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterSkin[playerid][2], 0);
    PlayerTextDrawFont(playerid, CharacterSkin[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, CharacterSkin[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, CharacterSkin[playerid][2], 0);
    PlayerTextDrawSetPreviewRot(playerid, CharacterSkin[playerid][2], 19.000, 0.000, 0.000, 0.750);
    PlayerTextDrawSetPreviewVehCol(playerid, CharacterSkin[playerid][2], 0, 0);



    CharacterName[playerid][0] = CreatePlayerTextDraw(playerid, 167.000, 258.000, "Tao_nhan_vat");
    PlayerTextDrawLetterSize(playerid, CharacterName[playerid][0], 0.210, 1.099);
    PlayerTextDrawTextSize(playerid, CharacterName[playerid][0], 20.000, 78.000);
    PlayerTextDrawAlignment(playerid, CharacterName[playerid][0], 2);
    PlayerTextDrawColor(playerid, CharacterName[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharacterName[playerid][0], 1);
    PlayerTextDrawSetOutline(playerid, CharacterName[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][0], 1768516095);
    PlayerTextDrawFont(playerid, CharacterName[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, CharacterName[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, CharacterName[playerid][0], 1);

    CharacterLevel[playerid][0] = CreatePlayerTextDraw(playerid, 167.000, 266.000, "Level: 0");
    PlayerTextDrawLetterSize(playerid, CharacterLevel[playerid][0], 0.160, 1.099);
    PlayerTextDrawAlignment(playerid, CharacterLevel[playerid][0], 2);
    PlayerTextDrawColor(playerid, CharacterLevel[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, CharacterLevel[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, CharacterLevel[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterLevel[playerid][0], -1061109505);
    PlayerTextDrawFont(playerid, CharacterLevel[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, CharacterLevel[playerid][0], 1);

    CharacterName[playerid][1] = CreatePlayerTextDraw(playerid, 318.000, 258.000, "Tao_nhan_vat");
    PlayerTextDrawLetterSize(playerid, CharacterName[playerid][1], 0.210, 1.099);
    PlayerTextDrawTextSize(playerid, CharacterName[playerid][1], 20.000, 78.000);
    PlayerTextDrawAlignment(playerid, CharacterName[playerid][1], 2);
    PlayerTextDrawColor(playerid, CharacterName[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharacterName[playerid][1], 1);
    PlayerTextDrawSetOutline(playerid, CharacterName[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][1], 1768516095);
    PlayerTextDrawFont(playerid, CharacterName[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, CharacterName[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, CharacterName[playerid][1], 1);

    CharacterLevel[playerid][1] = CreatePlayerTextDraw(playerid, 318.000, 266.000, "Level: 0");
    PlayerTextDrawLetterSize(playerid, CharacterLevel[playerid][1], 0.160, 1.099);
    PlayerTextDrawAlignment(playerid, CharacterLevel[playerid][1], 2);
    PlayerTextDrawColor(playerid, CharacterLevel[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, CharacterLevel[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, CharacterLevel[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterLevel[playerid][1], -1061109505);
    PlayerTextDrawFont(playerid, CharacterLevel[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, CharacterLevel[playerid][1], 1);

    CharacterName[playerid][2] = CreatePlayerTextDraw(playerid, 471.000, 258.000, "Tao_nhan_vat");
    PlayerTextDrawLetterSize(playerid, CharacterName[playerid][2], 0.210, 1.099);
    PlayerTextDrawTextSize(playerid, CharacterName[playerid][2], 20.000, 78.000);
    PlayerTextDrawAlignment(playerid, CharacterName[playerid][2], 2);
    PlayerTextDrawColor(playerid, CharacterName[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, CharacterName[playerid][2], 1);
    PlayerTextDrawSetOutline(playerid, CharacterName[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterName[playerid][2], 1768516095);
    PlayerTextDrawFont(playerid, CharacterName[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, CharacterName[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, CharacterName[playerid][2], 1);

    CharacterLevel[playerid][2] = CreatePlayerTextDraw(playerid, 471.000, 266.000, "Level: 0");
    PlayerTextDrawLetterSize(playerid, CharacterLevel[playerid][2], 0.160, 1.099);
    PlayerTextDrawAlignment(playerid, CharacterLevel[playerid][2], 2);
    PlayerTextDrawColor(playerid, CharacterLevel[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, CharacterLevel[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, CharacterLevel[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, CharacterLevel[playerid][2], -1061109505);
    PlayerTextDrawFont(playerid, CharacterLevel[playerid][2], 2);
    PlayerTextDrawSetProportional(playerid, CharacterLevel[playerid][2], 1);

}


stock ShowPlayerCharacter(playerid) {
    for(new i = 0 ; i < 3 ; i++) {
        if (TempCharacter[playerid][i][IsCreated]) {
            new string[256];
            format(string, sizeof(string), "Level: %d", TempCharacter[playerid][i][Lv]);
            PlayerTextDrawSetString(playerid,CharacterLevel[playerid][i], string);
            PlayerTextDrawSetString(playerid,CharacterName[playerid][i], TempCharacter[playerid][i][Name]);
            PlayerTextDrawSetPreviewModel(playerid, CharacterSkin[playerid][i], TempCharacter[playerid][i][Skin]);
        }
        else
        {
            PlayerTextDrawSetString(playerid,CharacterName[playerid][i], "Chua khoi tao");
        }
        PlayerTextDrawShow(playerid, CharacterLevel[playerid][i]);
        PlayerTextDrawShow(playerid, CharacterName[playerid][i]);
        PlayerTextDrawShow(playerid, CharacterSkin[playerid][i]);
    
    }
    SetPlayerCameraPos(playerid, 1327.6215,276.7715,27.1267);
    SetPlayerCameraLookAt(playerid, 1360.5042,251.5099,22.8312);
    SetPlayerPos(playerid, 1315.5244,270.9372,29.6472);
    PlayerTextDrawShow(playerid, CharacterMain[playerid][0]);
    SelectTextDraw(playerid, COLOR_LIGHTRED);
    SetPVarInt(playerid,"TextDrawCharacter",1);
    return 1;
}/*
stock ShowInfoCharacter(playerid,i) {
    new string[129],gioitinh[10];
    switch(TempCharacter[playerid][i][GioiTinh]) {
        case 0: gioitinh = "Nu";
        case 1: gioitinh = "Nam";
    }

    PlayerTextDrawSetString(playerid,CharacterLevel[playerid][0], TempCharacter[playerid][i][Name]);

    PlayerTextDrawSetPreviewModel(playerid, CharacterSkin[playerid][2], TempCharacter[playerid][i][Skin]);
    PlayerTextDrawSetPreviewRot(playerid, CharacterSkin[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

    format(string, sizeof string, "Ten_nhan_vat: ~y~%s", TempCharacter[playerid][i][Name]);
    PlayerTextDrawSetString(playerid,CharacterSkin[playerid][2],string);
    format(string, sizeof string, "Level: ~y~%d", TempCharacter[playerid][i][Lv]);
    PlayerTextDrawSetString(playerid,CharacterName[playerid][0],string);
    format(string, sizeof string, "Cong_viec: ~y~%s", GetJobName(TempCharacter[playerid][i][Job]));
    PlayerTextDrawSetString(playerid,CharacterLevel[playerid][0],string);
    format(string, sizeof string, "Gio da choi: ~y~%d", TempCharacter[playerid][i][pPlayingHours]);
    PlayerTextDrawSetString(playerid,CharacterName[playerid][1],string);
    TextDrawShowForPlayer(playerid, ButtonCharacter[0]);
    TextDrawShowForPlayer(playerid, ButtonCharacter[1]);
    for(new icc = 0; icc < 7 ; icc++) {
        PlayerTextDrawShow(playerid, CharacterMain[playerid][icc]);
    }
    return 1;

}*/
stock HideTDCharacter(playerid) {
	for(new i = 0 ; i <  3 ; i++) {
        PlayerTextDrawHide(playerid, CharacterSkin[playerid][i]);
		PlayerTextDrawHide(playerid, CharacterLevel[playerid][i]);
		PlayerTextDrawHide(playerid, CharacterName[playerid][i]);
	}
    PlayerTextDrawHide(playerid, CharacterMain[playerid][0]);
	return 1;
}
	