#include <a_samp>
#include <YSI_Coding\y_hooks>
const
		JOB_WOOD = 30,
		MAX_WOOD = 10,
		WOOD_CHECK = 1883;

enum eWood {
	WoodObject,
	Text3D:WoodText,
	WoodStatus
}

new WoodInfo[MAX_WOOD][eWood];
new Float:WoodPostion[MAX_WOOD][3] = // Position có sẵn của bản cũ
{
	{-639.3089,-61.5377,64.8936},
	{-652.7448,-86.8826,63.3066},
	{-683.0600,-90.6403,66.3271},
	{-694.6327,-74.3674,69.7006},
	{-686.5068,-64.7477,69.8633},
	{-633.3345,-73.4974,65.3331},
	{-662.6438,-124.9772,61.1884},
	{-647.3447,-145.8317,63.0927},
	{-636.9913,-138.2652,65.7189},
	{-684.5880,-55.5238,70.5329}
};

new HasChainsaw[MAX_PLAYERS];
/*
	HasChainsaw -> biến lưu cưa máy, có gì cho nó lưu và thêm vào 24/7 giúp tui.
*/

/*-----------------------------------------*/
forward RespawnWood(i);
public RespawnWood(i)
{
	WoodInfo[i][WoodText] = CreateDynamic3DTextLabel("Cay Go\nNhan 'Y' de chat go", -1,  WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2]-1, 100);
	WoodInfo[i][WoodObject] = CreateObject(655, WoodPostion[i][0], WoodPostion[i][1], WoodPostion[i][2]-1, 0,0,0);
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

	new rand = Random(4, 7);
	Inventory_Add(playerid, "Go", rand);
	sendMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban nhan duoc %d go tu viec chat cai cay nay.", rand);

	DestroyObject(WoodInfo[GetPVarInt(playerid, #woodID)][WoodObject]);
	DestroyDynamic3DTextLabel(WoodInfo[GetPVarInt(playerid, #woodID)][WoodText]);
	SetTimerEx("RespawnWood", 60000 * 20, false, "d", GetPVarInt(playerid, #woodID)); // 20 min
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

CMD:chatgo(playerid, params[])
{
	new Float:PosXACtor, Float:PosYACtor, Float:PosZACtor;
	GetActorPos(ChatGoActor, PosXACtor, PosYACtor, PosZACtor);
	if(IsPlayerInRangeOfPoint(playerid, 2.0, PosXACtor, PosYACtor, PosZACtor))
	{
		if(PlayerInfo[playerid][pJob] != JOB_WOOD && PlayerInfo[playerid][pJob2] != JOB_WOOD)
		{
			ShowPlayerDialog(playerid, WOOD_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc", "Chon", "Huy");
		}
		else
		{
			ShowPlayerDialog(playerid, WOOD_MENU, DIALOG_STYLE_LIST, "Cong viec", "Xin viec\nNghi viec (1)\nNghi viec (2)\nThay dong phuc", "Chon", "Huy");
		}
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
				if (!IsValidObject(WoodInfo[i][WoodObject])) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Cay nay chua phat trien.");
				if (PlayerInfo[playerid][pJob] != JOB_WOOD && PlayerInfo[playerid][pJob2] != JOB_WOOD) return 1;
				if (GetPVarInt(playerid, #cuttingWood)) return 1;
				if (Inventory_Count(playerid, "May Cua") < 1) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban khong co may cua de chat go.");
				if (PlayerInfo[playerid][pModel] != 16) return SendClientMessage(playerid, 0xECA727FF, "LUMBER:{FFFFFF} Ban khong mac do bao ho.");

				TogglePlayerControllable(playerid, false);
				PlayAnim(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 1, 0, 1);
				SetPlayerAttachedObject(playerid, PIZZA_INDEX, 341, 6, -0.059999,	0.034,	0.319,	21,	-110.5,	112.8,	1,	1,	1, 0, 0);
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
        			if (IsPlayerInRangeOfPoint(playerid,5.0,-543.2013,-197.4136,78.4063)) {
        				if(PlayerInfo[playerid][pJob] == JOB_WOOD || PlayerInfo[playerid][pJob2] == JOB_WOOD) return SendErrorMessage(playerid, " Ban da lam viec Lam Tac roi.");
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
        			SetPlayerSkin(playerid, 16);
        			PlayerInfo[playerid][pModel] = 16;
        			SendClientTextDraw(playerid, "Ban da thay trang phuc hay bat dau lam viec");
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

    	WoodInfo[i][WoodText] = CreateDynamic3DTextLabel("Cay Go\nNhan 'Y' de chat go", -1,  WoodPostion[i][0],WoodPostion[i][1],WoodPostion[i][2]-1, 100);
    	WoodInfo[i][WoodObject] = CreateObject(655, WoodPostion[i][0], WoodPostion[i][1], WoodPostion[i][2]-1, 0,0,0);
    	WoodInfo[i][WoodStatus]  = 0;
    }

	ChatGoActor = CreateActor(16,-544.4698, -196.8952, 78.4063, 276.5303);
	return 1;
}