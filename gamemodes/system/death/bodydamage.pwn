/*
    ,============================================,
    |     Body Damage (He thong sat thuong)     |
    |               29.11.2023                  |
    |         Script: Nicks / Nickzky           |
    *============================================*

    Contact :
    > FB : https://www.facebook.com/Nick.2208/
    > Discord : nicks6723
*/

/* -------------------------------- INCLUDE -------------------------------- */
#include <YSI_Coding\y_hooks>

/* -------------------------------- DEFINES -------------------------------- */


/* -------------------------------- VARIABLES -------------------------------- */
enum
{
    BODY_PART_TORSO = 3,
    BODY_PART_GROIN,
    BODY_PART_LEFT_ARM,
    BODY_PART_RIGHT_ARM,
    BODY_PART_LEFT_LEG,
    BODY_PART_RIGHT_LEG,
    BODY_PART_HEAD
}
enum e_dmg
{
    Float:dmg_Amount,
    dmg_Target[MAX_PLAYER_NAME],
	dmg_GunID,
	dmg_Bodypart
}
const
    MAX_DAMAGES = 1000;

new DamageInfo[MAX_PLAYERS][MAX_DAMAGES][e_dmg];
/* -------------------------------- FUNCTION -------------------------------- */
static stock Damage_GetBodypart(bodypart)
{
    new bodyname[20];
    switch(bodypart)
    {
        case BODY_PART_TORSO: bodyname = "Nguc";
        case BODY_PART_GROIN: bodyname = "Hang";
        case BODY_PART_LEFT_ARM: bodyname = "Tay trai";
        case BODY_PART_RIGHT_ARM: bodyname = "Tay phai";
        case BODY_PART_LEFT_LEG: bodyname = "Chan trai";
        case BODY_PART_RIGHT_LEG: bodyname = "Chan phai";
        case BODY_PART_HEAD: bodyname = "Dau";
    }
    return bodyname;
}
stock Damage_ResetDamages(playerid)
{
    for(new i = 0; i < MAX_DAMAGES; i++)
    {
        DamageInfo[playerid][i][dmg_Amount] = 0.0;
        strcpy(DamageInfo[playerid][i][dmg_Target], "None", 5);
        DamageInfo[playerid][i][dmg_GunID] = 0;
        DamageInfo[playerid][i][dmg_Bodypart] = 0;
        // DamageInfo[playerid][i][dmg_Tick] = 0;
    }
    return 1;
}
/* -------------------------------- CALLBACKS -------------------------------- */
hook OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    if(gPlayerLogged{damagedid})
    {
        new
            i = 0;
        if((bodypart == BODY_PART_RIGHT_LEG || bodypart == BODY_PART_LEFT_LEG) && (ProxDetectorS(50.0, playerid, damagedid) && random(100) < 15))
        {
            if(GetPVarInt(playerid, "IsInArena") == -1 && !GetPVarInt(playerid, "EventToken") && GetPVarInt(damagedid, "Injured") == 0)
            {
                ApplyAnimation(damagedid,"GYMNASIUM","gym_tread_falloff",1.0,0,0,0,0,0);
                cmd_me(damagedid, "da bi te do ban trung vao chan");
                GameTextForPlayer(damagedid, " ", 3000, 1);
                GameTextForPlayer(damagedid, "~r~Bi te !", 5000, 1); 
            }
        }
        while(DamageInfo[damagedid][i][dmg_Amount] != 0.0) i++;
        strcpy(DamageInfo[damagedid][i][dmg_Target], GetPlayerNameEx(playerid), MAX_PLAYER_NAME);
        DamageInfo[damagedid][i][dmg_Amount] = amount;
        DamageInfo[damagedid][i][dmg_GunID] = weaponid;
        DamageInfo[damagedid][i][dmg_Bodypart] = bodypart;
        new 
            Float:x,
            Float:y,
            Float:z,
            Float:Distance, string[500];

        GetPlayerPos(damagedid, x, y, z);
        Distance = GetPlayerDistanceFromPoint(playerid,x,y,z);
        
        format(string, sizeof(string), "[RC-DMG] {AA3333}-%.2f HP{FFFFFF} {E28221}[%s]{FFFFFF} bang {FFFF00}%s{FFFFFF} vao {33CCFF}%s{FFFFFF} {708090}(%.1fm)", DamageInfo[damagedid][i][dmg_Amount], GetPlayerNameEx(playerid), GetWeaponNameEx(weaponid), Damage_GetBodypart(bodypart), Distance);
        SendClientMessage(damagedid, -1, string);// bi ban
        format(string, sizeof(string), "[RC-DMG] {33AA33}+%.2f HP{FFFFFF} {E28221}[%s]{FFFFFF} bang {FFFF00}%s{FFFFFF} vao {33CCFF}%s{FFFFFF} {708090}(%.1fm)", DamageInfo[damagedid][i][dmg_Amount], GetPlayerNameEx(damagedid), GetWeaponNameEx(weaponid), Damage_GetBodypart(bodypart), Distance);
        SendClientMessage(playerid, -1, string);// nguoi ban
    }
    return 1;
}