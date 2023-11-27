#include <YSI_Coding\y_hooks>

#define MAX_REPAIR_POINT 50

enum rpInfo
{
	rpId,
	rpBizID,
	rpStatus,
	Float: rpPosX,
	Float: rpPosY,
	Float: rpPosZ,
	rpPickup,
	Text3D: rpText
};

new RepairPoint[MAX_REPAIR_POINT][rpInfo];

forward OnLoadRepairPoint();
public OnLoadRepairPoint()
{
	new i, rows, fields;
	cache_get_data(rows, fields, MainPipeline);

	while (i < rows)
	{
		RepairPoint[i][rpId] = cache_get_field_content_int(i, "id", MainPipeline);
		RepairPoint[i][rpBizID] = cache_get_field_content_int(i, "BizID", MainPipeline);
		RepairPoint[i][rpPosX] = cache_get_field_content_float(i, "PosX", MainPipeline);
		RepairPoint[i][rpPosY] = cache_get_field_content_float(i, "PosY", MainPipeline);
		RepairPoint[i][rpPosZ] = cache_get_field_content_float(i, "PosZ", MainPipeline);
		
		RepairPoint[i][rpStatus] = 0;
		CreateRepairPoint(i);
		i++;
	}

	printf("[LoadRepairPoint] Loaded %i repair points", i);
	return 1;
}

forward OnRepairPointCreated(id);
public OnRepairPointCreated(id)
{
	RepairPoint[id][rpId] = cache_insert_id();
	printf("[Repair Point] %i has been created (sqlID: %i)", id, RepairPoint[id][rpId]);
	return 1;
}

stock LoadRepairPoint()
{
	printf("[LoadRepairPoint] Loading data from database...");
	mysql_function_query(MainPipeline, "SELECT * FROM `repairpoint`", true, "OnLoadRepairPoint", "");
}

stock SaveRepairPoint(id)
{
	new string[576];
	format(string, sizeof(string), "UPDATE `repairpoint` SET \
		`BizID` = %d, \
		`PosX` = %f, \
		`PosY` = %f, \
		`PosZ` = %f WHERE `id` = %d",
		RepairPoint[id][rpBizID],
		RepairPoint[id][rpPosX],
		RepairPoint[id][rpPosY],
		RepairPoint[id][rpPosZ],
		RepairPoint[id][rpId]);

	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
	return 1;
}

stock GetFreeRepairPoint()
{
	for(new i; i < MAX_REPAIR_POINT; i ++)
	{
		if (RepairPoint[i][rpPosX] == 0.0) return i;
	}

	return -1;
}

stock GetRepairPointNearest(playerid)
{
	for(new i; i < MAX_REPAIR_POINT; i ++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, RepairPoint[i][rpPosX], RepairPoint[i][rpPosY], RepairPoint[i][rpPosZ])) return i;
	}
	
	return -1;
}

stock CreateRepairPoint(id)
{
	if (IsValidDynamic3DTextLabel(RepairPoint[id][rpText])) DestroyDynamic3DTextLabel(RepairPoint[id][rpText]);
	if (IsValidDynamicPickup(RepairPoint[id][rpPickup])) 	DestroyDynamicPickup(RepairPoint[id][rpPickup]);

	RepairPoint[id][rpPickup] = CreateDynamicPickup(19134, 23, RepairPoint[id][rpPosX], RepairPoint[id][rpPosY], RepairPoint[id][rpPosZ], -1, -1, -1);
	
	new szText[128];
	format(szText, sizeof(szText), "[Repair Point #%i]{FFFFFF}\nDoanh nghiep: #%i\n/mech", id, RepairPoint[id][rpBizID]);

	RepairPoint[id][rpText] = CreateDynamic3DTextLabel(szText, 0xA7622AFF, RepairPoint[id][rpPosX], RepairPoint[id][rpPosY], RepairPoint[id][rpPosZ]+0.3, 15.0);
	return 1;
}

