#include <YSI_Coding\y_hooks>

// VARIABLES
#define 		MAX_GROUPS_TRASHMAN 		100
#define 		MAX_TRASHCAN 				80
enum TrashmanInfo {
	LeaderTM,
	GroupIDTM,
	TrashPicked
}
enum TrashmanInfoGr {
	TMLeader,
	TMMembers,
	TMVehicle,
	TMTrashcan[MAX_TRASHCAN],
	TMVehicleTrash,
	TMVehicleObj,
	TMZone,
	TMZoneOld,
	TMStep,
	TMDangLamViec
}
new TrashTimer[MAX_PLAYERS] = {-1, ...};
new TrashOnFoot[MAX_PLAYERS];
new TimeTrash[MAX_PLAYERS];
new Float: TrashcanPos[MAX_TRASHCAN][4] = {
{2275.8467,-1077.8477,47.7021,336.9437},// Las Colinas 1
{2183.0293,-1016.8803,62.8450,354.6798},
{2287.7627,-1049.0544,49.5156,152.0767},
{2377.3035,-1055.1786,54.1087,207.7883},
{2362.2817,-1034.6593,54.2288,196.6337},
{2357.7793,-1046.3573,54.1555,110.8653},
{2360.4863,-1055.0533,54.1239,24.6975},
{2323.2817,-1051.6172,52.3516,281.1143},
{2281.9685,-1082.9996,47.6604,65.2826},
{2260.6465,-1093.7245,41.6016,60.5486},
{2259.1211,-1099.7042,37.9766,244.8009},
{2256.7209,-1105.8827,37.9766,241.6675},
{2261.9224,-1110.0769,37.9766,337.1725},
{2274.2705,-1116.2561,37.9766,330.8432},
{2284.9048,-1119.4648,37.9766,359.1062},
{2285.9380,-1103.4965,37.9766,170.9402},
{2291.4309,-1104.2676,37.9766,170.9402},
{2433.7671,-1015.6914,54.3559,203.2967},
{2502.3677,-1063.0134,70.1568,355.2269},
{2528.6428,-1066.7122,69.5662,270.8769},
{2241.4802,-1723.3478,13.5469,188.3619}, // GANTON 2
{2294.8940,-1646.0161,14.8311,267.8516},
{2279.3826,-1722.3700,13.5469,176.9007},
{2294.6946,-1720.8730,13.5545,273.9034},
{2305.8604,-1723.2382,13.5469,181.2249},
{2329.8928,-1723.0457,13.5424,181.1622},
{2373.3223,-1720.9087,13.5562,88.4474},
{2422.4797,-1754.0786,13.5469,93.1147},
{2426.1563,-1778.6846,13.5469,357.2040},
{2433.0505,-1778.7937,13.5469,356.7654},
{2440.3875,-1778.7388,13.5469,359.6480},
{2447.9858,-1778.7678,13.5469,354.3212},
{2441.7148,-1767.0835,13.5615,268.9290},
{2449.5266,-1759.3271,13.5910,178.1242},
{2230.3201,-1762.7899,13.5625,84.5856},
{2258.4788,-1668.9948,15.4589,358.3549},
{2243.8914,-1645.6993,15.4790,166.4679},
{2253.7539,-1648.6653,15.4766,163.8361},
{2278.3269,-1649.7083,15.2686,173.5496}	,
{2323.2112,-1645.4258,14.8270,177.0597},
{1744.7003,-2054.8977,13.5755,181.7594},  // EL CORONA 3
{1759.9685,-2054.2751,13.5771,179.6486},
{1765.0258,-2040.6160,13.5265,273.0456},
{1765.1082,-2023.4513,14.1514,273.7151},
{1689.7308,-2008.6395,14.1212,180.1297},
{1695.3821,-2028.3254,14.1387,87.0067},
{1684.6230,-2043.2061,14.1413,269.4079},
{1695.3593,-2060.3792,14.1387,90.0153},
{1680.0240,-2063.9050,14.1424,175.9948},
{1800.6287,-2124.0251,13.5469,0.7772},
{1784.6914,-2102.6470,13.5469,181.4237},
{1766.5914,-2102.3640,13.5469,180.7342},
{1743.3401,-2125.5081,13.5469,269.1576},
{1738.3135,-2098.4592,13.5469,178.3528},
{1718.5359,-2124.9333,13.5543,359.3356},
{1672.2158,-2107.6255,13.5469,181.6112},
{1852.9443,-2042.4158,13.5469,180.2333},
{1912.3958,-2042.6107,13.5391,170.6456},
{1948.6897,-2043.6702,13.5469,179.1059},
{1952.6290,-2006.6353,13.5469,267.9680},
{129.4314,-1489.5990,18.7289,328.8809},  // RICHMAN 4
{140.7793,-1467.9410,25.2109,321.1730},
{152.5607,-1448.9695,32.8450,52.7695},
{219.0339,-1389.0498,51.5696,152.7860},
{225.2357,-1403.4584,51.6094,325.9125},
{206.0809,-1355.7302,50.5143,224.9556},
{252.7996,-1364.2253,53.1094,308.9457},
{259.9373,-1383.7024,53.1094,211.2477},
{238.3146,-1365.7012,53.1094,127.6498},
{282.3802,-1328.6488,53.5713,305.7894},
{293.0405,-1347.7633,53.4390,125.1433},
{309.7186,-1336.1858,53.4467,300.9018},
{342.6665,-1283.4674,54.1230,24.8291},
{358.2231,-1279.0461,53.7036,24.3278},
{423.5943,-1247.2794,51.0646,18.8753},
{405.2920,-1228.5668,51.6993,108.3643},
{363.1485,-1215.3246,56.8553,217.2567},
{288.6575,-1261.6725,73.6171,44.5691},
{270.2656,-1226.6445,74.5996,212.2039},
{188.7294,-1403.3257,46.5537,142.6663}
};
new TrashcanObject[MAX_TRASHCAN];
new Text3D: TrashcanText[MAX_TRASHCAN];
new TMGInfo[MAX_GROUPS_TRASHMAN][TrashmanInfoGr];
new TMInfo[MAX_PLAYERS][TrashmanInfo];
// DIALOG
Dialog:trashmandialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				return cmd_taonhomabcxyz(playerid, "abc");
			}
			case 1:
			{
				if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban chua tao team, hay su dung /createteam de tao team va moi nguoi khac vao lam cung..."), SendClientMessage(playerid, -1, ".../trogiuptrashman de biet them chi tiet nua nhe!");
				if(TMInfo[playerid][LeaderTM] != 1) return SendErrorMessage(playerid, " Ban khong phai la truong nhom nen khong the lay xe.");
				if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] != INVALID_VEHICLE_ID) return SendErrorMessage(playerid, " Nhom cua ban da lay xe roi.");
                if(!IsPlayerInRangeOfPoint(playerid, 4,2208.2852,-2025.0245,13.5469)) return SendErrorMessage(playerid," Ban khong o gan noi lam viec.");
                if(LamViec[playerid] != 0 && LamViec[playerid] != 3) return  SendClientMessage(playerid, COLOR_GREY, "Ban dang lam cong viec khac khong the lam Trashman.");  
                SendClientMessage(playerid, COLOR_VANG, "Ban da bat dau lam viec Trashman hay di den checkpoint, su dung /trogiuptrashman de biet them chi tiet.");
                ActSetPlayerPos(playerid, 2202.8777,-2047.4569,15.2173);
                TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj] = CreateObject(19848, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	            TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = CreateVehicle(408, 2202.8777,-2047.4569,15.2173 , 45.5 , 0, 0, 1000, 0);
	            TMGInfo[TMInfo[playerid][GroupIDTM]][TMDangLamViec] = 1;
	            AttachObjectToVehicle(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj], TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle], -1.5, 0.0, -1.1, 0.0, 0.0, 0.0);
	            ActPutPlayerInVehicle(playerid, TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] ,0);
	            foreach(new i: Player)
	            {
	               	if(TMInfo[playerid][GroupIDTM] == TMInfo[i][GroupIDTM])
	               	{
	               		LamViec[i] = 3;
	              	}
	            }
	            LamViec[playerid] = 3;
	            switch(random(4))
	            {
	               	case 0:
	               	{
	               		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 1;
	               		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}LAS COLINAS{ffffff} va tim cac thung rac o xung quanh do");
	               		SetPlayerCheckpoint(playerid, 2169.0344,-1005.0826,62.8047, 10.0);
	               		SetPVarInt(playerid, #GPSTM, 1);
	               	}
	               	case 1:
	               	{
	               		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 2;
	               		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}GANTON{ffffff} va tim cac thung rac o xung quanh do");
	               		SetPlayerCheckpoint(playerid, 2239.0088,-1653.2634,15.2969, 10.0);
	               		SetPVarInt(playerid, #GPSTM, 2);
	               	}
	               	case 2:
	               	{
	               		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 3;
	               		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}EL CORONA{ffffff} va tim cac thung rac o xung quanh do");
	               		SetPlayerCheckpoint(playerid, 1961.1755,-2005.4413,13.3906, 10.0);
	               		SetPVarInt(playerid, #GPSTM, 3);
	               	}
	               	case 3:
	               	{
	               		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 4;
	               		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}RICHMAN{ffffff} va tim cac thung rac o xung quanh do");
	               		SetPlayerCheckpoint(playerid, 109.2051,-1486.4408,14.5084, 10.0);
	               		SetPVarInt(playerid, #GPSTM, 4);
	              	}
	            }
			}
			case 2:
			{
				return cmd_trogiuptrashman(playerid, "abc");
			}
		}
	}
	return 1;
}
Dialog:trashmanager(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[555], string2[555];
		format(string, sizeof(string), "{ff4747}>{ffffff} Thanh vien\n{1E88E5}> {ffffff}Tim xe cua nhom\n{ff4747}>{ffffff} Moi vao nhom\n{ff4747}>{ffffff} Moi ra khoi nhom\n{1E88E5}> {ffffff}Tro giup nhom\n{ff4747}> ROI KHOI NHOM", "Lua chon", "Huy bo");
		format(string2, sizeof(string2), "{1E88E5}NHOM LAM VIEC {ffffff}So rac trong xe [{ff4747}%d{ffffff}]", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
		switch(listitem)
		{
			case 0:
			{
				new szDialog[1024];
				foreach(new i: Player)
				{
					if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
					{
						if(TMInfo[i][LeaderTM] == 0) format(szDialog, sizeof(szDialog), "%s\n* %s (ID %d)", szDialog, GetPlayerNameEx(i), i);
						else format(szDialog, sizeof(szDialog), "%s\n{ff4747}* %s [LEADER]{ffffff}", szDialog, GetPlayerNameEx(i));
					}
				}
				if(!isnull(szDialog)) {
				    strdel(szDialog, 0, 1);
				    Dialog_Show(playerid, membertrashman, DIALOG_STYLE_LIST, "{747474}> {ff4747}THANH VIEN TRONG NHOM{ffffff}", szDialog, "Lua chon", "Huy bo");
				}
				else SendErrorMessage(playerid, " Nhom cua ban khong co thanh vien nao.");
			}
			case 1:
			{
				if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] == INVALID_VEHICLE_ID) return SendErrorMessage(playerid, " Co ve nhu xe cua nhom ban chua duoc spawn ra hoac da bi xoa.");
				new Float: tx, Float: ty, Float: tz;
				GetVehiclePos(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle], tx, ty, tz);
				SetPlayerCheckpoint(playerid, tx, ty, tz, 10.0);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN]: {ffffff}Checkpoint da chi den dia diem xe cua ban.");
			}
			case 2:
			{
				if(TMInfo[playerid][LeaderTM] == 1) return Dialog_Show(playerid, invitemembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI VAO NHOM", "Nhap vao day ID nguoi ban muon moi vao nhom!", "Xac nhan", "Thoat");
				else return Dialog_Show(playerid, trashmanager, DIALOG_STYLE_LIST,  string2,string, "Lua chon", "Huy bo"), SendClientTextDraw(playerid, "~r~Chi co truong nhom moi co the lam viec nay!");
			}
			case 3:
			{
				if(TMInfo[playerid][LeaderTM] == 1) return Dialog_Show(playerid, kickmembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI RA KHOI NHOM", "Nhap vao day ID nguoi ban muon kick ra khoi nhom!\n ID co the lay trong phan thanh vien", "Kick", "Thoat");
				else return Dialog_Show(playerid, trashmanager, DIALOG_STYLE_LIST,  string2,string, "Lua chon", "Huy bo"), SendClientTextDraw(playerid, "~r~Chi co truong nhom moi co the lam viec nay!");
			}
			case 4: cmd_trogiuptrashman(playerid, "abc");
			case 5: cmd_roinhomzxcabc(playerid, "abc");
		}
	}
	return 1;
}

