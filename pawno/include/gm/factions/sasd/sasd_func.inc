this::LoadDynamicAPB()
{
    new rows = cache_num_rows(), time = GetTickCount(), total;

	if (!rows) return print("[APBS] Khong co du lieu duoc tim thay.");
	  

	for(new i = 0; i < rows; i++)
	{
	    ApbInfo[i][apbID] = cache_get_field_content_int(i, "id");
	    cache_get_field_content(i, "charge", ApbInfo[i][apbCharge], dbHandle, 128);
        cache_get_field_content(i, "suspect", ApbInfo[i][apbSuspect], dbHandle, MAX_PLAYER_NAME);
        cache_get_field_content(i, "officer", ApbInfo[i][apbOfficer], dbHandle, MAX_PLAYER_NAME);
		cache_get_field_content(i, "date", ApbInfo[i][apbDate], dbHandle, MAX_PLAYER_NAME);

        ApbInfo[i][apbFaction] = cache_get_field_content_int(i, "faction");
		ApbInfo[i][apbOn] = 1;

        total++;
	}
	printf("[APBS] Rows - %i. Load - %i. Time: %i ms.", rows, total, GetTickCount()-time);
	return 1;
}

this::ApbCreate(apb)
{
	ApbInfo[apb][apbID] = cache_insert_id();
	ApbInfo[apb][apbOn] = 1;
	return 1;
}

this::PoliceSetPlate(playerid, vehicleid, plate[])
{
	if (cache_num_rows())	return SendErrorMessage(playerid,"Bien so xe khong co, vui long thu go lai lenh.");

    format(VehicleInfo[vehicleid][carPlate], 24, "%s", plate);
	SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][carPlate]);
	RespawnVehicle(vehicleid, 1);
	Save_Car(vehicleid);
	SendSyntaxMessage(playerid, "Ban da thay doi bien so xe cua %s. Bien so moi la %s", VehicleNames[GetVehicleModel(vehicleid)-400], VehicleInfo[vehicleid][carPlate]);
	return 1;
}

