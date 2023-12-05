#include <YSI_Coding\y_hooks>
#define MAX_DRUG_POINT 10
enum DrugLab {
	Float:DLab_Postion[3],
	DLab_Int,
	DLab_Vw,
	DLab_PickUP,
	Text3D:DLab_Label,
	DLab_Type, // 0 = drug , 1 = weapon
	DLab_Family
}
new DrugLabInfo[MAX_DRUG_POINT][DrugLab], DownCountJobTime[MAX_PLAYERS], DownTimeUsed[MAX_PLAYERS][4];
// new DrugTypeName[4][] = {"Codeine","Cocaine","Ecstasy","LSD"};
timer DisableEfftects[30000](playerid) 
{
	SetPlayerDrunkLevel(playerid, 0); //  effects phe da
	DeletePVar(playerid, "EffectsDrugs");
}

stock SaveDrug(uid)
{
    new szQuery[2048];
    printf("saved drl %d",uid);
    format(szQuery, sizeof(szQuery), "UPDATE `drug_lab` SET \
        `DLab_Vw` = '%d', \
        `DLab_Int` = '%d', \
        `DLab_Type` = '%d', \
        `DLab_Family` = '%d', \
        `DLab_Postion0` = '%f', \
        `DLab_Postion1` = '%f', \
        `DLab_Postion2` = '%f' WHERE `drl_id` = %d",
        DrugLabInfo[uid][DLab_Vw],
        DrugLabInfo[uid][DLab_Int],
        DrugLabInfo[uid][DLab_Type],
        DrugLabInfo[uid][DLab_Family],
        DrugLabInfo[uid][DLab_Postion][0],
        DrugLabInfo[uid][DLab_Postion][1],
        DrugLabInfo[uid][DLab_Postion][2],
        uid);
    mysql_tquery(MainPipeline, szQuery, "OnSaveDRL", "d", uid);
}
forward OnSaveDRL(pid);
public OnSaveDRL(pid)
{
}
CMD:startsetupdrl(playerid,params[]) {
    for(new i =0; i < MAX_DRUG_POINT; i++) {
    	InsertDRL(i);
    }

	return 1;
}
stock InsertDRL(uid) {
    new szQuery[129];
    format(szQuery, sizeof(szQuery), "INSERT INTO `drug_lab` (`drl_id`,`DLab_Postion0`,`DLab_Postion1`,`DLab_Postion2`) VALUES ('%d','0.0','0.0','0.0')",uid);
    mysql_tquery(MainPipeline, szQuery, "OnInsertDRL", "d", uid);
    return 1;
}

stock RefreshDrugLab(id)
{
	if (IsValidDynamic3DTextLabel(DrugLabInfo[id][DLab_Label])) DestroyDynamic3DTextLabel(DrugLabInfo[id][DLab_Label]);
	if (IsValidDynamicPickup(DrugLabInfo[id][DLab_PickUP])) 	DestroyDynamicPickup(DrugLabInfo[id][DLab_PickUP]);

	new string[129], type_namez[26];

	switch(DrugLabInfo[id][DLab_Type]) {
		case 0: type_namez = "Drug Lab";
		case 1: type_namez = "Weapon Lab";
	}
	if (DrugLabInfo[id][DLab_Family] == 99) {
		format(string, sizeof(string), "%s #%d\n(Bam Y de thao tac)", type_namez, id);
	}
	else {
		format(string, sizeof(string), "%s #%d\nFamily: %s\n(Bam Y de thao tac)", type_namez, id, FamilyInfo[DrugLabInfo[id][DLab_Family]][FamilyName]);
	}

	DrugLabInfo[id][DLab_Label] = CreateDynamic3DTextLabel(string, -1, DrugLabInfo[id][DLab_Postion][0], DrugLabInfo[id][DLab_Postion][1], DrugLabInfo[id][DLab_Postion][2], 15.0, INVALID_PLAYER_ID,  INVALID_VEHICLE_ID, 0, DrugLabInfo[id][DLab_Vw], DrugLabInfo[id][DLab_Int]);
	DrugLabInfo[id][DLab_PickUP] = CreateDynamicPickup(1577, 10, DrugLabInfo[id][DLab_Postion][0], DrugLabInfo[id][DLab_Postion][1], DrugLabInfo[id][DLab_Postion][2],DrugLabInfo[id][DLab_Vw], DrugLabInfo[id][DLab_Int]);
	return 1;
}

