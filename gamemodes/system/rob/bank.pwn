#include <YSI_Coding\y_hooks>
new Robbingbank = -1;
new Robber_Timer;
new RuaTien_Timer[MAX_PLAYERS];
new RuaTien_Status[MAX_PLAYERS];
#define DIALOG_RUATIEN 10090
hook OnGameModeInit()
{
	CreateObject(2332, 2305.73047, -0.39158, 26.16562,   0.00000, 0.00000, 90);
	CreateDynamic3DTextLabel("{FF0000}Su dung '/robbank' de cuop", -1, 2305.73047, -0.39158, 26.16562+0.6,12.0);

	CreateDynamic3DTextLabel("{FF0000}Dia diem rua tien 1", -1,1207.8416,144.8207,20.4785+0.6,12.0);
	CreateDynamic3DTextLabel("{FF0000}Dia diem rua tien 2", -1,1493.1688,-666.8275,95.6013+0.6,12.0);
	CreateDynamic3DTextLabel("{FF0000}Dia diem rua tien 3", -1,1891.7700,-1070.3519,23.9375+0.6,12.0);
	return 1;
}
CMD:resetrobbank(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendErrorMessage(playerid,"Ban khong co quyen su dung lenh nay");
	Robbingbank = -1;
	SendClientMessage(playerid, -1,"Ban da reset rob bank thanh cong !");
	return 1;
}
CMD:robbank(playerid, params[])
{
	new hourb, minuteb, secondb;
	gettime(hourb, minuteb, secondb);
	/*if(hour < 19 || hour > 23) return SendErrorMessage(playerid, "Day khong phai thoi diem cuop (20h - 22h)");
	if(Cops < 2) return SendErrorMessage(playerid, "So luong PD khong du de thuc hien vu cuop !");*/

	if(Robbingbank != -1) return SendErrorMessage(playerid, "Ngan hang da bi cuop , ban khong the thuc hien !");
	Robbingbank = playerid;
	Robber_Timer = SetTimerEx("OnPlayerRobbing", 1000, 1, "i", playerid);

	new rob_msg[1280];
	format(rob_msg, sizeof(rob_msg), "{FF0000}[CANH BAO]{FFFFFF} %s dang cuop ngan hang !", GetPlayerNameEx(playerid));
	SendGroupMessage(1, -1, rob_msg);
	return 1;
}

forward OnPlayerRobbing(playerid);
public OnPlayerRobbing(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 20.0, 2305.73047, -0.39158, 26.16562) && Robbingbank == playerid) {
		Inventory_Add(playerid, "Dirty", 1, 60*24*2);
		// SendClientMessage(playerid, -1, "Ban da cuop duoc 1 cuc tien");

		new rob_msg[1280];
		format(rob_msg, sizeof(rob_msg), "Ban da cuop %d cuc tien", Inventory_Count(playerid, "Dirty"));
		SendClientTextDraw(playerid, rob_msg, 1);
	}
	else{
		SendClientMessage(playerid, -1, "Ban da roi khoi khu vuc cuop tien , hanh dong se bi dung lai !");
		KillTimer(Robber_Timer);
	}
	return 1;
}

CMD:ruatien(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_RUATIEN, DIALOG_STYLE_LIST, "Dia diem rua tien", "Khu vuc rua tien 1\nKhu vuc rua tien 2\nKhu vuc rua tien 3", "Chon", "Huy");
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_RUATIEN && response == 1)
	{
		if(listitem == 0)
		{
			CP[playerid] = 12320;
			SetPlayerCheckpoint(playerid,1207.8416,144.8207,20.4785, 5);
		}
		if(listitem == 1)
		{
			CP[playerid] = 12321;
			SetPlayerCheckpoint(playerid,1493.1688,-666.8275,95.6013, 5);
		}
		if(listitem == 2)
		{
			CP[playerid] = 12322;
			SetPlayerCheckpoint(playerid,1891.7700,-1070.3519,23.9375, 5);
		}
		SetPVarInt(playerid, #RuaTien_Type, listitem+1);
		SendClientMessage(playerid, -1, "Dia diem da duoc danh dau tren ban do !");
	}
	return 1;
}
stock PlayerRuaTien(playerid)
{
	new rt_type = GetPVarInt(playerid, #RuaTien_Type);

	if(!Inventory_HasItem(playerid, "Dirty")) return SendErrorMessage(playerid, "Ban khong co tien ban de rua !");
	
	if(rt_type == 1)
		SetPVarInt(playerid, #RuaTien_Time, 60*5);
	else if(rt_type == 2)
		SetPVarInt(playerid, #RuaTien_Time, 60*10);
	else
		SetPVarInt(playerid, #RuaTien_Time, 60*20);

	RuaTien_Timer[playerid] = SetTimerEx("OnPlayerRuaTien", 1000, 1, "i", playerid);
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if(CP[playerid] == 12320 || CP[playerid] == 12321 || CP[playerid] == 12322)
	{
		PlayerRuaTien(playerid);
		CP[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
}

forward OnPlayerRuaTien(playerid);
public OnPlayerRuaTien(playerid)
{
	if(GetPVarInt(playerid, #RuaTien_Time) > 0)
	{
		new rt_msg[1280];
		format(rt_msg, sizeof(rt_msg), "Ban dang rua tien , thoi gian con %d giay", GetPVarInt(playerid, #RuaTien_Time));
		SendClientTextDraw(playerid, rt_msg, 1);

		new rt_type = GetPVarInt(playerid, #RuaTien_Type);

		if(rt_type == 1)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1207.8416,144.8207,20.4785)){
				SetPVarInt(playerid, #RuaTien_Time, 0);
				RuaTien_Status[playerid] = -1;
			}
		}
		if(rt_type == 2)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1493.1688,-666.8275,95.6013)){
				SetPVarInt(playerid, #RuaTien_Time, 0);
				RuaTien_Status[playerid] = -1;
			}
		}
		if(rt_type == 3)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1891.7700,-1070.3519,23.9375)){
				SetPVarInt(playerid, #RuaTien_Time, 0);
				RuaTien_Status[playerid] = -1;
			}
		}
	}
	else {
		if(RuaTien_Status[playerid] == 1)
		{
			new percent = 0;
			switch(GetPVarInt(playerid, #RuaTien_Type))
			{
				case 1: percent=60;
				case 2: percent=70;
				case 3: percent=90;
				default: percent=60;
			}
			new rt_amount = Inventory_Count(playerid, "Dirty");
			new rt_msg[1280];
			format(rt_msg, sizeof(rt_msg), "Ban da rua thanh cong %d cuc tien ban !", rt_amount);
			SendClientMessage(playerid, -1, rt_msg);

			Inventory_RemoveTimer(playerid, "Dirty", rt_amount);

			PlayerInfo[playerid][pCash] += rt_amount*(percent/100*500000);
		}
		else{
			Inventory_RemoveTimer(playerid, "Dirty", Inventory_Count(playerid, "Dirty"));
			SendErrorMessage(playerid, "Ban da rua tien that bai");
		}
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	RuaTien_Status[playerid] = 1;
	return 1;
}