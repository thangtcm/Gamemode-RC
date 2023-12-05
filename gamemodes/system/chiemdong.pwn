/*
    ,============================================,
    |     Capture Gang (He thong chiem dong)    |
    |               29.11.2023                  |
    |         Script: Nicks / Nickzky           |
    *============================================*

    Contact :
    > FB : https://www.facebook.com/Nick.2208/
    > Discord : nicks6723
*/

/* -------------------------------- INCLUDE -------------------------------- */
#include <YSI_Coding\y_hooks>


/* -------------------------------- DEFINE -------------------------------- */
#define 		MAX_CAPTURE					100
#define         TIME_CHIEMDONG            300

/* -------------------------------- VARIABLES -------------------------------- */
//Capture Gang
enum DATA_CAPTURE 
{
	f_CaptureID,
	Float: f_PointChiemDong[3],
	
	f_chiemdong,
	f_PlayerName[32],
	f_PlayerID,
	f_FamilyID,
	f_HealthCD,
	f_TimeResetCD,
	
	f_captureObject,
    Text3D: f_captureLabel,

	// gang-zone family
	FamilyGangzone,
	Float: f_Max[2],
	Float: f_Min[2],
	f_CaptureType,
	f_CaptureActivity
};
new FamilyCD[MAX_CAPTURE][DATA_CAPTURE];
new ChiemDongTime = TIME_CHIEMDONG;
new bool:ChiemDong_Lock = true;

