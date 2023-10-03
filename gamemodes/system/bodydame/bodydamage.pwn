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
	new Float:health,Float:armour;
	if((0 <= weaponid <= 46) || weaponid == 54)
    {
        if(BODY_PART_TORSO <= bodypart <= BODY_PART_HEAD) Damage[playerid][(bodypart - 3)][weaponid]++;
    }
    if(issuerid != INVALID_PLAYER_ID)
    {
    	if(GetPVarInt(playerid, "Injured") == 0 && GetPVarInt(playerid, "IsInArena") == -1 && weaponid != 25)
        {
	    	new Float:damage;
			switch(weaponid)
			{
			    case 0:
			    {
			    
			    	damage = 3.0;	
			    }	
				case 1: damage = 6.0;
				case 2, 3, 5, 6, 7, 10, 11, 13, 12, 14, 15: damage = 8.0;
				case 4, 8: damage = 15.0;
				case 9: damage = 13.0;
				case 22:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 13.0;
						}
						case 5,6:
						{
				    	    damage = 9.0;
						}
						case 7,8:
						{
				    	    damage = 11.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
						}
						case 9:
						{
				    	    damage = 18;
						}
					}
				}
				case 23:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 14.5;
						}
						case 5,6:
						{
				    	    damage = 10.0;
						}
						case 7,8:
						{
				    	    damage = 12.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
   						}
						case 9:
						{
				    	    damage = 21;
						}
					}
				}
				case 24:
				{
					GetPlayerHealth(playerid, health);
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 29.5;
						}
						case 5,6:
						{
				    	    damage = 21.5;
						}
						case 7,8:
						{
				    	    damage = 23.0;
				    	    if(BanVaoChan[playerid] == 0)
	                        {
	                            ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
	                            SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
	                            BanVaoChan[playerid] = 1;
	                        }
						}
						case 9:
						{
				    	    damage = 34.5;
						}
					}
				}
			//	case 25: damage = 30.0;
			//	case 27: damage = 34.0;
				case 28:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 10.5;
						}
						case 5,6:
						{
				    	    damage = 7.0;
						}
						case 7,8:
						{
				    	    damage = 8.5;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
						}
						case 9:
						{
				    	    damage = 15;
						}
					}
				}
				case 29:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 14.5;
						}
						case 5,6:
						{
				    	    damage = 10.5;
						}
						case 7,8:
						{
				    	    damage = 12.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
                    	}
						case 9:
						{
				    	    damage = 17;
						}
					}
				}
				case 30:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{

				    	    damage = 20.5;
						}
						case 5,6:
						{
				    	    damage = 16.5;
						}
						case 7,8:
						{
				    	    damage = 18.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
						}
						case 9:
						{
				    	    damage = 27;
						}
					}
				}
				case 31:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{

				    	    damage = 22.5;
						}
						case 5,6:
						{
				    	    damage = 18.0;
						}
						case 7,8:
						{
				    	    damage = 19.5;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
						}
						case 9:
						{
				    	    damage = 30;
						}
					}
				}
				case 32:
		        {
		            switch(bodypart)
		            {
						case 3,4:
						{

				    	    damage = 14.5;
						}
						case 5,6:
						{
				    	    damage = 11.5;
						}
						case 7,8:
						{
				    	    damage = 12.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }
						}
						case 9:
						{
				    	    damage = 18;
						}
					}
				}
				case 33:
				{
					switch(bodypart)
		            {
						case 3,4:
						{

				    	    damage = 35.0;
						}
						case 5,6:
						{
				    	    damage = 29.0;
						}
						case 7,8:
						{
				    	    damage = 32.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            } 
						}
						case 9:
						{
				    	    damage = 60;
						}
					}
				}
				case 34:
				{
		            switch(bodypart)
		            {
						case 3,4:
						{
				    	    damage = 70.0;
						}
						case 5,6:
						{
				    	    damage = 55.0;
						}
						case 7,8:
						{
				    	    damage = 58.0;
				    	    if(BanVaoChan[playerid] == 0)
                            {
                                ApplyAnimation(playerid,"PED","FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
                                SetTimerEx("BiBanChan", 10000, 0, "i", playerid);
                                BanVaoChan[playerid] = 1;
                            }    
						}	
					}
				}
				case 41, 42: damage = 0.1;
			}
			GetPlayerHealth(playerid,health), GetPlayerArmour(playerid,armour);
			if(armour > 0)
			{
				new Float:amoun;
			    amoun = armour - damage;
				if(amoun < 0)
				{
					return SetPlayerHealth(playerid,health-damage);
				}
				else 
				{
					SetPlayerHealth(playerid,health-floatround(damage/2));
					printf("armour < 0 %d -- %d", health-floatround(damage/2), armour-damage);
					return SetPlayerArmour(playerid,armour-damage);
				}	
			}
			else
			{
				SetPlayerHealth(playerid,health-damage);
				printf("health < 0 %d ", health-damage);
			}  	
		}	
    }
    return 0;
}
forward BiBanChan(playerid);
public BiBanChan(playerid)
{
	BanVaoChan[playerid] = 0;
}
GetBodyPartName(bodypart)
{
        new part[11];
        switch(bodypart)
        {
                case BODY_PART_TORSO: part = "nguc";
                case BODY_PART_GROIN: part = "hang";
                case BODY_PART_LEFT_ARM: part = "tay trai";
                case BODY_PART_RIGHT_ARM: part = "tay phai";
                case BODY_PART_LEFT_LEG: part = "chan trai";
                case BODY_PART_RIGHT_LEG: part = "chan phai";
                case BODY_PART_HEAD: part = "dau";
                default: part = "NONE";
        }
        return part;
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

CMD:damages(playerid, params[])
{
        new id;
        if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /damages [playerid]");
        if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Nguoi choi khong hop le.");
        if (!ProxDetectorS(8.0, playerid, id)) return SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Ban khong dung gan nguoi choi.");
        DisplayDamages(playerid, id);
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