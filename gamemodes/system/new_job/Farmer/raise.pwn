#include <YSI\y_hooks>
#define MAX_CATTLES 16
#define CATTLE_DEFAULT_STATUS 0
#define ROW_1_POS_X -1424
#define ROW_1_POS_Y -1464
#define ROW_1_POS_Z 101

#define ROW_2_POS_X -1417
#define ROW_2_POS_Y -1464
#define ROW_2_POS_Z 101
#define OBJ_DEER 19315
#define OBJ_COW 19833

enum CATTLE_INFO{
	c_ID,
	c_Height,
	c_Status,
	c_Time,
	c_Owner,
	c_CattleObject,
	Text3D:c_CattleLabel,
	c_CattleTimer,
	c_Animal,
	Float:c_CattlePosX,
	Float:c_CattlePosY,
	Float:c_CattlePosZ
}
new RaiseCattleInfo[MAX_CATTLES][CATTLE_INFO];
new CountCattle = 0;
new CattleTimeChange = 120;
hook OnGameModeInit()
{
	for(new i = 0; i < MAX_CATTLES; i++){
		RaiseCattleInfo[i][c_ID] = -1;
	}
	return 1;
}
RS_CattleStatus(rs_c_status)
{
	new stt_str[1280];
	switch(rs_c_status)
	{
		case 0: stt_str="{0af762}Binh thuong{FFFFFF}";
		case 1: stt_str="{f7ef0a}Doi bung{FFFFFF}";
		case 2: stt_str="{5678f5}Khat Nuoc{FFFFFF}";
		default: stt_str="Khong xac dinh";
	}
	return stt_str;
}

