#include <YSI_Coding\y_hooks>

#define MAX_DOTS           (3000)
#define GPS_ERROR_NODE      (0)
#define COLOR_GPS 0x6c07b0FF

// Variables

enum E_GPS_DATA
{
    bool:gpsEnabled,
    Float:gpsCoordinates[3]
};

static GPS_DATA[MAX_PLAYERS][E_GPS_DATA];
static Routes[MAX_PLAYERS][MAX_DOTS];
new GangZonePlayerArea[MAX_PLAYERS][MAX_DOTS];

// Functions

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][pAdmin] < 2)
        SetPlayerCheckPointEx(playerid, fX, fY, fZ, 10);
    return true;
}

// hook OnPlayerUpdate(playerid)
// {
//     for(new x; x < MAX_DOTS; ++x)
// 	{
//         if(Routes[playerid][x] == -1) return 1;
//         if(IsPlayerInPlayerGangZoneEx(playerid, Routes[playerid][x]))
//         {
//             for(new i; i <= x; i++)
//             {
//                 if(Routes[playerid][x] != -1)
//                 {
//                     PlayerGangZoneDestroyEx(playerid, Routes[playerid][i]);
//                     Routes[playerid][i] = -1;
//                 }
//             }
//             x = MAX_DOTS;
//             break;
//         }
//     }
//     return 1;
// }

stock Float:GDBP(Float:X2, Float:Y2, Float:Z2, Float: PointX, Float: PointY, Float: PointZ)
{
	return floatsqroot(floatadd(floatadd(floatpower(floatsub(X2, PointX), 2.0), floatpower(floatsub(Y2, PointY), 2.0)), floatpower(floatsub(Z2, PointZ), 2.0)));
}

stock HasWaypointSet(playerid)
{
    return GPS_DATA[playerid][gpsEnabled];
}

stock UpdateWaypoint(playerid)
{
    return SetPlayerPath(playerid, GPS_DATA[playerid][gpsCoordinates][0], GPS_DATA[playerid][gpsCoordinates][1], GPS_DATA[playerid][gpsCoordinates][2]);
}

stock CreateMapRoute(playerid, Float:X1, Float:Y1, Float:X2, Float:Y2, color)
{
	new 
		Float: Dis = 10, 
		Float: TotalDis = GDBP(X1, Y1, 0.0, X2, Y2, 0.0), 
		mapPoints = floatround(TotalDis / Dis)
	;

	for(new i = 1; i <= mapPoints; ++i)
	{
		new Float: x, Float: y;

		if(i != 0)
		{
			x = X1 + (((X2 - X1) / mapPoints) * i);
			y = Y1 + (((Y2 - Y1) / mapPoints) * i);
		}
		else
		{
			x = X1;
			y = Y1;
		}

		new slot = 0;

		while(slot <= MAX_DOTS)
		{
			if(slot == MAX_DOTS)
			{
				slot = -1;
				break;
			}

			if(Routes[playerid][slot] == -1)
			{
				break;
			}
			slot++;
		}

		if(slot == -1) return;

		Routes[playerid][slot] = PlayerGangZoneCreate(playerid, x-(Dis / 2)-2.5, y-(Dis / 2)-2.5, x+(Dis / 2)+2.5, y+(Dis / 2)+2.5);
        GangZonePlayerArea[playerid][slot] = CreateDynamicRectangle(x-(Dis / 2)-2.5, y-(Dis / 2)-2.5, x+(Dis / 2)+2.5, y+(Dis / 2)+2.5, .playerid = playerid);
		PlayerGangZoneShowEx(playerid, Routes[playerid][slot], color);
	}
}

stock DestroyRoutes(playerid)
{
	for(new x; x < MAX_DOTS; ++x)
	{
		if(Routes[playerid][x] != -1)
		{
            PlayerGangZoneHideEx(playerid, Routes[playerid][x]);
		    PlayerGangZoneDestroyEx(playerid, Routes[playerid][x]);
		    Routes[playerid][x] = -1;
            if(GangZonePlayerArea[playerid][x] != -1)
            {
                DestroyDynamicArea(GangZonePlayerArea[playerid][x]);
                GangZonePlayerArea[playerid][x] = -1;
            }
		}
	}
}

stock ForcePlayerEndLastRoute(playerid)
{
	GPS_DATA[playerid][gpsEnabled] = false;
	DestroyRoutes(playerid);
    SendServerMessage(playerid, "Ban da den vi tri can den.");
//	DisablePlayerCheckpoint(playerid);
}

