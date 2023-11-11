/*
    Project Name: Hata Anti-Cheat (H-AC)
	Project Version: v0.0.2
    Project Developer: Hata
*/

//ANTI SILENT AIMBOT: 0
//ANTI VEHICLE REPAIR HACK: 1
//ANTI SCREEN FLICKERING: 2
//ANTI CAR TROLLER: 3
//ANTI SURFING INVISIBLE: 4
//ANTI AIRBREAK: 5
//ANTI SEAT ID CRASHER: 6
//ANTI SPEED HACK (On Foot/Driver): 7
//ANTI TROLL ANIMATION: 8
//ANTI ANIMATION INVISIBLE: 9
//ANTI FLY HACK (On Foot): 10
//ANTI RAGE SHOT: 11
//ANTI TRAILER CRASHER: 12
//ANTI WEAPON HACK: 13
//ANTI KILL ALL HACK: 14
//ANTI CHECKPOINT TELEPORT HACK: 15
//ANTI QUICK TURN HACK: 16
//ANTI NPC LOGIN: 17
//ANTI FAKE STATE: 18
//ANTI GAME SPEED: 19

#include <a_samp>

forward OnPlayerCheatDetected(playerid, code);
forward OnPlayerChangedToTrailer(playerid, vehicleid, trailerid);

new OldSpeed[MAX_PLAYERS],
Float:LastPos[MAX_PLAYERS][3],
OldTrailer[MAX_PLAYERS],
Float:OldA[MAX_PLAYERS],
Float:airPosX[MAX_PLAYERS],
Float:airPosY[MAX_PLAYERS],
Float:airPosZ[MAX_PLAYERS],
AirWarns[MAX_PLAYERS],
SilentWarning[MAX_PLAYERS],
SilentTimer[MAX_PLAYERS],
IsPlayerAFK[MAX_PLAYERS],
ShotTick[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "LegalCheat", 1);
	AirWarns[playerid] = 0;
	SetPVarInt(playerid, "CarID", -1);
	if (IsPlayerNPC(playerid))
	{
	    CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 17);
	}
	#if defined HAC_OnPlayerConnect
	    return HAC_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

public OnPlayerSpawn(playerid)
{
	SetTimerEx("AntiCheatControl", 200, true, "i", playerid);
	SetPVarInt(playerid, "CarID", -1);
	SetPVarInt(playerid, "LegalCheat", 1);
	SetTimerEx("ResetLegalCheat", 2000, false, "i", playerid);
	SetTimerEx("AFKControl", 200, true, "i", playerid);
	SetTimerEx("GameSpeedControl", 100, true, "i", playerid);
	
	#if defined HAC_OnPlayerSpawn
	    return HAC_OnPlayerSpawn(playerid);
	#else
		return 1;
	#endif
}

forward GameSpeedControl(playerid);
public GameSpeedControl(playerid)
{
	SetPVarInt(playerid, "GameSpeed", PlayerSpeed(playerid));
	return 1;
}

forward AntiCheatControl(playerid);
public AntiCheatControl(playerid)
{
	OldSpeed[playerid] = PlayerSpeed(playerid);
	GetPlayerPos(playerid, LastPos[playerid][0], LastPos[playerid][1], LastPos[playerid][2]);
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
	{
	    OldTrailer[playerid] = GetVehicleTrailer(GetPlayerVehicleID(playerid));
	}
	else
	{
		OldTrailer[playerid] = -1;
	}
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), OldA[playerid]);
	}
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	if (weaponid == 4 && amount >= 50 || weaponid == 4 && amount == 0)
	{
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 14);
	}
	#if defined HAC_OnPlayerTakeDamage
	    return HAC_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid);
	#else
		return 1;
	#endif
}
public OnPlayerChangedToTrailer(playerid, vehicleid, trailerid)
{
    if (OldTrailer[playerid] != -1 && OldTrailer[playerid] != trailerid)
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 12);
    }
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    SetPVarInt(playerid, "LegalCheat", 1);
    SetTimerEx("ResetLegalCheat", 500, false, "i", playerid);
    #if defined HAC_OnVehicleDamageStatusUpdate
	    return HAC_OnVehicleDamageStatusUpdate(vehicleid, playerid);
	#else
		return 1;
	#endif
}

forward ResetLegalCheat(playerid);
public ResetLegalCheat(playerid)
{
    SetPVarInt(playerid, "LegalCheat", 0);
    return 1;
}

stock PlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

