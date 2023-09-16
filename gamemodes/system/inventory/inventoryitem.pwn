#define MAX_ITEMTINER   (100)

enum itemTimerInfo{
    Id,
    ItemId,
    Quantity,
    Timer,
    PlayerId,
    bool:Exists
}

new ItemTimerData[MAX_PLAYERS][MAX_ITEMTINER][itemTimerInfo];
new Timer:myItemTimer[MAX_PLAYERS] = {Timer:-1, ...};
forward OnLoadItemTimer(playerid);

hook OnPlayerDisconnect(playerid, reason)
{
    stop myItemTimer[playerid];
    myItemTimer[playerid] = Timer:-1;
    return 1;
}

stock ITEMTIMER_LOAD(playerid)
{
    for(new i; i < MAX_ITEMTINER; i++)  ItemTimerData[playerid][i][Exists] = false, ItemTimerData[playerid][i][Id] = -1;
    new str[128],
        PlayerSQLId = GetPlayerSQLId(playerid);
	printf("[LOAD ITEMTIMER] Loading data from database...");
    format(str, sizeof(str), "SELECT * FROM itemtimer WHERE PlayerID = %d", PlayerSQLId);
	mysql_function_query(MainPipeline, str, true, "OnLoadItemTimer", "i", playerid);
}

public OnLoadItemTimer(playerid)
{
	new i, rows, fields, tmp[128];
	cache_get_data(rows, fields, MainPipeline);
	while(i < rows)
	{
        ItemTimerData[playerid][i][Exists] = true;
		cache_get_field_content(i, "Id", tmp, MainPipeline); ItemTimerData[playerid][i][Id] = strval(tmp);
        cache_get_field_content(i, "ItemId", tmp, MainPipeline); ItemTimerData[playerid][i][ItemId] = strval(tmp);
		cache_get_field_content(i, "Timer", tmp, MainPipeline); ItemTimerData[playerid][i][Timer] = strval(tmp);
        cache_get_field_content(i, "Quantity", tmp, MainPipeline); ItemTimerData[playerid][i][Quantity] = strval(tmp);
        printf("timer %d", gettime());
        if(ItemTimerData[playerid][i][Timer] < gettime()) ITEMTIMER_DELETE(playerid, i);
  		i++;
 	}
	if(i > 0) printf("[LOAD ITEMTIMER] %d du lieu item realtime cua %s da duoc tai.", i, GetPlayerNameEx(playerid));
    myItemTimer[playerid] = repeat ItemTimer(playerid);
}

stock ITEMTIMER_ADD(playerid, itemId, quantity, timer)
{
	new string[2048], index = ItemTimer_GetFreeID(playerid);
    if(index == -1) return SendClientMessageEx(playerid, COLOR_RED, "Item gioi han thoi cua ban da het slot luu tru");
    ItemTimerData[playerid][index][ItemId] = itemId,
    ItemTimerData[playerid][index][Quantity] = quantity,
    ItemTimerData[playerid][index][Timer] = gettime() + (timer * 60);
    format(string, sizeof(string), "INSERT INTO `itemtimer` (\
		`ItemId`, \
		`Timer`, \
        `Quantity`, \
		`PlayerId`)\
		VALUES ('%d', '%d', '%d', '%d')", 
		itemId,
		ItemTimerData[playerid][index][Timer],
        quantity,
		GetPlayerSQLId(playerid)
	);
	mysql_function_query(MainPipeline, string, false, "OnItemTimerAdd", "ii", playerid, index);
	return 1;
}

forward OnItemTimerAdd(playerid, index);
public OnItemTimerAdd(playerid, index)
{
    ItemTimerData[playerid][index][Exists] = true;
    ItemTimerData[playerid][index][Id] = mysql_insert_id(MainPipeline);
}

stock ITEMTIMER_DELETE(playerid, index)
{
    if(ItemTimerData[playerid][index][Id] == -1) return 0;
    new
        string[64];
    format(string, sizeof(string), "DELETE FROM `itemtimer` WHERE `Id`= '%d'", ItemTimerData[playerid][index][Id]);
    mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
    ItemTimerData[playerid][index][Id] = 0;
    ItemTimerData[playerid][index][Exists] = false;
    Inventory_SendRemoveTimer(playerid, ItemTimerData[playerid][index][ItemId], ItemTimerData[playerid][index][Quantity]);
	return 1;
}

stock ItemTimer_GetFreeID(playerid)
{
	for(new i; i < MAX_ITEMTINER; i++)
	{
		if(!ItemTimerData[playerid][i][Exists])
			return i;
	}
	return -1;
}

timer ItemTimer[1000](playerid)
{
    if(IsPlayerConnected(playerid))
    {
        for(new i; i < MAX_ITEMTINER; i++)
            if(ItemTimerData[playerid][i][Exists] && ItemTimerData[playerid][i][Timer] < gettime()) 
                ITEMTIMER_DELETE(playerid, i);
    }
}

/*
CREATE TABLE itemtimer (
    Id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PlayerId INT(6) NOT NULL,
    ItemId INT(6) NOT NULL,
    Timer INT(6) NOT NULL,
    Quantity INT(6) NOT NULL
);
*/