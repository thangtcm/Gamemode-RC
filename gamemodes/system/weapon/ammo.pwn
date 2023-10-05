#include <a_samp>
#include <YSI_Coding\y_hooks>
new PlayerAmmo[MAX_PLAYERS][10];
new CraftWeaponDeal[MAX_PLAYERS];
new CraftWeaponDealTime[MAX_PLAYERS];
new weaponzz, ammosdzz;
    // 	// ammo & weapon item
	// {"9mm", "9mm"}, // ammo type = 1
	// {"Sdpistol", "Sdpistol"}, // ammo type = 1
	// {"Deagle", "Deagle"},// ammo type = 1
	// {"Shotgun", "Shotgun"},// ammo type = 2
	// {"Combat Shotgun", "C_shotgun"},// ammo type = 2
	// {"MP5", "MP5"}, /// type 3
	// {"AK47", "AK47"}, // TYPE 4
	// {"M4", "M4"}, // TYPE 4
	// {"Sniper", "Sniper"}, // type 5

	// {"Dan sung luc", "Ammo1"}, // type 5
	// {"Dan Shotgun", "Ammo2"}, // type 5
	// {"Dan Tieu lien", "Ammo3"}, // type 5
	// {"Dan sung truong", "Ammo4"}, // type 5
	// {"Dan Sniper", "Ammo5"}, // type 5

