enum PLANT_INFO{
	Id,
	plantLevel,
    OwnerPlayerId,
	plantType,
	plantTimer,
	ObjectSpawn,
	Text3D:PlantText,
	Float:plantPos[3],
    Exsits
}

enum TreeGolbal{
	PlantName[32],
	PlantBuy,
	PlantSell,
	PlantProduct[32]
}

new PlantArr[][TreeGolbal] ={
	{"Hat Giong Lua", 5, 15, "Lua"},
	{"Hat Giong Duoc Lieu", 35, 65, "Thao Duoc"}
};
new PlantTreeInfo[MAX_PLAYERS][MAX_PLAYER_PLANT][PLANT_INFO];
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          PLANT
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~

stock GetPlantFree(playerid)
{
    for(new i = 0; i < MAX_PLAYER_PLANT; ++i)
	{
		if(!PlantTreeInfo[playerid][i][Exsits])
		{
            return i;
		}
	}
    return -1;
}

stock SavePlantPlayer(playerid)
{
    for(new i = 0; i < MAX_PLAYER_PLANT; ++i)
	{
		if(!PlantTreeInfo[playerid][i][Exsits])
		{
            PLANT_UPDATE(playerid, i);
		}
	}
    return -1;
}

stock PlantTree_Reload(playerid, plantid)
{
    new string[256];
    if(IsValidDynamic3DTextLabel(PlantTreeInfo[playerid][plantid][PlantText]))
    {
        DestroyDynamic3DTextLabel(PlantTreeInfo[playerid][plantid][PlantText]);
        PlantTreeInfo[playerid][plantid][PlantText] = Text3D: INVALID_3DTEXT_ID;
    }
    if(IsValidDynamicObject(PlantTreeInfo[playerid][plantid][ObjectSpawn]))
    {
        DestroyDynamicObject(PlantTreeInfo[playerid][plantid][ObjectSpawn]);
        PlantTreeInfo[playerid][plantid][ObjectSpawn] = INVALID_OBJECT_ID;
    }
    new plantObject = 19837, playerVW = GetPlayerSQLId(playerid);
    switch(PlantTreeInfo[playerid][plantid][plantLevel])
    {
        case 1:{
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Thu hoach: {FF0000}Chua{FFFFFF}",
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
            if(PlantTreeInfo[playerid][plantid][plantTimer] < PLANT_TINE_LEVEL_1 && PlantTreeInfo[playerid][plantid][plantTimer] != 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_1) : PLANT_TINE_LEVEL_1 * 3;
            }
        }
        case 2:{
            plantObject = 19473;
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Thu hoach: {FF0000}Chua{FFFFFF}", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
            if(PlantTreeInfo[playerid][plantid][plantTimer] < PLANT_TINE_LEVEL_2 && PlantTreeInfo[playerid][plantid][plantTimer] != 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_2) : PLANT_TINE_LEVEL_2 * 3;
            }
        }
        case 3:{
            plantObject = 804;
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Su dung {212c58}/thuhoach{FFFFFF} de thu hoach", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
            PlantTreeInfo[playerid][plantid][plantPos][2] = Plant_ZDefault + 1.0;
            if(PlantTreeInfo[playerid][plantid][plantTimer] < PLANT_TINE_LEVEL_3 && PlantTreeInfo[playerid][plantid][plantTimer] != 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_3) : PLANT_TINE_LEVEL_3 * 3;
            }
        }
    }
    PlantTreeInfo[playerid][plantid][PlantText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, 
        PlantTreeInfo[playerid][plantid][plantPos][0],
        PlantTreeInfo[playerid][plantid][plantPos][1],
        PlantTreeInfo[playerid][plantid][plantPos][2]+0.5, 5.0, .testlos = 1, .worldid = playerVW, .streamdistance = 10.0);
    PlantTreeInfo[playerid][plantid][ObjectSpawn] = CreateDynamicObject(plantObject, 
        PlantTreeInfo[playerid][plantid][plantPos][0],
        PlantTreeInfo[playerid][plantid][plantPos][1],
        PlantTreeInfo[playerid][plantid][plantPos][2], 0.000000, 0.000000, 0.000000, .interiorid = -1, .worldid = playerVW, .playerid=-1, .streamdistance = 100);
    return 1;
}

