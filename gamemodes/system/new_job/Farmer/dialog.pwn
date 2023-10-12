Dialog:FARMER_MENU(playerid, response, listitem, inputtext[]){
	if(response)
	{
		printf("RUNN %d", listitem);
		if(CMND < 1) return SendErrorMessage(playerid,"Ban khong co CMND khong the xin viec.");
		switch(listitem) {
			case 0: {
				if (IsPlayerInRangeOfPoint(playerid,5.0,-382.8567,-1430.5543,25.7266)) {
					if(PlayerInfo[playerid][pJob] == JOB_FARMER || PlayerInfo[playerid][pJob2] == JOB_FARMER) return SendErrorMessage(playerid, " Ban da lam viec Nong Dan roi.");
					if(PlayerInfo[playerid][pJob] == 0)
					{
						SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec Nong Dan thanh cong, hay thay dong phuc va bat dau lam viec.");
						SendClientTextDraw(playerid, "Ban da nhan viec ~y~Nong Dan~w~ hay thay dong phuc va bat dau lam viec");
						PlayerInfo[playerid][pJob] = JOB_FARMER;
						return 1;
					}
					else if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob2] != JOB_FARMER)
					{
						SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec Nong Dan thanh cong, hay thay dong phuc va bat dau lam viec.");
						SendClientTextDraw(playerid, "Ban da nhan viec ~y~Nong Dan~w~ hay thay dong phuc va bat dau lam viec");
						PlayerInfo[playerid][pJob2] = JOB_FARMER;
						return 1;
					}
					else return SendServerMessage(playerid, "Ban da co cong viec, hay nghi viec de bat dau cong viec nay.");
				}
				else
				{
					return SendClientMessageEx(playerid, COLOR_YELLOW, "Ban can toi vi tri xin viec /gps de tim cong viec.");
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
				if(GetPVarInt(playerid, #RangeFarm) == 1)
				{
					Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_INPUT, "Mua cay giong", "Nhap so luong", ">>", "<<");
				}
				else if(GetPVarInt(playerid, #RangeFarm) == 2)
				{
					Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_LIST, "Mua gia suc", "Bo\nNai", ">>", "<<");
				}
				else SendFarmerJob(playerid, "ERROR FARM RANGE");
			}
		}
	}
	return 1;
}

Dialog:BUYER_FARM_DIALOG(playerid, response, listitem, inputtext[]){
	if(response){
		new buyer_msg[128];
		if(GetPVarInt(playerid, #RangeFarm) == 1){
			if(PlayerInfo[playerid][pCash] < strval(inputtext)*CostTree) return SendFarmerJob(playerid, "Ban khong du tien!");
			PlayerInfo[playerid][pCayGiong]+= strval(inputtext);
			PlayerInfo[playerid][pCash]-= strval(inputtext)*CostTree;
			format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d hat giong voi gia %d",strval(inputtext),strval(inputtext)*CostTree);
			SendFarmerJob(playerid, buyer_msg);
		}
		else if(GetPVarInt(playerid, #RangeFarm) == 2){
			if(listitem == 0)
			{
				Dialog_Show(playerid, BUY_COW_DIALOG, DIALOG_STYLE_INPUT, "Mua bo giong", "Nhap so luong", ">>", "<<");
			}
			else if(listitem == 1)
			{
				Dialog_Show(playerid, BUY_DEER_DIALOG, DIALOG_STYLE_INPUT, "Mua nai giong", "Nhap so luong", ">>", "<<");
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
		PlayerInfo[playerid][pBo]+= strval(inputtext);
		PlayerInfo[playerid][pCash]-= strval(inputtext)*CostCow;
		format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d con bo voi gia %d",strval(inputtext),strval(inputtext)*CostTree);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}
Dialog:BUY_DEER_DIALOG(playerid, response, listitem, inputtext[]){
	new buyer_msg[128];
	if(response){
		if(PlayerInfo[playerid][pCash] < strval(inputtext)*CostDeer) return SendFarmerJob(playerid, "Ban khong du tien!");
		PlayerInfo[playerid][pNai]+= strval(inputtext);
		PlayerInfo[playerid][pCash]-= strval(inputtext)*CostDeer;
		format(buyer_msg, sizeof(buyer_msg), "Ban da mua thanh cong %d con bo voi gia %d",strval(inputtext),strval(inputtext)*CostTree);
		SendFarmerJob(playerid, buyer_msg);
	}
	return 1;	
}