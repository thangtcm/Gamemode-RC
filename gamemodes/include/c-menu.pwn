
#if defined _menu_included
    #endinput
#endif

#define _menu_included

#include <a_samp>
#include <YSI\y_hooks>

#define             MAX_MENU_ITEMSZ          10

new PlayerText:Menu_ItemSelect[MAX_PLAYERS][MAX_MENU_ITEMSZ];
new PlayerText:Menu_ItemName[MAX_PLAYERS][MAX_MENU_ITEMSZ];
new PlayerText:Menu_BackGr[MAX_PLAYERS][4];

static
    playermenu_itemset[MAX_PLAYERS][MAX_MENU_ITEMSZ],
    playermenu_show[MAX_PLAYERS] = -1,
    item_count[MAX_PLAYERS] ,
    item_select[MAX_PLAYERS] = -1;
new counttick[MAX_PLAYERS];

forward OnPlayerSelectMenu(playerid,menuid,itemid,response);

CMD:testmenu(playerid,params[]) {
	AddItemPlayerMenu(playerid,"Select 1");
	AddItemPlayerMenu(playerid,"Select 2");
	AddItemPlayerMenu(playerid,"Select 3");
	AddItemPlayerMenu(playerid,"Select 4");
	AddItemPlayerMenu(playerid,"Select 5");
	AddItemPlayerMenu(playerid,"Select 6");
	AddItemPlayerMenu(playerid,"Select 7");
	AddItemPlayerMenu(playerid,"Select 8");
	AddItemPlayerMenu(playerid,"Select 9");
	AddItemPlayerMenu(playerid,"Select 10");
	ShowPlayerMenu(playerid, 1 ,"Tuy chon",strval(params));
	return 1;
}
stock AddItemPlayerMenu(playerid,const itemname[]) {
	new str[129];
	for(new i = 0; i < MAX_MENU_ITEMSZ ; i++) {
		if(playermenu_itemset[playerid][i] == 0) {
			playermenu_itemset[playerid][i] = 1;
			item_count[playerid]++;
			format(str, sizeof str, "%s", itemname);
            PlayerTextDrawSetString(playerid, Menu_ItemName[playerid][i], str);
            break;
		}
	}
	return 1;
}
stock LastIndexStr(playerid,index) {
	PlayerTextDrawSetString(playerid, Menu_ItemSelect[playerid][index], "mdl-2019:no_select"); 
    PlayerTextDrawShow(playerid, Menu_ItemSelect[playerid][index]);
}
stock SelectItemIndex(playerid,index) {
    PlayerTextDrawSetString(playerid, Menu_ItemSelect[playerid][index], "mdl-2019:select"); 
    PlayerTextDrawShow(playerid, Menu_ItemSelect[playerid][index]);
}
stock ShowPlayerMenu(playerid, menuid ,const name_tittle[],select) {
	new str[129];
	format(str, sizeof str, "%s", name_tittle);
    PlayerTextDrawSetString(playerid, Menu_BackGr[playerid][3], str);
    for(new i = 0; i < MAX_MENU_ITEMSZ ; i++) {
        if(playermenu_itemset[playerid][i] == 1) {
        	PlayerTextDrawShow(playerid, Menu_ItemSelect[playerid][i]);
        	PlayerTextDrawShow(playerid, Menu_ItemName[playerid][i]);
        }
    }
    PlayerTextDrawShow(playerid, Menu_BackGr[playerid][0]);
	PlayerTextDrawShow(playerid, Menu_BackGr[playerid][1]);
	PlayerTextDrawShow(playerid, Menu_BackGr[playerid][2]);
	PlayerTextDrawShow(playerid, Menu_BackGr[playerid][3]);
	SetPVarInt(playerid, "open_menu", 1);
	SetPVarInt(playerid, "ayzaaaa", 1);
	playermenu_show[playerid] = menuid;
    item_select[playerid] = -1;
    TogglePlayerControllable(playerid, 0);
    SendClientTextDraw(playerid,"Su dung nut~y~ UP va DOWN~w~ de tuy chon ~y~Space~w~ de chon ~y~Enter~w~ de thoat");
    if(select == 1 ) SelectTextDraw(playerid, 0x4f202dAA);
	return 1;
}
ClearMenuItem(playerid) {
	for(new i =0 ; i < MAX_MENU_ITEMSZ; i++) {
		playermenu_itemset[playerid][i] = 0;
		PlayerTextDrawSetString(playerid, Menu_ItemSelect[playerid][i], "mdl-2019:no_select"); 
		PlayerTextDrawSetString(playerid, Menu_ItemName[playerid][i], ""); 
	}
	playermenu_show[playerid] = -1, item_count[playerid] = 0,item_select[playerid] = -1,counttick[playerid] = 0;
}
stock HidePlayerMenu(playerid) {
	ClearMenuItem(playerid);
	for(new i =0 ; i < MAX_MENU_ITEMSZ; i++) {
		PlayerTextDrawHide(playerid, Menu_ItemName[playerid][i]);
		PlayerTextDrawHide(playerid, Menu_ItemSelect[playerid][i]);
	}
	PlayerTextDrawHide(playerid, Menu_BackGr[playerid][0]);
	PlayerTextDrawHide(playerid, Menu_BackGr[playerid][1]);
	PlayerTextDrawHide(playerid, Menu_BackGr[playerid][2]);
	PlayerTextDrawHide(playerid, Menu_BackGr[playerid][3]);
	CancelSelectTextDraw(playerid);
	DeletePVar(playerid, "open_menu");
	TogglePlayerControllable(playerid, 1);
	SetTimerEx("ResetAyza", 3000, 0, "d", playerid);
	return 1;
}
forward ResetAyza(playerid); 
public ResetAyza(playerid)  {
	DeletePVar(playerid, "ayzaaaa");
	return 1;
}
hook OnPlayerConnect(playerid) {
	CreateMenuTextDraw(playerid);
}
hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	if(GetPVarInt(playerid, "open_menu") == 1) {
		for(new i =0 ; i < MAX_MENU_ITEMSZ; i++) { 
			if(playertextid == Menu_ItemSelect[playerid][i] ) {
				if(item_select[playerid] != -1) {
                    LastIndexStr(playerid,item_select[playerid]);
                    SelectItemIndex(playerid,i);
                    item_select[playerid] = i;
                    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                    return 1;
				}
				if(item_select[playerid] == i) {
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					CallLocalFunction("OnPlayerSelectMenu", "dddd", playerid, playermenu_show[playerid], item_select[playerid],1);
				}
				else {
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SelectItemIndex(playerid,i);
                    item_select[playerid] = i;
				}	
			}
		}
		if(playertextid == Menu_BackGr[playerid][1]) {
			if(item_select[playerid] == -1) return 1;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			CallLocalFunction("OnPlayerSelectMenu", "dddd", playerid, playermenu_show[playerid], item_select[playerid],1);
		}
		if(playertextid == Menu_BackGr[playerid][2]) {
			if(item_select[playerid] == -1) return 1;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			CallLocalFunction("OnPlayerSelectMenu", "dddd", playerid, playermenu_show[playerid], item_select[playerid],0);
		}
	}
	return 1;
}
hook OnPlayerUpdate(playerid) {
	if(GetPVarInt(playerid, "open_menu") && counttick[playerid] - GetTickCount() <= 0)
    {
     	new Keys, ud, lr;
        GetPlayerKeys(playerid, Keys, ud, lr);
        switch(ud)
        {
        	case KEY_UP: {
        		counttick[playerid] = GetTickCount() + 150;
            	printf("key U , item select la: %d, item toi da la: %d", item_select[playerid],item_count[playerid]);
            	if(item_select[playerid] == -1) {
            		SelectItemIndex(playerid,0);
            		item_select[playerid] = 0;
            		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            	}
        	    else if(item_select[playerid] == 0) {
        		    item_select[playerid] = item_count[playerid]-1;
        		    LastIndexStr(playerid,0);
        		    SelectItemIndex(playerid,item_select[playerid]);
        		    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
        		    return 1;
        	    } 
        	    else if(item_select[playerid] > 0) {
        	    	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
        	    	LastIndexStr(playerid,item_select[playerid]);
        		    SelectItemIndex(playerid,item_select[playerid]-1);
        	    	item_select[playerid]--;
        	    }    
        	}
        	case KEY_DOWN: {
	        	counttick[playerid] = GetTickCount() + 150;
            	printf("key U , item select la: %d, item toi da la: %d", item_select[playerid],item_count[playerid]);
            	if(item_select[playerid] == -1) {
            		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            		SelectItemIndex(playerid,0);
            		item_select[playerid] = 0;
            	}
            	else if(item_select[playerid] >= item_count[playerid]-1) {
            		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            		item_select[playerid] = 0;
        		    LastIndexStr(playerid,item_count[playerid]-1);
        		    SelectItemIndex(playerid,0);
        		    return 1;
            	} 
            	else if(item_select[playerid] < item_count[playerid]-1) { 
            		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            		LastIndexStr(playerid,item_select[playerid]);
        		    SelectItemIndex(playerid,item_select[playerid]+1);
            		item_select[playerid]++;
            	}    
        	}
        }
    }
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

    if(GetPVarInt(playerid, "open_menu"))
    {
    	switch(newkeys) {
            case KEY_SECONDARY_ATTACK, KEY_SPRINT: 
            { 
                new 
                    response = (newkeys & KEY_SPRINT) ? 1 : 0;
                printf("response: %d key %d", response,newkeys);
                if(playermenu_show[playerid] >= 0) 
                {
                    CallLocalFunction("OnPlayerSelectMenu", "dddd", playerid, playermenu_show[playerid], item_select[playerid],response);
                }
            }           
        }
    }
    return 1;
}
stock CreateMenuTextDraw(playerid) {
	Menu_BackGr[playerid][0] = CreatePlayerTextDraw(playerid, 244.210830, 117.083351, "mdl-2019:main");
    PlayerTextDrawLetterSize(playerid, Menu_BackGr[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Menu_BackGr[playerid][0], 153.000000, 253.000000);
    PlayerTextDrawAlignment(playerid, Menu_BackGr[playerid][0], 1);
    PlayerTextDrawColor(playerid, Menu_BackGr[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, Menu_BackGr[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, Menu_BackGr[playerid][0], 255);
    PlayerTextDrawFont(playerid, Menu_BackGr[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, Menu_BackGr[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][0], 0);


	Menu_BackGr[playerid][1] = CreatePlayerTextDraw(playerid, 274.370605, 345.166717, "mdl-2019:tuychon");
	PlayerTextDrawLetterSize(playerid, Menu_BackGr[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Menu_BackGr[playerid][1], 39.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, Menu_BackGr[playerid][1], 1);
	PlayerTextDrawColor(playerid, Menu_BackGr[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Menu_BackGr[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Menu_BackGr[playerid][1], 255);
	PlayerTextDrawFont(playerid, Menu_BackGr[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, Menu_BackGr[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, Menu_BackGr[playerid][1], true);

	Menu_BackGr[playerid][2] = CreatePlayerTextDraw(playerid, 327.788909, 345.166717, "mdl-2019:thoat");
	PlayerTextDrawLetterSize(playerid, Menu_BackGr[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Menu_BackGr[playerid][2], 39.000000, 14.000000);
	PlayerTextDrawAlignment(playerid, Menu_BackGr[playerid][2], 1);
	PlayerTextDrawColor(playerid, Menu_BackGr[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Menu_BackGr[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, Menu_BackGr[playerid][2], 255);
	PlayerTextDrawFont(playerid, Menu_BackGr[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, Menu_BackGr[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, Menu_BackGr[playerid][2], true);

    Menu_BackGr[playerid][3] = CreatePlayerTextDraw(playerid, 322.996612, 125.000007, "MUA_VAT_PHAM");
	PlayerTextDrawLetterSize(playerid, Menu_BackGr[playerid][3], 0.243982, 1.658332);
	PlayerTextDrawAlignment(playerid, Menu_BackGr[playerid][3], 2);
	PlayerTextDrawColor(playerid, Menu_BackGr[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Menu_BackGr[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Menu_BackGr[playerid][3], 255);
	PlayerTextDrawFont(playerid, Menu_BackGr[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, Menu_BackGr[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Menu_BackGr[playerid][3], 0);

    new Float:y;
	for(new i = 0 ; i < MAX_MENU_ITEMSZ ;i++) {
	//	item_number += 1;
	//	item_number = item_number == 0 ? 1 : item_number;
        y = 147.033370 + ( i * 19 ); // 132.650039

        Menu_ItemSelect[playerid][i] = CreatePlayerTextDraw(playerid, 264.511047, y, "mdl-2019:no_select");
        PlayerTextDrawLetterSize(playerid, Menu_ItemSelect[playerid][i], 0.000000, 0.000000);
        PlayerTextDrawTextSize(playerid, Menu_ItemSelect[playerid][i], 116.000000, 19.000000);
        PlayerTextDrawAlignment(playerid, Menu_ItemSelect[playerid][i], 1);
        PlayerTextDrawColor(playerid, Menu_ItemSelect[playerid][i], -1);
        PlayerTextDrawSetShadow(playerid, Menu_ItemSelect[playerid][i], 0);
        PlayerTextDrawSetOutline(playerid, Menu_ItemSelect[playerid][i], 0);
        PlayerTextDrawBackgroundColor(playerid, Menu_ItemSelect[playerid][i], 255);
        PlayerTextDrawFont(playerid, Menu_ItemSelect[playerid][i], 4);
        PlayerTextDrawSetProportional(playerid, Menu_ItemSelect[playerid][i], 0);
        PlayerTextDrawSetShadow(playerid, Menu_ItemSelect[playerid][i], 0);
        PlayerTextDrawSetSelectable(playerid, Menu_ItemSelect[playerid][i], true);

		y = 151.816665 + ( i* 19 );
		Menu_ItemName[playerid][i] = CreatePlayerTextDraw(playerid, 322.065338, y, "");
		PlayerTextDrawLetterSize(playerid, Menu_ItemName[playerid][i], 0.171830, 1.057499);
		PlayerTextDrawAlignment(playerid, Menu_ItemName[playerid][i], 2);
		PlayerTextDrawColor(playerid, Menu_ItemName[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, Menu_ItemName[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, Menu_ItemName[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, Menu_ItemName[playerid][i], 255);
		PlayerTextDrawFont(playerid, Menu_ItemName[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, Menu_ItemName[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, Menu_ItemName[playerid][i], 0);
	}

	return 1;

}


