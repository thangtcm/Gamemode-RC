CMD:thuenongtrai(playerid, params[])
{
    if(PlayerInfo[playerid][pFarmerKey] != -1) return SendErrorMessage(playerid, "Ban da so huu nong trai roi, khong the mua them nong trai moi.");
    Dialog_Show(playerid, FarmRent, DIALOG_STYLE_INPUT, "Thue nong trai", "Xin vui long nhap so ngay ban muon thue. (Nhap '5' tuong ung voi 5 ngay)", "Xac Nhan", "<");
    return 1;
}

CMD:exitfarm(playerid, params[])
{
	if(IsPlayerInDynamicArea(playerid, PlayerFarmArea))
	{
		LeaveAreaFarm(playerid, PlayerFarmArea);
	}
	return 1;
}

CMD:asellfarm(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 4) {
		return SendErrorMessage(playerid, " Ban khong duoc phep su dung lenh nay.");
	}
	new string[128], farmId;
	if(sscanf(params, "d", farmId)) return SendUsageMessage(playerid, " /asellfarm [farmer id]");
	FarmClear(farmId);
	FARM_UPDATE(farmId);
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	format(string,sizeof(string),"Administrator %s (IP: %s) da ban nong trai ID %d (duoc so huu boi %d).",GetPlayerNameEx(playerid),ip,farmId,FarmInfo[farmId][OwnerName]);
	Log("logs/farmer.log", string);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	format(string, sizeof(string), "~w~Ban da ban farmer %d.", farmId);
	GameTextForPlayer(playerid, string, 10000, 3);
	foreach(new j: Player) {
		if(PlayerInfo[j][pFarmerKey] == farmId) {
			PlayerInfo[j][pFarmerKey] = -1;
			SendServerMessage(playerid, " Mot Admin da ban cua hang nay, so lieu thong ke cua hang ban duoc thiet lap lai.");
		}
	}
	format(string, sizeof(string), "UPDATE `accounts` SET `Farmer` = -1 WHERE `Farmer` = '%d'", farmId);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
	return 1;
}

CMD:gotofarm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pShopTech] >= 1)
	{
		new farmid;
		if(sscanf(params, "d", farmid)) return SendUsageMessage(playerid, " /gotofarm [farmer id]");
		if(!FarmInfo[farmid][Exsits]) return SendErrorMessage(playerid, " Invalid farmer ID specified.");
		if (FarmInfo[farmid][ExteriorX] == 0.0) return SendErrorMessage(playerid, " No exterior set for this farmer.");
		GameTextForPlayer(playerid, "~w~Teleporting", 5000, 1);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		PlayerInfo[playerid][pInt] = 0;
		PlayerInfo[playerid][pVW] = 0;
		SetPlayerPos(playerid,FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]);
	}
	else
	{
	    SendErrorMessage(playerid, " Ban khong duoc phep su dung lenh nay.");
	}
	return 1;
}

CMD:muanongtrai(playerid, parms[])
{
    if(PlayerInfo[playerid][pFarmerKey] != -1) return SendErrorMessage(playerid, "Ban da so huu nong trai roi, khong the mua them nong trai moi.");
    new farmid =  PlayerNearFarm(playerid);
    if(FarmInfo[farmid][OwnerPlayerId] != -1) return SendErrorMessage(playerid, "Nong trai nay hien da co nguoi so huu.");
    new str[560];
    if(GetPlayerCash(playerid) < FarmInfo[farmid][FarmPrice])
    {
        format(str, sizeof(str), "{FF6347}ERROR:{FFFFFF}%sBan khong co du tien de mua nong trai nay(So tien hien tai: %d - So tien yeu cau :%d).", GetPlayerCash(playerid), FarmInfo[farmid][FarmPrice]);
        return SendClientMessageEx(playerid, COLOR_WHITE, str);
    }
    GivePlayerCash(playerid, FarmInfo[farmid][FarmPrice]*-1);
    GameTextForPlayer(playerid, "~w~Welcome Farm~n~Chuc mung ban da so huu nong trai.", 5000, 3);
    SendServerMessage(playerid, " Chuc mung ban da co nong trai nha!");
    SendServerMessage(playerid, " Bay gio ban co the lam cong viec nong trai roi!");
    PlayerInfo[playerid][pFarmerKey] = farmid;
    FarmInfo[farmid][OwnerPlayerId] = GetPlayerSQLId(playerid);
    FarmInfo[farmid][VirtualWorld] = GetPlayerSQLId(playerid);
    FarmInfo[farmid][FarmType] = FARM_OWNER;
    strcat((FarmInfo[farmid][OwnerName][0] = 0, FarmInfo[farmid][OwnerName]), GetPlayerNameEx(playerid), MAX_PLAYER_NAME);
    FARM_UPDATE(farmid);
    format(str,sizeof(str),"%s (IP: %s) da mua nong trai (ID: %d) voi gia $%d.",GetPlayerNameEx(playerid),GetPlayerIpEx(playerid),farmid,FarmInfo[farmid][FarmPrice]);
    Log("logs/farm.log", str);
    return 1;
}

