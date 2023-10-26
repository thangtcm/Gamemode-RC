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


Dialog:FARMER_MENU(playerid, response, listitem, inputtext[]){
	if(response)
	{
		if(CMND < 1) return SendErrorMessage(playerid,"Ban khong co CMND khong the xin viec.");
        switch(listitem) {
			case 0: {
                new Float:x, Float:y, Float:z;
                GetDynamicActorPos(ActorFarmer[playerid], x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) {
					if(PlayerInfo[playerid][pJob] == JOB_FARMER || PlayerInfo[playerid][pJob2] == JOB_FARMER) return SendErrorMessage(playerid, " Ban da lam viec Nong Dan roi.");
					if(PlayerInfo[playerid][pJob] == 0)
					{
						SendServerMessage(playerid, "*Ban da nhan cong viec Nong Dan thanh cong, hay thay dong phuc va bat dau lam viec.");
						SendClientTextDraw(playerid, "Ban da nhan viec ~y~Nong Dan~w~ hay thay dong phuc va bat dau lam viec");
						PlayerInfo[playerid][pJob] = JOB_FARMER;
						return 1;
					}
					else if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob2] != JOB_FARMER)
					{
						SendServerMessage(playerid, "*Ban da nhan cong viec Nong Dan thanh cong, hay thay dong phuc va bat dau lam viec.");
						SendClientTextDraw(playerid, "Ban da nhan viec ~y~Nong Dan~w~ hay thay dong phuc va bat dau lam viec");
						PlayerInfo[playerid][pJob2] = JOB_FARMER;
						return 1;
					}
					else return SendServerMessage(playerid, "Ban da co cong viec, hay nghi viec de bat dau cong viec nay.");
				}
				else
				{
					return SendErrorMessage(playerid, "Ban can toi vi tri xin viec /gps de tim cong viec.");
				}
			}
			case 1: {
				cmd_nghiviec(playerid,"1");
			}
			case 2: {
				cmd_nghiviec(playerid,"2");
			}
			case 3: {
				if(PlayerInfo[playerid][pJob] != JOB_FARMER && PlayerInfo[playerid][pJob2] != JOB_FARMER) return SendErrorMessage(playerid, " Ban chua phai Nong Dan."); 
				SetPlayerSkin(playerid, 158);
				PlayerInfo[playerid][pModel] = 158;
				SendClientTextDraw(playerid, "Ban da thay trang phuc hay bat dau lam viec");
			}
			case 4:{
                SetPVarInt(playerid, #RangeFarm, 1);
				new str[560];
				format(str, sizeof(str), "Hat Giong\t\tGia");
				for(new i =0; i < sizeof(PlantArr); i++)
				{
					format(str, sizeof(str), "%s\n%s\t\t%d", str, PlantArr[i][PlantName], PlantArr[i][PlantBuy]);
				}
                Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Mua cay giong", str, ">>", "<<");
			}
			case 5:
			{
				SendErrorMessage(playerid, "He thong dang bao tri, se duoc cap nhat trong lan toi.");
			}
            case 7:{
                SetPVarInt(playerid, #RangeFarm, 2);
                Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_LIST, "Mua gia suc", "Bo\nNai", ">>", "<<");
            }
			case 6:{
                Dialog_Show(playerid, SELL_FARM_DIALOG, DIALOG_STYLE_LIST, "Ban hang", "Bot Mi\nThao Duoc", ">>", "<<");
            }
		}
	}
	return 1;
}

