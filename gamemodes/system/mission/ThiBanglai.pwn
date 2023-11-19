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
{829.8356,-609.6153,15.9689}, // 40 MPH
{834.2700,-548.9444,15.8153},
{781.6683,-527.6374,15.8153},
{722.0259,-527.9050,15.8117},
{679.1986,-566.1868,15.8153},
{679.1959,-673.4142,15.8153},
{683.9590,-797.7986,35.4485},
{741.2899,-891.5577,42.8651},
{792.9636,-1030.4653,24.8114}, // 60 MPH
{737.3622,-1060.4653,22.8377}, 
{646.8804,-1192.7010,17.6902},
{625.2151,-1301.7292,14.2485},
{624.0712,-1398.9515,12.9462},
{624.7911,-1523.6074,14.5749},
{627.0731,-1657.8997,15.3599},
{584.9104,-1720.6461,13.1373},
{420.5506,-1700.2816,9.1901},
{216.9152,-1632.4012,13.4200},
{72.1308,-1525.2570,4.4657},
{-97.6246,-1489.8728,2.3231}, // 40 MPH
{-147.4238,-1315.8544,2.3231},
{-107.0146,-1157.5494,1.6611},
{-81.8646,-1045.9396,21.1786},
{-113.1582,-971.5482,24.0782},
{-43.8502,-833.1515,11.9268},
{29.7384,-663.5918,3.1997},
{130.4584,-684.7977,6.0668},
{220.9880,-623.3987,27.2719},
{303.0262,-568.5374,40.2530},
{446.1580,-598.4182,36.5259},
{594.7116,-647.3687,21.3924},
{669.3761,-664.3604,15.8585},
{684.0832,-543.3890,15.8132},
{722.6440,-532.4922,15.8075},
{789.2615,-546.0828,15.8167},
{829.8356,-609.6153,15.9689}
};


//player_get_speed

new pDriveReward[MAX_PLAYERS];
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
	SendTestMessage(playerid, "CHUC MUNG! Ban da hoan thanh khoa hoc lai xe va lay duoc bang lai!");
	if(pDriveReward[playerid] == 0) // qua lan dau thi
	{
	    pDriveReward[playerid] = 1;
	    new Float: arr_fPlayerPos[4];
		GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
		GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
		// CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 509, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 1, 1, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		// SendTestMessage(playerid, "Ban duoc tang chiec BIKE cho viec hoan thanh hoc lai xe!");
	}
	return 1;
}

DrivingSchoolSpeedMeter(playerid, Float:speed)
{
	new 
		pTestMarker = PlayerLincenseAttemp[playerid],
		maxspeed = 0; 

	switch(pTestMarker) {
		case 0 .. 7: maxspeed = 40;
		case 8 .. 19: maxspeed = 60;
		case 20 .. 36: maxspeed = 40; 
	}


	if(speed > (maxspeed + 2) && GetPVarInt(playerid, "pDTest") != 2) {
		new string[129];
        format(string, sizeof string, "~r~(FAIL) ~w~Ban da vuot qua gioi han toc do toi da la ~p~%d MPH.", maxspeed);
        SendClientTextDraw(playerid, string);
		SetPlayerCheckpoint(playerid, 814.0655,-600.5410,16.0355, 4.0);
		DisablePlayerRaceCheckpoint(playerid);
		SetPVarInt(playerid, "pDTest", 2);
	}
	return 1;
}

hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 1, 816.6824, -613.7670, 16.3359);
	CreateDynamic3DTextLabel("Su dung [/thibanglai] de bat dau thi.", 0xFF0000FF, 816.6824, -613.7670, 16.3359,4.0);
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
		if(PlayerLincenseAttemp[playerid] == 8) // 
		{
			new string[129];
			format(string, sizeof string, "~r~(WARNING SPEED) ~w~Toc do toi da sap toi ban co the chay ~p~60 MPH~w~.");
			SendClientTextDraw(playerid, string);
		}
		else if(PlayerLincenseAttemp[playerid] == 18) // 
		{
			new string[129];
			format(string, sizeof string, "~r~(WARNING SPEED) ~w~Hay giam toc lai duoi ~p~ 40 MPH ~w~- Tranh bi thi truot." );
			SendClientTextDraw(playerid, string);
		}
		if(PlayerLincenseAttemp[playerid] >= sizeof(dsPoints)-1) return DrivingTestFinish(playerid);
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
					SetPVarInt(playerid, "PTestVeh", CreateVehicle(404, 830.0211, -608.1303, 16.0687, 1.5913, 3, 3, -1));
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
    if(!IsPlayerInRangeOfPoint(playerid,5, 816.6824, -613.7670, 16.3359)) return 1;
    if(PlayerInfo[playerid][pCarLic]) return SendTestMessage(playerid, "Ban da co bang lai roi.");
    ShowPlayerDialog(playerid, DIALOG_DSVEH_CAUTION, DIALOG_STYLE_MSGBOX,"DRIVING TEST", "{FE2C2C}DOC CAN THAN\n{FFFFFF}Ban dang chuan bi thi bang lai xe.\nTham gia giao thong, duong chinh yeu cau toc do khong cao hon {FE2C2C}40{FFFFFF} va tren duong cao toc yeu cau toc do khong duoc cao hon {FE2C2C}60{FFFFFF}.\nNeu ban vuot qua gioi han toc do ban se bi truot ky thi.\nNeu dang thi ban roi khoi phuong tien cua ban hon 1 phut se bi loai.","Tiep tuc","Huy bo");
    return 1;
}