#include <YSI_Coding\y_hooks>

new CountPress[MAX_PLAYERS];
new KeyPressed[MAX_PLAYERS];
new TimerPressKey[MAX_PLAYERS];
new KeyPressesType[MAX_PLAYERS];
new GetKeyMiner[MAX_PLAYERS];
new MinerTimer[MAX_PLAYERS];
new TimerRandomPress[MAX_PLAYERS];
new RockIDMiner[MAX_PLAYERS];
hook OnPlayerConnect(playerid)
{
	CountPress[playerid] = 0;
	TimerPressKey[playerid] = 0;
	KeyPressed[playerid] = true;
	KillTimer(MinerTimer[playerid]);
	timerdc[playerid] = 0;
	RockIDMiner[playerid] = -1;
	DeletePVar(playerid, "MinerWorking");
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 0) return 1;
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 588.1791,866.1268,-42.4973))
	{
	    if(PRESSED(KEY_YES))
	    {
	    	Dialog_Show(playerid, minerdialog, DIALOG_STYLE_LIST, "Quan ly khu mo", "Nhan / tra dong phuc lam viec\nMua Pickaxe (dung cu de dao)", "Lua chon", "Huy bo");
	    }
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 2126.8018,-76.6521,2.4721))
	{
	    if(PRESSED(KEY_YES))
	    {
			new format_job[1280];
			format(format_job, sizeof(format_job), "{a8a7a7}Da: {ffffff}%d$\n{c96c02}Dong: {ffffff}%d$\n{5c5c5c}Sat: {ffffff}%d$\n{f7ff05}Vang: {ffffff}%d$", RandomMoney[0], RandomMoney[1], RandomMoney[2], RandomMoney[3]);
	    	Dialog_Show(playerid, thuksdialog, DIALOG_STYLE_LIST, "Thu mua khoang san", format_job, "Lua chon", "Huy bo");
	    }
	}
	if(IsPlayerInRangeOfPoint(playerid, 300.0, 588.1791,866.1268,-42.4973))
	{
		if(PRESSED(KEY_YES))
		{
			for(new i = 0; i < MAX_ROCKS; i++)
			{
				if(RockStatus[i] == 1)
				{
					if(IsPlayerInRangeOfPoint(playerid, 2.0, rockPositions[i][0], rockPositions[i][1], rockPositions[i][2]))
					{
						if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
						if(GetPlayerSkin(playerid) == 27)
						{
							if(Inventory_Count(playerid, "Pickaxe") >= 1)
							{
								if(timerdc[playerid] == 0)
								{
									OnPlayerPickUpRock(playerid, i);
									RockIDMiner[playerid] = i;
								}
								else return SendErrorMessage(playerid, " Ban dang dao da roi.");
							}
							else return SendErrorMessage(playerid, " Ban chua mua Pickaxe.");
						}
						else return SendErrorMessage(playerid, " Ban dang khong mac quan ao bao ho cua cong viec miner, hay den NPC de lay quan ao.");
					}
				}
			}
		}
	}
	if(!KeyPressed[playerid])
	{
		if((PRESSED(GetKeyMiner[playerid])) && !KeyPressed[playerid])
		{
			KeyPressed[playerid] = true;
			TimerPressKey[playerid] = 0;
			SendServerMessage(playerid, "Ban thao tac qua tot.");
			new GetTimeNow = gettime();
			if(GetTimeNow - GetPVarInt(playerid, "TimeCountNotyHack") <= 1 && GetPVarInt(playerid, "TimeCountNotyHack") < GetTimeNow)
			{
				CountPress[playerid] ++;
				new string[128];
				format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID: %d) Da thuc hien nhan phim capcha voi toc do ban tho %d lan.", GetPlayerNameEx(playerid), playerid, CountPress[playerid]);
				ABroadCast(COLOR_YELLOW, string, 2);
				format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID: %d) co the dang su dung cleo auto farm nhan phim capcha trong %d giay.", GetPlayerNameEx(playerid), playerid, GetTimeNow - GetPVarInt(playerid, "TimeCountNotyHack"));
				ABroadCast(COLOR_YELLOW, string, 2);
			}
			else
			{
				CountPress[playerid] = 0;
			}
		}
		else
		{
			FaildMiner(playerid);
		}
	}
	return 1;
}