CMD:repair(playerid, params[])
{
	if (PlayerInfo[playerid][pJob] != 7 && PlayerInfo[playerid][pJob2] != 7) return SendErrorMessage(playerid, "Ban khong phai la tho sua xe!");

	new 
		i, bid = PlayerInfo[playerid][pBusiness], vid, title[128], info[448], Float:vhp,
		panels, doors, lights, tires, status[3][64], timeleft[128];

	if ((i = GetRepairPointNearest(playerid)) == -1) return SendErrorMessage(playerid, "Ban khong o gan diem sua xe.");
	if (bid != RepairPoint[i][rpBizID]) return SendErrorMessage(playerid, "Diem sua xe nay khong thuoc doanh nghiep cua ban.");
	if (!IsPlayerInAnyVehicle(playerid)) 	return SendErrorMessage(playerid, "Ban khong o trong phuong tien de sua chua.");

	vid = GetPlayerVehicleID(playerid);
	GetVehicleStatus(playerid, panels, doors, lights, tires);
	if (panels == 0) status[0] = "{13BC10}[Tot]{FFFFFF}";
	else status[0] = "{D31212}[Hong]{FFFFFF}";
	if (doors == 0) status[1] = "{13BC10}[Tot]{FFFFFF}";
	else status[1] = "{D31212}[Hong]{FFFFFF}";
	if (lights == 0) status[2] = "{13BC10}[Tot]{FFFFFF}";
	else status[2] = "{D31212}[Hong]{FFFFFF}";
	GetVehicleHealth(vid, vhp);

	format(title, sizeof(title), "Xe {2C6EAF}%s", VehicleName[GetVehicleModel(vid) - 400]);
	foreach(new p: Player)
	{
		for(new d = 0; d < MAX_PLAYERVEHICLES; d++)
		{
			if(PlayerVehicleInfo[p][d][pvId] == vid)
			{
				if(PlayerVehicleInfo[p][d][pvTiresDays] > gettime()) format(timeleft, sizeof(timeleft), "[Con %s]", FormatTimeleft(gettime(), PlayerVehicleInfo[p][d][pvTiresDays]));
				else timeleft = "{D31212}[Hong]{FFFFFF}";

				format(info, sizeof(info), "\
				Dong co\t[%0.1f/%0.1f]\t100 HP/1 unit\n\
				Den xe\t%s\t1 unit\n\
				Cua xe\t%s\t1 unit\n\
				Than xe\t%s\t1 unit\n\
				Lop xe\t%s\t1 ngay/5 unit",
				vhp, PlayerVehicleInfo[p][d][pvMaxHealth],
				status[2], status[1], status[0], timeleft);

				Dialog_Show(playerid, DIALOG_MECH, DIALOG_STYLE_TABLIST, title, info, "Chon", "Dong");

				SetPVarInt(playerid, #pvID, p);
				SetPVarInt(playerid, #pvSlot, d);
				return 1;
			}
		}
	}

	SendErrorMessage(playerid, "Phuong tien nay khong kha dung.");
	return 1;
}


CMD:rpedit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendErrorMessage(playerid, "Ban khong the su dung lenh nay.");

	new option[16], secoption[128];
	if(sscanf(params, "s[16]S()[128]", option, secoption))
	{
		SendUsageMessage(playerid, " /rpedit [option]");
		SendClientMessage(playerid, -1, "Option: create / pos / biz / delete");
		return 1;
	}

	new 
		i,
		bid,
		Float: fPos[3],
		string[228];

	if (strcmp(option, "create") == 0)
	{
		if (sscanf(secoption, "d", bid)) 	return SendUsageMessage(playerid, " /rpedit create [biz id]");
		if (!IsValidBusinessID(bid)) 		return SendErrorMessage(playerid, "Doanh nghiep nay khong ton tai.");
		if (Businesses[bid][bType] != BUSINESS_TYPE_MECHANIC) return SendErrorMessage(playerid, "Loai hinh doanh nghiep nay khong phai la sua xe.");

		if ((i = GetFreeRepairPoint()) == -1) return SendErrorMessage(playerid, "The limit has been reached [ERROR]"); // MAX_REPAIR_POINT ()
		GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);
		RepairPoint[i][rpPosX] = fPos[0];
		RepairPoint[i][rpPosY] = fPos[1];
		RepairPoint[i][rpPosZ] = fPos[2];
		RepairPoint[i][rpBizID] = bid;

		format(string, sizeof(string), "INSERT INTO `repairpoint` (`BizID`, `PosX`, `PosY`, `PosZ`) VALUES ('%d', '%f', '%f', '%f')", bid, RepairPoint[i][rpPosX], RepairPoint[i][rpPosY], RepairPoint[i][rpPosZ]);
		mysql_tquery(MainPipeline, string, "OnRepairPointCreated", "d", i);

		CreateRepairPoint(i);
	}
	else if (strcmp(option, "pos") == 0)
	{
		if (sscanf(secoption, "d", i)) 		return SendUsageMessage(playerid, " /rpedit pos [repair id]");
		if (RepairPoint[i][rpPosX] == 0.0) 	return SendErrorMessage(playerid, "Khong ton tai Repair Point #%d", i);

		GetPlayerPos(playerid, fPos[0], fPos[1], fPos[2]);
		RepairPoint[i][rpPosX] = fPos[0];
		RepairPoint[i][rpPosY] = fPos[1];
		RepairPoint[i][rpPosZ] = fPos[2];

		CreateRepairPoint(i); // refresh point
		SaveRepairPoint(i); 
	}
	else if (strcmp(option, "biz") == 0)
	{
		if (sscanf(secoption, "dd", i, bid)) 		return SendUsageMessage(playerid, " /rpedit biz [repair id] [biz id]");
		if (!IsValidBusinessID(bid)) 			return SendErrorMessage(playerid, "Doanh nghiep nay khong ton tai.");
		if (Businesses[bid][bType] != BUSINESS_TYPE_MECHANIC) return SendErrorMessage(playerid, "Loai hinh doanh nghiep nay khong phai la sua xe.");
        if (RepairPoint[i][rpPosX] == 0.0) 	return SendErrorMessage(playerid, "Khong ton tai Repair Point #%d", i);

		RepairPoint[i][rpBizID] = bid;
		CreateRepairPoint(i); // refresh point
		SaveRepairPoint(i);
	}
	else if (strcmp(option, "delete") == 0)
	{
		if (sscanf(secoption, "d", i)) 		return SendUsageMessage(playerid, " /rpedit delete [i]");
		if (RepairPoint[i][rpPosX] == 0.0) 	return SendErrorMessage(playerid, "Khong ton tai Repair Point #%d", i);

		RepairPoint[i][rpPosX] = 0.0;
		RepairPoint[i][rpPosY] = 0.0;
		RepairPoint[i][rpPosZ] = 0.0;
		RepairPoint[i][rpBizID] = -1;
		
		mysql_format(MainPipeline, string, sizeof(string), "DELETE FROM `repairpoint` WHERE `id` = %d", RepairPoint[i][rpId]);
		mysql_query(MainPipeline, string);
		RepairPoint[i][rpId] = -1;
		
		if(IsValidDynamicPickup(RepairPoint[i][rpPickup])) DestroyDynamicPickup(RepairPoint[i][rpPickup]);
		if(IsValidDynamic3DTextLabel(RepairPoint[i][rpText])) DestroyDynamic3DTextLabel(RepairPoint[i][rpText]);
	}
	return 1;
}

