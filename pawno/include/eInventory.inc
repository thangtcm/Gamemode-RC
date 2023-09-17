// eSelection.inc - Rewritten version of mSelection.inc
// Created for Interactive Roleplay - 17/03/2013 @ 10:20 PM.

#if !defined MAX_MENU_ITEMS
	#define MAX_MENU_ITEMS (300)
#endif

#if !defined MAX_CUSTOM_ROTATIONS
	#define MAX_CUSTOM_ROTATIONS (50)
#endif

#define MODEL_RESPONSE_CANCEL (0)
#define MODEL_RESPONSE_SELECT (1)
#define MAX_ITEMPAGE	(15)

enum g_ePlayerMenuEnum {
	PlayerText:g_eMenuTextdraws[6],
	PlayerText:g_eMenuItems[MAX_ITEMPAGE],
	PlayerText:g_eMenuAmounts[MAX_ITEMPAGE],
	PlayerText:g_eMenuNames[MAX_ITEMPAGE],
	PlayerText:g_eMenuSlots[MAX_ITEMPAGE],
	Float:g_eMenuRot[4],
	g_eMenuModels[MAX_MENU_ITEMS],
	g_eMenuAmount[MAX_MENU_ITEMS],
	g_eMenuSlot[MAX_MENU_ITEMS],
	g_eMenuTotalItems,
	g_eMenuPage,
	g_eMenuPages,
	g_eMenuShown,
	g_eMenuExtra,
	g_eMenuIgnore,
	g_eMenuTime,
	g_eMenuType
};

enum g_eItemRotationEnum {
	g_eItemModel,
	Float:g_eItemRotX,
	Float:g_eItemRotY,
	Float:g_eItemRotZ,
	Float:g_eItemZoom
};

static stock
	g_ePlayerMenuName[MAX_PLAYERS][MAX_MENU_ITEMS][32],
	g_ePlayerMenuData[MAX_PLAYERS][g_ePlayerMenuEnum],
	g_eMenuCustomRotation[MAX_CUSTOM_ROTATIONS][g_eItemRotationEnum]
;

stock SetModelPreviewRotation(modelid, Float:x, Float:y, Float:z, Float:zoom = 1.0)
{
	for (new i = 0; i != MAX_CUSTOM_ROTATIONS; i ++) if (!g_eMenuCustomRotation[i][g_eItemModel]) {
		g_eMenuCustomRotation[i][g_eItemModel] = modelid;
		g_eMenuCustomRotation[i][g_eItemRotX] = x;
		g_eMenuCustomRotation[i][g_eItemRotY] = y;
		g_eMenuCustomRotation[i][g_eItemRotZ] = z;
		g_eMenuCustomRotation[i][g_eItemZoom] = zoom;

		break;
	}
	return 0;
}

stock HideModelSelectionInventory(playerid)
{
	if (!IsPlayerConnected(playerid) || !g_ePlayerMenuData[playerid][g_eMenuShown])
	    return 0;

	for (new i = 0; i < MAX_ITEMPAGE; i ++) {
		if(i < 4)	PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][i]);
		PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][i]);
	}
	for (new i = 0; i != MAX_MENU_ITEMS; i ++)
	{
	    if (i < MAX_ITEMPAGE)
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
			if (g_ePlayerMenuData[playerid][g_eMenuNames][i] != PlayerText:INVALID_TEXT_DRAW)
	    	{
                PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i]);
                g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
			}
		}
		g_ePlayerMenuData[playerid][g_eMenuModels][i] = -1;
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