/*this::OnCheckNumber(playerid)
{
	if (!cache_num_rows())
	{
	    Dialog_Show(playerid, MDCVehicle, DIALOG_STYLE_INPUT, "{8D8DFF}MDC - ����� ����������", "{B4B5B7}����� ���������� �� ����������\n\n������� �������� ����:\n\n(( ����� �� ))", "Done", "Quay lai");
	    return SendErrorMessage(playerid, "���������� � ����� �������� ������ �� ������.");
	}

	new ownername[MAX_PLAYER_NAME], model, plate[24], date[24];

	cache_get_field_content(0, "ownername", ownername);
	strreplace(ownername, '_', ' ');
    cache_get_field_content(0, "plate", plate);
    model = cache_get_field_content_int(0, "model");
    cache_get_field_content(0, "date", date);

	static const str_size[] = "{B4B5B7}���������� ������ �� ������ ��\n\n�������� ����: %s\n����� ����������: %s\n�������� ����������: %s\n���� �������: %s";
	new mes[sizeof(str_size) - 4 + 24 + 32 + MAX_PLAYER_NAME + 24 + (10 * 24)];

 	format(mes, sizeof(mes), str_size, plate, VehicleNames[model-400], ownername, date);

	new vehicle, count;
	if ((vehicle = FindVehicleByPlate(plate)) != -1)
	{
	    for(new i; i != MAX_CAR_TICKETS; i++)
		{
		    if (vTickets[vehicle][i][tID] == 0) 	continue;
            if (count == 0) 						strcat(mes, "\n\n������");
			    
            format(mes, sizeof(mes), "%s\n#i: $%i - %.11s...", mes, count+1, FormatNumber(vTickets[vehicle][i][tAmount]), vTickets[vehicle][i][tReason]);
			count++;
		}
		
		if (!count) strcat(mes, "\n\n��� ������������ �������");
	}
	else strcat(mes, "\n\n{FF6347}��������� �� �� �������");

	Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "{8D8DFF}MDC - ����� �� ������", mes, "-", "");
	return 1;
}

this::PersonInfo(playerid, userid)
{
	new str[128], mdc[1024] = "{B4B5B7}��������� ������\n\n";

	format(str, sizeof(str), "������ ���: %s, ���� ��������: %s\n", GetNameEx(userid),PlayerInfo[userid][pBirthdate]);
	strcat(mdc, str);
	format(str, sizeof(str), "phone number: %i\n",PlayerInfo[userid][pNumber]);
	strcat(mdc, str);
	format(str, sizeof(str), "������: %i\n", CountPlayerTickets(userid));
	strcat(mdc, str);

	switch(PlayerInfo[userid][pCarLic])
	{
	    case 0: strcat(mdc, "�������� �� ��������: ���\n");
	    case 1: strcat(mdc, "�������� �� ��������: ��\n");
	}
	format(str, sizeof(str), "�������������� ��������: %i\n\n",PlayerInfo[userid][pDriveWarns]);
	strcat(mdc, str);
	switch(PlayerInfo[userid][pWepLic])
	{
	    case 0: strcat(mdc, "�������� �� ������: ���\n");
	    case 1: strcat(mdc, "�������� �� ������: ��\n");
	}
	format(str, sizeof(str), "��������������: %i\n\n",PlayerInfo[userid][pWepWarns]);
	strcat(mdc, str);
	switch(PlayerInfo[userid][pFlyLic])
	{
	    case 0: strcat(mdc, "�������� �� �����: ���\n");
	    case 1: strcat(mdc, "�������� �� �����: ��\n");
	}
	switch(PlayerInfo[userid][pTaxiLic])
	{
	    case 0: strcat(mdc, "�������� �� ��������� �����: ���\n\n");
	    case 1: strcat(mdc, "�������� �� ��������� �����: ��\n\n");
	}

	new count;

	for(new i; i < MAX_HOUSES; i++)
	{
	    if (!HouseInfo[i][hID] || HouseInfo[i][hOwnerID] != PlayerInfo[userid][pID]) continue;

		format(str, sizeof(str), "����� ����������: %s, %03d\n\n", GetHouseZone(i), i);
		strcat(mdc, str);
		count++;
		
		if (count > 4) break;
	}

	if (!count) strcat(mdc, "����� ����������: �� �������\n\n\n");

	count = 0;

	foreach(new i : Vehicle)
	{
	    if (VehicleInfo[i][carOwnerID] != PlayerInfo[userid][pID]) continue;

        format(str, sizeof(str), "������������ ��������: %s\nPhone: %s\n\n", VehicleNames[VehicleInfo[i][carModel]-400], VehicleInfo[i][carPlate]);
		strcat(mdc, str);

		if (count > 5) break;
	}

	strcat(mdc, "������������ ������:\n");
	format(str, sizeof(str), "������: %i\n", PlayerInfo[userid][pArrested]);
	strcat(mdc, str);

    if (PlayerInfo[playerid][pJailed] == PRISON_JAIL)
	{
		format(str, sizeof(str), "�������� ����������: %s%i\n\n",(PlayerInfo[userid][pIsolateTime] != 0)?("B"):("A"), PlayerInfo[userid][pPrisoned]+100);
		strcat(mdc, str);
	}

	format(str, sizeof(str), "%s\n\n", (cache_num_rows() > 0)?("� �������"):("�� � �������"));
	strcat(mdc, str);

	for(new i; i < cache_num_rows(); i++)
	{
        cache_get_field_content(i, "charge", str);
        strcat(mdc, str);
        strcat(mdc, "\n");
	}
	Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "{8D8DFF}Police MDC", mdc, "-", "");
	return 1;
}*/

