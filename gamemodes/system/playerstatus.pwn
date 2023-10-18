#include <YSI_Coding\y_hooks>
#define Hungry_TypeEat		(1)
#define Hungry_TypeStrong	(2)
#define Hungry_TypeDrink	(3)

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
	new Float: Eatz = float(PlayerInfo[playerid][pEat]),
		Float: Drinkz = float(PlayerInfo[playerid][pDrink]);
	if(Eatz >= 2 && Drinkz >= 2)
	{
		new calEat = floatround(Eatz/2, floatround_floor),
			calDrink = floatround(Drinkz/2, floatround_floor);
		new minHungry = (calEat < calDrink ? (calEat) : calDrink);
		PlayerInfo[playerid][pStrong] = minHungry;
	}
	new Float: Strongz = float(PlayerInfo[playerid][pStrong]);
	new Float: MainHungry = (-20.0 / 100.0);
	new pstring[32];
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][1], 20.000, MainHungry * Eatz);
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][4], 20.000, MainHungry * Drinkz);
	PlayerTextDrawTextSize(playerid, P_Progress[playerid][7], 20.000, MainHungry * Strongz);
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

hook OnPlayerConnect(playerid)
{
	Load_TDProgressPlayer(playerid);
	return 1;
}
forward StartDownEatDrinkStrong(playerid);
public StartDownEatDrinkStrong(playerid)
{
	if(GetPVarInt(playerid, "Injured") == 1 || PlayerCuffed[ playerid ] >= 1 || PlayerInfo[ playerid ][ pJailTime ] > 0 || PlayerInfo[playerid][pHospital] > 0 || !IsPlayerConnected(playerid))
		return 1;
	UpdatePlayerHungry(playerid);
	return 1;
}

task NotifiHunger[600000]()
{
	foreach(new i : Player)
	{
		if(GetPVarInt(i, "Injured") == 0 && PlayerCuffed[ i ] == 0 && PlayerInfo[ i ][ pJailTime ] == 0 && PlayerInfo[i][pHospital] == 0 && IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pDrink] <= 25 && PlayerInfo[i][pEat] <= 25)
			{
				SendClientMessage(i, COLOR_REALRED, "[SERVER] {ffffff}Hay an uong gi do, neu khong ban se chet.");
			}
			else if(PlayerInfo[i][pDrink] <= 25)
			{
				SendClientMessage(i, COLOR_REALRED, "[SERVER] {ffffff}Hay uong gi do, neu khong ban se chet.");
			}
			else if(PlayerInfo[i][pEat] <= 25)
			{
				SendClientMessage(i, COLOR_REALRED, "[SERVER] {ffffff}Hay an gi do, neu khong ban se chet.");
			}
		}
	}
}

task HungerDownHP[300000]()
{
	foreach(new i : Player)
	{
		if(GetPVarInt(i, "Injured") == 0 && PlayerCuffed[ i ] == 0 && PlayerInfo[ i ][ pJailTime ] == 0 && PlayerInfo[i][pHospital] == 0 && IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pDrink] <= 25 || PlayerInfo[i][pEat] <= 25)
			{
				new Float: hpz;
				GetPlayerHealth(i, hpz);
				if(hpz > 5){
					SetPlayerHealth(i, hpz-5);
				}else{
					SetPlayerHealth(i, 0);
					SendClientMessage(i, COLOR_REALRED, "[SERVER] {ffffff}Ban da chet vi doi bung.");
				}
			}
		}
		
	}
}

stock UpdatePlayerHungry(playerid)
{
	if(PlayerInfo[playerid][pEat] <= 25 || PlayerInfo[playerid][pDrink] <= 25)
	{
		if(--PlayerInfo[playerid][pEat] <= 0) PlayerInfo[playerid][pEat] = 0;
		if(--PlayerInfo[playerid][pDrink] <= 0) PlayerInfo[playerid][pDrink]=0;
	}
	else
	{
		--PlayerInfo[playerid][pEat];
		--PlayerInfo[playerid][pDrink];
	}
	return 1;
}