#include <YSI_Coding\y_hooks>

const 
        MAX_CASINO_TABLE = 150; // Maximum casino tables that can be created

enum eCasinoTable
{
    cId,
    cBizID,
    cType, // 1. Tai xiu - 2. Chan le
    cPrices[2], // Bet Min - Bet Max
    Float:cPosX,
    Float:cPosY,
    Float:cPosZ,
    Float:cRotX,
    Float:cRotY,
    Float:cRotZ,
    Float:cActorX,
    Float:cActorY,
    Float:cActorZ,
    Float:cActorA,
    cVW,
    cInt,
    Text3D:cText, // Text3D ID
    cActor, // Actor ID
    cObject, // Object ID

    cSession, // phiên
    cTimeLeft, // thời gian còn lại
    cPause, // thời gian ngưng phiên
    cTotalBet, // tổng số tiền cược của bàn
    cTotalPlayer, // tổng người đã cược
    cResult // kết quả phiên
};

new 
    CasinoTable[MAX_CASINO_TABLE][eCasinoTable],
    CasinoType[2][12] = {"Tai/Xiu", "Chan/Le"},
    PlayerBet[MAX_PLAYERS],
    BetTable[MAX_PLAYERS],
    BetAmount[MAX_PLAYERS];

// Timer Name: Casino_Timer
// Time repeats:  1000ms
task Casino_Timer[1000]()
{
    for(new i; i < MAX_CASINO_TABLE; i++)
    {
        if (CasinoTable[i][cActorX] != 0.0 && CasinoTable[i][cPrices][0] != 0 && CasinoTable[i][cPrices][1] != 0)
        {
            if (CasinoTable[i][cPause] == 0)
            {
                if (CasinoTable[i][cTimeLeft] > 0) CasinoTable[i][cTimeLeft]--;
                else {
                    new result = 1 + random(20);
                    if (result % 2 == 0) CasinoTable[i][cResult] = 1;
                    else CasinoTable[i][cResult] = 2;

                    SendResultToPlayer(i, CasinoTable[i][cType]);
                }
            }
            else {
                CasinoTable[i][cPause]--;
                if (CasinoTable[i][cPause] == 0) CasinoTable[i][cSession]++;
            }
        }
    }
}

/*-----------------------_______________________________-----------------------*/
/*----------------------|                               |----------------------*/
/*----------------------|           Functions           |----------------------*/
/*----------------------|_______________________________|----------------------*/
forward OnLoadCasinoTable();
public OnLoadCasinoTable()
{
	new i, rows, fields;
	cache_get_data(rows, fields, MainPipeline);

	while (i < rows)
	{
		CasinoTable[i][cId] = cache_get_field_content_int(i, "id", MainPipeline);
		CasinoTable[i][cBizID] = cache_get_field_content_int(i, "BizID", MainPipeline);
        CasinoTable[i][cType] = cache_get_field_content_int(i, "Type", MainPipeline);
        CasinoTable[i][cPrices][0] = cache_get_field_content_int(i, "BetMin", MainPipeline);
        CasinoTable[i][cPrices][1] = cache_get_field_content_int(i, "BetMax", MainPipeline);
        CasinoTable[i][cVW] = cache_get_field_content_int(i, "VW", MainPipeline);
        CasinoTable[i][cInt] = cache_get_field_content_int(i, "Interior", MainPipeline);

		CasinoTable[i][cPosX] = cache_get_field_content_float(i, "PosX", MainPipeline);
		CasinoTable[i][cPosY] = cache_get_field_content_float(i, "PosY", MainPipeline);
		CasinoTable[i][cPosZ] = cache_get_field_content_float(i, "PosZ", MainPipeline);
        CasinoTable[i][cRotX] = cache_get_field_content_float(i, "RotX", MainPipeline);
        CasinoTable[i][cRotY] = cache_get_field_content_float(i, "RotY", MainPipeline);
        CasinoTable[i][cRotZ] = cache_get_field_content_float(i, "RotZ", MainPipeline);
		CasinoTable[i][cActorX] = cache_get_field_content_float(i, "ActorX", MainPipeline);
		CasinoTable[i][cActorY] = cache_get_field_content_float(i, "ActorY", MainPipeline);
		CasinoTable[i][cActorZ] = cache_get_field_content_float(i, "ActorZ", MainPipeline);
        CasinoTable[i][cActorA] = cache_get_field_content_float(i, "ActorA", MainPipeline);
		
		CreateCasinoTable(i);
        CasinoTable[i][cSession] = 0;
        CasinoTable[i][cTimeLeft] = 90;
        CasinoTable[i][cPause] = 5;
		i++;
	}

	printf("[LoadTable] Loaded %i casino table", i);
    return 1;
}

