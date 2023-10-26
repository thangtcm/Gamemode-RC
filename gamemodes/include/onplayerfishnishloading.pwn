public OnLoadingFinish(playerid,loadingid) {
	switch(loadingid) {
		case 1: SendServerMessage(playerid, " [TESTING SUCCES]");
        case LoadingDaoDa: {
            RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
            StopLoopingAnim(playerid);
            DeletePVar(playerid, "DangDaoDa");
            switch(random(100)) {
                case 0..40: SendClientTextDraw(playerid, "Ban khong dao duoc gi");
                case 41..79: {
                    //AddItemInventory(playerid,24,1);
                    SendClientTextDraw(playerid, "Ban dao duoc 1 ~y~quang sat");
                    SendClientMessageEx(playerid,-1, "Ban da dao duoc 1 {1c1b1a}Quang sat");
                }
                case 80..89: {
                    //AddItemInventory(playerid,25,1);
                    SendClientTextDraw(playerid, "Ban dao duoc 1 ~y~quang dong");
                    SendClientMessageEx(playerid,-1,"Ban da dao duoc 1 {ee8721}Quang dong");
                }
                case 90..95: {
                    //AddItemInventory(playerid,26,1);
                    SendClientTextDraw(playerid, "Ban dao duoc 1 ~y~quang bac");
                    SendClientMessageEx(playerid,-1,"Ban da dao duoc 1 {81e3dc}Quang bac");
                }
                case 96..99: {
                    //AddItemInventory(playerid,27,1);
                    SendClientTextDraw(playerid, "Ban dao duoc 1 ~y~quang vang");
                    SendClientMessageEx(playerid,-1,"Ban da dao duoc 1 {AB752D}Quang vang");
                }
            }
        }
		case LOAD_CHARACTERLOGIN: { 
		    new i = GetPVarInt(playerid, #select_character);
            ShowNoticeGUIFrame(playerid, 3);
            CancelSelectTextDraw(playerid);
            new string[129];
            printf("LOAD_CHARACTERLOGIN %s - Admin %d", TempCharacter[playerid][i][Name], PlayerInfo[playerid][pAdmin]);
	        format(string, sizeof(string), "SELECT * FROM `accounts` WHERE `Username` = '%s'",  TempCharacter[playerid][i][Name]);
 	        mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", LOADUSERDATA_THREAD, playerid, g_arrQueryHandle{playerid}); 
 	    }
        case LOAD_CHATGO: {
            SendClientMessage(playerid, COLOR_YELLOW, "Ban nhan duoc $2000 dollar");
            PlayerInfo[playerid][pCash] += 2000;
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
            ClearAnimations(playerid);
            DeletePVar(playerid, "Chatcay_var");
            DisablePlayerCheckpoint(playerid);
            TogglePlayerControllable(playerid,1);
        }
        // case LOAD_LAYGO: {
        //     new i = GetPVarInt(playerid, "GoIDAAA") - 1;
        //     if(WoodInfo[i][WoodInWoodxD] <= 1) return SendClientTextDraw(playerid,"Loi go da het khong the lay...");
        //     WoodInfo[i][WoodInWoodxD] -= 1;
    
        //     SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        //     SetPVarInt(playerid, "Chatcay_var", 1);
        //     SetPlayerCheckpoint(playerid, -745.2551,-115.5959,66.7408, 1);
        //     DeletePVar(playerid, "GoIDAAA");
        //     SetPlayerAttachedObject( playerid, PIZZA_INDEX, 19793, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
        //     if(WoodInfo[i][WoodInWoodxD] <= 0) {
        //         DestroyDynamicObject( WoodInfo[i][WoodObject]);
        //         DestroyDynamic3DTextLabel(WoodInfo[i][WoodText]);
        //     }
        // }
	}
	return 1;
}