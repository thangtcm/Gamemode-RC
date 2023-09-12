#include <a_samp>
#include <YSI\y_hooks>
new PlayerAmmo[MAX_PLAYERS][10];

new weaponzz, ammosdzz;
    
stock GivePlayerAmmoEx(playerid, weapon, Ammo)
{
    switch(weapon)
    {
    	case 22,23,24: {
    	    PlayerAmmo[playerid][ 1 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 1 ]);
    	  
    	}
    	case 25: {
    	    PlayerAmmo[playerid][ 2 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 2 ]);
    	  
    	}
    	case 29: {
    	    PlayerAmmo[playerid][ 3 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 3 ]);
    	 
    	}
    	case 30,31: {
    	    PlayerAmmo[playerid][ 4 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 4 ]);
    	
    	}
    	case 34: {
    	    PlayerAmmo[playerid][ 5 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 5 ]);
    	
    	}
    }
    return 1;
}
stock ResetPlayerWeaponsEx( playerid )
{
	ResetPlayerWeapons(playerid);
	PlayerAmmo[playerid][ 1 ] = 0;
	PlayerAmmo[playerid][ 2 ] = 0;

	PlayerAmmo[playerid][ 3 ] = 0;
	PlayerAmmo[playerid][ 4 ] = 0;
	PlayerAmmo[playerid][ 5 ] = 0;
	PlayerAmmo[playerid][ 6 ] = 0;
	PlayerAmmo[playerid][ 7 ] = 0;
	PlayerAmmo[playerid][ 8 ] = 0;
	PlayerAmmo[playerid][ 9 ] = 0;

	PlayerInfo[playerid][pGuns][ 0 ] = 0;
	PlayerInfo[playerid][pGuns][ 1 ] = 0;
	PlayerInfo[playerid][pGuns][ 2 ] = 0;
	PlayerInfo[playerid][pGuns][ 3 ] = 0;
	PlayerInfo[playerid][pGuns][ 4 ] = 0;
	PlayerInfo[playerid][pGuns][ 5 ] = 0;
	PlayerInfo[playerid][pGuns][ 6 ] = 0;
	PlayerInfo[playerid][pGuns][ 7 ] = 0;
	PlayerInfo[playerid][pGuns][ 8 ] = 0;
	PlayerInfo[playerid][pGuns][ 9 ] = 0;
	PlayerInfo[playerid][pGuns][ 10 ] = 0;
	PlayerInfo[playerid][pGuns][ 11 ] = 0;
	PlayerInfo[playerid][pAGuns][ 0 ] = 0;
	PlayerInfo[playerid][pAGuns][ 1 ] = 0;
	PlayerInfo[playerid][pAGuns][ 2 ] = 0;
	PlayerInfo[playerid][pAGuns][ 3 ] = 0;
	PlayerInfo[playerid][pAGuns][ 4 ] = 0;
	PlayerInfo[playerid][pAGuns][ 5 ] = 0;
	PlayerInfo[playerid][pAGuns][ 6 ] = 0;
	PlayerInfo[playerid][pAGuns][ 7 ] = 0;
	PlayerInfo[playerid][pAGuns][ 8 ] = 0;
	PlayerInfo[playerid][pAGuns][ 9 ] = 0;
	PlayerInfo[playerid][pAGuns][ 10 ] = 0;
	PlayerInfo[playerid][pAGuns][ 11 ] = 0;
	return 1;
}
hook OnPlayerUpdate(playerid) {

    GetPlayerWeaponData(playerid, 2, weaponzz, ammosdzz);
	if(GetPlayerWeapon(playerid) == 22 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 2, weaponzz, ammosdzz);
    if(GetPlayerWeapon(playerid) == 23 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 2, weaponzz, ammosdzz);
    if(GetPlayerWeapon(playerid) == 24 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~wvui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 3, weaponzz, ammosdzz);
	if(GetPlayerWeapon(playerid) == 25 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 4, weaponzz, ammosdzz);
	if(GetPlayerWeapon(playerid) == 29 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 5, weaponzz, ammosdzz);
    if(GetPlayerWeapon(playerid) == 30 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 5, weaponzz, ammosdzz);
    if(GetPlayerWeapon(playerid) == 31 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
    GetPlayerWeaponData(playerid, 6, weaponzz, ammosdzz);
    if(GetPlayerWeapon(playerid) == 34 && ammosdzz <= 1)
	{
        SetPlayerArmedWeapon(playerid, 0);
        SendClientTextDraw(playerid," Vu khi cua ban da~r~ het dan ~w~vui long gan them dan");
    }
}
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(GetPVarInt(playerid, "IsInArena") == -1)
    {
        if(GetPVarInt( playerid, "EventToken") == 0)
        {
            switch(weaponid)
            {
                case 22,23,24: 
                {
                    if(PlayerAmmo[playerid][ 1 ] > 0)
                    {
                        PlayerAmmo[playerid][ 1 ] -= 1;

                    }
                }
                case 25: 
                {
                    if(PlayerAmmo[playerid][ 2 ] > 0)
                    {
                        PlayerAmmo[playerid][ 2 ] -= 1;

                    }
                }
                case 29: 
                {
                    if(PlayerAmmo[playerid][ 3 ] > 0)
                    {
                        PlayerAmmo[playerid][ 3 ] -= 1;

                    }
                }
                case 30,31: 
                {
                    if(PlayerAmmo[playerid][ 4 ] > 0)
                    {
                        PlayerAmmo[playerid][ 4 ] -= 1;

                    }
                }
                case 34: 
                {
                    if(PlayerAmmo[playerid][ 5 ] > 0)
                    {
                        PlayerAmmo[playerid][ 5 ] -= 1;

                    }
                }
            }
        }
    }
    return 1;
}