stock PlantTree_Update(playerid, plantid)
{
    new string[256];
    if(--PlantTreeInfo[playerid][plantid][plantTimer] <= 0)
    {
        if(PlantTreeInfo[playerid][plantid][plantLevel] == 3) return 1;
        PlantTreeInfo[playerid][plantid][plantLevel]++;
        PlantTreeInfo[playerid][plantid][plantTimer] = 0;
        PlantTree_Reload(playerid, plantid);
        return 1;
    }
    switch(PlantTreeInfo[playerid][plantid][plantLevel])
    {
        case 1:{
            
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Thu hoach: {FF0000}Chua{FFFFFF}", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
            
        }
        case 2:{
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Thu hoach: {FF0000}Chua{FFFFFF}", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
        }
        case 3:{
            format(string, sizeof(string), 
                "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
                Cap do: {212c58}%d{FFFFFF}\n\
                Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
                Chu so huu: {212c58}%s{FFFFFF}\n\
                Su dung {212c58}/thuhoach{FFFFFF} de thu hoach", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
                plantid,
                PlantTreeInfo[playerid][plantid][plantLevel],
                PlantTreeInfo[playerid][plantid][plantTimer],
                GetPlayerNameEx(playerid)
            );
        }
    }
    UpdateDynamic3DTextLabelText(PlantTreeInfo[playerid][plantid][PlantText], COLOR_WHITE, string);
    return 1;
}

stock PlantTree_Timer(playerid)
{
    for(new i= 0; i < MAX_PLAYER_PLANT; i++)
    {
        if(PlantTreeInfo[playerid][i][Exsits] && PlayerInfo[playerid][pFarmerKey] != -1)
        {
            PlantTree_Update(playerid, i);
        }
    }
}

stock PlantTree_Near(playerid, Float:range)
{
    for(new i= 0; i < MAX_PLAYER_PLANT; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, range, 
            PlantTreeInfo[playerid][i][plantPos][0], 
            PlantTreeInfo[playerid][i][plantPos][1], 
            PlantTreeInfo[playerid][i][plantPos][2]) && PlantTreeInfo[playerid][i][Exsits])
            return i;
    }
    return -1;
}

stock PlantTree_Add(playerid, type)
{
    if(!IsPlayerInDynamicArea(playerid, FarmPlantArea) || GetPlayerVirtualWorld(playerid) != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong o trong khu vuc trong cay cua ban.");
    if(PlantTree_Near(playerid, 3.0) != -1) return SendErrorMessage(playerid, "Ban khong the trong cay trong pham vi dang co cay trong khac.");
    if(Inventory_Count(playerid, PlantArr[type][PlantName]) <= 0) SendErrorMessage(playerid, "Ban khong co giong cay de trong cay.");
    new plantId = GetPlantFree(playerid);
    if(plantId == -1)   return SendErrorMessage(playerid, "Ban khong the trong cay them nua.");
    new playerinvId = Inventory_GetItemID(playerid, PlantArr[type][PlantName]);
    Inventory_Remove(playerid, playerinvId);
    GetPlayerPos(playerid, PlantTreeInfo[playerid][plantId][plantPos][0], PlantTreeInfo[playerid][plantId][plantPos][1], PlantTreeInfo[playerid][plantId][plantPos][2]);
    PlantTreeInfo[playerid][plantId][plantPos][2] = Plant_ZDefault;
    PlantTreeInfo[playerid][plantId][plantLevel] = 1;
    PlantTreeInfo[playerid][plantId][plantType] = type;
    PlantTreeInfo[playerid][plantId][plantTimer] = PLANT_TINE_LEVEL_1;
    ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_Out", 4.1, false, 0, 0, 0, 3000, 1);
	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~Dang gieo giong...~w~ Xin vui long doi.", 3000, 3);
    SetTimerEx("DangGieoGiong", 3000, false, "ii", playerid, plantId);
    return 1;
}

public DangGieoGiong(playerid, plantId)
{
	SendServerMessage(playerid, "Ban da gieo giong");
    PlantTree_Reload(playerid, plantId);
    ClearAnimations(playerid);
    PLANT_ADD(playerid, plantId);
    return 1;
}

stock PlantTree_Remove(playerid, plantId)
{
    PlantTreeInfo[playerid][plantId][Exsits] = false;
    PlantTreeInfo[playerid][plantId][Id] = 0;
    PlantTreeInfo[playerid][plantId][plantPos][2] = 0.0;
    PlantTreeInfo[playerid][plantId][plantLevel] = 0;
    PlantTreeInfo[playerid][plantId][plantType] = 0;
    if(IsValidDynamic3DTextLabel(PlantTreeInfo[playerid][plantId][PlantText]))
    {
        DestroyDynamic3DTextLabel(PlantTreeInfo[playerid][plantId][PlantText]);
        PlantTreeInfo[playerid][plantId][PlantText] = Text3D: INVALID_3DTEXT_ID;
    }
    if(IsValidDynamicObject(PlantTreeInfo[playerid][plantId][ObjectSpawn]))
    {
        DestroyDynamicObject(PlantTreeInfo[playerid][plantId][ObjectSpawn]);
        PlantTreeInfo[playerid][plantId][ObjectSpawn] = INVALID_OBJECT_ID;
    }
    return 1;
}