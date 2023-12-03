
CMD:handcuff1(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(!FixLoi(playerid))return 1;
		if(PlayerInfo[playerid][pHasCuff] < 1)
		{
		    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong co chiec cong tay nao.");
		    return 1;
		}

		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /handcuff1 [playerid]");
		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(giveplayerid == playerid) return 1;
				if(HandCuff[giveplayerid] == 2) return SendClientTextDraw(playerid, "Nguoi choi nay da bi cong tay");
				if(IsPlayerInAnyVehicle(giveplayerid) == 1) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong the cong khi nguoi choi dang o tren xe.");
				new Float:HP;
				GetPlayerHealth(playerid, HP);
				if(HP >= 1)
				{
					format(string, sizeof(string), "[CONG TAY] {FFFFFF}Ban da cong tay %s, hay su dung '{FF6347}/unhandcuff{FFFFFF}' de thao cong.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* %s da keo hai tay %s ve sau siet chat va cong lai.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));	
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 10.0, 4000);
					GameTextForPlayer(giveplayerid, "~r~Hand Cuff", 2500, 3);
					ClearAnimations(giveplayerid);
					DangBiTazer[giveplayerid] = 0;
					SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
                    SetPlayerAttachedObject(giveplayerid, 7, 19418, 6, -0.011, 0.028, -0.022, -15.600012, -33.699977, -81.700035, 1.0, 1.0, 1.0);
					HandCuff[giveplayerid] = 2;
					DeletePVar(giveplayerid, "IsFrozen");
					TogglePlayerControllable(giveplayerid, 1);
				}
			}
			else return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong dung gan nguoi choi.");
		}
	}
	return 1;
}

CMD:keoday(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(!FixLoi(playerid))return 1;

		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /keoday [playerid]");
		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(giveplayerid == playerid) return 1;
				if(IsPlayerInAnyVehicle(giveplayerid) == 1) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong the keo day khi nguoi choi dang o tren xe.");
				new Float:HP;
				GetPlayerHealth(playerid, HP);
				if(HP >= 1)
				{
					ClearAnimations(giveplayerid);
					DeletePVar(giveplayerid, "IsFrozen");
					TogglePlayerControllable(giveplayerid, 1);
				}
			}
			else return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong dung gan nguoi choi.");
		}
	}
	return 1;
}

CMD:handcuff2(playerid, params[])
{
	if(IsACop(playerid))
	{
		if(!FixLoi(playerid))return 1;
		if(PlayerInfo[playerid][pHasCuff] < 1)
		{
		    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong co chiec cong tay nao.");
		    return 1;
		}

		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /handcuff2 [Player]");
		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(giveplayerid == playerid) return 1;
				if(HandCuff[giveplayerid] == 2) return SendClientTextDraw(playerid, "Nguoi choi nay da bi cong tay");
				if(IsPlayerInAnyVehicle(giveplayerid) == 1) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong the cong khi nguoi choi dang o tren xe.");
				new Float:HP;
				GetPlayerHealth(playerid, HP);
				if(HP >= 1)
				{
					format(string, sizeof(string), "[CONG TAY] {FFFFFF}Ban da cong tay %s, hay su dung '{FF6347}/unhandcuff{FFFFFF}' de thao cong.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTRED, string);
					
					format(string, sizeof(string), "* %s da keo hai tay %s ve sau siet chat va cong lai.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
					//ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 10.0, 4000);
					GameTextForPlayer(giveplayerid, "~r~Hand Cuff", 2500, 3);
					ClearAnimations(giveplayerid);
					DangBiTazer[giveplayerid] = 0;
					SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);
                    SetPlayerAttachedObject(giveplayerid, 7, 19418, 6, -0.011, 0.028, -0.022, -15.600012, -33.699977, -81.700035, 1.0, 1.0, 1.0);
					HandCuff[giveplayerid] = 2;
					DeletePVar(giveplayerid, "IsFrozen");
					ApplyAnimationEx(giveplayerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
				//TogglePlayerControllable(giveplayerid, 1);
				}
			}
			else return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong dung gan nguoi choi.");
		}
	}
	return 1;
}

CMD:unhandcuff(playerid, params[])
{
	if(IsACop(playerid))
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /unhandcuff [Player]");

		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(8.0, playerid, giveplayerid))
			{
				/*if(PlayerInfo[giveplayerid][pJailTime] >= 1) da mo khoa va thao cong tay cho
				{
					SendClientMessageEx(playerid, COLOR_WHITE, "You can't uncuff a jailed player.");
					return 1;
				} */
				if(giveplayerid == playerid) return 1;
				if(IsPlayerInAnyVehicle(giveplayerid) == 1) return SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong the thao cong khi nguoi choi dang o tren xe.");
				if(HandCuff[giveplayerid]>1)
				{
					format(string, sizeof(string), "[THAO CONG] {FFFFFF} Ban da duoc thao cong tay boi Officer %s.", GetPlayerNameEx(playerid));
					SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "[THAO CONG] {FFFFFF} Ban da thao cong tay doi tuong %s.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "{FF8000}*{C2A2DA} %s da mo khoa va thao cong tay cho %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
					ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					GameTextForPlayer(giveplayerid, "~g~Thao cong", 2500, 3);
					RemovePlayerAttachedObject(giveplayerid, 7);
					SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
					ClearAnimations(giveplayerid);
					HandCuff[giveplayerid] = 0;
				}
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong dung gan nguoi choi.");
				return 1;
			}
		}
	}
	return 1;
}
stock FixLoi(playerid)
{
    if(HandCuff[playerid] != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 )
	{
   		//SendClientMessage(playerid, COLOR_GRAD2, " Ban khong the lam vao thoi diem nay.");
   		return 0;
	}
	return 1;
}