stock FaildMiner(playerid)
{
	SendErrorMessage(playerid, "Ban da dao da that bai.");
	KillTimer(MinerTimer[playerid]);
	KeyPressed[playerid] = true;
	StopLoopingAnim(playerid);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	timerdc[playerid] = 0;
	TimerPressKey[playerid] = 0;
	if(RockIDMiner[playerid] != -1)
	{
		CreateRock(RockIDMiner[playerid]);
		RockStatus[RockIDMiner[playerid]] = 1;
		RockIDMiner[playerid] = -1;
	}
	DeletePVar(playerid, "MinerWorking");
	return 1;
}

forward ResetPrice();
public ResetPrice()
{
	new bool:isHight = false;
	switch(random(100))
	{
		case 0..50:
		{
			RandomMoney[0] = (10+random(30)); // 20
			RandomMoney[1] = (RandomMoney[0] + 5 +random(50)); // 45
			RandomMoney[2] = (RandomMoney[1]+random(55));// 70
			RandomMoney[3] = (RandomMoney[2]+random(250));// => 270
		}
		case 51..89:
		{
			RandomMoney[0] = (20 * 2+random(30)) ;//70
			RandomMoney[1] = (RandomMoney[0] + random(50)) ; // 120
			RandomMoney[2] = (RandomMoney[1] * 2+random(50)) ; // 240 + 50 => 290
			RandomMoney[3] = (RandomMoney[2] + random(100)+110); //  500
		}
		case 90..100:
		{
			RandomMoney[0] = (30*2+random(30) * 2); // 60+60 => 120
			RandomMoney[1] = (RandomMoney[0] + 30 +random(25) * 2);//120 + 80 => 200
			RandomMoney[2] = (RandomMoney[1] * 2 +random(240));// 440
			RandomMoney[3] = (RandomMoney[2] + 260 + random(300));// 440 + 260 + 300 => 1k
			isHight = true;
		}
	}

	
	SetTimer("ResetPrice", 3600000, false);
	if(isHight)
		SendClientMessageToAll(COLOR_REALRED, "[THU MUA KHOANG SAN] {ffffff}Thi truong khoang san dang bi khan hiem, gia ca thi truong tang cao ngat nguong.");
	SendClientMessageToAll(COLOR_REALRED, "[THU MUA KHOANG SAN] {ffffff}Gia ca thi truong da thay doi, hay den nguoi thu mua tai Palomino Creek de xem gia ca.");
    new moneyzxc0[30], moneyzxc1[30], moneyzxc2[30], moneyzxc3[30];
    format(moneyzxc0, 30, "%d$", RandomMoney[0]);
    format(moneyzxc1, 30, "%d$", RandomMoney[1]);
    format(moneyzxc2, 30, "%d$", RandomMoney[2]);
    format(moneyzxc3, 30, "%d$", RandomMoney[3]);
	SendLogToDiscordRoom4("RC:RP LOG - GIÁ CẢ THU MUA", "1157993235776557156", "ĐÁ", moneyzxc0, "ĐỒNG", moneyzxc1, "SẮT", moneyzxc2, "VÀNG", moneyzxc3, 0x8d9922);
    return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid, #skinsavezxc) != 0)
	{
		timerdc[playerid] = 0;
		RemovePlayerAttachedObject(playerid, 8);
		RemovePlayerAttachedObject(playerid, 9);
		new skinc = GetPVarInt(playerid, #skinsavezxc);
		SetPlayerSkin(playerid, skinc);
		SetPVarInt(playerid, #skinsavezxc, 0);
	}
	FaildMiner(playerid);
	return 1;
}
hook OnGameModeInit()
{
    for (new i = 0; i < MAX_ROCKS; i++)
    {
        RockStatus[i] = 1; 
        CreateRock(i);
    }
    SetTimer("ResetPrice", 20000, false);
    return 1;
}
forward OnPlayerPickUpRock(playerid, rockIndex);
public OnPlayerPickUpRock(playerid, rockIndex)
{
    if (RockStatus[rockIndex] == 1)
    {
    	RockStatus[rockIndex] = 0;
		timerdc[playerid] = 35+(random(40));
		if(DownCountJobTime[playerid] >= gettime()) {
			timerdc[playerid] -= 10;
		}
		TimerRandomPress[playerid] = random(timerdc[playerid]-10);
		timerd = timerdc[playerid]*1000;
		KeyPressed[playerid] = true;
		SetPVarInt(playerid, "MinerWorking", 1);
		MinerTimer[playerid] = SetTimerEx("StartCountTime", 1000, true, "i", playerid);
    	DestroyDynamicObject(RockObj[rockIndex]);
    	DestroyDynamic3DTextLabel(RockText[rockIndex]);
   		ApplyAnimation(playerid,"BASEBALL","Bat_4",1.0,1,1,1,1,1);
		SetPVarInt(playerid, #dangdaoda, 1);
		TogglePlayerControllable(playerid, 0);
		SetPlayerAttachedObject(playerid, 9, 2228, 6, 0.036999, 0.041, 0.21, 0.0, 172.8, -89.3, 0.805, 1.046, 0.789999);
    }
}
forward StartCountTime(playerid);
public StartCountTime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "MinerWorking") != 0)
		{
			if(TimerPressKey[playerid] <= 0 && KeyPressed[playerid])
			{
				if(timerdc[playerid] > 0)
				{
					
					timerdc[playerid]--;
					new format_job[1280];
					if(DownCountJobTime[playerid] >= gettime()) {
						format(format_job, sizeof(format_job), "Ban dang dao da, vui long doi~p~ %d~w~ de dao xong (~r~-10 giay~w~).", timerdc[playerid]);
					}
					else {
						format(format_job, sizeof(format_job), "Ban dang dao da, vui long doi~p~ %d~w~ de dao xong.", timerdc[playerid]);
					}
					SendClientTextDraw(playerid, format_job);
					ApplyAnimation(playerid,"BASEBALL","Bat_4",1.0,1,1,1,1,1);
					if(timerdc[playerid] == TimerRandomPress[playerid])
					{
						MinerGetKeys(playerid);
					}
				}
				else
				{
					TogglePlayerControllable(playerid, 1);
					ApplyAnimation(playerid,"SWORD","sword_1",0.87,1,0,0,0,0);
					ClearAnimations(playerid);
					new format_job[1280];
					if(PlayerInfo[playerid][pMinerLevel] == 0)
					{
						switch(random(100))
						{
							case 0..60:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~y~1 Da~g~.");
								Inventory_Add(playerid, "Da", 1);
								SendLogToDiscordRoom("MINERAL LOG" ,"1157988317548265523", "Name", GetPlayerNameEx(playerid, false), "ADDED", "Đá", "Số lượng", "1", 0x226199);
							}
							case 84..94:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Sat~g~.");
								Inventory_Add(playerid, "Sat", 1);
								SendLogToDiscordRoom("MINERAL LOG" ,"1157988317548265523", "Name", GetPlayerNameEx(playerid, false), "ADDED", "Sắt", "Số lượng", "1", 0x226199);
							}
							case 61..83:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Dong~g~.");
								Inventory_Add(playerid, "Dong", 1);
								SendLogToDiscordRoom("MINERAL LOG" ,"1157988317548265523", "Name", GetPlayerNameEx(playerid, false), "ADDED", "Đồng", "Số lượng", "1", 0x226199);
							}
							case 95..100:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~r~1 VANG~g~.");
								Inventory_Add(playerid, "Vang", 1);
								SendLogToDiscordRoom("MINERAL LOG" ,"1157988317548265523", "Name", GetPlayerNameEx(playerid, false), "ADDED", "VÀNG", "Số lượng", "1", 0x226199);
							}
						}
					}
					else if(PlayerInfo[playerid][pMinerLevel] == 2)
					{
						switch(random(100))
						{
							case 0..50:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~y~1 Da~g~.");
								Inventory_Add(playerid, "Da", 1);
							}
							case 51..65:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Sat~g~.");
								Inventory_Add(playerid, "Sat", 1);
							}
							case 66..92:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Dong~g~.");
								Inventory_Add(playerid, "Dong", 1);
							}
							case 93..100:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~r~1 VANG~g~.");
								Inventory_Add(playerid, "Vang", 1);
							}
						}
					}
					else if(PlayerInfo[playerid][pMinerLevel] == 3)
					{
						switch(random(100))
						{
							case 0..40:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~y~1 Da~g~.");
								Inventory_Add(playerid, "Da", 1);
							}
							case 41..58:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Sat~g~.");
								Inventory_Add(playerid, "Sat", 1);
							}
							case 59..88:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Dong~g~.");
								Inventory_Add(playerid, "Dong", 1);
							}
							case 89..100:
							{
								format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~r~1 VANG~g~.");
								Inventory_Add(playerid, "Vang", 1);
							}
						}
					}
					StopLoopingAnim(playerid);
					RemovePlayerAttachedObject(playerid, 9);
					PlayerInfo[playerid][pSoLanMiner]++;
					
					if(PlayerInfo[playerid][pMinerLevel] == 0 && PlayerInfo[playerid][pSoLanMiner] == 500)
					{
						SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Chuc mung, ban da dat duoc Level 2 cua job miner.");
						SendClientMessage(playerid, COLOR_LIGHTRED, "Level cang cao thi ti le ra duoc dong, sat, vang cao hon binh thuong.");
						PlayerInfo[playerid][pMinerLevel] = 2;
					}
					else if(PlayerInfo[playerid][pMinerLevel] == 2 && PlayerInfo[playerid][pSoLanMiner] == 1000)
					{
						SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Chuc mung, ban da dat duoc Level 3 cua job miner.");
						SendClientMessage(playerid, COLOR_LIGHTRED, "Level cang cao thi ti le ra duoc dong, sat, vang cao hon binh thuong.");
						PlayerInfo[playerid][pMinerLevel] = 3;
					}
					SendClientTextDraw(playerid, format_job);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
					if(RockIDMiner[playerid] != -1)
					{
						SetTimerEx("OnRockRespawn", 600000, false, "i", RockIDMiner[playerid]);
					}
					CheckDoneMisson(playerid, 1);
					KillTimer(MinerTimer[playerid]);
					DeletePVar(playerid, "MinerWorking");
				}
			}
			else
			{
				if(--TimerPressKey[playerid] < 0)
				{
					
					FaildMiner(playerid);
				}
				ShowMessageKeyPressed(playerid);
			}
		}
	}
	return 1;
}

