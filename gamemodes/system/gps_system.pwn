#include <a_samp>
#include <YSI_Coding\y_hooks>



stock GetJobFind(z) {
	new jobnamez[80];
	switch(z) {
		case 0:	jobnamez = "Pizza RC";
		case 1:	jobnamez = "Pizza Bluberry";
		case 2:	jobnamez = "Trucker";
		case 3:	jobnamez = "Miner";
		case 4:	jobnamez = "Farm";
	}
	return jobnamez;
}  
stock GetZoneFind(z) {
	new gaga[70];
	switch(z) {
		case 0:	gaga = "Thi tran Montgomery";
		case 1:	gaga = "Thi tran Blue Berry";
		case 2:	gaga = "Thi tran Dillimore";
		case 3:	gaga = "Thi tran Palomino Creek";
	}
	return gaga;
}  
<<<<<<< HEAD
=======
stock GetZoneFindx(z) {
	new gaga[70];
	switch(z) {
		case 0:	gaga = "Bank RC";
		case 1:	gaga = "Bank Bluberry";
		case 2:	gaga = "Bank Dillimore";
		case 3:	gaga = "Bank palomino";
	}
	return gaga;
} 
stock GetZoneFindy(z) {
	new gaga[70];
	switch(z) {
		case 0:	gaga = "Pizza RC";
		case 1:	gaga = "24/7 RC";
		case 2:	gaga = "Xe RC";
		case 3:	gaga = "Quan ao RC";
	}
	return gaga;
} 
>>>>>>> main
stock GetZoneFindz(zxc) {
	new gagaz[70];
	switch(zxc) {
		case 0:	gagaz = "Tru so canh sat";
		case 1:	gagaz = "Benh vien";
		case 2:	gagaz = "City Hall";
	}
	return gagaz;
}  
<<<<<<< HEAD

=======
new Float:timbank_postion[4][3] = {
{1373.5576,405.0259,19.9555},
{207.9119,-61.7973,1.9766},
{694.9058,-500.1317,16.3359},
{2303.8279,-16.1507,26.4844} 
};
new Float:timstore_postion[4][3] = {
{1367.5760,248.1629,19.5669},
{1359.8734,204.9854,19.7555},
{1242.3909,211.3994,19.5547},
{1277.0188,370.8625,19.5547} 
};
>>>>>>> main
new Float:timduong_postion[4][3] = {
{1289.2391,248.9346,19.4063},
{233.1081,-211.2786,1.4300},
{682.8105,-529.9641,16.1883},
{2343.8049,90.8922,26.3327} 
};
new Float:diadiemkhac_postion[3][3] = {
{636.3668,-571.8013,16.3359},
{1247.7277,338.8819,19.4063},
{447.7277,238.8819,19.4063}
};
new Float:timvieclam_postion[5][3] = {
{1363.0930,253.7802,19.5669},
{206.2160,-202.2273,1.5781},
{58.6224,-291.5815,1.5781},
{588.0701,865.1739,-43.5557},
{-1420.5599,-1474.9758,101.6378}
};
CMD:gps(playerid, params[])
{
	if(Inventory_HasItem(playerid, "GPS"))
	{
	    if(PlayerInfo[playerid][pSudungGPS] == 0) return ShowPlayerDialog(playerid, GPS_SYSTEM, DIALOG_STYLE_LIST, "GPS SYSTEM", "Xac dinh vi tri\nTim dia diem\n{357c5a}Bat GPS", "Chon", "Huy");
	    if(PlayerInfo[playerid][pSudungGPS] == 1) return ShowPlayerDialog(playerid, GPS_SYSTEM, DIALOG_STYLE_LIST, "GPS SYSTEM", "Xac dinh vi tri\nTim dia diem\n{813027}Tat GPS", "Chon", "Huy");
	    return 1;
    }
    else
    {
    	SendErrorMessage(playerid," Ban khong co GPS");
    }
    return 1;
}
CMD:dunggps(playerid, params[])
{
	if(PlayerInfo[playerid][pGPS] >= 1)
	{
	 

	    PlayerInfo[playerid][pSudungGPS] = 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Ban khong co GPS");
	}
	return 1;
}
Dialog:GPSPosition(playerid, response, listitem, inputtext[])
{
	if(response)
	{
<<<<<<< HEAD
		new wepget[20], string[256], szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN];
=======
		new szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN];