SetPlayerZond(playerid, step)
{
	if (step == 0)
	{
	    if (pTemp[playerid][pZond] != 1) return 1;

	    TogglePlayerSpectating(playerid, 0);
		DestroyPlayerObject(playerid, pTemp[playerid][pZondObj]);

		if (IsValidDynamic3DTextLabel(pTemp[playerid][pZondLabel]))
		{
		    DestroyDynamic3DTextLabel(pTemp[playerid][pZondLabel]);
		    pTemp[playerid][pZondLabel] = Text3D:INVALID_3DTEXT_ID;
		}
		
		DestroyDynamicActor(pTemp[playerid][pZondActor]);
		pTemp[playerid][pZondActor] = INVALID_ACTOR_ID;

		for(new i; i < 11; i++) TextDrawHideForPlayer(playerid, zond_cam[i]);
	    return 1;
	}

	new id = -1, Float: x, Float: y, Float: z, vw, interior;

	if ((id = GetNearOutsideBiz(playerid)) != -1 && (BizInfo[id][bizType] != BIZ_GAS_STATION && BizInfo[id][bizType] != BIZ_AUTOSALON && BizInfo[id][bizType] != BIZ_ADVERT && BizInfo[id][bizType] != BIZ_TUNING && BizInfo[id][bizType] != BIZ_LICENSE && BizInfo[id][bizType] != BIZ_BOATSALON && BizInfo[id][bizType] != BIZ_FLYSALON))
	{
	    x = BizInfo[id][bizExitX];
	    y = BizInfo[id][bizExitY];
	    z = BizInfo[id][bizExitZ];
	    vw = BizInfo[id][bizExitVW];
	    interior = BizInfo[id][bizExitInt];
	}

	if (id == -1 && (id = GetNearOutsideHouse(playerid)) != -1)
	{
	    x = HouseInfo[id][hExitX];
	    y = HouseInfo[id][hExitY];
	    z = HouseInfo[id][hExitZ];
	    vw = HouseInfo[id][hExitVW];
	    interior = HouseInfo[id][hExitInt];
	}

	if (id == -1 && (id = GetNearOutsideExtHouse(playerid)) != -1)
	{
	    x = HouseInfo[id][hExtX][0];
	    y = HouseInfo[id][hExtY][0];
	    z = HouseInfo[id][hExtZ][0];
	    vw = HouseInfo[id][hExtVW][0];
	    interior = HouseInfo[id][hExtInt][0];
	}

	if (id == -1 && (id = GetNearApartmentOutside(playerid)) != -1)
	{
	    x = ApartInfo[id][aExitX];
	    y = ApartInfo[id][aExitY];
	    z = ApartInfo[id][aExitZ];
	    vw = ApartInfo[id][aExitVW];
	    interior = ApartInfo[id][aExitInt];
	}

	if (id == -1) return 1;

	SavePlayerPos(playerid);
    GameTextForPlayer(playerid, "_", 1, 4);

    if (IsValidDynamic3DTextLabel(pTemp[playerid][pZondLabel]))
	{
	    DestroyDynamic3DTextLabel(pTemp[playerid][pZondLabel]);
	    pTemp[playerid][pZondLabel] = Text3D:INVALID_3DTEXT_ID;
 	}

 	new mes[128];

	format(mes, sizeof(mes),"(( %s su dung mot thiet bi tham do. ))", GetNameWithMask(playerid));
	pTemp[playerid][pZondLabel] = CreateDynamic3DTextLabel(mes, COLOR_PURPLE, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GetWorld(playerid), GetInterior(playerid));
	pTemp[playerid][pZondActor] = CreateDynamicActor(GetPlayerSkin(playerid), PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pPosA], GetWorld(playerid), GetInterior(playerid));
	ApplyDynamicActorAnimation(pTemp[playerid][pZondActor], "BOMBER", "NULL", 0.0, 0, 0, 0, 0, 0);
	ApplyDynamicActorAnimation(pTemp[playerid][pZondActor], "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 0, 1, 0);
	TogglePlayerSpectating(playerid, 1);
    pTemp[playerid][pZondObj] = CreatePlayerObject(playerid, 19300, x, y, z, 0.0, 0.0, 0.0);
	AttachCameraToPlayerObject(playerid, pTemp[playerid][pZondObj]);
	SetInterior(playerid, interior);
	SetWorld(playerid, vw);

	for(new i; i<11;i++) TextDrawShowForPlayer(playerid, zond_cam[i]);

	pTemp[playerid][pZond] = 1;

	SendFactionMessage(FACTION_POLICE, COLOR_POLICECHAT, "* %s %s bat dau su dung /zond.", GetRankName(playerid), GetNameEx(playerid));
	return 1;
}