RS_GetName(rs_c_type)
{
	new name_str[1280];
	switch(rs_c_type){
		case 0:name_str = "Bo";
		case 1: name_str = "Nai";
		default: name_str = "Khong xac dinh";
	}
	return name_str;
}
RS_FreeID()
{
	// if(CountCattle == MAX_CATTLES-1) return -1;

	new rs_fid;
	for(new i = 0; i < MAX_CATTLES; i++){
		if(RaiseCattleInfo[i][c_ID] == -1){
			rs_fid = i; 
			break;
		}
	}
	return rs_fid;
}
RaiseCattle(playerid, case_animal)
{
	if(CountCattle == 15) return SendFarmerJob(playerid, "Da full cho roi ban vui long quay lai sau nhe !");
	new rs_id = RS_FreeID();
	// printf("rs_id: %d", rs_id);

	new rs_height,Float:CattlePos[4], rs_object, rs_cattleinfo[1280];
	switch(case_animal)
	{
		case 0: {
			rs_height = random(25)+20;
			rs_object = OBJ_COW;

			if(CountCattle < 8) {
				CattlePos[0] = ROW_1_POS_X;
				CattlePos[2] = ROW_1_POS_Z-0.5;
				CattlePos[3] = -270;
				CattlePos[1] = ROW_1_POS_Y-(-1.7)*CountCattle;
			}
			else if(CountCattle < 16) {

				CattlePos[0] = ROW_2_POS_X;
				CattlePos[2] = ROW_2_POS_Z-0.5;
				CattlePos[3] = -90;
				CattlePos[1] = ROW_2_POS_Y-(-1.7)*(CountCattle-8);
			}
		}
		case 1: {
			rs_height = random(7)+1;
			rs_object = OBJ_DEER;
			if(CountCattle < 8) {
				CattlePos[0] = ROW_1_POS_X;
				CattlePos[2] = ROW_1_POS_Z;
				CattlePos[3] = 270;
				CattlePos[1] = ROW_1_POS_Y-(-1.7)*CountCattle;
			}
			else if(CountCattle < 16) {

				CattlePos[0] = ROW_2_POS_X;
				CattlePos[2] = ROW_2_POS_Z;
				CattlePos[3] = 0;
				CattlePos[1] = ROW_2_POS_Y-(-1.7)*(CountCattle-8);
			}
		}
		default: rs_height = 10;
	}
	RaiseCattleInfo[rs_id][c_ID] = rs_id;
	RaiseCattleInfo[rs_id][c_Height] = rs_height;
	RaiseCattleInfo[rs_id][c_Status] = CATTLE_DEFAULT_STATUS;
	RaiseCattleInfo[rs_id][c_Time] = CattleTimeChange;
	RaiseCattleInfo[rs_id][c_Owner] = playerid;
	RaiseCattleInfo[rs_id][c_Animal] = case_animal;


	RaiseCattleInfo[rs_id][c_CattlePosX] = CattlePos[0];
	RaiseCattleInfo[rs_id][c_CattlePosY] = CattlePos[1];
	RaiseCattleInfo[rs_id][c_CattlePosZ] = CattlePos[2];

	RaiseCattleInfo[rs_id][c_CattleObject] = CreateObject(rs_object, CattlePos[0], CattlePos[1], CattlePos[2], 0.00000, 0.00000, CattlePos[3], 100);

	// printf("%0.2f %0.2f %0.2f",CattlePos[0], CattlePos[1], CattlePos[2]);
	format(rs_cattleinfo, sizeof(rs_cattleinfo), 
		"{6e8dff}#%d{FFFFFF}\nGia suc: {6e8dff}%s{FFFFFF}\nTrang thai: {6e8dff}%s{FFFFFF}\nChu so huu: {6e8dff}%s{FFFFFF}\nSu dung {6e8dff}/feed %d{FFFFFF} de thao tac",
		RaiseCattleInfo[rs_id][c_ID],
		RS_GetName(case_animal),
		RS_CattleStatus(RaiseCattleInfo[rs_id][c_Status]),
		GetPlayerNameEx(playerid),
		RaiseCattleInfo[rs_id][c_ID]);
	RaiseCattleInfo[rs_id][c_CattleLabel] = CreateDynamic3DTextLabel(rs_cattleinfo, -1, CattlePos[0], CattlePos[1], CattlePos[2], 100);

	RaiseCattleInfo[rs_id][c_CattleTimer] = SetTimerEx("OnRaiseCattle", 1000, 1, "i", rs_id);
	CountCattle++;
	return 1;
}
RS_GetCattleStatus(playerid)
{
	new rs_status[1280];
	strcat(rs_status,"ID\tTen\tTrang thai\tThoi gian", sizeof(rs_status));
	for(new i = 0; i < MAX_CATTLES; i++)
	{
		if(RaiseCattleInfo[i][c_Owner] == playerid && RaiseCattleInfo[i][c_ID] != -1)
		{
			new rs_stt_info[1280];
			format(rs_stt_info, sizeof(rs_stt_info), 
				"\n{26e7ed}%d{FFFFFF}\t{2dfc98}%s{FFFFFF}\t{e7fc2d}%s{FFFFFF}\t%d",
				RaiseCattleInfo[i][c_ID],
				RS_GetName(RaiseCattleInfo[i][c_Animal]),
				RS_CattleStatus(RaiseCattleInfo[i][c_Status]),
				RaiseCattleInfo[i][c_Time]);
			strcat(rs_status,rs_stt_info, sizeof(rs_status));
		}
	}
	// strcat(rs_status,"\nEND", sizeof(rs_status));

	Dialog_Show(playerid, FARM_MENU_INFO, DIALOG_STYLE_TABLIST_HEADERS, "Theo doi gia suc", rs_status, ">>", "<<");
	return 1;
}
CMD:farm(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == JOB_FARMER || PlayerInfo[playerid][pJob2] == JOB_FARMER)
	{
		Dialog_Show(playerid, FARM_MENU, DIALOG_STYLE_LIST, "Quan li trang trai", "Nuoi them gia suc\nKiem tra tinh trang gia suc", "Chon", "Huy");
	}
	else SendFarmerJob(playerid, "Ban khong phai Nong Dan");
	return 1;
}

CMD:ftimep(playerid, params[])
{
	new f_id, f_time;
	if(sscanf(params, "ii", f_id, f_time)) return SendUsageMessage(playerid, "/ftimep [Cattle id] [time]");

	RaiseCattleInfo[f_id][c_Time] = f_time;
	return 1;
}