CMD:farmedit(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4)
	{
		return SendErrorMessage(playerid, " Ban khong duoc phep su dung lenh nay.");
	}
    new string[128], choice[32], farmid, amount;
	if(sscanf(params, "s[32]D(-1)D(0)", choice, farmid, amount))
	{
		SendUsageMessage(playerid, " /farmedit [name] [farmid] [Optional] [amount]");
		SendSelectMessage(playerid, " createdefault, price, exterior, rentfee");
		return 1;
	}
    if(strcmp(choice, "exterior", true) == 0)
    {
        if(farmid == -1) return SendErrorMessage(playerid, "ID Nong trai khong hop le.");
         new Float: Pos[3];
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		format(string, sizeof(string), "%s vua chinh sua vi tri cua Nong trai (ID: %d) toi vi tri cua ho. (Before:  %f, %f, %f | After: %f, %f, %f)", 
            GetPlayerNameEx(playerid), farmid,  
            FarmInfo[farmid][ExteriorX], 
            FarmInfo[farmid][ExteriorY], 
            FarmInfo[farmid][ExteriorZ], 
            Pos[0], Pos[1], Pos[2]);
		Log("logs/farmedit.log", string);
        ABroadCast(COLOR_YELLOW, string, 4);
		GetPlayerPos(playerid, FarmInfo[farmid][ExteriorX], FarmInfo[farmid][ExteriorY], FarmInfo[farmid][ExteriorZ]);
		SendClientMessageEx( playerid, COLOR_WHITE, "You have changed the exterior!" );
		Farm_Reload(farmid);
        FARM_UPDATE(farmid);
    }
    else if(strcmp(choice, "price", true) == 0)
	{
        if(farmid == -1) return SendErrorMessage(playerid, "ID Nong trai khong hop le.");
		FarmInfo[farmid][FarmPrice] = amount;
		format(string, sizeof(string), "Ban da chinh gia ban nong trai nay la $%d.", amount );
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		Farm_Reload(farmid);
        FARM_UPDATE(farmid);
		format(string, sizeof(string), "%s vua chinh sua gia ban cua Nong trai (ID: %d) thanh $%d.", GetPlayerNameEx(playerid), amount);
		ABroadCast(COLOR_YELLOW, string, 4);
        Log("logs/farmedit.log", string);
	}
    else if(strcmp(choice, "rentfee", true) == 0)
	{
        if(farmid == -1) return SendErrorMessage(playerid, "ID Nong trai khong hop le.");
		FarmInfo[farmid][RentFee] = amount;
		format(string, sizeof(string), "Ban da chinh gia thue nong trai nay la $%d.", amount );
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		Farm_Reload(farmid);
        FARM_UPDATE(farmid);
		format(string, sizeof(string), "%s vua chinh sua gia thue cua Nong trai (ID: %d) thanh $%d.", GetPlayerNameEx(playerid), amount);
		ABroadCast(COLOR_YELLOW, string, 4);
        Log("logs/farmedit.log", string);
	}
    else if(strcmp(choice, "createdefault", true) == 0)
	{
        farmid = Farm_AddDefault(playerid);
		format(string, sizeof(string), "Ban da tao mot nong trai (ID: %d)", farmid);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		FARM_ADD(farmid);
		format(string, sizeof(string), "%s vua tao mot Nong trai (ID: %d) tai vi tri cua ho.", GetPlayerNameEx(playerid), amount);
		ABroadCast(COLOR_YELLOW, string, 4);
        Log("logs/farmedit.log", string);
	}
    return 1;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~
//          PLANT
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//~~~~~~~~~~~~~~~~~~~~~~~~~~

CMD:farmer(playerid, params[])
{
	new Float:x,
            Float:y,
            Float:z;
	GetDynamicActorPos(ActorFarmer[playerid], x, y, z);

	if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
	{
		Dialog_Show(playerid, FARMER_MENU, DIALOG_STYLE_LIST, "Cong viec", "Thay dong phuc\nMua cay giong\nMua gia suc\nBan hang", "Chon", "Huy");
	}
	else SendErrorMessage(playerid, "Ban khong o gan nguoi quan ly nong trai");
	return 1;
}


CMD:thuhoach(playerid, params[])
{
    new thuhoachmsg[512];
    new plantId = PlantTree_Near(playerid, 3.0);
    if(!IsPlayerInDynamicArea(playerid, FarmPlantArea) || GetPlayerVirtualWorld(playerid) != GetPlayerSQLId(playerid)) return SendErrorMessage(playerid, "Ban khong o trong khu vuc trong cay cua ban.");
    if(plantId == -1) return SendErrorMessage(playerid, "Ban khong dung gan bat ky cay trong nao cua ban.");
	if(PlantTreeInfo[playerid][plantId][plantTimer] <= 0 && PlantTreeInfo[playerid][plantId][plantLevel] == 3)
	{
		new TreeType = PlantTreeInfo[playerid][plantId][plantType];
		if(Inventory_Add(playerid, PlantArr[TreeType][PlantProduct]))
		{
			format(thuhoachmsg, sizeof(thuhoachmsg), "Ban da thu hoach thanh cong cay %s (ID: %d)", PlantArr[TreeType][PlantProduct], plantId);
			SendFarmerJob(playerid, thuhoachmsg);
			PLANT_DELETE(playerid, plantId);
		}
	}
	else SendFarmerJob(playerid, "Cay nay van chua the thu hoach !");
	return 1;
}