>>>>>>> main
		GetPlayerGroupInfo(playerid, szRank, szDivision, szEmployer);
		switch(listitem)
		{
			case 0:
			{
			    new stringz[1029];
				stringz = "Dia diem\tKhu vuc\tKhoang cach";
				for(new z =0 ; z < 4 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2]);
				    Get3DZone(timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetZoneFind(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMDUONG, DIALOG_STYLE_TABLIST_HEADERS, "Tim duong",stringz,"Chon", "Huy");
			}
			case 1:
			{
				new stringz[1029];
				stringz = "Cong viec\tDia diem\tKhoang cach";
				for(new z =0 ; z < 5 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timvieclam_postion[z][0], timvieclam_postion[z][1], timvieclam_postion[z][2]);
				    Get3DZone(timvieclam_postion[z][0], timvieclam_postion[z][1], timvieclam_postion[z][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetJobFind(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMVIECLAM, DIALOG_STYLE_TABLIST_HEADERS, "Tim viec lam",stringz,"Chon", "Huy");
			}
<<<<<<< HEAD
			case 2: return 1;
			case 3: return 1;
=======
			case 2:
			{
				new stringz[1029];
				stringz = "Ngan hang\tDia diem\tKhoang cach";
				for(new z =0 ; z < 5 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timbank_postion[z][0], timbank_postion[z][1], timbank_postion[z][2]);
				    Get3DZone(timbank_postion[z][0], timbank_postion[z][1], timbank_postion[z][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetZoneFindx(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMVIECLAM, DIALOG_STYLE_TABLIST_HEADERS, "Tim viec lam",stringz,"Chon", "Huy");
			}
			case 3:
			{
				new stringz[1029];
				stringz = "Cua hang\tDia diem\tKhoang cach";
				for(new z =0 ; z < 5 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timstore_postion[z][0], timstore_postion[z][1], timstore_postion[z][2]);
				    Get3DZone(timstore_postion[z][0], timstore_postion[z][1], timstore_postion[z][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetZoneFindy(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMVIECLAM, DIALOG_STYLE_TABLIST_HEADERS, "Tim viec lam",stringz,"Chon", "Huy");
			}
>>>>>>> main
			case 4:
			{
			    new stringz[1029];
				stringz = "Dia diem\tKhu vuc\tKhoang cach";
				for(new zxc =0 ; zxc < 3 ; zxc++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, diadiemkhac_postion[zxc][0], diadiemkhac_postion[zxc][1], diadiemkhac_postion[zxc][2]);
				    Get3DZone(diadiemkhac_postion[zxc][0], diadiemkhac_postion[zxc][1], diadiemkhac_postion[zxc][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetZoneFindz(zxc),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMDUONG, DIALOG_STYLE_TABLIST_HEADERS, "Tim duong",stringz,"Chon", "Huy");
			}
			case 5: return cmd_home(playerid, "");
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

 	if(dialogid == GPS_SYSTEM)
	{
 		if(response)
		{
			if(listitem == 0)
			{
			  	BatGPS(playerid);
			}
			if(listitem == 1)
			{
				Dialog_Show(playerid, GPSPosition, DIALOG_STYLE_LIST, "Chon dia diem can tim", "Thi tran\nCong Viec\nNgan hang\nStore\nDia diem khac\nMy house", "Lua chon", "Huy bo");
			}
			if(listitem == 2)
			{
			    if( PlayerInfo[playerid][pSudungGPS] == 0)
                {
                	SendClientMessageEx(playerid, COLOR_YELLOW,"Ban da bat GPS thanh cong");
	   	  	  	    PlayerInfo[playerid][pSudungGPS] = 1;
	  	        }
 	  	  	    else if( PlayerInfo[playerid][pSudungGPS] == 1)
                {
                	SendClientMessageEx(playerid, COLOR_YELLOW,"Ban da tat GPS thanh cong");
   	  	  	  	    PlayerInfo[playerid][pSudungGPS] = 0;
 	  	  	    }
			    return 1;
			}
			// return cmd_timduong(playerid, "");
        }
    }
    if(dialogid == TIMVIECLAM)
	{
	    if(response)
	    {
	       	SetPlayerCheckpoint(playerid,timvieclam_postion[listitem][0], timvieclam_postion[listitem][1], timvieclam_postion[listitem][2],3);
	       	CP[playerid] = 252000;
		}
	}

	if(dialogid == TIMDUONG)
	{
	    if(response)
	    {
	       	SetPlayerCheckpoint(playerid,timduong_postion[listitem][0], timduong_postion[listitem][1], timduong_postion[listitem][2],3);
	       	CP[playerid] = 252000;
		}
	}
	return 1;
}
