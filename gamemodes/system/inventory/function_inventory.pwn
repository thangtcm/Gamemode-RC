stock GetItemSlotFromID(playerid,itemid) {
    new slot;
    for(new i = 0; i < 60 ; i++) {
        if(InventoryInfo[playerid][pSlot][i] == itemid) {
            slot = i;
            break ;
        }
    }
    return slot;
}
stock InvCar_GetItemSlotFromID(playerid,veh,itemid) {
    new slot;
    for(new i = 0; i < 20 ; i++) {
        if(VehicleInventory[playerid][veh][pSlot][i] == itemid) {
            slot = i;
            break ;
        }
    }
    return slot;
}
stock InvPlayer_GetItemSlotFromID(playerid,itemid) {
    new slot;
    for(new i = 0; i < 60 ; i++) {
        if(InventoryInfo[playerid][pSlot][i] == itemid) {
            slot = i;
            break ;
        }
    }
    return slot;
}

stock GetItemIDFromName(itemname[]) {
    new itemid;
    for(new i = 1; i<30;i++) {
        if (strcmp(GetInventoryItemName(i), itemname) == 0) // full meal
        {
            itemid = i;
            printf("itemid la %d",itemid);
            break ;
        }
    }
    return itemid;
}
stock GetInventoryItemString(itemid) {
    new itemname[32];
    switch(itemid)
    {
        case 0: itemname = "slot";
        case 2: itemname = "chainuoc";
        case 3: itemname = "pizza";
        case 4: itemname = "banhmi";
        case 5: itemname = "gaybc";
        case 6: itemname = "9mm";
        case 7: itemname = "shotgun";
        case 8: itemname = "sdpistol";
        case 9: itemname = "mp5";
        case 10: itemname = "ak47";
        case 11: itemname = "m4";
        case 12: itemname = "sniper";
        case 13: itemname = "dansungluc";
        case 14: itemname = "dansungtieulien";
        case 15: itemname = "dansungtruong";
        case 16: itemname = "dansungshotgun";
        case 17: itemname = "dansungngam";
        case 18: itemname = "sting";
        case 19: itemname = "7up";
        case 20: itemname = "coca";
        case 21: itemname = "hambuger";
        case 22: itemname = "gps";
        case 23: itemname = "cuoc";
        case 24: itemname = "sat";
        case 25: itemname = "dong";
        case 26: itemname = "bac";
        case 27: itemname = "vang";
    } 
    return itemname;
}
stock GetInventoryItemName(itemid) {
    new itemname[52];
    switch(itemid)
    {
        case 0: itemname = "Khong co vat pham";
        case 2: itemname = "Nuoc suoi Lavie";
        case 3: itemname = "Banh Pizza";
        case 4: itemname = "Banh mi khong";
        case 5: itemname = "Gay bong chay";
        case 6: itemname = "9mm";
        case 7: itemname = "Shotgun";
        case 8: itemname = "Sdpistol";
        case 9: itemname = "mp5";
        case 10: itemname = "AK-47";
        case 11: itemname = "M4";
        case 12: itemname = "Sniper";
        case 13: itemname = "Dan danh cho sung luc";
        case 14: itemname = "Dan sung tieu lien";
        case 15: itemname = "Dan sung truong";
        case 16: itemname = "Dan sung shotgun";
        case 17: itemname = "Dan sung ngam";
        case 18: itemname = "sting";
        case 19: itemname = "7up";
        case 20: itemname = "coca";
        case 21: itemname = "hambuger";
        case 22: itemname = "GPS";
        case 23: itemname = "Cay cuoc";
        case 24: itemname = "Quang Sat";
        case 25: itemname = "Quang Dong";
        case 26: itemname = "Quang Bac";
        case 27: itemname = "Quang Vang";
    } 
    return itemname;
}
stock GetInventoryItemInfo(itemid) {
    new itemname[332];
    switch(itemid)
    {
        case 1: itemname = "";
        case 2: itemname = "Nuoc suoi nguyen chat, uong vao se giup giai khat";
        case 3: itemname = "Banh Pizza, Banh pizza thom ngon day du dinh duong";
        case 4: itemname = "Banh mi khong, banh mi cung cap chat dam";
        case 5: itemname = "Gay bong chay dung de danh bong chay hoac lam vu khi tan cong nguoi khac";
        case 6: itemname = "9mm - Khau sung luc";
        case 7: itemname = "Shotgun - Sung ngan";
        case 8: itemname = "Sdpistol - Sung luc giam thanh";
        case 9: itemname = "MP5 Sung tieu lien";
        case 10: itemname = "AK47 Sung  tieu lien";
        case 11: itemname = "M4 Sung  tieu lien";
        case 12: itemname = "Sniper Sung ngam";
        case 13: itemname = "Dan danh cho sung luc, cac loai sung nhu: 9mm , Sdpistol , Deagle";
        case 14: itemname = "Dan sung tieu lien cac loai sung nhu : mp5, Tec , Uzi";
        case 15: itemname = "Dan sung truong cho cac loai sung nhu: M4, AK-47";
        case 16: itemname = "Dan sung shotgun danh cho cac loai sung: Shotgun, Spas-12";
        case 17: itemname = "Dan sung ngam danh cho Sniper";
        case 18: itemname = "Nuoc giai khat Sting vi dau";
        case 19: itemname = "Nuoc giai khat 7up vi chanh";
        case 20: itemname = "Nuoc giai khat cocacola";
        case 21: itemname = "Banh hambuger";
        case 22: itemname = "GPS , dung de xac dinh vi tri";
        case 23: itemname = "Cuoc , Dung de dao da";
        case 24: itemname = "Quang Sat, Quang sat nguyen chat";
        case 25: itemname = "Quang Dong , Quang dong nguyen chat";
        case 26: itemname = "Quang Bac , Quang bac nguyen chat";
        case 27: itemname = "Quang Vang , Quang vang nguyen chat";

    } 
    return itemname;
}
stock check_PlayerInvSlot(playerid) {
    new check = 1;
    for(new i = 0; i < 20; i++) {
        if(InventoryInfo[playerid][pSlot][i] == 0) {
            check = 2;
        }
    }
    if(check == 2) {
        return 1;
    }
    return 0;
}
stock check_CarInvSlot(playerid,vehslot) {
    new check = 1;
    for(new i = 0; i < 20; i++) {
        if(VehicleInventory[playerid][vehslot][pSlot][i] == 0) {
            check = 2;
        }
    }
    if(check == 2) {
        return 1;
    }
    return 0;
}