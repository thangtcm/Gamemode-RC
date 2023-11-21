#include <YSI\y_hooks>

forward Car_Check();
public Car_Check()
{
    new Float:vHealth;
    foreach(new i: Player)
    {
        for(new d; d < MAX_PLAYERVEHICLES; d++)
        {
            if (PlayerVehicleInfo[i][d][pvId] == GetPlayerVehicleID(i))
            {
                GetVehicleHealth(PlayerVehicleInfo[i][d][pvId], vHealth);
                if(vHealth == 1000.0)
                {
                    SetVehicleHealth(PlayerVehicleInfo[i][d][pvId], 900.0);
                    SendClientMessage(i, COLOR_LIGHTRED, "SYSTEM: Ban da bi kick vi nghi van su dung Car Cheat.");
                    SetTimerEx("KickEx", 1000, 0, "i", i);
                }
            }
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    SetTimer("Car_Check", 1000, true);
    return 1;
}