TracePlayer(playerid)
{
	new targetid = pTemp[playerid][pTracePlayer];

	pTemp[playerid][pTraceStage]++;

	if (pTemp[playerid][pTraceStage] < 9 && (0 == IsPlayerLogged(targetid) || PlayerInfo[targetid][pPhoneAirplane] != 0 || PlayerInfo[targetid][pPhoneOff] != 0 || 0 == GetPlayerNetwork(targetid)))
	{
	    if (pTemp[playerid][pTraceGZ] != -1) GangZoneDestroy(pTemp[playerid][pTraceGZ]);
	    
		pTemp[playerid][pTraceGZ] = -1;
	    pTemp[playerid][pTracePlayer] = INVALID_PLAYER_ID;
	    pTemp[playerid][pTraceStage] = 0;
	    SendErrorMessage(playerid, "Mat tin hieu.");

	    return 1;
	}

	new mulstatus[16], sevstatus[16], verstatus[16], mes[712];

	if (pTemp[playerid][pTraceDist][0] >= 1250.0) mulstatus = "{FF6347}YEU";
	else if (pTemp[playerid][pTraceDist][0] < 1250.0) mulstatus = "{DABB3E}TOT";

	if (pTemp[playerid][pTraceDist][1] >= 1250.0) sevstatus = "{FF6347}YEU";
	else if (pTemp[playerid][pTraceDist][1] < 1250.0) sevstatus = "{DABB3E}TOT";

	if (pTemp[playerid][pTraceDist][1] >= 1250.0) verstatus = "{FF6347}YEU";
	else if (pTemp[playerid][pTraceDist][1] < 1250.0) verstatus = "{DABB3E}TOT";

    if (pTemp[playerid][pTraceStage] < 9)
    {
	    if (pTemp[playerid][pTraceStage] > 1) format(mes, sizeof(mes), "{AFAFAF}Nhan duoc phan hoi %s {AFAFAF}tu {FFFFFF}Mulholland{AFAFAF} ...\n", mulstatus);
	    if (pTemp[playerid][pTraceStage] > 3) format(mes, sizeof(mes), "%s{AFAFAF}han duoc phan hoi %s {AFAFAF}tu {FFFFFF}Mulholland{AFAFAF} ...\n", mes, sevstatus);
	    if (pTemp[playerid][pTraceStage] > 5) format(mes, sizeof(mes), "%s{AFAFAF}han duoc phan hoi %s {AFAFAF}tu {FFFFFF}Verona Beach{AFAFAF} ...",mes, verstatus);

		if (pTemp[playerid][pTraceStage] == 8)
		{
		    new location[MAX_ZONE_NAME];
		    GetPlayer2DZone(targetid, location, MAX_ZONE_NAME);

		    new Float:x, Float:y, Float:z;

			if (GetWorld(targetid) || GetInterior(targetid))
			{
				x = PlayerInfo[targetid][pLocationPos][0];
				y = PlayerInfo[targetid][pLocationPos][1];
				z = PlayerInfo[targetid][pLocationPos][2];
			}
			else GetPlayerPos(targetid, x, y, z);

		    format(mes, sizeof(mes), "%s\n{AFAFAF}... Theo doi da hoan tat.\n\n\nVi tri gan dung. %s\nso dien thoai: %i / So huu: %s", mes, location, PlayerInfo[targetid][pNumber], GetNameEx(targetid));

		    pTemp[playerid][pTraceGZ] = GangZoneCreate(x+65, y+65, x-65,y-65);
			GangZoneShowForPlayer(playerid, pTemp[playerid][pTraceGZ], 0xFF0000AA);
		}
		Dialog_Show(playerid, ShowTrace, DIALOG_STYLE_MSGBOX, "He thong theo doi - Nhan ESC / ENTER de thoat", mes, "Dong", "");
	}	

	if (pTemp[playerid][pTraceStage] > 600)
	{
	    if (pTemp[playerid][pTraceGZ] != -1) GangZoneDestroy(pTemp[playerid][pTraceGZ]);
	    pTemp[playerid][pTraceGZ] = -1;

	    pTemp[playerid][pTracePlayer] = INVALID_PLAYER_ID;
	    pTemp[playerid][pTraceStage] = 0;
	}
	return 1;
}