enum DataTypePoint
{
    TPoint_Name[30],
    TPoint_Amount
};
new TPointEdit[][DataTypePoint] = {
    {"{f4a460}Weapon{FFFFFF}", 1},
    {"{f4a460}Drug{FFFFFF}", 2},
    {"{f4a460}Money{FFFFFF}", 3},
    {"{f4a460}Ammo{FFFFFF}", 4}
};
/* -------------------------------- CALLBACK -------------------------------- */
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	if(dialogid == DIALOG_CAPTURE_CP && response == 1)
	{
		new stringz[100], zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[listitem][f_CaptureType];
		Get3DZone(FamilyCD[listitem][f_PointChiemDong][0],  FamilyCD[listitem][f_PointChiemDong][1],  FamilyCD[listitem][f_PointChiemDong][2], zone, sizeof(zone));
        format(stringz, sizeof(stringz), "> Dia ban chiem dong nay dang o khu vuc {ffa500}%s{FFFFFF} (type : %s)", zone, TPointEdit[typecap-1][TPoint_Name]);
		SendClientMessage(playerid, -1, stringz);
		SetPlayerCheckpoint(playerid, FamilyCD[listitem][f_PointChiemDong][0],  FamilyCD[listitem][f_PointChiemDong][1],  FamilyCD[listitem][f_PointChiemDong][2], 5.0);
	}
	if(dialogid == DIALOG_CAPTURE_MAIN && response == 1) {
		if(listitem == 0) return ShowPlayerDialog(playerid, DIALOG_CREATECAPTURE, DIALOG_STYLE_MSGBOX, "CAPTURE EDIT", "{ff0000}>{FFFFFF} Ban co muon dat vi tri chiem dong tai noi nay khong??", "Dong y", "Huy Bo");
		if(listitem == 1) {
			if(nearPointCD(playerid) == -1) {
				SendClientMessageEx(playerid, -1, "{AA3333}[!]{FFFFFF} Ban khong o gan mot vi tri /chiemdong nao de xoa het.");
				return 1;
			}
			new string[1280];
			format(string, 1280, "> Ban co muon xoa khu vuc chiem dong #ID_%d nay khong?", nearPointCD(playerid) + 1);
			SetPVarInt(playerid, "DeleteCaptureID", nearPointCD(playerid));
			ShowPlayerDialog(playerid, DIALOG_DELETECAPTURE, DIALOG_STYLE_MSGBOX, "CAPTURE EDIT", string, "Dong y", "Huy Bo");
		}
		if(listitem == 2) {

			if(nearPointCD(playerid) == -1) {
				SendClientMessageEx(playerid, -1, "{AA3333}[!]{FFFFFF} Ban can phai dung gan vi tri cua point chiem dong de luu #ID truoc khi tao gang-zone.");
				return 1;
			}

			new slot = nearPointCD(playerid);
			SetPVarInt(playerid, "gangzoneEdit", 1);
			SetPVarInt(playerid, "gangzoneFID", slot);

			new string[1280];
			format(string, sizeof(string), "[+] Ban da bat dau tao gang-zone cho khu vuc chiem dong #ID_%d", slot + 1);
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
			SendClientMessageEx(playerid, -1, "{FFFF00}[+]{FFFFFF} Ban da bat dau dieu chinh mot gang-zone, vui long su dung (/savezone) de luu vi tri.");
			return 1;
		}

		if(listitem == 3) {
			ShowPlayerDialog(playerid, DIALOG_DELGANGZONE, DIALOG_STYLE_INPUT, "CAPTURE EDIT", "{ff0000}>{FFFFFF} Ban vui long nhap #ID gang-zone ban muon xoa : ", "Dong y", "Huy Bo");
		}
		if(listitem == 4) {

            if(nearPointCD(playerid) == -1) {
				SendClientMessageEx(playerid, -1, "{AA3333}[!]{FFFFFF} Ban khong o gan mot vi tri chiem dong nao edit type het.");
				return 1;
			}
            new string[300];
            strcat(string, "Capture Type Name");
            for(new i; i < sizeof(TPointEdit); i ++)
            {
                format(string, sizeof(string), "%s\n%s", string, TPointEdit[i][TPoint_Name]);
            }    
			ShowPlayerDialog(playerid, DIALOG_TYPECAPTURE, DIALOG_STYLE_TABLIST_HEADERS, "CAPTURE EDIT - TYPE", string, "Chon", "Huy Bo");
		}
		if(listitem == 5) {

            if(nearPointCD(playerid) == -1) {
				SendClientMessageEx(playerid, -1, "{AA3333}[!]{FFFFFF} Ban khong o gan mot vi tri chiem dong nao edit type activity het.");
				return 1;
			}
			ShowPlayerDialog(playerid, DIALOG_ACTIVITY_CAPTURE, DIALOG_STYLE_LIST, "CAPTURE EDIT - ACTIVITY", "InActive\nActive", "Chon", "Huy Bo");
		}
	}

	if(dialogid == DIALOG_TYPECAPTURE && response == 1) {
		new string[1280];
		new fam = nearPointCD(playerid);
        // SetPVarInt(playerid, "DeleteCaptureID", nearPointCD(playerid));
		// SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("%d = %d", FamilyCD[nearPointCD(playerid)][f_CaptureType], TPointEdit[listitem][TPoint_Amount]));
		FamilyCD[fam][f_CaptureType] = TPointEdit[listitem][TPoint_Amount];
        format(string, 1280, ">{FFFFFF} Ban da dieu chinh thanh cong khu vuc chiem dong {FFFF00}#ID_%d{FFFFFF} thuoc type {FFFF00}%s", nearPointCD(playerid) + 1, TPointEdit[listitem][TPoint_Name]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		//
		new zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[fam][f_CaptureType];
		Get3DZone(FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][0],  FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][1],  FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][2], zone, sizeof(zone));
		format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}None{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
		UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, string);
		SaveCapture();
		return 1;
	}
	if(dialogid == DIALOG_ACTIVITY_CAPTURE && response == 1) {
		new string[1280];
		new fam = nearPointCD(playerid);
		FamilyCD[fam][f_CaptureActivity] = listitem;
		if(listitem == 0)format(string, 1280, ">{FFFFFF} Ban da dieu chinh thanh cong khu vuc chiem dong {FFFF00}#ID_%d{FFFFFF} sang trang thai {AA3333}InActive", nearPointCD(playerid) + 1);
		if(listitem == 1)format(string, 1280, ">{FFFFFF} Ban da dieu chinh thanh cong khu vuc chiem dong {FFFF00}#ID_%d{FFFFFF} sang trang thai {32cd32}Active", nearPointCD(playerid) + 1);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		SaveCapture();
		return 1;
	}

	if(dialogid == DIALOG_CREATECAPTURE && response == 1) {
		CreateCapture(playerid);
		return 1;
	}

	if(dialogid == DIALOG_DELETECAPTURE && response == 1) {
		new i = GetPVarInt(playerid, "DeleteCaptureID");
		DeleteFCapture(i); 

		new string[1280];
		format(string, sizeof(string), "[+] Ban da xoa khu vuc chiem dong #ID_%d thanh cong", i + 1);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, string);

		SaveCapture();
		return 1;
	}

	if(dialogid == DIALOG_DELGANGZONE && response == 1) {
		SendClientMessageEx(playerid, -1, "{AA3333}[!]{FFFFFF} Ban chi can xoa khu vuc chiem dong, se xoa luon gang-zone.");
		return 1;
	}	
	return 1;
}
hook OnPlayerDeath(playerid, killerid, reason) {
    if(GetPVarInt(playerid, "chiemdong") != 0) 
    {
    	new fam = GetPVarInt(playerid, "IDCapture");

        FamilyCD[fam][f_chiemdong] = 0;
		strcpy(FamilyCD[fam][f_PlayerName], "None", MAX_PLAYER_NAME);
		FamilyCD[fam][f_FamilyID] = INVALID_FAMILY_ID;
		FamilyCD[fam][f_PlayerID] = INVALID_PLAYER_ID;

        new string[1280];
		new zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[fam][f_CaptureType];
		Get3DZone(FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2], zone, sizeof(zone));
        format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}NONE{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem dong\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
		UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, string);

		// GangZoneStopFlashForAll(FamilyCD[fam][FamilyGangzone]);

        DeletePVar(playerid, "chiemdong");
        DeletePVar(playerid, "TimeChiemDong");
        DeletePVar(playerid, "IDCapture");

        SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Trang thai chiem dong cua ban da that bai vi da bi ha guc.");
        return 1;
    }
    return 1;
}
stock ChiemDong_OnplayerDisconnect(playerid)
{
	if(GetPVarInt(playerid, "chiemdong") != 0) 
    {
    	new fam = GetPVarInt(playerid, "IDCapture");

        FamilyCD[fam][f_chiemdong] = 0;
		strcpy(FamilyCD[fam][f_PlayerName], "None", MAX_PLAYER_NAME);
		FamilyCD[fam][f_FamilyID] = INVALID_FAMILY_ID;
		FamilyCD[fam][f_PlayerID] = INVALID_PLAYER_ID;

        new string[1280];
		new zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[fam][f_CaptureType];
		Get3DZone(FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2], zone, sizeof(zone));
        format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}NONE{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem dong\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
		UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, string);

		// GangZoneStopFlashForAll(FamilyCD[fam][FamilyGangzone]);

        DeletePVar(playerid, "chiemdong");
        DeletePVar(playerid, "TimeChiemDong");
        DeletePVar(playerid, "IDCapture");
    }
	if(GetPVarInt(playerid, "AwardTypeCD") != 0)
	{
		DeletePVar(playerid, "AwardTypeCD");
		DeletePVar(playerid, "CD_pX");
		DeletePVar(playerid, "CD_pY");
		DeletePVar(playerid, "CD_pZ");
	}	
	return 1;
}
//nhan thuong khi vao checkpoint
hook OnPlayerEnterCheckpoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 4.0, GetPVarFloat(playerid, "CD_pX"), GetPVarFloat(playerid, "CD_pY"), GetPVarFloat(playerid, "CD_pZ")))
	{
		if(PlayerInfo[playerid][pAwardTypeCD] != 0 && GetPVarInt(playerid, "AwardTypeCD") != 0)
		{
			SendClientMessage(playerid, COLOR_RED, "> Dang lay phan thuong vui long cho doi...");
			SetTimerEx("AwardCD", 30000, false, "d", playerid);
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 1, 1, 1, 1, 1, 1);
			
		}
	}
	return 1;
}
/* -------------------------------- FUNCTION -------------------------------- */
forward AwardCD(playerid);
public AwardCD(playerid) {

	//type weapon
	if(GetPVarInt(playerid, "AwardTypeCD") == 1)
	{
		//add them o day
		Inventory_Add(playerid, "AK47");
		Inventory_Add(playerid, "Vat_lieu", 100);
		Inventory_Add(playerid, "Go", 100);
		Inventory_Add(playerid, "item_iron", 100); // sat
		SendNewFamilyMessage(playerid, -1, "-------------------------------- {FFFF00}[AWARD CAPTURE GANG]{FFFFFF} -------------------------------------");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "> Ban da nhan thuong cho FAM/Gang thanh cong (Type Weapon) nhan nhung phan qua sau :");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "+ Weapon : AK47, 100 vat lieu, 200 go, 200 sat");
		DeletePVar(playerid, "AwardTypeCD");
		DeletePVar(playerid, "CD_pX");
		DeletePVar(playerid, "CD_pY");
		DeletePVar(playerid, "CD_pZ");
		PlayerInfo[playerid][pAwardTypeCD] = 0;
		DisableCheckPoint(playerid);
	}
	//type drug
	if(GetPVarInt(playerid, "AwardTypeCD") == 2)
	{
		//add them o day
		Inventory_Add(playerid, "chh_1", 100);
		Inventory_Add(playerid, "chh_1", 50);
		Inventory_Add(playerid, "Ecstacy", 20); // sat
		Inventory_Add(playerid, "LSD", 10); // sat
		SendNewFamilyMessage(playerid, -1, "-------------------------------- {FFFF00}[AWARD CAPTURE GANG]{FFFFFF} -------------------------------------");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "> Ban da nhan thuong cho FAM/Gang thanh cong (Type Drug) nhan nhung phan qua sau :");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "+ 100 chat hoa hoc 1, 50 chat hoa hoc 2, 20 Ecstasy , 10 LSD");
		DeletePVar(playerid, "AwardTypeCD");
		DeletePVar(playerid, "CD_pX");
		DeletePVar(playerid, "CD_pY");
		DeletePVar(playerid, "CD_pZ");
		PlayerInfo[playerid][pAwardTypeCD] = 0;
		DisableCheckPoint(playerid);
	}
	//type money
	if(GetPVarInt(playerid, "AwardTypeCD") == 3)
	{
		//add them o day
		
		new money = Random(100000, 300000);
		new string[70];
		Inventory_Add(playerid, "img dirty", money);
		SendNewFamilyMessage(playerid, -1, "-------------------------------- {FFFF00}[AWARD CAPTURE GANG]{FFFFFF} -------------------------------------");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "> Ban da nhan thuong cho FAM/Gang thanh cong (Type Dirty Money) nhan nhung phan qua sau :");
		format(string, sizeof(string), "+ %s$ tien ban (Them vao tui do)", number_format(money));
		SendNewFamilyMessage(playerid, COLOR_YELLOW, string);
		DeletePVar(playerid, "AwardTypeCD");
		DeletePVar(playerid, "CD_pX");
		DeletePVar(playerid, "CD_pY");
		DeletePVar(playerid, "CD_pZ");
		PlayerInfo[playerid][pAwardTypeCD] = 0;
		DisableCheckPoint(playerid);
	}
	//type ammo
	if(GetPVarInt(playerid, "AwardTypeCD") == 4)
	{
		//add them o day
		Inventory_Add(playerid, "Ammo1", 50); // Dan sung luc
		Inventory_Add(playerid, "Ammo2", 50); // Dan sung shotgun
		Inventory_Add(playerid, "Ammo3", 200); // Dan sung tieu lien
		Inventory_Add(playerid, "Ammo4", 100); // Dan sung truong
		SendNewFamilyMessage(playerid, -1, "-------------------------------- {FFFF00}[AWARD CAPTURE GANG]{FFFFFF} -------------------------------------");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "> Ban da nhan thuong cho FAM/Gang thanh cong (Type Ammo) nhan nhung phan qua sau :");
		SendNewFamilyMessage(playerid, COLOR_YELLOW, "+ 100 dan sung truong, 200 dan sung tieu lien, 50 dan Shotgun và 50 sung luc");
		DeletePVar(playerid, "AwardTypeCD");
		DeletePVar(playerid, "CD_pX");
		DeletePVar(playerid, "CD_pY");
		DeletePVar(playerid, "CD_pZ");
		PlayerInfo[playerid][pAwardTypeCD] = 0;
		DisableCheckPoint(playerid);
	}
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	return 1;
}
forward TimeChiemDong(playerid);
public TimeChiemDong(playerid) {
	new fam = GetPVarInt(playerid, "IDCapture");
    if(IsPlayerInRangeOfPoint(playerid, 70.0, FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2])) {

        SetPVarInt(playerid, "chiemdong", GetPVarInt(playerid, "chiemdong")-1);

        new string[15000];
        format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~%d giay con lai", GetPVarInt(playerid, "chiemdong"));
        GameTextForPlayer(playerid, string, 1100, 3);

        new family = FamilyCD[fam][f_FamilyID];

        new gangzone[1280];
		new zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[fam][f_CaptureType];
		Get3DZone(FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2], zone, sizeof(zone));
		format(gangzone, sizeof(gangzone), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {FFFF00}(F%d) %s{FFFFFF}\nTinh trang : %s (%d giay)\nNguoi chiem : {f0e68c}%s{FFFFFF}.", 
			zone, TPointEdit[typecap-1][TPoint_Name], family, FamilyInfo[family][FamilyName], statusCapture(FamilyCD[fam][f_chiemdong]), GetPVarInt(playerid, "chiemdong"), FamilyCD[fam][f_PlayerName]);
		UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, gangzone);

        if(GetPVarInt(playerid, "chiemdong") > 0) SetTimerEx("TimeChiemDong", 1000, 0, "d", playerid);
        if(GetPVarInt(playerid, "chiemdong") <= 0)
        {
            DeletePVar(playerid, "chiemdong");
            DeletePVar(playerid, "TimeChiemDong");

            FamilyCD[fam][f_chiemdong] = 2;
            FamilyCD[fam][f_HealthCD] = 9999;

			FamilyCD[fam][f_FamilyID] = PlayerInfo[playerid][pFMember];

			// GangZoneStopFlashForAll(FamilyCD[fam][FamilyGangzone]);

			format(gangzone, sizeof(gangzone), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {FFFF00}(F%d) %s{FFFFFF}\nTinh trang : %s {FFFFFF}(Health : {AA3333}%s%%{FFFFFF})\nNguoi chiem : {f0e68c}%s{FFFFFF}", 
				zone, TPointEdit[typecap-1][TPoint_Name], family, FamilyInfo[family][FamilyName], statusCapture(FamilyCD[fam][f_chiemdong]), number_format(FamilyCD[fam][f_HealthCD]), FamilyCD[fam][f_PlayerName]);
            
            UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, gangzone);

            // new zone[MAX_ZONE_NAME];
			// Get3DZone(FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2], zone, sizeof(zone));
			format(string, sizeof(string), "> Ban da chiem dong thanh cong khu vuc cua %s", zone);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        }
    }
    else {

		FamilyCD[fam][f_chiemdong] = 0;
		strcpy(FamilyCD[fam][f_PlayerName], "None", MAX_PLAYER_NAME);
		FamilyCD[fam][f_PlayerID] = INVALID_PLAYER_ID;
		FamilyCD[fam][f_FamilyID] = INVALID_FAMILY_ID;

        new string[1280];
        // format(string, sizeof(string), "Khu vuc chiem dong\n\nSo huu : {FFFF00}(F%d) %s{FFFFFF}\nTinh trang : Chua bi chiem\nSu dung: /chiemdong.", fam, FamilyInfo[fam][FamilyName]);
		new zone[MAX_ZONE_NAME];
		new typecap = FamilyCD[fam][f_CaptureType];
		Get3DZone(FamilyCD[fam][f_PointChiemDong][0],  FamilyCD[fam][f_PointChiemDong][1],  FamilyCD[fam][f_PointChiemDong][2], zone, sizeof(zone));
		format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}None{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem dong\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
        UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, string);

		// GangZoneStopFlashForAll(FamilyCD[fam][FamilyGangzone]);

        SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Ban da chiem dong that bai do chay ra xa khoi khu vuc chiem dong (70m).");

        DeletePVar(playerid, "chiemdong");
        DeletePVar(playerid, "TimeChiemDong");
        DeletePVar(playerid, "IDCapture");
        return 1;
    }
    return 1;
}

