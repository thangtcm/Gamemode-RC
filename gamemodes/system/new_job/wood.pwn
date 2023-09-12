#include <a_samp>
#include <YSI\y_hooks>

#define MAX_WOOD 10
enum Wood {
	WoodObject,
	Text3D:WoodText,
	WoodStatus,
	ObjectHealth,
	WoodInWoodxD
}
new WoodInfo[MAX_WOOD][Wood];
new Float:WoodPostion[MAX_WOOD][3] = {
{-639.3089,-61.5377,64.8936},
{-652.7448,-86.8826,63.3066},
{-683.0600,-90.6403,66.3271},
{-694.6327,-74.3674,69.7006},
{-686.5068,-64.7477,69.8633},
{-633.3345,-73.4974,65.3331},
{-662.6438,-124.9772,61.1884},
{-647.3447,-145.8317,63.0927},
{-636.9913,-138.2652,65.7189},
{-684.5880,-55.5238,70.5329}
};

CreateWood() {
    for(new i = 0 ; i < MAX_WOOD ; i++) {

    	WoodInfo[i][WoodText] = CreateDynamic3DTextLabel("{ffffff}( Su dung phim 'Y' de chat cay )\nBan co the {8c0000}SPAM 'Y'{ffffff} lien tuc de chat cay nhanh hon.\n{058a00}Cay bach dang", -1,  WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2]-1, 100);
    	WoodInfo[i][WoodObject] = CreateObject(655, WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2]-1, 0,0,0);
    	WoodInfo[i][ObjectHealth] = 100;
    	WoodInfo[i][WoodStatus]  = 1;
    	
    }
}
// case WOOD_MENU: {
        	
CMD:chatgo(playerid,params[]) {
	if(CMND < 1) return SendErrorMessage(playerid,"Ban khong co CMND khong the xin viec.");
	if(GetPVarInt(playerid, "Chatcay_var") == 0) {
		ShowPlayerDialog(playerid, WOOD_MENU, DIALOG_STYLE_LIST, "Cong viec chat go", "Nhan viec chat go\nThay dong phuc\nBat dau lam viec\nNghi viec chat go", "Tuy chon", "Thoat");
	}
	else if(GetPVarInt(playerid, "Chatcay_var") != 0) {
		ShowPlayerDialog(playerid, WOOD_MENU, DIALOG_STYLE_LIST, "Cong viec chat go", "Nhan viec chat go\nThay dong phuc\nDung lam viec\nNghi viec chat go", "Tuy chon", "Thoat");
	}
	
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		  	case WOOD_MENU: {
        	switch(listitem) {
        		case 0: {
        			if (IsPlayerInRangeOfPoint(playerid,5.0,-543.2013,-197.4136,78.4063)) {
        				if(PlayerInfo[playerid][pJob] == 30 || PlayerInfo[playerid][pJob2] == 30) return SendErrorMessage(playerid, " Ban da lam viec Lam Tac roi.");
            			if(PlayerInfo[playerid][pJob] == 0)
                        {
                			SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
                			SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                			PlayerInfo[playerid][pJob] = 30;
                			return 1;
            			}
            			if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob] != 30)
            			{
            				SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
            				SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                		    PlayerInfo[playerid][pJob2] = 30;
                			return 1;
            			}		
        		    }
        		}
        		case 1: {
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        			SetPlayerSkin(playerid, 16);
        			PlayerInfo[playerid][pModel] = 16;
        			SendClientTextDraw(playerid, "Ban da thay trang phuc hay bat dau lam viec");
        		}
        		case 2: {
        			if(GetPVarInt(playerid,"chatcay_var") == 0) 
        			{
        			    if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        	            if(PlayerInfo[playerid][pModel] != 16) SendErrorMessage(playerid," Ban chua mac do bao ho khong the bat dau.");	
        	            SendClientTextDraw(playerid," Ban da bat dau lam viec, hay chat cay va lay go vao kho");
        	            SetPVarInt(playerid, "Chatcay_var", 1);
        	        }
        	        else if(GetPVarInt(playerid,"chatcay_var") != 0 ) {
                        if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        	            if(PlayerInfo[playerid][pModel] != 16) SendErrorMessage(playerid," Ban chua mac do bao ho khong the bat dau.");	
        	            SendClientTextDraw(playerid," Ban da dung dau viec chat go");
        	            DeletePVar(playerid, "Chatcay_var");
        	        }	

           		}
        		case 3: {
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
                    if(PlayerInfo[playerid][pJob] == 30) {
                    	PlayerInfo[playerid][pJob] = 0;
                    }
                    else if(PlayerInfo[playerid][pJob2] == 30) {
                    	PlayerInfo[playerid][pJob] = 0;
                    }
                    DeletePVar(playerid, "Chatcay_var");
                    SendClientTextDraw(playerid,"Ban da nghi viec thanh cong");
        		}
        	}
        }
	}
	return 1;
}
hook OnPlayerConnect(playerid) {
	CreateWood();

}
forward ResetChatgo(playerid);
public ResetChatgo(playerid) {
	DeletePVar(playerid, "DangChat");
	RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 0, 1);
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(GetPVarInt(playerid, "Chatcay_var") == 1) {
		switch(newkeys) {
			case KEY_YES: {
				for(new i = 0;i<MAX_WOOD;i++ ) {
					if(IsPlayerInRangeOfObject(playerid, WoodInfo[i][WoodObject], 3)) {
						switch(WoodInfo[i][WoodStatus]) {
							case 1: {
								if(GetPVarInt(playerid, "DangChat")) return 1;
								PlayAnim(playerid, "BASEBALL", "Bat_4", 4.0, 1, 0, 0, 0, 0, 1);
								SetPlayerAttachedObject(playerid, PIZZA_INDEX, 19631, 6, -0.059999,	0.034,	0.319,	21,	-110.5,	112.8,	1,	1,	1, 0, 0);
								SetPVarInt(playerid,"DangChat",1);
								SetTimerEx("ResetChatgo",3000,0,"d",playerid);
								SendClientTextDraw(playerid,"Dang chat go...");
							    WoodInfo[i][ObjectHealth] -= 10 + random(10);
                        	    if( WoodInfo[i][ObjectHealth] <= 0) {
                        		    DestroyObject( WoodInfo[i][WoodObject]);
                        		    WoodInfo[i][WoodInWoodxD] = 10;
                        		    WoodInfo[i][WoodStatus] = 2;
                        	    	WoodInfo[i][WoodObject] = CreateObject(18609, WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2], 0,0,0);
                       	 	    }
                       	 	}
                       	 	case 2: {
                       	 		if(GetPVarInt(playerid,"GoIDAAA") != 0) return SendClientTextDraw(playerid," Ban dang lay go khong the tiep tuc ~r~SPAM");
                       	 		SetPVarInt(playerid, "GoIDAAA", i+1);
                       	 		PlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
                       	 		LoaderStarting(playerid, LOAD_LAYGO, "Dang lay go...", 1,6);
                       	 	}
						}           
					} 
				}			
			}
		}	
	}
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid) {
	if(GetPVarInt(playerid, "Chatcay_var") == 2) {
		LoaderStarting(playerid, LOAD_CHATGO, "Dang chat go vao kho...", 1,4);
		TogglePlayerControllable(playerid,0);
	}
}