CMD:mech(playerid, params[]) 
{
	new 
		i, vid, title[128];

	if ((i = GetRepairPointNearest(playerid)) == -1) 						return SendErrorMessage(playerid, " Ban khong o gan diem sua xe.");
	if (PlayerInfo[playerid][pBusiness] != RepairPoint[i][rpBizID]) return SendErrorMessage(playerid, " Diem sua xe nay khong thuoc doanh nghiep cua ban.");
    if (!IsPlayerInAnyVehicle(playerid)) 	return SendErrorMessage(playerid, " Ban phai o ben trong mot chiec xe.");

	vid = GetPlayerVehicleID(playerid);

	format(title, sizeof(title), "Xe {2C6EAF}%s", VehicleName[GetVehicleModel(vid) - 400]);
	foreach(new p: Player)
	{
		for(new d = 0; d < MAX_PLAYERVEHICLES; d++)
		{
			if(PlayerVehicleInfo[p][d][pvId] == vid)
			{
                SetPVarInt(playerid, #pvID, p);
                SetPVarInt(playerid, #pvSlot, d);
                Dialog_Show(playerid, DIALOG_MECH, DIALOG_STYLE_TABLIST, title, "{FFFFFF}1. Sua xe\t{1BE41B}[Sua chua cac phan bi hu hong tren chiec xe]{FFFFFF}\n2. Nang cap xe\t{1BE41B}[Nang cap dong co va dung tich xang]", "Chon", "<");
				return 1;
			}
		}
	}

    if(DynVeh[GetPlayerVehicleID(playerid)] != -1 && DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_igID] != INVALID_GROUP_ID)
    {
        SetPVarInt(playerid, #facFixed, 1);
        Dialog_Show(playerid, DIALOG_MECH_FIXED, DIALOG_STYLE_MSGBOX, title, "{FFFFFF}Yeu cau: 2 linh kien\n\n{41B431}-> Ban co muon sua chua phuong tien nay khong?", "Co", "Khong");
        return 1;
    }

	SendErrorMessage(playerid, "Phuong tien nay khong kha dung.");
	return 1;
}

/*----------------------------------*/

Dialog:DIALOG_MECH(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        DeletePVar(playerid, #pvID);
        DeletePVar(playerid, #pvSlot);
        SendClientMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da tat Menu Mechanic.");
        return 1;
    }
    new 
        title[128], info[448], Float:vhp,
        panels, doors, lights, tires, status[3][64], timeleft[128],
        p = GetPVarInt(playerid, #pvID),
        d = GetPVarInt(playerid, #pvSlot),
        vid = GetPlayerVehicleID(playerid);

    format(title, sizeof(title), "Xe {2C6EAF}%s", VehicleName[GetVehicleModel(vid) - 400]);
    switch(listitem)
    {
        case 0: {
            GetVehicleStatus(playerid, panels, doors, lights, tires);
            if (panels == 0) status[0] = "{13BC10}[Tot]{FFFFFF}";
            else status[0] = "{D31212}[Hong]{FFFFFF}";
            if (doors == 0) status[1] = "{13BC10}[Tot]{FFFFFF}";
            else status[1] = "{D31212}[Hong]{FFFFFF}";
            if (lights == 0) status[2] = "{13BC10}[Tot]{FFFFFF}";
            else status[2] = "{D31212}[Hong]{FFFFFF}";
            GetVehicleHealth(vid, vhp);

            if(PlayerVehicleInfo[p][d][pvId] == vid)
            {
                if(PlayerVehicleInfo[p][d][pvTiresDays] > gettime()) format(timeleft, sizeof(timeleft), "[Con %s]", FormatTimeleft(gettime(), PlayerVehicleInfo[p][d][pvTiresDays]));
                else timeleft = "{D31212}[Hong]{FFFFFF}";

                format(info, sizeof(info), "\
                Dong co\t[%0.1f/%0.1f]\t100 HP/1 unit\n\
                Den xe\t%s\t1 unit\n\
                Cua xe\t%s\t1 unit\n\
                Than xe\t%s\t1 unit\n\
                Lop xe\t%s\t1 ngay/5 unit",
                vhp, PlayerVehicleInfo[p][d][pvMaxHealth],
                status[2], status[1], status[0], timeleft);

                Dialog_Show(playerid, DIALOG_MECH_FIXED, DIALOG_STYLE_TABLIST, title, info, "Chon", "Quay lai");

                return 1;
            }
        }
        case 1: {
            Dialog_Show(playerid, DIALOG_MECH_UPGRADE, DIALOG_STYLE_TABLIST, title, "{FFFFFF}\
            Dong co xe\t1HP/1 unit\n\
            Dung tich xang\t1L/1 unit", "Chon", "Quay lai");

            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_MECH_UPGRADE(playerid, response, listitem, inputtext[]){
    if(!response) {
        DeletePVar(playerid, #pvUpgrade);
        return cmd_mech(playerid, "");
    }
    
    new title[128], info[256],
        p = GetPVarInt(playerid, #pvID),
        d = GetPVarInt(playerid, #pvSlot),
        up_type = GetPVarInt(playerid, #pvUpgrade),
        vid = GetPlayerVehicleID(playerid),
        iBusiness = PlayerInfo[playerid][pBusiness];
    
    format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Nang cap", VehicleName[GetVehicleModel(vid) - 400]);
    if(up_type) {
        switch(up_type)
        {
            case 1: {
                new 
                    Float:amount = floatstr(inputtext),
                    cost = strval(inputtext);

                if (amount < 1 || isnull(inputtext)) {
                    DeletePVar(playerid, #pvUpgrade);
                    sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Mot con so khong hop le.");
                    return cmd_mech(playerid, "");
                }
                if (Businesses[iBusiness][bInventory] < cost) {
                    DeletePVar(playerid, #pvUpgrade);
                    sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien (Yeu cau: %d linh kien).", cost - Businesses[iBusiness][bInventory]);
                    return cmd_mech(playerid, "");
                }
                if(amount + PlayerVehicleInfo[p][d][pvMaxHealth] == 1000.0) {
                    DeletePVar(playerid, #pvUpgrade);
                    sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} HP Dong co khong the la 1000.0.", cost - Businesses[iBusiness][bInventory]);
                    return cmd_mech(playerid, "");
                }

                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                Businesses[iBusiness][bInventory] -= cost;
                PlayerVehicleInfo[p][d][pvMaxHealth] += amount;
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da nang cap dong co cua chiec xe %s (HP hien tai: %0.1fHP).", VehicleName[GetVehicleModel(vid) - 400], PlayerVehicleInfo[p][d][pvMaxHealth]);
                DeletePVar(playerid, #pvUpgrade);
                return cmd_mech(playerid, "");
            }
            case 2: {
                new 
                    Float:amount = floatstr(inputtext),
                    cost = strval(inputtext);

                if(amount < 1 || isnull(inputtext)) {
                    DeletePVar(playerid, #pvUpgrade);
                    sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Mot con so khong hop le.");
                    return cmd_mech(playerid, "");
                }
                if (Businesses[iBusiness][bInventory] < cost){
                    DeletePVar(playerid, #pvUpgrade);
                    sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien (Yeu cau: %d linh kien).", cost - Businesses[iBusiness][bInventory]);
                    return cmd_mech(playerid, "");
                }

                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                Businesses[iBusiness][bInventory] -= cost;
                VehicleCapacity[vid] += amount;
                PlayerVehicleInfo[p][d][pvCapacity] = VehicleCapacity[vid];
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da nang cap dung tich cua chiec xe %s (Dung tich hien tai: %0.1fL).", VehicleName[GetVehicleModel(vid) - 400], VehicleCapacity[vid]);
                DeletePVar(playerid, #pvUpgrade);
                return cmd_mech(playerid, "");
            }
        }
    }
    
    switch(listitem)
    {
        case 0: {
            SetPVarInt(playerid, #pvUpgrade, 1);

            format(info, sizeof(info), "{FFFFFF}\
                [#] Dong co hien tai: {3B83E8}%0.1f HP{FFFFFF}\n\
                [#] Chi phi: 1 HP/1 unit\n\n\
                {41B431}-> Nhap so HP ban muon nang cap cho dong co.", PlayerVehicleInfo[p][d][pvMaxHealth]);
            Dialog_Show(playerid, DIALOG_MECH_UPGRADE, DIALOG_STYLE_INPUT, title, info, "Nang cap", "Quay lai");
        }
        case 1: {
            SetPVarInt(playerid, #pvUpgrade, 2);

            format(info, sizeof(info), "{FFFFFF}\
                [#] Dung tich hien tai: {3B83E8}%0.1fL{FFFFFF}\n\
                [#] Chi phi: 1L/1 unit\n\n\
                {41B431}-> Nhap so lit ban muon nang cap cho dung tich xang.", VehicleCapacity[vid]);
            Dialog_Show(playerid, DIALOG_MECH_UPGRADE, DIALOG_STYLE_INPUT, title, info, "Nang cap", "Quay lai");
        }
    }
    return 1;
}

Dialog:DIALOG_MECH_FIXED(playerid, response, listitem, inputtext[]){
    if(!response) return cmd_mech(playerid, "");
    
    new 
        p = GetPVarInt(playerid, #pvID),
        d = GetPVarInt(playerid, #pvSlot),
        iBusiness = PlayerInfo[playerid][pBusiness],
        vid = GetPlayerVehicleID(playerid),
        title[128], info[256],
        panels, lights, doors, tires;

    if (GetPVarInt(playerid, #facFixed) == 1)
    {
        if(Businesses[iBusiness][bInventory] < 2) return sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
        
        Businesses[iBusiness][bInventory] -= 2;
        UpdateVehicleDamageStatus(vid, 0, 0, 0, 0);
        SetVehicleHealth(vid, DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_fMaxHealth]);
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);

        sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua toan bo chiec xe nay.");
        DeletePVar(playerid, #facFixed);
        return 1;
    }

    switch(listitem)
    {
        case 0: {
            new Float:hp, cost;
            GetVehicleHealth(vid, hp);
            if (hp >= PlayerVehicleInfo[p][d][pvMaxHealth]){
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Dong co chiec xe nay khong hu hong.");
                return cmd_mech(playerid, "");
            }

            cost = (floatround(PlayerVehicleInfo[p][d][pvMaxHealth]) - floatround(hp)) / 100;
            if(cost == 0) cost = 1;
            if (Businesses[iBusiness][bInventory] < cost) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
                return cmd_mech(playerid, "");
            }   

            format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Dong co", VehicleName[GetVehicleModel(vid) - 400]);
            format(info, sizeof(info), "{FFFFFF}\
                [#] Dong co: {4B84CE}%0.1f/%0.1f{FFFFFF}\n\
                [#] Yeu cau: %d linh kien\n\n\
                {41B431} -> Ban co muon sua chua phuong tien nay khong?", 
                hp, PlayerVehicleInfo[p][d][pvMaxHealth], cost);

            SetPVarInt(playerid, #repairCost, cost);
            SetPVarInt(playerid, #mechConfirm, 1);
            Dialog_Show(playerid, DIALOG_MECH_CONFIRM, DIALOG_STYLE_MSGBOX, title, info, "Co", "Quay lai");
        }
        case 1: {
            GetVehicleStatus(playerid, panels, doors, lights, tires);
            if (lights == 0) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Den xe khong bi hong.");
                return cmd_mech(playerid, "");
            }
            else if (Businesses[iBusiness][bInventory] < 1) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
                return cmd_mech(playerid, "");
            }

            format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Den xe", VehicleName[GetVehicleModel(vid) - 400]);
            format(info, sizeof(info), "{FFFFFF}\
                [#] Trang thai: %s{FFFFFF} (Thiet hai: %d%%)\n\
                [#] Yeu cau: 1 linh kien\n\n\
                {41B431} -> Ban co muon sua chua den chieu sang cua phuong tien nay khong?", 
                (lights) ? ("{D31212}Hong") : ("{13BC10}Tot"), lights);

            Dialog_Show(playerid, DIALOG_MECH_CONFIRM, DIALOG_STYLE_MSGBOX, title, info, "Co", "Quay lai");
            SetPVarInt(playerid, #repairCost, 1);
            SetPVarInt(playerid, #mechConfirm, 2);
        }
        case 2: {
            GetVehicleStatus(playerid, panels, doors, lights, tires);
            if (doors == 0) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Cua xe khong bi hong.");
                return cmd_mech(playerid, "");
            }
            else if (Businesses[iBusiness][bInventory] < 1) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
                return cmd_mech(playerid, "");
            }

            format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Cua xe", VehicleName[GetVehicleModel(vid) - 400]);
            format(info, sizeof(info), "{FFFFFF}\
                [#] Trang thai: %s{FFFFFF} (Thiet hai: %d%%)\n\
                [#] Yeu cau: 1 linh kien\n\n\
                {41B431} -> Ban co muon sua chua canh cua cua phuong tien nay khong?", 
                (doors) ? ("{D31212}Hong") : ("{13BC10}Tot"), doors);

            Dialog_Show(playerid, DIALOG_MECH_CONFIRM, DIALOG_STYLE_MSGBOX, title, info, "Co", "Quay lai");
            SetPVarInt(playerid, #repairCost, 1);
            SetPVarInt(playerid, #mechConfirm, 3);
        }
        case 3: {
            GetVehicleStatus(playerid, panels, doors, lights, tires);
            if (panels == 0) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Than xe khong bi hong.");
                return cmd_mech(playerid, "");
            }
            else if (Businesses[iBusiness][bInventory] < 1) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
                return cmd_mech(playerid, "");
            }

            format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Than xe", VehicleName[GetVehicleModel(vid) - 400]);
            format(info, sizeof(info), "{FFFFFF}\
                [#] Trang thai: %s{FFFFFF} (Thiet hai: %d%%)\n\
                [#] Yeu cau: 1 linh kien\n\n\
                {41B431} -> Ban co muon sua chua phan than cua phuong tien nay khong?", 
                (panels) ? ("{D31212}Hong") : ("{13BC10}Tot"), panels);

            Dialog_Show(playerid, DIALOG_MECH_CONFIRM, DIALOG_STYLE_MSGBOX, title, info, "Co", "Quay lai");
            SetPVarInt(playerid, #repairCost, 1);
            SetPVarInt(playerid, #mechConfirm, 4);
        }
        case 4: {
            GetVehicleStatus(playerid, panels, doors, lights, tires);
            if(tires == 0 || gettime() < (PlayerVehicleInfo[p][d][pvTiresDays] - (86400 * 9))) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Lop xe khong bi hong va cung khong can gia han.");
                return cmd_mech(playerid, "");
            }

            new leftdays, cost;

            if (PlayerVehicleInfo[p][d][pvTiresDays] > gettime()) {
                leftdays = (PlayerVehicleInfo[p][d][pvTiresDays] - gettime()) / 86400;
                cost = (10 - leftdays) * 5;
            }
            else {
                leftdays = 0;
                cost = 10 * 5;
            }

            if(cost == 0) cost = 5;
            if (Businesses[iBusiness][bInventory] < cost) {
                sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
                return cmd_mech(playerid, "");
            }

            format(title, sizeof(title), "Xe {2C6EAF}%s{FFFFFF} > Lop xe", VehicleName[GetVehicleModel(vid) - 400]);
            format(info, sizeof(info), "{FFFFFF}\
                [#] Trang thai: %s{FFFFFF} (Thiet hai: %d%%)\n\
                [#] Thoi han: con %d ngay\n\
                [#] Yeu cau: %d linh kien\n\n\
                {41B431} -> Ban co muon sua chua lop xe cua phuong tien nay khong?", 
                (tires) ? ("{D31212}Hong") : ("{13BC10}Tot"), tires, leftdays, cost);

            Dialog_Show(playerid, DIALOG_MECH_CONFIRM, DIALOG_STYLE_MSGBOX, title, info, "Co", "Quay lai");
            SetPVarInt(playerid, #repairCost, cost);
            SetPVarInt(playerid, #mechConfirm, 5);
        }
    }
    return 1;
}

Dialog:DIALOG_MECH_CONFIRM(playerid, response, listitem, inputtext[]){
    if(!response) return cmd_mech(playerid, "");
    new 
        p = GetPVarInt(playerid, #pvID),
        d = GetPVarInt(playerid, #pvSlot),
        iBusiness = PlayerInfo[playerid][pBusiness],
        vid = GetPlayerVehicleID(playerid),
        cost = GetPVarInt(playerid, #repairCost),
        panels, lights, doors, tires;

    if (Businesses[iBusiness][bInventory] < GetPVarInt(playerid, #repairCost)) {
        sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Doanh nghiep khong du linh kien de sua chua.");
        return cmd_mech(playerid, "");
    }

    switch(GetPVarInt(playerid, #mechConfirm))
    {
        case 1: {
            Businesses[iBusiness][bInventory] -= cost;

            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            SetVehicleHealth(vid, PlayerVehicleInfo[p][d][pvMaxHealth]);
            PlayerVehicleInfo[p][d][pvHealth] = PlayerVehicleInfo[p][d][pvMaxHealth];
            
            sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua dong co cua chiec xe %s.", VehicleName[GetVehicleModel(vid) - 400]);
        }
        case 2: {
            Businesses[iBusiness][bInventory] -= cost;

            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            GetVehicleDamageStatus(vid, panels, doors, lights, tires);
            UpdateVehicleDamageStatus(vid, panels, doors, 0, tires);
            PlayerVehicleInfo[p][d][pvLights] = 0;

            sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua den chieu sang cua chiec xe %s.", VehicleName[GetVehicleModel(vid) - 400]);
        }
        case 3: {
            Businesses[iBusiness][bInventory] -= cost;

            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            GetVehicleDamageStatus(vid, panels, doors, lights, tires);
            UpdateVehicleDamageStatus(vid, panels, 0, lights, tires);
            PlayerVehicleInfo[p][d][pvDoors] = 0;

            sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua canh cua cua chiec xe %s.", VehicleName[GetVehicleModel(vid) - 400]);
        }
        case 4: {
            Businesses[iBusiness][bInventory] -= cost;

            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            GetVehicleDamageStatus(vid, panels, doors, lights, tires);
            UpdateVehicleDamageStatus(vid, 0, doors, lights, tires);
            PlayerVehicleInfo[p][d][pvPanels] = 0;

            sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua phan than cua chiec xe %s.", VehicleName[GetVehicleModel(vid) - 400]);
        }
        case 5: {
            Businesses[iBusiness][bInventory] -= cost;

            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            GetVehicleDamageStatus(vid, panels, doors, lights, tires);
            UpdateVehicleDamageStatus(vid, panels, doors, lights, 0);
            PlayerVehicleInfo[p][d][pvTires] = 0;

            new extend_days = 10 - ((PlayerVehicleInfo[p][d][pvTiresDays] - gettime()) / 86400);
            if(PlayerVehicleInfo[p][d][pvTiresDays] > gettime()) PlayerVehicleInfo[p][d][pvTiresDays] += extend_days * 86400;
            else PlayerVehicleInfo[p][d][pvTiresDays] = gettime() + (86400 * 10);

            sendMessage(playerid, 0xCE794BFF, "MECH:{FFFFFF} Ban da sua chua lop cua chiec xe %s (gia han them %d ngay).", VehicleName[GetVehicleModel(vid) - 400], extend_days);
        }
    }

    DeletePVar(playerid, #pvID);
    DeletePVar(playerid, #pvSlot);
    DeletePVar(playerid, #repairCost);
    DeletePVar(playerid, #mechConfirm);
    return cmd_mech(playerid, "");
}

CMD:sonxe(playerid, params[]) {
	new iColors[2];
	if (Businesses[PlayerInfo[playerid][pBusiness]][bType] != BUSINESS_TYPE_MECHANIC) return SendErrorMessage(playerid, "Ban khong phai la thanh vien cua tram sua xe.");
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong o trong xe.");
	else if(PlayerInfo[playerid][pSpraycan] == 0) return SendErrorMessage(playerid, " Ban khong co binh son xe nao.");
	if(sscanf(params, "ii", iColors[0], iColors[1])) return SendUsageMessage(playerid, " /mauxe [ID 1] [ID 2]. ID mau sac cua samp.");
	else if((PlayerInfo[playerid][pDonateRank] == 0) && (iColors[0] > 126 || iColors[1] > 126)) return SendErrorMessage(playerid, " Chi VIP moi su dung ID mau sac tren 126.");
	else if(!(0 <= iColors[0] <= 255 && 0 <= iColors[1] <= 255)) return SendErrorMessage(playerid, " Mau sac khong hop le(ID mau sac phai tu 0 cho toi 255).");
	new szMessage[60];
	for(new i = 0; i < MAX_PLAYERVEHICLES; i++)
	{
		if(IsPlayerInVehicle(playerid, PlayerVehicleInfo[playerid][i][pvId]))
		{
			PlayerVehicleInfo[playerid][i][pvColor1] = iColors[0], PlayerVehicleInfo[playerid][i][pvColor2] = iColors[1];
			ChangeVehicleColor(PlayerVehicleInfo[playerid][i][pvId], PlayerVehicleInfo[playerid][i][pvColor1], PlayerVehicleInfo[playerid][i][pvColor2]);
			PlayerInfo[playerid][pSpraycan]--;
			g_mysql_SaveVehicle(playerid, i);
			format(szMessage, sizeof(szMessage), "Ban da thay doi mau sac chiec xe cua ban bang ID %d, %d.", iColors[0], iColors[1]);
			return SendClientMessageEx(playerid, COLOR_GRAD2, szMessage);
		}
	}
	for(new i = 0; i < sizeof(VIPVehicles); i++)
	{
		if(IsPlayerInVehicle(playerid, VIPVehicles[i]))
		{
			ChangeVehicleColor(VIPVehicles[i], iColors[0], iColors[1]);
			PlayerInfo[playerid][pSpraycan]--;
			format(szMessage, sizeof(szMessage), "Ban da thay doi mau sac chiec xe cua ban bang ID %d, %d.", iColors[0], iColors[1]);
			return SendClientMessageEx(playerid, COLOR_GRAD2, szMessage);
		}
	}
	for(new i = 0; i < sizeof(FamedVehicles); i++)
	{
		if(IsPlayerInVehicle(playerid, FamedVehicles[i]))
		{
			ChangeVehicleColor(FamedVehicles[i], iColors[0], iColors[1]);
			PlayerInfo[playerid][pSpraycan]--;
			format(szMessage, sizeof(szMessage), "Ban da thay doi mau sac chiec xe cua ban bang ID %d, %d.", iColors[0], iColors[1]);
			return SendClientMessageEx(playerid, COLOR_GRAD2, szMessage);
		}
	}
	SendErrorMessage(playerid, " Ban khong the son xe cua nguoi khac.");
	return 1;
}

CMD:mtow(playerid, params[]) {
	if(IsPlayerInAnyVehicle(playerid))
	{
		new
			carid = GetPlayerVehicleID(playerid);

		if(IsATowTruck(carid))
		{
			new
				closestcar = GetClosestCar(playerid, carid);

			foreach(new i: Player)
			{
				if(arr_Towing[i] == closestcar || (GetPlayerVehicleID(i) == closestcar && GetPlayerState(i) == 2)) return SendErrorMessage(playerid, " Ban dang keo xe khac, ban khong co quyen keo them xe.");
			}

			if(GetDistanceToCar(playerid,closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid)) {
				foreach(new i: Player)
				{
					if(IsAPlane(closestcar) || IsABike(closestcar) || IsASpawnedTrain(closestcar) || IsATrain(closestcar) || IsAHelicopter(closestcar)) {
						return SendErrorMessage(playerid, " ban khong theo keo xe nay.");
					}
					if(GetPlayerVehicle(i, closestcar) != -1) {

						new
							hKey;

						if(((hKey = PlayerInfo[i][pPhousekey]) != INVALID_HOUSE_ID) && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hKey][hExteriorX], HouseInfo[hKey][hExteriorY], HouseInfo[hKey][hExteriorZ])
						||((hKey = PlayerInfo[i][pPhousekey2]) != INVALID_HOUSE_ID) && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hKey][hExteriorX], HouseInfo[hKey][hExteriorY], HouseInfo[hKey][hExteriorZ])) {
							return SendErrorMessage(playerid, " Chiec xe nay khong can phai keo.");
						}

						arr_Towing[playerid] = closestcar;
						SendErrorMessage(playerid, " Chiec xe da san sang de giam giu.");
						return AttachTrailerToVehicle(closestcar,carid);
					}
				}
				SendErrorMessage(playerid, " Chiec xe nay khong co dang ky, no san sang de giam giu.");
				AttachTrailerToVehicle(closestcar,carid);
				arr_Towing[playerid] = closestcar;
				return 1;
			}
		}
		else if(IsAAircraftTowTruck(carid)) //Tug
		{
			new
				closestcar = GetClosestCar(playerid, carid);

			foreach(new i: Player)
			{
				if(arr_Towing[i] == closestcar || (GetPlayerVehicleID(i) == closestcar && GetPlayerState(i) == 2)) return SendErrorMessage(playerid, " You can't tow a vehicle which is occupied, or in tow.");
			}

			if(GetDistanceToCar(playerid,closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid))
			{
				foreach(new i: Player)
				{
					if(IsAPlane(closestcar))
					{
						if(GetPlayerVehicle(i, closestcar) != -1)
						{
							arr_Towing[playerid] = closestcar;
							SendErrorMessage(playerid, " Chiec xe da san sang de giam giu.");
							return AttachTrailerToVehicle(closestcar,carid);
						}
					}
					else return SendErrorMessage(playerid, " Ban chi co the keo may bay bang xe nay!");
				}
				SendErrorMessage(playerid, " Chiec xe nay khong co dang ky, no san sang de giam giu.");
				AttachTrailerToVehicle(closestcar,carid);
				arr_Towing[playerid] = closestcar;
			}
		}
		else SendErrorMessage(playerid, " Ban khong duoc phep keo xe nay.");
	}
	else SendErrorMessage(playerid, " ban phai o ben  trong xe keo moi co the su dung lenh nay!");
	return 1;
}

CMD:muntow(playerid, params[])
{
	if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
	{
		SendClientMessageEx(playerid, COLOR_GRAD1,"Ban da tha chiec xe ma ban da keo.");
		arr_Towing[playerid] = INVALID_VEHICLE_ID;
		DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GRAD1,"Ban khong keo chiec xe nao.");
	}
	return 1;
}

CMD:setvehhp(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendErrorMessage(playerid, "Ban khong the su dung lenh nay.");
	extract params -> new vehid, Float:hp; else
	{
		return SendUsageMessage(playerid, " /setvehcap [vehid] [health]");
	}
	
    if(!IsValidVehicle(vehid)) return SendErrorMessage(playerid, "ID khong hop le.");

    foreach (new i: Player) {
        for (new d; d < MAX_PLAYERVEHICLES; d++)
        {
            if (PlayerVehicleInfo[i][d][pvId] == vehid)
            {
                PlayerVehicleInfo[i][d][pvMaxHealth] = hp;
                SetVehicleHealth(vehid, hp);

                new mes[128];
                format(mes, sizeof(mes), "Ban da dieu chinh dong co toi da xe ID %i thanh %0.1f.", vehid, hp);
                SendClientMessage(playerid, -1, mes);
                return 1;
            }
        }
    }

    SendErrorMessage(playerid, "Phuong tien khong kha dung.");
	return 1;
}