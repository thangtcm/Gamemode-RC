#include <a_samp>
#include <YSI_Coding\y_hooks>
const
		JOB_WOOD = 30,
		MAX_WOOD = 20,
		WOOD_CHECK = 1883;

enum eWood {
	WoodObject,
	Text3D:WoodText,
	WoodStatus
}

new WoodInfo[MAX_WOOD][eWood];
new Float:WoodPostion[MAX_WOOD][3] = // Position có sẵn của bản cũ
{
	{2335.5977, -668.5015, 130.7016},
	{2330.4456, -659.3566, 129.9227},
	{2336.8455, -641.0065, 130.1403},
	{2329.9133, -624.2472, 130.3419},
	{2341.4902, -623.6232, 129.0536},
	{2309.6648, -621.8474, 131.5609},
	{2291.6758, -629.4958, 134.1639},
	{2296.5176, -646.1287, 132.8668},
	{2307.9695, -657.5830, 131.0593},
	{2297.8538, -671.0771, 130.5975},
	{2298.9238, -686.5168, 130.2329},
	{2299.0354, -704.7725, 129.8714},
	{2325.8459, -710.2009, 131.1172},
	{2330.8247, -701.1703, 131.8430},
	{2343.0732, -693.4159, 132.6132},
	{2358.7197, -695.5845, 131.4068},
	{2360.5745, -709.9018, 131.2718},
	{2354.8420, -723.4679, 131.6167},
	{-683.731018, -146.484481, 59.855533},
	{-610.268005, -37.102207, 61.575477}
};

/*-----------------------------------------*/
forward RespawnWood(i);
public RespawnWood(i)
{
	WoodInfo[i][WoodText] = CreateDynamic3DTextLabel("Cay Go\nNhan 'Y' de chat go", -1,  WoodPostion[i][0], WoodPostion[i][1], WoodPostion[i][2]+1.2, 13.0);
	WoodInfo[i][WoodObject] = CreateDynamicObject(655, WoodPostion[i][0], WoodPostion[i][1], WoodPostion[i][2], 0,0,0);
	WoodInfo[i][WoodStatus] = 0;
	printf("Wood %d respawn", i);
	return 1;
}

