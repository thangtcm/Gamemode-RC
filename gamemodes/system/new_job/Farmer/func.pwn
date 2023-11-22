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
                    ActSetPlayerPos(playerid, FarmInfo[i][ExteriorX], FarmInfo[i][ExteriorY], FarmInfo[i][ExteriorZ]);
                    PlayerInfo[playerid][pFarmerKey] = -1;
                    FarmClear(i);
                    return 1;
                }
            }
            PlayerInfo[playerid][pFarmerKey] = i;
            return 1;
		}
        else
        {
            PlayerInfo[playerid][pFarmerKey] = -1;
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

stock PlantTree_GetNameLevel(treeLevel)
{
    new name[128];
    switch(treeLevel)
    {
        case 1, 2:{
            name = "Thu hoach: {FF0000}Chua{FFFFFF}";
        }
        case 3: {
            name = "Su dung {212c58}/thuhoach{FFFFFF} de thu hoach";
        }
    }
    return name;
}

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
    new string[560];
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
            if(PlantTreeInfo[playerid][plantid][plantTimer] > 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_1) : PLANT_TINE_LEVEL_1 * 3;
            }
        }
        case 2:{
            // if(PlantTreeInfo[playerid][plantid][plantType] == 2)
            //     plantObject = 894;
            // else
                plantObject = 19473;
            if(PlantTreeInfo[playerid][plantid][plantTimer] > 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_2) : PLANT_TINE_LEVEL_2 * 3;
            }
        }
        case 3:{
            // if(PlantTreeInfo[playerid][plantid][plantType] == 2)
            // {
            //     plantObject = 894;
            //     PlantTreeInfo[playerid][plantid][plantPos][2] = Plant_ZDefault;
            // }
            // else
            // {
                plantObject = 804;
                PlantTreeInfo[playerid][plantid][plantPos][2] = Plant_ZDefault + 1.0;

            // }
            if(PlantTreeInfo[playerid][plantid][plantTimer] > 0)
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantTimer];
            }
            else
            {
                PlantTreeInfo[playerid][plantid][plantTimer] = PlantTreeInfo[playerid][plantid][plantType] == 0 ? (PLANT_TINE_LEVEL_3) : PLANT_TINE_LEVEL_3 * 3;
            }
        }
    }
    switch(PlantTreeInfo[playerid][plantid][plantType])
    {
        case 0, 1:
        {
            format(string, sizeof(string), 
            "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
            Cap do: {212c58}%d{FFFFFF}\n\
            Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
            Chu so huu: {212c58}%s{FFFFFF}\n\
            %s", 
            PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
            plantid,
            PlantTreeInfo[playerid][plantid][plantLevel],
            PlantTreeInfo[playerid][plantid][plantTimer],
            GetPlayerNameEx(playerid),
            PlantTree_GetNameLevel(PlantTreeInfo[playerid][plantid][plantLevel])
            );
        }
        case 2:{
            format(string, sizeof(string), 
            "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
            Cap do: {212c58}%d{FFFFFF}\n\
            Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
            Chu so huu: {212c58}%s{FFFFFF}\n\
            Trang thai: %s\n\
            Su dung {212c58}/plantfeed va /thuhoach{FFFFFF} de thao tac", 
            PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
            plantid,
            PlantTreeInfo[playerid][plantid][plantLevel],
            PlantTreeInfo[playerid][plantid][plantTimer],
            GetPlayerNameEx(playerid),
            Plant_GetNameStatus(PlantTreeInfo[playerid][plantid][plantStatus])
            );
        }
    }
    PlantTreeInfo[playerid][plantid][PlantText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, 
        PlantTreeInfo[playerid][plantid][plantPos][0],
        PlantTreeInfo[playerid][plantid][plantPos][1],
        PlantTreeInfo[playerid][plantid][plantPos][2]+0.5, 5.0, .testlos = 1, .worldid = playerVW, .streamdistance = 20.0);
    PlantTreeInfo[playerid][plantid][ObjectSpawn] = CreateDynamicObject(plantObject, 
        PlantTreeInfo[playerid][plantid][plantPos][0],
        PlantTreeInfo[playerid][plantid][plantPos][1],
        PlantTreeInfo[playerid][plantid][plantPos][2], 0.000000, 0.000000, 0.000000, .interiorid = -1, .worldid = playerVW, .playerid=-1, .streamdistance = 100);
    Streamer_Update(playerid);
    return 1;
}

