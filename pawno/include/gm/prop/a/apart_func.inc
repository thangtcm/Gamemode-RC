forward LoadDynamicApartment();
forward OnApartInsert(ApartID);
forward OnApartRemove(apartid);

public LoadDynamicApartment()
{
    new rows = cache_num_rows(), time = GetTickCount(), total;

	if (!rows) return print("[Can Ho] Khong co du lieu duoc tim thay.");

	for(new i; i < rows; i++)
	{
		ApartInfo[i][aID] = cache_get_field_content_int(i, "id");
		ApartInfo[i][aPosX] = cache_get_field_content_float(i, "posx");
		ApartInfo[i][aPosY] = cache_get_field_content_float(i, "posy");
		ApartInfo[i][aPosZ] = cache_get_field_content_float(i, "posz");
		ApartInfo[i][aExitX] = cache_get_field_content_float(i, "exitx");
		ApartInfo[i][aExitY] = cache_get_field_content_float(i, "exity");
		ApartInfo[i][aExitZ] = cache_get_field_content_float(i, "exitz");
		ApartInfo[i][aExitInt] = cache_get_field_content_int(i, "exitint");
		ApartInfo[i][aExitVW] = cache_get_field_content_int(i, "exitvw");
		ApartInfo[i][aPosInt] = cache_get_field_content_int(i, "posint");
		ApartInfo[i][aPosVW] = cache_get_field_content_int(i, "posvw");
		cache_get_field_content(i, "apartname", ApartInfo[i][aApartName], dbHandle, 128);
		

		if (ApartInfo[i][aExitVW] == 0) ApartInfo[i][aExitVW] = i + 1000;
		 
		ApartInfo[i][aApartOn] = 1;
		ApartInfo[i][aCheckPoint] = CreateDynamicCP(ApartInfo[i][aPosX], ApartInfo[i][aPosY], ApartInfo[i][aPosZ], 1.0, ApartInfo[i][aPosVW], ApartInfo[i][aPosInt], -1, 2.0);
		total++;
	}
	printf("[Can Ho] Rows - %i. Load - %i. Time: %i ms.", rows, total, GetTickCount()-time);
	return 1;
}

public OnApartInsert(ApartID)
{
	ApartInfo[ApartID][aID] = cache_insert_id();
	return 1;
}

public OnApartRemove(apartid)
{
    ApartInfo[apartid][aID] = 0;
	ApartInfo[apartid][aPosX] = 0.0000;
	ApartInfo[apartid][aPosY] = 0.0000;
	ApartInfo[apartid][aPosZ] = 0.0000;
	ApartInfo[apartid][aExitX] = 0.0000;
	ApartInfo[apartid][aExitY] = 0.0000;
	ApartInfo[apartid][aExitZ] = 0.0000;
	ApartInfo[apartid][aExitInt] = 0;
	ApartInfo[apartid][aExitVW] = 0;
	ApartInfo[apartid][aPosInt] = 0;
	ApartInfo[apartid][aPosVW] = 0;
	ApartInfo[apartid][aApartOn] = 0;
	return 1;
}

AddApartToFile(apartid, Float:x, Float:y, Float:z, interior, vw)
{
    new query[128 + 128];
	mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `apartment` (posx, posy, posz, posint, posvw) VALUES (%f, %f, %f, %i, %i)", x, y, z, interior, vw);
	mysql_tquery(dbHandle, query, "OnApartInsert", "d", apartid);
	return 1;
}

SetAparmentInterior(playerid, apartid, int)
{
	ApartInfo[apartid][aExitX] = E_APARTINT[int][aPosX];
	ApartInfo[apartid][aExitY] = E_APARTINT[int][aPosY];
	ApartInfo[apartid][aExitZ] = E_APARTINT[int][aPosZ];
	ApartInfo[apartid][aExitInt] = E_APARTINT[int][aInt];
	SendSyntaxMessage(playerid, "Can ho [ID: %i] - Ten noi that: %s", apartid, E_APARTINT[int][aName]);
	Save_Apart(apartid);
	return 1;
}