public OnVehicleSpawn(vehicleid) 
{
	new Float:vHatasd;
	GetVehicleHealth(vehicleid, vHatasd);
	if (vHatasd > 997)
	{
	    SetVehicleHealth(vehicleid, 997); 
	}
	#if defined HAC_OnVehicleSpawn
	    return HAC_OnVehicleSpawn(vehicleid);
	#else
		return 1;
	#endif
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    SetPVarInt(playerid, "CarID", vehicleid);
	SetPVarInt(playerid, "LegalCheat", 1);
	SetTimerEx("ResetLegalCheat", 2000, false, "i", playerid);
	#if defined HAC_OnPlayerStateChange
	    return HAC_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    new Float:vHealth;
	GetVehicleHealth(vehicleid, vHealth);
	if (vHealth > 997)
	{
		SetVehicleHealth(vehicleid, 997); 
	}
	#if defined HAC_OnVehicleMod
	    return HAC_OnVehicleMod(playerid, vehicleid, componentid);
	#else
		return 1;
	#endif
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    new Float:vHealth;
	GetVehicleHealth(vehicleid, vHealth); 
	if (vHealth > 997) 
	{
		SetVehicleHealth(vehicleid, 997); 
	}
	#if defined HAC_OnVehiclePaintjob
	    return HAC_OnVehiclePaintjob(playerid, vehicleid, paintjobid);
	#else
		return 1;
	#endif
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new Float:vHealth;
	GetVehicleHealth(vehicleid, vHealth);
	if (vHealth > 997) 
	{
		SetVehicleHealth(vehicleid, 997); 
	}
	#if defined HAC_OnVehicleRespray
	    return HAC_OnVehicleRespray(playerid, vehicleid, color1, color2);
	#else
		return 1;
	#endif
}

stock IsNotSilentVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 424, 429, 439, 441, 457, 464, 480, 485, 486, 500, 504, 506, 533, 536, 555, 567, 568, 571, 572, 575,
		430, 446, 452, 453, 454, 472, 473, 484, 493, 595, 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510: return 1;
	}
	return 0;
}