stock nearPointCD(playerid) {
	new slot = -1;
	for(new fam = 0; fam < MAX_CAPTURE; fam++) {
		if(IsPlayerInRangeOfPoint(playerid, 10.0, FamilyCD[fam][f_PointChiemDong][0], FamilyCD[fam][f_PointChiemDong][1], FamilyCD[fam][f_PointChiemDong][2])) {
			slot = fam;
			break;
		}
	}
	return slot;
}
stock statusCapture(id) {
    new name[1280];
    if(id == 0) name = "{fffacd}Chua bi chiem"; 
    else if(id == 1) name = "Dang bi chiem";
    else if(id == 2) name = "{32cd32}Da bi chiem dong";
    return name;
}

stock pointFamilyCD(playerid) {
	new slot = -1;
	for(new i = 0; i < MAX_CAPTURE; i++) {
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FamilyCD[i][f_PointChiemDong][0],  FamilyCD[i][f_PointChiemDong][1],  FamilyCD[i][f_PointChiemDong][2])) {
			slot = i;
			break;
		}
	}
	return slot;
}

stock ShowGangZone(playerid) 
{
    if(PlayerInfo[playerid][pFMember] != INVALID_FAMILY_ID && ChiemDong_Lock == false) {
        for(new fam = 0; fam < MAX_CAPTURE; fam++) 
            GangZoneShowForPlayer(playerid, FamilyCD[fam][FamilyGangzone], COLOR_YELLOW);
    }
}
stock HideGangZone(playerid) 
{
    if(PlayerInfo[playerid][pFMember] != INVALID_FAMILY_ID) {
        for(new fam = 0; fam < MAX_CAPTURE; fam++) 
            GangZoneHideForPlayer(playerid, FamilyCD[fam][FamilyGangzone]);
    }
}

