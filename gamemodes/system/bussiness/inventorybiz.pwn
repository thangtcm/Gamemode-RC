#include <YSI_Coding\y_hooks>
#include <a_samp>
#define MAX_INVENTORYBIZ_SLOT   5
#define MAX_RECIPES			    4

enum InventoryBiz{
    Id,
    ProductName[32],
    Quantity,
    OwnerBusiness,
    Exsits
}

new InventoryBizInfo[MAX_BUSINESSES][MAX_INVENTORYBIZ_SLOT][InventoryBiz];

forward OnLoadInvBiz();
forward OnInventoryBizAdd(businessid, index);
stock LoadInvBiz()
{
	for(new businessid; businessid < MAX_BUSINESSES; businessid++)
	{
		for(new i; i < MAX_INVENTORYBIZ_SLOT; i++)
		{
			InventoryBizInfo[businessid][i][Exsits] = false;
			InventoryBizInfo[businessid][i][Quantity] = 0;
		}
	}
	printf("[Load Inventory Biz] Loading data from database...");
	mysql_function_query(MainPipeline, "SELECT * FROM invbiz", true, "OnLoadInvBiz", "");
}

public OnLoadInvBiz()
{
    
	new i, rows, fields, tmp[128], businessid, index, oldbusinessid = -1;
	cache_get_data(rows, fields, MainPipeline);
	while(i < rows)
	{
		cache_get_field_content(i, "OwnerBusiness", tmp, MainPipeline); businessid = strval(tmp);
		if(businessid != oldbusinessid)
		{
			index = 0;
			oldbusinessid = businessid;
		}
		cache_get_field_content(i, "Id", tmp, MainPipeline); InventoryBizInfo[--businessid][index][Id] = strval(tmp);
		printf("businessid -- %d -- index %d", businessid, index);
		cache_get_field_content(i, "Quantity", tmp, MainPipeline); InventoryBizInfo[businessid][index][Quantity] = strval(tmp);
		cache_get_field_content(i, "ProductName", InventoryBizInfo[businessid][index][ProductName], MainPipeline, 32);
        InventoryBizInfo[businessid][index][Exsits] = true;
  		i++;
		index++;
 	}
	if(i > 0) printf("[Load Inventory Biz] %d du lieu kho cua hang %s da duoc tai.", i, Businesses[businessid][bName]);
}

stock InvBusiness_Recipes(businessid, productName[])
{
	if(!strcmp(productName, "Hamburger", true))
	{
		if(InvBusiness_Count(businessid, "Bot Mi") < 2 || InvBusiness_Count(businessid, "Thit") < 1)
			return false;
		INVBUSINESS_ADD(businessid, "Bot Mi", -2);
		INVBUSINESS_ADD(businessid, "Thit", -1);
		return true;
	}
	else if(!strcmp(productName, "Pizza", true))
	{
		if(InvBusiness_Count(businessid, "Bot Mi") < 3 || InvBusiness_Count(businessid, "Thit") < 2)
			return false;
		INVBUSINESS_ADD(businessid, "Bot Mi", -3);
		INVBUSINESS_ADD(businessid, "Thit", -2);
		return true;
	}
	else if(!strcmp(productName, "Bread", true))
	{
		if(InvBusiness_Count(businessid, "Bot Mi") < 4)
			return false;
		INVBUSINESS_ADD(businessid, "Bot Mi", -4);
		return true;
	}
	else if(!strcmp(productName, "Juice", true))
	{
		if(InvBusiness_Count(businessid, "Trai Cay") < 2)
			return false;
		INVBUSINESS_ADD(businessid, "Trai Cay", -2);
		return true;
	}
    return 1;
}

stock InvBusiness_InvValid(businessid, productName[])
{
    for(new i; i < MAX_INVENTORYBIZ_SLOT;i++)
    {
        if(!strcmp(InventoryBizInfo[businessid][i][ProductName], productName) && !isnull(productName) && !isnull(InventoryBizInfo[businessid][i][ProductName])) 
		{
			return i;
		}
    }
    return -1;
}

stock InvBusiness_GetFreeID(businessid)
{
    for(new i; i < MAX_INVENTORYBIZ_SLOT;i++)
    {
        if(!InventoryBizInfo[businessid][i][Exsits]) 
			return i;
    }
    return -1;
}

stock InvBusiness_Count(businessid, item[])
{
	new count = 0;
	for(new i = 0; i < MAX_INVENTORYBIZ_SLOT; i++)
	{
		if(!InventoryBizInfo[businessid][i][Exsits])
			continue;
		if(!strcmp(InventoryBizInfo[businessid][i][ProductName], item)) 
			count += InventoryBizInfo[businessid][i][Quantity];
	}
	return count;
}