stock WeaponTick31(weaponid)
{ // 0 <> 34
    switch(weaponid)
    {
        case 22: return 190;
        case 23: return 350;
        case 24: return 680;
        case 25: return 1030;
        case 26: return 115;
        case 27: return 300;
        case 28: return 30;
        case 29: return 85;
        case 30, 31: return 90;
        case 32: return 35;
        case 33, 34: return 1000; 
    }
    return 100000;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (!GetPlayerWeapon(playerid) || IsPlayerAFK[playerid] || weaponid == 0)
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 13);
    }
    new dist = GetTickCount() - ShotTick[playerid];
    if(dist < WeaponTick31(weaponid))
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 19);
    }
    ShotTick[playerid] = GetTickCount();
   	if (hittype == 1)
	{
        new Float:ox, Float:oy, Float:oz, Float:hx, Float:hy, Float:hz;
        GetPlayerLastShotVectors(playerid, ox, oy, oz, hx, hy, hz);
        new Float:hitposdistance = GetPlayerDistanceFromPoint(hitid, hx, hy, hz);
		new Float:playerdistance = GetPlayerDistanceFromPoint(playerid, hx, hy, hz);
    	if (hitposdistance == 0)
	    {
	    	CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 0);
	    }
        if (hitposdistance > 3.0)
	    {
	    	CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 0);
	    }
		if (hitposdistance < 0)
		{
		    CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 0);
		}
		if (GetPlayerCameraMode(playerid) == 53 || GetPlayerCameraMode(playerid) == 55)
		{
			if (playerdistance < 50.0 && GetPlayerTargetPlayer(playerid) != hitid && !IsPlayerInAnyVehicle(hitid) && !IsPlayerInAnyVehicle(playerid))
			{
				SilentWarning[playerid]++;
				SilentTimer[playerid] = gettime()+5;
			}
			if (SilentWarning[playerid] >= 3 && GetPlayerTargetPlayer(playerid) != hitid && !IsPlayerInAnyVehicle(hitid) && !IsPlayerInAnyVehicle(playerid))
			{	
				CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 0);
			}
		}
		new vehicleid = GetPlayerVehicleID(hitid);
		if (IsPlayerInAnyVehicle(hitid) && !IsPlayerAFK[hitid] && !IsNotSilentVehicle(vehicleid) && GetPlayerAnimationIndex(hitid) == 0)
		{
			if (GetPlayerState(hitid) == PLAYER_STATE_DRIVER || GetPlayerState(hitid) == PLAYER_STATE_PASSENGER)
			{
                CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 0);
			}
		}
        new Float:xyz[3];
        GetPlayerPos(hitid,xyz[0],xyz[1],xyz[2]);
        new Float:Distance = GetPlayerDistanceFromPoint(playerid,xyz[0],xyz[1],xyz[2]);
		switch(weaponid) {
			case 30: {
				if(Distance > 70) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 31: {
				if(Distance > 90) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 33: {
				if(Distance > 100) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 34: {
				if(Distance > 200) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 25: {
				if(Distance > 30) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 29: {
				if(Distance > 40) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 22: {
				if(Distance > 50) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 23: {
				if(Distance > 50) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
			case 24: {
				if(Distance > 50) return CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 11);
			}
        }
    }
    #if defined HAC_OnPlayerWeaponShot
	    return HAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
    #else
		return 1;
	#endif
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat)
{
    new Float:vHealth;
	GetVehicleHealth(vehicleid, vHealth);
    if (vHealth > 997)
    {
	    SetVehicleHealth(vehicleid, 997); 
	}
    #if defined HAC_OnUnoccupiedVehicleUpdate
	    return HAC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat);
    #else
		return 1;
	#endif
}


public OnPlayerEnterCheckpoint(playerid)
{
    if (!IsPlayerInRangeOfPoint(playerid, 20.0, LastPos[playerid][0], LastPos[playerid][1], LastPos[playerid][2]))
	{
	    if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
	        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 15);
		}
	}
    #if defined HAC_OnPlayerEnterCheckpoint
	    return HAC_OnPlayerEnterCheckpoint(playerid);
    #else
		return 1;
	#endif
}

forward DestroyAirWarns(playerid);
public DestroyAirWarns(playerid)
{
	AirWarns[playerid] = 0;
	return 1;
}

forward AFKControl(playerid);
public AFKControl(playerid)
{
	if (gettime() - GetPVarInt(playerid, "Time") > 1)
	{
		IsPlayerAFK[playerid] = true;
	}
	return 1;
}

public OnPlayerUpdate(playerid) 
{
	SetPVarInt(playerid, "Time", gettime());
	if (IsPlayerAFK[playerid])
	{
		IsPlayerAFK[playerid] = false;
	}
	new vehid = GetPlayerVehicleID(playerid),
    Keys, ud, lr,
	Float:air_pX, Float:air_pY, Float:air_pZ;
	GetPlayerPos(playerid, air_pX, air_pY, air_pZ);
	new Float:air_dist = GetPlayerDistanceFromPoint(playerid, airPosX[playerid], airPosY[playerid], airPosZ[playerid]);
    GetPlayerKeys(playerid, Keys, ud, lr);
	if (vehid > -1) 
    {
		new Float:vehealth;
		GetVehicleHealth(vehid, vehealth);
		if (vehealth > 997)
		{
            CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 1);
			SetVehicleHealth(vehid, 997); 
		}
	}
	if (SilentWarning[playerid] > 0 && SilentTimer[playerid] < gettime())
	{
        SilentWarning[playerid] = 0;
	}
	if (GetPlayerWeapon(playerid) < 0)
	{
	    CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 13);
	}
	if (GetPlayerCameraMode(playerid) == 45 || GetPlayerCameraMode(playerid) == 34)
	{
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 2);
	}
    if (GetPVarInt(playerid, "LegalCheat") == 0 && GetPlayerPing(playerid) < 200 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && PlayerSpeed(playerid) >= 45 && PlayerSpeed(playerid) - OldSpeed[playerid] >= 50)
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 7);
    }
    if (GetPVarInt(playerid, "LegalCheat") == 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && PlayerSpeed(playerid) - OldSpeed[playerid] >= 50)
    {
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 7);
	}
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPVarInt(playerid, "CarID") != vehid)
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 3);
    }
    if(GetPlayerAnimationIndex(playerid) == 970 || GetPlayerAnimationIndex(playerid) == 966 || GetPlayerAnimationIndex(playerid) == 516)
    {
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 8);
    }
	if(GetPlayerAnimationIndex(playerid) == 402)
	{
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 9);
	}
	if (GetPlayerSkin(playerid) != 0 && GetPVarInt(playerid, "GameSpeed") == 0 && PlayerSpeed(playerid) > 7 && GetPlayerAnimationIndex(playerid) != 1197)
	{
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 19);
	}
	new surfingvehicle = GetPlayerSurfingVehicleID(playerid);
    new Float:svx, Float:svy, Float:svz, Float:npx, Float:npy, Float:npz;
    GetVehiclePos(surfingvehicle, svx, svy, svz);
    GetPlayerPos(playerid, npx, npy, npz);
    new Float:surfing = (svy + svx + svz) - (npx + npy + npz);
    if((surfingvehicle != 65535) && (surfing  < -30 || surfing > 30))
    {
	   CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 4);
    }
    new SurfingObject = GetPlayerSurfingObjectID(playerid);
    new Float:XObject, Float:YObject, Float:ZObject;
    GetObjectPos(SurfingObject, XObject, YObject, ZObject);
    new Float:surfing2 = (XObject + YObject + ZObject) - (npx + npy + npz);
    if((SurfingObject != 65535) && (surfing2  < -30 || surfing2 > 30))
	{
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 4);
	}
	new SeatID = GetPlayerVehicleSeat(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && SeatID == 0)
	{
        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 6);
	}
	if (GetPVarInt(playerid, "LegalCheat") == 0 && air_dist >= 2.0 && air_dist <= 90.0 && PlayerSpeed(playerid) > 5 && PlayerSpeed(playerid) < 50)
	{
	    AirWarns[playerid]++;
	    SetTimerEx("DestroyAirWarns", 250, false, "i", playerid);
	}
	if (AirWarns[playerid] >= 2 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
        AirWarns[playerid] = 0;
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 5);
	}
    if (GetPlayerAnimationIndex(playerid) == 44 && PlayerSpeed(playerid) >= 5)
    {
		CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 10);
	}
    if (IsTrailerAttachedToVehicle(vehid))
    {
        CallLocalFunction("OnPlayerChangedToTrailer", "iii", playerid, vehid, GetVehicleTrailer(vehid));
	}
	new Float:newA;
	GetVehicleZAngle(GetPlayerVehicleID(playerid), newA);
	if (GetPVarInt(playerid, "LegalCheat") == 0 && floatround(floatabs(newA - OldA[playerid])) == 180)
	{
	    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
	        CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 16);
		}
	}
	if (IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid, "LegalCheat") == 0)
    {
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
		{
		    CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 18);
		}
	}
    if ((!IsPlayerInAnyVehicle(playerid) || GetPlayerAnimationIndex(playerid) != 0) && GetPVarInt(playerid, "LegalCheat") == 0)
    {
	    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		{
		    CallLocalFunction("OnPlayerCheatDetected", "ii", playerid, 18);
		}
	}
	airPosX[playerid] = air_pX;
	airPosY[playerid] = air_pY;
	airPosZ[playerid] = air_pZ;
	#if defined HAC_OnPlayerUpdate
	    return HAC_OnPlayerUpdate(playerid);
    #else
		return 1;
	#endif
}
	
