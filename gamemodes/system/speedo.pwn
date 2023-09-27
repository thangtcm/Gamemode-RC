#include <a_samp>
#include <YSI_Coding\y_hooks>

new PlayerText:SpeedoTD[MAX_PLAYERS][8];


hook OnPlayerConnect(playerid) {
	LoadTSD(playerid);
}
hook OnPlayerUpdate(playerid) {
    if(IsPlayerInAnyVehicle(playerid)) {
    	show_update_speedo(playerid);
    }
}
stock show_update_speedo(playerid) {
	if(GetPVarInt(playerid,"Tog_speedo") == 1) return 1;
	new speedonumber[50],Float:fDamage;
    new vehicleid = GetPlayerVehicleID(playerid);
	switch(GetVehicleSpeed(GetPlayerVehicleID(playerid)))
    {
    	case 0..9: speedonumber ="mdl-2018:Speedo-0";
    	case 10..19: speedonumber ="mdl-2018:Speedo-10";
    	case 20..29:  speedonumber ="mdl-2018:Speedo-20";
    	case 30..39:  speedonumber ="mdl-2018:Speedo-30";
    	case 40..49:  speedonumber ="mdl-2018:Speedo-40";
    	case 50..59:  speedonumber ="mdl-2018:Speedo-50";
    	case 60..69:  speedonumber ="mdl-2018:Speedo-60";
    	case 70..79:  speedonumber ="mdl-2018:Speedo-70";
    	case 80..89:  speedonumber ="mdl-2018:Speedo-80";
    	case 90..1000:  speedonumber ="mdl-2018:Speedo-90";
    }

    PlayerTextDrawSetString(playerid, SpeedoTD[playerid][0] , speedonumber);

    switch(floatround(VehicleFuel[vehicleid]))
    {
    	case 0..11: speedonumber ="mdl-2018:fuel-0";
    	case 12..24: speedonumber ="mdl-2018:fuel-12";
    	case 25..36:  speedonumber ="mdl-2018:fuel-25";
    	case 37..49:  speedonumber ="mdl-2018:fuel-37";
    	case 50..64:  speedonumber ="mdl-2018:fuel-50";
    	case 65..74:  speedonumber ="mdl-2018:fuel-65";
    	case 75..86:  speedonumber ="mdl-2018:fuel-75";
    	case 87..99:  speedonumber ="mdl-2018:fuel-87";
    	case 100..1000:  speedonumber ="mdl-2018:fuel-100";
    }
    PlayerTextDrawSetString(playerid,SpeedoTD[playerid][1] , speedonumber);

    format(speedonumber, sizeof speedonumber, "%d MPH", GetVehicleSpeed(GetPlayerVehicleID(playerid)));
    PlayerTextDrawSetString(playerid,SpeedoTD[playerid][3] , speedonumber);
    PlayerTextDrawShow(playerid, SpeedoTD[playerid][0]);
    PlayerTextDrawShow(playerid, SpeedoTD[playerid][1]); 
    PlayerTextDrawShow(playerid, SpeedoTD[playerid][2]); 
    PlayerTextDrawShow(playerid, SpeedoTD[playerid][3]);
    PlayerTextDrawShow(playerid, SpeedoTD[playerid][4]);

    GetVehicleHealth(vehicleid, fDamage);
    new
		vParamArr[7];

	GetVehicleParamsEx(vehicleid, vParamArr[0], vParamArr[1], vParamArr[2], vParamArr[3], vParamArr[4], vParamArr[5], vParamArr[6]);

    if(vParamArr[3] != VEHICLE_PARAMS_ON)
	{
		PlayerTextDrawHide(playerid,SpeedoTD[playerid][6]);
	}
	else {
		PlayerTextDrawShow(playerid,SpeedoTD[playerid][6]);
	}
    if(fDamage < 450) {
    	PlayerTextDrawShow(playerid,SpeedoTD[playerid][7]);
    }
    else {
        PlayerTextDrawHide(playerid,SpeedoTD[playerid][7]);
    }
    if(vParamArr[1] != VEHICLE_PARAMS_ON)
	{
		PlayerTextDrawHide(playerid,SpeedoTD[playerid][5]);
	}
	else {
		PlayerTextDrawShow(playerid,SpeedoTD[playerid][5]);
	}
    return 1;
}


//Player TextDraws: 

stock LoadTSD(playerid) {
SpeedoTD[playerid][0] = CreatePlayerTextDraw(playerid, 530.138366, 354.516876, "mdl-2018:speedo-0");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][0], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][0], 72.000000, 83.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][0], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][0], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][0], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][0], 0);

SpeedoTD[playerid][1] = CreatePlayerTextDraw(playerid, 585.700317, 365.166900, "mdl-2018:fuel-0");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][1], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][1], 58.000000, 65.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][1], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][1], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][1], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][1], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][1], 0);

SpeedoTD[playerid][2] = CreatePlayerTextDraw(playerid, 584.263305, 324.883483, "mdl-2018:Mileage");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][2], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][2], 48.000000, 55.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][2], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][2], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][2], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][2], 0);

SpeedoTD[playerid][3] = CreatePlayerTextDraw(playerid, 567.345031, 409.066589, "320_MPH");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][3], 0.182606, 1.308333);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][3], 2);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][3], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][3], 1);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][3], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][3], 1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][3], 0);

SpeedoTD[playerid][4] = CreatePlayerTextDraw(playerid, 608.012634, 348.966278, "500");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][4], 0.169487, 1.267500);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][4], 2);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][4], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][4], 1);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][4], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][4], 1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][4], 0);

SpeedoTD[playerid][5] = CreatePlayerTextDraw(playerid, 572.818542, 355.083374, "mdl-2018:Lights");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][5], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][5], 12.000000, 17.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][5], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][5], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][5], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][5], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][5], 0);

SpeedoTD[playerid][6] = CreatePlayerTextDraw(playerid, 557.226135, 356.283447, "mdl-2018:Locks-Locked");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][6], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][6], 13.000000, 13.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][6], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][6], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][6], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][6], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][6], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][6], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][6], 0);

SpeedoTD[playerid][7] = CreatePlayerTextDraw(playerid, 542.629699, 355.683410, "mdl-2018:Engine-Broken");
PlayerTextDrawLetterSize(playerid, SpeedoTD[playerid][7], 0.000000, 0.000000);
PlayerTextDrawTextSize(playerid, SpeedoTD[playerid][7], 13.000000, 15.000000);
PlayerTextDrawAlignment(playerid, SpeedoTD[playerid][7], 1);
PlayerTextDrawColor(playerid, SpeedoTD[playerid][7], -1);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][7], 0);
PlayerTextDrawSetOutline(playerid, SpeedoTD[playerid][7], 0);
PlayerTextDrawBackgroundColor(playerid, SpeedoTD[playerid][7], 255);
PlayerTextDrawFont(playerid, SpeedoTD[playerid][7], 4);
PlayerTextDrawSetProportional(playerid, SpeedoTD[playerid][7], 0);
PlayerTextDrawSetShadow(playerid, SpeedoTD[playerid][7], 0);


}