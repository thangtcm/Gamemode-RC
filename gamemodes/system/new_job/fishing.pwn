#include <YSI_Coding\y_hooks>


new F_RandomPrice;
new NPC_Fish;
new F_timerdc[MAX_PLAYERS];
new F_CountPress[MAX_PLAYERS];
new F_KeyPressed[MAX_PLAYERS];
new F_TimerPressKey[MAX_PLAYERS];
new F_KeyPressesType[MAX_PLAYERS];
new GetKeyFish[MAX_PLAYERS];
new FishTimer[MAX_PLAYERS];
new F_TimerRandomPress[MAX_PLAYERS];
new F_DownCountJobTime[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	F_CountPress[playerid] = 0;
	F_TimerPressKey[playerid] = 0;
	F_KeyPressed[playerid] = true;
	KillTimer(FishTimer[playerid]);
	DeletePVar(playerid, "FishWorking");
	return 1;
}

hook OnGameModeInit()
{
    NPC_Fish = CreateActor(1, 1136.7452,-1450.6530,15.7969,90.0503);
    CreateDynamic3DTextLabel("< THU MUA CA >\n(( Su dung [/sellfish] de tuong tac ))", -1, 1136.7452,-1450.6530,15.7969,10);           
    SetTimer("F_ResetPrice", 20000, false);
}
Dialog:BANCA(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
		{
			return Dialog_Show(playerid, BANCA, DIALOG_STYLE_INPUT, "Ban ca", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(strval(inputtext) < 1)
		{
			return Dialog_Show(playerid, BANCA, DIALOG_STYLE_INPUT, "Ban ca", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(Inventory_Count(playerid, "Ca") < strval(inputtext))
		{
			return Dialog_Show(playerid, BANCA, DIALOG_STYLE_INPUT, "Ban ca", "{8f0a03}Ban da nhap nhieu hon so CA ma ban co trong tui do !", "Ban", "Huy");
		}
		else
		{
			new format_job[1280], moneyselled = F_RandomPrice*strval(inputtext);
			format(format_job, sizeof(format_job), "[SERVER] {ffffff}Ban da ban {6e69ff}%d {a8a7a7}CA' {ffffff}thanh cong va nhan duoc %d$.", strval(inputtext), moneyselled);
			PlayerInfo[playerid][pCash] += moneyselled;
			SendClientMessage(playerid, COLOR_LIGHTRED, format_job);
			new pItemId = Inventory_GetItemID(playerid, "Ca", strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
        	new moneyzxc[30];
        	format(moneyzxc, 30, "%d$", moneyselled);
			SendLogToDiscordRoom4("RC:RP LOG - BÁN CÁ", "1157988261382328392", "Name", GetPlayerNameEx(playerid, false), "Đã bán", "Đá", "Số lượng", inputtext, "TỔNG TIỀN", moneyzxc, 0x229926);
		}
	}
	return 1;
}

CMD:sellfish(playerid, params[])
{
    new Float:PosXACtor, Float:PosYACtor, Float:PosZACtor;
	GetActorPos(NPC_Fish, PosXACtor, PosYACtor, PosZACtor);
	if(IsPlayerInRangeOfPoint(playerid, 5.0, PosXACtor, PosYACtor, PosZACtor))
	{
	    new str[158];
	    format(str, sizeof(str), "GIA: {FFBE00}1KG/%d{FFFFFF}\nHay nhap so luong muon ban:", F_RandomPrice);
	    Dialog_Show(playerid, BANCA, DIALOG_STYLE_INPUT, "Ban ca", str, "Ban", "Huy");
	}
	return 1;
}

CMD:cauca(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 403.8664, -2088.7915, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 398.6363, -2088.7952, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 395.9465, -2088.7981, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 390.9263, -2088.7979, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 383.4541, -2088.6594, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 374.7811, -2088.7969, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 369.7698, -2088.6250, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 366.8293, -2088.7974, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 361.9101, -2088.7981, 7.8359) || IsPlayerInRangeOfPoint(playerid, 3.0, 354.6985, -2088.7607, 7.8359))
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
		if(Inventory_Count(playerid, "Ca") >= 100) return SendErrorMessage(playerid, " Hay di ban KG ca tren nguoi, moi co the cau tiep.");
		if(Inventory_Count(playerid, "Can cau") >= 1)
		{
		    if(Inventory_Count(playerid, "Moi cau") >= 1)
	    	{
				if(F_timerdc[playerid] == 0)
				{
				    cmd_me(playerid,"dang cau ca.");
					StartFishing(playerid);
					ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,0,1,1);
					TogglePlayerControllable(playerid, 0);					
				    SetPlayerAttachedObject(playerid, 0, 18632, 1, -0.194, 0.354999, 0.018, 96.1001, -45.6, -177.4, 1.000000, 1.000000, 1.000000, 0xFF0000AA);
				}
				else return SendErrorMessage(playerid, " Ban dang cau ca roi.");
			}
			else return SendErrorMessage(playerid, " Ban khong co moi cau.");
		}
		else return SendErrorMessage(playerid, " Ban chua mua can cau ca.");
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 0) return 1;
	if(!F_KeyPressed[playerid])
	{
		if((PRESSED(GetKeyFish[playerid])) && !F_KeyPressed[playerid])
		{
			F_KeyPressed[playerid] = true;
			F_TimerPressKey[playerid] = 0;
			SendServerMessage(playerid, "Ban thao tac qua tot.");
			new F_GetTimeNow = gettime();
			if(F_GetTimeNow - GetPVarInt(playerid, "F_TimeCountNotyHack") <= 1 && GetPVarInt(playerid, "F_TimeCountNotyHack") < F_GetTimeNow)
			{
				F_CountPress[playerid] ++;
				new string[128];
				format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID: %d) Da thuc hien nhan phim capcha voi toc do ban tho %d lan.", GetPlayerNameEx(playerid), playerid, CountPress[playerid]);
				ABroadCast(COLOR_YELLOW, string, 2);
				format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID: %d) co the dang su dung cleo auto farm nhan phim capcha trong %d giay.", GetPlayerNameEx(playerid), playerid, F_GetTimeNow - GetPVarInt(playerid, "F_TimeCountNotyHack"));
				ABroadCast(COLOR_YELLOW, string, 2);
			}
			else
			{
				F_CountPress[playerid] = 0;
			}
		}
		else
		{
			FaildFish(playerid);
		}
	}
	return 1;
}