CMD:feed(playerid, params[])
{
	new c_selid;
	if(sscanf(params, "i", c_selid)) return SendUsageMessage(playerid, "/feed [ Cattle ID ]");

	if(RaiseCattleInfo[c_selid][c_Owner] == playerid && RaiseCattleInfo[c_selid][c_ID] != -1)
	{
		SetPVarInt(playerid, #Cattle_Nearing, c_selid);
		Dialog_Show(playerid, FARM_MENU_FEED, DIALOG_STYLE_LIST, "Thao tac gia suc", "Cho an\nCho uong\nBan", ">>", "<<");
	}
	else {
		SendFarmerJob(playerid, "Gia suc nay khong phai cua ban!");
	}
	return 1;
}

Dialog:FARM_MENU_FEED(playerid, response, listitem, inputtext[]) {
	if(response)
	{
		new c_nearing = GetPVarInt(playerid, #Cattle_Nearing);
		if(!c_nearing) return SendFarmerJob(playerid, "Loi thao tac!");

		if(listitem == 0)
		{
			if(RaiseCattleInfo[c_nearing][c_Status] == 1)
			{
				SendFarmerJob(playerid, "Ban da tiep do 1 cuc lua mi cho gia suc cua minh");
				RaiseCattleInfo[c_nearing][c_Time] = 1;
				RaiseCattleInfo[c_nearing][c_Status] = random(2);
			}
			else SendFarmerJob(playerid, "Gia suc cua ban khong doi bung !");
		}
		else if(listitem == 1)
		{
			if(RaiseCattleInfo[c_nearing][c_Status] == 2)
			{
				SendFarmerJob(playerid, "Ban da tiep nuoc cho gia suc cua minh");
				RaiseCattleInfo[c_nearing][c_Time] = 1;
				RaiseCattleInfo[c_nearing][c_Status] = random(2);
			}
			else SendFarmerJob(playerid, "Gia suc cua ban khong khat !");
		}
	}
	return 1;
}
Dialog:FARM_MENU(playerid, response, listitem, inputtext[]) {
	if(response)
	{
		if(listitem == 0)
		{
			new count_cattle[1280];
			format(count_cattle, sizeof(count_cattle), 
			"Ten\tSo luong\n\
			{fcff4f}Bo{FFFFFF}\t{4fb6ff}%d{ffffff}\n\
			{fcff4f}Nai{FFFFFF}\t{4fb6ff}%d{ffffff}",
			PlayerInfo[playerid][pBo],
			PlayerInfo[playerid][pNai]);

			Dialog_Show(playerid, CATTLE_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Quan li gia suc", count_cattle, "Chon", "Huy");
		}
		else if(listitem == 1)
		{
			RS_GetCattleStatus(playerid);
		}
	}
	return 1;
}

Dialog:CATTLE_MENU(playerid, response, listitem, inputtext[]) {
	if(response)
	{
		if(listitem == 0)
		{
			// if(PlayerInfo[playerid][pBo] <= 0) return SendFarmerJob(playerid, "Ban khong co gia suc nay !");
			RaiseCattle(playerid, 0);
		}
		else if(listitem == 1)
		{
			RaiseCattle(playerid, 1);
		}
	}
	return 1;
}


forward OnRaiseCattle(cattle_id);
public OnRaiseCattle(cattle_id)
{
	if(RaiseCattleInfo[cattle_id][c_Time] > 0 && RaiseCattleInfo[cattle_id][c_ID] != -1) RaiseCattleInfo[cattle_id][c_Time]--;
	else{
		RaiseCattleInfo[cattle_id][c_Time] = random(300);
		RaiseCattleInfo[cattle_id][c_Status] = random(2);
		new rs_cattleinfo[1280];
		format(rs_cattleinfo, sizeof(rs_cattleinfo), 
		"{6e8dff}#%d{FFFFFF}\nGia suc: {6e8dff}%s{FFFFFF}\nTrang thai: {6e8dff}%s{FFFFFF}\nChu so huu: {6e8dff}%s{FFFFFF}\nSu dung {6e8dff}/feed %d{FFFFFF} de thao tac",
		RaiseCattleInfo[cattle_id][c_ID],
		RS_GetName(RaiseCattleInfo[cattle_id][c_Owner]),
		RS_CattleStatus(RaiseCattleInfo[cattle_id][c_Status]),
		GetPlayerNameEx(playerid),
		RaiseCattleInfo[cattle_id][c_ID]);
		UpdateDynamic3DTextLabelText(RaiseCattleInfo[cattle_id][c_CattleLabel], -1, rs_cattleinfo);
	}
	return 1;
}