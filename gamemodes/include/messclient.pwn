
#define SendUsageMessage(%0,%1) \
    sendMessage(%0, COLOR_LIGHTRED, "{FF6347}USE:{FFFFFF}"%1)
    
#define SendErrorMessage(%0,%1) \
    sendMessage(%0, COLOR_LIGHTRED, "{FF6347}ERROR:{FFFFFF}"%1)

#define SendServerMessage(%0,%1) \
    sendMessage(%0, COLOR_LIGHTRED, "{FF6347}SERVER:{FFFFFF}"%1)

#define SendSelectMessage(%0,%1) \
    sendMessage(%0, COLOR_LIGHTRED, "{FF6347}TUY CHON:{FFFFFF}"%1)

stock sendMessage(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[156]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 156
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
} // Credits to Emmet, South Central Roleplay

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
		args,
		start,
		end,
		string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if(args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

		for(end = start + (args - 16); end > start; end -= 4)
		{
			#emit LREF.pri end
			#emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach(new i : Player)
		{
			if(IsPlayerNearPlayer(i, playerid, radius))
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach(new i : Player)
	{
		if(IsPlayerNearPlayer(i, playerid, radius))
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}