stock SetPlayerPath(playerid, Float:X2, Float:Y2, Float:Z2)
{
	new Float:x, Float:y, Float:z, MapNode:start, MapNode:target;
    GetPlayerPos(playerid, x, y, z);
	if((GDBP(X2, Y2, 0.0, x, y, 0.0) <= 15.0))
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Ban da den vi tri nay.");
		ForcePlayerEndLastRoute(playerid);
		return true;
	}

    if(GetClosestMapNodeToPoint(x, y, z, start) != 0) return print("Khong tim duoc duong di.");
    if(GetClosestMapNodeToPoint(X2, Y2, Z2, target)) return print("Khong tim duoc duong di.");

    if(FindPathThreaded(start, target, "OnPathFound", "i", playerid))
    {
    	SendClientMessage(playerid, -1, "Da xay ra loi.");
    	return true;
    }
    return true;
}

forward public OnPathFound(Path:pathid, playerid);
public OnPathFound(Path:pathid, playerid)
{
    if(!IsValidPath(pathid)) return SendErrorMessage(playerid, "Error [G03].");

    DestroyRoutes(playerid);

    new Mapsize, Float:Maplength;
    GetPathSize(pathid, Mapsize);
    GetPathLength(pathid, Maplength);
    
    if(Mapsize == 1)
    {
    	ForcePlayerEndLastRoute(playerid);
		return SendClientMessage(playerid, COLOR_ORANGE, "Ban da den vi tri.");
    }
    
	new MapNode:nodeid, mapindex, Float:lastx, Float:lasty,Float:lastz;
	GetPlayerPos(playerid, lastx, lasty, lastz);
	GetClosestMapNodeToPoint(lastx, lasty, lastz, nodeid);
	GetMapNodePos(nodeid, lastx, lasty, lastz);

	new _max = MAX_DOTS, firstpos = 1;
	if(MAX_DOTS > Mapsize) _max = Mapsize;
    else return SendErrorMessage(playerid, "Khong the tim duong, vi tri qua xa.");

	new Float:mapPosX,Float:mapPosY,Float:mapPosZ,
	Float:PX, Float:PY, Float:PZ;
	GetPlayerPos(playerid, PX, PY, PZ);

	for(new i = 0; i < _max; ++i)
	{
		GetPathNode(pathid, i, nodeid);
		GetPathNodeIndex(pathid, nodeid, mapindex);
		GetMapNodePos(nodeid, mapPosX, mapPosY, mapPosZ);
		if(firstpos) // to connect the path with the player's position
		{
		    CreateMapRoute(playerid, PX, PY, mapPosX, mapPosY, COLOR_GPS);
		    firstpos = 0;
		}
		else
		{
			if(i == mapindex) CreateMapRoute(playerid, lastx, lasty, mapPosX, mapPosY, COLOR_GPS);
			lastx = mapPosX + 0.1;
			lasty = mapPosY + 0.1;
		}
	}
    DestroyPath(pathid);
    return true;
}

// CMD:resetpath(playerid) {
//     printf("AAA  %d", Routes[playerid][0]);
//     for(new x; x < MAX_DOTS; ++x)
// 	{
//         if(Routes[playerid][x] == -1) return 1;
//         if(IsPlayerInPlayerGangZoneEx(playerid, Routes[playerid][x]))
//             printf("test %d %d %d", IsPlayerInPlayerGangZoneEx(playerid, Routes[playerid][x]), x);
//     }
//     return 1;
// }

stock CheckNodePath(playerid, areaid){
    for(new x; x < MAX_DOTS; ++x)
	{
        if(Routes[playerid][x] != -1){
            if(GangZonePlayerArea[playerid][x] == areaid)
            {
                for(new i; i <= x; i++)
                {
                    if(Routes[playerid][i] != -1)
                    {
                        PlayerGangZoneDestroyEx(playerid, Routes[playerid][i]);
                        Routes[playerid][i] = -1;
                    }
                    if(GangZonePlayerArea[playerid][i] != -1)
                    {
                        DestroyDynamicArea(GangZonePlayerArea[playerid][i]);
                        GangZonePlayerArea[playerid][i] = -1;
                    }
                }
                x = MAX_DOTS;
                break;
            }
        }
    }
    return 1;
}

stock bool:IsPointInRectangle(const Float:px, const Float:py, const Float:minx, const Float:miny, const Float:maxx, const Float:maxy){
	return (px >= minx && px <= maxx) && (py >= miny && py <= maxy);
}

stock SetPlayerCheckPointEx(playerid, Float:pointX, Float:pointY, Float:pointZ, Float:radius)
{
    GPS_DATA[playerid][gpsEnabled] = true;
    GPS_DATA[playerid][gpsCoordinates][0] = pointX;
    GPS_DATA[playerid][gpsCoordinates][1] = pointY;
    GPS_DATA[playerid][gpsCoordinates][2] = pointZ;

    SetPlayerPath(playerid, pointX, pointY, pointZ);

    SendClientMessage(playerid, COLOR_GRAD2, "He thong dang tu tim duong cho ban.");
    return SetPlayerCheckpoint(playerid, pointX, pointY, pointZ, radius);
}