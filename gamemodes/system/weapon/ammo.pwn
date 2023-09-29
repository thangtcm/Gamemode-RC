#include <a_samp>
#include <YSI_Coding\y_hooks>
new PlayerAmmo[MAX_PLAYERS][10];

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