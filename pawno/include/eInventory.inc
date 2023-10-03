// eSelection.inc - Rewritten version of mSelection.inc
// Created for Interactive Roleplay - 17/03/2013 @ 10:20 PM.

#if !defined MAX_MENU_ITEMS
	#define MAX_MENU_ITEMS (300)
#endif

#if !defined MAX_CUSTOM_ROTATIONS
	#define MAX_CUSTOM_ROTATIONS (50)
#endif

#if !defined SELECT_ICONUSER
	#define SELECT_ICONUSER (1)
#endif

#if !defined SELECT_ICONCAR
	#define SELECT_ICONCAR (2)
#endif

#if !defined SELECT_ICONSETTING
	#define SELECT_ICONSETTING (3)
#endif

#define MODEL_RESPONSE_CANCEL (0)
#define MODEL_RESPONSE_SELECT (1)
#define MAX_ITEMPAGE	(16)
#define MAX_ITEMLINE	(4)

enum g_ePlayerMenuEnum {
	PlayerText:g_eMenuTextdraws[15],
	PlayerText:g_eMenuItems[MAX_ITEMPAGE],
	PlayerText:g_eMenuAmounts[MAX_ITEMPAGE],
	PlayerText:g_eMenuNames[MAX_ITEMPAGE],
	PlayerText:g_eMenuSlots[MAX_ITEMPAGE],
	PlayerText:g_eMenuExpirys[MAX_ITEMPAGE],
	Float:g_eMenuRot[4],
	g_eMenuAmount[MAX_MENU_ITEMS],
	g_eMenuSlot[MAX_MENU_ITEMS],
	g_eMenuExpiry[MAX_MENU_ITEMS],
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
	g_ePlayerMenuModel[MAX_PLAYERS][MAX_MENU_ITEMS][64],
	g_ePlayerMenuData[MAX_PLAYERS][g_ePlayerMenuEnum],
	g_eMenuCustomRotation[MAX_CUSTOM_ROTATIONS][g_eItemRotationEnum]
;

// stock SetModelPreviewRotation(modelid, Float:x, Float:y, Float:z, Float:zoom = 1.0)
// {
// 	for (new i = 0; i != MAX_CUSTOM_ROTATIONS; i ++) if (!g_eMenuCustomRotation[i][g_eItemModel]) {
// 		g_eMenuCustomRotation[i][g_eItemModel] = modelid;
// 		g_eMenuCustomRotation[i][g_eItemRotX] = x;
// 		g_eMenuCustomRotation[i][g_eItemRotY] = y;
// 		g_eMenuCustomRotation[i][g_eItemRotZ] = z;
// 		g_eMenuCustomRotation[i][g_eItemZoom] = zoom;

// 		break;
// 	}
// 	return 0;
// }

stock HideModelSelectionInventory(playerid)
{
	if (!IsPlayerConnected(playerid) || !g_ePlayerMenuData[playerid][g_eMenuShown])
	    return 0;

	for (new i = 0; i < MAX_ITEMPAGE; i ++) {
		if(i < 15)	PlayerTextDrawDestroy(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][i]);
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

stock ShowModelSelectionInventory(playerid, header[] , extraid, items[][64], size = sizeof(items), bool:amount = false, amounts[] = {-1}, itemnames[120][32] = {"_",...}, bool:expiry=false, expirys[] = {0})
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
		g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	new
	    Float:x = 385.0,
	    Float:y = 190.0,
		str[64];
	g_ePlayerMenuData[playerid][g_eMenuTextdraws][0] = CreatePlayerTextDraw(playerid, 498.000, 180.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 6.000, 23.000);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 360.000, 190.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 825374975);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 741093631);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][0], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][1] = CreatePlayerTextDraw(playerid, 498.000, 178.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 0.300, 0.100);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 2.000, 190.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1583310847);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][1], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][2] = CreatePlayerTextDraw(playerid, 498.000, 152.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 0.300, 0.008);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 2.000, 190.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1583310847);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][2], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][3] = CreatePlayerTextDraw(playerid, 498.000, 155.000, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 0.300, 2.500);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 0.000, 190.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1061176831);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][3], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][4] = CreatePlayerTextDraw(playerid, 498.000, 123.500, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 0.300, 3.000);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 0.000, 190.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 404299519);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][4], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][5] = CreatePlayerTextDraw(playerid, 410.000, 130.000, header);
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 0.300, 1.500);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][5], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][6] = CreatePlayerTextDraw(playerid, 415.000, 157.500, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 0.300, 2.000);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 0.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 150);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][6], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][7] = CreatePlayerTextDraw(playerid, 533.000, 160.000, "PAGE 1");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 0.200, 1.200);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 2);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][8] = CreatePlayerTextDraw(playerid, 571.500, 159.000, "mdl-2023:btn_next");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 13.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][8], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][9] = CreatePlayerTextDraw(playerid, 509.500, 159.000, "mdl-2023:btn_prev");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 13.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][9], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][10] = CreatePlayerTextDraw(playerid, 440.000, 157.500, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 0.300, 2.000);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 0.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 150);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][10], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][11] = CreatePlayerTextDraw(playerid, 465.000, 157.500, "_");
	PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 0.300, 2.000);
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 0.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 2);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], -1);
	PlayerTextDrawUseBox(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);
	PlayerTextDrawBoxColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 150);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 150);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][11], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][12] = CreatePlayerTextDraw(playerid, 432.500, 158.500, "mdl-2023:icon_car");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 15.000, 16.500);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][12], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][13] = CreatePlayerTextDraw(playerid, 408.500, 158.500, "mdl-2023:icon_user");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 13.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][13], 1);

	g_ePlayerMenuData[playerid][g_eMenuTextdraws][14] = CreatePlayerTextDraw(playerid, 458.500, 159.000, "mdl-2023:icon_setting");
	PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 13.000, 15.000);
	PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 1);
	PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], -1);
	PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 0);
	PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 0);
	PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 255);
	PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 4);
	PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 1);
	PlayerTextDrawSetSelectable(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][14], 1);


	for(new idx = 0; idx < MAX_ITEMPAGE; idx++)
	{
		if (idx > 0 && (idx % MAX_ITEMLINE) == 0)
		{
			x = 430.0;
			y += 50.0;
		}
		else
		{
			x += 45.0;
		}
		if (idx < MAX_ITEMPAGE)
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
	x = 370.0,
	y = 194.0;
	new itemModel[64];
 	for (new i = 0, idx = 0; i != MAX_MENU_ITEMS; i ++)
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
			if (i < MAX_ITEMPAGE && strcmp(items[i], "_"))
			{
				if (idx > 0 && (idx % MAX_ITEMLINE) == 0)
				{
	   				x = 415.0;
	  	    		y += 50.0;
	  			}
	    		else
				{
	 	    		x += 45.0;
	        	}
	        	idx++;

	        	if (i < MAX_ITEMPAGE && strcmp(items[i], "_"))
				{
					g_ePlayerMenuData[playerid][g_eMenuItems][i] = CreatePlayerTextDraw(playerid, x, y, g_ePlayerMenuModel[playerid][i]);
					PlayerTextDrawTextSize(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], 30.000, 30.000);
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
						g_ePlayerMenuData[playerid][g_eMenuExpirys][i] = CreatePlayerTextDraw(playerid, x, y + 29.6, str);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuExpirys][i], 0.109, 0.680);
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
						g_ePlayerMenuData[playerid][g_eMenuAmounts][i] = CreatePlayerTextDraw(playerid, x + 27.0, y + 29.6, str);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 0.109, 0.680);
						PlayerTextDrawAlignment(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 2);
						PlayerTextDrawColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], -1);
						PlayerTextDrawSetShadow(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetOutline(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 0);
						PlayerTextDrawBackgroundColor(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 150);
						PlayerTextDrawFont(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);
						PlayerTextDrawSetProportional(playerid, g_ePlayerMenuData[playerid][g_eMenuAmounts][i], 1);

						g_ePlayerMenuData[playerid][g_eMenuNames][i] = CreatePlayerTextDraw(playerid, x + 7.0, y -5.0, itemnames[i]);
						PlayerTextDrawLetterSize(playerid, g_ePlayerMenuData[playerid][g_eMenuNames][i], 0.100, 0.680);
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
					// for (new j = 0; j != MAX_CUSTOM_ROTATIONS; j ++)
					// {
					// 	if (g_eMenuCustomRotation[j][g_eItemModel] == items[i])
					// 	{
					// 		PlayerTextDrawSetPreviewRot(playerid, g_ePlayerMenuData[playerid][g_eMenuItems][i], g_eMenuCustomRotation[j][g_eItemRotX], g_eMenuCustomRotation[j][g_eItemRotY], g_eMenuCustomRotation[j][g_eItemRotZ], g_eMenuCustomRotation[j][g_eItemZoom]);
					// 		break;
					// 	}
					// }
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
		
    for (new i = 0; i < MAX_ITEMPAGE; i ++) {
		if(i < 15)	PlayerTextDrawShow(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][i]);
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

stock ConvertSecondsToDuration(seconds)
{
    new result[64];
	new minutes = seconds/60;
    
	if (minutes >= 525600)
    {
        new years = minutes / 525600;
        format(result, sizeof(result), "%dy", years);
    }
	else if (minutes >= 43200)
    {
        new months = minutes / 43200;
        format(result, sizeof(result), "%dm", months);
    }
	else if (minutes >= 10080)
    {
        new weeks = minutes / 10080;
        format(result, sizeof(result), "%dw", weeks);
    }
    else if (minutes >= 1440)
    {
        new days = minutes / 1440;
        format(result, sizeof(result), "%dd", days);
    }
    else if (minutes >= 60)
    {
        new hours = minutes / 60;
        format(result, sizeof(result), "%dh", hours);
    }
    else
    {
        format(result, sizeof(result), "%dmin", minutes);
    }

    return result;
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
	    CallLocalFunction("OnModelSelectionResponseInv", "ddds[64]d", playerid, g_ePlayerMenuData[playerid][g_eMenuExtra], 0, "_", MODEL_RESPONSE_CANCEL);
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

	    format(str, 8, "Page %d", page);
	    PlayerTextDrawSetString(playerid, g_ePlayerMenuData[playerid][g_eMenuTextdraws][7], str);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if (!g_ePlayerMenuData[playerid][g_eMenuShown] || (GetTickCount() - g_ePlayerMenuData[playerid][g_eMenuTime]) < 600)
	{
		return CallLocalFunction("MS_OnPlayerClickPlayerTextDraw", "ii", playerid, _:playertextid);
	}
	if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][8])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] == g_ePlayerMenuData[playerid][g_eMenuPages])
			return 0;

		else
			Menu_SetPage(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] + 1);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][9])
	{
		if (g_ePlayerMenuData[playerid][g_eMenuPage] < 2)
			return 0;

		else
			Menu_SetPage(playerid, g_ePlayerMenuData[playerid][g_eMenuPage] - 1);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][12])
	{
		new extraid = g_ePlayerMenuData[playerid][g_eMenuExtra];
	    HideModelSelectionInventory(playerid);
		return CallLocalFunction("OnModelSelectionMenuInv", "ddd", playerid, extraid, SELECT_ICONCAR, MODEL_RESPONSE_SELECT);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][13])
	{
		new extraid = g_ePlayerMenuData[playerid][g_eMenuExtra];
	    HideModelSelectionInventory(playerid);
		return CallLocalFunction("OnModelSelectionMenuInv", "ddd", playerid, extraid, SELECT_ICONUSER, MODEL_RESPONSE_SELECT);
	}
	else if (playertextid == g_ePlayerMenuData[playerid][g_eMenuTextdraws][14])
	{
		new extraid = g_ePlayerMenuData[playerid][g_eMenuExtra];
	    HideModelSelectionInventory(playerid);
		return CallLocalFunction("OnModelSelectionMenuInv", "ddd", playerid, extraid, SELECT_ICONSETTING, MODEL_RESPONSE_SELECT);
	}
	else for (new i = 0; i < MAX_ITEMPAGE; i ++)
	{
		if (g_ePlayerMenuData[playerid][g_eMenuItems][i] == playertextid)
		{
			new
				index = (i + (g_ePlayerMenuData[playerid][g_eMenuPage] - 1) * MAX_ITEMPAGE),
				extraid = g_ePlayerMenuData[playerid][g_eMenuExtra],
				modelid[64];
			strcpy(modelid, g_ePlayerMenuModel[playerid][i], 64);
			HideModelSelectionInventory(playerid);
			CallLocalFunction("OnModelSelectionResponseInv", "ddds[64]d", playerid, extraid, index, modelid, MODEL_RESPONSE_SELECT);
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

forward OnModelSelectionResponseInv(playerid, extraid, index, modelid[], response);
forward OnModelSelectionMenuInv(playerid, extraid, selectType, response);