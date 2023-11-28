#include <YSI_Coding\y_hooks>

stock LoadVehicleSign()
{
	for(new i = 0 ; i < MAX_VEHICLES; i++) {
		VehSignInfo[i][vs_ID] = -1;
		VehSignInfo[i][vs_OwnerID] = -1;
		VehSignInfo[i][vs_VehicleID] = -1;
	}
	mysql_tquery(MainPipeline, "SELECT * FROM `vehsign`","OnVehicleSign", "");
	return 1;
}

forward OnVehicleSign();
public OnVehicleSign()
{
    new fields, rows, result[128];
    cache_get_data(rows, fields, MainPipeline);

    for( new index; index < rows; index++) {
		cache_get_field_content(index, "id", result, MainPipeline); VehSignInfo[index][vs_ID] = strval(result);
		cache_get_field_content(index, "VehSign", result, MainPipeline); VehSignInfo[index][vs_VehSign] = strval(result);
		cache_get_field_content(index, "OwnerID", result, MainPipeline); VehSignInfo[index][vs_OwnerID] = strval(result);
		cache_get_field_content(index, "VehicleID", result, MainPipeline); VehSignInfo[index][vs_VehicleID] = strval(result);
	}
	if(!rows) return printf("[Vehicle Sign database] 0 Vehicle Sign loaded.", rows);
	printf("[Vehicle Sign database] %d Vehicle Sign loaded.", rows);
	return 1;
}
stock FindVehSign(vehsqlid)
{
	new vsid = -1;
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(VehSignInfo[i][vs_VehicleID] == vehsqlid)
		{
			vsid = i; break;
		}
	}
	return vsid;
}
stock CreateVehSign(playerid, vehid, vehsign_number){
	new format_vs[128];
	format(format_vs, sizeof(format_vs), "SF-%d", vehsign_number);
	SetVehicleNumberPlate(vehid, format_vs);
	return 1;
}


stock RegisterVehSign(playerid, vehslotid)
{

	new vehsign_id;
	for(new i = 0; i < MAX_VEHICLES; i++) {
		if(VehSignInfo[i][vs_ID] == -1 && VehSignInfo[i][vs_OwnerID] == -1 && VehSignInfo[i][vs_VehicleID] == -1) {
			vehsign_id = i; break;
		}
		else if(VehSignInfo[i][vs_VehicleID] == PlayerVehicleInfo[playerid][vehslotid][pvSlotId]){
			SendErrorMessage(playerid, "Chiec xe nay da duoc dang ki roi !");
			return 0;
		}
	}
	new rand_vs = Random(10000,99999);


	VehSignInfo[vehsign_id][vs_ID] = vehsign_id;
	VehSignInfo[vehsign_id][vs_VehSign] = rand_vs;
	VehSignInfo[vehsign_id][vs_OwnerID] = GetPlayerSQLId(playerid);
	VehSignInfo[vehsign_id][vs_VehicleID] = PlayerVehicleInfo[playerid][vehslotid][pvSlotId];

	new freg_vs[1280];
	format(freg_vs, sizeof(freg_vs), "INSERT INTO `vehsign` SET \
		`VehSign` = '%d', \
		`OwnerID` = '%d', \
		`VehicleID` = '%d'",
		VehSignInfo[vehsign_id][vs_VehSign],
		VehSignInfo[vehsign_id][vs_OwnerID],
		VehSignInfo[vehsign_id][vs_VehicleID]);
	mysql_function_query(MainPipeline, freg_vs, true, "VEHSIGN_REG", "");

	new vs_msg[1280];
	format(vs_msg, sizeof(vs_msg), "Chiec xe ban vua dang ki co bien so: {c54640}SF-%d{ffffff}", VehSignInfo[vehsign_id][vs_VehSign]);
	SendClientMessage(playerid, -1, vs_msg);
	SendClientMessage(playerid, -1, "Ban hay tien hanh cat xe va lay ra 1 lan nua de co bien so xe nhe !");
	return 1;
}

stock MenuRegisterVehSign(playerid)
{
	new vstring[4096], icount = GetPlayerVehicleSlots(playerid);
	new statez[30];
	vstring = "Phuong tien\tTinh trang\tGiay to xe";
	for(new i, iModelID; i < icount; i++)
	{
		if((iModelID = PlayerVehicleInfo[playerid][i][pvModelId] - 400) >= 0)
		{
			new VehSignstr[1280], VehSignID = FindVehSign(PlayerVehicleInfo[playerid][i][pvSlotId]);
			if(VehSignID != -1){
				format(VehSignstr, sizeof(VehSignstr), "SF-%d", VehSignInfo[VehSignID][vs_VehSign]);
			} else VehSignstr = "{c54640}Chua dang ky{FFFFFF}";
			switch(PlayerVehicleInfo[playerid][i][pvGiayToXe]) 
			{
				case 0: statez = "{c54640}Chua dang ky{FFFFFF}";
				case 1: statez = "{36e198}Da dang ky{FFFFFF}";
			}
			if(PlayerVehicleInfo[playerid][i][pvImpounded]) {
				format(vstring, sizeof(vstring), "%s\n[%d]%s\t{f0635c}Tich thu{ffffff}\t%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID],statez);
			}
			else if(PlayerVehicleInfo[playerid][i][pvDisabled]) {
				format(vstring, sizeof(vstring), "%s\n[%d]%s\t{f0635c}Khong dung duoc{ffffff}\t%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID],statez);
			}
			else if(!PlayerVehicleInfo[playerid][i][pvSpawned]) {
				format(vstring, sizeof(vstring), "%s\n[%d]%s\t{eedf4f}Trong Garage{ffffff}\t%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID],statez);
			}
			else format(vstring, sizeof(vstring), "%s\n[%d]%s\t{7fe39a}Dang su dung{ffffff}\t%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID],statez);
		}
	}
	format(vstring, sizeof(vstring), "%s", vstring);
	ShowPlayerDialog(playerid, VEHSIGN_DLG, DIALOG_STYLE_TABLIST_HEADERS, "Kho phuong tien", vstring, "Chon", "Huy bo");
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == VEHSIGN_DLG && response == 1)
	{
		if(PlayerVehicleInfo[playerid][listitem][pvSpawned]) {
			RegisterVehSign(playerid, listitem);
		}
		else if(PlayerVehicleInfo[playerid][listitem][pvImpounded]) {
			SendServerMessage(playerid, " Ban khong the dang ki mot chiec xe khi dang bi thu giu. Neu muon dang ki lai ban toi DMV de nop tien phat xe.");
		}
		else if(PlayerVehicleInfo[playerid][listitem][pvDisabled]) {
			SendServerMessage(playerid, " Ban khong the dang ki khi xe dang bi vo hieu hoa tai slot. No bi vo hieu hoa do cap do VIP cua ban (Xe han che).");
		}
		else if((PlayerInfo[playerid][pRVehRestricted] > gettime() || PlayerVehicleInfo[playerid][listitem][pvRestricted] > gettime()) && IsRestrictedVehicle(PlayerVehicleInfo[playerid][listitem][pvModelId]))
        {
            SendErrorMessage(playerid, " Ban khong duoc phep dang ki chiec xe han che nay");
        }
		else if(!PlayerVehicleInfo[playerid][listitem][pvSpawned]) 
		{
			RegisterVehSign(playerid, listitem);
		}
		else SendServerMessage(playerid, " Ban khong the dang ki mot chiec xe khong ton tai.");
	}
	return 1;
}

CMD:dangkibienso(playerid, params[])
{
	MenuRegisterVehSign(playerid);
	return 1;
}