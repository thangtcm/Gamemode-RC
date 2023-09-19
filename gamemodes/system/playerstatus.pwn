#include <YSI_Coding\y_hooks>
new PlayerText: P_Progress[MAX_PLAYERS][12];
stock ShowProgressTD(playerid)
{
	for(new i = 0 ; i < 12; i++)
	{
		PlayerTextDrawShow(playerid, P_Progress[playerid][i]);
	}
	return 1;
}
stock UpdateProgressStat(playerid)
{
	new Float: Eatz = float(PlayerInfo[playerid][pEat]);
	new Float: Drinkz = float(PlayerInfo[playerid][pDrink]);
	new Float: Strongz = float(PlayerInfo[playerid][pStrong]);
	new Float: Eat = Eatz/100.0*-20.0;
	new Float: Drink = Drinkz/100.0*-20.0;
	new Float: Strong = Strongz/100.0*-20.0;
	new pstring[32];
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][1], 20.000, Eat);
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][4], 20.000, Drink);
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][7], 20.000, Strong);
	format(pstring, sizeof(pstring), "%0.1f", Strongz);
	PlayerTextDrawSetString(playerid, P_Progress[playerid][9], pstring);
	format(pstring, sizeof(pstring), "%0.1f", Drinkz);
	PlayerTextDrawSetString(playerid, P_Progress[playerid][10], pstring);
	format(pstring, sizeof(pstring), "%0.1f", Eatz);
	PlayerTextDrawSetString(playerid, P_Progress[playerid][11], pstring);
	ShowProgressTD(playerid);
	return 1;
}


