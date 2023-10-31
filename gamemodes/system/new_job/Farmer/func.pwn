SendFarmerJob(playerid, const msg_job[])
{
	new format_job[1280];
	format(format_job, sizeof(format_job), "{212c59}[FARMER]{FFFFFF}: %s", msg_job);
	SendClientMessage(playerid, COLOR_WHITE, format_job);
	return 1;
}

stock SetPlayerFarmer(playerid)
{
    for(new i = 0; i < MAX_FARM; ++i)
	{
		if(FarmInfo[i][OwnerPlayerId] == GetPlayerSQLId(playerid) && FarmInfo[i][Exsits])
		{
            if(FarmInfo[i][FarmType] == FARM_RENT)
            {
                new month, day, year, farmtimer;
                getdate(year,month,day);
                farmtimer = day*1000000 + month*10000 + year;
                if(farmtimer > FarmInfo[i][RentTimer])
                {
                    SendServerMessage(playerid, "Nong trai (ID: %d) da het thoi han thue, he thong tu dong tich thu tai san nong trai cua ban.");
                    SendServerMessage(playerid, "Cac du lieu cay trong va gia suc cua ban se duoc he thong luu tru va tai su dung cho lan so huu nong trai tiep theo cua ban.");
                    FarmClear(i);
                    return 1;
                }
            }
            PlayerInfo[playerid][pFarmerKey] = i;
            break;
		}
	}
    return 1;
}

stock FarmRemove(farmid)
{
    FarmInfo[farmid][Exsits] = false;
    if(IsValidDynamic3DTextLabel(FarmInfo[farmid][fTextID]))
        DestroyDynamic3DTextLabel(FarmInfo[farmid][TextLabel]);
    FarmInfo[farmid][OwnerPlayerId] = -1;
    FarmInfo[farmid][VirtualWorld] = 0;
    FarmInfo[farmid][ExteriorX] = 0.0;
    FarmInfo[farmid][ExteriorY] = 0.0;
    FarmInfo[farmid][ExteriorZ] = 0.0;
    FarmInfo[farmid][FarmType] = FARM_DEFAULT;
    FarmInfo[farmid][RentFee] = 0;
    FarmInfo[farmid][FarmPrice] = 0;
    FarmInfo[farmid][RentTimer]  = 0;
    PlayerInfo[playerid][pFarmerKey] = -1;
    if(IsValidDynamicPickup(FarmInfo[farmid][fPickupID])) DestroyDynamicPickup(FarmInfo[farmid][fPickupID]);
    return 1;
}

stock FarmClear(farmid)
{
    FarmInfo[farmid][OwnerPlayerId] = -1;
    FarmInfo[farmid][VirtualWorld] = 0;
    FarmInfo[farmid][ExteriorX] = 0.0;
    FarmInfo[farmid][ExteriorY] = 0.0;
    FarmInfo[farmid][ExteriorZ] = 0.0;
    FarmInfo[farmid][FarmType] = FARM_DEFAULT;
    FarmInfo[farmid][RentFee] = 0;
    FarmInfo[farmid][FarmPrice] = 0;
    FarmInfo[farmid][RentTimer]  = 0;
    Farm_Reload(farmid);
    return 1;
}

stock GetFarmFree()
{
    for(new i = 0; i < MAX_FARM; ++i)
	{
		if(!FarmInfo[i][Exsits])
		{
            return i;
		}
	}
    return -1;
}

stock Farm_Reload(farmid)
{
    new string[256];
    new month, day, year;
    getdate(year,month,day);
    if(FarmInfo[farmid][RentTimer] < (day*1000000 + month*10000 + year) && FarmInfo[farmid][FarmType] == FARM_RENT )
    {
        FarmInfo[farmid][FarmType] = 0;
        FarmInfo[farmid][RentTimer] = 0;
        FarmInfo[farmid][OwnerPlayerId] = -1; 
    }
    if(IsValidDynamicPickup(FarmInfo[farmid][fPickupID])) DestroyDynamicPickup(FarmInfo[farmid][fPickupID]);
    if(IsValidDynamic3DTextLabel(FarmInfo[farmid][fTextID]))
        DestroyDynamic3DTextLabel(FarmInfo[farmid][fTextID]);
    switch(FarmInfo[farmid][FarmType])
    {
        case FARM_DEFAULT:{
            format(string, sizeof(string), "Nong trai\nDang duoc mo ban\nChi phi mua: {6add89}$%s{FFFFFF}\nChi phi thue: {6add89}$%s/1 ngay{FFFFFF}\nID: {6add89}%d{ffffff}\nSu dung /thuenongtrai hoac /muanongtrai de thue hoac mua nong trai nay.", number_format(FarmInfo[farmid][FarmPrice]), number_format(FarmInfo[farmid][RentFee]), farmid);
			FarmInfo[farmid][fTextID] = CreateDynamic3DTextLabel(string, COLOR_WHITE, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]+0.5,10.0, .testlos = 1, .worldid = 0, .streamdistance = 10.0);
        }
        case FARM_RENT:{
            format(string, sizeof(string), "Nong trai\nNguoi Thue: {6add89}%s{ffffff}\nID: {6add89}%d{ffffff}", StripUnderscore(FarmInfo[farmid][OwnerName]), farmid);
			FarmInfo[farmid][fTextID]  = CreateDynamic3DTextLabel(string, COLOR_WHITE, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]+0.5,10.0, .testlos = 1, .worldid = 0, .streamdistance = 10.0);
        }
        case FARM_OWNER:{
            format(string, sizeof(string), "Nong trai\nChu so huu: {6add89}%s{ffffff}\nID: {6add89}%d{ffffff}", StripUnderscore(FarmInfo[farmid][OwnerName]), farmid);
			FarmInfo[farmid][fTextID]  = CreateDynamic3DTextLabel(string, COLOR_WHITE, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]+0.5,10.0, .testlos = 1, .worldid = 0, .streamdistance = 10.0);
        }
    }
    FarmInfo[farmid][fPickupID] = CreateDynamicPickup(2228, 23, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ], .worldid = 0, .streamdistance = 30.0);
    return 1;
}

