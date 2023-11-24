        

#define DS_LIST DIALOG_STYLE_LIST
#define DS_TABLIST DIALOG_STYLE_TABLIST
#define DS_HEADERS DIALOG_STYLE_TABLIST_HEADERS
#define DS_MSGBOX DIALOG_STYLE_MSGBOX
#define DS_INPUT DIALOG_STYLE_INPUT
#define DS_PASS DIALOG_STYLE_PASSWORD

#define function%0(%1) forward%0(%1); public%0(%1)

#define D_MSGBOX 1233

#define D_JTM_JOBLIST 1234
#define D_JTM_GET 1235
#define D_JTM_INFO 1236
#define D_JTM_QUIT 1237

#define D_JTM_RENTLIST 1238
#define D_JTM_RENT 1239
#define D_JTM_RINFO 1240
#define D_JTM_UNRENT 1241

#define TM_PICKUPJOB 1997.8,-2091.8,13.8
#define TM_PICKUPRENT 2102.6001,-2087,13.8
#define TM_PICKUPTAICHE 2098.5,-2029.4000244141,13.7
#define TM_CPRECYCLE 2070.3999023438,-2057.1000976562,13.5

#include <YSI_Coding\y_hooks>
#include <streamer>

new player_Job[MAX_PLAYERS]; // TUY CHINH CHO NAY NHE
new jobskill_Trashman[MAX_PLAYERS]; // KI NANG CONG VIEC (CO THE XOA DI)

new tm_RentTime[MAX_PLAYERS]; // Thoi gian thue xe
new tm_RentTimer[MAX_PLAYERS]; // Timer
new tm_TrashTimer[MAX_PLAYERS][2];
new tm_Rented[MAX_PLAYERS]; // Da thue xe
new tm_RentVeh[MAX_PLAYERS]; // ID Vehicle
new tm_RentOwner[MAX_PLAYERS]; // Chu xe (tranh tinh trang lay xe)
new Text3D:tm_OwnerLabel[MAX_PLAYERS];
new tm_DynamicCP[MAX_PLAYERS];
new tm_Pickup[3]; // Pickup Models
new Text3D:tm_Label[3]; // 3D Text label
new tm_Onduty[MAX_PLAYERS]; // Dang lam viec
new tm_BinNum[MAX_PLAYERS]; // So thu tu cua thung rac
new tm_Amount[MAX_PLAYERS]; // So luong rac tren xe
new tm_Holding[MAX_PLAYERS]; // So luong rac dang mang theo

stock IsPlayerJobTrashman(playerid)
{
	if(!strcmp(player_Job[playerid], "Trashman")) return true;
	if(strcmp(player_Job[playerid], "Trashman")) return false;
	return 1;
}

stock IsTrashmasterOwner(playerid)
{
	new plname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, plname, sizeof plname);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!strcmp(plname, tm_RentOwner[i])) return true;
		if(strcmp(plname, tm_RentOwner[i])) return false;
	}
	return 1;
}

stock IsPlayerNearVehicle(playerid, vehid)
{
	new Float:vx,Float:vy,Float:vz;
	GetVehiclePos(tm_RentVeh[playerid], vx, vy, vz);
	if(IsPlayerInRangeOfPoint(playerid, 5, vx, vy, vz)) return true;
	else return false;
}

stock timec(time) // Bo chuyen doi thoi gian
{
	new jhour;
    new jmin;
	new jdiv;
    new jsec;
    new string[128];
	if(time > 3599){
		jhour = floatround(time / (60*60));
		jdiv = floatround(time % (60*60));
        jmin = floatround(jdiv / 60, floatround_floor);
        jsec = floatround(jdiv % 60, floatround_ceil);
        format(string,sizeof(string),"%02d gio, %02d phut, %02d giay",jhour,jmin,jsec);
    }
    else if(time > 59 && time < 3600){
        jmin = floatround(time/60);
        jsec = floatround(time - jmin*60);
        format(string,sizeof(string),"%02d phut, %02d giay",jmin,jsec);
    }
    else
	{
        jsec = floatround(time);
        format(string,sizeof(string),"%02d giay",jsec);
    }
    return string;
}

