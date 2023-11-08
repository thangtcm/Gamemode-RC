#include <a_samp>
#include <YSI_Coding\y_hooks>

#define MAX_BODY_PARTS 7

#define MAX_WEAPONS 55
#define D_DAMAGES 1
#define BODY_PART_TORSO 3
#define BODY_PART_GROIN 4
#define BODY_PART_RIGHT_ARM 5
#define BODY_PART_LEFT_ARM 6
#define BODY_PART_RIGHT_LEG 7
#define BODY_PART_LEFT_LEG 8
#define BODY_PART_HEAD 9

#define DEATH_RESET     true

new Damage[MAX_PLAYERS][MAX_BODY_PARTS][MAX_WEAPONS];
new BanVaoChan[MAX_PLAYERS];


hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) 
{
    return 0;
}
forward BiBanChan(playerid);
public BiBanChan(playerid)
{
	BanVaoChan[playerid] = 0;
}


DisplayDamages(toplayer, playerid)
{
        new playername[MAX_PLAYER_NAME], title[45];
        GetPlayerName(playerid, playername, sizeof(playername));
        format(title, sizeof(title), "Vet thuong cua %s", playername);
        if(!CountDamages(playerid)) return ShowPlayerDialog(toplayer, D_DAMAGES, DIALOG_STYLE_LIST, title, "Dang xem vi tri vet thuong...", ">>>", "");
        new gText[1000], fstr[45];
        for(new i = 0; i < MAX_BODY_PARTS; i++)
        {
                for(new z = 0; z < MAX_WEAPONS; z++)
                {
                        if(!Damage[playerid][i][z]) continue;
     
                        switch(z)
                        {
                                case 0,5,6,7,9,2: format(fstr, sizeof(fstr), "%d vet thuong tu %s danh vao %s\n", Damage[playerid][i][z], GetWeaponNameEx(z), GetBodyPartName(i + 3));
                                case 8: format(fstr, sizeof(fstr), "%d nhat chem tu %s vao %s\n", Damage[playerid][i][z], GetWeaponNameEx(z), GetBodyPartName(i + 3));
                                case 22 .. 34: format(fstr, sizeof(fstr), "%d vien dan %s o %s\n", Damage[playerid][i][z], GetWeaponNameEx(z), GetBodyPartName(i + 3));
                                case 54: format(fstr, sizeof(fstr), "%d bi phong o %s sau vu no\n", Damage[playerid][i][z], GetBodyPartName(i));
                                default: format(fstr, sizeof(fstr), "%d vien dan %s vao %s\n", Damage[playerid][i][z], GetWeaponNameEx(z), GetBodyPartName(i + 3));
                        }
                        strcat(gText, fstr);
                }
        }
        ShowPlayerDialog(toplayer, D_DAMAGES, DIALOG_STYLE_LIST, title, gText, "Dong", "");
        return 1;
}


//      FUNCTIONS
ResetDamages(playerid)
{
        for(new i = 0; i < MAX_BODY_PARTS; i++)
        {
                for(new z = 0; z < MAX_WEAPONS; z++) Damage[playerid][i][z] = 0;
        }
        return 1;
}

CountDamages(playerid)
{
        new count = 0;
        for(new i = 0; i < MAX_BODY_PARTS; i++)
        {
                for(new z = 0; z < MAX_WEAPONS; z++)
                {
                        if(Damage[playerid][i][z]) count += Damage[playerid][i][z];
                }
        }
        return count;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(GetPVarInt(playerid, "Injured") == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
		if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP))
		{
			ApplyAnimation(playerid,"FINALE", "FIN_Land_Die", 4.0, 0, 1, 1, 0, 0, 1);
		}
		if(PRESSED(KEY_SPRINT))
		{
			ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
		}
		return true;
	}
	return 1;

}