// Insert ID when created successfully
forward OnTableCreated(id);
public OnTableCreated(id)
{
    CasinoTable[id][cId] = cache_insert_id();
    printf("[Casino Table] %i has been created (sqlID: %i)", id, CasinoTable[id][cId]);
    return 1;
}

// Set to InitiateGamemode
stock LoadCasinoTable()
{
	printf("[LoadCasinoTable] Loading data from database...");
	mysql_function_query(MainPipeline, "SELECT * FROM `casino_table`", true, "OnLoadCasinoTable", "");
}

// Reload dynamic streamer
stock CreateCasinoTable(id)
{
    if (IsValidDynamic3DTextLabel(CasinoTable[id][cText]))  DestroyDynamic3DTextLabel(CasinoTable[id][cText]);
    if (IsValidDynamicActor(CasinoTable[id][cActor]))       DestroyDynamicActor(CasinoTable[id][cActor]);
    if (IsValidDynamicObject(CasinoTable[id][cObject]))     DestroyDynamicObject(CasinoTable[id][cObject]);

    if(CasinoTable[id][cActorX] != 0.0)
    {
        CasinoTable[id][cActor] = CreateDynamicActor(172,  
                                                    CasinoTable[id][cActorX], CasinoTable[id][cActorY], CasinoTable[id][cActorZ], CasinoTable[id][cActorA], 
                                                    1, 100.0, CasinoTable[id][cVW], CasinoTable[id][cInt]
                                                    );
        
        new szText[128];
        format(szText, sizeof(szText), "[Casino Table #%i]\n{725B37}Loai: %s\n{FFFFFF}Nhan 'Y' de xem chi tiet", id, CasinoType[CasinoTable[id][cType]-1]);
    
        CasinoTable[id][cText] = CreateDynamic3DTextLabel(szText, 0xC71A1AFF, CasinoTable[id][cActorX], CasinoTable[id][cActorY], CasinoTable[id][cActorZ]+0.4, 10.0, .worldid = CasinoTable[id][cVW], .interiorid = CasinoTable[id][cInt]);
    }

    CasinoTable[id][cObject] = CreateDynamicObject(2188, CasinoTable[id][cPosX], CasinoTable[id][cPosY], CasinoTable[id][cPosZ], CasinoTable[id][cRotX], CasinoTable[id][cRotY], CasinoTable[id][cRotZ], CasinoTable[id][cVW], CasinoTable[id][cInt]);
    return 1;
}