stock GivePlayerValidWeapon( playerid, WeaponID, Ammo )
{
    #if defined zombiemode
   	if(zombieevent == 1 && GetPVarType(playerid, "pIsZombie")) return SendClientMessageEx(playerid, COLOR_GREY, "Zombies can't have guns.");
	#endif
	switch( WeaponID )
	{
  		case 0, 1:
		{
			PlayerInfo[playerid][pGuns][ 0 ] = WeaponID;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 2, 3, 4, 5, 6, 7, 8, 9:
		{
			PlayerInfo[playerid][pGuns][ 1 ] = WeaponID;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 22, 23, 24:
		{
			PlayerInfo[playerid][pGuns][ 2 ] = WeaponID;
			PlayerAmmo[playerid][ 1 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 25, 26, 27:
		{
			PlayerInfo[playerid][pGuns][ 3 ] = WeaponID;
			PlayerAmmo[playerid][ 2 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 28, 29, 32:
		{
			PlayerInfo[playerid][pGuns][ 4 ] = WeaponID;
			PlayerAmmo[playerid][ 3 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 30, 31:
		{
			PlayerInfo[playerid][pGuns][ 5 ] = WeaponID;
		    PlayerAmmo[playerid][ 4 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 33, 34:
		{
			PlayerInfo[playerid][pGuns][ 6 ] = WeaponID;
			PlayerAmmo[playerid][ 5 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 35, 36, 37, 38:
		{
			PlayerInfo[playerid][pGuns][ 7 ] = WeaponID;
			PlayerAmmo[playerid][ 6 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 16, 17, 18, 39, 40:
		{
			PlayerInfo[playerid][pGuns][ 8 ] = WeaponID;
			PlayerAmmo[playerid][ 7 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 41, 42, 43:
		{
			PlayerInfo[playerid][pGuns][ 9 ] = WeaponID;
			PlayerAmmo[playerid][ 8 ] = Ammo;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 10, 11, 12, 13, 14, 15:
		{
			PlayerInfo[playerid][pGuns][ 10 ] = WeaponID;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
		case 44, 45, 46:
		{
			PlayerInfo[playerid][pGuns][ 11 ] = WeaponID;
			GivePlayerWeapon( playerid, WeaponID, Ammo );
		}
	}
	return 1;
}

stock SetPlayerWeapons(playerid)
{
    if(GetPVarInt(playerid, "IsInArena") >= 0) { return 1; }
	ResetPlayerWeapons(playerid);
	{
		if(PlayerInfo[playerid][pGuns][0] > 0 && PlayerInfo[playerid][pAGuns][0] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][0], 60000);
		}
		if(PlayerInfo[playerid][pGuns][1] > 0 && PlayerInfo[playerid][pAGuns][1] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][1], 60000);
		}
		if(PlayerInfo[playerid][pGuns][2] > 0 && PlayerInfo[playerid][pAGuns][2] == 0 && PlayerAmmo[playerid][1] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][2], PlayerAmmo[playerid][1]);
		}
		if(PlayerInfo[playerid][pGuns][3] > 0 && PlayerInfo[playerid][pAGuns][3] == 0 && PlayerAmmo[playerid][2] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][3], PlayerAmmo[playerid][2]);
		}
		if(PlayerInfo[playerid][pGuns][4] > 0 && PlayerInfo[playerid][pAGuns][4] == 0 && PlayerAmmo[playerid][3] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][4], PlayerAmmo[playerid][3]);
		}
		if(PlayerInfo[playerid][pGuns][5] > 0 && PlayerInfo[playerid][pAGuns][5] == 0 && PlayerAmmo[playerid][4] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][5], PlayerAmmo[playerid][4]);
		}
		if(PlayerInfo[playerid][pGuns][6] > 0 && PlayerInfo[playerid][pAGuns][6] == 0 && PlayerAmmo[playerid][5] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][6], PlayerAmmo[playerid][5]);
		}
		if(PlayerInfo[playerid][pGuns][7] > 0 && PlayerInfo[playerid][pAGuns][7] == 0 && PlayerAmmo[playerid][6] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][7], PlayerAmmo[playerid][6]);
		}
		if(PlayerInfo[playerid][pGuns][8] > 0 && PlayerInfo[playerid][pAGuns][8] == 0 && PlayerAmmo[playerid][7] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][8], PlayerAmmo[playerid][7]);
		}
		if(PlayerInfo[playerid][pGuns][9] > 0 && PlayerInfo[playerid][pAGuns][9] == 0 && PlayerAmmo[playerid][8] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][9], PlayerAmmo[playerid][8]);
		}
		if(PlayerInfo[playerid][pGuns][10] > 0 && PlayerInfo[playerid][pAGuns][10] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][10], 60000);
		}
		if(PlayerInfo[playerid][pGuns][11] > 0 && PlayerInfo[playerid][pAGuns][11] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][11], 60000);
		}
	}
	return 1;
}