stock FaildFish(playerid)
{
	SendErrorMessage(playerid, "Ban da cau ca that bai.");
	KillTimer(FishTimer[playerid]);
	F_KeyPressed[playerid] = true;
	StopLoopingAnim(playerid);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	RemovePlayerAttachedObject(playerid, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	F_timerdc[playerid] = 0;
	F_TimerPressKey[playerid] = 0;
	DeletePVar(playerid, "FishWorking");
	return 1;
}



hook OnPlayerDisconnect(playerid, reason)
{
	FaildFish(playerid);
	return 1;
}

forward F_ResetPrice();
public F_ResetPrice()
{
    F_RandomPrice = 5 + random(10);
	
	SetTimer("F_ResetPrice", 3600000, false);
	SendClientMessageToAll(COLOR_REALRED, "[THU MUA CA'] {ffffff}Gia ca thi truong ban' ca' thay doi, hay den nguoi thu mua tai Market de xem gia ca.");
    return 1;
}

forward StartFishing(playerid);
public StartFishing(playerid)
{
		F_timerdc[playerid] = 30+(random(10));
		if(F_DownCountJobTime[playerid] >= gettime()) {
			F_timerdc[playerid] -= 10;
		}
		F_TimerRandomPress[playerid] = random(F_timerdc[playerid]-10);
		F_KeyPressed[playerid] = true;
		SetPVarInt(playerid, "FishWorking", 1);
		ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,0,1,1);
		FishTimer[playerid] = SetTimerEx("F_StartCountTime", 1000, true, "i", playerid);
}
forward F_StartCountTime(playerid);
public F_StartCountTime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "FishWorking") != 0)
		{
			if(F_TimerPressKey[playerid] <= 0 && F_KeyPressed[playerid])
			{
				if(F_timerdc[playerid] > 0)
				{
					
					F_timerdc[playerid]--;
					new format_job[1280];
					if(F_DownCountJobTime[playerid] >= gettime()) {
						format(format_job, sizeof(format_job), "Vui long doi~p~ %d~w~. (10 GIAY)", F_timerdc[playerid]);
					}
					else {
						format(format_job, sizeof(format_job), "Vui long doi~p~ %d~w~.", F_timerdc[playerid]);
					}
					SendClientTextDraw(playerid, format_job);
					if(F_timerdc[playerid] == F_TimerRandomPress[playerid])
					{
						FishGetKeys(playerid);
					}
				}
				else
				{
				    new string[158], format_job[555];
					ClearAnimations(playerid);				
					JobSkill[playerid][Fish] += 1;
					StopLoopingAnim(playerid);
					RemovePlayerAttachedObject(playerid, 0);
					KillTimer(FishTimer[playerid]);
					TogglePlayerControllable(playerid, 1);				
					DeletePVar(playerid, "FishWorking");
					if(JobSkill[playerid][Fish] < 250)
					{   
					    new rdd = random(100);
					    switch(rdd)
					    {
							case 0..5:
							{
								format(format_job, sizeof(format_job), "~y~ OH MY GOD~n~ Ban da rat may man khi dao duoc ~r~1x Santa Hat~y~.");					
								SendClientMessage(playerid,COLOR_WHITE, string);			
								SendLogToDiscordRoom("SANTA HAT" ,"1180540668632899688", "Name", GetPlayerNameEx(playerid, false), "JOB", "Mineral", "Số lượng", "1 SANTA HAT", 0xFF4747);							
								Inventory_Add(playerid, "Santa Hat", 1);	
							}
							case 6..100:
							{
								new rd = 5 + random(5);
								format(string, sizeof(string), "Ban da cau thanh cong {FF8E00}%d KG {FFFFFF} ca.", rd);
								SendClientMessage(playerid,COLOR_WHITE, string);
								Inventory_Add(playerid, "Ca", rd);
	   			          	}
					    }				    							    
			            new pItemId = Inventory_GetItemID(playerid, "Moi cau", 1);
		            	Inventory_Remove(playerid, pItemId, 1);
					}
					else if(JobSkill[playerid][Fish] >= 250)
					{
					    new rdd = random(100);
					    switch(rdd)
					    {
							case 0..5:
							{
					            format(format_job, sizeof(format_job), "~y~ OH MY GOD~n~ Ban da rat may man khi dao duoc ~r~1x Santa Hat~y~.");					
		                        SendClientMessage(playerid,COLOR_WHITE, string);			
		                        SendLogToDiscordRoom("SANTA HAT" ,"1180540668632899688", "Name", GetPlayerNameEx(playerid, false), "JOB", "Mineral", "Số lượng", "1 SANTA HAT", 0xFF4747);							
		                    	Inventory_Add(playerid, "Santa Hat", 1);	
							}
							case 6..100:
							{
					            new rd = 10 + random(8);
							    format(string, sizeof(string), "Ban da cau thanh cong {FF8E00}%d KG {FFFFFF} ca.", rd);
							    SendClientMessage(playerid,COLOR_WHITE, string);
						 	   	Inventory_Add(playerid, "Ca", rd);
	   			          	}
					    }				    					
				        new pItemId = Inventory_GetItemID(playerid, "Moi cau", 1);
		            	Inventory_Remove(playerid, pItemId, 1);
					}
				}
			}
			else
			{
				if(--F_TimerPressKey[playerid] < 0)
				{
					
					FaildFish(playerid);
				}
				F_ShowMessageKeyPressed(playerid);
			}
		}
	}
	return 1;
}