stock nearCapture() {
	new slot = -1;
	for(new i = 0; i < MAX_CAPTURE; i++) {
		if(FamilyCD[i][f_CaptureID] == 0) {
			slot = i;
			break;
		}
	}
	return slot;
}

stock CreateCapture(playerid) {

	if(nearCapture() == -1) {
		SendClientMessageEx(playerid, -1, "{ff0000}>{FFFFFF} So luong chiem dong trong may chu da dat gioi han, khong the tao them.");
		return 1;
	}

	new fam = nearCapture();

	new string[1280];
    format(string,sizeof(string),"{ff0000}>{FFFFFF} Ban da tao thanh cong mot khu vuc chiem dong #ID_%d.", fam + 1);
	SendClientMessageEx(playerid, -1, string);

	new Float: Pos[3];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);

	FamilyCD[fam][f_PointChiemDong][0] = Pos[0];
	FamilyCD[fam][f_PointChiemDong][1] = Pos[1];
	FamilyCD[fam][f_PointChiemDong][2] = Pos[2];
	
	FamilyCD[fam][f_CaptureID] = fam + 1;

	FamilyCD[fam][f_chiemdong] = 0;
	FamilyCD[fam][f_PlayerName] = INVALID_PLAYER_ID;
	FamilyCD[fam][f_PlayerID] = INVALID_PLAYER_ID;
	FamilyCD[fam][f_FamilyID] = INVALID_FAMILY_ID;
	FamilyCD[fam][f_HealthCD] = 0;
	FamilyCD[fam][f_TimeResetCD] = 0;
	FamilyCD[fam][f_CaptureType] = 1;
	FamilyCD[fam][f_CaptureActivity] = 0;

	new zone[MAX_ZONE_NAME];
	new typecap = FamilyCD[fam][f_CaptureType];
	Get3DZone(FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][0],  FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][1],  FamilyCD[GetPVarInt(playerid, "IDCapture")][f_PointChiemDong][2], zone, sizeof(zone));
    format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}None{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap][TPoint_Name]);
    FamilyCD[fam][f_captureLabel] = CreateDynamic3DTextLabel(string, -1, Pos[0],  Pos[1],  Pos[2]+0.7, 50.0);
    FamilyCD[fam][f_captureObject] = CreateDynamicPickup(1239, 23, Pos[0],  Pos[1],  Pos[2]);

    SaveCapture();
	return 1;
}