stock SetPlayerWeaponsEx(playerid)
{
	ResetPlayerWeapons(playerid);
	{
		if(PlayerInfo[playerid][pGuns][0] > 0 && PlayerInfo[playerid][pAGuns][0] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][0], 60000);
		}
		if(PlayerInfo[playerid][pGuns][1] > 0 && PlayerInfo[playerid][pAGuns][1] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][1], 60000);
		}
		if(PlayerInfo[playerid][pGuns][2] > 0 && PlayerInfo[playerid][pAGuns][2] == 0 && PlayerAmmo[playerid][1] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][2], PlayerAmmo[playerid][1]);
		}
		if(PlayerInfo[playerid][pGuns][3] > 0 && PlayerInfo[playerid][pAGuns][3] == 0 && PlayerAmmo[playerid][2] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][3], PlayerAmmo[playerid][2]);
		}
		if(PlayerInfo[playerid][pGuns][4] > 0 && PlayerInfo[playerid][pAGuns][4] == 0 && PlayerAmmo[playerid][3] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][4], PlayerAmmo[playerid][3]);
		}
		if(PlayerInfo[playerid][pGuns][5] > 0 && PlayerInfo[playerid][pAGuns][5] == 0 && PlayerAmmo[playerid][4] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][5], PlayerAmmo[playerid][4]);
		}
		if(PlayerInfo[playerid][pGuns][6] > 0 && PlayerInfo[playerid][pAGuns][6] == 0 && PlayerAmmo[playerid][5] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][6], PlayerAmmo[playerid][5]);
		}
		if(PlayerInfo[playerid][pGuns][7] > 0 && PlayerInfo[playerid][pAGuns][7] == 0 && PlayerAmmo[playerid][6] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][7], PlayerAmmo[playerid][6]);
		}
		if(PlayerInfo[playerid][pGuns][8] > 0 && PlayerInfo[playerid][pAGuns][8] == 0 && PlayerAmmo[playerid][7] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][8], PlayerAmmo[playerid][7]);
		}
		if(PlayerInfo[playerid][pGuns][9] > 0 && PlayerInfo[playerid][pAGuns][9] == 0 && PlayerAmmo[playerid][8] > 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][9], PlayerAmmo[playerid][8]);
		}
		if(PlayerInfo[playerid][pGuns][10] > 0 && PlayerInfo[playerid][pAGuns][10] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][10], 60000);
		}
		if(PlayerInfo[playerid][pGuns][11] > 0 && PlayerInfo[playerid][pAGuns][11] == 0)
		{
			GivePlayerValidWeapon(playerid, PlayerInfo[playerid][pGuns][11], 60000);
		}
	}
	SetPlayerArmedWeapon(playerid, GetPVarInt(playerid, "LastWeapon"));
}

