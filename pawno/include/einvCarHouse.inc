#if !defined MAX_MENU_ITEMCHS
	#define MAX_MENU_ITEMCHS (30)
#endif

#define MODEL_RESPONSE_CANCEL (0)
#define MODEL_RESPONSE_SELECT (1)
#define MAX_ITEMCHPAGE	(9)
#define MAX_ITEMCHLINE	(3)

enum g_ePlayerMenuCHEnum {
	PlayerText:g_eMenuCHTextdraws[15],
	PlayerText:g_eMenuItems[MAX_ITEMCHPAGE],
	PlayerText:g_eMenuAmounts[MAX_ITEMCHPAGE],
	PlayerText:g_eMenuNames[MAX_ITEMCHPAGE],
	PlayerText:g_eMenuSlots[MAX_ITEMCHPAGE],
	PlayerText:g_eMenuExpirys[MAX_ITEMCHPAGE],
	Float:g_eMenuRot[4],
	g_eMenuAmount[MAX_MENU_ITEMCHS],
	g_eMenuSlot[MAX_MENU_ITEMCHS],
	g_eMenuExpiry[MAX_MENU_ITEMCHS],
	g_eMenuTotalItems,
	g_eMenuPage,
	g_eMenuPages,
	g_eMenuShown,
	g_eMenuExtra,
	g_eMenuIgnore,
	g_eMenuTime,
	g_eMenuType
};

static stock
	g_ePlayerMenuName[MAX_PLAYERS][MAX_MENU_ITEMCHS][32],
	g_ePlayerMenuModel[MAX_PLAYERS][MAX_MENU_ITEMCHS][64],
	g_ePlayerMenuData[MAX_PLAYERS][g_ePlayerMenuCHEnum]
;

stock HideModelSelectionInvCarHouse(playerid)
{
	if (!IsPlayerConnected(playerid) || !g_ePlayerMenuData[playerid][g_eMenuShown])
	    return 0;

	for (new i = 0; i < MAX_ITEMCHPAGE; i ++) {
		if(i < 7)	PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][i]);
		PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][i]);
	}
	for (new i = 0; i != MAX_MENU_ITEMCHS; i ++)
	{
	    if (i < MAX_ITEMCHPAGE)
	    {
	        if (g_ePlayerMenuData[playerid][g_eMenuItems][i] != PlayerText:INVALID_TEXT_DRAW)
	        {
	            PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i]);
                g_ePlayerMenuData[playerid][g_eMenuItems][i] = PlayerText:INVALID_TEXT_DRAW;
			}
	    	if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i] != PlayerText:INVALID_TEXT_DRAW)
	    	{
                PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i]);
                g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = PlayerText:INVALID_TEXT_DRAW;
			}
			if (g_ePlayerMenuData[playerid][g_eMenuExpirys][i] != PlayerText:INVALID_TEXT_DRAW)
	    	{
                PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i]);
                g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = PlayerText:INVALID_TEXT_DRAW;
			}
			if (g_ePlayerMenuData[playerid][g_eMenuNames][i] != PlayerText:INVALID_TEXT_DRAW)
	    	{
                PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i]);
                g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
			}
		}
		strcpy(g_ePlayerMenuModel[playerid][i], "_", 64);
		g_ePlayerMenuData[playerid][g_eMenuAmount][i] = 0;
		strcpy(g_ePlayerMenuName[playerid][i], "_", 32);
	}
	g_ePlayerMenuData[playerid][g_eMenuShown] = false;
	g_ePlayerMenuData[playerid][g_eMenuTotalItems] = 0;
	g_ePlayerMenuData[playerid][g_eMenuExtra] = 0;
	g_ePlayerMenuData[playerid][g_eMenuPage] = 1;
	g_ePlayerMenuData[playerid][g_eMenuPages] = 0;
    g_ePlayerMenuData[playerid][g_eMenuIgnore] = true;

	g_ePlayerMenuData[playerid][g_eMenuRot][0] = 0.0;
    g_ePlayerMenuData[playerid][g_eMenuRot][1] = 0.0;
    g_ePlayerMenuData[playerid][g_eMenuRot][2] = 0.0;
    g_ePlayerMenuData[playerid][g_eMenuRot][3] = 0.0;

	CancelSelectTextDraw(playerid);
	return 1;
}

