Tower_OnGameModeInit()
{
	mysql_tquery(dbHandle, "SELECT * FROM `towers`", "LoadDynamicTowers");
	return 1;
}

this::LoadDynamicTowers()
{
	new rows = cache_num_rows(),
	    time = GetTickCount(),
		total;

	if (!rows)
	{
	    print("[Towers] Khong co du lieu duoc tim thay.");
	    return 1;
	}

	for(new i; i < rows; i++)
	{
	    TowerInfo[i][towerID] = cache_get_field_content_int(i, "id");
	    TowerInfo[i][towerModel] = cache_get_field_content_int(i, "model");
		TowerInfo[i][towerPosX] = cache_get_field_content_float(i, "x");
		TowerInfo[i][towerPosY] = cache_get_field_content_float(i, "y");
		TowerInfo[i][towerPosZ] = cache_get_field_content_float(i, "z");
		TowerInfo[i][towerPosRX] = cache_get_field_content_float(i, "rx");
		TowerInfo[i][towerPosRY] = cache_get_field_content_float(i, "ry");
		TowerInfo[i][towerPosRZ] = cache_get_field_content_float(i, "rz");

		TowerInfo[i][towerObject] =
			CreateDynamicObject(TowerInfo[i][towerModel], TowerInfo[i][towerPosX], TowerInfo[i][towerPosY], TowerInfo[i][towerPosZ], TowerInfo[i][towerPosRX], TowerInfo[i][towerPosRY], TowerInfo[i][towerPosRZ], 0, 0);

		TowerInfo[i][towerOn] = 1;
        total++;
	}
	printf("[Towers] Rows - %i. Load - %i. Time: %i ms.", rows, total, GetTickCount()-time);
	return 1;
}

this::OnTowerInsert(towerid)
{
	TowerInfo[towerid][towerID] = cache_insert_id();
	return 1;
}

Tow_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new Float:oldX, Float:oldY, Float:oldZ,
	Float:oldRotX, Float:oldRotY, Float:oldRotZ;

    GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
	GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

	if (GetPVarInt(playerid, #edit_tower) && TowerInfo[GetPVarInt(playerid, #edit_tower)-1][towerObject] == objectid && TowerInfo[GetPVarInt(playerid, #edit_tower)-1][towerOn])
	{
		if (response == EDIT_RESPONSE_FINAL)
		{
		    new tower = GetPVarInt(playerid, #edit_tower)-1;
	    	DeletePVar(playerid, #edit_tower);
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);

			new query[156];
			mysql_format(dbHandle, query, sizeof(query), "UPDATE `towers` SET `x` = %f, `y` = %f, `z` = %f, `rx` = %f, `ry` = %f, `rz` = %f WHERE `id` = %i",x,y,z,rx,ry,rz,TowerInfo[tower][towerID]);
			mysql_tquery(dbHandle, query);

			GetDynamicObjectPos(objectid, TowerInfo[tower][towerPosX], TowerInfo[tower][towerPosY], TowerInfo[tower][towerPosZ]);
			GetDynamicObjectRot(objectid, TowerInfo[tower][towerPosRX], TowerInfo[tower][towerPosRY], TowerInfo[tower][towerPosRZ]);

  			SendServerMessage(playerid, "Chinh sua vi tri thap ID: %i thanh cong.", tower);
		}
		else if (response == EDIT_RESPONSE_CANCEL)
		{
	    	DeletePVar(playerid, #edit_tower);
			SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
			SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
		}
	}
	return 1;
}