stock MoveDrugLab(playerid,drl_id) {
	new Float:Pos_drl[3],string[129];
    GetPlayerPos(playerid, Pos_drl[0], Pos_drl[1], Pos_drl[2]);
    DrugLabInfo[drl_id][DLab_Postion][0] = Pos_drl[0];
    DrugLabInfo[drl_id][DLab_Postion][1] = Pos_drl[1];
    DrugLabInfo[drl_id][DLab_Postion][2] = Pos_drl[2];
    DrugLabInfo[drl_id][DLab_Int] = GetPlayerInterior(playerid);
    DrugLabInfo[drl_id][DLab_Vw] = GetPlayerVirtualWorld(playerid);

	RefreshDrugLab(drl_id);
    return 1;
}

stock UseDrug(playerid,drug_id,pItemId) {
	new string[129];
	if(GetPVarInt(playerid, "EffectsDrugs") == 1) return SendErrorMessage(playerid, "Ban dang bi phe da roi.");
	switch(drug_id) {
		case 0: {
			if(DownTimeUsed[playerid][0] > gettime()) {
                format(string, sizeof string, "Ban can phai doi %d giay moi co the tiep tuc su dung.",  DownTimeUsed[playerid][0] -gettime());
                SendClientMessage(playerid, COLOR_LIGHTRED, string);
				return 1;
			}
			new Float:old_health;
			GetPlayerHealth(playerid, old_health);
			if(BonusHealth[playerid]  >= 100) return SendErrorMessage(playerid, "Ban da dat toi da trang thai tu Codeine ((>100 HP)).");
			BonusHealth[playerid] += 10;
			format(string, sizeof string, "Ban dang su dung Codeine ( ban duoc tang 10 hp toi da. HP: %.1f/%1.f)",old_health,100 + BonusHealth[playerid]);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			SetPlayerDrunkLevel(playerid, 40000); //  effects phe da
			SetPVarInt(playerid, "EffectsDrugs", 1);
			defer DisableEfftects[30000](playerid);
			DownTimeUsed[playerid][0] += gettime() + 1200;

			// REMOVE 
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		    PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		    Inventory_Remove(playerid, pItemId, 1);
		}
		case 1: {
			if(DownTimeUsed[playerid][1] > gettime()) {
                format(string, sizeof string, "Ban can phai doi %d giay moi co the tiep tuc su dung.",  DownTimeUsed[playerid][1] -gettime());
                SendClientMessage(playerid, COLOR_LIGHTRED, string);
				return 1;
			}
			DownCountJobTime[playerid] = gettime() + 3600;
			format(string, sizeof string, "Ban dang su dung Cocaine, ban dang rat sang khoai. (Fast Job: %d giay ( 1h))",DownCountJobTime[playerid]- gettime());
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			SetPlayerDrunkLevel(playerid, 40000); //  effects phe da
			SetPVarInt(playerid, "EffectsDrugs", 1);
			defer DisableEfftects[30000](playerid);
			DownTimeUsed[playerid][1] += gettime() + 7200;
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
			Inventory_Remove(playerid, pItemId, 1);
		}
		case 2: {
			if(DownTimeUsed[playerid][2] > gettime()) {
                format(string, sizeof string, "Ban can phai doi %d giay moi co the tiep tuc su dung.",  DownTimeUsed[playerid][2] -gettime());
                SendClientMessage(playerid, COLOR_LIGHTRED, string);
				return 1;
			}
			new Float:old_armour;
			GetPlayerArmour(playerid, old_armour);
			if(old_armour >= 100 + BonusArmour[playerid]  ) return SendErrorMessage(playerid, "Ban da dat toi da trang thai tu Ecstasy ((>100 HP)).");
			SetPlayerArmour(playerid, old_armour + 20);
			SetPlayerDrunkLevel(playerid, 40000); //  effects phe da
			SetPVarInt(playerid, "EffectsDrugs", 1);
			defer DisableEfftects[30000](playerid);
			DownTimeUsed[playerid][2] += gettime() + 1200;
			if(old_armour + 20 >= 100 + BonusArmour[playerid]) SetPlayerArmour(playerid, 100 + BonusArmour[playerid]);
			GetPlayerArmour(playerid, old_armour);
			format(string, sizeof string, "Ban dang su dung Ecstasy, ban dang rat sang khoai. (ban duoc tang 20 ar. Armour: %.1f/%.1f)",old_armour + 20,100 + BonusArmour[playerid]);
		    SendClientMessageEx(playerid, COLOR_WHITE, string);
		    PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
		    ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
			Inventory_Remove(playerid, pItemId, 1);
		}
		case 3: {
			if(DownTimeUsed[playerid][3] > gettime()) {
                format(string, sizeof string, "Ban can phai doi %d giay moi co the tiep tuc su dung.",  DownTimeUsed[playerid][3] -gettime());
                SendClientMessage(playerid, COLOR_LIGHTRED, string);
				return 1;
			}
			new Float:old_armour;
			GetPlayerArmour(playerid, old_armour);
			if(BonusArmour[playerid]  >= 100) return SendErrorMessage(playerid, "Ban da dat toi da trang thai tu LSD ((>100 AR)).");
			BonusArmour[playerid] += 10;
			format(string, sizeof string, "Ban dang su dung LSD, ban dang rat sang khoai. (ban duoc tang 10 Bonus Armour. Armour: %0f/%0f)",old_armour,100 + BonusArmour[playerid]);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			SetPlayerDrunkLevel(playerid, 40000); //  effects phe da
			SetPVarInt(playerid, "EffectsDrugs", 1);
			defer DisableEfftects[30000](playerid);
			DownTimeUsed[playerid][3] += gettime() + 1800;
			Inventory_Remove(playerid, pItemId, 1);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
	}
    return 1;
}

CMD:druglabnext(playerid, params[])
{
	new string[128],drl_id = -1;
	for(new i = 0 ; i < MAX_DRUG_POINT; i++) {
		if(DrugLabInfo[i][DLab_Postion][0] == 0 || DrugLabInfo[i][DLab_Postion][1] == 0.0) {
			drl_id = i;
			break ;
		}
	}
	if(drl_id == -1) return SendClientMessageEx(playerid, COLOR_WHITE, "Khong co druglab con trong.");
	format(string, sizeof string, "ID Drug lab dang trong la: %d", drl_id);
	SendClientMessageEx(playerid, COLOR_WHITE, string);
	return 1;
}

CMD:editdruglab(playerid, params[])
{
	new string[128], drl_id,choose, choice[32];
	if(sscanf(params, "s[32]dd",  choice,drl_id,choose))
	{
		SendUsageMessage(playerid, " /editdruglab [option] [id] [choose]");
		SendSelectMessage(playerid, " Delete , Vitri, FamilyID (99 = player), Type ( 0 = Drug, 1 = Weapon )");
		return 1;
	}
	if (strcmp(choice, "Delete", true) == 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban da xoa thanh cong drug lab.");
		DestroyDynamicPickup( DrugLabInfo[drl_id][DLab_PickUP]);
	    DestroyDynamic3DTextLabel( DrugLabInfo[drl_id][DLab_Label]);
		DrugLabInfo[drl_id][DLab_Postion][0] = 0.0;
        DrugLabInfo[drl_id][DLab_Postion][1] = 0.0;
        DrugLabInfo[drl_id][DLab_Postion][2] = 0.0;
        SaveDrug(drl_id);
	}
	if (strcmp(choice, "Type", true) == 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban da chinh sua type thanh cong.");
		DrugLabInfo[drl_id][DLab_Type] = choose;
		RefreshDrugLab(drl_id);
        SaveDrug(drl_id);
	}
	if (strcmp(choice, "Vitri", true) == 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban da chinh sua vi tri thanh cong.");
		MoveDrugLab(playerid, drl_id);
		SaveDrug(drl_id);
	}
	if (strcmp(choice, "FamilyID", true) == 0)
	{
		if (choose == 99)
		{
			DrugLabInfo[drl_id][DLab_Family] = 99;
			sendMessage(playerid, -1, "Ban da chinh sua Drug Lab %d cho phep moi nguoi su dung.", drl_id);
			RefreshDrugLab(drl_id);
        	SaveDrug(drl_id);
			return 1;
		}

		format(string,sizeof string,"Ban da chinh sua FAMILY ID %d cho Drub lab %d",choose,drl_id);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		DrugLabInfo[drl_id][DLab_Family] = choose;
		RefreshDrugLab(drl_id);
        SaveDrug(drl_id);
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(newkeys & KEY_YES) {
		//new drl_id = -1;
		for(new i = 0 ; i < MAX_DRUG_POINT; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 5 , DrugLabInfo[i][DLab_Postion][0], DrugLabInfo[i][DLab_Postion][1], DrugLabInfo[i][DLab_Postion][2])) {
				if(DrugLabInfo[i][DLab_Family] == 99) {
					if(DrugLabInfo[i][DLab_Type] == 0 ) {
						Dialog_Show(playerid, DIALOG_DRUGS_G, DIALOG_STYLE_TABLIST_HEADERS, "Che tao Drug", "Drug Name\tY/C Chat Hoa hoc I\tY/C Chat Hoa hoc II\n\
																										#Codeine\t2\t0\n\
																										#Cocain\t4\t0", "Che tao", "Huy bo");
					}
					else if(DrugLabInfo[i][DLab_Type] == 1 ) { 
						ShowMainCraft(playerid, 2);

					}
				}
				else {
					if(DrugLabInfo[i][DLab_Family] != PlayerInfo[playerid][pFMember]) return SendErrorMessage(playerid,"Drug Lab khong phai cua Family ban.");
					if(DrugLabInfo[i][DLab_Type] == 0 ) {
						Dialog_Show(playerid, DIALOG_DRUGS_G, DIALOG_STYLE_TABLIST_HEADERS, "Che tao Drug", "Drug Name\tY/C Chat Hoa hoc I\tY/C Chat Hoa hoc II\n\
																										#Codeine\t2\t0\n\
																										#Cocain\t4\t0\n\
																										#Ecstasy\t4\t4\n\
																										#LSD\t8\t6", "Che tao", "Huy bo");
					}
					else if(DrugLabInfo[i][DLab_Type] == 1 ) { 
						ShowMainCraft(playerid);

					}
				}
			}
		} 
	}
	if(newkeys & KEY_YES) {
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 2306.409179 ,-1569.672607, 1051.562988)) {
			Dialog_Show(playerid, DIALOG_BUY_CHH, DIALOG_STYLE_TABLIST_HEADERS, "Mua chat hoa hoc", "#Loai\tGia ban\tso luong\n\
		        	                                                                                 Chat hoa hoc I\t$1\t1\n\
		        		                                                                             Chat hoa hoc II\t$2\t1", "Mua", "Huy bo");
		}
	}
	return 1;
}

