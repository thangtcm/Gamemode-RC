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
	day += strval(inputtext) + 1;
	while (day > GetDayInMonth(year, month)) {
		day -= GetDayInMonth(year, month);
		month++;

		if (month > 12) {
			month = 1;
			year++;
		}
	}
    FarmInfo[farmid][RentTimer] = day*1000000 + month*10000 + year;
    FARM_UPDATE(farmid);
    format(str,sizeof(str),"%s (IP: %s) da thue nong trai (ID: %d) %d ngay voi gia $%d.",GetPlayerNameEx(playerid),GetPlayerIpEx(playerid),farmid, strval(inputtext),pricerent);
    Log("logs/farm.log", str);
    return 1;
}


Dialog:FARMER_MENU(playerid, response, listitem, inputtext[]){
	if(response)
	{
        switch(listitem) {
			case 0: {
				SetPlayerSkin(playerid, 158);
				SendClientTextDraw(playerid, "Ban da thay trang phuc hay bat dau lam viec.");
			}
			case 1: {
				SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
				SendClientTextDraw(playerid, "Ban da tra trang phuc lam viec cua minh.");
			}
			case 2:{
                SetPVarInt(playerid, #RangeFarm, 1);
				new str[560];
				format(str, sizeof(str), "Hat Giong\t\tGia");
				for(new i =0; i < sizeof(PlantArr); i++)
				{
					format(str, sizeof(str), "%s\n%s\t\t%d", str, PlantArr[i][PlantName], PlantArr[i][PlantBuy]);
				}
                Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Mua cay giong", str, ">>", "<<");
			}
            case 3:{
                SetPVarInt(playerid, #RangeFarm, 2);
                Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_LIST, "Mua gia suc", "Bo", ">>", "<<");
            }
			case 4:{
                Dialog_Show(playerid, SELL_FARM_DIALOG, DIALOG_STYLE_LIST, "Ban hang", "Lua\nThao Duoc\nThit", ">>", "<<");
            }
			case 5:{
				Dialog_Show(playerid, CONVERT_FLOUR_DIALOG, DIALOG_STYLE_INPUT, "Doi bot mi (2 lua = 1 bot mi)", "Nhap so luong", ">>", "<<");
			}
		}
	}
	return 1;
}

Dialog:SELL_FARM_DIALOG(playerid, response, listitem, inputtext[]){
	if(response){
		new str[128];
		SetPVarInt(playerid, #FarmSellProduct, listitem);
		if(listitem == 2)
		{
			format(str, sizeof(str), "Ban %s(%d$/1)", AnimalArr[0][AnimalProduct], AnimalArr[0][AnimalSell]);
			Dialog_Show(playerid, SELL_PRODUCT_DIALOG, DIALOG_STYLE_INPUT, str, "Vui long nhap so luong can ban", ">", "<");
		}
		else
		{
			format(str, sizeof(str), "Ban %s(%d$/1)", PlantArr[listitem][PlantProduct], PlantArr[listitem][PlantSell]);
			Dialog_Show(playerid, SELL_PRODUCT_DIALOG, DIALOG_STYLE_INPUT, str, "Vui long nhap so luong can ban", ">", "<");
		}
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
		printf("PlantArrId %d", PlantArrId);
		if(PlantArrId == 2)
		{
			PlantArrId = 0;
			if(Inventory_Count(playerid, AnimalArr[PlantArrId][AnimalProduct]) < strval(inputtext)) return SendErrorMessage(playerid, "Ban khong du so luong!");
			PlayerInfo[playerid][pCash] += strval(inputtext)*AnimalArr[PlantArrId][AnimalSell];
			new pItemId = Inventory_GetItemID(playerid, AnimalArr[PlantArrId][AnimalProduct], strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
			format(buyer_msg, sizeof(buyer_msg), "Ban da ban thanh cong %d %s va nhan duoc %d$",strval(inputtext), AnimalArr[PlantArrId][AnimalProduct], strval(inputtext)*AnimalArr[PlantArrId][AnimalSell]);
			SendFarmerJob(playerid, buyer_msg);
			return 1;
		}
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

Dialog:FARM_MENU_PLANTFEED(playerid, response, listitem, inputtext[]) {
	if(response)
	{
		new plantId = GetPVarInt(playerid, #Plant_Nearing);
		new str[128];
		switch(listitem)
		{
			case 0:{
				if(PlantTreeInfo[playerid][plantId][plantStatus] == 1)
				{
					SendFarmerJob(playerid, "Ban da tuoi nuoc cho cay trong cua minh");
					if(PlantTreeInfo[playerid][plantId][plantLevel] == 1)
					{
						PlantTreeInfo[playerid][plantId][plantLevel]++;
						PlantTreeInfo[playerid][plantId][plantStatus] = 0;
					}
					else if(PlantTreeInfo[playerid][plantId][plantLevel] == 2)
					{
						PlantTreeInfo[playerid][plantId][plantAmount] += random(5) + 1;
						PlantTreeInfo[playerid][plantId][plantStatus] = 0;
						if(PlantTreeInfo[playerid][plantId][plantAmount] >= 20)
						{
							PlantTreeInfo[playerid][plantId][plantLevel]++;
							PlantTreeInfo[playerid][plantId][plantStatus] = 3;
							PlantTreeInfo[playerid][plantId][plantTimer] = 0;
						}
					}
					GivePlayerCash(playerid, -5);
					PlantTree_Reload(playerid, plantId);
				}
				else SendFarmerJob(playerid, "Cay trong cua ban dang trong tinh trang phat trien!");
			}
			case 1:{

				if(PlantTreeInfo[playerid][plantId][plantStatus] == 2)
				{
					SendFarmerJob(playerid, "Ban da bon phan cho cay trong cua minh");
					if(PlantTreeInfo[playerid][plantId][plantLevel] == 1)
					{
						PlantTreeInfo[playerid][plantId][plantLevel]++;
						PlantTreeInfo[playerid][plantId][plantStatus] = 0;
					}
					else if(PlantTreeInfo[playerid][plantId][plantLevel] == 2)
					{
						PlantTreeInfo[playerid][plantId][plantAmount] += random(5) + 1;
						PlantTreeInfo[playerid][plantId][plantStatus] = 0;
						if(PlantTreeInfo[playerid][plantId][plantAmount] >= 20)
						{
							PlantTreeInfo[playerid][plantId][plantLevel]++;
							PlantTreeInfo[playerid][plantId][plantStatus] = 3;
							PlantTreeInfo[playerid][plantId][plantTimer] = 0;
						}
					}
					GivePlayerCash(playerid, -5);
					PlantTree_Reload(playerid, plantId);
				}
				else SendFarmerJob(playerid, "Cay trong cua ban dang trong tinh trang phat trien!");
			}
		}

	}
	return 1;
}
Dialog:FARM_MENU_FEED(playerid, response, listitem, inputtext[]) {
	if(response)
	{
		new cattleId = GetPVarInt(playerid, #Cattle_Nearing);
		new str[128];
		switch(listitem)
		{
			case 0:{
				if(RaiseCattleInfo[playerid][cattleId][c_Status] == 3)
				{
					new needitem = floatround(RaiseCattleInfo[playerid][cattleId][c_Weight]/50, floatround_ceil);
					if(Inventory_Count(playerid, "Lua") < needitem)
					{
						format(str, sizeof(str), "Ban khong co du %d lua de cho gia suc nay an.", needitem);
						SendFarmerJob(playerid, str);
						return 1;
					}
					new playerinvId = Inventory_GetItemID(playerid, "Lua");
					Inventory_Remove(playerid, playerinvId, needitem);
					SendFarmerJob(playerid, "Ban da tiep do 1 cuc lua mi cho gia suc cua minh");
					RaiseCattleInfo[playerid][cattleId][c_Timer] = 30;
					RaiseCattleInfo[playerid][cattleId][c_Status] = 2;
					RaiseCattleInfo[playerid][cattleId][c_Weight] += 20;
					CATTLE_UPDATE(playerid, cattleId);
				}
				else if(RaiseCattleInfo[playerid][cattleId][c_Status] == 1)
				{
					new needitem = floatround((float(RaiseCattleInfo[playerid][cattleId][c_Weight])/50.0), floatround_ceil);
					if(Inventory_Count(playerid, "Lua") < needitem)
					{
						format(str, sizeof(str), "Ban khong co du %d lua de cho gia suc nay an.", needitem);
						SendFarmerJob(playerid, str);
						return 1;
					}
					new playerinvId = Inventory_GetItemID(playerid, "Lua");
					Inventory_Remove(playerid, playerinvId, needitem);
					format(str, sizeof(str), "Ban da cho gia suc cua minh an %d lua.", needitem);
					SendFarmerJob(playerid, str);
					RaiseCattleInfo[playerid][cattleId][c_Timer] = CATTLE_TIME;
					RaiseCattleInfo[playerid][cattleId][c_Status] = 0;
					RaiseCattleInfo[playerid][cattleId][c_Weight] += 20;
					CATTLE_UPDATE(playerid, cattleId);
				}
				else SendFarmerJob(playerid, "Gia suc cua ban khong doi bung !");
			}
			case 1:{
				if(RaiseCattleInfo[playerid][cattleId][c_Status] == 3)
				{
					SendFarmerJob(playerid, "Ban da tiep nuoc cho gia suc cua minh");
					RaiseCattleInfo[playerid][cattleId][c_Timer] = 30;
					RaiseCattleInfo[playerid][cattleId][c_Status] = 1;
					RaiseCattleInfo[playerid][cattleId][c_Weight] += 20;
					GivePlayerCash(playerid, -5);
					CATTLE_UPDATE(playerid, cattleId);
				}
				if(RaiseCattleInfo[playerid][cattleId][c_Status] == 2)
				{
					SendFarmerJob(playerid, "Ban da tiep nuoc cho gia suc cua minh");
					RaiseCattleInfo[playerid][cattleId][c_Timer] = CATTLE_TIME;
					RaiseCattleInfo[playerid][cattleId][c_Status] = 0;
					RaiseCattleInfo[playerid][cattleId][c_Weight] += 20;
					GivePlayerCash(playerid, -5);
					CATTLE_UPDATE(playerid, cattleId);
				}
				else SendFarmerJob(playerid, "Gia suc cua ban khong khat !");
			}
			case 2:{
				if(RaiseCattleInfo[playerid][cattleId][c_Status] != 0) return SendErrorMessage(playerid, "Ban khong the lay thit gia suc dang doi hoac khat.");
				if(RaiseCattleInfo[playerid][cattleId][c_Weight] < 100) return SendErrorMessage(playerid, "Gia suc cua ban chua du can nang de lay thit.");
				new getmeat = floatround(RaiseCattleInfo[playerid][cattleId][c_Weight]/20, floatround_ceil);

				format(str, sizeof(str), "Ban da lay duoc %d thit %s voi %dkg", getmeat, RaiseCattleInfo[playerid][cattleId][c_Name], RaiseCattleInfo[playerid][cattleId][c_Weight]);
				SendFarmerJob(playerid, str);
				Inventory_Add(playerid, "Thit", getmeat);
				CATTLE_DELETE(playerid, cattleId);
			}
		}

	}
	return 1;
}

Dialog:CONVERT_FLOUR_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		if(strval(inputtext) < 0){
			Dialog_Show(playerid, CONVERT_FLOUR_DIALOG, DIALOG_STYLE_INPUT, "{FFFFFF}Doi bot mi", "({FF0000} Du lieu khong hop le)\n{FFFFFF} Vui long nhap lai so luong", ">>", "<<");
		}
		if(Inventory_Count(playerid, "Lua") < strval(inputtext)*2)
			return SendErrorMessage(playerid, "Ban khong co du lua de doi.");
		new pItemId = Inventory_GetItemID(playerid,"Lua");
		Inventory_Remove(playerid, pItemId, strval(inputtext)*2);
		Inventory_Add(playerid, "Bot Mi", strval(inputtext));
		format(buyer_msg, sizeof(buyer_msg), "Ban da doi thanh cong %d bot mi voi %d lua cua ban.",strval(inputtext),strval(inputtext)*2);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}