#include <a_samp>
#include <YSI\y_hooks>

#include "system/inventory/variables_inventory.pwn"
#include "system/inventory/function_inventory.pwn"
#include "system/inventory/textdraws_inventory.pwn"
#include "system/inventory/faction_command.pwn"
#include "system/inventory/iteminfoot.pwn"


new PlayerText:Select_Inventory[MAX_PLAYERS][5];
new PlayerText:Inventory_Main[MAX_PLAYERS][4];
new PlayerText:Inventory_Slot[MAX_PLAYERS][70];
new PlayerText:Inventory_Amount[MAX_PLAYERS][70];


stock ShowSelection_InventoryItem(playerid,slot) {
    new string[129];
    format(string, sizeof string, "%s", GetInventoryItemName(InventoryInfo[playerid][pSlot][slot]));
    PlayerTextDrawSetString(playerid, invslot_main[playerid][3], string);
    format(string, sizeof string, "%d", InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][slot]]);
    PlayerTextDrawSetString(playerid, invslot_main[playerid][4], string);
    PlayerTextDrawShow(playerid, invslot_main[playerid][1]);
    PlayerTextDrawShow(playerid, invslot_main[playerid][2]);
    PlayerTextDrawShow(playerid, invslot_main[playerid][3]);
    PlayerTextDrawShow(playerid, invslot_main[playerid][4]);
    PlayerTextDrawShow(playerid, invslot_main[playerid][5]);
    PlayerTextDrawShow(playerid, invslot_main[playerid][6]);
    SetPVarInt(playerid, "Openinventory", 2);
    SetPVarInt(playerid, "SelectSlot", slot);
    for(new i = 0 ; i < 20 ; i ++) {
        if(InventoryInfo[playerid][pSlot][i] != 0) {
            PlayerTextDrawHide(playerid, invslot_amount[playerid][i]);
        }
    }
    return 1;
}