Dialog:DIALOG_BUY_CHHI(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 0 || strval(inputtext) > 100) return Dialog_Show(playerid, DIALOG_BUY_CHHI, DIALOG_STYLE_INPUT, "Mua chat hoa hoc I", "So luong phai tu 0-100\nVui long nhap so luong ban muon mua ( gia $1/ 1CHH)", "Mua", "Huy bo");
		if(PlayerInfo[playerid][pCash] < 1 * strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du tien de mua chat hoa hoc I .");
		Inventory_Add(playerid, "Chat hoa hoc I", strval(inputtext));
		new string[129];
		format(string, sizeof string, "Ban da mua thanh cong %d chat hoa hoc I voi gia $%s .", strval(inputtext) , number_format( 1 * strval(inputtext) ));
		SendClientMessage(playerid, -1, string);
		PlayerInfo[playerid][pCash] -=  strval(inputtext) * 2;
	}
	return 1;
}
Dialog:DIALOG_BUY_CHHII(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 0 || strval(inputtext) > 100) return Dialog_Show(playerid, DIALOG_BUY_CHHI, DIALOG_STYLE_INPUT, "Mua chat hoa hoc II", "So luong phai tu 0-100\nVui long nhap so luong ban muon mua ( gia $1/ 1CHH)", "Mua", "Huy bo");
		if(PlayerInfo[playerid][pCash] < 2 * strval(inputtext)) return SendClientMessage(playerid, -1, "Ban khong du tien de mua chat hoa hoc II .");
		Inventory_Add(playerid, "Chat hoa hoc II", strval(inputtext));
		new string[129];
		format(string, sizeof string, "Ban da mua thanh cong %d chat hoa hoc II voi gia $%s .", strval(inputtext) , number_format( 2 * strval(inputtext) ));
		SendClientMessage(playerid, -1, string);
		PlayerInfo[playerid][pCash] -=  strval(inputtext) * 2;
	}
	return 1;
}

