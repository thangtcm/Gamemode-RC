

#include <YSI\y_hooks>

#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

hook OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "NotAndroid", 0);  
    SendClientCheck(playerid, 0x48, 0, 0, 2);
    return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    switch(actionid)
    {       
        case 0x48:
        {
            SetPVarInt(playerid, "NotAndroid", 1);	
        }
    }
    return 1;
}