stock DeleteFCapture(fam) {
	FamilyCD[fam][f_CaptureID] = 0;
	
	FamilyCD[fam][f_PointChiemDong][0] = 0;
	FamilyCD[fam][f_PointChiemDong][1] = 0;
	FamilyCD[fam][f_PointChiemDong][2] = 0;

	FamilyCD[fam][f_Max][0] = 0;
	FamilyCD[fam][f_Max][1] = 0;
	FamilyCD[fam][f_Min][0] = 0;
	FamilyCD[fam][f_Min][1] = 0;
	
	FamilyCD[fam][f_chiemdong] = 0;
	FamilyCD[fam][f_PlayerName] = INVALID_PLAYER_ID;
	FamilyCD[fam][f_PlayerID] = INVALID_PLAYER_ID;
	FamilyCD[fam][f_FamilyID] = INVALID_FAMILY_ID;
	FamilyCD[fam][f_HealthCD] = 0;
	FamilyCD[fam][f_TimeResetCD] = 0;
	
	DestroyDynamic3DTextLabel(FamilyCD[fam][f_captureLabel]);
	DestroyDynamicPickup(FamilyCD[fam][f_captureObject]);
	GangZoneDestroy(FamilyCD[fam][FamilyGangzone]);
	return 1;
}
stock myChiemDong()
{
	for(new iIndex = 0; iIndex < MAX_CAPTURE; iIndex++) {
		FamilyCD[iIndex][f_chiemdong] = 0;
	    strcpy(FamilyCD[iIndex][f_PlayerName], "None", MAX_PLAYER_NAME);
		FamilyCD[iIndex][f_PlayerID] = INVALID_PLAYER_ID;
	    FamilyCD[iIndex][f_FamilyID] = INVALID_FAMILY_ID;
	    FamilyCD[iIndex][f_HealthCD] = 0;
	    FamilyCD[iIndex][f_TimeResetCD] = 0;

		if(FamilyCD[iIndex][f_PointChiemDong][0] != 0) 
		{
			new string[16000];
			new zone[MAX_ZONE_NAME];
			new typecap = FamilyCD[iIndex][f_CaptureType];
			Get3DZone(FamilyCD[iIndex][f_PointChiemDong][0],  FamilyCD[iIndex][f_PointChiemDong][1],  FamilyCD[iIndex][f_PointChiemDong][2], zone, sizeof(zone));
			format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {ffff00}None{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
		    FamilyCD[iIndex][f_captureLabel] = CreateDynamic3DTextLabel(string, -1, FamilyCD[iIndex][f_PointChiemDong][0],  FamilyCD[iIndex][f_PointChiemDong][1],  FamilyCD[iIndex][f_PointChiemDong][2]+0.7, 50.0);
		    FamilyCD[iIndex][f_captureObject] = CreateDynamicPickup(1239, 23, FamilyCD[iIndex][f_PointChiemDong][0], FamilyCD[iIndex][f_PointChiemDong][1], FamilyCD[iIndex][f_PointChiemDong][2]);
		}

		if(FamilyCD[iIndex][f_Max][0] != 0) {
			FamilyCD[iIndex][FamilyGangzone] = GangZoneCreate(FamilyCD[iIndex][f_Min][0], FamilyCD[iIndex][f_Min][1], FamilyCD[iIndex][f_Max][0], FamilyCD[iIndex][f_Max][1]);
		}
	}
}
stock SaveCapture()
{
	new
		szFileStr[1024],
		File: fHandle = fopen("myCapture.cfg", io_write);

	for(new iIndex; iIndex < MAX_CAPTURE; iIndex++)
	{
		format(szFileStr, sizeof(szFileStr), "%d|%f|%f|%f|%f|%f|%f|%f|%d|%d\r\n",
		FamilyCD[iIndex][f_CaptureID],
		FamilyCD[iIndex][f_PointChiemDong][0],
		FamilyCD[iIndex][f_PointChiemDong][1],
		FamilyCD[iIndex][f_PointChiemDong][2],
		FamilyCD[iIndex][f_Max][0],
		FamilyCD[iIndex][f_Max][1],
		FamilyCD[iIndex][f_Min][0],
		FamilyCD[iIndex][f_Min][1],
		FamilyCD[iIndex][f_CaptureType],
		FamilyCD[iIndex][f_CaptureActivity]);
		fwrite(fHandle, szFileStr);
	}
 	return fclose(fHandle);
}

stock LoadCapture()
{
    if(!fexist("myCapture.cfg")) return 1;

	new szFileStr[200],
  		File: iFileHandle = fopen("myCapture.cfg", io_read),
  		iIndex;

	while(iIndex < MAX_CAPTURE && fread(iFileHandle, szFileStr))
	{
		sscanf(szFileStr, "p<|>dfffffffdd",
		FamilyCD[iIndex][f_CaptureID],
		FamilyCD[iIndex][f_PointChiemDong][0],
		FamilyCD[iIndex][f_PointChiemDong][1],
		FamilyCD[iIndex][f_PointChiemDong][2],
		FamilyCD[iIndex][f_Max][0],
		FamilyCD[iIndex][f_Max][1],
		FamilyCD[iIndex][f_Min][0],
		FamilyCD[iIndex][f_Min][1],
		FamilyCD[iIndex][f_CaptureType],
		FamilyCD[iIndex][f_CaptureActivity]);
  		++iIndex;
	}
	myChiemDong();
	printf("> Load thanh cong chiem dong");
 	return fclose(iFileHandle);
}
task UpdateCapture[6000] ()
{
    for(new i = 0; i < MAX_CAPTURE; i++) 
    {
    	if(FamilyCD[i][f_chiemdong] == 2) 
    	{
    		if(FamilyCD[i][f_HealthCD] > 0) 
    		{
    			FamilyCD[i][f_HealthCD] -= 1000+random(1000);

    			new string[5000];
				// new diempoint = random(100);
    			new zone[MAX_ZONE_NAME];
				new typecap = FamilyCD[i][f_CaptureType];
        		Get3DZone(FamilyCD[i][f_PointChiemDong][0],  FamilyCD[i][f_PointChiemDong][1],  FamilyCD[i][f_PointChiemDong][2], zone, sizeof(zone));
    			
    			format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {FFFF00}(F%d) %s{FFFFFF}\nTinh trang : %s {FFFFFF}(Health : {AA3333}%s%%{FFFFFF})\nNguoi chiem : {f0e68c}%s{FFFFFF}.", 
    				zone, TPointEdit[typecap-1][TPoint_Name], FamilyCD[i][f_FamilyID], FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName], statusCapture(FamilyCD[i][f_chiemdong]), number_format(FamilyCD[i][f_HealthCD]), FamilyCD[i][f_PlayerName]);
            	
            	UpdateDynamic3DTextLabelText(FamilyCD[i][f_captureLabel], -1, string);

    			if(FamilyCD[i][f_HealthCD] < 0) 
    			{
					foreach(new iz: Player)
					{
						if(PlayerInfo[iz][pFMember] != INVALID_FAMILY_ID)
						{
							// new Message[5000];
							SendClientMessage(iz, -1, "");
							SendClientMessage(iz, -1, "");
							SendClientMessage(iz, -1, "{FFFFFF}-------------------------- {FFFF00}[CAPTURE GANG]{FFFFFF} ---------------------------");
							new thongbao[5000];
							format(thongbao, sizeof thongbao, "[CHIEM DONG] Nguoi choi {bebebe}%s{FFFFFF} thuoc {ffa500}(F%d) %s{FFFFFF} da hoan thanh viec chiem dong khu vuc {778899}%s{FFFFFF} thuoc type (%s).", FamilyCD[i][f_PlayerName], FamilyCD[i][f_FamilyID], FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName], zone, TPointEdit[typecap-1][TPoint_Name]);
							SendClientMessage(iz, -1, thongbao);
							SendClientMessage(iz, -1, "{FFFFFF}-------------------------------------------------------------------------------------");
							SendClientMessage(iz, -1, "");
							SendClientMessage(iz, -1, "");
						}
					}
					/* switch(diempoint)
					{
						case 0..50 :
						{
							FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyPoint] += 1;
							format(string, sizeof(string), "[CHIEM DONG] %s co duoc cho minh 1 Point tu khu vuc chiem dong cua ho", FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName]);
							SendClientMessageToAllEx(COLOR_YELLOW, string);
						}
						case 51..85 :
						{
							FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyPoint] += 2;
							format(string, sizeof(string), "[CHIEM DONG] %s co duoc cho minh 2 Point tu khu vuc chiem dong cua ho", FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName]);
							SendClientMessageToAllEx(COLOR_YELLOW, string);
						}
						case 86..100 :
						{
							FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyPoint] += 3;
							format(string, sizeof(string), "[CHIEM DONG] %s co duoc cho minh 3 Point tu khu vuc chiem dong cua ho", FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName]);
							SendClientMessageToAllEx(COLOR_YELLOW, string);
						}
					} */
					new player = FamilyCD[i][f_PlayerID];
					switch(random(4))
					{
						case 0:
						{
							SetPVarFloat(player, "CD_pX", 1274.2429);
							SetPVarFloat(player, "CD_pY", 294.1344);
							SetPVarFloat(player, "CD_pZ", 1274.2429);
							SetPlayerCheckpoint(player, GetPVarFloat(player, "CD_pX"), GetPVarFloat(player, "CD_pY"), GetPVarFloat(player, "CD_pZ"), 4.0);
						}	
						case 1: 
						{
							SetPVarFloat(player, "CD_pX",  2351.2170);
							SetPVarFloat(player, "CD_pY", -647.6680);
							SetPVarFloat(player, "CD_pZ", 128.0547);
							SetPlayerCheckpoint(player, GetPVarFloat(player, "CD_pX"), GetPVarFloat(player, "CD_pY"), GetPVarFloat(player, "CD_pZ"), 4.0);
						}	
						case 2: 
						{
							SetPVarFloat(player, "CD_pX",  313.7180);
							SetPVarFloat(player, "CD_pY",	1146.4028);
							SetPVarFloat(player, "CD_pZ", 8.5859);
							SetPlayerCheckpoint(player, GetPVarFloat(player, "CD_pX"), GetPVarFloat(player, "CD_pY"), GetPVarFloat(player, "CD_pZ"), 4.0);
						}	
						case 3: 
						{
							SetPVarFloat(player, "CD_pX",  -2088.1040);
							SetPVarFloat(player, "CD_pY", -2342.5239);
							SetPVarFloat(player, "CD_pZ", 30.6250);
							SetPlayerCheckpoint(player, GetPVarFloat(player, "CD_pX"), GetPVarFloat(player, "CD_pY"), GetPVarFloat(player, "CD_pZ"), 4.0);
						}	
					}
					PlayerPlaySound(player, 1056, 0.0, 0.0, 0.0);
					SetPVarInt(player, "AwardTypeCD", FamilyCD[i][f_CaptureType]);
					PlayerInfo[player][pAwardTypeCD] = FamilyCD[i][f_CaptureType];
					// SendClientMessage(player, -1, sprintf("> type award : %d", GetPVarInt(player, "AwardTypeCD")));
					SendClientMessage(player, COLOR_GREEN, "> Ban da chiem dong thanh cong cho FAM/GANG cua minh . Hay den checkpoint de nhan thuong");
					SendClientMessage(player, COLOR_RED, "* Luu y : Neu ban bi thoat game khi chua nhan phan thuong [/glayhang] de dung khi vao lai game *");
                	
					
					//update label
					format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {f4a460}(F%d) %s{FFFFFF}\nTinh trang : {32cd32}Da bi chiem dong", 
                		zone, TPointEdit[typecap-1][TPoint_Name], FamilyCD[i][f_FamilyID], FamilyInfo[FamilyCD[i][f_FamilyID]][FamilyName]);

                	UpdateDynamic3DTextLabelText(FamilyCD[i][f_captureLabel], -1, string);
    				
    				FamilyCD[i][f_chiemdong] = 0;
    				FamilyCD[i][f_HealthCD] = 0;
					strcpy(FamilyCD[i][f_PlayerName], "None", MAX_PLAYER_NAME);
					FamilyCD[i][f_PlayerID] = INVALID_PLAYER_ID;
					FamilyCD[i][f_TimeResetCD] = 10;
    			}
    		}
    	}
    }
}