#define OnPlayerWeaponShot  	            HAC_OnPlayerWeaponShot
#define OnPlayerConnect     	            HAC_OnPlayerConnect
#define OnPlayerSpawn        	            HAC_OnPlayerSpawn
#define OnVehicleDamageStatusUpdate         HAC_OnVehicleDamageStatusUpdate
#define OnVehicleSpawn                      HAC_OnVehicleSpawn
#define OnPlayerStateChange  	            HAC_OnPlayerStateChange
#define OnVehicleMod                        HAC_OnVehicleMod
#define OnVehiclePaintjob              	    HAC_OnVehiclePaintjob
#define OnVehicleRespray                    HAC_OnVehicleRespray
#define OnPlayerUpdate                      HAC_OnPlayerUpdate
#define OnUnoccupiedVehicleUpdate           HAC_OnUnoccupiedVehicleUpdate
#define OnPlayerTakeDamage                  HAC_OnPlayerTakeDamage
#define OnPlayerEnterCheckpoint             HAC_OnPlayerEnterCheckpoint

#if defined HAC_OnPlayerWeaponShot
	forward HAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif

#if defined HAC_OnPlayerConnect
	forward HAC_OnPlayerConnect(playerid);
#endif

#if defined HAC_OnPlayerSpawn
	forward HAC_OnPlayerSpawn(playerid);
#endif

#if defined HAC_OnVehicleDamageStatusUpdate
	forward HAC_OnVehicleDamageStatusUpdate(vehicleid, playerid);
#endif

#if defined HAC_OnVehicleSpawn
	forward HAC_OnVehicleSpawn(vehicleid);
#endif

#if defined HAC_OnPlayerStateChange
	forward HAC_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

#if defined HAC_OnVehicleMod
	forward HAC_OnVehicleMod(playerid, vehicleid, componentid);
#endif

#if defined HAC_OnVehiclePaintjob
	forward HAC_OnVehiclePaintjob(playerid, vehicleid, paintjobid);
#endif

#if defined HAC_OnVehicleRespray
	forward HAC_OnVehicleRespray(playerid, vehicleid, color1, color2);
#endif

#if defined HAC_OnPlayerUpdate
	forward HAC_OnPlayerUpdate(playerid);
#endif

#if defined HAC_OnUnoccupiedVehicleUpdate
	forward HAC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat);
#endif

#if defined HAC_OnPlayerTakeDamage
    forward HAC_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid);
#endif

#if defined HAC_OnPlayerEnterCheckpoint
    forward HAC_OnPlayerEnterCheckpoint(playerid);