stock ShowModelSelectionInventory(playerid, extraid, items[], size = sizeof(items), Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fZoom = 1.0, carcol = -1, bool:amount = false, amounts[] = {-1}, itemnames[120][32] = {"_",...})
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	if (size > MAX_MENU_ITEMS)
	    return printf("** Warning: Please increase \"MAX_MENU_ITEMS\" if you want to create more items.");

	if (g_ePlayerMenuData[playerid][g_eMenuShown])
	{
	    HideModelSelectionInventory(playerid);
	}
	for (new i = 0; i < MAX_ITEMPAGE; i ++) {
	    g_ePlayerMenuData[playerid][g_eMenuItems][i] = PlayerText:INVALID_TEXT_DRAW;
		g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = PlayerText:INVALID_TEXT_DRAW;
		g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	new
	    Float:x = 85.0,
	    Float:y = 111.0,
		page[8],
		str[16];
	format(page, 8, "1/%d", (size / MAX_ITEMPAGE) + 1);
	g_ePlayerMenuData[playerid][g_eMenuTextdraws][0] = CreatePlayerTextDraw(playerid, 146.464, 92.583, "mdl-2020:main_inv");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 350.000, 280.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 4);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 0);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 0);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][1] = CreatePlayerTextDraw(playerid, 315.000, 335.000, page);
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 0);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][2] = CreatePlayerTextDraw(playerid, 470.000, 330.000, "mdl-2020:btn_right");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 19.000, 26.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 4);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 0);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][3] = CreatePlayerTextDraw(playerid, 155.000, 330.000, "mdl-2020:btn_left");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 19.000, 26.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 4);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 0);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);

	for(new idx = 0; idx < MAX_ITEMPAGE; idx++)
	{
		if (idx > 0 && (idx % 5) == 0)
		{
			x = 155.0;
			y += 72.0;
		}
		else
		{
			x += 68.0;
		}
		if (idx < MAX_ITEMPAGE)
		{
			g_ePlayerMenuData[playerid][g_eMenuSlots][idx] = CreatePlayerTextDraw(playerid, x, y, "mdl-2020:slot");
			PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 61.000, 54.000);
			PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 1);
			PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], -1);
			PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 0);
			PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 0);
			PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 255);
			PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 4);
			PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][0], 0);
			PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][idx], 0);
		}
	}
	x = 90.0,
	y = 114.0;
 	for (new i = 0, idx = 0; i != MAX_MENU_ITEMS; i ++)
	{
 		if (i >= size)
 		{
 	        g_ePlayerMenuData[playerid][g_eMenuModels][i] = -1;
 	    }
 	    else
		{
		    if (items[i] == -1)
			{
                g_ePlayerMenuData[playerid][g_eMenuModels][i] = -1;
                g_ePlayerMenuData[playerid][g_eMenuAmount][i] = 0;
				strcpy(g_ePlayerMenuName[playerid][i], "_", 32);
      		}
	  		else
	  		{
	   			g_ePlayerMenuData[playerid][g_eMenuTotalItems]++;
				g_ePlayerMenuData[playerid][g_eMenuModels][i] = items[i];
				strcpy(g_ePlayerMenuName[playerid][i], itemnames[i], 32);
				if (amount) {
	                g_ePlayerMenuData[playerid][g_eMenuAmount][i] = amounts[i];
				}
			}
			if (i < MAX_ITEMPAGE && items[i] != -1)
			{
				if (idx > 0 && (idx % 5) == 0)
				{
	   				x = 160.0;
	  	    		y += 72.0;
	  			}
	    		else
				{
	 	    		x += 67.0;
	        	}
	        	idx++;

	        	if (i < MAX_ITEMPAGE && items[i] != -1)
				{
					// format(strs, sizeof(strs), "X %f Y %f ID %d", x, y, i);
					// SendClientMessageEx(playerid, 0x00FF00FF, strs);
					g_ePlayerMenuData[playerid][g_eMenuItems][i] = CreatePlayerTextDraw(playerid, x, y, "_");
					PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 52.000, 47.000);
					PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 1);
					PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], -1);
					PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0);
					PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0);
					PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 85);
					PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 5);
					PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0);
					PlayerTextDrawSetPreviewModel(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], items[i]);
					PlayerTextDrawSetPreviewRot(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0.000, 0.000, 0.000, 1.000);
					PlayerTextDrawSetPreviewVehCol(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 0, 0);
					PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 1);
					if (amount && amounts[i] != -1)
					{
					    format(str, 16, "%d", amounts[i]);
						g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = CreatePlayerTextDraw(playerid, x + 40.0, y + 34.0, str);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 0.300, 1.500);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);

						g_ePlayerMenuData[playerid][g_eMenuNames][i]  = CreatePlayerTextDraw(playerid, x + 18, y + 54.0, itemnames[i]);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 0.219, 0.999);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 1);
					}
					else
					{
					    g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = PlayerText:INVALID_TEXT_DRAW;
						g_ePlayerMenuData[playerid][g_eMenuNames][i] = PlayerText:INVALID_TEXT_DRAW;
					}
                    if (carcol != -1)
                    {
						PlayerTextDrawSetPreviewVehCol(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], carcol, carcol);
					}
					for (new j = 0; j != MAX_CUSTOM_ROTATIONS; j ++)
					{
						if (g_eMenuCustomRotation[j][g_eItemModel] == items[i])
						{
							PlayerTextDrawSetPreviewRot(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], g_eMenuCustomRotation[j][g_eItemRotX], g_eMenuCustomRotation[j][g_eItemRotY], g_eMenuCustomRotation[j][g_eItemRotZ], g_eMenuCustomRotation[j][g_eItemZoom]);
							break;
						}
					}
				}
			}
		}
	}
	g_ePlayerMenuData[playerid][g_eMenuExtra] = extraid;
	g_ePlayerMenuData[playerid][g_eMenuShown] = true;
	g_ePlayerMenuData[playerid][g_eMenuPage] = 1;
	g_ePlayerMenuData[playerid][g_eMenuPages] = (size / MAX_ITEMPAGE) + 1;
	g_ePlayerMenuData[playerid][g_eMenuTime] = GetTickCount();
	g_ePlayerMenuData[playerid][g_eMenuType] = 1;

    g_ePlayerMenuData[playerid][g_eMenuRot][0] = fRotX;
    g_ePlayerMenuData[playerid][g_eMenuRot][1] = fRotY;
    g_ePlayerMenuData[playerid][g_eMenuRot][2] = fRotZ;
    g_ePlayerMenuData[playerid][g_eMenuRot][3] = fZoom;
		
    for (new i = 0; i < MAX_ITEMPAGE; i ++) {
		if(i < 4)	PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][i]);
		PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuSlots][i]);
	}

	for (new i = 0; i < MAX_ITEMPAGE; i ++) if (g_ePlayerMenuData[playerid][g_eMenuModels][i] != -1) {
		if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i] != PlayerText:INVALID_TEXT_DRAW) {
	    	PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i]);
	        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i]);
			PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i]);
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
	    return CallLocalFunction("MS_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
	}
	else if ((clickedid == Text:INVALID_TEXT_DRAW && g_ePlayerMenuData[playerid][g_eMenuShown]))
	{
	    CallLocalFunction("OnModelSelectionResponseInv", "ddddd", playerid, g_ePlayerMenuData[playerid][g_eMenuExtra], 0, 0, MODEL_RESPONSE_CANCEL);
	    HideModelSelectionInventory(playerid);
	}
	return CallLocalFunction("MS_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
}

