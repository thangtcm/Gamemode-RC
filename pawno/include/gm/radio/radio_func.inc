forward LoadDynamicRadios();
forward OnChannelInsert(playerid, channel);

public LoadDynamicRadios()
{
    new rows = cache_num_rows(), time = GetTickCount(), total;

	if (!rows)	return print("[Radio] Khong co du lieu duoc tim thay.");

	for(new i; i < rows; i++)
	{
	    RadiosInfo[i][radioID] = cache_get_field_content_int(i, "id");
		RadiosInfo[i][radioChannel] = cache_get_field_content_int(i, "channelid");
		RadiosInfo[i][radioOwner] = cache_get_field_content_int(i, "owner");
		cache_get_field_content(i, "pass", RadiosInfo[i][radioPass], dbHandle, 33);

		RadiosInfo[i][radioOn] = 1;
		total++;
	}
	printf("[Radio] Rows - %i. Load - %i. Time: %i ms.", rows, total, GetTickCount()-time);
	return 1;
}

public OnChannelInsert(playerid, channel)
{
	if (!IsPlayerLogged(playerid)) return 1;

    RadiosInfo[channel][radioOn] = 1;
	RadiosInfo[channel][radioID] = cache_insert_id();
	PlayerInfo[playerid][pOwnedChannel] = RadiosInfo[channel][radioID];
	return 1;
}


SetRadioChannel(playerid, channel)
{
	if (channel == 0) PlayerInfo[playerid][pAuthed] = 0;
	PlayerInfo[playerid][pChannel] = channel;

	return 1;
}

SetRadioSlot(playerid, slot)
{
	PlayerInfo[playerid][pSlot] = slot;
	return 1;
}

GetPlayerChannel(playerid)
{
	return PlayerInfo[playerid][pChannel];
}

GetPlayerSlot(playerid)
{
	return PlayerInfo[playerid][pSlot];
}

ChannelExists(channelid)
{
	switch(channelid)
	{
	    case 911, 999, 912, 998: return 1;
	}
	
	for(new i = 0; i != MAX_RADIOS; i++)
	{
		if (RadiosInfo[i][radioOn] != 0 && RadiosInfo[i][radioChannel] == channelid) return 1;
	}
	return 0;
}

GetChannelID(mysql_id)
{
	for(new i = 0; i != MAX_RADIOS; i++)
	{
		if (RadiosInfo[i][radioOn] && RadiosInfo[i][radioID] == mysql_id) return i;
	}
	return -1;
}

SendRadioMessage(channel, color, string[])
{
	foreach(new i : Player)
	{
	    if (!IsPlayerLogged(i) || !PlayerInfo[i][pAuthed] || PlayerInfo[i][pChannel] != channel) continue;

        SCM(i, color, string);
	}
	return 1;
}

SendSlotRadioMessage(channel, slot, color, string[])
{
	foreach(new i : Player)
	{
	    if (!IsPlayerLogged(i) || PlayerInfo[i][pAuthed] != 1 || PlayerInfo[i][pChannel] != channel || PlayerInfo[i][pSlot] != slot) continue;

        SCM(i, color, string);
	}
	return 1;
}

AddChannelToFile(playerid, channelid, pass[], id)
{
    new query[128 + 128];
	mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `radios` (channelid, owner, pass) VALUES (%i, %i, '%e')", channelid, PlayerInfo[playerid][pID], pass);
	mysql_tquery(dbHandle, query, "OnChannelInsert", "ii", playerid, id);
	return 1;
}