stock Farm_AddDefault(playerid)
{
    new Float:playerPos[3];
    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
    new farmid = GetFarmFree();
    if(farmid == -1) return SendErrorMessage(playerid, "Da dat toi da so luong nong trai tai may chu, ban khong the tao them.");
    FarmInfo[farmid][Exsits] = true;
    FarmInfo[farmid][OwnerPlayerId] = -1;
    FarmInfo[farmid][VirtualWorld] = 0;
    FarmInfo[farmid][ExteriorX] = playerPos[0];
    FarmInfo[farmid][ExteriorY] = playerPos[1];
    FarmInfo[farmid][ExteriorZ] = playerPos[2];
    FarmInfo[farmid][FarmType] = FARM_DEFAULT;
    FarmInfo[farmid][RentFee] = 0;
    FarmInfo[farmid][FarmPrice] = 0;
    FarmInfo[farmid][RentTimer]  = 0;
    Farm_Reload(farmid);
    return farmid;
}

stock PlayerNearFarm(playerid, IsOwner = -1)
{
    new Float:playerPos[3];
    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
    if(IsOwner == -1)
    {
        for(new i = 0; i < sizeof(FarmInfo); i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 2.0, FarmInfo[i][ExteriorX], FarmInfo[i][ExteriorY], FarmInfo[i][ExteriorZ]))
            return i;
        }
    }
    else
    {
        for(new i = 0; i < sizeof(FarmInfo); i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 2.0, FarmInfo[i][ExteriorX], FarmInfo[i][ExteriorY], FarmInfo[i][ExteriorZ]) && IsOwner == FarmInfo[i][VirtualWorld])
            return i;
        }
    }
    return -1;
}

stock Rent_Farm(playerid, farmid)
{
    if(farmid == -1) return 1;
    if(FarmInfo[farmid][Exsits]) return SendErrorMessage(playerid, "Nong trai nay hien da co nguoi so huu.");
    if(PlayerInfo[playerid][pFarmerKey] != -1) return SendErrorMessage(playerid, "Ban da so huu nong trai roi, khong the mua them nong trai moi.");
    return  Dialog_Show(playerid, FarmRent, DIALOG_STYLE_INPUT, "Thue nong trai", "Xin vui long nhap so ngay ban muon thue. (Nhap '5' tuong ung voi 5 ngay)", "Xac Nhan", "<");
}


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


stock LeaveAreaFarm(playerid, areaid)
{
    if(areaid == PlayerFarmArea && GetPlayerVirtualWorld(playerid) == GetPlayerSQLId(playerid) && GetPVarInt(playerid, "IsPlayer_StreamPrep") < gettime())
	{
        new farmid = PlayerInfo[playerid][pFarmerKey];
        SetPlayerPos(playerid, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]);
        SendServerMessage(playerid, "Ban da roi khoi nong trai cua minh.");
        Player_StreamPrep(playerid, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ], FREEZE_TIME);
        SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 0);
    }
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          CATTLE
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
Get_CattleStatus(statuslevel)
{
	new str[256];
	switch(statuslevel)
	{
		case 0: str="{0af762}Binh thuong{FFFFFF}";
		case 1: str="{f7ef0a}Doi bung{FFFFFF}";
		case 2: str="{5678f5}Khat Nuoc{FFFFFF}";
        case 3: str="{6b09e3}Doi bung va khat nuoc{FFFFFF}";
		default: str="Khong xac dinh";
	}
	return str;
}

stock Cattle_AddDefault(cattileId)
{
    
}