stock MinerGetKeys(playerid)
{
    new randomselect = random(3), string[128];
	KeyPressed[playerid] = false;
	TimerPressKey[playerid] = 7 + random(5);
	KeyPressesType[playerid] = randomselect;
	switch(randomselect)
	{
		case 0:
		{
			GetKeyMiner[playerid] = 65536;
		}
		case 1:
		{
		    GetKeyMiner[playerid] = 262144;
		}
		case 2:
		{
		    GetKeyMiner[playerid] = 131072;
		}
	}
	return 1;
}

stock ShowMessageKeyPressed(playerid)
{
	new str[128];
	switch(KeyPressesType[playerid])
	{
		case 0:
		{
			format(str, sizeof(str), "~w~Hay nhan phim ~p~ Y~w~ trong ~p~ %d~w~ giay.", TimerPressKey[playerid]);
		}
		case 1:
		{
		   format(str, sizeof(str), "~w~Hay nhan phim ~p~ H~w~ trong ~p~ %d~w~ giay.", TimerPressKey[playerid]);
		}
		case 2:
		{
		    format(str, sizeof(str), "~w~Hay nhan phim ~p~ N~w~ trong ~p~ %d~w~ giay.", TimerPressKey[playerid]);
		}
	}
	SetPVarInt(playerid, "TimeCountNotyHack", gettime());
	SendClientTextDraw(playerid, str);
	return 1;
}