stock HideInventory(playerid) {
    for(new i = 0 ; i < 60 ; i ++) {
        PlayerTextDrawHide(playerid, Inventory_Slot[playerid][i]);
        PlayerTextDrawHide(playerid, Inventory_Amount[playerid][i]);
        CancelSelectTextDraw(playerid);
    }
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][0]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][1]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][2]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][3]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][4]);
    PlayerTextDrawHide(playerid, Inventory_Main[playerid][0]);
    DeletePVar(playerid,"OpenInventory");
    DeletePVar(playerid,"ClickSlot");
    DeletePVar(playerid,"IsClick");
    return 1;
}
stock Inventory_use(playerid,slot,itemid) { 
    new string[129];
    switch(itemid) {
        case 1: SendServerMessage(playerid," Vat pham nay khong the su dung");
        case 2: {
            if(PlayerInfo[playerid][pKhatNuoc] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pKhatNuoc] += 30;
            PlayerInfo[playerid][pKhatNuoc] = PlayerInfo[playerid][pKhatNuoc] > 100 ? 100 : PlayerInfo[playerid][pKhatNuoc];
            format(string, sizeof(string), "* %s dang an uong mot ngum Nuoc Suoi.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);      
        }
        case 3: {
            if(PlayerInfo[playerid][pDoiBung] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pDoiBung] += 50;
            PlayerInfo[playerid][pDoiBung] = PlayerInfo[playerid][pDoiBung] > 100 ? 100 : PlayerInfo[playerid][pDoiBung];
            format(string, sizeof(string), "* %s dang an mot Pizza.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        }
        case 4: {
            if(PlayerInfo[playerid][pDoiBung] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pDoiBung] += 40;
            PlayerInfo[playerid][pDoiBung] = PlayerInfo[playerid][pDoiBung] > 100 ? 100 : PlayerInfo[playerid][pDoiBung];
            format(string, sizeof(string), "* %s dang an mot Banh mi.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
        }
        case 5: {
            if(GetPlayerWeaponDataCx(playerid,5)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,5,60000);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);

        }
        case 6: {
            if(GetPlayerWeaponDataCx(playerid,22)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,22,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 7: {
            if(GetPlayerWeaponDataCx(playerid,25)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,25,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 8: {
            if(GetPlayerWeaponDataCx(playerid,23)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,23,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 9: {
            if(GetPlayerWeaponDataCx(playerid,29)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,29,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 10: {
            if(GetPlayerWeaponDataCx(playerid,30)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,30,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 11: {
            if(GetPlayerWeaponDataCx(playerid,31)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,31,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 12: {
            if(GetPlayerWeaponDataCx(playerid,34)) return SendErrorMessage(playerid, " Tren nguoi ban da co vu khi nay.");
            GivePlayerValidWeapon(playerid,34,1);
            DropItem(playerid,slot,itemid,1);
            SetPlayerWeapons(playerid);
        }
        case 13: {
            if(GetPlayerWeaponDataCx(playerid,22)) {
                DropItem(playerid,slot,itemid,1);
             //   RemovePlayerWeapon(playerid, 22);
             //   GivePlayerValidWeapon(playerid, 22, 3);
                GivePlayerAmmoEx(playerid, 22, 7);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }   
            if(GetPlayerWeaponDataCx(playerid,23)) {
                DropItem(playerid,slot,itemid,1);
             //   RemovePlayerWeapon(playerid, 23);
             //   GivePlayerValidWeapon(playerid, 23, 3);
                GivePlayerAmmoEx(playerid, 23, 7);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }    
            if(GetPlayerWeaponDataCx(playerid,24)) {
                DropItem(playerid,slot,itemid,1);
             //   RemovePlayerWeapon(playerid, 24);
             //   GivePlayerValidWeapon(playerid, 24, 3);
                GivePlayerAmmoEx(playerid, 24, 7);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }          
            else {
                SendErrorMessage(playerid,"Ban phai cam sung luc tren tay.");
            }
        }
        case 14: {
            if(GetPlayerWeaponDataCx(playerid,29)) {
                DropItem(playerid,slot,itemid,1);
           //     RemovePlayerWeapon(playerid, 29);
            //    GivePlayerValidWeapon(playerid, 29, 3);
                GivePlayerAmmoEx(playerid, 29, 30);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }         
            else {
                SendErrorMessage(playerid,"Ban phai cam sung luc tren tay.");
            }
        }
        case 15: {
            if(GetPlayerWeaponDataCx(playerid,30)) {
                DropItem(playerid,slot,itemid,1);
           //     RemovePlayerWeapon(playerid, 30);
           //     GivePlayerValidWeapon(playerid, 30, 3);
                GivePlayerAmmoEx(playerid, 30, 30);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }  
            if(GetPlayerWeaponDataCx(playerid,31)) {
                DropItem(playerid,slot,itemid,1);
           //     RemovePlayerWeapon(playerid, 31);
           //     GivePlayerValidWeapon(playerid, 31, 3);
                GivePlayerAmmoEx(playerid, 31, 30);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }           
            else {
                SendErrorMessage(playerid,"Ban phai cam sung luc tren tay.");
            }
        }
        case 16: {
            if(GetPlayerWeaponDataCx(playerid,25)) {
                DropItem(playerid,slot,itemid,1);
              //  RemovePlayerWeapon(playerid, 25);
            //    GivePlayerValidWeapon(playerid, 25, 3);
                GivePlayerAmmoEx(playerid, 25, 30);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }         
            else {
                SendErrorMessage(playerid,"Ban phai cam sung luc tren tay.");
            }
        }
        case 17: {
            if(GetPlayerWeaponDataCx(playerid,34) ) {
                DropItem(playerid,slot,itemid,1);
              //  RemovePlayerWeapon(playerid, 34);
               // GivePlayerValidWeapon(playerid, 34, 3);
                GivePlayerAmmoEx(playerid, 34, 7);
                cmd_ame(playerid,"dang gan bang dan vao khau sung");
                ApplyAnimation(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
                SetPlayerArmedWeapon(playerid, GetPlayerWeapon(playerid) );
                SendClientTextDraw(playerid, "Dang thay dan...");
                return 1;
            }         
            else {
                SendErrorMessage(playerid,"Ban phai cam sung luc tren tay.");
            }
        }
        case 18: {
            if(PlayerInfo[playerid][pDoiBung] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pKhatNuoc] += 55;
            PlayerInfo[playerid][pKhatNuoc] = PlayerInfo[playerid][pKhatNuoc] > 100 ? 100 : PlayerInfo[playerid][pKhatNuoc];
            format(string, sizeof(string), "* %s dang uong mot ngum Sting.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);      
        }
        case 19: {
            if(PlayerInfo[playerid][pKhatNuoc] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pKhatNuoc] += 50;
            PlayerInfo[playerid][pKhatNuoc] = PlayerInfo[playerid][pKhatNuoc] > 100 ? 100 : PlayerInfo[playerid][pKhatNuoc];
            format(string, sizeof(string), "* %s dang uong mot ngum 7UP.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);      
        }
        case 20: {
            if(PlayerInfo[playerid][pKhatNuoc] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pKhatNuoc] += 50;
            PlayerInfo[playerid][pKhatNuoc] = PlayerInfo[playerid][pKhatNuoc] > 100 ? 100 : PlayerInfo[playerid][pKhatNuoc];
            format(string, sizeof(string), "* %s dang uong mot ngum Cocacla.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);      
        }
        case 21: {
            if(PlayerInfo[playerid][pDoiBung] >= 90) return SendErrorMessage(playerid," Ban khong the an them luc nay");
            PlayerInfo[playerid][pDoiBung] += 55;
            PlayerInfo[playerid][pDoiBung] = PlayerInfo[playerid][pDoiBung] > 100 ? 100 : PlayerInfo[playerid][pDoiBung];
            format(string, sizeof(string), "* %s dang an mot cai banh Hambuger.", GetPlayerNameEx(playerid));
            ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            DropItem(playerid,slot,itemid,1);
            if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);      
        }
        case 22: {
            cmd_gps(playerid,"");
        }
    }
    HideInventory(playerid);
    return 1;
}
stock DropItem(playerid,slot,itemid,amount) { 
    if(InventoryInfo[playerid][pSoLuong][itemid] - amount >= 1) 
    {
        InventoryInfo[playerid][pSoLuong][itemid] -= amount; 
        if(GetPVarInt(playerid, "OpenInventory") != 0) 
        {
            new string[129];
            format(string,sizeof string, "%d",InventoryInfo[playerid][pSoLuong][itemid]);
            PlayerTextDrawSetString(playerid, Inventory_Amount[playerid][slot], string);
            PlayerTextDrawShow(playerid, Inventory_Amount[playerid][slot]);
        }
    }
    else if(InventoryInfo[playerid][pSoLuong][itemid] - amount <= 0) 
    { 
        InventoryInfo[playerid][pSoLuong][itemid] = 0;
        InventoryInfo[playerid][pSlot][slot] = 0; 
        if(GetPVarInt(playerid, "Openinventory") != 0) {
            new string[129];
            format(string, sizeof string, "mdl-2020:%s",GetInventoryItemString(InventoryInfo[playerid][pSlot][slot]));
            PlayerTextDrawSetString(playerid, Inventory_Slot[playerid][slot], string);
            PlayerTextDrawShow(playerid,  Inventory_Slot[playerid][slot]);
            PlayerTextDrawHide(playerid,  Inventory_Amount[playerid][slot]);
        }

    }
    return 1;
}
stock Inventory_drop(playerid,slot,itemid) { 
    switch(itemid) {
        case 1: SendServerMessage(playerid," Vat pham nay chua the vut");
    }
    return 1;
}
stock AddItemInventory(playerid,itemid,soluong) 
{
	if(InventoryInfo[playerid][pSoLuong][itemid] >= 1) {
		InventoryInfo[playerid][pSoLuong][itemid] += soluong;
		/*if(GetPVarInt(playerid, "Openinventory") == 1) {

		}*/
		return 1;
	}
	else if(InventoryInfo[playerid][pSoLuong][itemid] <= 0) {
        if(!check_PlayerInvSlot(playerid)) return  SendErrorMessage(playerid," Tui do da day khong the, them vat pham moi");
		new slotadd = -1;
		for(new i = 0 ; i < 20 ; i++ ) {
			if(InventoryInfo[playerid][pSlot][i] == 0) {       
                slotadd = i;
                break ;
			}
		}
		InventoryInfo[playerid][pSlot][slotadd] = itemid;
		InventoryInfo[playerid][pSoLuong][itemid] = soluong;
	}
	return 1;
}

CMD:additem(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 2)
    {
        new giveplayerid, item, amount;
        if(sscanf(params, "udd", giveplayerid, item, amount)) return SendUsageMessage(playerid, " /additem [player] [id vat pham] [so luong]");
        // SendErrorMessage(playerid," Tui do cua nguoi do da day.");
        AddItemInventory(giveplayerid, item, amount);

    }
    return 1;
}

CMD:invz(playerid,params[]) return ShowInventoryForPlayer(playerid);
CMD:addtien(playerid,params[]) return  AddItemInventory(playerid,1,1000);

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
    {

        if(newkeys == KEY_YES)
        { 
    
            for(new i = 0; i < MAX_OBJECTS; i++) {
                if(ItemInfo[i][ObjectItemSet] == true) {
                    if(ItemInfo[i][WorldID] != GetPlayerVirtualWorld(playerid) || ItemInfo[i][Interior] != GetPlayerInterior(playerid)) return 1;
                    if(IsPlayerInRangeOfPoint(playerid,  1.5, ItemInfo[i][jtemPos][0] , ItemInfo[i][jtemPos][1] , ItemInfo[i][jtemPos][2])) {
    
                        DestroyDynamicObject(ItemInfo[i][ObjectID]);
                        DestroyDynamic3DTextLabel(ItemInfo[i][ItemTextID]);
                        ItemInfo[i][ObjectItemSet] = false;
                        ItemInfo[i][jtemPos][0] = 0 , ItemInfo[i][jtemPos][1] = 0 , ItemInfo[i][jtemPos][2] = 0;
                        AddItemInventory(playerid,ItemInfo[i][ItemID],1);
                        ItemInfo[i][ItemID] = 0;
                        break ;
                    }
                }
            }
        }
    }
    return 1;
}
hook OnPlayerConnect(playerid) {
    CreateInv(playerid);
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    new string[129];
  /*
    if(dialogid == DIALOG_INVENTORYCAR) {
        if(response) {
        ///    if(InventoryInfo[playerid][pSlot][GetItemIDFromName(inputtext)] == 0) return SendErrorMessage(playerid, " Vat pham khong ton tai o slot balo nay.");
            new veh = GetPVarInt(playerid,"catvaovehicle");
            new listitemz = InvCar_GetItemSlotFromID(playerid,veh,GetItemIDFromName(inputtext));
            SetPVarInt(playerid, "TakeItemID", GetItemIDFromName(inputtext));
            format(string, sizeof string, "Vui long nhap so luong ban muon lay\nVat pham: %s\nSo luong hien co: %d\nSlot vat pham: %d", GetInventoryItemName(VehicleInventory[playerid][veh][pSlot][listitemz]),VehicleInventory[playerid][veh][pSoLuong][VehicleInventory[playerid][veh][pSlot][listitemz]],listitemz);
            ShowPlayerDialog(playerid, DIALOG_TAKEAMOUNT, DIALOG_STYLE_INPUT, "Nhap so luong", string, "Tiep tuc", "Thoat");
       
        }
        else {
            DeletePVar(playerid, "catvaovehicle");
        }
    }*/
    if(dialogid == DROP_PLAYERINV) {
        if(response) {
            CreateItemInFoot(playerid,InventoryInfo[playerid][pSlot][GetPVarInt(playerid,"ClickSlot")]);
            DropItem(playerid,GetPVarInt(playerid,"ClickSlot"),InventoryInfo[playerid][pSlot][GetPVarInt(playerid,"ClickSlot")],1);
            SetPVarInt(playerid, "OpenInventory", 1);  
            DeletePVar(playerid, "LockClick"); 
        }
        else {
            SetPVarInt(playerid, "OpenInventory", 1);
            DeletePVar(playerid, "LockClick"); 
        }
    }  
    if(dialogid == DIALOG_TAKEAMOUNT) {
        if(response) {
            new veh = GetPVarInt(playerid,"catvaovehicle");
            new listitemz = InvCar_GetItemSlotFromID(playerid,veh,GetPVarInt(playerid,"TakeItemID"));
            if(isnull(inputtext) && strlen(inputtext) > 20 && !IsNumeric(inputtext)) {
                format(string, sizeof string, "So ban nhap khong hop le!\nVui long nhap so luong ban muon lay\nVat pham: %s\nSo luong hien co: %d\nSlot vat pham: %d", GetInventoryItemName(VehicleInventory[playerid][veh][pSlot][listitemz]),VehicleInventory[playerid][veh][pSoLuong][VehicleInventory[playerid][veh][pSlot][listitemz]],listitemz);
                ShowPlayerDialog(playerid, DIALOG_TAKEAMOUNT, DIALOG_STYLE_INPUT, "Nhap so luong", string, "Tiep tuc", "Thoat");
                return 1;
            }
            if(VehicleInventory[playerid][veh][pSoLuong][GetPVarInt(playerid,"TakeItemID")] < strval(inputtext)) return SendErrorMessage(playerid, " So luong vuot qua so luong hien co trong cop xe.");
            CarInventory_TakeUse(playerid,GetPVarInt(playerid,"catvaovehicle"),listitemz,VehicleInventory[playerid][veh][pSlot][listitemz],strval(inputtext));
            g_mysql_SaveVehicle(playerid, GetPVarInt(playerid,"catvaovehicle"));
            DeletePVar(playerid, "catvaovehicle");
            DeletePVar(playerid, "TakeItemID");

        }
        else {
            DeletePVar(playerid, "catvaovehicle");
            DeletePVar(playerid, "TakeItemID");
        }
    }
    if(dialogid == DIALOG_CATITEM) {
        if(response) {
        ///    if(InventoryInfo[playerid][pSlot][GetItemIDFromName(inputtext)] == 0) return SendErrorMessage(playerid, " Vat pham khong ton tai o slot balo nay.");
            new listitemz = GetItemSlotFromID(playerid,GetItemIDFromName(inputtext));
            SetPVarInt(playerid, "PutItemID", GetItemIDFromName(inputtext));
            format(string, sizeof string, "Vui long nhap so luong ban muon cat\nVat pham: %s\nSo luong hien co: %d\nSlot vat pham: %d", GetInventoryItemName(InventoryInfo[playerid][pSlot][listitemz]),InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][listitemz]],listitemz);
            ShowPlayerDialog(playerid, DIALOG_CATAMOUNT, DIALOG_STYLE_INPUT, "Nhap so luong", string, "Tiep tuc", "Thoat");
       
        }
        else {
            DeletePVar(playerid, "catvaovehicle");
        }
    }
    if(dialogid == DIALOG_CATAMOUNT) {
        if(response) {
            new listitemz = GetItemSlotFromID(playerid,GetPVarInt(playerid,"PutItemID"));
            if(isnull(inputtext) && strlen(inputtext) > 20 && !IsNumeric(inputtext)) {
                format(string, sizeof string, "So ban nhap khong hop le!\nVui long nhap so luong ban muon cat\nVat pham: %s\nSo luong hien co: %d\nSlot vat pham: %d", GetInventoryItemName(InventoryInfo[playerid][pSlot][listitemz]),InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][listitemz]],listitemz);
                ShowPlayerDialog(playerid, DIALOG_CATAMOUNT, DIALOG_STYLE_INPUT, "Nhap so luong", string, "Tiep tuc", "Thoat");
                return 1;
            }
            if(InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][listitemz]] < strval(inputtext)) return SendErrorMessage(playerid, " Ban khong du so luong de cat vao.");
            AddItemCarInventory(playerid,GetPVarInt(playerid,"catvaovehicle"), InventoryInfo[playerid][pSlot][listitemz],strval(inputtext));
            DropItem(playerid,listitemz, InventoryInfo[playerid][pSlot][listitemz],strval(inputtext));

            if( InventoryInfo[playerid][pSlot][listitemz] == 1) {
                PlayerInfo[playerid][pCash] -= strval(inputtext);
            }
            g_mysql_SaveVehicle(playerid, GetPVarInt(playerid,"catvaovehicle"));
            DeletePVar(playerid, "catvaovehicle");
            DeletePVar(playerid, "PutItemID");

        }
        else {
            DeletePVar(playerid, "catvaovehicle");
            DeletePVar(playerid, "PutItemID");
        }
    }
       
    return 1;
        
}
stock DestroySelect(playerid) {
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][0]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][4]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][1]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][2]);
    PlayerTextDrawHide(playerid, Select_Inventory[playerid][3]);
    return 1;
}

stock CreateSelectSlot(playerid,i,_doc=0,_ngang=0) {
    PlayerTextDrawDestroy(playerid, Select_Inventory[playerid][0]);
    PlayerTextDrawDestroy(playerid, Select_Inventory[playerid][4]);
    PlayerTextDrawDestroy(playerid, Select_Inventory[playerid][1]);
    PlayerTextDrawDestroy(playerid, Select_Inventory[playerid][2]);
    PlayerTextDrawDestroy(playerid, Select_Inventory[playerid][3]);
   // DestroySelect(playerid);

    new Float:x,Float:y,Float:tdx,Float:tdy;
    _ngang = i % 10;
    _doc = i / 10;
    
    tdy = 111.483299 + (37.900017 * _doc);
    tdx = 155.186355 + (33.411591 * _ngang);

    x = tdx + 18.666855;
    y = tdy + 7.683365;

    Select_Inventory[playerid][0] = CreatePlayerTextDraw(playerid, x,y, "mdl-2020:sudung");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][0], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][0], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][0], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][0], false);
    x = tdx + 18.703933;
    y = tdy + 4.433372;
  
    Select_Inventory[playerid][4] = CreatePlayerTextDraw(playerid, x,y, "mdl-2020:mainselect");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][4], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][4], 33.000000, 42.000000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][4], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][4], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][4], 0);

    x = tdx + 18.666855;
    y = tdy + 7.683365;

    Select_Inventory[playerid][1] = CreatePlayerTextDraw(playerid, x,y, "mdl-2020:sudung");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][1], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][1], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][1], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][1], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][1], true);
    
    x = tdx + 18.735352;
    y = tdy + 18.8498;
    Select_Inventory[playerid][2] = CreatePlayerTextDraw(playerid, x,y, "mdl-2020:vutbo");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][2], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][2], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][2], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][2], true);

    x = tdx + 18.666855;
    y = tdy + 30.533149;
    Select_Inventory[playerid][3] = CreatePlayerTextDraw(playerid, x,y, "mdl-2020:thongtin");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][3], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][3], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][3], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][3], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][3], true);
    

    return 1;
}
CMD:invne(playerid) {
    ShowInventoryForPlayer(playerid);
    return 1;
}


