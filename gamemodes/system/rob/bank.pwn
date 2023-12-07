#include <YSI_Coding\y_hooks>
new Robbingbank = -1;
new Robber_Timer[MAX_PLAYERS];
new Rob_Status[MAX_PLAYERS] = 0;
new RuaTien_Timer[MAX_PLAYERS];
new RuaTien_Status[MAX_PLAYERS] = 0;
#define DIALOG_RUATIEN 10090
hook OnGameModeInit()
{
	CreateObject(2332, 1436.2850,-999.7745,1639.8025,   0.00000, 0.00000, 90);
	CreateDynamic3DTextLabel("{FF0000}Su dung '/robbank' de cuop", -1, 1436.2850,-999.7745,1639.8025 +0.6,12.0);

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
	if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1436.2850,-999.7745,1639.8025)) return SendErrorMessage(playerid, "Ban khong o khu vuc cuop ngan hang !");
	new hourb, minuteb, secondb;
	gettime(hourb, minuteb, secondb);
	if(hour < 19 || hour > 23) return SendErrorMessage(playerid, "Day khong phai thoi diem cuop (20h - 22h)");
	if(Cops < 2) return SendErrorMessage(playerid, "So luong PD khong du de thuc hien vu cuop !");

	if(Rob_Status[playerid] == 1) return SendErrorMessage(playerid, "Ban dang cuop ngan hang roi !");
	new check_g = 0;
	for(new i = 0; i < 13; i++)
	{
		new weapon_g,ammos_g;
		GetPlayerWeaponData(playerid, i, weapon_g, ammos_g);
    	if(weapon_g == 29 || weapon_g == 30 || weapon_g == 31 || weapon_g == 27) check_g = 1;
	}
	if(check_g == 0) return SendErrorMessage(playerid, "Ban khong co vu ki tren nguoi (MP5, M4, AK47, Combat Shotgun) ");

	if(Robbingbank == -1){
		Rob_Status[playerid] = 1;
		Robbingbank = playerid;
		Robber_Timer[playerid] = SetTimerEx("OnPlayerRobbing", 1000, 1, "i", playerid);
		new rob_msg[1280];
		format(rob_msg, sizeof(rob_msg), "{FF0000}[CANH BAO (Faction)]{FFFFFF} {fccf03}%s {FF0000}dang cuop ngan hang !", GetPlayerNameEx(playerid));
		SendGroupMessage(1, -1, rob_msg);

	} else SendErrorMessage(playerid, "Ngan hang da bi cuop , ban khong the thuc hien !");
	return 1;
}

forward OnPlayerRobbing(playerid);
public OnPlayerRobbing(playerid)
{
	if(Rob_Status[playerid] != 1) {
		SendErrorMessage(playerid, "Ban da chet trong luc cuop va khong nhan duoc bat ki tien ban nao !");
		DeletePVar(playerid, #DirtyAmount);
		KillTimer(Robber_Timer[playerid]);
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 20.0, 1436.2850,-999.7745,1639.8025) && Robbingbank == playerid) {
		
		SetPVarInt(playerid, #DirtyAmount, GetPVarInt(playerid, #DirtyAmount)+1);

		new rob_msg[1280];
		format(rob_msg, sizeof(rob_msg), "Ban da cuop %d cuc tien", GetPVarInt(playerid, #DirtyAmount));
		SendClientTextDraw(playerid, rob_msg, 1);
	}
	else{
		Rob_Status[playerid] = 0;
		Robbingbank = -2;
		Inventory_Add(playerid, "Tien Ban", GetPVarInt(playerid, #DirtyAmount), 60*24*2);

		SendClientMessage(playerid, -1, "Ban da roi khoi khu vuc cuop tien , hanh dong se bi dung lai !");
		DeletePVar(playerid, #DirtyAmount);
		KillTimer(Robber_Timer[playerid]);
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
	
	RuaTien_Status[playerid] = 1;

	if(!Inventory_HasItem(playerid, "Tien Ban")) return SendErrorMessage(playerid, "Ban khong co tien ban de rua !");
	
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
		if(Inventory_Count(playerid, "Tien Ban") <= 0) return SendErrorMessage(playerid, "Ban khong co tien ban de rua");
		PlayerRuaTien(playerid);
		CP[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

forward OnPlayerRuaTien(playerid);
public OnPlayerRuaTien(playerid)
{
	if(GetPVarInt(playerid, #RuaTien_Time) > 0)
	{
		new rt_msg[1280];
		format(rt_msg, sizeof(rt_msg), "Ban dang rua tien , thoi gian con %d giay", GetPVarInt(playerid, #RuaTien_Time));
		SendClientTextDraw(playerid, rt_msg, 1);
		
		SetPVarInt(playerid, #RuaTien_Time, GetPVarInt(playerid, #RuaTien_Time)-1);

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
	else if(GetPVarInt(playerid, #RuaTien_Time) <= 0) {
		if(RuaTien_Status[playerid] == 1)
		{
			new percent = 60;
			new rt_type = GetPVarInt(playerid, #RuaTien_Type);
			if(rt_type == 1) percent = 60;
			else if(rt_type == 2) percent = 70;
			else if(rt_type == 3) percent = 90;
			else percent = 60;

			new rt_amount = Inventory_Count(playerid, "Tien Ban");
			new rt_msg[1280];
			format(rt_msg, sizeof(rt_msg), "%s da rua thanh cong %d cuc tien ban voi so tien nhan duoc la %d !",GetPlayerNameEx(playerid), rt_amount, rt_amount*percent);
			SendClientMessage(playerid, -1, rt_msg);
			printf("Percent : %d", percent);
			PlayerInfo[playerid][pCash] += rt_amount*percent;
			Log("Robbank.log", rt_msg);
			
			Inventory_RemoveTimer(playerid, "Tien Ban", rt_amount);
			RuaTien_Status[playerid] = 0;
			KillTimer(RuaTien_Timer[playerid]);
		}
		else if(RuaTien_Status[playerid] == -1){
			Inventory_RemoveTimer(playerid, "Tien Ban", Inventory_Count(playerid, "Tien Ban"));
			SendErrorMessage(playerid, "Ban da rua tien that bai");
			KillTimer(RuaTien_Timer[playerid]);
		}
	}
	return 1;
}
hook OnPlayerConnect(playerid)
{
	RuaTien_Timer[playerid] = -1;
	RuaTien_Status[playerid] = 0;
	return 1;
}
hook OnPlayerDeath(playerid, killerid, reason)
{
	Rob_Status[playerid] = 0;
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(RuaTien_Status[playerid] == 1){
		KillTimer(RuaTien_Timer[playerid]);
		RuaTien_Timer[playerid] = -1;
		RuaTien_Status[playerid] = 0;
	}
	Robbingbank = -2;
	return 1;
}

CMD:rbtime(playerid, params[])
{
	SetPVarInt(playerid, #RuaTien_Time, 5);
	return 1;
}

CMD:rbtest(playerid, params[])
{
	Inventory_Add(playerid, "Tien Ban", 10);
	return 1;
}

CMD:rbpos(playerid, params[]){
	SetPlayerPos(playerid, 1436.5100,-999.5000,1641.2740);
	return 1;
}