stock PlantTree_Update(playerid, plantid)
{
    new string[560];
    if(!PlantTreeInfo[playerid][plantid][Exsits]) return 1;
    PlantTreeInfo[playerid][plantid][plantTimer]--;
    if(PlantTreeInfo[playerid][plantid][plantTimer] < 0 && PlantTreeInfo[playerid][plantid][plantType] == 2)
    {
        if(PlantTreeInfo[playerid][plantid][plantStatus] > 0 && PlantTreeInfo[playerid][plantid][plantStatus] < 3)
        {
            format(string, sizeof(string), "Cay trong %s (ID: %d) cua ban da bi heo vi %s.", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName],
                plantid,
                Plant_GetNameStatus(PlantTreeInfo[playerid][plantid][plantStatus]));
            SendClientMessageEx(playerid, COLOR_WHITE, string);
            PLANT_DELETE(playerid, plantid);
        }
        if(PlantTreeInfo[playerid][plantid][plantStatus] == 0)
        {
            PlantTreeInfo[playerid][plantid][plantStatus] = random(1) + 1;
            PlantTreeInfo[playerid][plantid][plantTimer] = 240; // 4p
            new str[128];
            format(str, sizeof(str), "Cay trong %s (ID: %d) cua ban dang bi %s, ban co 4 phut de cham soc no truoc khi bi heo.", 
                PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName],
                plantid,
                Plant_GetNameStatus(PlantTreeInfo[playerid][plantid][plantStatus]));
            SendClientMessageEx(playerid, COLOR_WHITE, str);
        }
        return 1;
    }
    if(PlantTreeInfo[playerid][plantid][plantTimer] < 0 && PlantTreeInfo[playerid][plantid][plantType] != 2)
    {
        if(PlantTreeInfo[playerid][plantid][plantLevel] == 3) return 1;
        PlantTreeInfo[playerid][plantid][plantLevel]++;
        PlantTreeInfo[playerid][plantid][plantTimer] = 0;
        PlantTree_Reload(playerid, plantid);
        return 1;
    }
    switch(PlantTreeInfo[playerid][plantid][plantType])
    {
        case 0, 1:
        {
            format(string, sizeof(string), 
            "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
            Cap do: {212c58}%d{FFFFFF}\n\
            Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
            Chu so huu: {212c58}%s{FFFFFF}\n\
            %s", 
            PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
            plantid,
            PlantTreeInfo[playerid][plantid][plantLevel],
            PlantTreeInfo[playerid][plantid][plantTimer],
            GetPlayerNameEx(playerid),
            PlantTree_GetNameLevel(PlantTreeInfo[playerid][plantid][plantLevel])
            );
        }
        case 2:{
            format(string, sizeof(string), 
            "Cay {212c58}%s{FFFFFF}(ID:%d)\n\
            Cap do: {212c58}%d{FFFFFF}\n\
            Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
            Chu so huu: {212c58}%s{FFFFFF}\n\
            Trang thai: %s\n\
            Su dung {212c58}/plantfeed va /thuhoach{FFFFFF} de thao tac", 
            PlantArr[PlantTreeInfo[playerid][plantid][plantType]][PlantName], 
            plantid,
            PlantTreeInfo[playerid][plantid][plantLevel],
            PlantTreeInfo[playerid][plantid][plantTimer],
            GetPlayerNameEx(playerid),
            Plant_GetNameStatus(PlantTreeInfo[playerid][plantid][plantStatus])
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

stock Plant_GetNameStatus(type)
{
    return PlantStatusArr[type];
}

stock PlantTree_Add(playerid, type)
{
    if((!IsPlayerInDynamicArea(playerid, FarmPlantArea) && !IsPlayerInDynamicArea(playerid, FarmPlantOrangeArea)) || GetPlayerVirtualWorld(playerid) != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong o trong khu vuc trong cay.");
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
    PlantTreeInfo[playerid][plantId][plantStatus] = 0;
    PlantTreeInfo[playerid][plantId][plantAmount] = 0;
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
        ActSetPlayerPos(playerid, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]);
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
stock GetCattleStatus(statuslevel)
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

stock GetCattleName(cattleType)
{
    new name_str[32];
	switch(cattleType){
		case 0:name_str = "Bo";
		case 1: name_str = "Nai";
		default: name_str = "Khong xac dinh";
	}
	return name_str;
}

stock LoadPutCattle(playerid)
{
    for(new i; i  < MAX_CATTLES; i++)
    {
        if(i < 8)
        {
            CattlePosData[playerid][i][PosX] = CattlePosDefault[0][0];
            CattlePosData[playerid][i][PosY] = CattlePosDefault[0][1] + 1.5*i;
            CattlePosData[playerid][i][PosZ] = CattlePosDefault[0][2];
            CattlePosData[playerid][i][RotZ] = CattlePosDefault[0][3];
            CattlePosData[playerid][i][Exsits] = false;
        }
        else
        {
            CattlePosData[playerid][i][PosX] = CattlePosDefault[1][0];
            CattlePosData[playerid][i][PosY] = CattlePosDefault[1][1] + 1.6*(i%8);
            CattlePosData[playerid][i][PosZ] = CattlePosDefault[1][2];
            CattlePosData[playerid][i][RotZ] = CattlePosDefault[1][3];
            CattlePosData[playerid][i][Exsits] = false;
        }
    }
}

stock GetCattlePosFree(playerid)
{
    for(new i; i < MAX_CATTLES; i++)
    {
        if(!CattlePosData[playerid][i][Exsits])
            return i;
    }
    return -1;
}


stock CATTLE_FREEID(playerid)
{
    for(new i; i < MAX_CATTLES; i++)
    {
        if(!RaiseCattleInfo[playerid][i][Exsits])
            return i;
    }
    return -1;
}

stock Cattle_AddDefault(playerid, animal_type)
{
    new cattlePos = GetCattlePosFree(playerid);
    new index = CATTLE_FREEID(playerid);
    if(index > 3 || index == -1) return SendErrorMessage(playerid, "Ban chi co the nuoi toi da 3 gia suc.");
    if(cattlePos == -1) return SendErrorMessage(playerid, "Ban khong con vi tri de nuoi.");
    if(!IsPlayerInDynamicArea(playerid, PlayerFarmArea) || GetPlayerVirtualWorld(playerid) != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong o trong khu vuc nong trai cua ban.");
    if(Inventory_Count(playerid, AnimalArr[animal_type][AnimalName]) <= 0) SendErrorMessage(playerid, "Ban khong co giong nuoi nay.");
    new playerinvId = Inventory_GetItemID(playerid, AnimalArr[animal_type][AnimalName]);
    Inventory_Remove(playerid, playerinvId);
    RaiseCattleInfo[playerid][index][c_Weight] = WEIGHT_DEFAULT;
    RaiseCattleInfo[playerid][index][c_Status] = 0;
    RaiseCattleInfo[playerid][index][c_Model] = AnimalArr[animal_type][AnimalModel];
    RaiseCattleInfo[playerid][index][c_Timer] = CATTLE_TIME;
    RaiseCattleInfo[playerid][index][c_Pos][0] = CattlePosData[playerid][cattlePos][PosX];
    RaiseCattleInfo[playerid][index][c_Pos][1] = CattlePosData[playerid][cattlePos][PosY];
    RaiseCattleInfo[playerid][index][c_Pos][2] = CattlePosData[playerid][cattlePos][PosZ];
    RaiseCattleInfo[playerid][index][c_Pos][3] = CattlePosData[playerid][cattlePos][RotZ];
    RaiseCattleInfo[playerid][index][c_Name] = GetCattleName(animal_type);
    RaiseCattleInfo[playerid][index][c_SpawnPos] = cattlePos;
    CATTLE_ADD(playerid, index);
    SendServerMessage(playerid, "Ban da bat dau nuoi gia suc.");
    return 1;
}

stock Cattle_Reload(playerid, cattleId)
{
    new string[256];
    if(IsValidDynamic3DTextLabel(RaiseCattleInfo[playerid][cattleId][c_Text]))
    {
        DestroyDynamic3DTextLabel(RaiseCattleInfo[playerid][cattleId][c_Text]);
        RaiseCattleInfo[playerid][cattleId][c_Text] = Text3D: INVALID_3DTEXT_ID;
    }
    if(IsValidDynamicObject(RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn]))
    {
        DestroyDynamicObject(RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn]);
        RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn] = INVALID_OBJECT_ID;
    }
    new cattleObject = RaiseCattleInfo[playerid][cattleId][c_Model], playerVW = GetPlayerSQLId(playerid);
    format(string, sizeof(string), 
		"{6e8dff}Gia suc: {6e8dff}%s (ID: %d){FFFFFF}\nTrang thai: {6e8dff}%s{FFFFFF}\nCan nang: {6e8dff}%d{FFFFFF}\nChu so huu: {6e8dff}%s{FFFFFF}\nSu dung {6e8dff}/feed{FFFFFF} de thao tac",
		RaiseCattleInfo[playerid][cattleId][c_Name],
        cattleId,
		GetCattleStatus(RaiseCattleInfo[playerid][cattleId][c_Status]),
        RaiseCattleInfo[playerid][cattleId][c_Weight],
		GetPlayerNameEx(playerid));
    RaiseCattleInfo[playerid][cattleId][c_Text] = CreateDynamic3DTextLabel(string, COLOR_WHITE, 
        RaiseCattleInfo[playerid][cattleId][c_Pos][0],
        RaiseCattleInfo[playerid][cattleId][c_Pos][1],
        RaiseCattleInfo[playerid][cattleId][c_Pos][2]+1.0, 5.0, .worldid = playerVW, .streamdistance = 15.0);

    RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn] = CreateDynamicObject(cattleObject, 
        RaiseCattleInfo[playerid][cattleId][c_Pos][0],
        RaiseCattleInfo[playerid][cattleId][c_Pos][1],
        RaiseCattleInfo[playerid][cattleId][c_Pos][2], 0.000000, 0.000000, RaiseCattleInfo[playerid][cattleId][c_Pos][3], .interiorid = -1, .worldid = playerVW, .playerid=-1, .streamdistance = 100);
    Streamer_Update(playerid);
    return 1;
}

stock Cattle_UpdateTimer(playerid, cattleId)
{
    new string[256];
    if(RaiseCattleInfo[playerid][cattleId][c_Weight] >= 500) return 1;
    RaiseCattleInfo[playerid][cattleId][c_Timer]--;
    if(RaiseCattleInfo[playerid][cattleId][c_Timer] == 60 && RaiseCattleInfo[playerid][cattleId][c_Status] != 0)
    {
        new str[128];
        format(str, sizeof(str), "%s (ID: %d) cua ban dang bi %s, ban con 1 phut de cham soc no truoc khi chet.", RaiseCattleInfo[playerid][cattleId][c_Name],
            cattleId,
            GetCattleStatus(RaiseCattleInfo[playerid][cattleId][c_Status]));
        SendClientMessageEx(playerid, COLOR_WHITE, str);
    }
    if(RaiseCattleInfo[playerid][cattleId][c_Timer] <= 0 && RaiseCattleInfo[playerid][cattleId][c_Status] != 0)
    {
        new str[128];
        format(str, sizeof(str), "%s (ID: %d) cua ban da bi chet vi %s.", RaiseCattleInfo[playerid][cattleId][c_Name],
            cattleId,
            GetCattleStatus(RaiseCattleInfo[playerid][cattleId][c_Status]));
        SendClientMessageEx(playerid, COLOR_WHITE, str);
        CATTLE_DELETE(playerid, cattleId);
        return 1;
    }
    if(RaiseCattleInfo[playerid][cattleId][c_Timer] <= 0 && RaiseCattleInfo[playerid][cattleId][c_Status] == 0)
    {
        RaiseCattleInfo[playerid][cattleId][c_Status] = random(3) + 1;
        new str[128];
        format(str, sizeof(str), "%s (ID: %d) cua ban dang bi %s, hay den nuoi duong truoc khi no chet.", RaiseCattleInfo[playerid][cattleId][c_Name],
            cattleId,
            GetCattleStatus(RaiseCattleInfo[playerid][cattleId][c_Status]));
        SendClientMessageEx(playerid, COLOR_WHITE, str);
        RaiseCattleInfo[playerid][cattleId][c_Timer] = CATTLE_TIME;
        Cattle_Reload(playerid, cattleId);
        CATTLE_UPDATE(playerid, cattleId);
    }
    format(string, sizeof(string), 
        "{6e8dff}Gia suc: {6e8dff}%s (ID: %d){FFFFFF}\nTrang thai: {6e8dff}%s{FFFFFF}\nCan nang: {6e8dff}%d{FFFFFF}\nChu so huu: {6e8dff}%s{FFFFFF}\nSu dung {6e8dff}/feed{FFFFFF} de thao tac",
        RaiseCattleInfo[playerid][cattleId][c_Name],
        cattleId,
        GetCattleStatus(RaiseCattleInfo[playerid][cattleId][c_Status]),
        RaiseCattleInfo[playerid][cattleId][c_Weight],
        GetPlayerNameEx(playerid));
    UpdateDynamic3DTextLabelText(RaiseCattleInfo[playerid][cattleId][c_Text], COLOR_WHITE, string);
    return 1;
}

stock Cattle_Remove(playerid, cattleId)
{
    RaiseCattleInfo[playerid][cattleId][Exsits] = false;
    RaiseCattleInfo[playerid][cattleId][Id] = 0;
    RaiseCattleInfo[playerid][cattleId][c_Pos][0] = 0.0;
    RaiseCattleInfo[playerid][cattleId][c_Status] = 0;
    RaiseCattleInfo[playerid][cattleId][c_Weight] = 0;
    RaiseCattleInfo[playerid][cattleId][c_Pos][1] = 0.0;
    RaiseCattleInfo[playerid][cattleId][c_Pos][2] = 0.0;
    CattlePosData[playerid][RaiseCattleInfo[playerid][cattleId][c_SpawnPos]][Exsits] = false;
    if(IsValidDynamic3DTextLabel(RaiseCattleInfo[playerid][cattleId][c_Text]))
    {
        DestroyDynamic3DTextLabel(RaiseCattleInfo[playerid][cattleId][c_Text]);
        RaiseCattleInfo[playerid][cattleId][c_Text] = Text3D: INVALID_3DTEXT_ID;
    }
    if(IsValidDynamicObject(RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn]))
    {
        DestroyDynamicObject(RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn]);
        RaiseCattleInfo[playerid][cattleId][c_ObjectSpawn] = INVALID_OBJECT_ID;
    }
    return 1;
}

