
const MAX_SHOW_DMG = 50;

enum dmgInfo
{
    dmgBody,
    Float:dmgHit,
    dmgReason
};

new DamagedInfo[MAX_PLAYERS][MAX_SHOW_DMG][dmgInfo];

stock GetBodyName(bodypart)
{
    new szResult[128];
    switch(bodypart)
    {
        case 3: szResult = "Than";
        case 4: szResult = "Hang";
        case 5: szResult = "Tay trai";
        case 6: szResult = "Tay phai";
        case 7: szResult = "Chan trai";
        case 8: szResult = "Chan phai";
        case 9: szResult = "Dau";
        default: szResult = "Khong ro";
    }
    return szResult;
}

stock ResetDamagedPlayer(playerid)
{
    for(new i; i < MAX_SHOW_DMG; i ++)
    {
        DamagedInfo[playerid][i][dmgBody] = 0;
        DamagedInfo[playerid][i][dmgHit] = 0.0;
        DamagedInfo[playerid][i][dmgReason] = -1;
        DamagedReset[playerid] = -1;
    }
    return 1;
}

CMD:damages(playerid, const params[])
{
    new targetid;
    if(sscanf(params, "d", targetid)) return SendUsageMessage(playerid, " /damages [playerid]");

    if(GetPVarInt(targetid, "Injured") == 0) 
        return SendClientMessage(playerid, COLOR_GRAD2, "Nguoi choi nay khong bi thuong.");
    if(!ProxDetectorS(5.0, playerid, targetid))
        return SendClientMessage(playerid, COLOR_GRAD2, "Nguoi choi nay khong o gan ban.");
    if(GetPVarInt(playerid, "Injured") != 0)
        return SendClientMessage(playerid, COLOR_GRAD2, "Ban khong the lam dieu nay khi bi thuong.");

    new title[128], szDialog[1028];
    strcat(szDialog, "Vu khi\tSat thuong\tBo phan\n");
    for(new i; i < MAX_SHOW_DMG; i ++)
    {
        if(DamagedInfo[targetid][i][dmgHit] != 0)
        {
            format(szDialog, sizeof(szDialog), "%s%s\tgay ra {A81F1F}%0.1f\t{FFFFFF}%s\n", 
            szDialog,
            GetWeaponNameEx(DamagedInfo[targetid][i][dmgReason]),
            DamagedInfo[targetid][i][dmgHit],
            GetBodyName(DamagedInfo[playerid][i][dmgBody]));
        }
    }

    format(title, sizeof(title), "Thong tin sat thuong [ID: %d]", targetid);
    ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_TABLIST_HEADERS, title, szDialog, "Dong", "");

    return 1;
}


/*=====================================*/
#include <YSI_Coding\y_hooks>
hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    for(new i; i < MAX_SHOW_DMG; i++)
    {
        if(DamagedInfo[playerid][i][dmgBody] == 0)
        {
            DamagedInfo[playerid][i][dmgBody] = bodypart;
            DamagedInfo[playerid][i][dmgHit] = amount;
            DamagedInfo[playerid][i][dmgReason] = weaponid;
            
            DamagedReset[playerid] = 45;
            break;
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
<<<<<<< HEAD
    ResetDamagedPlayer(playerid);
    return 1;
=======
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
>>>>>>> main
}