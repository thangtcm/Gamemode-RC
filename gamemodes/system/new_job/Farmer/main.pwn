#include <YSI\y_hooks>
#define JOB_FARMER 31

#include "system/new_job/Farmer/plant.pwn"
#include "system/new_job/Farmer/map.pwn"
// #include "system/new_job/Farmer/raise.pwn"
new CostTree = 1000;
new CostCow = 7000, CostDeer = 5000;
SendFarmerJob(playerid, const msg_job[])
{
	new format_job[1280];
	format(format_job, sizeof(format_job), "{212c59}[FARMER]{FFFFFF}: %s", msg_job);
	SendClientMessage(playerid, COLOR_WHITE, format_job);
	return 1;
}
hook OnPlayerConnect(playerid)
{
	RemoveBuildingFarmMap(playerid);
}
hook OnGameModeInit()
{
	CreateFarmMap(); 
	return 1;
}
CMD:farmpos1(playerid, params[])
{
	SetPlayerPos(playerid, -382.8567,-1430.5543,25.7266);
	return 1;
}
CMD:farmpos2(playerid, params[])
{
	SetPlayerPos(playerid, -1420.0443,-1474.9486,101.6293);
	return 1;
}
CMD:farmer(playerid, params[])
{
	new Float:x,
            Float:y,
            Float:z;
	GetDynamicActorPos(ActorFarmer, x, y, z);

	if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z) || IsPlayerInRangeOfPoint(playerid, 5.0, -382.8567,-1430.5543,25.7266))
	{
		SetPVarInt(playerid, #RangeFarm, 1);
		Dialog_Show(playerid, FARMER_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc\nMua cay giong", "Chon", "Huy");
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, -1420.0443,-1474.9486,101.6293)){
		SetPVarInt(playerid, #RangeFarm, 2);
		Dialog_Show(playerid, FARMER_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc\nMua gia suc", "Chon", "Huy");
	}
	else SendFarmerJob(playerid, "Ban khong o gan NPC Farmer");
	return 1;
}

Dialog:FARMER_MENU(playerid, dialogid, response, listitem, inputtext[]){
	if(response)
	{
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
					if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob] != 30)
					{
						SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec Nong Dan thanh cong, hay thay dong phuc va bat dau lam viec.");
						SendClientTextDraw(playerid, "Ban da nhan viec ~y~Nong Dan~w~ hay thay dong phuc va bat dau lam viec");
						PlayerInfo[playerid][pJob2] = JOB_FARMER;
						return 1;
					}		
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
					Dialog_Show(playerid, BUYER_FARM_DIALOG, DIALOG_STYLE_INPUT, "Mua gia suc", "Bo\nNai", ">>", "<<");
				}
				else SendFarmerJob(playerid, "ERROR FARM RANGE");
			}
		}
	}
	return 1;
}

Dialog:BUYER_FARM_DIALOG(playerid, dialogid, response, listitem, inputtext[]){
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

Dialog:BUY_COW_DIALOG(playerid, dialogid, response, listitem, inputtext[]){
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
Dialog:BUY_DEER_DIALOG(playerid, dialogid, response, listitem, inputtext[]){
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