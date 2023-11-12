#include <YSI_Coding\y_hooks>

static bool:playerweaponshot[MAX_PLAYERS], 
	playershotplayerid[MAX_PLAYERS], 
	warnings[MAX_PLAYERS];

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	playerweaponshot[playerid] = true;
	if (hitid != INVALID_PLAYER_ID)
		playershotplayerid[playerid] = hitid;
	return true;
}

AC_FD_OnPlayerDamage(playerid, issuerid, weapon)
{
	if (issuerid != INVALID_PLAYER_ID) {
		if (IsBulletWeapon(weapon)) {
			if (!playerweaponshot[issuerid] && playershotplayerid[issuerid] != playerid) {
				if (warnings[issuerid] < 3)
					warnings[issuerid]++;
				else {
                    new mess[128];
                    format(mess, sizeof(mess), "RCRP-AC: %s (PID: %d - ID SQL: %d) dang hack Fake damager 'Bullet'", GetPlayerNameEx(playerid, false), playerid, GetPlayerSQLId(playerid));
                    ABroadCast(COLOR_YELLOW, string, 2);
                    format(mess, sizeof(mess), "[RCRP-AC] %s (%d) da bi kick khoi may chu [Reason: RCRP-AC Fake damager 'Bullet'].", GetPlayerNameEx(playerid, false), playerid);
                    SendClientMessageToAllEx(COLOR_LIGHTRED, mess);
                    SetTimerEx("KickEx", 1000, 0, "i", playerid);
					warnings[issuerid] = 0;
				}
				return false;
			}
		}
		else if (IsMeleeWeapon(weapon)) {
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, Float:x, Float:y, Float:z);
			if (!IsPlayerInRangeOfPoint(issuerid, 2.0, Float:x, Float:y, Float:z)) {
				if (warnings[issuerid] < 3)
					warnings[issuerid]++;
				else {					
                    new mess[128];
                    format(mess, sizeof(mess), "RCRP-AC: %s (PID: %d - ID SQL: %d) dang hack Fake damager 'Meele'", GetPlayerNameEx(playerid, false), playerid, GetPlayerSQLId(playerid));
                    ABroadCast(COLOR_YELLOW, string, 2);
                    format(mess, sizeof(mess), "[RCRP-AC] %s (%d) da bi kick khoi may chu [Reason: RCRP-AC Fake damager 'Meele'].", GetPlayerNameEx(playerid, false), playerid);
                    SendClientMessageToAllEx(COLOR_LIGHTRED, mess);
                    SetTimerEx("KickEx", 1000, 0, "i", playerid);	
					AC_Kick(issuerid, "Fake damager 'Meele' (AShot)");
					warnings[issuerid] = 0;
				}
				return false;
			}
		}
		playerweaponshot[issuerid] = false;
		playershotplayerid[issuerid] = INVALID_PLAYER_ID;
	}

	return true;
}