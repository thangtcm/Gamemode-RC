// task driving test


#include <YSI_Coding\y_hooks>

#define DIALOG_DSVEH_CAUTION 6941
#define DIALOG_DSVEH_RULES 6942
#define DIALOG_DSVEH_TESTBASE 6943
#define CHECKPOINT_DRIVINGSCHOOL 2539

forward checkTestVehicle(playerid);
SendTestMessage(playerid, const msg_job[])
{
	new format_job[1280];
	format(format_job, sizeof(format_job), "{00FF03}[DRIVING TEST]:{FFFFFF}: %s", msg_job);
	SendClientMessage(playerid, COLOR_WHITE, format_job);
	return 1;
}


new Float:dsPoints[][3] = {
	{1111.1583, -1743.8074, 13.0477},
	{1172.6925, -1767.0665, 13.0479},
	{1172.9950, -1848.0822, 13.0460},
	{1123.3563, -1849.6293, 13.0322},
	{1076.8311, -1849.8086, 13.0373}, // BAT DAU 60 KM/h
	{1018.3488, -1792.9497, 13.4525},
	{965.6966, -1779.3839, 13.7610},
	{888.1850, -1769.1161, 13.0327},
	{828.2728, -1767.7563, 13.0442},
	{735.9001, -1757.5757, 13.5538},
	{634.0140, -1729.6542, 13.491},
	{639.8931, -1697.5656, 14.4899}, // canh bao giam con 40km/h
	{662.9997, -1675.3562, 13.4916}, // dang tinh 40km/h
	{780.1934, -1677.0276, 12.8956},
	{812.3477, -1676.4949, 13.0310},
	{817.5114, -1642.9259, 13.0319},
	{862.5487, -1591.9619, 13.0337},
	{932.2825, -1574.8568, 13.0323},
	{1076.6440, -1575.3375, 13.0243},
	{1144.2057, -1574.9564, 12.9230},
	{1148.1510, -1659.0670, 13.4296},
	{1147.5964, -1714.7146, 13.4284},
	{1173.4719, -1714.5370, 13.2756},
	{1156.1775, -1737.9231, 13.1621},
	{1063.1198, -1740.4064, 13.1146}
};


//player_get_speed

new pDriveTimer[MAX_PLAYERS];
new pDriveTimerCheck[MAX_PLAYERS];
new DangLenXe[MAX_PLAYERS];
new PlayerLincenseAttemp[MAX_PLAYERS];


forward CheckSpeed(playerid);
public CheckSpeed(playerid) 
{
    if(GetPVarType(playerid, "pDTest")) DrivingSchoolSpeedMeter(playerid, player_get_speed(playerid));
    return 1;
}


DrivingTestFinish(playerid)
{
	new pTestVeh = GetPVarInt(playerid, "PTestVeh");
	DestroyVehicle(pTestVeh);
	DeletePVar(playerid, "pTestVeh");
	DeletePVar(playerid, "pDTest");
	PlayerLincenseAttemp[playerid] = 0;
	KillTimer(pDriveTimerCheck[playerid]);
	DisablePlayerRaceCheckpoint(playerid);
	PlayerInfo[playerid][pCarLic] = 1;
	CheckDoneMisson(playerid, 3);
	SendTestMessage(playerid, "CHUC MUNG! Ban da hoan thanh khoa hoc lai xe va lay duoc bang lai!");
	if(pDriveReward[playerid] == 0) // qua lan dau thi
	{
	    pDriveReward[playerid] = 1;
	    new Float: arr_fPlayerPos[4];
		GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
		GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
		CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 509, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 1, 1, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		SendTestMessage(playerid, "Ban duoc tang chiec BIKE cho viec hoan thanh hoc lai xe!");
	}
	return 1;
}

DrivingSchoolSpeedMeter(playerid, Float:speed)
{
	new 
		pTestMarker = PlayerLincenseAttemp[playerid],
		maxspeed = 0; 

	switch(pTestMarker) {
		case 0 .. 3: maxspeed = 40;
		case 4 .. 11: maxspeed = 60;
		case 12 .. 24: maxspeed = 40; 
	}


	if(speed > (maxspeed + 2) && GetPVarInt(playerid, "pDTest") != 2) {
		new string[129];
        format(string, sizeof string, "~r~(FAIL) ~w~Ban da vuot qua gioi han toc do toi da la ~p~%d MPH.", maxspeed);
        SendClientTextDraw(playerid, string);
		SetPlayerCheckPointEx(playerid, 1063.1198, -1740.4064, 13.1146, 4.0);
		DisablePlayerRaceCheckpoint(playerid);
		SetPVarInt(playerid, "pDTest", 2);
	}
	return 1;
}

hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 1, 1111.3508, -1792.6451, 16.5938);
	CreateDynamic3DTextLabel("Su dung [/thibanglai] de bat dau thi.", 0xFF0000FF, 1111.3508, -1792.6451, 16.5938,4.0);
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPVarType(playerid, "pDTest") > 0)
	{
		new pTestVeh = GetPVarInt(playerid, "pTestVeh");
		if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
		{
			pDriveTimer[playerid] = SetTimerEx("checkTestVehicle", 60000, false, "i", playerid);
			SendTestMessage(playerid, "Ban co 60 giay de quay lai xe cua minh hoac no se bi bien mat.");
		}
		else if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == pTestVeh)
		{
			KillTimer(pDriveTimer[playerid]);
		}
	}
	else if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		if(PlayerInfo[playerid][pCarLic] < 1)
		{
			SendClientTextDraw(playerid, "~r~Canh bao: ~w~Ban chua co bang lai xe, co nguy co ban se bi ba't bat cu luc nao!");
		}
	}
	return 1;
}
/*
forward Float:player_get_speed(playerid);
public Float:player_get_speed(playerid)
{
	new
		Float: fVelocity[3];

	GetVehicleVelocity(GetPlayerVehicleID(playerid), fVelocity[0], fVelocity[1], fVelocity[2]);
	return floatsqroot((fVelocity[0] * fVelocity[0]) + (fVelocity[1] * fVelocity[1]) + (fVelocity[2] * fVelocity[2])) * 100;
}
*/