Dialog:SELL_FARM_DIALOG(playerid, response, listitem, inputtext[]){
	if(response){
		new str[128];
		SetPVarInt(playerid, #FarmSellProduct, listitem);
		format(str, sizeof(str), "Ban %s(%d$/1)", PlantArr[listitem][PlantProduct], PlantArr[listitem][PlantSell]);
		Dialog_Show(playerid, SELL_PRODUCT_DIALOG, DIALOG_STYLE_INPUT, str, "Vui long nhap so luong can ban", ">", "<");
	}
	return 1;
}


Dialog:BUYER_FARM_DIALOG(playerid, response, listitem, inputtext[]){
	if(response){
		new str[128];
		if(GetPVarInt(playerid, #RangeFarm) == 1){
			SetPVarInt(playerid, #RangeFarm, listitem);
			format(str, sizeof(str), "Mua %s(%d$ mot hat giong)", PlantArr[listitem][PlantName], PlantArr[listitem][PlantBuy]);
			Dialog_Show(playerid, BUY_PLANTS_DIALOG, DIALOG_STYLE_INPUT, str, "Vui long nhap so luong can mua", ">", "<");
		}
		else if(GetPVarInt(playerid, #RangeFarm) == 2){
			if(listitem == 0)
			{
                format(str, sizeof(str), "Mua bo giong (%d$ mot con)", CostCow);
				Dialog_Show(playerid, BUY_COW_DIALOG, DIALOG_STYLE_INPUT, str, "Nhap so luong", ">", "<");
			}
			else if(listitem == 1)
			{
                format(str, sizeof(str), "Mua nai giong (%d$ mot con)", CostDeer);
				Dialog_Show(playerid, BUY_DEER_DIALOG, DIALOG_STYLE_INPUT, str, "Nhap so luong", ">", "<");
			}
		}
		else SendFarmerJob(playerid, "ERROR FARM RANGE");
	}
	return 1;
}

Dialog:BUY_COW_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		if(PlayerInfo[playerid][pCash] < strval(inputtext)*CostCow) return SendFarmerJob(playerid, "Ban khong du tien!");
        Inventory_Add(playerid, "Giong Bo", strval(inputtext), 60*24*7); //3 Ngay
		PlayerInfo[playerid][pCash]-= strval(inputtext)*CostCow;
		format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d con bo voi gia %d",strval(inputtext),strval(inputtext)*CostCow);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}
Dialog:BUY_DEER_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		if(PlayerInfo[playerid][pCash] < strval(inputtext)*CostDeer) return SendFarmerJob(playerid, "Ban khong du tien!");
		Inventory_Add(playerid, "Giong Nai", strval(inputtext), 60*24*7); //3 Ngay
		PlayerInfo[playerid][pCash]-= strval(inputtext)*CostDeer;
		format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d con bo voi gia %d",strval(inputtext),strval(inputtext)*CostDeer);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}

Dialog:BUY_PLANTS_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		new PlantArrId = GetPVarInt(playerid, #RangeFarm);
		if(PlayerInfo[playerid][pCash] < strval(inputtext)*PlantArr[PlantArrId][PlantBuy]) return SendErrorMessage(playerid, "Ban khong du tien!");
		Inventory_Add(playerid, PlantArr[PlantArrId][PlantName], strval(inputtext), 60*24*3); //3 Ngay
		PlayerInfo[playerid][pCash]-= strval(inputtext)*PlantArr[PlantArrId][PlantBuy];
		format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d %s voi gia %d",strval(inputtext), PlantArr[PlantArrId][PlantName], strval(inputtext)*PlantArr[PlantArrId][PlantBuy]);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}


Dialog:SELL_PRODUCT_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		new PlantArrId = GetPVarInt(playerid, #FarmSellProduct);
		if(Inventory_Count(playerid, PlantArr[PlantArrId][PlantProduct]) < strval(inputtext)) return SendErrorMessage(playerid, "Ban khong du so luong!");
		PlayerInfo[playerid][pCash] += strval(inputtext)*PlantArr[PlantArrId][PlantSell];
		new pItemId = Inventory_GetItemID(playerid, PlantArr[PlantArrId][PlantProduct], strval(inputtext));
		printf("%s", InventoryData[playerid][pItemId][invItem]);
		Inventory_Remove(playerid, pItemId, strval(inputtext));
		format(buyer_msg, sizeof(buyer_msg), "Ban da ban thanh cong %d %s va nhan duoc %d$",strval(inputtext), PlantArr[PlantArrId][PlantProduct], strval(inputtext)*PlantArr[PlantArrId][PlantSell]);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}