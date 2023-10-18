Dialog:FarmRent(playerid, response, listitem, inputtext[])
{
    if(PlayerInfo[playerid][pFarmerKey] != -1) return SendErrorMessage(playerid, "Ban da so huu nong trai roi, khong the mua them nong trai moi.");
    if(isnull(inputtext))
    {
        return  Dialog_Show(playerid, FarmRent, DIALOG_STYLE_INPUT, "Thue nong trai", "Xin vui long nhap lai so ngay can thue:", "Xac Nhan", "<");
    }
    if(strval(inputtext) < 5)
    {
        return  Dialog_Show(playerid, FarmRent, DIALOG_STYLE_INPUT, "Thue nong trai", "He thong chi cho phep ban thue tren 5 ngay.\n\nXin vui long nhap lai so ngay can thue:", "Xac Nhan", "<");
    }
    new farmid =  PlayerNearFarm(playerid);
    new str[560];
    if(FarmInfo[farmid][OwnerPlayerId] != -1) return SendErrorMessage(playerid, "Nong trai nay hien da co nguoi so huu.");
    new pricerent = FarmInfo[farmid][RentFee] * strval(inputtext);
    if(GetPlayerCash(playerid) < pricerent)
    {
        format(str, sizeof(str), "Ban khong co du tien de thue nong trai nay(So tien hien tai: %d - So tien yeu cau :%d).\n\nXin vui long nhap lai so ngay can thue neu ban muon tiep tuc:", GetPlayerCash(playerid), pricerent);
        return  Dialog_Show(playerid, FarmRent, DIALOG_STYLE_INPUT, "Thue nong trai", str, "Xac Nhan", "<");
    }
    GivePlayerCash(playerid, pricerent*-1);
    GameTextForPlayer(playerid, "~w~Welcome Farm~n~Chuc mung ban da thue duoc mot nong trai.", 5000, 3);
    SendServerMessage(playerid, " Chuc mung ban da co nong trai nha!");
    SendServerMessage(playerid, " Bay gio ban co the lam cong viec nong trai roi!");
    PlayerInfo[playerid][pFarmerKey] = farmid;
    FarmInfo[farmid][OwnerPlayerId] = GetPlayerSQLId(playerid);
    FarmInfo[farmid][VirtualWorld] = GetPlayerSQLId(playerid);
    FarmInfo[farmid][FarmType] = FARM_RENT;
    strcat((FarmInfo[farmid][OwnerName][0] = 0, FarmInfo[farmid][OwnerName]), GetPlayerNameEx(playerid), MAX_PLAYER_NAME);
    new month, day, year;
    getdate(year,month,day);
    FarmInfo[farmid][RentTimer] = (day + strval(inputtext) + 1)*1000000 + month*10000 + year;
    FARM_UPDATE(farmid);
    format(str,sizeof(str),"%s (IP: %s) da thue nong trai (ID: %d) %d ngay voi gia $%d.",GetPlayerNameEx(playerid),GetPlayerIpEx(playerid),farmid, strval(inputtext),pricerent);
    Log("logs/farm.log", str);
    return 1;
}