// Save to database
stock SaveCasinoTable(id)
{
    new szQuery[448];
    format(szQuery, sizeof(szQuery), "UPDATE `casino_table` SET \
    `BizID` = '%d', `Type` = '%d', `BetMin` = '%d', `BetMax` = '%d', `VW` = '%d', `Interior` = '%d', \
    `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f', `RotX` = '%f', `RotY` = '%f', `RotZ` ='%f', \
    `ActorX` = '%f', `ActorY` = '%f', `ActorZ` = '%f', `ActorA` = '%f' WHERE `id` = '%d'", 
    CasinoTable[id][cBizID], CasinoTable[id][cType], CasinoTable[id][cPrices][0], CasinoTable[id][cPrices][1],
    CasinoTable[id][cVW], CasinoTable[id][cInt], CasinoTable[id][cPosX], CasinoTable[id][cPosY], CasinoTable[id][cPosZ],
    CasinoTable[id][cRotX], CasinoTable[id][cRotY], CasinoTable[id][cRotZ], 
    CasinoTable[id][cActorX], CasinoTable[id][cActorY], CasinoTable[id][cActorZ], CasinoTable[id][cActorA], CasinoTable[id][cId]);

    mysql_function_query(MainPipeline, szQuery, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    printf("Casino Table (sqlID: %d) saved", CasinoTable[id][cId]);
    return 1;
}

// Get unused ID
stock GetTable_FreeID()
{
    for(new i; i < MAX_CASINO_TABLE; i++)
    {
        if (CasinoTable[i][cPosX] == 0.0) return i;
    }
    return -1;
}

stock GetTableNearest(playerid)
{
    for(new i; i < MAX_CASINO_TABLE; i++)
    {
        if (CasinoTable[i][cActorX] != 0.0 && 
        IsPlayerInRangeOfPoint(playerid, 4.0, CasinoTable[i][cActorX], CasinoTable[i][cActorY], CasinoTable[i][cActorZ]) &&
        IsPlayerInRangeOfPoint(playerid, 3.0, CasinoTable[i][cPosX], CasinoTable[i][cPosY], CasinoTable[i][cPosZ])) return i;
    }
    return -1;
}

// send result to player
stock SendResultToPlayer(id, type)
{
    foreach (new i: Player)
    {
        if (IsPlayerInRangeOfPoint(i, 4.0, CasinoTable[id][cActorX], CasinoTable[id][cActorY], CasinoTable[id][cActorZ]) && BetTable[i] == id)
        {
            new bizid = CasinoTable[id][cBizID];
            if (type == 1) {
                new result[2][6] = {"Tai", "Xiu"};
                sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Tai/Xiu phien {00A326}#%03d{FFFFFF} ket qua la: {006BB8}%s{FFFFFF}.", CasinoTable[id][cSession], result[CasinoTable[id][cResult]-1]);
                if (PlayerBet[i] == CasinoTable[id][cResult]) {
                    new receive_cash = BetAmount[i] + ((BetAmount[i] * 90) / 100); // tiền đặt cược + 90% số tiền
                    sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da thang Tai/Xiu trong phien {00A326}#%03d{FFFFFF}, tra ve cho ban {29AE2F}$%s{FFFFFF}.", CasinoTable[id][cSession], number_format(receive_cash));
                    Businesses[bizid][bSafeBalance] -= (BetAmount[i] * 90) / 100;
                    GivePlayerCash(i, receive_cash);
                    
                    PlayerBet[i] = 0;
                    BetAmount[i] = 0;
                    BetTable[i] = -1;
                }
                else {
                    Businesses[bizid][bSafeBalance] += BetAmount[i];
                    PlayerBet[i] = 0;
                    BetAmount[i] = 0;
                    BetTable[i] = -1;
                    sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da thua Tai/Xiu trong phien {00A326}#%03d{FFFFFF}, chuc ban may man lan sau.", CasinoTable[id][cSession]);
                }
            }
            else {
                new result[2][6] = {"Chan", "Le"};
                sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Chan/Le phien {00A326}#%03d{FFFFFF} ket qua la: {006BB8}%s{FFFFFF}.", CasinoTable[id][cSession], result[CasinoTable[id][cResult]-1]);
                if (PlayerBet[i] == CasinoTable[id][cResult]) {
                    new receive_cash = BetAmount[i] + ((BetAmount[i] * 90) / 100); // tiền đặt cược + 90% số tiền
                    sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da thang Chan/Le trong phien {00A326}#%03d{FFFFFF}, tra ve cho ban {29AE2F}$%s{FFFFFF}.", CasinoTable[id][cSession], number_format(receive_cash));
                    Businesses[bizid][bSafeBalance] -= (BetAmount[i] * 90) / 100;
                    GivePlayerCash(i, receive_cash);

                    PlayerBet[i] = 0;
                    BetAmount[i] = 0;
                    BetTable[i] = -1;
                }
                else {
                    Businesses[bizid][bSafeBalance] += BetAmount[i];
                    PlayerBet[i] = 0;
                    BetAmount[i] = 0;
                    BetTable[i] = -1;
                    sendMessage(i, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da thua Chan/Le trong phien {00A326}#%03d{FFFFFF}, chuc ban may man lan sau.", CasinoTable[id][cSession]);
                }
            }

            if (BetTable[i] == id) BetTable[i] = -1;
        }
    }

    CasinoTable[id][cTotalBet] = 0;
    CasinoTable[id][cTotalPlayer] = 0;
    CasinoTable[id][cResult] = 0;
    CasinoTable[id][cPause] = 8;
    CasinoTable[id][cTimeLeft] = 90;
    return 1;
}

stock GetBet_AllTable(bizid)
{
    new amount;
    for (new i; i < MAX_CASINO_TABLE; i++)
    {
        if (CasinoTable[i][cBizID] == bizid)
        {
            amount += CasinoTable[i][cTotalBet];
        }
    }
    
    return amount;
}
// command for administrator
CMD:acasino(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4) return SendErrorMessage(playerid, "Ban khong co quyen su dung lenh nay.");

    new option[12], secoption[64];
	if (sscanf(params, "s[16]S()[128]", option, secoption))
	{
		SendUsageMessage(playerid, " /acasino [option]");
		SendClientMessage(playerid, -1, "Option: create / actor / bizid / object / type / delete");
		return 1;
	}

    new 
        i, bizid, type,
        Float:pX, Float:pY, Float:pZ, Float:pA;
    if (strcmp(option, "create") == 0)
    {
        if (sscanf(secoption, "ii", bizid, type)) 	return SendUsageMessage(playerid, " /acasino create [biz id] [type (1. tai xiu 2. chan le)]");
		if (!IsValidBusinessID(bizid)) 		        return SendErrorMessage(playerid, "Doanh nghiep nay khong ton tai.");
		if (type != 1 && type != 2)                 return SendErrorMessage(playerid, "Loai hinh khong hop le.");
        if (Businesses[bizid][bType] != BUSINESS_TYPE_CASINO) return SendErrorMessage(playerid, "Loai hinh doanh nghiep nay khong phai la Casino.");
        if ((i = GetTable_FreeID()) == -1) return SendErrorMessage(playerid, "The limit has been reached [ERROR]");

        GetPlayerPos(playerid, pX, pY, pZ);
        CasinoTable[i][cPosX] = pX;
        CasinoTable[i][cPosY] = pY;
        CasinoTable[i][cPosZ] = pZ;
        CasinoTable[i][cVW] = GetPlayerVirtualWorld(playerid);
        CasinoTable[i][cInt] = GetPlayerInterior(playerid);
        CasinoTable[i][cBizID] = bizid;
        CasinoTable[i][cType] = type;
        CasinoTable[i][cTimeLeft] = 90;
        CasinoTable[i][cPause] = 8;

        new query[448];
        format(query, sizeof(query), "INSERT INTO `casino_table` (`PosX`, `PosY`, `PosZ`, `VW`, `Interior`, `BizID`, `Type`) \
                                        VALUES ('%f', '%f', '%f', '%d', '%d', '%d', '%d')", 
                                                        pX, pY, pZ, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), bizid, type);
        mysql_tquery(MainPipeline, query, "OnTableCreated", "d", i);

        sendMessage(playerid, -1, "Ban da tao ra Casino Table #%i (Loai: {725B37}%s{FFFFFF})", i, CasinoType[type-1]);

        CreateCasinoTable(i);
    }
    else if (strcmp(option, "bizid") == 0)
    {
        if (sscanf(secoption, "dd", i, bizid)) 	    return SendUsageMessage(playerid, " /acasino bizid [table id] [bizid]");
        if (CasinoTable[i][cPosX] == 0.0)           return SendErrorMessage(playerid, "Casino Table khong ton tai.");
        if (!IsValidBusinessID(bizid)) 		        return SendErrorMessage(playerid, "Doanh nghiep nay khong ton tai.");
        if (Businesses[bizid][bType] != BUSINESS_TYPE_CASINO) return SendErrorMessage(playerid, "Loai hinh doanh nghiep nay khong phai la Casino.");
    
        CasinoTable[i][cBizID] = bizid;
        SaveCasinoTable(i);
        sendMessage(playerid, -1, "Ban da thay doi doanh nghiep cua Casino Table #%d thanh #%d", i, bizid);
    }
    else if (strcmp(option, "actor") == 0)
    {
        if (sscanf(secoption, "d", i)) 	    return SendUsageMessage(playerid, " /acasino actor [table id]");
        if (CasinoTable[i][cPosX] == 0.0)   return SendErrorMessage(playerid, "Casino Table khong ton tai.");

        GetPlayerPos(playerid, pX, pY, pZ);
        GetPlayerFacingAngle(playerid, pA);
        if (!IsPlayerInRangeOfPoint(playerid, 7.0, CasinoTable[i][cPosX], CasinoTable[i][cPosY], CasinoTable[i][cPosZ])) return SendErrorMessage(playerid, "Actor phai o gan Casino Table.");
        CasinoTable[i][cActorX] = pX;
        CasinoTable[i][cActorY] = pY;
        CasinoTable[i][cActorZ] = pZ;
        CasinoTable[i][cActorA] = pA;

        if (IsValidDynamic3DTextLabel(CasinoTable[i][cText]))  DestroyDynamic3DTextLabel(CasinoTable[i][cText]);
        if (IsValidDynamicActor(CasinoTable[i][cActor]))       DestroyDynamicActor(CasinoTable[i][cActor]);
        CasinoTable[i][cActor] = CreateDynamicActor(172,  
                                                    CasinoTable[i][cActorX], CasinoTable[i][cActorY], CasinoTable[i][cActorZ], CasinoTable[i][cActorA], 
                                                    1, 100.0, CasinoTable[i][cVW], CasinoTable[i][cInt]
                                                    );
        
        new szText[128];
        format(szText, sizeof(szText), "[Casino Table #%i]\n{725B37}Loai: %s\n{FFFFFF}Nhan 'Y' de xem chi tiet", i, CasinoType[CasinoTable[i][cType]-1]);
    
        CasinoTable[i][cText] = CreateDynamic3DTextLabel(szText, 0xC71A1AFF, CasinoTable[i][cActorX], CasinoTable[i][cActorY], CasinoTable[i][cActorZ]+0.4, 10.0, .worldid = CasinoTable[i][cVW], .interiorid = CasinoTable[i][cInt]);
        SaveCasinoTable(i);
    }
    else if (strcmp(option, "object") == 0)
    {
        if (sscanf(secoption, "d", i)) 	    return SendUsageMessage(playerid, " /acasino object [table id]");
        if (CasinoTable[i][cPosX] == 0.0)   return SendErrorMessage(playerid, "Casino Table khong ton tai.");

        EditDynamicObject(playerid, CasinoTable[i][cObject]);
        SetPVarInt(playerid, #editTable, i + 1);
        sendMessage(playerid, -1, "Ban dang chinh sua object cua Casino Table #%d.", i);
    }
    else if (strcmp(option, "type") == 0)
    {
        if (sscanf(secoption, "dd", i, type)) 	    return SendUsageMessage(playerid, " /acasino type [table id] [type (1. tai xiu 2. chan le)]");
        if (CasinoTable[i][cPosX] == 0.0)           return SendErrorMessage(playerid, "Casino Table khong ton tai.");
        if (type != 1 || type != 2)                 return SendErrorMessage(playerid, "Loai hinh khong hop le.");

        CasinoTable[i][cType] = type;
        sendMessage(playerid, -1, "Ban da chinh sua loai hinh cua Casino Table #%d thanh {725B37}%s{FFFFFF}.", CasinoType[type-1]);

        if (IsValidDynamic3DTextLabel(CasinoTable[i][cText]))  DestroyDynamic3DTextLabel(CasinoTable[i][cText]);

        new szText[128];
        format(szText, sizeof(szText), "[Casino Table #%i]\n{725B37}Loai: %s\n{FFFFFF}Nhan 'Y' de xem chi tiet", i, CasinoType[CasinoTable[i][cType]-1]);
        CasinoTable[i][cText] = CreateDynamic3DTextLabel(szText, 0xC71A1AFF, CasinoTable[i][cActorX], CasinoTable[i][cActorY], CasinoTable[i][cActorZ]+0.4, 10.0, .worldid = CasinoTable[i][cVW], .interiorid = CasinoTable[i][cInt]);
        
        SaveCasinoTable(i);
    }
    else if (strcmp(option, "delete") == 0)
    {
        if (sscanf(secoption, "d", i)) 	        return SendUsageMessage(playerid, " /acasino type [table id]");
        if (CasinoTable[i][cPosX] == 0.0)       return SendErrorMessage(playerid, "Casino Table khong ton tai.");
        if (CasinoTable[i][cPause] == 0 && CasinoTable[i][cTimeLeft] < 300) return SendErrorMessage(playerid, "Phien dang bat dau, khong the xoa bo Table nay.");

        new szQuery[128];
        mysql_format(MainPipeline, szQuery, sizeof(szQuery), "DELETE FROM `casino_table` WHERE `id` = %d", CasinoTable[i][cId]);
        mysql_query(MainPipeline, szQuery);

        if (IsValidDynamic3DTextLabel(CasinoTable[i][cText]))  DestroyDynamic3DTextLabel(CasinoTable[i][cText]);
        if (IsValidDynamicActor(CasinoTable[i][cActor]))       DestroyDynamicActor(CasinoTable[i][cActor]);
        if (IsValidDynamicObject(CasinoTable[i][cObject]))     DestroyDynamicObject(CasinoTable[i][cObject]);

        CasinoTable[i][cId] = -1;
        CasinoTable[i][cBizID] = -1;
        CasinoTable[i][cPosX] = 0.0;
        CasinoTable[i][cPosY] = 0.0;
        CasinoTable[i][cPosZ] = 0.0;
        CasinoTable[i][cRotX] = 0.0;
        CasinoTable[i][cRotY] = 0.0;
        CasinoTable[i][cRotZ] = 0.0;
        CasinoTable[i][cActorX] = 0.0;
        CasinoTable[i][cActorY] = 0.0;
        CasinoTable[i][cActorZ] = 0.0;
        CasinoTable[i][cActorA] = 0.0;
        CasinoTable[i][cType] = 0;
        CasinoTable[i][cPrices] = (EOS);
        CasinoTable[i][cTimeLeft] = 0;
        CasinoTable[i][cTotalBet] = 0;
        CasinoTable[i][cTotalPlayer] = 0;
        CasinoTable[i][cSession] = 0;
        sendMessage(playerid, -1, "Ban da xoa bo Casino Table #%d.", i);
    }
    return 1;
}

// command for owner business
CMD:editcasino(playerid, params[])
{
    if (PlayerInfo[playerid][pBusiness] == INVALID_BUSINESS_ID) return SendErrorMessage(playerid, "Ban khong so huu doanh nghiep.");
    if (PlayerInfo[playerid][pBusinessRank] < 5 && Businesses[PlayerInfo[playerid][pBusiness]][bOwner] != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong phai chu doanh nghiep.");

    new id, info[64], szDialog[128];
    if (sscanf(params, "d", id)) return SendUsageMessage(playerid, " /editcasino [table id]");
    if (CasinoTable[id][cBizID] != PlayerInfo[playerid][pBusiness]) return SendErrorMessage(playerid, "Casino Table nay khong thuoc ve ban.");
    if (!IsPlayerInRangeOfPoint(playerid, 10.0, CasinoTable[id][cPosX], CasinoTable[id][cPosY], CasinoTable[id][cPosZ])) return SendErrorMessage(playerid, "Ban khong o gan Casino Table nay.");
    if (PlayerInfo[playerid][pBusinessRank] < 5 && Businesses[PlayerInfo[playerid][pBusiness]][bOwner] != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong phai chu doanh nghiep nay.");
    if (CasinoTable[id][cPause] == 0) return SendErrorMessage(playerid, "Vui long doi het phien.");

    if (CasinoTable[id][cType] == 1 || CasinoTable[id][cType] == 2) {
        format(info, sizeof(info), "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", id, CasinoType[CasinoTable[id][cType]-1]);
        format(szDialog, sizeof(szDialog), "Dat cuoc toi thieu: \t{29AE2F}$%d{FFFFFF}\nDat cuoc toi da: \t{29AE2F}$%d", CasinoTable[id][cPrices][0], CasinoTable[id][cPrices][1]);
        Dialog_Show(playerid, CASINO_EDIT, DIALOG_STYLE_TABLIST, info, szDialog, "Chinh sua", "Dong");
    }
    else return SendErrorMessage(playerid, "Casino Table nay khong co loai hinh phu hop.");

    SetPVarInt(playerid, #TableID, id);
    return 1;
}

/*-----------------------_______________________________-----------------------*/
/*----------------------|                               |----------------------*/
/*----------------------|           CallBacks           |----------------------*/
/*----------------------|_______________________________|----------------------*/
hook OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    new i;
    if ((i = GetPVarInt(playerid, #editTable)) != 0)
    {
        i--;
        if (CasinoTable[i][cObject] == objectid)
        {
            switch (response)
            {
                case EDIT_RESPONSE_FINAL:
                {
                    CasinoTable[i][cPosX] = x;
                    CasinoTable[i][cPosY] = y;
                    CasinoTable[i][cPosZ] = z;
                    CasinoTable[i][cRotX] = rx;
                    CasinoTable[i][cRotY] = ry;
                    CasinoTable[i][cRotZ] = rz;

                    SetDynamicObjectPos(CasinoTable[i][cObject], CasinoTable[i][cPosX], CasinoTable[i][cPosY], CasinoTable[i][cPosZ]);
                    SetDynamicObjectRot(CasinoTable[i][cObject], CasinoTable[i][cRotX], CasinoTable[i][cRotY], CasinoTable[i][cRotZ]);
                    sendMessage(playerid, -1, "Ban da chinh sua Object cua Casino Table #%d.", i);
                    DeletePVar(playerid, #editTable);
                    SaveCasinoTable(i);
                }
                case EDIT_RESPONSE_CANCEL:
                {
                    SetDynamicObjectPos(CasinoTable[i][cObject], CasinoTable[i][cPosX], CasinoTable[i][cPosY], CasinoTable[i][cPosZ]);
                    SetDynamicObjectRot(CasinoTable[i][cObject], CasinoTable[i][cRotX], CasinoTable[i][cRotY], CasinoTable[i][cRotZ]);
                    DeletePVar(playerid, #editTable);
                }
            }
        } 
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_YES))
    {
        new i, szDialog[448], info[64];
        if ((i = GetTableNearest(playerid)) != -1)
        {
            if (CasinoTable[i][cType] == 1) {
                format(info, sizeof(info), "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", i, CasinoType[CasinoTable[i][cType]-1]);
                format(szDialog, sizeof(szDialog), "{00A326}\
                Phien Tai/Xiu: \t#%03d\n{FFFFFF}Thoi gian con lai: \t{706572}%02d giay{FFFFFF}\n\
                Dat toi thieu: \t{00B803}$%d{FFFFFF}\nDat toi da: \t{00B803}$%d{FFFFFF}\nTong tien da cuoc: \t{00B803}$%s{FFFFFF}\n \n\
                -> Dat cuoc:\n{006BB8}[#] Tai\n{006BB8}[#] Xiu", 
                CasinoTable[i][cSession], CasinoTable[i][cTimeLeft], CasinoTable[i][cPrices][0], CasinoTable[i][cPrices][1],
                number_format(CasinoTable[i][cTotalBet]));
                Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_TABLIST, info, szDialog, "Chon", "Dong");
            
                SetPVarInt(playerid, #interactTable, i);
            }
            else if (CasinoTable[i][cType] == 2) {
                format(info, sizeof(info), "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", i, CasinoType[CasinoTable[i][cType]-1]);
                format(szDialog, sizeof(szDialog), "{00A326}\
                Phien Chan/Le: \t#%03d\n{FFFFFF}Thoi gian con lai: \t{706572}%02d giay{FFFFFF}\n\
                Dat toi thieu: \t{00B803}$%d{FFFFFF}\nDat toi da: \t{00B803}$%d{FFFFFF}\nTong tien da cuoc: \t{00B803}$%s{FFFFFF}\n \n\
                -> Dat cuoc:\n{006BB8}[#] Chan\n{006BB8}[#] Le", 
                CasinoTable[i][cSession], CasinoTable[i][cTimeLeft], CasinoTable[i][cPrices][0], CasinoTable[i][cPrices][1],
                number_format(CasinoTable[i][cTotalBet]));
                Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_TABLIST, info, szDialog, "Chon", "Dong");
            
                SetPVarInt(playerid, #interactTable, i);
            }
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerBet[playerid] = 0;
    BetAmount[playerid] = 0;
    BetTable[playerid] = -1;
    return 1;
}

#include "./system/casino/dialogs.pwn" // Dialog functions