public checkTestVehicle(playerid)
{
	if(GetPVarType(playerid, "pDTest") > 0)
	{
		
		new pTestVeh = GetPVarInt(playerid, "PTestVeh");
		DestroyVehicle(pTestVeh);
		DeletePVar(playerid, "pTestVeh");
		DeletePVar(playerid, "pDTest");
		PlayerLincenseAttemp[playerid] = 0;
		KillTimer(pDriveTimerCheck[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		SendClientMessageEx(playerid, COLOR_YELLOW, "RADIO: Ban da rot bai thi lai xe. - Nguoi gui: Nguoi huong dan (619)");
	}
	return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(GetPVarType(playerid, "PTestVeh"))
	{
		new pTestVeh = GetPVarInt(playerid, "PTestVeh");
		DestroyVehicle(pTestVeh);
	}
	KillTimer(pDriveTimerCheck[playerid]);
	pDriveTimer[playerid] = 0;
}

hook OnPlayerEnterCheckpoint(playerid){
	if(GetPVarInt(playerid, "pDTest") == 2)
	{
		new pTestVeh = GetPVarInt(playerid, "PTestVeh");
		DestroyVehicle(pTestVeh);
		DeletePVar(playerid, "pTestVeh");
		DeletePVar(playerid, "pDTest");
		PlayerLincenseAttemp[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}
stock OnPlayerEnterRaceCP(playerid){
	if(GetPVarInt(playerid, "pDTest") == 1)
	{
		PlayerLincenseAttemp[playerid]++;
		if(PlayerLincenseAttemp[playerid] == 5) // 
		{
			new string[129];
			format(string, sizeof string, "~r~(WARNING SPEED) ~w~Toc do toi da sap toi ban co the chay ~p~60 MPH~w~.");
			SendClientTextDraw(playerid, string);
		}
		else if(PlayerLincenseAttemp[playerid] == 12) // 
		{
			new string[129];
			format(string, sizeof string, "~r~(WARNING SPEED) ~w~Hay giam toc lai duoi ~p~ 40 MPH ~w~-tranh bi thi truot." );
			SendClientTextDraw(playerid, string);
		}
		if(PlayerLincenseAttemp[playerid] >= sizeof(dsPoints)) return DrivingTestFinish(playerid);
		else
		{
			SetPlayerRaceCheckpoint(playerid, 0, 
				dsPoints[PlayerLincenseAttemp[playerid]][0], dsPoints[PlayerLincenseAttemp[playerid]][1], dsPoints[PlayerLincenseAttemp[playerid]][2],
				dsPoints[PlayerLincenseAttemp[playerid] + 1][0], dsPoints[PlayerLincenseAttemp[playerid] + 1][1], dsPoints[PlayerLincenseAttemp[playerid] + 1][2], 4.0);
		}
			
	}
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	
	switch(dialogid)
	{
		case DIALOG_DSVEH_CAUTION:
		{
			if(response)
			{
				//1138.3353,1375.6553,10.4057
				ShowPlayerDialog(playerid, 
				DIALOG_DSVEH_RULES,
				DIALOG_STYLE_MSGBOX,
				"Luat le", 
				"{ffffff}Luat le dieu khien phuong tien can phai tuan theo ({ff2e00}QUAN TRONG{ffffff}).\n1. Khi tham gia giao thong bat buoc di ben lan duong ben phai.\n2. Ban can tuan thu theo gioi han toc do moi luc.\n3. Can phai that day an toan hoac doi mu bao hiem.\n4. Den xe phai bat vao buoi toi.\n5. Neu gap tai nan giao thong, ban can phai goi 911.\n6. Ban can phai dau xe dung vi tri.",
				"Tiep tuc",
				"Dong");
			}
			else return SendClientMessageEx(playerid, COLOR_GREY, "Ban da huy thi bang lai.");
		}
		case DIALOG_DSVEH_RULES:
		{
			if(response)
			{
				ShowPlayerDialog(playerid, 
				DIALOG_DSVEH_TESTBASE,
				DIALOG_STYLE_LIST,
				"{D64040}Neu ban bi tai nan giao thong, ban se xu ly nhu the nao?",
				"Chay luon khong quan tam.\nDieu khien xe va tiep tuc di.\nBao cao ngay cho canh sat va cong ty bao hiem.", "Chon", "Huy");
			}
		}
		case DIALOG_DSVEH_TESTBASE:
		{
			if(response)
			{
				if(listitem == 2)
				{
					ShowPlayerDialog(playerid, 
					DIALOG_DSVEH_TESTBASE+1,
					DIALOG_STYLE_LIST,
					"{D64040}Ban co duoc phep lai xe o lan duong ben TRAI khong?",
					"Duoc\nKhong", "Chon", "Huy");
				}
				else
				{
					return SendClientMessageEx(playerid, COLOR_GREY, "Sai cau tra loi! Hay thu lai...");
				}
			}
		}
		case DIALOG_DSVEH_TESTBASE+1:
		{
			if(response)
			{
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, 
					DIALOG_DSVEH_TESTBASE+2,
					DIALOG_STYLE_LIST,
					"{D64040}Neu toc do gioi han la 40 MPH, ban phai di chuyen....",
					"650 MPH\n120 MPH\n100 MPH\n40 MPH\n300 MPH\n430 MPH", "Chon", "Huy");
				}
				else
				{
					return SendClientMessageEx(playerid, COLOR_GREY, "Sai cau tra loi! Hay thu lai...");
				}
			}
		}
		case DIALOG_DSVEH_TESTBASE+2:
		{
			if(response)
			{
				if(listitem == 3)
				{
					ShowPlayerDialog(playerid, 
					DIALOG_DSVEH_TESTBASE+3,
					DIALOG_STYLE_LIST,
					"{D64040}Ban phai luon that day an toan va doi mu bao hiem?.",
					"Dung\nSai", "Chon", "Huy");
				}
				else
				{
					return SendClientMessageEx(playerid, COLOR_GREY, "Sai cau tra loi! Hay thu lai...");
				}
			}
		}
		case DIALOG_DSVEH_TESTBASE+3:
		{
			if(response)
			{
				if(listitem == 0)
				{
					
					
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid, 0);
					SetPVarInt(playerid, "PTestVeh", CreateVehicle(404, 1062.3820, -1754.9650, 13.0750, 270.4118, 3, 3, -1));
					new pTestVeh = GetPVarInt(playerid, "PTestVeh");
					VehicleFuel[pTestVeh] = 100.0;
					IsPlayerEntering{playerid} = true;
					DangLenXe[playerid] = pTestVeh;
					ActPutPlayerInVehicle(playerid, pTestVeh, 0);
					SendTestMessage(playerid, "Nguoi huong dan: Hay giu toc do phuong tien khong qua 40 MPH . Bay gio ban co the bat dau!");
					pDriveTimerCheck[playerid] = SetTimerEx("CheckSpeed", 500, true, "i", playerid);
					SetPVarInt(playerid, "PDTest", 1);
					printf("%f %f %f", dsPoints[1][0], dsPoints[1][1], dsPoints[1][2]);
					SetPlayerRaceCheckpoint(playerid, 0, 
						dsPoints[PlayerLincenseAttemp[playerid]][0], dsPoints[PlayerLincenseAttemp[playerid]][1], dsPoints[PlayerLincenseAttemp[playerid]][2],
						dsPoints[PlayerLincenseAttemp[playerid] + 1][0], dsPoints[PlayerLincenseAttemp[playerid] + 1][1], dsPoints[PlayerLincenseAttemp[playerid] + 1][2], 4.0);
					PlayerLincenseAttemp[playerid]++;
				}
				else
				{
					return SendTestMessage(playerid, "(FAIL) Sai cau tra loi! Hay thu lai...");
				}
			}
		}
	}
	return 0;
}

CMD:thibanglai(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid,5, 1111.3508, -1792.6451, 16.5938)) return 1;
    if(PlayerInfo[playerid][pCarLic]) return SendTestMessage(playerid, "Ban da co bang lai roi.");
    ShowPlayerDialog(playerid, DIALOG_DSVEH_CAUTION, DIALOG_STYLE_MSGBOX,"DRIVING TEST", "{FE2C2C}DOC CAN THAN\n{FFFFFF}Ban dang chuan bi thi bang lai xe.\nTham gia giao thong, duong chinh yeu cau toc do khong cao hon {FE2C2C}40{FFFFFF} va tren duong cao toc yeu cau toc do khong duoc cao hon {FE2C2C}60{FFFFFF}.\nNeu ban vuot qua gioi han toc do ban se bi truot ky thi.\nNeu dang thi ban roi khoi phuong tien cua ban hon 1 phut se bi loai.","Tiep tuc","Huy bo");
    return 1;
}