stock GivePlayerAmmoEx(playerid, weapon, Ammo)
{
    switch(weapon)
    {
    	case 22,23,24: {
    	    PlayerAmmo[playerid][ 1 ] += Ammo;
    	    SetPlayerAmmo(playerid, weapon, PlayerAmmo[playerid][ 1 ]);
    	  
    	}
    	case 25,27: {
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
    GetPlayerWeaponData(playerid, 3, weaponzz, ammosdzz);
	if(GetPlayerWeapon(playerid) == 27 && ammosdzz <= 1)
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

stock UseAmmo(playerid,type_ammo,ammo) {
	new string[128];
	switch(type_ammo) {
		case 1: {
			new weapon_g,ammos_g;
			GetPlayerWeaponData(playerid, 2, weapon_g, ammos_g);
            if(weapon_g != 22 && weapon_g != 23 && weapon_g != 24) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung luc' tren nguoi.");
            GivePlayerAmmoEx(playerid, weapon_g, ammo);
            SetPlayerArmedWeapon(playerid, weapon_g);
            //x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x//
            format(string, sizeof(string), "{FF8000}* {C2A2DA}%s dua tay len va lap bang dan vao vu khi.", GetPlayerNameEx(playerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
		}
		case 2: {
			new weapon_g,ammos_g;
			GetPlayerWeaponData(playerid, 3, weapon_g, ammos_g);
            if(weapon_g != 25 && weapon_g != 27) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung Shotgun' tren nguoi.");
            GivePlayerAmmoEx(playerid, weapon_g, ammo);
            SetPlayerArmedWeapon(playerid, weapon_g);
            //x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x//
            format(string, sizeof(string), "{FF8000}* {C2A2DA}%s dua tay len va lap bang dan vao vu khi.", GetPlayerNameEx(playerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
        }
        case 3: {
			new weapon_g,ammos_g;
			GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
            if(weapon_g != 29) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung tieu lien MP5' tren nguoi.");
            GivePlayerAmmoEx(playerid, weapon_g, ammo);
            SetPlayerArmedWeapon(playerid, weapon_g);
            //x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x//
            format(string, sizeof(string), "{FF8000}* {C2A2DA}%s dua tay len va lap bang dan vao vu khi.", GetPlayerNameEx(playerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
        }
        case 4: {
			new weapon_g,ammos_g;
			GetPlayerWeaponData(playerid, 4, weapon_g, ammos_g);
            if(weapon_g != 30 && weapon_g != 31) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung truong' tren nguoi.");
            GivePlayerAmmoEx(playerid, weapon_g, ammo);
            SetPlayerArmedWeapon(playerid, weapon_g);
            //x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x//
            format(string, sizeof(string), "{FF8000}* {C2A2DA}%s dua tay len va lap bang dan vao vu khi.", GetPlayerNameEx(playerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
        }
        case 5: {
			new weapon_g,ammos_g;
			GetPlayerWeaponData(playerid, 5, weapon_g, ammos_g);
            if(weapon_g != 34 ) return SendClientMessage(playerid,-1,"Ban khong so huu vu khi 'Sung Sniper' tren nguoi.");
            GivePlayerAmmoEx(playerid, weapon_g, ammo);
            SetPlayerArmedWeapon(playerid, weapon_g);
            //x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x//
            format(string, sizeof(string), "{FF8000}* {C2A2DA}%s dua tay len va lap bang dan vao vu khi.", GetPlayerNameEx(playerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
        }
	}
	return 1;
}
Dialog:DIALOG_USEAMMO1(playerid, response, listitem, inputtext[]) {
    if(response) {
    	printf("%d so sanh %d",Inventory_Count(playerid, "Dan sung luc") ,strval(inputtext));
    	if(Inventory_Count(playerid, "Dan sung luc") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan sung luc (/inv de kiem tra).");
    	UseAmmo(playerid,1,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sung luc");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}

Dialog:DIALOG_USEAMMO2(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan shotgun") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan Shotgun (/inv de kiem tra).");
    	UseAmmo(playerid,2,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan shotgun");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    }
    return 1;   
}
Dialog:DIALOG_USEAMMO3(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan tieu lien") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan tieu lien (/inv de kiem tra).");
    	UseAmmo(playerid,3,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan tieu lien");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}
Dialog:DIALOG_USEAMMO4(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan sung truong") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong Dan sung truong (/inv de kiem tra).");
    	UseAmmo(playerid,4,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sung truong");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}
Dialog:DIALOG_USEAMMO5(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan sniper") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong Dan sniper (/inv de kiem tra).");
    	UseAmmo(playerid,5,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sniper");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    }  
    return 1; 
}
Dialog:DIALOG_USEAMMO1AS(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan sung luc SAAS") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan sung luc (/inv de kiem tra).");
    	UseAmmo(playerid,1,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sung luc SAAS");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}

Dialog:DIALOG_USEAMMO2AS(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan shotgun SAAS") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan Shotgun (/inv de kiem tra).");
    	UseAmmo(playerid,2,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan shotgun SAAS");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    }
    return 1;   
}
Dialog:DIALOG_USEAMMO3AS(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan tieu lien SAAS") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong dan tieu lien (/inv de kiem tra).");
    	UseAmmo(playerid,3,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan tieu lien SAAS");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}
Dialog:DIALOG_USEAMMO4AS(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan sung truong SAAS") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong Dan sung truong (/inv de kiem tra).");
    	UseAmmo(playerid,4,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sung truong SAAS");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    } 
    return 1;  
}
Dialog:DIALOG_USEAMMO5AS(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(Inventory_Count(playerid, "Dan sniper SAAS") < strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du so luong Dan sniper (/inv de kiem tra).");
    	UseAmmo(playerid,5,strval(inputtext));
    	new pItemId = Inventory_GetItemID(playerid,"Dan sniper SAAS");
		Inventory_Remove(playerid, pItemId, strval(inputtext)); //ID cua InventoryData
    }  
    return 1; 
}
stock GetOderName(type) {
	new type_name[50];
	switch(type) {
		case 0: type_name = "Don hang khong xac dinh";
		case 1: type_name = "Don hang Colt-45";
		case 2: type_name = "Don hang Deagle";
		case 3: type_name = "Don hang Shotgun";
		case 4: type_name = "Don hang Spas-12";
		case 5: type_name = "Don hang MP5";
		case 6: type_name = "Don hang AK47";
		case 7: type_name = "Don hang Sniper";
	}
	return type_name;
}
CMD:crafttest(playerid,params[]) {
	ShowMainCraft(playerid);
	return 1;
}
ShowMainCraft(playerid) {
	Dialog_Show(playerid, CRAFT_MAIN, DIALOG_STYLE_LIST, "Che tao vu khi", "Xem don hang\nDat hang vu khi\nche tao dan","> Chon","Thoat");
}
Dialog:CRAFT_MAIN(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(listitem == 0 ) ShowDealCraft(playerid);
    	if(listitem == 1 ) ShowCraftWeapon(playerid);
    	if(listitem == 2 ) ShowCraftAmmo(playerid);
    }
}
stock ShowDealCraft(playerid) {
	if(CraftWeaponDeal[playerid] == 0) {
		Dialog_Show(playerid, MY_DEALCRAFT, DIALOG_STYLE_MSGBOX, "Che tao vu khi", "Ban khong co don hang nao","> Chon","Thoat");
	}
	else if(CraftWeaponDeal[playerid] != 0) {
		new string[129],button[30];
		format(string,sizeof(string),"Don hang cua ban la: %s\nThoi gian hoan tat don hang: %d giay",GetOderName(CraftWeaponDeal[playerid]), CraftWeaponDealTime[playerid]-gettime() );
		if(gettime() >= CraftWeaponDealTime[playerid]) {
			button = "Nhan hang";
		}
		else {
			format(button,sizeof(button),"> %d giay", CraftWeaponDealTime[playerid]-gettime());
		}
		
		Dialog_Show(playerid, MY_DEALCRAFT, DIALOG_STYLE_MSGBOX, "Che tao vu khi", string,button,"Thoat");
	}
	return 1;
}
stock ShowCraftWeapon(playerid) {
	Dialog_Show(playerid, CRAFT_WEAPON, DIALOG_STYLE_TABLIST_HEADERS, "Che tao vu khi", "Vu khi\tYeu cau\tThoi gian\n\
		        	                                                    #Colt 45\t15 Sat & 10 vat lieu\t15p\n\
		        		                                                #Deagle\t35 Sat & 10 go & 30 vat lieu\t15p\n\
		        		                                                #Shotgun\t30 Sat & 20 go & 25 vat lieu\t30p\n\
		        		                                                #Spas 12\t60 sat & 10 go & 80 vat lieu\t30p\n\
		                                                                #MP5\t50 Sat & 60 vat lieu\t40p\n\
													     				#AK47\t60 Sat & 60 go & 150 vat lieu\t60p\
													                    #Sniper\t150 Sat & 40 go & 280 vat lieu\t120p", "Che tao", "Huy bo");
}
stock ShowCraftAmmo(playerid) {
	Dialog_Show(playerid, CRAFT_AMMO, DIALOG_STYLE_TABLIST_HEADERS, "Che tao dan", "Loai dan\tYeu cau\t#So vien\n\
		        	                                                    #Sung luc\t1 Dong & 1 Thuoc sung\t#10\n\
		        		                                                #Sung Shotgun\t1 Dong & 1 Thuoc sung\t#10\n\
		        		                                                #Sung tieu lien\t2 Dong & 2 Thuoc sung\t#10\n\
		        		                                                #Sung truong\t3 Dong & 3 Thuoc sung\t#10\n\
		                                                                #Sung ngam\t3 Dong & 3 Thuoc sung\t#10\n", "Che tao", "Huy bo");
}


Dialog:MY_DEALCRAFT(playerid, response, listitem, inputtext[]) {
    if(response) {
    	new string[129];
    	if(CraftWeaponDeal[playerid] != 0) {
    		if(gettime() < CraftWeaponDealTime[playerid]) {
    			format(string,sizeof(string),"Thoi gian hoan tat don hang: %d giay, vui long doi",CraftWeaponDealTime[playerid]-gettime() );
    			SendClientMessage(playerid, -1, string);
    			return 1;
    		}
    		else if(gettime() < CraftWeaponDealTime[playerid]) {
    		    format(string,sizeof(string),"Ban da lay don hang %s thanh cong",GetOderName(CraftWeaponDeal[playerid])  );
    		    SendClientMessage(playerid, -1, string);
    		    new pitem_add[30];
    		    switch(CraftWeaponDeal[playerid]) {
    		    	case 0: pitem_add = "";
		            case 1: pitem_add = "9mm";
		            case 2: pitem_add = "Deagle";
		            case 3: pitem_add = "Shotgun";
		            case 4: pitem_add = "Spas";
		            case 5: pitem_add = "MP5";
		            case 6: pitem_add = "AK47";
		            case 7: pitem_add = "Sniper";
    		    }
    		    new pItemId;
    		    pItemId = Inventory_GetItemID(playerid,pitem_add);
		        Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 1, 60*24*2);
		        CraftWeaponDeal[playerid] = 0;
    		}
    	}
    }
    return 1;
}
Dialog:CRAFT_AMMO(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(listitem == 0 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Dong") < 1) return SendClientMessage(playerid, -1, "Ban khong du so luong Dong (1) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Thuoc sung") < 1) return SendClientMessage(playerid, -1, "Ban khong du so luong Thuoc sung (1) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Dong");
		    Inventory_Remove(playerid, pItemId, 1); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Thuoc sung");
		    Inventory_Remove(playerid, pItemId, 1); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Dan sung luc");
		    Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 10, 60*24*2);
		    SendClientMessage(playerid, COLOR_YELLOW, "> Ban da che tao thanh cong 10 vien dan sung luc (-1 dong , -1 thuoc sung).");
    	}
    	if(listitem == 1 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Dong") < 1) return SendClientMessage(playerid, -1, "Ban khong du so luong Dong (1) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Thuoc sung") < 1) return SendClientMessage(playerid, -1, "Ban khong du so luong Thuoc sung (1) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Dong");
		    Inventory_Remove(playerid, pItemId, 1); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Thuoc sung");
		    Inventory_Remove(playerid, pItemId, 1); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Dan shotgun");
		    Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 10, 60*24*2);
		    SendClientMessage(playerid, COLOR_YELLOW, "> Ban da che tao thanh cong 10 vien dan shotgun (-1 dong , -1 thuoc sung).");
    	}
    	if(listitem == 2 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Dong") < 2) return SendClientMessage(playerid, -1, "Ban khong du so luong Dong (2) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Thuoc sung") < 2) return SendClientMessage(playerid, -1, "Ban khong du so luong Thuoc sung (2) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Dong");
		    Inventory_Remove(playerid, pItemId, 2); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Thuoc sung");
		    Inventory_Remove(playerid, pItemId, 2); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Dan tieu lien");
		    Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 10, 60*24*2);
		    SendClientMessage(playerid, COLOR_YELLOW, "> Ban da che tao thanh cong 10 vien Dan tieu lien (-2 dong , -2 thuoc sung).");
    	}
    	if(listitem == 3 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Dong") < 3) return SendClientMessage(playerid, -1, "Ban khong du so luong Dong (3) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Thuoc sung") < 3) return SendClientMessage(playerid, -1, "Ban khong du so luong Thuoc sung (3) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Dong");
		    Inventory_Remove(playerid, pItemId, 3); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Thuoc sung");
		    Inventory_Remove(playerid, pItemId, 3); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Dan sung truong");
		    Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 10, 60*24*2);
		    SendClientMessage(playerid, COLOR_YELLOW, "> Ban da che tao thanh cong 10 vien Dan sung truong (-3 dong , -3 thuoc sung).");
    	}
    	if(listitem == 4 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Dong") < 3) return SendClientMessage(playerid, -1, "Ban khong du so luong Dong (3) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Thuoc sung") < 3) return SendClientMessage(playerid, -1, "Ban khong du so luong Thuoc sung (3) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Dong");
		    Inventory_Remove(playerid, pItemId, 3); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Thuoc sung");
		    Inventory_Remove(playerid, pItemId, 3); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Dan sniper");
		    Inventory_Set(playerid, g_aInventoryItems[pItemId][e_InventoryItem], 10, 60*24*2);
		    SendClientMessage(playerid, COLOR_YELLOW, "> Ban da che tao thanh cong 10 vien Dan sniper (-3 dong , -3 thuoc sung).");
    	}
    }
    return 1;
}
Dialog:CRAFT_WEAPON(playerid, response, listitem, inputtext[]) {
    if(response) {
    	if(listitem == 0 ) {
    		// craft colt 45 15 sat 10 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 15) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (15) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 10) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (10) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 15); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 10); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong Colt-45 , don hang se hoan tat trong 15p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 1;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 15 ) ; // 15p
    	}
        if(listitem == 1 ) {
    		// craft Deagle 35 sat 10 go 30 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 35) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (35) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Go") < 10) return SendClientMessage(playerid, -1, "Ban khong du so luong go (10) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 30) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (30) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 35); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 30); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Go");
		    Inventory_Remove(playerid, pItemId, 10); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong Deagle , don hang se hoan tat trong 15p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 2;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 15 ) ; // 15p
    	}
    	if(listitem == 2 ) {
    		// craft Shotgun 30 sat 20 go 25 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 30) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (30) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Go") < 20) return SendClientMessage(playerid, -1, "Ban khong du so luong go (20) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 25) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (25) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 30); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 20); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Go");
		    Inventory_Remove(playerid, pItemId, 25); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong Shotgun , don hang se hoan tat trong 30p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 3;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 30 ) ; // 15p
    	}
    	if(listitem == 3 ) {
    		// craft Shotgun 30 sat 20 go 25 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 60) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (60) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Go") < 10) return SendClientMessage(playerid, -1, "Ban khong du so luong go (10) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 80) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (80) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 60); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 10); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Go");
		    Inventory_Remove(playerid, pItemId, 80); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong Spas-12 , don hang se hoan tat trong 30p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 4;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 30 ) ; // 15p
    	}
    	if(listitem == 4 ) {
    		// craft Shotgun 30 sat 20 go 25 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 50) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (50) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 60) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (60) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 50); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 60); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong MP5 , don hang se hoan tat trong 40p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 5;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 40 ) ; // 15p
    	}
    	if(listitem == 5 ) {
    		// craft Shotgun 30 sat 20 go 25 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 60) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (60) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Go") < 60) return SendClientMessage(playerid, -1, "Ban khong du so luong go (60) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 150) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (150) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 60); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 150); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Go");
		    Inventory_Remove(playerid, pItemId, 60); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong AK-47 , don hang se hoan tat trong 60p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 6;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 60 ) ; // 
    	}
    	if(listitem == 5 ) {
    		// craft Shotgun 30 sat 20 go 25 vl , 15phut
    		if(Inventory_Count(playerid, "Sat") < 150) return SendClientMessage(playerid, -1, "Ban khong du so luong sat (60) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Go") < 40) return SendClientMessage(playerid, -1, "Ban khong du so luong go (60) (/inv de kiem tra).");
    		if(Inventory_Count(playerid, "Vat lieu") < 280) return SendClientMessage(playerid, -1, "Ban khong du so luong vat lieu (150) (/inv de kiem tra).");
    	    new pItemId = Inventory_GetItemID(playerid,"Sat");
		    Inventory_Remove(playerid, pItemId, 150); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Vat lieu");
		    Inventory_Remove(playerid, pItemId, 280); //ID cua InventoryData
		    pItemId = Inventory_GetItemID(playerid,"Go");
		    Inventory_Remove(playerid, pItemId, 40); //ID cua InventoryData
		    SendClientMessage(playerid, COLOR_YELLOW, "Ban da oder thanh cong Sniper , don hang se hoan tat trong 60p.");
		    SendClientMessage(playerid, COLOR_YELLOW, " > Sau khi don hang hoan tat hay quay lai NPC va nhan hang.");
		    CraftWeaponDeal[playerid] = 7;
		    CraftWeaponDealTime[playerid] = gettime() + ( 60 * 60 ) ; // 15p
    	}
    }  
    return 1; 
}

hook OnGameModeInit() {\
	CreateDynamicPickup(1239, 23, 2306.409179 ,-1569.672607, 1051.562988, -1); // Drug Smuggler Job (TR)
	CreateDynamic3DTextLabel("{FF0000} DRUG LAB \n{FFFFFF}(( BAM Y de mua chat hoa hoc.))", COLOR_WHITE, 2306.409179 ,-1569.672607, 1051.562988 + 0.5, 10.0);// Actor Trucker

	 
}
hook OnPlayerConnect(playerid) {
	CraftWeaponDeal[playerid]= 0;
}