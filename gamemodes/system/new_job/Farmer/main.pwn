#include <YSI_Coding\y_hooks>
#define JOB_FARMER 31
#define FARMER_MENU 2000

#include "system/new_job/Farmer/plant.pwn"
#include "system/new_job/Farmer/map.pwn"
// #include "system/new_job/Farmer/raise.pwn"

SendFarmerJob(playerid, msg_job[])
{
	new format_job[1280];
	format(format_job, sizeof(format_job), "{212c59}[FARMER]{FFFFFF}: %s", msg_job);
	SendClientMessage(playerid, -1, format_job);
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
CMD:farmer(playerid, params[])
{
	if(IsPlayerInRangeOfActor(playerid, ActorFarmer, 5.0) || IsPlayerInRangeOfPoint(playerid, 5.0, -382.8567,-1430.5543,25.7266))
	{
		ShowPlayerDialog(playerid, FARMER_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc", "Chon", "Huy");
	}
	else SendFarmerJob(playerid, "Ban khong o gan NPC Farmer");
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case FARMER_MENU: {
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
        	}
        }
	}
	return 1;
}