Dialog:invitemembertm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMDangLamViec] == 0)
		{
			if(!IsPlayerInRangeOfPlayer(playerid, strval(inputtext), 8.0))
			{
				Dialog_Show(playerid, invitemembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI VAO NHOM", "{ff4747} Nguoi do khong o gan vi tri cua ban!{ffffff}", "Xac nhan", "Thoat");
			}
			else
			{
				if(isnull(inputtext)) return Dialog_Show(playerid, invitemembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI VAO NHOM", "VUI LONG NHAP ID HOP LE!", "Xac nhan", "Thoat");
				else if(strval(inputtext) < 0) return Dialog_Show(playerid, invitemembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI VAO NHOM", "ID KHONG HOP LE!", "Xac nhan", "Thoat");
				else return cmd_moivaonhomabcxyzzxc(playerid, inputtext);
			}
		}
		else
		{
			new string[555], string2[555];
			format(string, sizeof(string), "{ff4747}>{ffffff} Thanh vien\n{1E88E5}> {ffffff}Tim xe cua nhom\n{ff4747}>{ffffff} Moi vao nhom\n{ff4747}>{ffffff} Moi ra khoi nhom\n{1E88E5}> {ffffff}Tro giup nhom\n{ff4747}> ROI KHOI NHOM", "Lua chon", "Huy bo");
			format(string2, sizeof(string2), "{1E88E5}NHOM LAM VIEC {ffffff}So rac trong xe [{ff4747}%d{ffffff}]", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
			Dialog_Show(playerid, trashmanager, DIALOG_STYLE_LIST,  string2,string, "Lua chon", "Huy bo");
			SendErrorMessage(playerid, " Ban khong the invite khi da bat dau lam viec.");
		}
	}
	return 1;
}
Dialog:kickmembertm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext)) return Dialog_Show(playerid, kickmembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI RA KHOI NHOM", "VUI LONG NHAP ID HOP LE!\n ID co the lay trong phan thanh vien", "Kick", "Thoat");
		else if(strval(inputtext) < 0) return Dialog_Show(playerid, kickmembertm, DIALOG_STYLE_INPUT, "{ff4747}>{ffffff} MOI RA KHOI NHOM", "ID KHONG HOP LE!\n ID co the lay trong phan thanh vien", "Kick", "Thoat");
		else return cmd_kicknhomzxczxc(playerid, inputtext);
	}
	return 1;
}