stock Menu_SetPage(playerid, page)
{
	if (g_ePlayerMenuData[playerid][g_eMenuShown])
	{
	    if (page < 1 || page > g_ePlayerMenuData[playerid][g_eMenuPages])
		    return 0;

	    new
			start = (MAX_ITEMPAGE * (page - 1)),
			str[16];

		for (new i = 0; i < MAX_ITEMPAGE; i ++) {
			PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i]);
		}
		for (new i = start; i != start + MAX_ITEMPAGE && i < MAX_MENU_ITEMS; i ++)
		{
  			if (g_ePlayerMenuData[playerid][g_eMenuModels][i] == -1)
  			{
     			PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);

		        if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
    			    PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);
					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);
				}
			}
			else
			{

				PlayerTextDrawSetPreviewRot(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start], g_ePlayerMenuData[playerid][g_eMenuRot][0], g_ePlayerMenuData[playerid][g_eMenuRot][1], g_ePlayerMenuData[playerid][g_eMenuRot][2], g_ePlayerMenuData[playerid][g_eMenuRot][3]);

				for (new j = 0; j != MAX_CUSTOM_ROTATIONS; j ++)
				{
					if (g_eMenuCustomRotation[j][g_eItemModel] == g_ePlayerMenuData[playerid][g_eMenuModels][i])
					{
						PlayerTextDrawSetPreviewRot(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start], g_eMenuCustomRotation[j][g_eItemRotX], g_eMenuCustomRotation[j][g_eItemRotY], g_eMenuCustomRotation[j][g_eItemRotZ], g_eMenuCustomRotation[j][g_eItemZoom]);
						break;
					}
				}
				PlayerTextDrawSetPreviewModel(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start], g_ePlayerMenuData[playerid][g_eMenuModels][i]);
		        PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);
		        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i - start]);

		        if (g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start] != PlayerText:INVALID_TEXT_DRAW)
				{
				    format(str, sizeof(str), "%d", g_ePlayerMenuData[playerid][g_eMenuAmount][i]);
					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start], str);

					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);
			        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i - start]);

					PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start], g_ePlayerMenuName[playerid][i - start]);

					PlayerTextDrawHide(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);
			        PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i - start]);
				}
			}
		}
	    g_ePlayerMenuData[playerid][g_eMenuPage] = page;

	    format(str, 8, "%d/%d", page, g_ePlayerMenuData[playerid][g_eMenuPages]);
	    PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], str);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if (!g_ePlayerMenuData[playerid][g_eMenuShown] || (GetTickCount() - g_ePlayerMenuData[playerid][g_eMenuTime]) < 600)
	{
		return CallLocalFunction("MS_OnPlayerClickPlayerTextDraw", "ii", playerid, _:playertextid);
	}
	if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][2])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] == g_ePlayerMenuData[playerid][g_eMenuPages])
			return 0;

		else
			Menu_SetPage(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] + 1);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][3])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] < 2)
			return 0;

		else
			Menu_SetPage(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] - 1);
	}
	else for (new i = 0; i < MAX_ITEMPAGE; i ++)
	{
		if (g_ePlayerMenuData[playerid][g_eMenuItems][i] == playertextid)
		{
			new
				index = (i + (g_ePlayerMenuData[playerid][g_eMenuPage] - 1) * MAX_ITEMPAGE),
				extraid = g_ePlayerMenuData[playerid][g_eMenuExtra],
				modelid = g_ePlayerMenuData[playerid][g_eMenuModels][index];

			HideModelSelectionInventory(playerid);
			CallLocalFunction("OnModelSelectionResponseInv", "ddddd", playerid, extraid, index, modelid, MODEL_RESPONSE_SELECT);
			break;
		}
	}
	return CallLocalFunction("MS_OnPlayerClickPlayerTextDraw", "dd", playerid, _:playertextid);
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

#define OnPlayerClickTextDraw MS_OnPlayerClickTextDraw
#define OnPlayerClickPlayerTextDraw MS_OnPlayerClickPlayerTextDraw

forward MS_OnPlayerClickTextDraw(playerid, Text:clickedid);
forward MS_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);

forward OnModelSelectionResponseInv(playerid, extraid, index, modelid, response);