stock Load_TDProgressPlayer(playerid)
{
	P_Progress[playerid][0] = CreatePlayerTextDraw(playerid, 285.500, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][0], 22.000, 23.500);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][0], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][0], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][0], 1);

	P_Progress[playerid][1] = CreatePlayerTextDraw(playerid, 286.500, 445.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][1], 20.000, -20.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][1], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][1], -8575233);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][1], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][1], 1);

	P_Progress[playerid][2] = CreatePlayerTextDraw(playerid, 292.000, 430.000, "HUD:radar_burgerShot");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][2], 9.000, 11.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][2], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][2], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][2], 1);

	P_Progress[playerid][3] = CreatePlayerTextDraw(playerid, 308.500, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][3], 22.000, 23.500);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][3], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][3], 255);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][3], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][3], 1);

	P_Progress[playerid][4] = CreatePlayerTextDraw(playerid, 309.500, 445.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][4], 20.000, -20.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][4], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][4], 2006895615);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][4], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][4], 1);

	P_Progress[playerid][5] = CreatePlayerTextDraw(playerid, 315.500, 430.000, "HUD:radar_dateDrink");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][5], 9.000, 11.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][5], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][5], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][5], 1);

	P_Progress[playerid][6] = CreatePlayerTextDraw(playerid, 331.500, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][6], 22.000, 23.500);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][6], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][6], 255);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][6], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][6], 1);

	P_Progress[playerid][7] = CreatePlayerTextDraw(playerid, 332.500, 445.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][7], 20.000, -20.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][7], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][7], 2011002879);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][7], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][7], 1);

	P_Progress[playerid][8] = CreatePlayerTextDraw(playerid, 338.000, 430.000, "HUD:radar_gym");
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][8], 9.000, 11.000);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][8], 1);
	PlayerTextDrawColor(playerid, P_Progress[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][8], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][8], 1);
	
	P_Progress[playerid][9] = CreatePlayerTextDraw(playerid, 342.500, 413.000, "100");
	PlayerTextDrawLetterSize(playerid, P_Progress[playerid][9], 0.200, 1.199);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][9], 2);
	PlayerTextDrawColor(playerid, P_Progress[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][9], 1);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][9], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][9], 1);

	P_Progress[playerid][10] = CreatePlayerTextDraw(playerid, 319.500, 413.000, "100");
	PlayerTextDrawLetterSize(playerid, P_Progress[playerid][10], 0.200, 1.199);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][10], 2);
	PlayerTextDrawColor(playerid, P_Progress[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][10], 1);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][10], 1);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][10], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][10], 1);

	P_Progress[playerid][11] = CreatePlayerTextDraw(playerid, 296.000, 413.000, "100");
	PlayerTextDrawLetterSize(playerid, P_Progress[playerid][11], 0.200, 1.199);
	PlayerTextDrawAlignment(playerid, P_Progress[playerid][11], 2);
	PlayerTextDrawColor(playerid, P_Progress[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, P_Progress[playerid][11], 1);
	PlayerTextDrawSetOutline(playerid, P_Progress[playerid][11], 1);
	PlayerTextDrawBackgroundColor(playerid, P_Progress[playerid][11], 255);
	PlayerTextDrawFont(playerid, P_Progress[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, P_Progress[playerid][11], 1);
}
hook OnPlayerUpdate(playerid)
{
	if(PlayerInfo[playerid][pEat] < 0)
	{
		PlayerInfo[playerid][pEat] = 0;
	}
	if(PlayerInfo[playerid][pDrink] < 0)
	{
		PlayerInfo[playerid][pDrink] = 0;
	}
	if(PlayerInfo[playerid][pStrong] < 0)
	{
		PlayerInfo[playerid][pStrong] = 0;
	}
	if(PlayerInfo[playerid][pEat] > 100)
	{
		PlayerInfo[playerid][pEat] = 100;
	}
	if(PlayerInfo[playerid][pDrink] > 100)
	{
		PlayerInfo[playerid][pDrink] = 100;
	}
	if(PlayerInfo[playerid][pStrong] > 100)
	{
		PlayerInfo[playerid][pStrong] = 100;
	}
	UpdateProgressStat(playerid);
	return 1;
}
hook OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pEat] = 50;
	PlayerInfo[playerid][pDrink] = 50;
	PlayerInfo[playerid][pStrong] = 25;
	Load_TDProgressPlayer(playerid);
	SetTimerEx("StartDownEatDrinkStrong", 60000, false, "i", playerid);
	return 1;
}
forward StartDownEatDrinkStrong(playerid);
public StartDownEatDrinkStrong(playerid)
{
	if(PlayerInfo[playerid][pAdmin] > 4) return 1;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || !IsPlayerRunning(playerid))
	{
		if(PlayerInfo[playerid][pEat] > 25)
		{
			PlayerInfo[playerid][pEat]--;
		}
		else if(PlayerInfo[playerid][pEat] >= 10)
		{
			PlayerInfo[playerid][pEat]--;
			if(GetPVarInt(playerid, #HPDown) == 0)
			{
				SetPVarInt(playerid, #HPDown, 1);
				SetTimerEx("DownHP", 100, false, "i", playerid);
			}
		}
		if(PlayerInfo[playerid][pDrink] > 25)
		{
			PlayerInfo[playerid][pDrink]--;
		}
		else if(PlayerInfo[playerid][pDrink] >= 10)
		{
			PlayerInfo[playerid][pDrink]--;
			if(GetPVarInt(playerid, #HPDown) == 0)
			{
				SetPVarInt(playerid, #HPDown, 1);
				SetTimerEx("DownHP", 100, false, "i", playerid);
			}
		}
	}
	else
	{
		if(PlayerInfo[playerid][pEat] > 25)
		{
			PlayerInfo[playerid][pEat]--;
			PlayerInfo[playerid][pEat]--;
		}
		else if(PlayerInfo[playerid][pEat] >= 10)
		{
			PlayerInfo[playerid][pEat]--;
			PlayerInfo[playerid][pEat]--;
			if(GetPVarInt(playerid, #HPDown) == 0)
			{
				SetPVarInt(playerid, #HPDown, 1);
				SetTimerEx("DownHP", 100, false, "i", playerid);
			}
		}
		if(PlayerInfo[playerid][pDrink] > 25)
		{
			PlayerInfo[playerid][pDrink]--;
			PlayerInfo[playerid][pDrink]--;
		}
		else if(PlayerInfo[playerid][pDrink] >= 10)
		{
			PlayerInfo[playerid][pDrink]--;
			PlayerInfo[playerid][pDrink]--;
			if(GetPVarInt(playerid, #HPDown) == 0)
			{
				SetPVarInt(playerid, #HPDown, 1);
				SetTimerEx("DownHP", 100, false, "i", playerid);
			}
		}
	}
	SetTimerEx("StartDownEatDrinkStrong", 60000, false, "i", playerid);
	SetTimerEx("DownStrong", 60000, false, "i", playerid);
	return 1;
}

forward DownStrong(playerid);
public DownStrong(playerid)
{
	if(PlayerInfo[playerid][pStrong] > 0)
	{
		PlayerInfo[playerid][pStrong]--;
	}
	else return SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] {ffffff}Ban da bi kiet suc, khong the di lam hay an uong gi do");
	return 1;
}
forward DownHP(playerid);
public DownHP(playerid)
{
	if(GetPVarInt(playerid, "Injured") == 0)
	{
		if(PlayerInfo[playerid][pEat] >= 10 && PlayerInfo[playerid][pEat] <= 25)
		{
			new Float: hpz;
			GetPlayerHealth(playerid, hpz);
			if(hpz > 5)
			{
				SetPlayerHealth(playerid, hpz-5);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] {ffffff}Hay an gi do, neu khong ban se chet.");
			}
			else
			{
				SetPlayerHealth(playerid, 0);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] {ffffff}Ban chet vi doi bung.");
			}
			SetTimerEx("DownHP", 120000, false, "i", playerid);
		}
		else if(PlayerInfo[playerid][pEat] > 25)
		{
			SetPVarInt(playerid, #HPDown, 0);
		}
		else if(PlayerInfo[playerid][pEat] >= 0 && PlayerInfo[playerid][pEat] < 10)
		{
			new Float: hpz;
			GetPlayerHealth(playerid, hpz);
			if(hpz > 10)
			{
				SetPlayerHealth(playerid, hpz-10);
				SendClientMessage(playerid, COLOR_REALRED, "[SERVER] {ffffff}Hay an gi do, neu khong ban se chet.");
			}
			else
			{
				SetPlayerHealth(playerid, 0);
				SendClientMessage(playerid, COLOR_REALRED, "[SERVER] {ffffff}Ban da chet vi doi bung.");
			}
			SetTimerEx("DownHP", 120000, false, "i", playerid);
		}
		if(PlayerInfo[playerid][pDrink] >= 10 && PlayerInfo[playerid][pDrink] <= 25)
		{
			new Float: hpz;
			GetPlayerHealth(playerid, hpz);
			if(hpz > 5)
			{
				SetPlayerHealth(playerid, hpz-5);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] {ffffff}Hay uong gi do, neu khong ban se chet.");
			}
			else
			{
				SetPlayerHealth(playerid, 0);
				SendClientMessage(playerid, COLOR_LIGHTRED, "[SERVER] {ffffff}Ban da chet vi khat nuoc.");
			}
			SetTimerEx("DownHP", 120000, false, "i", playerid);
		}
		else if(PlayerInfo[playerid][pDrink] > 25)
		{
			SetPVarInt(playerid, #HPDown, 0);
		}
		else if(PlayerInfo[playerid][pDrink] >= 0 && PlayerInfo[playerid][pDrink] < 10)
		{
			new Float: hpz;
			GetPlayerHealth(playerid, hpz);
			if(hpz > 10)
			{
				SetPlayerHealth(playerid, hpz-10);
				SendClientMessage(playerid, COLOR_REALRED, "[SERVER] {ffffff}Hay uong gi do, neu khong ban se chet.");
			}
			else
			{
				SetPlayerHealth(playerid, 0);
				SendClientMessage(playerid, COLOR_REALRED, "[SERVER] {ffffff}Ban da chet vi khat nuoc.");
			}
			SetTimerEx("DownHP", 120000, false, "i", playerid);
		}
	}
	return 1;
}