// FUNCS
stock IsPlayerInRangeOfPlayer(playerid, targetid, Float:range)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    return IsPlayerInRangeOfPoint(playerid, range, x, y, z);
}
stock CreateTrashcan(trashcanid)
{
	new string[555];
	TrashcanObject[trashcanid] = CreateDynamicObject(1334, TrashcanPos[trashcanid][0], TrashcanPos[trashcanid][1], TrashcanPos[trashcanid][2], 0.0, 0.0, TrashcanPos[trashcanid][3], -1, -1, -1);
	format(string, sizeof(string), "#%d\n{ff4747}<THUNG RAC>{ffffff}\n\n Bam phim 'Y' de lay rac.", trashcanid);
	TrashcanText[trashcanid] = CreateDynamic3DTextLabel(string, -1, TrashcanPos[trashcanid][0], TrashcanPos[trashcanid][1], TrashcanPos[trashcanid][2]+0.6, 1.8);
	return 1;
}
forward OnPlayerPickUpTrash(playerid, trashcanid);
public OnPlayerPickUpTrash(playerid, trashcanid)
{
	if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][trashcanid] != 0) return SendErrorMessage(playerid, " Thung rac nay khong con gi de lay.");
	TMInfo[playerid][TrashPicked] = trashcanid;
	TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][trashcanid] = 1;
	TimeTrash[playerid] = 6+random(4);
	TrashTimer[playerid] = SetTimerEx("TrashPicking", 1000, true, "i", playerid);
   	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 1, 1, 1, 1, 0);
   	TogglePlayerControllable(playerid, 0);
	return 1;
}
forward TrashPicking(playerid);
public TrashPicking(playerid)
{
    if(TimeTrash[playerid] > 0)
    {
    	new format_job[555];
    	TimeTrash[playerid]--;
    	format(format_job, sizeof(format_job), "Ban dang nhat rac, vui long doi~p~ %d~w~ de nhat xong.", TimeTrash[playerid]);
    	SendClientTextDraw(playerid, format_job);
    	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 1, 1, 1, 1, 0);
    }
    else
    {
    	if(IsPlayerInRangeOfPoint(playerid, 1.8, TrashcanPos[TMInfo[playerid][TrashPicked]][0], TrashcanPos[TMInfo[playerid][TrashPicked]][1], TrashcanPos[TMInfo[playerid][TrashPicked]][2]))
    	{
			ClearAnimations(playerid);
	   		StopLoopingAnim(playerid);
	   		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	    	SendClientTextDraw(playerid, "~w~Ban da nhat rac xong, hay mang den xe va bam ~r~'N' ~w~de bo rac vao xe.");
	    	KillTimer(TrashTimer[playerid]);
			SetPlayerAttachedObject(playerid, PIZZA_INDEX, 1264, 1, 0.102953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			TogglePlayerControllable(playerid, 1);
			TrashOnFoot[playerid] = 1;
		}
		else
		{
			ClearAnimations(playerid);
	   		StopLoopingAnim(playerid);
	   		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	    	SendClientTextDraw(playerid, "~w~Ban da di chuyen ~r~~n~NHAT RAC THAT BAI.");
	    	KillTimer(TrashTimer[playerid]);
			TogglePlayerControllable(playerid, 1);
			TrashOnFoot[playerid] = 0;
		}
    }
    return 1;
}