hook OnGameModeInit()
{
	tm_Pickup[0] = CreatePickup(1210, 1, TM_PICKUPJOB, 0); // Nhan viec
	tm_Pickup[1] = CreatePickup(1239, 1, TM_PICKUPRENT, 0); // Thue xe
	tm_Pickup[2] = CreatePickup(1239, 1, TM_PICKUPTAICHE, 0); // Tai che rac

	tm_Label[0] = Create3DTextLabel("Cong viec: Trashman\nBam Y", COLOR_YELLOW, TM_PICKUPJOB+0.7, 20, 0, 0);
	tm_Label[1] = Create3DTextLabel("Noi thue xe Trashmaster\nBam Y", COLOR_YELLOW, TM_PICKUPRENT+0.7, 20, 0, 0);
	tm_Label[2] = Create3DTextLabel("Noi tai che rac thai\nBam N", COLOR_YELLOW, TM_PICKUPTAICHE+0.7, 20, 0, 0);

	new tmpobjid[33];
	tmpobjid[0] = CreateObject(1227, 1841.566406, -1575.821044, 13.386780, 0.000000, 0.000000, 54.700000, 300.00); 
	tmpobjid[1] = CreateObject(1343, 1840.121459, -1577.330810, 13.309167, 0.000000, 0.000000, 74.099998, 300.00); 
	tmpobjid[2] = CreateObject(1331, 1832.890747, -1888.642578, 13.057359, 0.000000, 0.000000, 180.000000, 300.00); 
	tmpobjid[3] = CreateObject(1334, 2097.398437, -1830.941406, 13.434690, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[4] = CreateObject(1343, 2099.644531, -1830.808227, 13.294692, 0.000000, 0.000000, -16.500001, 300.00); 
	tmpobjid[5] = CreateObject(1343, 2228.219726, -1715.608886, 13.232681, 0.000000, 0.000000, -90.499977, 300.00); 
	tmpobjid[6] = CreateObject(1343, 2228.122802, -1714.378173, 13.232681, 0.000000, 0.000000, -149.799987, 300.00); 
	tmpobjid[7] = CreateObject(1227, 2423.055175, -2103.061279, 13.343847, 0.000000, 0.000000, 90.000000, 300.00); 
	tmpobjid[8] = CreateObject(1265, 2423.059082, -2101.273193, 13.043842, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[9] = CreateObject(1265, 2422.716308, -2100.377685, 13.043842, 0.000000, 0.000000, 107.100006, 300.00); 
	tmpobjid[10] = CreateObject(1358, 2400.833007, -2060.825439, 13.711330, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[11] = CreateObject(1370, 2397.917724, -2060.101318, 13.026065, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[12] = CreateObject(1370, 2398.616699, -2061.253417, 13.026065, 0.000000, 0.000000, -59.799995, 300.00); 
	tmpobjid[13] = CreateObject(1415, 2377.281738, -2064.068603, 12.479784, 0.000000, 0.000000, 90.000000, 300.00); 
	tmpobjid[14] = CreateObject(1343, 1947.160522, -1796.824707, 13.292821, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[15] = CreateObject(1343, 1945.874145, -1796.534667, 13.292821, 0.000000, 0.000000, -36.400001, 300.00); 
	tmpobjid[16] = CreateObject(2674, 1948.544677, -1796.353515, 12.576875, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[17] = CreateObject(1334, 1788.982910, -1625.164550, 13.370903, 0.000000, 0.000000, 180.000000, 300.00); 
	tmpobjid[18] = CreateObject(1265, 1786.892578, -1625.326049, 12.868711, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[19] = CreateObject(1265, 1785.671875, -1625.326049, 12.868711, 0.000000, 0.000000, -45.699996, 300.00); 
	tmpobjid[20] = CreateObject(1440, 1792.029418, -1625.339965, 12.999876, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[21] = CreateObject(1343, 1538.788574, -1613.887695, 13.306889, 0.000000, 0.000000, 270.000000, 300.00); 
	tmpobjid[22] = CreateObject(1343, 1538.788574, -1614.908447, 13.306889, 0.000000, 0.000000, -82.700096, 300.00); 
	tmpobjid[23] = CreateObject(1328, 1538.901855, -1616.172729, 13.066881, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[24] = CreateObject(2671, 1538.061767, -1614.527954, 12.576875, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[25] = CreateObject(12957, 1626.176513, -1701.400512, 12.929704, 0.000000, 0.000000, 180.000000, 300.00); 
	tmpobjid[26] = CreateObject(3035, 1624.942504, -1695.945190, 12.949721, 0.000000, 0.000000, 90.000000, 300.00); 
	tmpobjid[27] = CreateObject(1265, 1625.995239, -1701.479736, 13.088589, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[28] = CreateObject(849, 1625.586669, -1704.813354, 12.669124, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[29] = CreateObject(1343, 1186.371826, -1369.634887, 13.259169, 0.000000, 0.000000, 77.099998, 300.00); 
	tmpobjid[30] = CreateObject(1372, 1186.423217, -1371.264160, 12.587800, 0.000000, 0.000000, -88.699897, 300.00); 
	tmpobjid[31] = CreateObject(2059, 1186.264404, -1372.179321, 12.586634, 0.000000, 0.000000, 0.000000, 300.00); 
	tmpobjid[32] = CreateObject(2059, 1186.342529, -1373.463378, 12.586634, 0.000000, 0.000000, 81.900077, 300.00); 
	return 1;
}

hook OnGameModeExit()
{
	for(new i = 0; i < 4; i++)
	{
		DestroyPickup(tm_Pickup[i]);
		Delete3DTextLabel(tm_Label[i]);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, TM_PICKUPJOB))
		{
			ShowPlayerDialog(playerid, D_JTM_JOBLIST, DS_LIST, "CONG VIEC: Trashman",
			"Nhan cong viec nay\n\
			Gioi thieu ve cong viec\n\
			Nghi cong viec nay", "Chon", "Huy");
		}
	}
	if(newkeys == KEY_YES && !IsPlayerInAnyVehicle(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, TM_PICKUPRENT))
		{
			ShowPlayerDialog(playerid, D_JTM_RENTLIST, DS_LIST, "THUE XE: Trashman",
			"Thue xe Trashmaster\n\
			Thong tin thue xe\n\
			Tra xe da thue", "Chon", "Huy");
		}
	}
	if(IsPlayerJobTrashman(playerid))
	{
		if(newkeys == KEY_YES && !IsPlayerInAnyVehicle(playerid) && tm_Onduty[playerid] == 1)
		{
			if((IsPlayerInRangeOfPoint(playerid, 3, 1841.566406, -1575.821044, 13.386780) && tm_BinNum[playerid] == 1) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1840.121459, -1577.330810, 13.309167) && tm_BinNum[playerid] == 2) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1832.890747, -1888.642578, 13.057359) && tm_BinNum[playerid] == 3) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2097.398437, -1830.941406, 13.434690) && tm_BinNum[playerid] == 4) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2099.644531, -1830.808227, 13.294692) && tm_BinNum[playerid] == 5) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2228.219726, -1715.608886, 13.232681) && tm_BinNum[playerid] == 6) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2228.122802, -1714.378173, 13.232681) && tm_BinNum[playerid] == 7) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2423.055175, -2103.061279, 13.343847) && tm_BinNum[playerid] == 8) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2423.059082, -2101.273193, 13.043842) && tm_BinNum[playerid] == 9) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2422.716308, -2100.377685, 13.043842) && tm_BinNum[playerid] == 10) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2400.833007, -2060.825439, 13.711330) && tm_BinNum[playerid] == 11) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2397.917724, -2060.101318, 13.026065) && tm_BinNum[playerid] == 12) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2398.616699, -2061.253417, 13.026065) && tm_BinNum[playerid] == 13) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 2377.281738, -2064.068603, 12.479784) && tm_BinNum[playerid] == 14) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1947.160522, -1796.824707, 13.292821) && tm_BinNum[playerid] == 15) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1945.874145, -1796.534667, 13.292821) && tm_BinNum[playerid] == 16) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1948.544677, -1796.353515, 12.576875) && tm_BinNum[playerid] == 17) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1788.982910, -1625.164550, 13.370903) && tm_BinNum[playerid] == 18) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1786.892578, -1625.326049, 12.868711) && tm_BinNum[playerid] == 19) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1785.671875, -1625.326049, 12.868711) && tm_BinNum[playerid] == 20) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1792.029418, -1625.339965, 12.999876) && tm_BinNum[playerid] == 21) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1538.788574, -1613.887695, 13.306889) && tm_BinNum[playerid] == 22) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1538.788574, -1614.908447, 13.306889) && tm_BinNum[playerid] == 23) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1538.901855, -1616.172729, 13.066881) && tm_BinNum[playerid] == 24) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1538.061767, -1614.527954, 12.576875) && tm_BinNum[playerid] == 25) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1626.176513, -1701.400512, 12.929704) && tm_BinNum[playerid] == 26) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1624.942504, -1695.945190, 12.949721) && tm_BinNum[playerid] == 27) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1625.995239, -1701.479736, 13.088589) && tm_BinNum[playerid] == 28) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1625.586669, -1704.813354, 12.669124) && tm_BinNum[playerid] == 29) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1186.371826, -1369.634887, 13.259169) && tm_BinNum[playerid] == 30) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1186.423217, -1371.264160, 12.587800) && tm_BinNum[playerid] == 31) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1186.264404, -1372.179321, 12.586634) && tm_BinNum[playerid] == 32) ||\
				(IsPlayerInRangeOfPoint(playerid, 3, 1186.342529, -1373.463378, 12.586634) && tm_BinNum[playerid] == 33))
				{
					if(IsPlayerJobTrashman(playerid))
					{
						if(tm_Holding[playerid] <= 0)
						{
							tm_Holding[playerid]+=123; // Mot so luong nao do trong thung rac
							SendClientMessage(playerid,-1,"Hay mang rac quay tro lai xe va bam N de chat rac len xe.");
							SetPlayerAttachedObject(playerid, 9, 1265, 6);
							ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 1, 1, 1, 3000);
							tm_TrashTimer[playerid][0] = SetTimerEx("TrashmanDangLayRac", 3000, false, "i", playerid);
						}
					}
				}
		}
		if(newkeys == KEY_NO && !IsPlayerInAnyVehicle(playerid) && tm_Onduty[playerid] == 1)
		{
			if(IsPlayerNearVehicle(playerid, tm_RentVeh[playerid]) && tm_Holding[playerid] > 0)
			{
				if(tm_Amount[playerid] >= 500)
				{
					DestroyDynamicCP(tm_DynamicCP[playerid]);
					SendClientMessage(playerid,-1,"Rac trong xe cua ban da day. Hay cho rac ve khu tai che de thuc hien tai che rac thai.");
					//tm_DynamicCP[playerid][1] = CreateDynamicCP(TM_PICKUPTAICHE, 4.00, 0, 0, playerid, 2000.0);
					SetPlayerCheckPointEx(playerid, TM_CPRECYCLE, 3);
					tm_BinNum[playerid] = 0;
					return 0;
				}
				ApplyAnimation(playerid, "ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 3000);
				tm_TrashTimer[playerid][1] = SetTimerEx("TrashmanBoRacVaoXe", 3000, false, "i", playerid);
				tm_Amount[playerid]+=tm_Holding[playerid];
				tm_Holding[playerid] = 0;
				RandomTrashmanCP(playerid);
			}
			else SendClientMessage(playerid,-1,"Ban chua lay rac hoac ban khong o gan chiec xe Trashmaster.");
		}
		if(newkeys == KEY_NO && !IsPlayerInAnyVehicle(playerid) && tm_Onduty[playerid] == 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.5, TM_PICKUPTAICHE))
			{
				new string[128];
				if(tm_Holding[playerid] <= 0){
					SendClientMessage(playerid,COLOR_LIGHTRED,"Ban chua lay rac tren xe xuong!");
					return 0;
				}
				format(string, sizeof string, "Da tai che thanh cong so rac %d kg, ban nhan duoc so tien %d SAD.", tm_Holding[playerid], tm_Holding[playerid]*30);
				SendClientMessage(playerid,COLOR_LIGHTRED,string);
				GivePlayerMoney(playerid, tm_Holding[playerid]*30); // TUY CHINH
				tm_Amount[playerid]=0;
				tm_Onduty[playerid]=0;
			}
		}
	}
	return 1;
}

