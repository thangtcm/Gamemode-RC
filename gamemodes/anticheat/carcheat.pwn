#include <YSI_Coding\y_hooks>

#define MAX_VEHICLE_HEATH 900.0

static Checkvehicle[MAX_PLAYERS];
static bool:PlayerInModShop[MAX_PLAYERS];

static const Float:PAYNSPRAY[][] = 
{
    {1025.05, -1024.23, 32.1}, // LS Temple
    {487.68, -1740.87, 11.13}, // LS Santa Maria
    {-1420.73, 2583.37, 55.56}, // El Quebrados
    {-1904.39, 284.97, 40.75}, // Wang Cars
    {-2425.91, 1022.33, 50.10}, // Juniper Hill
    {1975.60, 2162.16, 10.77}, // LV Redsands
    {2065.38, -1831.51, 13.25}, // Idlewood
    {-99.55, 1118.36, 19.44}, // Fort Carson
    {721.07, -455.94, 16.04}, // Dillimore
    {2393.74, 1493.01, 10.52} // LV Unused (Pyramid)
};

forward CheckVehicleHealth(playerid);

/* Functions */

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(Checkvehicle[playerid]);
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{ 
    new Float:Vehiclehealth;
    GetVehicleHealth(vehicleid, Vehiclehealth);
    if(Vehiclehealth > GetVehicleMaxHealth(vehicleid))
    {
        SetVehicleHealth(vehicleid, GetVehicleMaxHealth(vehicleid));
    }

    return 1;
  
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) 
    {
        Checkvehicle[playerid] = SetTimerEx("CheckVehicleHealth", 1000, 1, "i",  playerid);
    }

    if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) KillTimer(Checkvehicle[playerid]);
    

    return 1;
}

hook OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(enterexit == 1) // Enter
    {
        PlayerInModShop[playerid] = true;
    }

    if(enterexit == 0) // Exit
    {
        SetVehicleHealth(GetPlayerVehicleID(playerid), GetVehicleMaxHealth(GetPlayerVehicleID(playerid)));
        PlayerInModShop[playerid] = false;
    }

    return 1;
}


public CheckVehicleHealth(playerid)
{
    new Float:Vehiclehealth;
    GetVehicleHealth(GetPlayerVehicleID(playerid), Vehiclehealth);

    for(new i=0; i<sizeof(PAYNSPRAY); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10, PAYNSPRAY[i][0], PAYNSPRAY[i][1], PAYNSPRAY[i][2]))
        {
            if(Vehiclehealth > GetVehicleMaxHealth(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                SetVehicleHealth(GetPlayerVehicleID(playerid), GetVehicleMaxHealth(GetPlayerVehicleID(playerid)));
                return 1;
            }
        }
    }

    if(Vehiclehealth > GetVehicleMaxHealth(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && PlayerInModShop[playerid] == false)
    {
        new string[128];
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
        SetPlayerArmedWeapon(playerid, 0);
        if(GetPVarInt(playerid, "Injured") == 1)
        {
            KillEMSQueue(playerid);
            ClearAnimations(playerid);
        }
        if(GetPVarInt(playerid, "IsInArena") >= 0) LeavePaintballArena(playerid, GetPVarInt(playerid, "IsInArena"));
        GameTextForPlayer(playerid, "~w~Welcome to ~n~~r~Fort DeMorgan", 5000, 3);
        ResetPlayerWeaponsEx(playerid);
        format(string, sizeof(string), "AdmCmd: %s da bi phat tu boi System, ly do: Car Cheat (Health)", GetPlayerNameEx(playerid));
        Log("logs/admin.log", string);
        format(string, sizeof(string), "AdmCmd: %s da bi phat tu boi System, ly do: Car Cheat (Health)", GetPlayerNameEx(playerid));
        SendClientMessageToAllEx(COLOR_LIGHTRED, string);
        PlayerInfo[playerid][pWantedLevel] = 0;
        SetPlayerWantedLevel(playerid, 0);
        SetPlayerHealth(playerid, 0x7FB00000);
        PlayerInfo[playerid][pJailTime] = 10*60;
        SetPVarInt(playerid, "_rAppeal", gettime()+60);			format(PlayerInfo[playerid][pPrisonReason], 128, "[OOC][PRISON] Car Cheat");
        PhoneOnline[playerid] = 1;
        SetPlayerInterior(playerid, 1);
        PlayerInfo[playerid][pInt] = 1;
        new rand = random(sizeof(OOCPrisonSpawns));
        Streamer_UpdateEx(playerid, OOCPrisonSpawns[rand][0], OOCPrisonSpawns[rand][1], OOCPrisonSpawns[rand][2]);
        ActSetPlayerPos(playerid, OOCPrisonSpawns[rand][0], OOCPrisonSpawns[rand][1], OOCPrisonSpawns[rand][2]);
        SetPlayerSkin(playerid, 50);
        SetPlayerColor(playerid, TEAM_APRISON_COLOR);
        Player_StreamPrep(playerid, OOCPrisonSpawns[rand][0], OOCPrisonSpawns[rand][1], OOCPrisonSpawns[rand][2], FREEZE_TIME);
        return 1;
    }

    return 1;
}