stock ShowModelSelectionInvCarHouse(playerid, header[] , extraid, items[][64], size = sizeof(items), bool:amount = false, amounts[] = {-1}, itemnames[MAX_MENU_ITEMCHS][32] = {"_",...}, bool:expiry=false, expirys[] = {0})
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	if (size > MAX_MENU_ITEMCHS)
	    return printf("** Warning: Please increase \"MAX_MENU_ITEMCHS\" if you want to create more items.");

	if (g_ePlayerMenuData[playerid][g_eMenuShown])
	{
	    HideModelSelectionInvCarHouse(playerid);
	}
	for (new i = 0; i < MAX_ITEMCHPAGE; i ++) {
	    g_ePlayerMenuData[playerid][g_eMenuItems][i] = PlayerText:INVALID_TEXT_DRAW;
		g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = PlayerText:INVALID_TEXT_DRAW;
		g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
		g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	new
	    Float:x = 180.0,
	    Float:y = 190.0,
		str[64];
	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0] = CreatePlayerTextDraw(playerid, 280.000, 185.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 5.839, 17.899);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 360.000, 150.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 825374975);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 741093631);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][0], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1] = CreatePlayerTextDraw(playerid, 280.000, 158.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 0.180, 2.500);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 0.000, 150.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1061176831);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][1], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2] = CreatePlayerTextDraw(playerid, 280.000, 184.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 0.300, -0.199);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 2.000, 150.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1583310847);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][2], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3] = CreatePlayerTextDraw(playerid, 210.000, 163.000, header);
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][3], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4] = CreatePlayerTextDraw(playerid, 316.000, 164.000, "1/2");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 0.280, 1.500);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 2);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5] = CreatePlayerTextDraw(playerid, 300.000, 167.000, "mdl-2023:btn_prev");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 10.000, 10.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5], 1);

	g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6] = CreatePlayerTextDraw(playerid, 340.000, 167.000, "mdl-2023:btn_next");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 10.000, 10.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6], 1);

	for(new idx = 0; idx < MAX_ITEMCHPAGE; idx++)
	{
		if (idx > 0 && (idx % MAX_ITEMCHLINE) == 0)
		{
			x = 230.0;
			y += 55.0;
		}
		else
		{
			x += 50.0;
		}
		if (idx < MAX_ITEMCHPAGE)
		{
			g_ePlayerMenuData[playerid][g_eMenuSlots][idx] = CreatePlayerTextDraw(playerid, x, y, "_");
			PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 0.209, 4.296);
			PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], -84.000, 33.000);
			PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 2);
			PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], -1);
			PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
			PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 589572607);
			PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
			PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
			PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 150);
			PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
			PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
		}
	}
	x = 160.0,
	y = 190.0;
	new itemModel[64];
 	for (new i = 0, idx = 0; i != MAX_MENU_ITEMCHS; i ++)
	{
 		if (i >= size)
 		{
 	        strcpy(g_ePlayerMenuModel[playerid][i], "_", 64);
 	    }
 	    else
		{
		    if (!strcmp(items[i], "_"))
			{
                strcpy(g_ePlayerMenuModel[playerid][i], "_", 64);
                g_ePlayerMenuData[playerid][g_eMenuAmount][i] = 0;
				g_ePlayerMenuData[playerid][g_eMenuExpiry][i] = 0;
				strcpy(g_ePlayerMenuName[playerid][i], "_", 32);
      		}
	  		else
	  		{
	   			g_ePlayerMenuData[playerid][g_eMenuTotalItems]++;
				format(itemModel, sizeof(itemModel), "mdl-2023:%s", items[i]);
				strcpy(g_ePlayerMenuModel[playerid][i], itemModel, 64);
				strcpy(g_ePlayerMenuName[playerid][i], itemnames[i], 32);
				if (amount) {
	                g_ePlayerMenuData[playerid][g_eMenuAmount][i] = amounts[i];
				}
				if(expiry){
					g_ePlayerMenuData[playerid][g_eMenuExpiry][i] = expirys[i];
				}
			}
			if (i < MAX_ITEMCHPAGE && strcmp(items[i], "_"))
			{
				if (idx > 0 && (idx % MAX_ITEMCHLINE) == 0)
				{
	   				x = 210.0;
	  	    		y += 55.0;
	  			}
	    		else
				{
	 	    		x += 50.0;
	        	}
	        	idx++;

	        	if (i < MAX_ITEMCHPAGE && strcmp(items[i], "_"))
				{
					g_ePlayerMenuData[playerid][g_eMenuItems][i] = CreatePlayerTextDraw(playerid, x, y, g_ePlayerMenuModel[playerid][i]);
					PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 35.000, 35.000);
					PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 1);
					PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], -1);
					PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0);
					PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0);
					PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 255);
					PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 4);
					PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 1);
					PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 1);
					if (expiry && expirys[i] != 0)
					{
						format(str, 64, "HSD: %s", ConvertSecondsToDuration(expirys[i]));
						g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = CreatePlayerTextDraw(playerid, x + 10.0, y + 35.0, str);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 0.100, 0.600);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 2);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 0);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 1);
					}
					if (amount && amounts[i] != -1)
					{
					    format(str, 64, "%d", amounts[i]);
						g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = CreatePlayerTextDraw(playerid, x + 32.0, y + 35.0, str);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 0.100, 0.600);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 2);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 0);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);

						g_ePlayerMenuData[playerid][g_eMenuNames][i] = CreatePlayerTextDraw(playerid, x + 20.0, y - 2.0, itemnames[i]);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 0.150, 0.750);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 2);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 0);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
					}
					else
					{
					    g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = PlayerText:INVALID_TEXT_DRAW;
						g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
						g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = PlayerText:INVALID_TEXT_DRAW;
					}
				}
			}
		}
	}
	g_ePlayerMenuData[playerid][g_eMenuExtra] = extraid;
	g_ePlayerMenuData[playerid][g_eMenuShown] = true;
	g_ePlayerMenuData[playerid][g_eMenuPage] = 1;
	g_ePlayerMenuData[playerid][g_eMenuPages] = (size / MAX_ITEMCHPAGE) + 1;
	g_ePlayerMenuData[playerid][g_eMenuTime] = GetTickCount();
	g_ePlayerMenuData[playerid][g_eMenuType] = 1;
		
    for (new i = 0; i < MAX_ITEMCHPAGE; i ++) {
		if(i < 7)	PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][i]);
		PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][i]);
		if (strcmp(g_ePlayerMenuModel[playerid][i], "_")) {
			if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i] != PlayerText:INVALID_TEXT_DRAW) {
				PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i]);
				PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i]);
				PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i]);
			}
			if(g_ePlayerMenuData[playerid][g_eMenuExpirys][i] != PlayerText:INVALID_TEXT_DRAW)
				PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i]);
		}
	}
	SelectTextDraw(playerid, -1);
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if (g_ePlayerMenuData[playerid][g_eMenuIgnore] || (GetTickCount() - g_ePlayerMenuData[playerid][g_eMenuTime]) < 200)
	{
	    g_ePlayerMenuData[playerid][g_eMenuIgnore] = false;
	    return CallLocalFunction("MSS_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
	}
	else if ((clickedid == Text:INVALID_TEXT_DRAW && g_ePlayerMenuData[playerid][g_eMenuShown]))
	{
	    CallLocalFunction("OnModelSelectionResponseInvCH", "ddds[64]d", playerid, g_ePlayerMenuData[playerid][g_eMenuExtra], 0, "_", MODEL_RESPONSE_CANCEL);
	    HideModelSelectionInvCarHouse(playerid);
	}
	return CallLocalFunction("MSS_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
}

stock Menu_SetPageCH(playerid, page)
{
	if (g_ePlayerMenuData[playerid][g_eMenuShown])
	{
	    if (page < 1 || page > g_ePlayerMenuData[playerid][g_eMenuPages])
		    return 0;

	    new
			start = (MAX_ITEMCHPAGE * (page - 1)),
			str[16];

		for (new i = 0; i < MAX_ITEMCHPAGE; i ++) {
			PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i]);
		}
		for (new i = start; i != start + MAX_ITEMCHPAGE && i < MAX_MENU_ITEMCHS; i ++)
		{
  			if (!strcmp(g_ePlayerMenuModel[playerid][i], "_", true))
  			{
     			PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);

		        if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
    			    PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);
					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);
				}
				if (g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
    			    PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start]);
				}
			}
			else
			{
		        if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
				    format(str, sizeof(str), "%d", g_ePlayerMenuData[playerid][g_eMenuAmount][i]);
					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start], str);

					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);
			        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);

					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start], g_ePlayerMenuName[playerid][i]);

					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);
			        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);

					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start], g_ePlayerMenuModel[playerid][i]);
					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);
					PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);
				}
				if (g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
					format(str, sizeof(str), "HSD: %s", ConvertSecondsToDuration(g_ePlayerMenuData[playerid][g_eMenuExpiry][i]));
					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start], str);

					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start]);
					PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i - start]);
				}
			}
		}
	    g_ePlayerMenuData[playerid][g_eMenuPage] = page;

	    format(str, 8, "%d/2", page);
	    PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][4], str);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if (!g_ePlayerMenuData[playerid][g_eMenuShown] || (GetTickCount() - g_ePlayerMenuData[playerid][g_eMenuTime]) < 600)
	{
		return CallLocalFunction("MSS_OnPlayerClickPlayerTextDraw", "ii", playerid, _:playertextid);
	}
	if (playertextid == g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][6])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] == g_ePlayerMenuData[playerid][g_eMenuPages])
			return 0;

		else
			Menu_SetPageCH(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] + 1);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuCHTextdraws][5])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] < 2)
			return 0;

		else
			Menu_SetPageCH(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] - 1);
	}
	else for (new i = 0; i < MAX_ITEMCHPAGE; i ++)
	{
		if (g_ePlayerMenuData[playerid][g_eMenuItems][i] == playertextid)
		{
			new
				index = (i + (g_ePlayerMenuData[playerid][g_eMenuPage] - 1) * MAX_ITEMCHPAGE),
				extraid = g_ePlayerMenuData[playerid][g_eMenuExtra],
				modelid[64];
			strcpy(modelid, g_ePlayerMenuModel[playerid][i], 64);
			HideModelSelectionInvCarHouse(playerid);
			CallLocalFunction("OnModelSelectionResponseInvCH", "ddds[64]d", playerid, extraid, index, modelid, MODEL_RESPONSE_SELECT);
			break;
		}
	}
	return CallLocalFunction("MSS_OnPlayerClickPlayerTextDraw", "dd", playerid, _:playertextid);
}

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif

#define OnPlayerClickTextDraw MSS_OnPlayerClickTextDraw
#if defined MSS_OnPlayerClickTextDraw
	forward MSS_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

#define OnPlayerClickPlayerTextDraw MSS_OnPlayerClickPlayerTextDraw
#if defined MSS_OnPlayerClickPlayerTextDraw
	forward MSS_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);
#endif
forward OnModelSelectionResponseInvCH(playerid, extraid, index, modelid[], response);
forward OnModelSelectionMenuInvCH(playerid, extraid, selectType, response);