stock ShowPlayerInventoryDialog(playerid) {
    new string[329];
    string = "";
    new item;
    for(new i = 0 ; i < 30 ; i ++) {
        item = InventoryInfo[playerid][pSlot][i];
        if(InventoryInfo[playerid][pSlot][i] != 0) {

            format(string, sizeof string, "%s\n%s\t%d",string,GetInventoryItemName(item),InventoryInfo[playerid][pSoLuong][item]);
            printf("%d %s",i,GetInventoryItemName(InventoryInfo[playerid][pSlot][i] ));
        }
    }
   // printf("%s",string);
    ShowPlayerDialog(playerid, INVENTORY_MOBILE, DIALOG_STYLE_TABLIST, "Tui do", string, "Tuy chon", "Thoat");
}
stock ShowInventoryForPlayer(playerid) {
    new string[129];
    for(new i = 0 ; i < 60 ; i ++) {
        if(InventoryInfo[playerid][pSlot][i] != 0) {
            format(string, sizeof string, "%d", InventoryInfo[playerid][pSoLuong][InventoryInfo[playerid][pSlot][i]]);
            PlayerTextDrawSetString(playerid, Inventory_Amount[playerid][i], string);
            PlayerTextDrawShow(playerid, Inventory_Amount[playerid][i]);
        }
        format(string, sizeof string, "mdl-2020:%s", GetInventoryItemString(InventoryInfo[playerid][pSlot][i]));
        PlayerTextDrawSetString(playerid, Inventory_Slot[playerid][i], string);
        PlayerTextDrawShow(playerid, Inventory_Slot[playerid][i]);
    }
    
    PlayerTextDrawShow(playerid, Inventory_Main[playerid][0]);
    SelectTextDraw(playerid, 0xccdd74AA);
    SetPVarInt(playerid,"OpenInventory",1);
    return 1;
}