Add_Call(playerid, type, text[])
{
	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid,x, y, z);
	for(new i = 0; i != MAX_CALLS_AND_ARREST; i++)
	{
	    if (CallInfo[i][callExists] != 0) continue;

        GetPlayerPos(playerid, CallInfo[i][callPosX], CallInfo[i][callPosY], CallInfo[i][callPosZ]);
        CallInfo[i][callType] = type;
        format(CallInfo[i][callText], 128, "%s", text);
        format(CallInfo[i][callDate], 32, "%s", GetFullDate());
        GetPlayer2DZone(playerid, CallInfo[i][callLocation], MAX_ZONE_NAME);
        
        
		if (pTemp[playerid][pPayphone] == -1)
		{
			format(CallInfo[i][callName], MAX_PLAYER_NAME, "%s", GetNameEx(playerid));
			CallInfo[i][callPhone] = PlayerInfo[playerid][pNumber];
		}	
		else
		{
			format(CallInfo[i][callName], MAX_PLAYER_NAME, "Dien thoai cong cong");
			CallInfo[i][callPhone] = PayphoneInfo[pTemp[playerid][pPayphone]][phNumber];
		}

        CallInfo[i][callDelete] = gettime() + 1200;
        CallInfo[i][callExists] = 1;
        break;
	}
	return 1;
}

Get_Calls(playerid)
{
	if (!IsPlayerFactionPolice(playerid) &&
		!IsPlayerFactionMedic(playerid) &&
		!IsPlayerFactionFire(playerid)) return 1;

	new mes[512], count, type = (IsPlayerFactionMedic(playerid) || IsPlayerFactionFire(playerid))?(2):(1);

    for(new i = 0; i != MAX_CALLS_AND_ARREST; i++)
	{
	    if (CallInfo[i][callExists] == 0 || (CallInfo[i][callType] != type && CallInfo[i][callType] != 3)) continue;
		format(mes, sizeof(mes), "%s\n%i. %s (Dien thoai: %i), %s", mes, count+1, CallInfo[i][callName], CallInfo[i][callPhone], CallInfo[i][callDate]);
		count++;
	}

	if (!count) return SendErrorMessage(playerid, "Khong co cuoc goi 911 nao kha dung. ");

	Dialog_Show(playerid, MDCCall, DIALOG_STYLE_LIST, "{8D8DFF}MDC - Cuoc goi 911", mes, "Chon", "Quay lai");
	return 1;
}

GetArrestID(playerid)
{
	if (PlayerToPoint(5.0, playerid, 1580.5043,-1672.8867,2982.2800))	return PALOMINO_JAIL;
	//if (PlayerToPoint(5.0, playerid, -133.6486,1336.4399,845.0739))		return SASD_JAIL;//sasd
	//if (PlayerToPoint(5.0, playerid, 2757.4048,-1115.1128,1028.5006))	return LSPD_JAIL;//LSPD HQ

	return 0;
}

Add_Arrest(playerid, suspect, time)
{
	for(new i = 0; i != MAX_CALLS_AND_ARREST; i++)
	{
		if (ArrestInfo[i][arrestExists] != 0) continue;

		format(ArrestInfo[i][arrestDate], 32, "%s", GetFullDate());
		format(ArrestInfo[i][arrestSuspect], MAX_PLAYER_NAME, "%s", GetNameEx(suspect));
		format(ArrestInfo[i][arrestOfficer], MAX_PLAYER_NAME, "%s", GetNameEx(playerid));
		ArrestInfo[i][arrestTime] = time;
		ArrestInfo[i][arrestDelete] = gettime() + 1200;
		ArrestInfo[i][arrestExists] = 1;
		break;
	}
	return 1;
}

AddCriminalRecord(playerid, const charge[], officer[], faction, arrest = 0)
{
	if (!strlen(charge)) return SendErrorMessage(playerid, "Khoan phi qua ngan.");

    new query[256];
	mysql_format(dbHandle, query, sizeof(query),"INSERT INTO `criminalrecords` (userid, charge, date, officer, faction, arrest) VALUES (%i, '%e', '%s', '%e', %i, %i)", PlayerInfo[playerid][pID], charge, GetFullDate(), officer, faction, arrest);
	mysql_tquery(dbHandle, query);
	return 1;
}