task ResetCapture[60000]() {
	for(new i = 1; i < MAX_FAMILY; i++) {
		if(FamilyCD[i][f_TimeResetCD] != 0) {
			FamilyCD[i][f_TimeResetCD] -= 1;

			if(FamilyCD[i][f_TimeResetCD] == 0) 
			{
				new string[1280];
				new zone[MAX_ZONE_NAME];
				new typecap = FamilyCD[i][f_CaptureType];
				Get3DZone(FamilyCD[i][f_PointChiemDong][0],  FamilyCD[i][f_PointChiemDong][1],  FamilyCD[i][f_PointChiemDong][2], zone, sizeof(zone));
				format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {00ff00}None{FFFFFF}\nTinh trang : {fffacd}Chua bi chiem dong\n{FFFFFF}Su dung: /chiemdong.", zone, TPointEdit[typecap-1][TPoint_Name]);
				UpdateDynamic3DTextLabelText(FamilyCD[i][f_captureLabel], -1, string);

				FamilyCD[i][f_chiemdong] = 0;
				FamilyCD[i][f_HealthCD] = 0;
				strcpy(FamilyCD[i][f_PlayerName], "None", MAX_PLAYER_NAME);
				FamilyCD[i][f_PlayerID] = INVALID_PLAYER_ID;
				FamilyCD[i][f_FamilyID] = INVALID_FAMILY_ID;
				FamilyCD[i][f_TimeResetCD] = 0;
			}
		}
	}
}
/* -------------------------------- COMMAND -------------------------------- */
CMD:fcapture(playerid, paramsp[]) {
	if(PlayerInfo[playerid][pAdmin] == 99999 || PlayerInfo[playerid][pGangModerator] >= 1)
		ShowPlayerDialog(playerid, DIALOG_CAPTURE_MAIN, DIALOG_STYLE_LIST, "CAPTURE EDIT", "{ff0000}>{FFFFFF} Tao chiem dong\n{ff0000}>{FFFFFF} Xoa chiem dong\n{00bfff}>{FFFFFF} Tao gang-zone\n{00bfff}>{FFFFFF} Xoa gang-zone\n{FFFF00}>{FFFFFF} Edit Type Capture\n{FFFF00}>{FFFFFF} Edit Activity Capture", "Dong y", "Huy bo");
	return 1;
}
CMD:savezone(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 99999 || PlayerInfo[playerid][pGangModerator] >= 1) 
    {

        new string[1280];
        new stage = GetPVarInt(playerid, "gangzoneEdit");
        new Float:x, Float: y, Float: z;
        new Float:tminx, Float: tminy, Float: tmaxx, Float: tmaxy;
        GetPlayerPos(playerid, x, y, z);
        if(stage == -1) {
            SendClientMessageEx(playerid, COLOR_GRAD2, "Ban khong duoc chinh sua kich thuoc Turf ngay bay gio!");
            return 1;
        }
        else {
            switch(stage) {
                case 1:
                {
                    SetPVarFloat(playerid, "gangzoneMinX", x);
                    format(string,sizeof(string),"X=%f, Y=%f, Z=%f",x,y,z);
                    SendClientMessageEx(playerid, COLOR_GRAD2, string);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[+] Ban da luu thanh cong toa do (Min X) cua gang-zone thanh cong (/savezone) de tiep tuc.");
                    SetPVarInt(playerid, "gangzoneEdit", 2);
                }
                case 2:
                {
                    SetPVarFloat(playerid, "gangzoneMinY", y);
                    format(string,sizeof(string),"X=%f, Y=%f, Z=%f",x,y,z);
                    SendClientMessageEx(playerid, COLOR_GRAD2, string);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[+] Ban da luu thanh cong toa do (Min Y) cua gang-zone thanh cong (/savezone) de tiep tuc.");
                    SetPVarInt(playerid, "gangzoneEdit", 3);
                }
                case 3:
                {
                    SetPVarFloat(playerid, "gangzoneMaxX", x);
                    format(string,sizeof(string),"X=%f, Y=%f, Z=%f",x,y,z);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[+] Ban da chinh sua thanh cong Turf East Wall.");
                    SendClientMessageEx(playerid, COLOR_GRAD2, string);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[+] Ban da luu thanh cong toa do (Max X) cua gang-zone thanh cong (/savezone) de tiep tuc.");
                    SetPVarInt(playerid, "gangzoneEdit", 4);
                }
                case 4:
                {
                	SendClientMessageEx(playerid, COLOR_YELLOW, "[+] Ban da hoan thanh viec luu toa do gang-zone thanh cong.");

                    new fam = GetPVarInt(playerid, "gangzoneFID");
                    
                    SetPVarFloat(playerid, "gangzoneMaxY", y);
                    SetPVarInt(playerid, "gangzoneEdit", -1);

                    tminx = GetPVarFloat(playerid, "gangzoneMinX");
                    tminy = GetPVarFloat(playerid, "gangzoneMinY");
                    tmaxx = GetPVarFloat(playerid, "gangzoneMaxX");
                    tmaxy = GetPVarFloat(playerid, "gangzoneMaxy");
                    
                    FamilyCD[fam][f_Min][0] = tminx;
                    FamilyCD[fam][f_Min][1] = tminy;
                    
                    FamilyCD[fam][f_Max][0]  = tmaxx;
                    FamilyCD[fam][f_Max][1] = tmaxy;

                    SetPVarFloat(playerid, "gangzoneMinX", 0.0);
                    SetPVarFloat(playerid, "gangzoneMinY", 0.0);
                    SetPVarFloat(playerid, "gangzoneMaxX", 0.0);
                    SetPVarFloat(playerid, "gangzoneMaxy", 0.0);
					//----------------------------------------------------------
					FamilyCD[fam][FamilyGangzone] = GangZoneCreate(FamilyCD[fam][f_Min][0],FamilyCD[fam][f_Min][1],FamilyCD[fam][f_Max][0],FamilyCD[fam][f_Max][1]);

                    foreach(new i: Player) {
    					GangZoneShowForPlayer(i, FamilyCD[fam][FamilyGangzone], COLOR_YELLOW);
					}

					SaveCapture();
					//----------------------------------------------------------
                }
            }
        }
    }
    else {
        SendClientMessageEx(playerid, COLOR_GRAD2, "Ban khong du kha nang su dung lenh nay!");
    }
    return 1;
}
//lenh cho mem
CMD:diaban(playerid, params[]) {
    if(PlayerInfo[playerid][pFMember] != INVALID_FAMILY_ID) {
    	new string[15000];
        for(new i = 0; i < MAX_CAPTURE; i++) {
        	if(FamilyCD[i][f_PointChiemDong][0] != 0)  
        	{
        		// STT | Dia ban (Ten family) | Vi tri | Tinh trang
        		new zone[MAX_ZONE_NAME];
    			Get3DZone(FamilyCD[i][f_PointChiemDong][0],  FamilyCD[i][f_PointChiemDong][1],  FamilyCD[i][f_PointChiemDong][2], zone, sizeof(zone));
        		if(FamilyCD[i][f_FamilyID] != INVALID_FAMILY_ID) {
        			new fam = FamilyCD[i][f_FamilyID];
        			format(string, sizeof(string), "%s{00ff00}(F%d) %s{FFFFFF}\t%s\t%s\t%s\n", string, fam, FamilyInfo[fam][FamilyName], zone, statusCapture(FamilyCD[i][f_chiemdong]), FamilyCD[i][f_CaptureActivity] ? "{f0e68c}Active":"{AA3333}InActive");
        		}
        		else 
        			format(string, sizeof(string), "%s{00ff00}None{FFFFFF}\t%s\t%s\t%s\n", string, zone, statusCapture(FamilyCD[i][f_chiemdong]), FamilyCD[i][f_CaptureActivity] ? "{f0e68c}Active":"{AA3333}InActive");

        	}
        }
        if(isnull(string)) {
        	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Dia ban", "Hien tai chua co dia ban nao trong may chu het.", "Dong y", "Huy bo");
        	return 1;
        }
        new str_capture[15000];
        format(str_capture, sizeof(str_capture), "Dia ban\tVi tri\tTinh trang\tLock\n%s", string);
        ShowPlayerDialog(playerid, DIALOG_CAPTURE_CP, DIALOG_STYLE_TABLIST_HEADERS, "Dia ban", str_capture, "Dong y", "Huy bo");
        return 1;
    }else SendClientMessage(playerid, -1, "> Ban khong o trong mot Family nao de co the xem dia ban het.");
    return 1;
}
CMD:chiemdong(playerid, params[])
{
    if(pointFamilyCD(playerid) == -1)
    	return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Ban khong o gan mot khu vuc chiem dong nao het");

	if(ChiemDong_Lock)
		return SendClientMessageEx(playerid, COLOR_GREY, "> He thong chiem dong dang bi khoa , chua den khung gio chiem dong hang ngay");

	if(PlayerInfo[playerid][pFMember] == INVALID_FAMILY_ID)
		return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Ban can phai trong mot Family/Gangster moi co the chiem dong.");

	if(PlayerInfo[playerid][pRank] < 5)
		return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Ban can phai dat muc Rank 5, Rank 6... de co the chiem dong");


    new fam = pointFamilyCD(playerid);

    if(FamilyCD[fam][f_chiemdong] != 0)
    	return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Khu vuc nay tam thoi dang bi chiem dong roi , ban khong the chiem dong tiep tuc");

    if(FamilyCD[fam][f_TimeResetCD] != 0)
    	return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Khu vuc nay moi bi chiem dong truoc do , khong the chiem dong tiep tuc den khi reset sau 10 phut");
		
    if(FamilyCD[fam][f_CaptureActivity] == 0)
    	return SendClientMessage(playerid, -1, "{AA3333}[!]{FFFFFF} Khu vuc chiem dong nay khong hoat dong , vui long [/diaban] de xem");

    FamilyCD[fam][f_chiemdong] = 1;
    strcpy(FamilyCD[fam][f_PlayerName], GetPlayerNameEx(playerid), MAX_PLAYER_NAME);
    FamilyCD[fam][f_PlayerID] = playerid;
	FamilyCD[fam][f_FamilyID] = PlayerInfo[playerid][pFMember];

    SetPVarInt(playerid, "chiemdong", ChiemDongTime);
	SetTimerEx("TimeChiemDong", 1000, 0, "d", playerid);

	SetPVarInt(playerid, "IDCapture", fam);

	new string[15000];
	new zone[MAX_ZONE_NAME];
	new Familyid = GetPVarInt(playerid, "IDCapture");
	new typecap = FamilyCD[fam][f_CaptureType];
	Get3DZone(FamilyCD[Familyid][f_PointChiemDong][0],  FamilyCD[Familyid][f_PointChiemDong][1],  FamilyCD[Familyid][f_PointChiemDong][2], zone, sizeof(zone));
	format(string, sizeof(string), "Khu vuc chiem dong : %s (%s)\n\nSo huu : {FFFF00}(F%d) %s{FFFFFF}\nTinh trang : %s (%d giay)\n{FFFFFF}Nguoi chiem : %s.", 
		zone, TPointEdit[typecap-1][TPoint_Name], PlayerInfo[playerid][pFMember], FamilyInfo[PlayerInfo[playerid][pFMember]][FamilyName], statusCapture(FamilyCD[fam][f_chiemdong]), GetPVarInt(playerid, "chiemdong"), FamilyCD[fam][f_PlayerName]);
	
	UpdateDynamic3DTextLabelText(FamilyCD[fam][f_captureLabel], -1, string);

	// GangZoneFlashForAll(FamilyCD[fam][FamilyGangzone], COLOR_RED);
	foreach(new i: Player)
	{
	    if(PlayerInfo[i][pFMember] != INVALID_FAMILY_ID) {
			SendClientMessage(i, -1, "");
			SendClientMessage(i, -1, "");
			SendClientMessage(i, -1, "-------------------------------- {FFFF00}[CAPTURE GANG]{FFFFFF} -------------------------------------");
	        new stringz[5000];
			format(stringz, sizeof(stringz), "{FFFF00}%s{FFFFFF} thuoc {f0e68c}(F%d) %s{FFFFFF} dang co gang de chiem dong khu vuc %s ", GetPlayerNameEx(playerid),  PlayerInfo[playerid][pFMember], FamilyInfo[ PlayerInfo[playerid][pFMember]][FamilyName], zone);
			SendClientMessage(i, -1, stringz);
			SendClientMessage(i, -1, "-------------------------------------------------------------------------------------------------");
			format(stringz, sizeof(stringz), "{f4a460}>{FFFFFF} Khu vuc nay se thuoc so huu cua ho trong vong %d giay {f4a460}<{FFFFFF}", ChiemDongTime);
			SendClientMessage(i, -1, stringz);
			SendClientMessage(i, -1, "");
			SendClientMessage(i, -1, "");

	    }
	}
	SendClientMessage(playerid, -1, "{FFFF00}[+]{FFFFFF} Ban da bat dau chiem dong khu vuc nay, ban khong duoc phep di chuyen qua 100m hoac bi giet se huy bo trang thai chiem dong.");

    return 1;
}
CMD:showzone(playerid) {
	ShowGangZone(playerid);
    return 1;
}
CMD:hidezone(playerid)
{
	HideGangZone(playerid);
	return 1;
}
CMD:settimeturf(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 && PlayerInfo[playerid][pGangModerator] > 0)
	{
		new string[128], amount;
		if(sscanf(params, "d", amount))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /settimeturf [amount]");
			return 1;
		}
        ChiemDongTime = amount;
        format(string, sizeof(string), "{FFFF00}[+]{FFFFFF} Ban da dieu chinh thoi gian chiem dong Turf thanh ({00FFF0}%ds{FFFFFF})",amount);
        SendClientMessageEx(playerid, -1, string);
	}
    else SendClientMessage(playerid, COLOR_GRAD1, "Ban khong the dung lenh nay");
	return 1;
}
stock AutoOpenChiemDong()
{
	for(new cap = 0; cap < MAX_CAPTURE; cap++) {
		if(FamilyCD[cap][f_PointChiemDong][0] != 0.0)
			FamilyCD[cap][f_CaptureActivity] = 0;
	}
	ChiemDong_Lock = false;
	foreach(new iz: Player)
	{
		if(PlayerInfo[iz][pFMember] != INVALID_FAMILY_ID)
		{
			// new Message[5000];
			SendClientMessage(iz, -1, "");
			SendClientMessage(iz, -1, "");
			SendClientMessage(iz, -1, "{FFFFFF}-------------------------- {FFFF00}[CAPTURE GANG - OPEN]{FFFFFF} ---------------------------");
			ShowGangZone(iz);
		}
	}
	new i = 0;
	while(i < 2) 
    {
		new cap = random(MAX_CAPTURE);
		if(FamilyCD[cap][f_PointChiemDong][0] != 0.0)
		{
			i++;
			FamilyCD[cap][f_CaptureActivity] = 1;
			new zone[MAX_ZONE_NAME];
			Get3DZone(FamilyCD[cap][f_PointChiemDong][0],  FamilyCD[cap][f_PointChiemDong][1],  FamilyCD[cap][f_PointChiemDong][2], zone, sizeof(zone));
			GangZoneFlashForAll(FamilyCD[cap][FamilyGangzone], COLOR_RED);
			foreach(new iz: Player)
			{
				if(PlayerInfo[iz][pFMember] != INVALID_FAMILY_ID)
				{
					new thongbao[5000];
					format(thongbao, sizeof thongbao, "[CHIEM DONG] Khu vuc dia ban {f4a460}%s{FFFFFF} da mo trang thai chiem dong {f4a460}[/diaban].", zone);
					SendClientMessage(iz, -1, thongbao);
				}
			}
		}
	}	
	return 1;
}
stock AutoLockChiemDong()
{
	ChiemDong_Lock = true;
	for(new cap = 0; cap < MAX_CAPTURE; cap++) {
		if(FamilyCD[cap][f_PointChiemDong][0] != 0.0)
		{
			FamilyCD[cap][f_CaptureActivity] = 0;
			GangZoneStopFlashForAll(FamilyCD[cap][FamilyGangzone]);
		}
	}
	foreach(new iz: Player)
	{
		if(PlayerInfo[iz][pFMember] != INVALID_FAMILY_ID)
		{
			SendClientMessage(iz, -1, "");
			SendClientMessage(iz, -1, "{FFFFFF}-------------------------- {AA3333}[CAPTURE GANG - CLOSED]{FFFFFF} ---------------------------");
			SendClientMessage(iz, -1, "[CHIEM DONG] Cac dia ban da dong lai theo khung gio quy dinh chiem dong cua may chu.");
			SendClientMessage(iz, -1, "");
			HideGangZone(iz);
		}
	}
	return 1;
}
CMD:modiaban(playerid)
{
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "[+] Mo random dia diem chiem dong thanh cong");
	AutoOpenChiemDong();
	return 1;
}
CMD:khoadiaban(playerid)
{
	SendClientMessage(playerid, COLOR_RED, "[-] Khoa all dia diem chiem dong auto thanh cong");
	AutoLockChiemDong();
	return 1;
}
CMD:khoachiemdong(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4 && PlayerInfo[playerid][pGangModerator] < 1)
 		SendClientMessageEx( playerid, COLOR_WHITE, "Ban khong the dung lenh nay" );
	else
	{
		new string[80];
		if(!ChiemDong_Lock)
		{
			ChiemDong_Lock = true;
			format(string, sizeof(string), "[CAPTURE]: Admin %s da khoa he thong chiem dong.", GetPlayerNameEx(playerid));
			ABroadCast(COLOR_ORANGE, string, 2);
		}
		else
		{
			format(string, sizeof(string), "[CAPTURE]: Admin %s da mo he thong chiem dong.", GetPlayerNameEx(playerid));
			ABroadCast(COLOR_ORANGE, string, 2);
			ChiemDong_Lock = false;
		}
	}
	return 1;
}
CMD:glayhang(playerid)
{
	if(PlayerInfo[playerid][pAwardTypeCD] != 0 && GetPVarInt(playerid, "AwardTypeCD") == 0)
	{
		switch(random(4))
		{
			case 0:
			{
				SetPVarFloat(playerid, "CD_pX", 1274.2429);
				SetPVarFloat(playerid, "CD_pY", 294.1344);
				SetPVarFloat(playerid, "CD_pZ", 1274.2429);
				SetPlayerCheckpoint(playerid, GetPVarFloat(playerid, "CD_pX"), GetPVarFloat(playerid, "CD_pY"), GetPVarFloat(playerid, "CD_pZ"), 4.0);
			}	
			case 1: 
			{
				SetPVarFloat(playerid, "CD_pX",  2351.2170);
				SetPVarFloat(playerid, "CD_pY", -647.6680);
				SetPVarFloat(playerid, "CD_pZ", 128.0547);
				SetPlayerCheckpoint(playerid, GetPVarFloat(playerid, "CD_pX"), GetPVarFloat(playerid, "CD_pY"), GetPVarFloat(playerid, "CD_pZ"), 4.0);
			}	
			case 2: 
			{
				SetPVarFloat(playerid, "CD_pX",  313.7180);
				SetPVarFloat(playerid, "CD_pY",	1146.4028);
				SetPVarFloat(playerid, "CD_pZ", 8.5859);
				SetPlayerCheckpoint(playerid, GetPVarFloat(playerid, "CD_pX"), GetPVarFloat(playerid, "CD_pY"), GetPVarFloat(playerid, "CD_pZ"), 4.0);
			}	
			case 3: 
			{
				SetPVarFloat(playerid, "CD_pX",  -2088.1040);
				SetPVarFloat(playerid, "CD_pY", -2342.5239);
				SetPVarFloat(playerid, "CD_pZ", 30.6250);
				SetPlayerCheckpoint(playerid, GetPVarFloat(playerid, "CD_pX"), GetPVarFloat(playerid, "CD_pY"), GetPVarFloat(playerid, "CD_pZ"), 4.0);
			}	
		}
		PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
		SetPVarInt(playerid, "AwardTypeCD", PlayerInfo[playerid][pAwardTypeCD]);
		// SendClientMessage(player, -1, sprintf("> type award : %d", GetPVarInt(player, "AwardTypeCD")));
		SendClientMessage(playerid, COLOR_GREEN, "> Hay den dia diem checkpoint de nhan phan thuong cho FAM/GANG cua minh .");
	}
	else SendClientMessage(playerid, COLOR_RED, "> Ban khong chiem dong thanh cong dia ban nao de nhan phan thuong cho FAM/GANG cua minh");
	return 1;
}