stock CreateInv(playerid) {

    Inventory_Main[playerid][0] = CreatePlayerTextDraw(playerid, 146.464141, 92.583297, "mdl-2020:main_inv");
    PlayerTextDrawLetterSize(playerid, Inventory_Main[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Inventory_Main[playerid][0], 350.000000, 251.000000);
    PlayerTextDrawAlignment(playerid, Inventory_Main[playerid][0], 1);
    PlayerTextDrawColor(playerid, Inventory_Main[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, Inventory_Main[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, Inventory_Main[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, Inventory_Main[playerid][0], 255);
    PlayerTextDrawFont(playerid, Inventory_Main[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, Inventory_Main[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, Inventory_Main[playerid][0], 0);

    new Float:Y,Float:X,Float:amountx,Float:amounty;

    for(new line=0;line<6;line++) {
        Y =  111.483299 + (37.900017 * line);
        for(new i=0;i<10;i++) {
            X = 155.186355 + ( 33.411591 * i );
          //  printf("CreatePlayerTextDraw(playerid,%f,%f) [%d]-i: %d- line: %d", X,Y,i*line,i,line);
            Inventory_Slot[playerid][i + ( line * 10 )] = CreatePlayerTextDraw(playerid, X, Y, "mdl-2020:slot");
            PlayerTextDrawLetterSize(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 0.000000, 0.000000);
            PlayerTextDrawTextSize(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 32.000000, 35.000000);
            PlayerTextDrawAlignment(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 1);
            PlayerTextDrawColor(playerid, Inventory_Slot[playerid][i + ( line * 10 )], -1);
            PlayerTextDrawSetShadow(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawSetOutline(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawBackgroundColor(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 255);
            PlayerTextDrawFont(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 4);
            PlayerTextDrawSetProportional(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawSetShadow(playerid, Inventory_Slot[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawSetSelectable(playerid, Inventory_Slot[playerid][i + ( line * 10 )], true);
            
            amountx = X + 26.626221;
            amounty = Y + 23.100044;

            Inventory_Amount[playerid][i + ( line * 10 )] = CreatePlayerTextDraw(playerid, amountx, amounty, "1");
            PlayerTextDrawLetterSize(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 0.153086, 1.016665);
            PlayerTextDrawAlignment(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 3);
            PlayerTextDrawColor(playerid, Inventory_Amount[playerid][i + ( line * 10 )], -1);
            PlayerTextDrawSetShadow(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawSetOutline(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 0);
            PlayerTextDrawBackgroundColor(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 255);
            PlayerTextDrawFont(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 1);
            PlayerTextDrawSetProportional(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 1);
            PlayerTextDrawSetShadow(playerid, Inventory_Amount[playerid][i + ( line * 10 )], 0);

        }
    }
    new Float:xz = 18.703933;
    new Float:yz = 4.433372;

    Select_Inventory[playerid][0] = CreatePlayerTextDraw(playerid, xz,yz, "mdl-2020:mainselect");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][0], 33.000000, 42.000000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][0], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][0], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][0], 0);

  
    Select_Inventory[playerid][4] = CreatePlayerTextDraw(playerid, xz,yz, "mdl-2020:mainselect");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][4], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][4], 33.000000, 42.000000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][4], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][4], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][4], 0);



    Select_Inventory[playerid][1] = CreatePlayerTextDraw(playerid, xz,yz, "mdl-2020:sudung");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][1], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][1], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][1], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][1], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][1], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][1], true);
    

    Select_Inventory[playerid][2] = CreatePlayerTextDraw(playerid, xz,yz, "mdl-2020:vutbo");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][2], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][2], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][2], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][2], true);

    Select_Inventory[playerid][3] = CreatePlayerTextDraw(playerid, xz,yz, "mdl-2020:thongtin");
    PlayerTextDrawLetterSize(playerid, Select_Inventory[playerid][3], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, Select_Inventory[playerid][3], 33.000000, 11.030000);
    PlayerTextDrawAlignment(playerid, Select_Inventory[playerid][3], 1);
    PlayerTextDrawColor(playerid, Select_Inventory[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, Select_Inventory[playerid][3], 255);
    PlayerTextDrawFont(playerid, Select_Inventory[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, Select_Inventory[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, Select_Inventory[playerid][3], true);
    CreateSelectSlot(playerid,2);
    return 1;
}