stock INVBUSINESS_ADD(businessid, productName[], quantity = 1)
{
	new
		index = InvBusiness_InvValid(businessid, productName),
		string[250];
	if(index == -1)
	{
		index = InvBusiness_GetFreeID(businessid);
		if(index != -1)
		{
			InventoryBizInfo[businessid][index][Quantity] = quantity;
			InventoryBizInfo[businessid][index][OwnerBusiness] = Businesses[businessid][bId];
			strcpy(InventoryBizInfo[businessid][index][ProductName], productName, 32);
            format(string, sizeof(string), "INSERT INTO `invbiz` (`ProductName`, `Quantity`, `OwnerBusiness`) VALUES('%s', '%d', '%d')", 
				 g_mysql_ReturnEscaped(productName, MainPipeline), quantity, Businesses[businessid][bId]);
			mysql_function_query(MainPipeline, string, false, "OnInventoryBizAdd", "ii", businessid, index);
			printf("[CREATE INVENTORY BIZ] %s (ID %d) da duoc them vao du lieu cua cua hang %s", productName, index, Businesses[businessid][bName]);
			return index;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `invbiz` SET `Quantity` = `Quantity` + %d WHERE `Id` = '%d'", quantity, InventoryBizInfo[businessid][index][Id]);
		mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		InventoryBizInfo[businessid][index][Quantity] += quantity;
		printf("[UPDATE INVENTORY BIZ] %s (ID %d) da duoc them %d so luong vao du lieu cua cua hang %s", productName, index, quantity, Businesses[businessid][bName]);
	}
	return 1;
}

stock INVBUSINESS_DELETE(businessid, index)
{
    if(InventoryBizInfo[businessid][index][Exsits])
	{
        new
            string[64];
        format(string, sizeof(string), "DELETE FROM `invbiz` WHERE `Id`= '%d'", InventoryBizInfo[businessid][index][Id]);
        mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "i", SENDDATA_THREAD);
		return 1;
    }
	return 0;
}

public OnInventoryBizAdd(businessid, index)
{
	InventoryBizInfo[businessid][index][Exsits] = true;
	InventoryBizInfo[businessid][index][Id] = mysql_insert_id(MainPipeline);
	return 1;
}


CMD:setinvbiz(playerid, params[])
{
	new
		businessid,
		productName[32],
		capacity;

	if(PlayerInfo[playerid][pAdmin] < 99999)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ban khong duoc phep su dung lenh nay.");

	if(sscanf(params, "dds[32]", businessid, capacity, productName))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/setinvbiz [businessid] [quantity] [productName] (\"Bot Mi\", \"Thit\", \"Trai Cay\")");

	if (!IsValidBusinessID(businessid))
	{
		SendErrorMessage(playerid, " Invalid business ID entered.");
		return 1;
	}
	INVBUSINESS_ADD(businessid, productName, capacity);
	new string[128];
	format(string, sizeof(string), "Ban da dua vat pham %s so luong %d vao cua hang %s.", productName, capacity, Businesses[businessid][bName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, string);
	return 1;
}


CMD:bgiveinventory(playerid, params[])
{
    new iBusiness = InBusiness(playerid);

   	if(iBusiness == INVALID_BUSINESS_ID || (Businesses[iBusiness][bType] != BUSINESS_TYPE_BAR && Businesses[iBusiness][bType] != BUSINESS_TYPE_CLUB && Businesses[iBusiness][bType] != BUSINESS_TYPE_RESTAURANT)) return SendErrorMessage(playerid, "Ban khong o trong cua hang nao!");
	else if(PlayerInfo[playerid][pBusinessRank] < 5 && Businesses[PlayerInfo[playerid][pBusiness]][bOwner] != GetPlayerSQLId(playerid)) {
	    return SendErrorMessage(playerid, " Ban khong phai la chu cua hang.");
	}
	new capacity, productName[32];
	if(sscanf(params, "ds[32]", capacity, productName))
		return SendClientMessageEx(playerid, COLOR_GRAD1, "/bgiveinventory [quantity] [productName](\"Bot Mi\", \"Thit\", \"Trai Cay\")");
	if(Inventory_Count(playerid, productName) < capacity)
		return SendErrorMessage(playerid, "Ban khong co du so luong vat pham nay de cung cap.");
	new pItemId = Inventory_GetItemID(playerid,productName);
		Inventory_Remove(playerid, pItemId, capacity);
	INVBUSINESS_ADD(iBusiness, productName, capacity);
	new string[128];
	format(string, sizeof(string), "Ban da dua vat pham %s voi so luong la %d vao cua hang cua minh (%s).", productName, capacity, Businesses[iBusiness][bName]);
	SendClientMessageEx(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:bizinventory(playerid, params[])
{
	new
		string[128],
		iBusiness = PlayerInfo[playerid][pBusiness];
	if(iBusiness != INVALID_BUSINESS_ID)
	{
		SendClientMessageEx(playerid, COLOR_GREEN, "|_________ Thong ke cua hang________|");
		format(string, sizeof(string), "So tien: %d / Cong suat: %d / Loai: %s", Businesses[iBusiness][bInventory], Businesses[iBusiness][bInventoryCapacity], GetInventoryType(iBusiness));
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		for(new i; i < MAX_INVENTORYBIZ_SLOT; i++)
		{
			if(InventoryBizInfo[iBusiness][i][Exsits])
			{
				format(string, sizeof(string), "(%d)\tSan pham %s: %d so luong", i+1, InventoryBizInfo[iBusiness][i][ProductName], InventoryBizInfo[iBusiness][i][Quantity]);
				SendClientMessageEx(playerid, COLOR_WHITE, string);
			}
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD2, " Ban khong So huu hoac lam viec trong cua hang.");
	return 1;
}