Patrul_Init()
{
	for(new i; i != MAX_PATROL; i++)
	{
	    PatrolInfo[0][i][patrulOfficer][0] = INVALID_PLAYER_ID;
	    PatrolInfo[0][i][patrulOfficer][1] = INVALID_PLAYER_ID;
	    PatrolInfo[1][i][patrulOfficer][0] = INVALID_PLAYER_ID;
	    PatrolInfo[1][i][patrulOfficer][1] = INVALID_PLAYER_ID;
	}
	return 1;
}

GetPatrolID(playerid)
{
	return (IsPlayerFactionPolice(playerid))?(1):(0);
}

StartChase(playerid)
{
	SetPVarInt(playerid, #Chase_Time, 300);
	SetPVarInt(playerid, #Chase_Timer, SetTimerEx("Chasing", 1000, true, "i", playerid));
	return 1;
}

this::Chasing(playerid)
{
	if (GetPVarInt(playerid, #Chase_Time) > 1) {
		SetPVarInt(playerid, #Chase_Time, GetPVarInt(playerid, #Chase_Time) - 1);
	} else {
		KillTimer(GetPVarInt(playerid, #Chase_Timer));
		DeletePVar(playerid, #Chase_Time);
		DeletePVar(playerid, #Chase_Timer);

		foreach(new i : Player)
		{
			if (IsPlayerLogged(i) == 0 || !IsPlayerFactionPolice(i))	continue;
			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
		}
		return 1;
	}

	foreach(new i : Player)
	{
		if (IsPlayerLogged(i) == 0 || !IsPlayerFactionPolice(i))	continue;
		if (!PlayerNearPlayer(30.0, i, playerid)) {
			SetPlayerMarkerForPlayer(i, playerid, TEAM_HIT_COLOR);
		}
		else {
			SetPlayerMarkerForPlayer(i, playerid, 0xA52A2AFF);
		}
	}

	return 1;
}

PutPlayerInPrison(playerid)
{
	if (PlayerInfo[playerid][pJailed] == 0) return 1;

   	/*if (PlayerInfo[playerid][pJailed] == LSPD_JAIL)
	{
	    new i = random(sizeof(prison_lspd));
	    SetPlayerPosEx(playerid, prison_lspd[i][0], prison_lspd[i][1], prison_lspd[i][2]);
		SetInterior(playerid, 1);
		SetWorld(playerid, 1);
		return 1;
	}
	else if (PlayerInfo[playerid][pJailed] == SASD_JAIL)
	{
	    SetPlayerPosEx(playerid, -133.8623,1331.5747,845.0739);
		SetInterior(playerid, 3);
		SetWorld(playerid, 3);
		return 1;
	}*/
	else if (PlayerInfo[playerid][pJailed] == PALOMINO_JAIL)
	{
	    new i = random(sizeof(prison_palomino));
	    SetPlayerPosEx(playerid, prison_palomino[i][0], prison_palomino[i][1], prison_palomino[i][2]);

		SetInterior(playerid, 16);
		SetWorld(playerid, 23);
		return 1;
	}
	
	if (PlayerInfo[playerid][pIsolateTime] != 0)
	{
	    if (IsValidDynamic3DTextLabel(PrisonLabel[playerid]))
		{
			DestroyDynamic3DTextLabel(PrisonLabel[playerid]);
	        PrisonLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
		}
		new mes[5];
		format(mes, sizeof(mes), "B%i", PlayerInfo[playerid][pPrisoned] + 100);
        PrisonLabel[playerid] = CreateDynamic3DTextLabel(mes, 0xFF0000FF, 0,0,0.1, 15.0, playerid, INVALID_VEHICLE_ID, 1);

	    new i = PlayerInfo[playerid][pPrisoned];
	    SetPlayerPosEx(playerid, prison_isolate[i][0], prison_isolate[i][1], prison_isolate[i][2]);
		SetInterior(playerid, 6);
		SetWorld(playerid, 7);
		return 1;
	}
	
	if (PlayerInfo[playerid][pJailed] == PRISON_JAIL)
	{
        if (IsValidDynamic3DTextLabel(PrisonLabel[playerid]))
		{
			DestroyDynamic3DTextLabel(PrisonLabel[playerid]);
	        PrisonLabel[playerid] = Text3D:INVALID_3DTEXT_ID;
		}

		new mes[5];

		format(mes, sizeof(mes), "A%i", PlayerInfo[playerid][pPrisoned] + 100);
        PrisonLabel[playerid] = CreateDynamic3DTextLabel(mes, 0x00FF00FF, 0,0,0.1, 15.0, playerid, INVALID_VEHICLE_ID, 1);

	    new i = PlayerInfo[playerid][pPrisoned];

	    SetPlayerPosEx(playerid, prison_sadoc[i][0], prison_sadoc[i][1], prison_sadoc[i][2]);
		SetInterior(playerid, 6);
		SetWorld(playerid, 6);
		return 1;
	}
	return 1;
}

CreateStrip(Float:x, Float:y, Float:z, Float:angle)
{
	for(new i; i != MAX_SPIKE; i++)
	{
	    if (SpikeInfo[i][sCreated]) continue;

        SpikeInfo[i][sObject] = CreateDynamicObject(2899, x, y, z-0.9, 0, 0, angle-90);
		SpikeInfo[i][sCreated] = 1;
		SpikeInfo[i][sX] = x;
		SpikeInfo[i][sY] = y;
		SpikeInfo[i][sZ] = z-0.9;
		return i;
	}
	return -1;
}

MegaphoneSoundVoice(playerid, type)
{
    if (type < 1 || type > 7) return 1;

	new police_car_sound[7] = {15800,15811,15812,15819,15824,15825,15855};

 	PlayerPlaySoundEx(playerid, police_car_sound[type-1]);
	return 1;
}

PoliceOnline()
{
    new count = 0;
    foreach(new i : Player)
    {
        if (IsPlayerLogged(i) == 0)		continue;
		if (IsPlayerFactionPolice(i))	continue;
		if (IsPlayerAFK(i))				continue;
		if (!PlayerInfo[i][pOnDuty])		continue;
		
        count++;
    }
   	if (count < NEED_COPS_TO_CRIME)	return 0;
	else 							return 1; 
}

IsPoliceNear(playerid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x2,y2,z2);
    
	foreach(new i : Player)
    {
        if (IsPlayerLogged(i) == 0)										 continue;
		if (PlayerInfo[i][pFaction] != 1 && PlayerInfo[i][pFaction] != 3) continue;
		if (!PlayerInfo[i][pOnDuty])										 continue;

		GetPlayerPos(i,x1,y1,z1);
		if (GetDistanceBetweenPoints(x1,y1,z1,x2,y2,z2) < 30.0) return 1;
    }
	return 0;
}

this::Rappelling(playerid)
{
	if(!GetPVarInt(playerid, #SWATROPE)) return false;

    SetTimerEx("Rappelling", ROPETIME, 0, "i", playerid);
    ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
    return 1;
}

OnPlayerCallRappelling(playerid)
{
	new
		Float:playerX,
		Float:playerY,
		Float:playerZ,
		Float:groundZ,
		Float:subZ;

	GetPlayerPos(playerid, playerX, playerY, playerZ);
	MapAndreas_FindZ_For2DCoord(playerX, playerY, groundZ); //#include <mapandreas>

	subZ = playerZ - groundZ;
	if(subZ >= MAX_ROPE_LENGTH) return SendErrorMessage(playerid, "Qua cao!");
	if(subZ <= 2) 				return RemovePlayerFromVehicle(playerid);

	SetPVarInt(playerid, #SWATROPE, 1);

	SetPlayerCheckpoint(playerid, playerX, playerY, ROPEOFFSETZ - groundZ, 3.0);
	SetPlayerPos(playerid, playerX, playerY, playerZ - 1.0);
	SetPlayerVelocity(playerid, 0, 0, 0);

	for (new i = 0; i != 10; i++) ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);

	for (new i = 0; i <= subZ; i++) {
		RopesInfo[playerid][i] = CreateObject(3004, playerX, playerY, floatadd(groundZ, i), 87.640026855469, 342.13500976563, 350.07507324219);
	}

	SetTimerEx("Rappelling", ROPETIME, 0, "i", playerid);
	return 1;
}