// HOOKS
hook OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, #GPSTM) != 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Ban da den diem duoc chi dinh, hay tim rac xung quanh khu vuc nay");
		SetPVarInt(playerid, #GPSTM, 0);
		DisablePlayerCheckpoint(playerid);
	}
	if(GetPVarInt(playerid, #CPNhanTien) == 1)
	{
		new string[555];
		SetPVarInt(playerid, #CPNhanTien, 0);
		DestroyVehicle(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle]);
		DestroyObject(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj]);
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj] = INVALID_OBJECT_ID;
		for(new i = 0; i < MAX_TRASHCAN; i++)
		{
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][i] = 0;
		}
		foreach(new i: Player)
		{
			if(TMInfo[playerid][GroupIDTM] == TMInfo[i][GroupIDTM])
			{
				PlayerInfo[i][pCash] += 500;
				format(string, sizeof(string), "~g~FINISH~n~Ban da hoan thanh cong viec va nhan duoc mot it tien.~n~~p~+500$");
				SendClientTextDraw(playerid, string);
				format(string, sizeof(string), "[TRASHMAN]: {ffffff}Ban da hoan thanh cong viec va nhan duoc {ff4747}500${ffffff}.");
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			}
		}
	}
	return 1;
}
hook OnGameModeInit()
{
	for(new i = 0; i < MAX_TRASHCAN; i++)
	{
		CreateTrashcan(i);
		printf("[TRASHMAN] Da tao thanh cong trashcan#%d", i);
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 0) return 1;
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 2208.2852,-2025.0245,13.5469))
	{
	    if(PRESSED(KEY_YES))
	    {
	    	Dialog_Show(playerid, trashmandialog, DIALOG_STYLE_LIST, "{ff4747}Quan ly bai rac{ffffff}", "Tao nhom\nLay xe lam viec \n /trogiuptrashman", "Lua chon", "Huy bo");
	    }
	}
	if(LamViec[playerid] == 3)
	{
		if(PRESSED(KEY_YES))
		{
			for(new i = 0; i < MAX_TRASHCAN; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 1.8, TrashcanPos[i][0], TrashcanPos[i][1], TrashcanPos[i][2]))
				{
					if(i >= 0 && i <= 19 && TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] != 1) return SendErrorMessage(playerid, " Co ve nhu nhom cua ban da den sai khu vuc duoc chi dinh.");
					if(i >= 20 && i <= 39 && TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] != 2) return SendErrorMessage(playerid, " Co ve nhu nhom cua ban da den sai khu vuc duoc chi dinh.");
					if(i >= 40 && i <= 59 && TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] != 3) return SendErrorMessage(playerid, " Co ve nhu nhom cua ban da den sai khu vuc duoc chi dinh.");
					if(i >= 60 && i <= 79 && TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] != 4) return SendErrorMessage(playerid, " Co ve nhu nhom cua ban da den sai khu vuc duoc chi dinh.");
					if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][i] != 0) return SendErrorMessage(playerid, " Thung rac nay da duoc nhom cua ban lay roi.");
					if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban chua duoc vao nhom lam viec trashman.");
					if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
					if(TrashOnFoot[playerid] == 1) return SendErrorMessage(playerid, " Ban da cam rac tren tay khong the lay them.");
					if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec."); 
					if(TimeTrash[playerid] > 0) return 1;
					OnPlayerPickUpTrash(playerid, i);
				}
			}
		}
		if(PRESSED(KEY_NO))
		{
			if(IsPlayerInRangeOfVehicle(playerid, TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle], 5))
			{
				if(TrashOnFoot[playerid] == 1)
				{
					new format_job[555], randzone[MAX_PLAYERS];
					RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
					TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]++;
					TrashOnFoot[playerid] = 0;
					if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash] <= 14)
					{
						foreach(new i: Player)
						{
							if(TMInfo[playerid][GroupIDTM] == TMInfo[i][GroupIDTM])
							{
								format(format_job, sizeof(format_job), "~w~Da bo rac vao xe, so rac hien tai ~y~%d/15~w~.", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
								SendClientTextDraw(i, format_job);
							}
						}
					}
					else
					{
						if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMStep] != 2)
						{
							for(new i = 0; i < i+1; i++)
							{
							    switch(random(4))
							    {
							        case 0: randzone[playerid] = 1;
							        case 1: randzone[playerid] = 2;
							        case 2: randzone[playerid] = 3;
							        case 3: randzone[playerid] = 4;
							    }
							    if(randzone[playerid] != TMGInfo[TMInfo[playerid][GroupIDTM]][TMZoneOld])
							    {
							    	TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = randzone[playerid];
							    	break;
							    }
							}
							foreach(new i: Player)
							{
								format(format_job, sizeof(format_job), "~r~Hay di chuyen den dia diem tiep theo~w~So rac hien tai ~r~%d/15~w~.~n~~p~Neu muon vut rac hay /vutrac.", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
								SendClientTextDraw(i, format_job);
								TrashOnFoot[i] = 0;
								RemovePlayerAttachedObject(i,PIZZA_INDEX);
								SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
								ClearAnimations(i);
						   		StopLoopingAnim(i);
								TogglePlayerControllable(i, 1);
								KillTimer(TrashTimer[i]);
							    TMGInfo[TMInfo[playerid][GroupIDTM]][TMZoneOld] = TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone];
							    TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash] = 0;
							    TMGInfo[TMInfo[playerid][GroupIDTM]][TMStep] = 2;
								switch(TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone])
								{
									case 1:
					               	{
					               		SendClientMessage(i, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}LAS COLINAS{ffffff} va tim cac thung rac o xung quanh do");
					               		SetPlayerCheckpoint(i, 2169.0344,-1005.0826,62.8047, 10.0);
					               		SetPVarInt(i, #GPSTM, 1);
					               	}
					               	case 2:
					               	{
					               		SendClientMessage(i, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}GANTON{ffffff} va tim cac thung rac o xung quanh do");
					               		SetPlayerCheckpoint(i, 2239.0088,-1653.2634,15.2969, 10.0);
					               		SetPVarInt(i, #GPSTM, 2);
					               	}
					               	case 3:
					               	{
					               		SendClientMessage(i, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}EL CORONA{ffffff} va tim cac thung rac o xung quanh do");
					               		SetPlayerCheckpoint(i, 1961.1755,-2005.4413,13.3906, 10.0);
					               		SetPVarInt(i, #GPSTM, 3);
					               	}
					               	case 4:
					               	{
					               		SendClientMessage(i, COLOR_LIGHTBLUE, "[TRASHMAN] {ffffff}Hay di chuyen den khu vuc {ff4747}RICHMAN{ffffff} va tim cac thung rac o xung quanh do");
					               		SetPlayerCheckpoint(i, 109.2051,-1486.4408,14.5084, 10.0);
					               		SetPVarInt(i, #GPSTM, 4);
					              	}
					            }
							}
						}
						else
						{
							TMGInfo[TMInfo[playerid][GroupIDTM]][TMStep] = 0;
							TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash] = 0;
							TMGInfo[TMInfo[playerid][GroupIDTM]][TMZoneOld] = 0;
							TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 0;
							SetPlayerCheckpoint(playerid, 2202.8777,-2047.4569,15.2173, 15.0);
							SetPVarInt(playerid, #CPNhanTien, 1);
							foreach(new i: Player)
							{
								if(TMInfo[playerid][GroupIDTM] == TMInfo[i][GroupIDTM])
								{
									SendClientMessage(i, COLOR_LIGHTBLUE, "[TRASHMAN]: {ffffff}Nhom cua ban da hoan thanh, leader team da nhan duoc checkpoint hay quay tro ve.");
								}
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	new string[555];
	if(TMInfo[playerid][LeaderTM] == 1)
	{
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMLeader] = 0;
		DestroyVehicle(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle]);
		DestroyObject(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj]);
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj] = INVALID_OBJECT_ID;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
		TMInfo[playerid][LeaderTM] = 0;
		TMInfo[playerid][GroupIDTM] = 0;
		TMInfo[playerid][TrashPicked] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMStep] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZoneOld] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMZone] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMDangLamViec] = 0;

		for(new i = 0; i < MAX_TRASHCAN; i++)
		{
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][i] = 0;
		}
		foreach(new i: Player)
		{
			if(playerid != i)
			{
				if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					SendClientMessage(i, COLOR_VANG, "[TM GROUP]: Nhom cua ban da bi giai tan! {ff4747}[LEADER DISCONNECTED]");
					TMInfo[i][GroupIDTM] = 0;
					TMInfo[i][TrashPicked] = 0;
					TrashOnFoot[i] = 0;
					RemovePlayerAttachedObject(i,PIZZA_INDEX);
					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					StopLoopingAnim(i);
					TogglePlayerControllable(i, 1);
					KillTimer(TrashTimer[i]);
					LamViec[i] = 0;
				}
			}
		}
	}
	else
	{
		foreach(new i: Player)
		{
			if(playerid != i)
			{
				if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					format(string, sizeof(string), "[TM GROUP]: Nguoi choi %s da thoat khoi nhom. {ff4747}[DISCONNECTED]", GetPlayerNameEx(playerid));
					SendClientMessage(i, COLOR_VANG, string);
				}
			}
		}
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers]--; 
		TMInfo[playerid][GroupIDTM] = 0;
		TMInfo[playerid][TrashPicked] = 0;
	}
	TMInfo[playerid][GroupIDTM] = 0;
	TMInfo[playerid][TrashPicked] = 0;
	TrashOnFoot[playerid] = 0;
	RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	TogglePlayerControllable(playerid, 1);
	LamViec[playerid] = 0;
	KillTimer(TrashTimer[playerid]);
	TrashTimer[playerid] = -1;
	return 1;
}
// COMMANDS
CMD:taonhomabcxyz(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][GroupIDTM] != 0) return SendErrorMessage(playerid, " Ban da o trong mot nhom nao do roi!");
	for(new i = 1; i < MAX_GROUPS_TRASHMAN; i++)
	{
		if(TMGInfo[i][TMMembers] == 0)
		{
			new string[555];
			TMInfo[playerid][LeaderTM] = 1;
			TMInfo[playerid][GroupIDTM] = i;
			TMGInfo[i][TMLeader] = playerid;
			TMGInfo[i][TMMembers]++;
			format(string, sizeof(string), "[TRASHMAN]: {ffffff}Ban da tao thanh cong nhom lam viec, ID nhom ban la: {ff4747}%d{ffffff}.", i);
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj] = INVALID_OBJECT_ID;
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
			return 1;
		}
	}
	return 1;
}
CMD:roinhomzxcabc(playerid, params[])
{
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban dang khong o trong mot nhom nao het!");
	new string[555];
	if(TMInfo[playerid][LeaderTM] == 1)
	{
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMLeader] = 0;
		DestroyVehicle(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle]);
		DestroyObject(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj]);
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleObj] = INVALID_OBJECT_ID;
		TMInfo[playerid][LeaderTM] = 0;
		TMInfo[playerid][GroupIDTM] = 0;
		TMInfo[playerid][TrashPicked] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMDangLamViec] = 0;
		SendClientMessage(playerid, COLOR_VANG, "[TM GROUP]: Ban da giai tan nhom thanh cong!");
		for(new i = 0; i < MAX_TRASHCAN; i++)
		{
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMTrashcan][i] = 0;
		}
		foreach(new i: Player)
		{
			if(playerid != i)
			{
				if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					SendClientMessage(i, COLOR_VANG, "[TM GROUP]: Nhom cua ban da bi giai tan!");
					TMInfo[i][GroupIDTM] = 0;
					TMInfo[i][TrashPicked] = 0;
					return 1;
				}
			}
		}
	}
	else
	{
		foreach(new i: Player)
		{
			if(playerid != i && TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
			{
				format(string, sizeof(string), "[TM GROUP]: Nguoi choi %s da thoat khoi nhom.", GetPlayerNameEx(playerid));
				SendClientMessage(i, COLOR_VANG, string);
			}
		}
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers]--; 
		TMInfo[playerid][GroupIDTM] = 0;
		TMInfo[playerid][TrashPicked] = 0;
		SendClientMessage(playerid, COLOR_VANG, "Ban da roi khoi nhom lam viec trashman thanh cong!");
	}
	return 1;
}
CMD:kicknhomzxczxc(playerid, params[])
{
	if(TMInfo[playerid][LeaderTM] == 0) return SendErrorMessage(playerid, " Ban khong co quyen su dung lenh nay.");
	new
		iTargetID,
		string[555];

	if(sscanf(params, "u", iTargetID)) {
		SendUsageMessage(playerid, " /kicknhomzxczxc [id player]");
	}
	else if(IsPlayerConnected(iTargetID))
	{
		if(iTargetID == playerid) return SendErrorMessage(playerid, " Ban khong the kick chinh minh.");
		if(TMInfo[iTargetID][GroupIDTM] != TMInfo[playerid][GroupIDTM]) return SendErrorMessage(playerid, " Nguoi do khong o trong nhom cua ban");
		foreach(new i: Player)
		{
			if(i != playerid)
			{
				if(i != iTargetID && TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					format(string, sizeof(string), "[TM GROUP]: %s da bi kick ra khoi nhom boi %s.", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
					SendClientMessage(i, COLOR_VANG, string);
				}
			}
		}
		SendClientMessage(playerid, COLOR_VANG, "[TM GROUP]: Ban da kick thanh cong!");
		TMGInfo[TMInfo[iTargetID][GroupIDTM]][TMMembers]--; 
		TMInfo[iTargetID][GroupIDTM] = 0;
		TMInfo[iTargetID][TrashPicked] = 0;
		SendClientMessage(iTargetID, COLOR_VANG, "Ban da moi bi truong nhom kick!");
	}
	else return SendErrorMessage(playerid, " ID nguoi choi khong hop le.");
	return 1;
}

CMD:moivaonhomabcxyzzxc(playerid, params[])
{
	if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMDangLamViec] == 1) return SendErrorMessage(playerid, " Nhom cua ban da bat dau lam viec khong the moi them nguoi khac hay doi khi hoan thanh.");
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][LeaderTM] == 0) return SendErrorMessage(playerid, " Ban khong co quyen su dung lenh nay.");
	new
		iTargetID,
		string[555];

	if(sscanf(params, "u", iTargetID)) {
		SendUsageMessage(playerid, " /moivaonhom [id player]");
	}
	else if(IsPlayerConnected(iTargetID))
	{
		if(iTargetID == playerid) return SendErrorMessage(playerid, " Ban khong the moi chinh minh.");
		if(TMInfo[iTargetID][GroupIDTM] != 0) return SendErrorMessage(playerid, " Nguoi choi ma ban moi da o trong mot nhom khac.");
		format(string, sizeof(string), "[TRASHMAN]: {ffffff}Nguoi choi {ff4747}%s(%d){ffffff} muon moi ban vao nhom lam viec TRASHMAN (don rac) cua ho.", GetPlayerNameEx(playerid), playerid);
		SendClientMessage(iTargetID, COLOR_LIGHTRED, string);
		SendClientMessage(iTargetID, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}su dung {ff4747}/chapnhantm{ffffff} de chap nhan vao nhom.");
		SendClientMessage(iTargetID, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}hoac su dung {ff4040}/tuchoitm{ffffff} de {ff3030}tu choi {ffffff}vao nhom.");
		format(string, sizeof(string), "[TRASHMAN]: {ffffff}Ban da moi nguoi choi {ff4747}%s(%d){ffffff} vao nhom, hay doi ho chap nhan.", GetPlayerNameEx(iTargetID), playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		SetPVarInt(iTargetID, #invitedgroup, TMInfo[playerid][GroupIDTM]);
		SetPVarInt(iTargetID, #invitedid, playerid);
	}
	else return SendErrorMessage(playerid, " ID nguoi choi khong hop le.");
	return 1;
}
CMD:chapnhantm(playerid, params[])
{
	if(!IsPlayerInRangeOfPlayer(playerid, GetPVarInt(playerid, #invitedid), 8.0)) return SendErrorMessage(playerid, " Ban khong o gan nguoi moi nen khong the chap nhan.");
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMGInfo[GetPVarInt(playerid, #invitedgroup)][TMMembers] > 3) return SendErrorMessage(playerid, " Nhom da day, vui long tham gia nhom khac."), SetPVarInt(playerid, #invitedgroup, 0);
	if(TMInfo[playerid][GroupIDTM] != 0) return SendErrorMessage(playerid, " Ban dang o trong mot nhom nao do roi."), SetPVarInt(playerid, #invitedgroup, 0);
	if(GetPVarInt(playerid, #invitedgroup) != 0) 
	{
		new string[255];
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "[TM GROUP]: {ffffff}Ban da vao nhom thanh cong!");
		format(string, sizeof(string), "[TM GROUP]: {ffffff}Nguoi choi %s da gia nhap vao nhom.", GetPlayerNameEx(playerid));
		SendClientMessage(GetPVarInt(playerid, #invitedid), COLOR_LIGHTBLUE, string);
		TMInfo[playerid][GroupIDTM] = GetPVarInt(playerid, #invitedgroup);
		TMGInfo[GetPVarInt(playerid, #invitedgroup)][TMMembers]++;
		SetPVarInt(playerid, #invitedgroup, 0);
	}
	else return SendErrorMessage(playerid, " Ban khong nhan duoc loi moi tu bat ki ai.");
	return 1;
}
CMD:tuchoitm(playerid, params[])
{
	if(!IsPlayerInRangeOfPlayer(playerid, GetPVarInt(playerid, #invitedid), 8.0)) return SendErrorMessage(playerid, " Ban khong o gan nguoi moi nen khong the tu choi.");
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(GetPVarInt(playerid, #invitedgroup) != 0)
	{
		new string[255];
		SendClientMessage(playerid, COLOR_LIGHTRED, "[TM GROUP]: {ffffff}Ban da tu choi thanh cong!");
		format(string, sizeof(string), "[TM GROUP]: {ffffff}Nguoi choi %s da tu choi loi moi.", GetPlayerNameEx(playerid));
		SendClientMessage(GetPVarInt(playerid, #invitedid), COLOR_LIGHTRED, string);
		SetPVarInt(playerid, #invitedgroup, 0);
		SendClientMessage(playerid, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}Ban da tu choi loi moi tham gia nhom lam viec trashman thanh cong.");
	}
	else return SendErrorMessage(playerid, " Ban khong nhan duoc loi moi tu bat ki ai.");
	return 1;
}
CMD:radioteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban khong o trong bat ki nhom nao!");
	new string[555];
	if(!isnull(params))
	{
		foreach(new i: Player)
		{
			if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
			{
					format(string, sizeof(string), "[TM GROUP] {EA906C}%s(%d): %s", GetPlayerNameEx(playerid), i, params);
					SendClientMessage(i, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "(radio [tm]) %s", params);
					SetPlayerChatBubble(playerid, string, COLOR_WHITE, 15.0, 5000);
			}
		}
	}
	else return SendUsageMessage(playerid, " /radioteam [text] hoac /rd [text]");
	return 1;
}
CMD:rd(playerid, params[]) {
	return cmd_radioteam(playerid, params);
}
CMD:xemsorac(playerid, params[])
{
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban khong o trong bat ki nhom nao!");
	if(!IsPlayerInRangeOfVehicle(playerid, TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle], 5)) return SendErrorMessage(playerid, " Ban khong o gan phuong tien de xem rac.");
	new string[555];
	format(string, sizeof(string), "[TRASHMAN]: {ffffff}So rac trong xe cua ban la %d", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}
CMD:nhomcuatoi(playerid, params[]) {
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban khong o trong bat ki nhom nao!");
	new string[555], string2[555];
	format(string, sizeof(string), "{ff4747}>{ffffff} Thanh vien\n{1E88E5}> {ffffff}Tim xe cua nhom\n{ff4747}>{ffffff} Moi vao nhom\n{ff4747}>{ffffff} Moi ra khoi nhom\n{1E88E5}> {ffffff}Tro giup nhom\n{ff4747}> ROI KHOI NHOM", "Lua chon", "Huy bo");
	format(string2, sizeof(string2), "{1E88E5}NHOM LAM VIEC {ffffff}So rac trong xe [{ff4747}%d{ffffff}]", TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicleTrash]);
	Dialog_Show(playerid, trashmanager, DIALOG_STYLE_LIST,  string2,string, "Lua chon", "Huy bo");
	return 1;
}
CMD:trogiuptrashman(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTRED, "[TRASHMAN HELP]{ffffff} /quanlynhom, /vutrac, /chapnhantm, /tuchoitm, /radioteam (/rd).");
	return 1;
}
CMD:vutrac(playerid, params[])
{
	if(TrashOnFoot[playerid] != 1) return SendErrorMessage(playerid, " Ban dang khong cam rac tren tay.");
	TrashOnFoot[playerid] = 0;
	SendClientMessage(playerid, COLOR_LIGHTRED, "Ban da vut rac thanh cong.");
	RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
	StopLoopingAnim(playerid);
	TogglePlayerControllable(playerid, 1);
	KillTimer(TrashTimer[playerid]);
	return 1;
}