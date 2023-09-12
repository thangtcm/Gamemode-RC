#include <a_samp>
#include <YSI\y_hooks>


stock AddItemCarInventory(playerid,veh,itemid,soluong) 
{
	if(VehicleInventory[playerid][veh][pSoLuong][itemid] >= 1) 
	{
		VehicleInventory[playerid][veh][pSoLuong][itemid] += soluong;		
		return 1;
	}
	else if(VehicleInventory[playerid][veh][pSoLuong][itemid] <= 0) 
	{
		new slotadd = -1;
		if(!check_CarInvSlot(playerid,veh)) return 1;
		for(new i = 0 ; i < 20 ; i++ ) {
			
			if(VehicleInventory[playerid][veh][pSlot][i] == 0) 
			{       
                slotadd = i;
                break ;
			}
		}
		VehicleInventory[playerid][veh][pSlot][slotadd] = itemid;
		VehicleInventory[playerid][veh][pSoLuong][itemid] = soluong;
	}
	return 1;
}
stock CarInventory_TakeUse(playerid,veh,slot,itemid,amount) { 
    AddItemInventory(playerid,itemid,amount);
    if( InventoryInfo[playerid][pSlot][slot] == 1) {
        PlayerInfo[playerid][pCash] += amount;
    }
    if(VehicleInventory[playerid][veh][pSoLuong][itemid] - amount >= 1) 
    {
        VehicleInventory[playerid][veh][pSoLuong][itemid] -= amount; 
        g_mysql_SaveVehicle(playerid, veh);
        return 1;
    }
    else if(VehicleInventory[playerid][veh][pSoLuong][itemid] - amount <= 0) 
    { 
        VehicleInventory[playerid][veh][pSoLuong][itemid] = 0;
        VehicleInventory[playerid][veh][pSlot][slot] = 0; 
        g_mysql_SaveVehicle(playerid, veh);
        return 1;
    }
    return 1;
}
CMD:addcaritem(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 2)
    {
        new giveplayerid, vehslot, item, amount;
        if(sscanf(params, "uddd", giveplayerid,vehslot, item, amount)) return SendUsageMessage(playerid, " /additem [player] [slot veh] [id vat pham] [so luong]");
        AddItemCarInventory(giveplayerid,vehslot, item, amount);
    }
    return 1;
}
CMD:test(playerid,params[]) {
	VehicleInventory[playerid][3][pSlot][0] = 2;
	VehicleInventory[playerid][3][pSoLuong][2] = 2;
	return 1;
}
CMD:copxe(playerid, params[])
{
    new  choice[32],inventorystr[900],vai[50] , check = 1 , veh;
    if(sscanf(params, "s[32]", choice))
    {
        SendUsageMessage(playerid, " /copxe [name]");
        SendSelectMessage(playerid, " bovao, xem");
        return 1;
    }
    if(strcmp(choice,"bovao",true) == 0)     {
        for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
        {
            if(PlayerVehicleInfo[playerid][d][pvSpawned] == 1) 
            {
                if(IsPlayerInRangeOfVehicle(playerid, PlayerVehicleInfo[playerid][d][pvId], 3)) {
                    veh = d;
                    check = 2; 
                    break;
                }
            }
        }
        if(check != 2) return SendErrorMessage(playerid, " Vui long dung gan xe cua ban de mo cop xe");
        for(new i = 0 ; i < 60 ; i++) {
            if(InventoryInfo[playerid][pSlot][i] != 0) {
                format(inventorystr, sizeof inventorystr, "%s%s\t%d\n", inventorystr,GetInventoryItemName(InventoryInfo[playerid][pSlot][i]),InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][i]] );           
            }           
        }
        format(vai, sizeof vai, "Cat vat pham vao xe %s", GetVehicleName(PlayerVehicleInfo[playerid][veh][pvId]));
        SetPVarInt(playerid,"catvaovehicle",veh);
        ShowPlayerDialog(playerid, DIALOG_CATITEM, DIALOG_STYLE_TABLIST, vai, inventorystr,"Cat", "Huy");
    }
    if(strcmp(choice,"xem",true) == 0)     {
        for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
        {
            if(PlayerVehicleInfo[playerid][d][pvSpawned] == 1) 
            {
                if(IsPlayerInRangeOfVehicle(playerid, PlayerVehicleInfo[playerid][d][pvId], 3)) {
                    veh = d;
                    check = 2; 
                    break;
                }
            }
        }
        if(check != 2) return SendErrorMessage(playerid, " Vui long dung gan xe cua ban de mo cop xe");
        for(new i = 0 ; i < 20 ; i++) {
            if(VehicleInventory[playerid][veh][pSlot][i] != 0) {
                format(inventorystr, sizeof inventorystr, "%s%s\t%d\n", inventorystr,GetInventoryItemName(VehicleInventory[playerid][veh][pSlot][i]),VehicleInventory[playerid][veh][pSoLuong][VehicleInventory[playerid][veh][pSlot][i]] );           
            }           
        }
        format(vai, sizeof vai, "Vat pham cua xe %s", GetVehicleName(PlayerVehicleInfo[playerid][veh][pvId]));
        SetPVarInt(playerid,"catvaovehicle",veh);
        if(isnull(inventorystr))
        { 
            ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, vai, "\\cKhong co gi trong cop xe", "Chon", "Thoat");
            return 1;
        }
        ShowPlayerDialog(playerid, DIALOG_INVENTORYCAR, DIALOG_STYLE_TABLIST, vai, inventorystr,"Cat", "Huy");
    }
    return 1;
}