Dialog:DIALOG_BUY_CHH(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(listitem == 0 ) {
			Dialog_Show(playerid, DIALOG_BUY_CHHI, DIALOG_STYLE_INPUT, "Mua chat hoa hoc I", "Vui long nhap so luong ban muon mua ( gia $1/ 1CHH)", "Mua", "Huy bo");
		}
		if(listitem == 1 ) {
			Dialog_Show(playerid, DIALOG_BUY_CHHII, DIALOG_STYLE_INPUT, "Mua chat hoa hoc II", "Vui long nhap so luong ban muon mua ( gia $2/ 1CHH)", "Mua", "Huy bo");
		}
	}
	return 1;
}
Dialog:DIALOG_DRUGS_G(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(Inventory_Count(playerid, "Chat hoa hoc I") < 0) return SendClientMessage(playerid, -1, "Ban khong co du chat hoa hoc I.");
		if(Inventory_Count(playerid, "Chat hoa hoc II") < 0) return SendClientMessage(playerid, -1, "Ban khong co du chat hoa hoc II.");
		if(listitem == 0 ) {
			if(Inventory_Count(playerid, "Chat hoa hoc I") < 2) return SendClientMessage(playerid, -1, "Ban khong co du 2 chat hoa hoc I.");
			Inventory_Add(playerid, "Codeine", 1);
            new pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc I");
			Inventory_Remove(playerid, pItemId, 2); //ID cua InventoryData
			SendClientMessage(playerid, -1, "Ban da che tao thanh cong 1 Codeine va mat 2 Chat hoa hoc I.");
			return 1;
		}
		if(listitem == 1 ) {
			if(Inventory_Count(playerid, "Chat hoa hoc I") < 4) return SendClientMessage(playerid, -1, "Ban khong co du 4 chat hoa hoc I.");
			Inventory_Add(playerid, "Cocain", 1);
            new pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc I");
			Inventory_Remove(playerid, pItemId, 4); //ID cua InventoryData

			SendClientMessage(playerid, -1, "Ban da che tao thanh cong 1 Cocain va mat 4 Chat hoa hoc I.");
			return 1;
		}
		if(listitem == 2 ) {
			if(Inventory_Count(playerid, "Chat hoa hoc I") < 4) return SendClientMessage(playerid, -1, "Ban khong co du 4 chat hoa hoc I.");
			if(Inventory_Count(playerid, "Chat hoa hoc II") < 4) return SendClientMessage(playerid, -1, "Ban khong co du 4 chat hoa hoc II.");


			Inventory_Add(playerid, "Ecstacy", 1);

            new pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc I");
			Inventory_Remove(playerid, pItemId, 4); //ID cua InventoryData
			pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc II");
			Inventory_Remove(playerid, pItemId, 4); //ID cua InventoryData
			SendClientMessage(playerid, -1, "Ban da che tao thanh cong 1 Ecstacy va mat 4 Chat hoa hoc I & 4 chat hoa hoc II.");
			return 1;
		}
		if(listitem == 3 ) {
			if(Inventory_Count(playerid, "Chat hoa hoc I") < 8) return SendClientMessage(playerid, -1, "Ban khong co du 8 chat hoa hoc I.");
			if(Inventory_Count(playerid, "Chat hoa hoc II") < 6) return SendClientMessage(playerid, -1, "Ban khong co du 6 chat hoa hoc II.");
			Inventory_Add(playerid, "LSD", 1);
            new pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc I");
			Inventory_Remove(playerid, pItemId, 8); //ID cua InventoryData
			pItemId = Inventory_GetItemID(playerid,"Chat hoa hoc II");
			Inventory_Remove(playerid, pItemId, 9); //ID cua InventoryData
			SendClientMessage(playerid, -1, "Ban da che tao thanh cong 1 LSD va mat 8 Chat hoa hoc I & 6 chat hoa hoc II.");
			return 1;
		}
	}
	return 1;
}
hook OnGameModeInit() {

	CreateDynamicPickup(1239, 23, 2306.409179 ,-1569.672607, 1051.562988, -1); // Drug Smuggler Job (TR)
	CreateDynamic3DTextLabel("{FF0000} DRUG LAB \n{FFFFFF}(( bam Y de mua chat hoa hoc.))", COLOR_WHITE, 2306.409179 ,-1569.672607, 1051.562988 + 0.5, 10.0);// Actor Trucker

	 
}
hook OnPlayerDeath(playerid, killerid, reason) {
	BonusHealth[playerid] = 0;
}