forward CuttingWood(playerid);
public CuttingWood(playerid)
{
	if (GetPVarInt(playerid, #CuttingCheck)) return 1;
	if (GetPVarInt(playerid, #cuttingTimer) > 0)
	{
		SetPVarInt(playerid, #cuttingTimer, GetPVarInt(playerid, #cuttingTimer) - 1);
		return 1;
	}
	ClearCutting(playerid);

	new rand = Random(1, 2), santahat = 1 + random(100);
	if(10 <= santahat <= 15) Inventory_Add(playerid, "Santa Hat", 1);

	Inventory_Add(playerid, "Go", rand);
	sendMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban nhan duoc %d go tu viec chat cai cay nay.", rand);

	DestroyDynamicObject(WoodInfo[GetPVarInt(playerid, #woodID)][WoodObject]);
	DestroyDynamic3DTextLabel(WoodInfo[GetPVarInt(playerid, #woodID)][WoodText]);
	SetTimerEx("RespawnWood", 60000 * 10, false, "d", GetPVarInt(playerid, #woodID)); // 20 min
	return 1;
}

forward CuttingCheck(playerid);
public CuttingCheck(playerid)
{
	new 
		i = 7, 
		captcha[12], info[128];

	while(i--) captcha[i] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');

	SetPVarInt(playerid, #CuttingCheck, 1);
	SetPVarString(playerid, #captcha_code, captcha);
	format(info, sizeof(info), "Ma kiem tra: {1EEBB5}%s{FFFFFF}\n\n{EC2727}-> Vui long nhap ma kiem tra ben duoi de tiep tuc:", captcha);
	ShowPlayerDialog(playerid, WOOD_CHECK, DIALOG_STYLE_INPUT, "Wood Captcha", info, "Gui", "Dong");
	return 1;
}

stock GetWoodNearest(playerid)
{
	for (new i = 0; i<MAX_WOOD; i++) {
		if(IsPlayerInRangeOfObject(playerid, WoodInfo[i][WoodObject], 3)) return i;
	}

	return -1;
}

stock ClearCutting(playerid)
{
	DeletePVar(playerid, #cuttingWood);
	DeletePVar(playerid, #cuttingTimer);
	DeletePVar(playerid, #CuttingCheck);
	DeletePVar(playerid, #captcha_code);
	RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 0, 1);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, true);

	WoodInfo[GetPVarInt(playerid, #woodID)][WoodStatus] = 0;
	return 1;
}

CMD:wood(playerid, params[])
{
	new Float:PosXACtor, Float:PosYACtor, Float:PosZACtor;
	GetActorPos(ChatGoActor, PosXACtor, PosYACtor, PosZACtor);
	if(IsPlayerInRangeOfPoint(playerid, 2.0, PosXACtor, PosYACtor, PosZACtor))
	{
		ShowPlayerDialog(playerid, WOOD_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc", "Chon", "Huy");
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	new i;
	if (KeyPressed(KEY_YES))
	{
		if((i = GetWoodNearest(playerid)) != -1)
		{
			if (WoodInfo[i][WoodStatus] == 0)
			{
				if (!IsValidDynamicObject(WoodInfo[i][WoodObject])) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Cay nay chua phat trien.");
				if (PlayerInfo[playerid][pJob] != JOB_WOOD && PlayerInfo[playerid][pJob2] != JOB_WOOD) return 1;
				if (GetPVarInt(playerid, #cuttingWood)) return 1;
				if (Inventory_Count(playerid, "May Cua") < 1) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban khong co may cua de chat go.");
				if (GetPlayerSkin(playerid) != 16) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban khong mac do bao ho.");

				TogglePlayerControllable(playerid, false);
				PlayAnim(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 1, 0, 1);
				SetPlayerAttachedObject(playerid, PIZZA_INDEX, 341, 6, 0.0,	0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 1, 0, 0);
				SetPVarInt(playerid, #cuttingWood, 1);
				SendClientTextDraw(playerid, "Dang chat go...");
				
				new rand_time = Random(30, 70);
				SetPVarInt(playerid, #cuttingTimer, rand_time);
				SetTimerEx("CuttingWood", 1000, false, "d", playerid);
				SetTimerEx("CuttingCheck", (rand_time - (rand_time / 2)) * 1000, false, "d", playerid);

				SetPVarInt(playerid, #woodID, i);
				WoodInfo[i][WoodStatus] = 1;
			}
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case WOOD_MENU: {
			if(PlayerInfo[playerid][pCMND] < 1) return SendErrorMessage(playerid,"Ban khong co CMND.");
        	switch(listitem) {
        		case 0: {
        			if (IsPlayerInRangeOfPoint(playerid,5.0,2357.2139, -651.3280, 128.0547)) {
        				if(PlayerInfo[playerid][pJob] == JOB_WOOD || PlayerInfo[playerid][pJob2] == JOB_WOOD) return 1;
            			if(PlayerInfo[playerid][pJob] == 0)
                        {
                			SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
                			SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                			PlayerInfo[playerid][pJob] = JOB_WOOD;
                			return 1;
            			}
            			if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob] != 30)
            			{
            				SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
            				SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                		    PlayerInfo[playerid][pJob2] = JOB_WOOD;
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
        			if(PlayerInfo[playerid][pJob] != JOB_WOOD && PlayerInfo[playerid][pJob2] != JOB_WOOD) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        			
					if(GetPlayerSkin(playerid) == 16)
					{
						SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
						SendClientTextDraw(playerid, "Ban da cat quan ao lam viec.");
					}
					else {
						SetPlayerSkin(playerid, 16);
						SendClientTextDraw(playerid, "Ban da thay quan ao lam viec.");
					}
        		}
        	}
        }
		case WOOD_CHECK: {
			if (!response) {
				ClearCutting(playerid);
				SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban da chat go that bai vi khong nhap ma kiem tra.");
				return 1;
			}

			new captcha[12];
			GetPVarString(playerid, #captcha_code, captcha, 12);
			if (strcmp(captcha, inputtext, true) != 0) {
				ClearCutting(playerid);
				SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban da chat go that bai vi ma kiem tra sai.");
				return 1;
			}

			DeletePVar(playerid, #CuttingCheck);
			DeletePVar(playerid, #captcha_code);
			DeletePVar(playerid, #cuttingTimer);
			SetTimerEx("CuttingWood", 1000, false, "d", playerid);
		}
	}
	return 1;
}

hook OnGameModeInit()
{
    for(new i = 0 ; i < MAX_WOOD ; i++) 
	{

    	WoodInfo[i][WoodText] = CreateDynamic3DTextLabel("Cay Go\nNhan 'Y' de chat go", -1,  WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2]+1.2, 13.0);
    	WoodInfo[i][WoodObject] = CreateDynamicObject(655, WoodPostion[i][0], WoodPostion[i][1], WoodPostion[i][2], 0,0,0);
    	WoodInfo[i][WoodStatus]  = 0;
    }

	ChatGoActor = CreateActor(16,2357.2139, -651.3280, 128.0547, 173.9230);
	return 1;
}
