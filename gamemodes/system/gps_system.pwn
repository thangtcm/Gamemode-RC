#include <a_samp>
#include <YSI_Coding\y_hooks>


stock GetJobFind(z) {
	new jobnamez[80];
	switch(z) {
		case 0:	jobnamez = "Pizza";
		case 1:	jobnamez = "Chat go";
		case 2:	jobnamez = "Miner";
		case 3:	jobnamez = "Cau ca";
		case 4:	jobnamez = "Trashman";
		case 5:	jobnamez = "Farmer";
		case 6:	jobnamez = "Trucker";
	}
	return jobnamez;
}  
stock _GetJobLevel(z) {
	new jobnamez[80];
	switch(z) {
		case 0:	jobnamez = "{74C36D}De{FFFFFF}";
		case 1:	jobnamez = "{74C36D}De{FFFFFF}";
		case 2:	jobnamez = "{74C36D}De{FFFFFF}";
		case 3:	jobnamez = "{74C36D}De{FFFFFF}";
		case 4:	jobnamez = "{C3AE6D}Trung binh{FFFFFF}";
		case 5:	jobnamez = "{C36D6F}Kho{FFFFFF}";
		case 6:	jobnamez = "{C36D6F}Kho{FFFFFF}";
	}
	return jobnamez;
}  

stock GetZoneFind(zxc) {
	new gagaz[70];
	switch(zxc) {
		case 0:	gagaz = "Pizza Stack";
		case 1:	gagaz = "City Hall";
		case 2:	gagaz = "Los Santos Police Department";
		case 3:	gagaz = "Benh vien";
		case 4:	gagaz = "Thi bang lai";
		case 5:	gagaz = "Mechanic";
		case 6:	gagaz = "Market";
		case 7:	gagaz = "Bank";
		case 8:	gagaz = "Casino";
	}
	return gagaz;
}  


new Float:timduong_postion[9][3] = {
{2105.4880,-1806.4644,13.5547},
{1771.2756,-1720.7433,13.5469},
{1536.9640,-1675.3302,13.3828},
{1996.8729,-1451.2161,13.5547},
{1111.3508, -1792.6451, 16.5938},
{2156.6877,-1742.6599,13.5469},
{1128.9858,-1410.5420,13.4592},
{1457.4771,-1137.7878,23.9846},
{1567.7627,-1897.5450,13.5608}
};
new Float:timvieclam_postion[7][3] = {
{2098.1018,-1801.5461,13.3828},
{2357.5962,-652.2203,128.0547},
{960.7295,-2143.3628,13.0938,},
{391.1583,-2088.2068,7.8359},
{2206.3513,-2024.8339,13.5469},
{-292.8786,-1412.1246,12.7305},
{2446.3665,-2100.4600,13.546}
};
CMD:gps(playerid, params[])
{
	if(Inventory_HasItem(playerid, "GPS"))
	{
	    ShowPlayerDialog(playerid, GPS_SYSTEM, DIALOG_STYLE_LIST, "GPS SYSTEM", "Tim dia diem", "Chon", "Huy");
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
		new szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN], string[2000];
		GetPlayerGroupInfo(playerid, szRank, szDivision, szEmployer);
		switch(listitem)
		{
			case 0:
			{
				string = "Dia diem\tKhu vuc\tKhoang cach";
				for(new z =0 ; z < 9 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2]);
				    Get3DZone(timduong_postion[z][0], timduong_postion[z][1], timduong_postion[z][2], zone, sizeof(zone));
				    format(string, sizeof string, "%s\n\%s\t{6db4c3}%s\t{3cab4e}%0.2f met", string,GetZoneFind(z),zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMDUONG, DIALOG_STYLE_TABLIST_HEADERS, "Tim duong",string,"Chon", "Huy");
			}
			case 1:
			{
				string = "Cong viec\tMuc do\tDia diem\tKhoang cach";
				for(new z =0 ; z < 7 ; z++ ) 
				{
					new zone[MAX_ZONE_NAME],Float:Distance;
					Distance = GetPlayerDistanceFromPoint(playerid, timvieclam_postion[z][0], timvieclam_postion[z][1], timvieclam_postion[z][2]);
				    Get3DZone(timvieclam_postion[z][0], timvieclam_postion[z][1], timvieclam_postion[z][2], zone, sizeof(zone));
				    format(string, sizeof string, "%s\n\%s\t%s\t{6db4c3}%s\t{3cab4e}%0.2f met", string,GetJobFind(z),_GetJobLevel(z), zone,Distance);
				}
				ShowPlayerDialog(playerid, TIMVIECLAM, DIALOG_STYLE_TABLIST_HEADERS, "Tim viec lam",string,"Chon", "Huy");
			}
		
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
				Dialog_Show(playerid, GPSPosition, DIALOG_STYLE_LIST, "GPS SYSTEM", "Tim duong\nCong viec", "Lua chon", "Huy bo");
			}
	
        }
    }
    if(dialogid == TIMVIECLAM)
	{
	    if(response)
	    {
	       	SetPlayerCheckPointEx(playerid,timvieclam_postion[listitem][0], timvieclam_postion[listitem][1], timvieclam_postion[listitem][2],3);
	       	CP[playerid] = 252000;
		}
	}

	if(dialogid == TIMDUONG)
	{
	    if(response)
	    {
	       	SetPlayerCheckPointEx(playerid,timduong_postion[listitem][0], timduong_postion[listitem][1], timduong_postion[listitem][2],3);
	       	CP[playerid] = 252000;
		}
	}
	return 1;
}
