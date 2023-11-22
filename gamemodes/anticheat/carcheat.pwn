#include <YSI_Coding\y_hooks>

#define MAX_VEHICLE_HEATH 999.0

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
stock Float: GetVehicleMaxHealth(vehicleid)
{
    foreach(new i: Player)
    {
        for(new d; d < MAX_PLAYERVEHICLES; d++)
        {
            if(PlayerVehicleInfo[i][d][pvId] == vehicleid)
            {
                return (PlayerVehicleInfo[i][d][pvMaxHealth]);
            }
        }
    }

    return MAX_VEHICLE_HEATH;
}

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
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
        SendClientMessage(playerid, COLOR_LIGHTRED, "SYSTEM:{FFFFFF} Ban da bi kick boi he thong vi su dung Car Cheat.");
        SetTimerEx("KickEx", 1000, false, "i", playerid);
        return 1;
    }

    return 1;
}
