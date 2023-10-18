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

stock PlayerNearFarm(playerid)
{
    new Float:playerPos[3];
    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
    for(new i = 0; i < sizeof(FarmInfo); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, FarmInfo[i][ExteriorX], FarmInfo[i][ExteriorY], FarmInfo[i][ExteriorZ]))
        return i;
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