GetApartmentZone(apartment, type = 0)
{
	new string[70], zone[28];

	GetZone(ApartInfo[apartment][aPosX], ApartInfo[apartment][aPosY], zone, sizeof(zone));
	
	if (IsPointInAnyDynamicArea(ApartInfo[apartment][aPosX], ApartInfo[apartment][aPosY], ApartInfo[apartment][aPosZ])) {
		new areas[10], street_area[1], j = GetNumberDynamicAreasForPoint(ApartInfo[apartment][aPosX], ApartInfo[apartment][aPosY], ApartInfo[apartment][aPosZ]);
		GetDynamicAreasForPoint(ApartInfo[apartment][aPosX], ApartInfo[apartment][aPosY], ApartInfo[apartment][aPosZ], areas, sizeof(areas));

		if (GetStreet(areas, j, street_area)) {
			if (type == 0) 	   format(string, sizeof(string), "%s, %s %i", zone, street_names[street_area[0]], 35+apartment); 
			else if (type == 1) format(string, sizeof(string), "%03d %s,%s", 35+apartment, street_names[street_area[0]], zone);
			else if (type == 2) format(string, sizeof(string), "%s %i", street_names[street_area[0]], 35+apartment); 
			
			return string;
		}
	}

	format(string, sizeof(string), "%s %i", zone, 35+apartment);
	return string;
}


Save_Apart(apartid)
{
	static const query_size[] = "UPDATE `apartment` SET `exitint`=%i,`exitvw`=%i,`posint`=%i,`posvw`=%i,`exitx`=%f,`exity`=%f,`exitz`=%f,`posx`=%f,`posy`=%f,`posz`=%f WHERE `id` = %i";
    new query[sizeof(query_size) - 22 + (11 * 11)];

	format(query, sizeof(query), query_size, 
	ApartInfo[apartid][aExitInt], ApartInfo[apartid][aExitVW], ApartInfo[apartid][aPosInt], ApartInfo[apartid][aPosVW], ApartInfo[apartid][aExitX], ApartInfo[apartid][aExitY], ApartInfo[apartid][aExitZ], ApartInfo[apartid][aPosX], 
	ApartInfo[apartid][aPosY], ApartInfo[apartid][aPosZ], ApartInfo[apartid][aID]);
	mysql_tquery(dbHandle, query);
	return 1;
}

IsPlayerApartmentOutside(playerid, i, Float: radius = 5.0)
{
    return (IsPlayerInRangeOfPoint(playerid, radius, ApartInfo[i][aPosX], ApartInfo[i][aPosY], ApartInfo[i][aPosZ]) && GetWorld(playerid) == ApartInfo[i][aPosVW] && GetInterior(playerid) == ApartInfo[i][aPosInt]) ? (1) : (0);
}

IsPlayerApartmentInside(playerid, i, Float: radius = 60.0)
{
    return (IsPlayerInRangeOfPoint(playerid, radius, ApartInfo[i][aExitX], ApartInfo[i][aExitY], ApartInfo[i][aExitZ]) && GetWorld(playerid) == ApartInfo[i][aExitVW] && GetInterior(playerid) == ApartInfo[i][aExitInt]) ? (1) : (0);
}

GetNearApartment(playerid)
{
    new aapart = GetNearApartmentInside(playerid);

	if (aapart == -1)		aapart = GetNearApartmentOutside(playerid);
	if (aapart != -1)		return aapart;
	
	return -1;
}

GetNearApartmentOutside(playerid)
{
    for(new i; i != MAX_APART; i++)
	{
	    if (ApartInfo[i][aApartOn] == 0) continue;
	    if (IsPlayerInRangeOfPoint(playerid, 3.0, ApartInfo[i][aPosX], ApartInfo[i][aPosY], ApartInfo[i][aPosZ]) && GetWorld(playerid) == ApartInfo[i][aPosVW] && GetInterior(playerid) == ApartInfo[i][aPosInt]) return i;
	}
	return -1;
}

GetNearApartmentInside(playerid, Float: radius = 60.0)
{
	if (pTemp[playerid][pApartEntered] != -1 && IsPlayerApartmentInside(playerid, pTemp[playerid][pApartEntered], radius)) return pTemp[playerid][pApartEntered];

    for(new i; i != MAX_APART; i++)
	{
	    if (ApartInfo[i][aApartOn] == 0) continue;
	    if (IsPlayerInRangeOfPoint(playerid, radius, ApartInfo[i][aExitX], ApartInfo[i][aExitY], ApartInfo[i][aExitZ]) && GetWorld(playerid) == ApartInfo[i][aExitVW] && GetInterior(playerid) == ApartInfo[i][aExitInt])
		{
		    pTemp[playerid][pApartEntered] = i;
			return i;
		}
	}
	return -1;
}

GetNextApartID()
{
	for(new i; i != MAX_APART; i++)
	{
	    if (ApartInfo[i][aApartOn] == 0) return i;
	}
	return -1;
}