forward OnRockRespawn(rockIndex);
public OnRockRespawn(rockIndex)
{
    if (RockStatus[rockIndex] == 0)
    {
        RockStatus[rockIndex] = 1;
        CreateRock(rockIndex);
    }
}
forward CreateRock(rockIndex);
public CreateRock(rockIndex)
{
	new randomrzx = random(360);
	new Float:randomrz = float(randomrzx);
	if(IsValidDynamic3DTextLabel(RockText[rockIndex]))
    {
        DestroyDynamic3DTextLabel(RockText[rockIndex]);
        RockText[rockIndex] = Text3D: INVALID_3DTEXT_ID;
    }
    if(IsValidDynamicObject(RockObj[rockIndex]))
    {
        DestroyDynamicObject(RockObj[rockIndex]);
        RockObj[rockIndex] = INVALID_OBJECT_ID;
    }
	RockText[rockIndex] = CreateDynamic3DTextLabel("<Rock>\n Bam phim 'Y' de bat dau dao da.", -1, rockPositions[rockIndex][0], rockPositions[rockIndex][1], rockPositions[rockIndex][2], 2.0);
    RockObj[rockIndex] = CreateDynamicObject(905, rockPositions[rockIndex][0], rockPositions[rockIndex][1], rockPositions[rockIndex][2]-0.8, 0.0, 0.0, randomrz, -1, -1, -1);
}