function TrashmanDangLayRac(playerid)
{
	ClearAnimations(playerid);
	return 1;
}

function TrashmanBoRacVaoXe(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
	ClearAnimations(playerid);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case D_JTM_JOBLIST:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(!IsPlayerJobTrashman(playerid)) // Khac
						{
							SetPlayerSkin(playerid, 7);
							ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "CONG VIEC: Trashman", "Ban da nhan cong viec Trashman thanh cong!", "Okay","");
							format(player_Job[playerid], 64, "Trashman");
						}
						else if(IsPlayerJobTrashman(playerid)) // Giong
						{
							ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "LOI", "Ban dang lam cong viec nay roi", "Okay","");
						}
					}
					case 1:
					{
						ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX,"CONG VIEC: Trashman",
							"\\cThong tin ve cong viec Trashman:\n\
							\n\
							\\cBla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n\
							\n\
							\\cBla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n","Da hieu","");
					}
					case 2:
					{
						if(!IsPlayerJobTrashman(playerid))
						{
							SendClientMessage(playerid,COLOR_LIGHTRED,"Ban chua nhan cong viec nay!");
						}
						if(IsPlayerJobTrashman(playerid))
						{
							ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "CONG VIEC: Trashman", "Ban da nghi cong viec Trashman thanh cong!", "Okay","");
							format(player_Job[playerid], 64, "That nghiep");
						}
					}
				}
			}
		}
		case D_JTM_RENTLIST:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(!IsPlayerJobTrashman(playerid))
						{
							ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban phai nhan cong viec Trashman de thue xe!", "Okay","");
						}
						if(IsPlayerJobTrashman(playerid))
						{
							if(tm_Rented[playerid] == 1)
							{
								ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban da thue mot chiec xe Trashman roi!\nHay tra xe da thue de co the thue mot chiec xe khac", "Okay","");
							}
							if(tm_Rented[playerid] == 0)
							{
								new plname[MAX_PLAYER_NAME];
								GetPlayerName(playerid, plname, sizeof plname);

								tm_Rented[playerid] = 1;
								tm_Amount[playerid] = 0;
								// PlayerInfo[playerid][Cash] -= 1234 gi gi do;
								format(tm_RentOwner[playerid], 32, "%s", plname);
								tm_RentTime[playerid] = 3600;
								tm_RentTimer[playerid] = SetTimerEx("OnPlayerRentingTrashmaster", 1000, true, "i", playerid);
								ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban da thue mot chiec xe Trashman thanh cong!\nDe lam cong viec nay hay len xe va su dung lenh '/donrac'.", "Okay","");			
								tm_RentVeh[playerid] = CreateVehicle(408,2128.5063,-2152.8242,14.0664,335.9995,1,1,-1); //Trashmaster	
								ActPutPlayerInVehicle(playerid, tm_RentVeh[playerid], 0);
								new string[128];
								format(string,sizeof string,"Chu so huu: %s", tm_RentOwner[playerid]);
								tm_OwnerLabel[playerid] = Create3DTextLabel(string, COLOR_YELLOW, 0, 0, 0, 40.0, 0, 1);
								Attach3DTextLabelToVehicle(tm_OwnerLabel[playerid], tm_RentVeh[playerid], 0, 0, 0);
							}
						}
					}
					case 1:
					{
						ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX,"THUE XE: Trashman",
							"\\cHop dong thue xe Trashmaster:\n\
							\n\
							\\cThoi gian\n\
							Bla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n\
							\n\
							\\cQuy dinh\n\
							Bla bla bla\n\
							Bla bla bla\n\
							Bla bla bla\n","Da hieu","");
					}
					case 2:
					{
						if(IsPlayerJobTrashman(playerid))
						{
							if(tm_Onduty[playerid] == 1)
							{
								ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban khong the tra xe da thue khi dang thuc hien cong viec!", "Okay","");
							}
							if(tm_Rented[playerid] == 0)
							{
								ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban khong co thue mot chiec Trashman nao ca!", "Okay","");
							}
							if(tm_Rented[playerid] == 1)
							{
								ShowPlayerDialog(playerid,D_MSGBOX,DS_MSGBOX, "THUE XE: Trashman", "Ban da tra chiec xe da thue thanh cong!", "Okay","");
								tm_Rented[playerid] = 0;
								tm_RentTime[playerid] = 0;
								tm_Holding[playerid] = tm_Amount[playerid];
								tm_Amount[playerid] = 0;
								format(tm_RentOwner[playerid], 32, "Nah");
								KillTimer(tm_RentTimer[playerid]);
								DestroyVehicle(tm_RentVeh[playerid]);
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

function OnPlayerRentingTrashmaster(playerid)
{
	if(IsPlayerJobTrashman(playerid))
	{
		if(tm_RentTime[playerid] <= 0 && tm_Rented[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "Thoi gian thue cua chiec Trashmaster da het. So luong rac tren xe da duoc chuyen vao nguoi ban.");
			DestroyVehicle(tm_RentVeh[playerid]);
			tm_RentTime[playerid] = 0;
			tm_Holding[playerid] = tm_Amount[playerid];
			tm_Amount[playerid] = 0;
			KillTimer(tm_RentTimer[playerid]);
			return 0;
		}
		tm_RentTime[playerid]--;
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(vehicleid == tm_RentVeh[playerid])
	{
		if(IsTrashmasterOwner(playerid) && IsPlayerJobTrashman(playerid))
		{
			// Co the khoi dong xe
			new sotring[128];
			format(sotring, sizeof sotring, "Thoi gian thue Trashmaster cua ban con lai %s", timec(tm_RentTime[playerid]));
			SendClientMessage(playerid,COLOR_YELLOW,sotring);
		}
		else if(!IsTrashmasterOwner(playerid) && (!IsPlayerJobTrashman(playerid) || IsPlayerJobTrashman(playerid)))
		{
			// Khong khoi dong duoc xe
			SendClientMessage(playerid,COLOR_LIGHTRED,"Ban khong phai la nguoi thue chiec xe nay!");
			ActRemovePlayerFromVehicle(playerid);
		}
	}
	return 1;
}

CMD:donracb(playerid,params[])
{
	if(tm_Onduty[playerid] == 1) return SendClientMessage(playerid,COLOR_LIGHTRED,"Ban dang thuc hien cong viec cho rac roi!");
	if(!IsPlayerInVehicle(playerid, tm_RentVeh[playerid])) return SendClientMessage(playerid,COLOR_LIGHTRED,"Ban phai len xe Trashmaster de lam cong viec nay!");
	if(!IsPlayerJobTrashman(playerid) && !IsTrashmasterOwner(playerid)) return SendClientMessage(playerid,COLOR_LIGHTRED,"Ban khong phai la chu so huu chiec xe nay hoac chua nhan viec nay!");
	RandomTrashmanCP(playerid);
	tm_Onduty[playerid] = 1;
	return 1;
}

CMD:xemracb(playerid,params[])
{
	if(IsPlayerJobTrashman(playerid) && tm_Onduty[playerid] == 1)
	{
		new string[128];
		format(string,sizeof string,"So rac tren nguoi: %d kg",tm_Holding[playerid]);
		SendClientMessage(playerid,-1,string);
		format(string,sizeof string,"So rac trong xe: %d kg",tm_Amount[playerid]);
		SendClientMessage(playerid,-1,string);
	}
	return 1;
}

CMD:layracb(playerid,params[])
{
	if(IsPlayerJobTrashman(playerid) && !IsPlayerInAnyVehicle(playerid) && tm_Onduty[playerid] == 1)
	{
		new string[128];
		format(string,sizeof string,"Ban da lay %d kg rac tren xe xuong.",tm_Amount[playerid]);
		SendClientMessage(playerid,-1,string);
		SendClientMessage(playerid,COLOR_YELLOW,"Hay mang vao trong nha may, bam N de thuc hien tai che rac thai.");
		tm_Holding[playerid]+=tm_Amount[playerid];
		tm_Amount[playerid]=0;
	}
	return 1;
}

stock RandomTrashmanCP(playerid)
{
	if(IsPlayerJobTrashman(playerid))
	{
		switch(random(33))
		{
			case 0: tm_BinNum[playerid] = 1, tm_DynamicCP[playerid] = CreateDynamicCP(1841.566406, -1575.821044, 13.386780, 4.00, 0, 0, playerid, 2000.0);
			case 1: tm_BinNum[playerid] = 2, tm_DynamicCP[playerid] = CreateDynamicCP(1840.121459, -1577.330810, 13.309167, 4.00, 0, 0, playerid, 2000.0);
			case 2: tm_BinNum[playerid] = 3, tm_DynamicCP[playerid] = CreateDynamicCP(1832.890747, -1888.642578, 13.057359, 4.00, 0, 0, playerid, 2000.0);
			case 3: tm_BinNum[playerid] = 4, tm_DynamicCP[playerid] = CreateDynamicCP(2097.398437, -1830.941406, 13.434690, 4.00, 0, 0, playerid, 2000.0);
			case 4: tm_BinNum[playerid] = 5, tm_DynamicCP[playerid] = CreateDynamicCP(2099.644531, -1830.808227, 13.294692, 4.00, 0, 0, playerid, 2000.0);
			case 5: tm_BinNum[playerid] = 6, tm_DynamicCP[playerid] = CreateDynamicCP(2228.219726, -1715.608886, 13.232681, 4.00, 0, 0, playerid, 2000.0);
			case 6: tm_BinNum[playerid] = 7, tm_DynamicCP[playerid] = CreateDynamicCP(2228.122802, -1714.378173, 13.232681, 4.00, 0, 0, playerid, 2000.0);
			case 7: tm_BinNum[playerid] = 8, tm_DynamicCP[playerid] = CreateDynamicCP(2423.055175, -2103.061279, 13.343847, 4.00, 0, 0, playerid, 2000.0);
			case 8: tm_BinNum[playerid] = 9, tm_DynamicCP[playerid] = CreateDynamicCP(2423.059082, -2101.273193, 13.043842, 4.00, 0, 0, playerid, 2000.0);
			case 9: tm_BinNum[playerid] = 10, tm_DynamicCP[playerid] = CreateDynamicCP(2422.716308, -2100.377685, 13.043842, 4.00, 0, 0, playerid, 2000.0);
			case 10: tm_BinNum[playerid] = 11, tm_DynamicCP[playerid] = CreateDynamicCP(2400.833007, -2060.825439, 13.711330, 4.00, 0, 0, playerid, 2000.0);
			case 11: tm_BinNum[playerid] = 12, tm_DynamicCP[playerid] = CreateDynamicCP(2397.917724, -2060.101318, 13.026065, 4.00, 0, 0, playerid, 2000.0);
			case 12: tm_BinNum[playerid] = 13, tm_DynamicCP[playerid] = CreateDynamicCP(2398.616699, -2061.253417, 13.026065, 4.00, 0, 0, playerid, 2000.0);
			case 13: tm_BinNum[playerid] = 14, tm_DynamicCP[playerid] = CreateDynamicCP(2377.281738, -2064.068603, 12.479784, 4.00, 0, 0, playerid, 2000.0);
			case 14: tm_BinNum[playerid] = 15, tm_DynamicCP[playerid] = CreateDynamicCP(1947.160522, -1796.824707, 13.292821, 4.00, 0, 0, playerid, 2000.0);
			case 15: tm_BinNum[playerid] = 16, tm_DynamicCP[playerid] = CreateDynamicCP(1945.874145, -1796.534667, 13.292821, 4.00, 0, 0, playerid, 2000.0);
			case 16: tm_BinNum[playerid] = 17, tm_DynamicCP[playerid] = CreateDynamicCP(1948.544677, -1796.353515, 12.576875, 4.00, 0, 0, playerid, 2000.0);
			case 17: tm_BinNum[playerid] = 18, tm_DynamicCP[playerid] = CreateDynamicCP(1788.982910, -1625.164550, 13.370903, 4.00, 0, 0, playerid, 2000.0);
			case 18: tm_BinNum[playerid] = 19, tm_DynamicCP[playerid] = CreateDynamicCP(1786.892578, -1625.326049, 12.868711, 4.00, 0, 0, playerid, 2000.0);
			case 19: tm_BinNum[playerid] = 20, tm_DynamicCP[playerid] = CreateDynamicCP(1785.671875, -1625.326049, 12.868711, 4.00, 0, 0, playerid, 2000.0);
			case 20: tm_BinNum[playerid] = 21, tm_DynamicCP[playerid] = CreateDynamicCP(1792.029418, -1625.339965, 12.999876, 4.00, 0, 0, playerid, 2000.0);
			case 21: tm_BinNum[playerid] = 22, tm_DynamicCP[playerid] = CreateDynamicCP(1538.788574, -1613.887695, 13.306889, 4.00, 0, 0, playerid, 2000.0);
			case 22: tm_BinNum[playerid] = 23, tm_DynamicCP[playerid] = CreateDynamicCP(1538.788574, -1614.908447, 13.306889, 4.00, 0, 0, playerid, 2000.0);
			case 23: tm_BinNum[playerid] = 24, tm_DynamicCP[playerid] = CreateDynamicCP(1538.901855, -1616.172729, 13.066881, 4.00, 0, 0, playerid, 2000.0);
			case 24: tm_BinNum[playerid] = 25, tm_DynamicCP[playerid] = CreateDynamicCP(1538.061767, -1614.527954, 12.576875, 4.00, 0, 0, playerid, 2000.0);
			case 25: tm_BinNum[playerid] = 26, tm_DynamicCP[playerid] = CreateDynamicCP(1626.176513, -1701.400512, 12.929704, 4.00, 0, 0, playerid, 2000.0);
			case 26: tm_BinNum[playerid] = 27, tm_DynamicCP[playerid] = CreateDynamicCP(1624.942504, -1695.945190, 12.949721, 4.00, 0, 0, playerid, 2000.0);
			case 27: tm_BinNum[playerid] = 28, tm_DynamicCP[playerid] = CreateDynamicCP(1625.995239, -1701.479736, 13.088589, 4.00, 0, 0, playerid, 2000.0);
			case 28: tm_BinNum[playerid] = 29, tm_DynamicCP[playerid] = CreateDynamicCP(1625.586669, -1704.813354, 12.669124, 4.00, 0, 0, playerid, 2000.0);
			case 29: tm_BinNum[playerid] = 30, tm_DynamicCP[playerid] = CreateDynamicCP(1186.371826, -1369.634887, 13.259169, 4.00, 0, 0, playerid, 2000.0);
			case 30: tm_BinNum[playerid] = 31, tm_DynamicCP[playerid] = CreateDynamicCP(1186.423217, -1371.264160, 12.587800, 4.00, 0, 0, playerid, 2000.0);
			case 31: tm_BinNum[playerid] = 32, tm_DynamicCP[playerid] = CreateDynamicCP(1186.264404, -1372.179321, 12.586634, 4.00, 0, 0, playerid, 2000.0);
			case 32: tm_BinNum[playerid] = 33, tm_DynamicCP[playerid] = CreateDynamicCP(1186.342529, -1373.463378, 12.586634, 4.00, 0, 0, playerid, 2000.0);
		}
		SendClientMessage(playerid,COLOR_YELLOW,"Hay di den checkpoint da duoc danh dau tren ban do de thu gom rac vao xe.");
	}
	return 1;
}



hook OnPlayerEnterCheckpoint(playerid)
{
	if(IsPlayerJobTrashman(playerid) && tm_Onduty[playerid] == 1 && tm_BinNum[playerid] == 0 && tm_Amount[playerid] >= 500)
	{
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,-1,"Hay xuong xe va su dung lenh '/layracb' de lay rac tu trong xe ra.");
	}
	return 1;
}
