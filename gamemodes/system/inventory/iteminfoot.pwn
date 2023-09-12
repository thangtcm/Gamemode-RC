
stock GetItemModelObject(itemid) {
	new objectid; // 1486 nuoc
	switch(itemid) {
        case 2: objectid = 1486;
        case 3: objectid = 2814;
        case 4: objectid = 2769;
        case 5: objectid = 336;
        case 6: objectid = 346;
        case 7: objectid = 349;
        case 8: objectid = 347;
        case 9: objectid = 353;
        case 10: objectid = 355;
        case 11: objectid = 2035;
        case 12: objectid = 358;
        case 13: objectid = 1575;
        case 14: objectid = 1576;
        case 15: objectid = 1577;
        case 16: objectid = 1578;
        case 17: objectid = 1579;
	}
	return objectid;
}

stock CreateItemInFoot(playerid,itemid) {
	for(new i = 0; i < MAX_OBJECTS_ITEMS; i++) {
		if(ItemInfo[i][ObjectItemSet] == false) {
			new Float:Pos[3];
			GetPlayerPos(playerid, Pos[0],Pos[1],Pos[2]);
			ItemInfo[i][jtemPos][0] = Pos[0] , ItemInfo[i][jtemPos][1] = Pos[1] , ItemInfo[i][jtemPos][2] = Pos[2];
			ItemInfo[i][ObjectItemSet] = true;
			ItemInfo[i][ItemID] = itemid;
			ItemInfo[i][WorldID] = GetPlayerVirtualWorld(playerid);
			ItemInfo[i][Interior] = GetPlayerInterior(playerid);
			new str[100];
			format(str, sizeof str, "%s (%d)\nNgoi xuong va bam phim 'Y' de nhat", GetInventoryItemName(itemid),i);
			ItemInfo[i][ItemTextID] = CreateDynamic3DTextLabel(str, -1, Pos[0],Pos[1],Pos[2]-1, 20, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid));
			ItemInfo[i][ObjectID] = CreateDynamicObject(GetItemModelObject(itemid), Pos[0],Pos[1],Pos[2]-1, 0,0,0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			break ;
		}
	}  
	return 1; 
}
// 
