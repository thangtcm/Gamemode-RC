//=====================INCLUDES=====================

#include 	<a_samp>
#include	<sscanf2>
#include <YSI_Coding\y_hooks>

//=====================DIALOGS======================

#define	DIALOG_DAMAGE 1927

//==================CONTROL PANEL===================

#define	MAX_DAMAGES	1000

//===================ENUMERATORS====================
enum {

    BODY_PART_TORSO = 3,
	BODY_PART_GROIN = 4,
	BODY_PART_RIGHT_ARM = 6,
	BODY_PART_LEFT_ARM = 5,
	BODY_PART_RIGHT_LEG = 8,
	BODY_PART_LEFT_LEG = 7,
	BODY_PART_HEAD = 9
}


enum dmgInfo
{
	dmgDamage,
	dmgWeapon,
	dmgBodypart,
	dmgKevlarhit,
	dmgSeconds,
}
new DamageInfo[MAX_PLAYERS][MAX_DAMAGES][dmgInfo];

hook OnPlayerConnect(playerid)
{
	ResetPlayerDamages(playerid);
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	ResetPlayerDamages(playerid);
	return 1;
}

CMD:damages(playerid, params[])
{
	new id;
	
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xFF6347FF, "USAGE: {FFFFFF}/damages [playerid/PartOfName]");

	ShowPlayerDamages(id, playerid);

	return 1;
}

hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	new id, Float: pHP, Float: pArm;
	GetPlayerHealth(damagedid, pHP);
	GetPlayerArmour(damagedid, pArm);

	for(new i = 0; i < MAX_DAMAGES; i++)
	{
		if(!DamageInfo[damagedid][i][dmgDamage])
		{
			id = i;
			break;
		}
	}
	
	DamageInfo[damagedid][id][dmgDamage] = floatround(amount, floatround_round);
	DamageInfo[damagedid][id][dmgWeapon] = weaponid;
	DamageInfo[damagedid][id][dmgBodypart] = bodypart;
	printf("Bodypart: %d %s, %d %s", DamageInfo[damagedid][id][dmgBodypart], DamageInfo[damagedid][id][dmgBodypart], bodypart, bodypart);

	if(pArm > 0) DamageInfo[damagedid][id][dmgKevlarhit] = 1;
	else if(pArm < 1) DamageInfo[damagedid][id][dmgKevlarhit] = 0;

	DamageInfo[damagedid][id][dmgSeconds] = gettime();
}


stock GetBodyPartName(bodypart)
{
	new part[32];
	switch(bodypart)
	{
		case BODY_PART_TORSO: 		part = "Than (Torso)";		
		case BODY_PART_GROIN: 		part = "Hang (Groin)";			
		case BODY_PART_LEFT_ARM: 	part = "Tay phai";	
		case BODY_PART_RIGHT_ARM: 	part = "Tay trai";	
		case BODY_PART_LEFT_LEG: 	part = "Chan trai";	
		case BODY_PART_RIGHT_LEG: 	part = "CHAN phai";	
		case BODY_PART_HEAD: 		part = "Dau";		
		default: 					part = "Khong xac dinh";	
	}
	return part;
}

stock ResetPlayerDamages(playerid)
{
	for(new id = 0; id < MAX_DAMAGES; id++)
	{
		if(DamageInfo[playerid][id][dmgDamage] != 0)
		{
			DamageInfo[playerid][id][dmgDamage] = 0;
			DamageInfo[playerid][id][dmgWeapon] = 0;
			DamageInfo[playerid][id][dmgBodypart] = 0;
			DamageInfo[playerid][id][dmgKevlarhit] = 0;
			DamageInfo[playerid][id][dmgSeconds] = 0;
		}
	}
	return 1;
}

stock ShowPlayerDamages(playerid, toid)
{
	new str[1000], str1[500], count = 0, name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));

	for(new id = 0; id < MAX_DAMAGES; id++)
	{
		if(DamageInfo[playerid][id][dmgDamage] != 0) count++;
	}

	if(count == 0) return ShowPlayerDialog(toid, DIALOG_DAMAGE, DIALOG_STYLE_LIST, name, "There is no damage to display...", "Close", "");
	else if(count > 0)
	{
		for(new id = 0; id < MAX_DAMAGES; id++)
		{
			if(DamageInfo[playerid][id][dmgDamage] != 0)
			{
				new part[100];
				switch(DamageInfo[playerid][id][dmgBodypart])
				{
					case 3:  part = "Than (Torso)";		
					case 4:  part = "Hang (Groin)";			
					case 5:  part = "Tay phai";	
					case 6:  part = "Tay trai";	
					case 7:  part = "Chan trai";	
					case 8:  part = "Chan phai";	
					case 9:  part = "Dau";		
					default: part = "Khong xac dinh";	

				}

				format(str1, sizeof str1, "%d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", 
					DamageInfo[playerid][id][dmgDamage], 
					GetWeaponNameEx(DamageInfo[playerid][id][dmgWeapon]), 
					part, 
					DamageInfo[playerid][id][dmgKevlarhit], gettime() - DamageInfo[playerid][id][dmgSeconds]
				);	

				strcat(str, str1);
			}
		}
		ShowPlayerDialog(toid, DIALOG_DAMAGE, DIALOG_STYLE_LIST, name, str, "Close", "");
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if (dialogid == DIALOG_DAMAGE) {
		if (response || !response)
			return 1;
	}
	return 1;
}