stock Cattle_Timer(playerid)
{
    for(new i; i < MAX_CATTLES; i++)
    {
        if(RaiseCattleInfo[playerid][i][Exsits] && PlayerInfo[playerid][pFarmerKey] != -1)
            Cattle_UpdateTimer(playerid, i);
    }
    return 1;
}
stock Cattle_Near(playerid, Float:range)
{
    for(new i= 0; i < MAX_PLAYER_PLANT; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, range, 
            RaiseCattleInfo[playerid][i][c_Pos][0], 
            RaiseCattleInfo[playerid][i][c_Pos][1], 
            RaiseCattleInfo[playerid][i][c_Pos][2]) && RaiseCattleInfo[playerid][i][Exsits])
            return i;
    }
    return -1;
}

stock Cattle_Count(playerid)
{
    new count = 0;
    for(new i= 0; i < MAX_CATTLES; i++)
    {
        if(RaiseCattleInfo[playerid][i][Exsits])
            count++;
    }
    return count;
}

stock Cattle_UpdateRange(playerid)
{
    for(new i= 0; i < MAX_CATTLES; i++)
    {
        if(RaiseCattleInfo[playerid][i][Exsits])
            CATTLE_UPDATE(playerid, i);
    }
    return 1;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          PRODUCT ORDER
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~


stock GetDayInMonth(year, month)
{
    new max_days;

    switch (month)
    {
        case 1, 3, 5, 7, 8, 10, 12:
            max_days = 31;
        case 4, 6, 9, 11:
            max_days = 30;
        case 2:
        {
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
            {
                max_days = 29; 
            }
            else
            {
                max_days = 28; 
            }
        }
        default:
            max_days = 0; 
    }
    return max_days;
}