stock FishGetKeys(playerid)
{
    new randomselect = random(3);
	F_KeyPressed[playerid] = false;
	F_TimerPressKey[playerid] = 5 + random(5);
	F_KeyPressesType[playerid] = randomselect;
	switch(randomselect)
	{
		case 0:
		{
			GetKeyFish[playerid] = 65536;
		}
		case 1:
		{
		    GetKeyFish[playerid] = 262144;
		}
		case 2:
		{
		    GetKeyFish[playerid] = 131072;
		}
	}
	return 1;
}

stock F_ShowMessageKeyPressed(playerid)
{
	new str[128];
	switch(F_KeyPressesType[playerid])
	{
		case 0:
		{
			format(str, sizeof(str), "~w~(CAPTCHA) Hay nhan phim ~p~ Y~w~ trong ~p~ %d~w~ giay.", F_TimerPressKey[playerid]);
		}
		case 1:
		{
		   format(str, sizeof(str), "~w~(CAPTCHA) Hay nhan phim ~p~ H~w~ trong ~p~ %d~w~ giay.", F_TimerPressKey[playerid]);
		}
		case 2:
		{
		    format(str, sizeof(str), "~w~(CAPTCHA) Hay nhan phim ~p~ N~w~ trong ~p~ %d~w~ giay.", F_TimerPressKey[playerid]);
		}
	}
	SetPVarInt(playerid, "F_TimeCountNotyHack", gettime());
	SendClientTextDraw(playerid, str);
	return 1;
}
