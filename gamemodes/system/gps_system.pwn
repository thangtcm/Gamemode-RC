#include <a_samp>
#include <YSI\y_hooks>



stock GetJobFind(z) {
	new jobnamez[80];
	switch(z) {
		case 0:	jobnamez = "Truck container (Van chuyen hang hoa)";
		case 1:	jobnamez = "Pizza Deliver (Giao Pizza)";
		case 2:	jobnamez = "Lumberjack (Chat go)";
		case 3:	jobnamez = "Hai trai cay";
		case 4:	jobnamez = "Dao da";
	}
	return jobnamez;
}  
stock GetZoneFind(z) {
	new gaga[70];
	switch(z) {
		case 0:	gaga = "Khu mua sam ( Market )";
		case 1:	gaga = "Tru so canh sat";
		case 2:	gaga = "City hall";
		case 3:	gaga = "Benh vien Jefferson";
		case 4:	gaga = "Benh vien Market";
		case 5:	gaga = "Cay xang idlewood";
		case 6:	gaga = "Tiem sua xe idlewood";
		case 7:	gaga = "Cua hang quan ao Ganton";
		case 8:	gaga = "Nha tho LS";
		case 9:	gaga = "Cong vien Glen park";
		case 10: gaga = "Ngan hang ( LS Bank )";
		case 11: gaga = "Toa soan LS ( LS News )";
	}
	return gaga;
}  

new Float:timduong_postion[12][3] = {
{1131.4810,-1460.3645,15.7969}, // market
{1554.1970,-1676.1125,16.1953}, // lspd
{1481.6774,-1771.9591,18.7958}, //  city hall
{2025.2477,-1402.8911,17.2098}, // benh vien jefferson
{1172.5953,-1323.5767,15.4035}, // benh vien market
{1833.3245,-1842.6456,13.5781}, // cay xang idlewood
{2156.1599,-1738.0543,13.5572},//  tiem sua xe idlewood
{2238.3289,-1663.8582,15.4766}, // cua hang quan ao ganton
{2232.0986,-1333.0348,23.9815}, // nha tho LS
{1971.5248,-1202.0349,25.5789}, // cong vien glen park
{1457.3000,-1011.9067,26.8438}, // ngan hang ls
{765.9731,-1370.3962,13.5182} // toa soan ls
};

new Float:timvieclam_postion[5][3] = {
{2507.7554,-2120.0732,13.5469},
{ 2098.5432,-1800.6925,13.3889},
{-543.2013,-197.4136,78.4063},
{1942.4304,164.3992,37.2813},
{581.6000,939.5470,-42.6158}
};
CMD:gps(playerid, params[])
{
	if(Inventory_HasItem(playerid, "GPS"))
	{
	    if(PlayerInfo[playerid][pSudungGPS] == 0) return ShowPlayerDialog(playerid, GPS_SYSTEM, DIALOG_STYLE_LIST, "GPS SYSTEM", "Xac dinh vi tri\nTim cong viec\nTim dia diem\n{357c5a}Bat GPS", "Chon", "Huy");
	    if(PlayerInfo[playerid][pSudungGPS] == 1) return ShowPlayerDialog(playerid, GPS_SYSTEM, DIALOG_STYLE_LIST, "GPS SYSTEM", "Xac dinh vi tri\nTim cong viec\nTim dia diem\n{813027}Tat GPS", "Chon", "Huy");
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
			if(listitem == 2)
			{
			    new stringz[1029];
				stringz = "Dia diem\tKhu vuc\tKhoang cach";
				for(new z =0 ; z < 12 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2]);
				    Get3DZone(timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2], zone, sizeof(zone));
				    format(stringz, sizeof stringz, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", stringz,GetZoneFind(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMDUONG, DIALOG_STYLE_TABLIST_HEADERS, "Tim duong",stringz,"Chon", "Huy");
			}
			if(listitem == 3)
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
			if(listitem == 3)
			{
			    return cmd_timduongadsads(playerid, "");
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
