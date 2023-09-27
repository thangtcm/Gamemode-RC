#include <a_samp>
#include <YSI_Coding\y_hooks>
#define DIALOG_THUNGCA (13421)
#define  MAX_THUNGHANG 100  
new ThungCaAttach[MAX_PLAYERS];

enum ThungCas
{
    pThungCaID,
    pThungCaSet,
    pThungObject,
    pThungAttachVeh,
    pThungType,
    pSoCa,
    pSoKGCa,
}
new ThungCa[MAX_THUNGHANG][ThungCas];
// 


//
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid== DIALOG_CATCA)
    {
        if(response)
        {
            new i = GetPVarInt(playerid, "ThungCaID");
            new soluong;
            new tong , toida; 
            if(sscanf(inputtext, "d", soluong)) return ShowPlayerDialog(playerid, DIALOG_CATCA, DIALOG_STYLE_INPUT, "Cat ca", "Nhap so luong kg ca ban muon cat vao", "Xac nhan",  "Tu choi");
            tong = soluong + ThungCa[i][pSoKGCa];
            if(PlayerInfo[playerid][pKgCa] < soluong) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du so ca de cat vao`");
            switch(ThungCa[i][pThungType])
            {
                case 1:
                {
                    toida = 500;
                }
                case 2:
                {
                    toida = 1000;
                }
                case 3:
                {
                    toida = 2500;
                }
                case 4:
                {
                    toida = 5000;
                }
            }
            if(tong > toida) return SendClientMessage(playerid, COLOR_GREY, "Thung ca dat so luong toi da");
            PlayerInfo[playerid][pKgCa] -= soluong;                         
            ThungCa[i][pSoKGCa] += soluong;
            SendClientMessage(playerid, COLOR_WHITE, "Ban da cat ca vao thung");
            SaveThung_Fix();
        }
    }
    if(dialogid == DIALOG_MAINTHUNG)
    {
        if(response)
        {
            if(listitem == 0)
            {
                cmd_mothaibabuonnam(playerid, "");
                SaveThung_Fix();
            }
        }
    }
    if(dialogid == DIALOG_MUAMOI)
    {
        if(response)
        {
            new soluong;
            if(sscanf(inputtext, "d", soluong)) return ShowPlayerDialog(playerid, DIALOG_MUAMOI, DIALOG_STYLE_INPUT, "Mua moi cau", "So luong khong hop le\nHay nhap so luong ban muon mua", "Xac nhan",  "Tu choi");
            if(PlayerInfo[playerid][pCash] < soluong * 3) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du tien de mua");
            if(soluong < 1 || soluong > 10000) return ShowPlayerDialog(playerid, DIALOG_MUAMOI, DIALOG_STYLE_INPUT, "Mua moi cau", "So luong khong hop le\nHay nhap so luong ban muon mua", "Xac nhan" , "Tu choi");
            PlayerInfo[playerid][pCash] -= soluong * 3;
            PlayerInfo[playerid][pMoiCau] +=  soluong;
            new string[129];
            format(string, sizeof string, "Ban da mua ~g~%d~w~ moi cau voi so tien ~g~%d", soluong , soluong * 3);
            SendClientTextDraw(playerid, string);
        }
    }
    if(dialogid == DIALOG_MUADAY)
    {
        if(response)
        {
            new soluong;
            if(sscanf(inputtext, "d", soluong)) return ShowPlayerDialog(playerid, DIALOG_MUADAY, DIALOG_STYLE_INPUT, "Mua day cau", "Hay nhap so luong ban muon mua","Xac nhan" , "Tu choi");
            if(PlayerInfo[playerid][pCash] < soluong) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du tien de mua");
            if(soluong < 1 || soluong> 10000) return ShowPlayerDialog(playerid, DIALOG_MUADAY, DIALOG_STYLE_INPUT, "Mua day cau", "Hay nhap so luong ban muon mua","Xac nhan", "Tu choi");
            PlayerInfo[playerid][pCash] -= soluong;
            PlayerInfo[playerid][pDayCau] += soluong;
            new string[129];
            format(string, sizeof string, "Ban da mua ~g~%d~w~ day cau voi so tien ~g~%d", soluong , soluong);
            SendClientTextDraw(playerid, string);
        }
    }
    if(dialogid == DIALOG_MAINDANHCA)
    {
        if(response)
        {
            if(listitem == 0 ) {
                if(PlayerInfo[playerid][pGiayPhepCauCa] == 1) return SendClientMessage(playerid, COLOR_GREY, "Ban da co giay phep");
                if(PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co du 30000$ de mua giay phep");
                PlayerInfo[playerid][pGiayPhepCauCa] = 1;
                PlayerInfo[playerid][pCash] -= 30000;
                SendClientTextDraw(playerid,"Ban da mua giay phep voi gia ~g~30000$");
            }
            if(listitem == 1)
            {
                if(PlayerInfo[playerid][pCanCau] == 1) return SendClientMessage(playerid, COLOR_GREY, "Ban da co can cau");
                if(PlayerInfo[playerid][pCash] < 2500) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co du 2500$ de mua can cau"); 
                PlayerInfo[playerid][pCanCau] = 1;
                PlayerInfo[playerid][pCash] -= 2500;
                SendClientTextDraw(playerid,"Ban da mua can cau voi gia ~g~2500$");
            }
            if(listitem == 2)
            {
            /*  if(PlayerInfo[playerid][pCash] < 3) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co du 3$ de mua moi cau");   
                PlayerInfo[playerid][pMoiCau] += 1;
                PlayerInfo[playerid][pCash] -= 3;
                SendClientTextDraw(playerid,"Ban da mua moi cau voi gia ~g~3$");*/
                ShowPlayerDialog(playerid, DIALOG_MUAMOI, DIALOG_STYLE_INPUT, "Mua moi cau", "Hay nhap so luong ban muon mua", "Xac nhan","Tu choi");
            }
            if(listitem == 3)
            {
            /*  if(PlayerInfo[playerid][pCash] < 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co du 1$ de mua day cau");   
                PlayerInfo[playerid][pMoiCau] += 1;
                PlayerInfo[playerid][pCash] -= 1;
                SendClientTextDraw(playerid,"Ban da mua day cau voi gia ~g~1$");*/
                ShowPlayerDialog(playerid, DIALOG_MUADAY, DIALOG_STYLE_INPUT, "Mua day cau", "Hay nhap so luong ban muon mua","Xac nhan","Tu choi");
            }
            if(listitem == 4)
            {
                if(PlayerInfo[playerid][pCash] < 20000) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co du 5000$ de mua");
                if(PlayerInfo[playerid][pLuoiChai] != 0) return SendClientMessage(playerid, COLOR_GREY, "Ban da co luoi roi");
                PlayerInfo[playerid][pCash] -= 20000;
                PlayerInfo[playerid][pLuoiChai] = 1;
                SendClientTextDraw(playerid, "Ban da mua ~g~Luoi danh ca~w~ voi gia ~g~20,000$");
            }
            if(listitem == 5) 
            {
                if(PlayerInfo[playerid][pCash] < 2500) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du 2500$ de mua");
                if(PlayerInfo[playerid][pThungCa] != 0) return SendClientMessage(playerid, COLOR_GREY, "Ban da co thung ca roi");
                PlayerInfo[playerid][pCash] -= 2500;
                PlayerInfo[playerid][pThungCa] = 1;
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SendClientMessage(playerid, COLOR_GREY, "Ban da mua thung ca sieu nho voi gia 5000$");
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2040, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            //  ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
                SetPVarInt(playerid, "ThungCaObj", 1);
            }
            if(listitem == 6) 
            {
                if(PlayerInfo[playerid][pCash] < 5000) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du 5000$ de mua");
                if(PlayerInfo[playerid][pThungCa] != 0) return SendClientMessage(playerid, COLOR_GREY, "Ban da co thung ca roi");
                PlayerInfo[playerid][pCash] -= 5000;
                PlayerInfo[playerid][pThungCa] = 2;
                SendClientMessage(playerid, COLOR_GREY, "Ban da mua thung ca nho voi gia 5000$");
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2969, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPVarInt(playerid, "ThungCaObj", 1);
            }
            if(listitem == 7) 
            {
                if(PlayerInfo[playerid][pCash] < 7500) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du 7500$ de mua");
                if(PlayerInfo[playerid][pThungCa] != 0) return SendClientMessage(playerid, COLOR_GREY, "Ban da co thung ca roi");
                PlayerInfo[playerid][pCash] -= 7500;
                PlayerInfo[playerid][pThungCa] = 3;
                SendClientMessage(playerid, COLOR_GREY, "Ban da mua thung ca vua voi gia 7500$");
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 3800, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                        
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPVarInt(playerid, "ThungCaObj", 1);
            }
            if(listitem == 8) 
            {
                if(PlayerInfo[playerid][pCash] < 10000) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du 10000$ de mua");
                if(PlayerInfo[playerid][pThungCa] != 0) return SendClientMessage(playerid, COLOR_GREY, "Ban da co thung ca roi");
                PlayerInfo[playerid][pCash] -= 10000;
                PlayerInfo[playerid][pThungCa] = 4;
                SendClientMessage(playerid, COLOR_GREY, "Ban da mua thung ca to voi gia 10000$");
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1224, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPVarInt(playerid, "ThungCaObj", 1);
            }
            /*if(listitem == 4)
            {
                ShowPlayerDialog(playerid, DIALOG_BANCA, DIALOG_STYLE_INPUT, "Ban ca", "Nhap so luong ca ban muon ban", "Xac nhan", "Dong y");
            }*/
        }
    }
    return 1;
}

stock SaveThung_Fix()
{
    for(new i =0; i < MAX_THUNGHANG ; i++)
    {
        if(ThungCa[i][pThungCaSet] == 1)
        {
            new file[3000];
            format(file, sizeof(file), "thungca/%d.ini", i);
            if(!dini_Exists(file)) dini_Create(file);
            dini_IntSet(file, "pThungCaID", ThungCa[i][pThungCaID]);
            dini_IntSet(file, "pThungCaSet", ThungCa[i][pThungCaSet]); 
            dini_IntSet(file, "pThungType", ThungCa[i][pThungType]);
            dini_IntSet(file, "pSoCa", ThungCa[i][pSoCa]);
            dini_IntSet(file, "pSoKGCa", ThungCa[i][pSoKGCa]);
        }
    }
    return 1;
}
stock LoadThung_Fix()
{
    new file[3000];
    for(new i = 1 ; i < MAX_THUNGHANG ;i++) {
        format(file, sizeof(file), "thungca/%d.ini", i);    
        ThungCa[i][pThungCaID] = dini_Int(file, "pThungCaID");
        ThungCa[i][pThungCaSet] = dini_Int(file, "pThungCaSet"); 
        ThungCa[i][pThungType] = dini_Int(file, "pThungType");
        ThungCa[i][pSoCa] = dini_Int(file, "pSoCa"); 
        ThungCa[i][pSoKGCa] = dini_Int(file, "pSoKGCa");
    }
    return 1;
}

// loadmysql
/*    switch(PlayerInfo[playerid][pThungCa])
    {
        case 1: 
        {
        //  SetPlayerAttachedObject(playerid,SLOT_THUNG, 2969,17);
            SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2040, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
        case 2: 
        {
        //  SetPlayerAttachedObject(playerid,SLOT_THUNG, 2969,17);
            SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2969, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
        case 3:
        {
        //  SetPlayerAttachedObject(playerid,SLOT_THUNG, 3800,17);
            SetPlayerAttachedObject( playerid, PIZZA_INDEX, 3800, 1, 0.002953, 0.569660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
        case 4:
        {
        //    SetPlayerAttachedObject(playerid,SLOT_THUNG, 1224,17);
            SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1224, 1, 0.002953, 0.569660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        }
    }

    if(PlayerVehicleInfo[playerid][vehicleid][VehicleThungID] != 0)
    {
        DestroyObject(ThungCa[PlayerVehicleInfo[playerid][vehicleid][VehicleThungID]][pThungObject]);
    }*/

forward AttachThungCa(playerid , j);
public AttachThungCa(playerid , j)
{
    DestroyObject(ThungCa[PlayerVehicleInfo[playerid][j][VehicleThungID]][pThungObject]);
//  ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
    SendClientMessage(playerid, COLOR_GREY, "Ban khong the boi khi cam thung ca");

    return 1;
}
// key
/*
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    new Float:X,Float:Y,Float:Z;
    for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
    {
        if(PlayerVehicleInfo[playerid][veh][pvId] != INVALID_PLAYER_VEHICLE_ID) GetVehiclePos(PlayerVehicleInfo[playerid][veh][pvId], X, Y, Z);
        GetVehiclePos(d, X,Y,Z);
        if(IsPlayerInRangeOfPoint(playerid, 5, X,Y,Z))
        {
            if(GetVehicleModel(d) != 473 || GetVehicleModel(d) != 484 || GetVehicleModel(d) != 454) return 1;
            SendClientTextDraw(playerid, "Ban dang lay thung ca...");
            cmd_me(playerid, "da lay thung ca len"); // cai nay lay 
            SetTimerEx("AttachThungCa",2000, 0, "ud", playerid , d);
            ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In",0.0,0,0,0,1,1);
            ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In",0.0,0,0,0,1,1);
        }
        break;
    }   
    return 1;
}
*/

CMD:thongtinca(playerid, params[])
{
    new string[400] , ver[30];
    switch(PlayerInfo[playerid][pGiayPhepCauCa])
    {
        case 0:
        {
            ver = "Chua co giay phep";
        }
        case 1:
        {
            ver = "Da co giay phep";
        }
    }
    format(string, sizeof string, "Giay phep: %s\nSo Luong ca trong nguoi: %dKg\nCan cau: %d\nMoi cau: %d\nDay cau : %d\nWild King Salmon : %d\nYellowfin Tuna : %d\nSwordfish : %d\nPuffer Fish : %d\nBluefin Tuna : %d", ver ,PlayerInfo[playerid][pKgCa],
        PlayerInfo[playerid][pCanCau] ,PlayerInfo[playerid][pMoiCau] , PlayerInfo[playerid][pDayCau] , 
        PlayerInfo[playerid][pCaHiem][0],PlayerInfo[playerid][pCaHiem][1],PlayerInfo[playerid][pCaHiem][2],PlayerInfo[playerid][pCaHiem][3],PlayerInfo[playerid][pCaHiem][4] );
    ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "Thong tin", string, "Dong", "");
    return 1;
}
stock CaBinhThuong(playerid)
{
    new randaha = random(101);
    new randomkg , string[129];
    switch(randaha)
    {
        case 0..55:
        {
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(10);
                }
                case 9..12:
                {
                    randomkg = 1 + random(20);
                }
                case 13..15:
                {
                    randomkg = 1 + random(30);
                }
                case 16..18:
                {
                    randomkg = 1 + random(40);
                }
                case 19..20:
                {
                    randomkg = 1 + random(49);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg;
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 56..77:
        {    
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(50);
                }
                case 9..12:
                {
                    randomkg = 1 + random(70);
                }
                case 13..16:
                {
                    randomkg = 1 + random(80);
                }
                case 17..18:
                {
                    randomkg = 1 + random(85);
                }
                case 19..20:
                {
                    randomkg = 1 + random(99);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg ;
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 78..92:
        {  
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(100);
                }
                case 9..12:
                {
                    randomkg = 56 + random(55);
                }
                case 13..16:
                {
                    randomkg = 61 + random(60);
                }
                case 17..18:
                {
                    randomkg = 1 + random(140);
                }
                case 19..20:
                {
                    randomkg = 1 + random(149);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg; 
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 93..100:
        {  
            switch(random(20))
            {
                case 0..8:
                {
                    randomkg = 1 + random(150);
                }
                case 9..12:
                {
                    randomkg = 1 + random(160);
                }
                case 13..16:
                {
                    randomkg = 1 + random(170);
                }
                case 17..18:
                {
                    randomkg = 1 + random(180);
                }
                case 19..20:
                {
                    randomkg = 1 + random(199);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg; 
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_ame(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 101:
        {
            switch(random(10))
            {
                case 0..4:
                {
        //          new string[129];
                    randomkg = 1 + random(180);
                    PlayerInfo[playerid][pKgCa] += randomkg; 
                    format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
                    cmd_ame(playerid, string);
                    format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
                    SendClientMessage(playerid, COLOR_GREY, string);
                }
                case 5:
                {
                    PlayerInfo[playerid][pCaHiem][0] += 1; // Wild King Salmon
                    SendClientMessage(playerid, COLOR_YELLOWEX, "Chuc mung ban cau duoc con ca quy hiem Wild King Salmon");
                    cmd_me(playerid, "da cau duoc con ca quy hiem Wild King Salmon.");
                }
                case 6:
                {
                    PlayerInfo[playerid][pCaHiem][1] += 1; // Wild King Salmon
                    SendClientMessage(playerid, COLOR_YELLOWEX, "Chuc mung ban cau duoc con ca quy hiem Yellowfin Tuna");
                    cmd_me(playerid, "da cau duoc con ca quy hiem Yellowfin Tuna.");
                }
                case 7:
                {
                    PlayerInfo[playerid][pCaHiem][2] += 1; // Wild King Salmon
                    SendClientMessage(playerid, COLOR_YELLOWEX, "Chuc mung ban cau duoc con ca quy hiem Swordfish");
                    cmd_me(playerid, "da cau duoc con ca quy hiem Swordfish.");
                }
                case 8:
                {
                    PlayerInfo[playerid][pCaHiem][3] += 1; // Wild King Salmon
                    SendClientMessage(playerid, COLOR_YELLOWEX, "Chuc mung ban cau duoc con ca quy hiem Puffer Fish");
                    cmd_me(playerid, "da cau duoc con ca quy hiem Puffer Fish.");
                }
                case 9..10:
                {
                    PlayerInfo[playerid][pCaHiem][4] += 1; // Wild King Salmon
                    SendClientMessage(playerid, COLOR_YELLOWEX, "Chuc mung ban cau duoc con ca quy hiem Bluefin Tuna");
                    cmd_me(playerid, "da cau duoc con ca quy hiem PBluefin Tuna.");
                }
            }
        }
    }
}
stock CaBinhThuong_Hai(playerid)
{
    new randaha = random(101);
    new randomkg , string[129];
    switch(randaha)
    {
        case 0..55:
        {
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(10);
                }
                case 9..12:
                {
                    randomkg = 1 + random(20);
                }
                case 13..15:
                {
                    randomkg = 1 + random(30);
                }
                case 16..18:
                {
                    randomkg = 1 + random(40);
                }
                case 19..20:
                {
                    randomkg = 1 + random(49);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg;
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 56..77:
        {    
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(50);
                }
                case 9..12:
                {
                    randomkg = 1 + random(70);
                }
                case 13..16:
                {
                    randomkg = 1 + random(80);
                }
                case 17..18:
                {
                    randomkg = 1 + random(85);
                }
                case 19..20:
                {
                    randomkg = 1 + random(99);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg ;
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 78..92:
        {  
            switch(random(21))
            {
                case 0..8:
                {
                    randomkg = 1 + random(100);
                }
                case 9..12:
                {
                    randomkg = 56 + random(55);
                }
                case 13..16:
                {
                    randomkg = 61 + random(60);
                }
                case 17..18:
                {
                    randomkg = 1 + random(140);
                }
                case 19..20:
                {
                    randomkg = 1 + random(149);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg; 
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_me(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
        case 93..100:
        {  
            switch(random(20))
            {
                case 0..8:
                {
                    randomkg = 1 + random(150);
                }
                case 9..12:
                {
                    randomkg = 1 + random(160);
                }
                case 13..16:
                {
                    randomkg = 1 + random(170);
                }
                case 17..18:
                {
                    randomkg = 1 + random(180);
                }
                case 19..20:
                {
                    randomkg = 1 + random(199);
                }
            }
            PlayerInfo[playerid][pKgCa] += randomkg; 
            format(string, sizeof string, "da cau duoc con ca nang %dkg.", randomkg);
            cmd_ame(playerid, string);
            format(string, sizeof string, "Ban da cau duoc con ca nang %dkg", randomkg);
            SendClientMessage(playerid, COLOR_GREY, string);
        }
    }
}
forward CauCaNe(playerid);
public CauCaNe(playerid)
{
    PlayerInfo[playerid][pMoiCau] -= 1;
    PlayerInfo[playerid][pDayCau] -= 1;
    PlayerInfo[playerid][pConCa] += 1;
    ClearAnimations(playerid);
    RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
    TogglePlayerControllable(playerid, 1);
    DeletePVar(playerid, "DangCauCa");
    switch(random(100))
    {
        case 0..69:
        {
            CaBinhThuong(playerid);
        }
        case 70..99:
        {
            SendClientMessage(playerid, COLOR_GREY, "Ban cau duoc bao rac");
        }
        case 100:
        {
            CaBinhThuong_Hai(playerid);
        }
    }
    return 1;
}
forward AnimeJav(playerid);
public AnimeJav(playerid)
{
    ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0,1,1,0,0,0);
    return 1;
    // de coi no boi dc k
}
CMD:cauca(playerid, params[])
{
    if(PlayerInfo[playerid][pCanCau] != 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co can cau");
    if(PlayerInfo[playerid][pMoiCau] < 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co moi cau");
    if(PlayerInfo[playerid][pDayCau] < 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co day cau");
 //   if(!IsABoat(GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen");
    if(IsPlayerAttachedObjectSlotUsed(playerid,PIZZA_INDEX)) return SendClientMessage(playerid, COLOR_GREY, "Ban dang cam vat khac");
    if(PlayerInfo[playerid][pKgCa] >= 50) return SendClientMessage(playerid, COLOR_GREY, "Ban da dat toi da 50kg ca");
    if(gettime() < GetPVarInt(playerid, "TimeCauCa")) 
    {
        new szMessage[64];
        format(szMessage, sizeof(szMessage), "Ban phai cho %d giay moi co the tiep tuc cau ca", GetPVarInt(playerid, "TimeCauCa") - gettime());
        SendClientMessage(playerid, COLOR_GREY, szMessage);
        return 1;
    }
    SetPVarInt(playerid, "TimeCauCa", gettime()+12); 
    SetPVarInt(playerid, "DangCauCa", 1);
    ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0,1,1,0,0,0);
    SetTimerEx("AnimeJav", 1000, 0,"d", playerid);
    cmd_me(playerid, "dang cau ca tren thuyen.");
    SetPlayerAttachedObject( playerid, PIZZA_INDEX, 18632, 1, -0.091109, 0.255484, 0.018155, 94.362060, 312.328125, 190.418655, 1.000000, 1.000000, 1.000000 );
 //   TogglePlayerControllable(playerid, 0);
    SetTimerEx("CauCaNe", 12000, 0, "d", playerid);
    return 1;
}
CMD:ngudan(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 4, 2885.3867,-339.4484,2.2967)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o gan noi ban dung cu cau ca");
    ShowPlayerDialog(playerid, DIALOG_MAINDANHCA, DIALOG_STYLE_LIST, "Ngu dan", "Dang ky giay phep\tgia: 30000$\nMua can cau\tgia: 2500$\nMua moi cau\tgia: 3$\nMua day cau\tgia: 1$\nMua luoi\t20000$\nThung ca sieu nho\tgia ban: 2500\nMua Thung ca nho\tgia ban: 5000$\nMua thung ca vua\tgia ban: 7500$\nMua thung ca to\tgia ban: 10000$", "Tuy chon", "huy bo");
    return 1;
}

CMD:xemthungca(playerid, params[])
{
    for(new i=0; i<MAX_PLAYERVEHICLES; i++)
    {
        if(PlayerVehicleInfo[playerid][i][pvId] == GetPlayerVehicleID(playerid)) return SendErrorMessage(playerid," Ban khong o tren phuong tien cua ban");
        if( PlayerVehicleInfo[playerid][i][VehicleThungID] == 0 ) return SendClientMessage(playerid, COLOR_GREY, "Tren thuyen khong co thung ca");
        SetPVarInt(playerid, "ThungCaID", PlayerVehicleInfo[playerid][i][VehicleThungID]);
        ShowPlayerDialog(playerid, DIALOG_MAINTHUNG, DIALOG_STYLE_LIST, "Thung ca", "Xem thong tin\nCat ca vao thung ", "Chon", "huy bo");
        SaveThung_Fix();
    }
    return 1;
}
CMD:mothaibabuonnam(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen khong the xem thung ca");
    for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
    {
        if(IsPlayerInVehicle(playerid, PlayerVehicleInfo[playerid][d][pvId]))
        {
            if(PlayerVehicleInfo[playerid][d][VehicleThungID] == 0) return SendClientMessage(playerid, COLOR_GREY, "Chiec thuyen khong co thung ca khong the xem");

            new str[130] , loai[30];
            switch(ThungCa[PlayerVehicleInfo[playerid][d][VehicleThungID]][pThungType])
            {
                case 1:
                {
                    loai = "Loai sieu nho";
                }
                case 2:
                {
                    loai = "Loai nho";
                }
                case 3:
                {
                    loai = "Loai vua";
                }
                case 4:
                {
                    loai = "Loai to";
                }
            }
            SaveThung_Fix();
            format(str, sizeof str, "Thung ca: %s\n So luong ca: %d kg", loai , ThungCa[PlayerVehicleInfo[playerid][d][VehicleThungID]][pSoKGCa] );
            ShowPlayerDialog(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "THUNG CA", str, "Dong" , "");
        }
    }
   
    return 1;
}
stock DatThungCa(playerid, i)
{
            if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Phuong tien nay khong the dat thung");
            if(PlayerInfo[playerid][pThungCa] == 0) return SendClientMessage(playerid, -1, "Ban khong co thung ca");
            if(GetVehicleModel(i) == 473)
            {
                    if(PlayerInfo[playerid][pThungCa] > 2) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");                 
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca"); 
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[j][pThungCaSet] == 0) {
                            switch(PlayerInfo[playerid][pThungCa])
                            {
                                case 1:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungCaSet] = 1;
                                    ThungCa[j][pThungCaID] = j;
                                    ThungCa[j][pThungType] = 1;
                                    SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                                    cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                                    ThungCa[j][pThungType] = 1; // nho~
                                    ThungCa[j][pThungAttachVeh] = i;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(2040,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject],i,-0.059999,-0.009999,0.105000,0.000000,5.500000,91.000000);
                                    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                                    RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                                    DeletePVar(playerid, "ThungCaObj");    
                                }
                                case 2:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungCaSet] = 1;
                                    ThungCa[j][pThungCaID] = j;
                                    ThungCa[j][pThungType] = 1;
                                    SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                                    cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                                    ThungCa[j][pThungType] = 2; // nho~
                                    ThungCa[j][pThungObject] = CreateObject(2969,0,0,-1000,0,0,0,100);
                                    ThungCa[j][pThungAttachVeh] = i;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i,0.059999,-0.724999,0.330000,-3.000000,1.500000,-179.000000);
                                    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                                    RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                                    DeletePVar(playerid, "ThungCaObj");    
                                }
                            }
                            return 1;
                        }
                    }
                    return 1;
            }
            if(GetVehicleModel(i) == 454)
            {
                    if(PlayerInfo[playerid][pThungCa] > 3) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");               
                    if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen");
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca");  
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[j][pThungCaSet] == 0) {
                            PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = j;
                            ThungCa[j][pThungAttachVeh] = i;
                            cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                            SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                            RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                            DeletePVar(playerid, "ThungCaObj");    
                            switch(PlayerInfo[playerid][pThungCa])
                            {
                                case 0:
                                {

                                }
                                case 1:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 1; // nho~
                                    ThungCa[j][pThungAttachVeh] = i;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(2040,0,0,-1000,0,0,0,100);              
                                    AttachObjectToVehicle(ThungCa[j][pThungObject],i,-0.059999,-0.009999,0.305000,0.000000,5.500000,91.000000);
                                }
                                case 2:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 2;
                                    ThungCa[j][pThungObject] = CreateObject(2969,0,0,-1000,0,0,0,100);
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    AttachObjectToVehicle(ThungCa[j][pThungObject] , i,-0.005000,-2.019998,0.294999,-3.000000,1.000000,-180.500000);
                                }
                                case 3:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 3;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(3800,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i,-0.005000,-2.019998,0.959999,-3.000000,1.000000,-180.500000);
                                }
                            }
                            return 1;
                        }
                    }
                    return 1;
            }
            if(GetVehicleModel(i) == 484)
            {
                    if(PlayerInfo[playerid][pThungCa] > 4) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");
                    if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen");
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca"); 
                    SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[j][pThungCaSet] == 0) 
                        {
                            PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = j;
                            ThungCa[j][pThungAttachVeh] = i;
                            cmd_me(playerid, "da dat thung xuong"); // cai nay lay 
                            SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                            RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                            DeletePVar(playerid, "ThungCaObj");               
                            switch(PlayerInfo[playerid][pThungCa])
                            {
                                case 1:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 1; // nho~
                                    ThungCa[j][pThungAttachVeh] = i;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(2040,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject],i,-0.059999,-0.009999,0.305000,0.000000,5.500000,91.000000);
                                }
                                case 2:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 2;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(2969,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i ,-0.080000,-3.220026,0.854999,-3.000000,1.500000,-176.000000);  
                                }
                                case 3:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 3;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(3800,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i ,0.059999,-2.450008,1.009999,-3.000000,1.000000,-180.500000);
        
                                }
                                case 4:
                                {
                                    PlayerVehicleInfo[playerid][i][VehicleThungID] = j;
                                    ThungCa[j][pThungType] = 4;
                                    PlayerInfo[playerid][pThungCa] = 0;
                                    ThungCa[j][pThungObject] = CreateObject(1224,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i,-0.005000,-2.735015,1.254999,-3.000000,1.000000,-180.500000);
        
                                }
                            }
                            return 1;
                        }
                    }
                    return 1;
            }
        return 1;
}/*
CMD:datthungca(playerid, params[])
{
    if(PlayerInfo[playerid][pThungCa] == 0) return SendClientMessage(playerid, -1, "Ban khong co thung ca");
    foreach(new i : Vehicles)
    {   
        new Float:Pos[3];
        GetVehiclePos(i, Pos[1],Pos[1],Pos[2]);   
        if(IsPlayerInRangeOfPoint(playerid, 3, Pos[1],Pos[1],Pos[2]))
        {
            print("alo1 23 23232");
            if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Phuong tien nay khong the dat thung");
            if(GetVehicleModel(i) == 473)
            {
                if(PlayerInfo[playerid][pThungCa] > 1) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");
             
                if(IsPlayerInRangeOfPoint(playerid, 3, Pos[1],Pos[1],Pos[2]))
                {
                    
                    if(PlayerVehicleInfo[playerid][i][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
                            return SendErrorMessage(playerid, "Thuyen nay khong phai cua ban khong the su dung lenh nay."); 
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca"); 
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[i][pThungCaSet] == 0) {
                            PlayerVehicleInfo[playerid][i][VehicleThungID] = i;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = i;
                            ThungCa[j][pThungType] = 1; // nho~
                            ThungCa[j][pThungObject] = CreateObject(2969,0,0,-1000,0,0,0,100);
                            ThungCa[j][pThungAttachVeh] = i;
                            AttachObjectToVehicle(ThungCa[j][pThungObject], GetPlayerVehicleID(playerid),-0.020000,0.064999,0.125000,-3.000000,1.000000,-180.500000);
                            return 1;
                        }
                    }
                    return 1;
                }
            }
            if(GetVehicleModel(i) == 454)
            {
                if(PlayerInfo[playerid][pThungCa] > 2) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");
   
                if(IsPlayerInRangeOfPoint(playerid, 3, Pos[1],Pos[1],Pos[2]))
                {
                    if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen");
                    if(PlayerVehicleInfo[playerid][i][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
                        return SendErrorMessage(playerid, "Thuyen nay khong phai cua ban khong the su dung lenh nay.");
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca");  
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[i][pThungCaSet] == 0) {
                            PlayerVehicleInfo[playerid][i][VehicleThungID] = i;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = i;
                            ThungCa[j][pThungType] = 1; // nho~
                            ThungCa[j][pThungAttachVeh] = i;
                            switch(PlayerInfo[playerid][pThungCa])
                            {
                                case 0:
                                {

                                }
                                case 1:
                                {
                                    ThungCa[j][pThungObject] = CreateObject(2969,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject] , i,-0.005000,-2.019998,0.294999,-3.000000,1.000000,-180.500000);
                                }
                                case 2:
                                {
                                    ThungCa[j][pThungObject] = CreateObject(3800,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i,-0.005000,-2.019998,0.959999,-3.000000,1.000000,-180.500000);
                                }
                            }
                            return 1;
                        }
                    }
                    return 1;
                }
            }
            if(GetVehicleModel(i) == 484)
            {
                if(PlayerInfo[playerid][pThungCa] > 2) return SendClientMessage(playerid, COLOR_GREY, "Thung ca qua to khong the dat");

                if(IsPlayerInRangeOfPoint(playerid, 3, Pos[1],Pos[1],Pos[2]))
                {
                    if(!IsABoatne(i)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen");
                    if(PlayerVehicleInfo[playerid][i][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
                        return SendErrorMessage(playerid, "Thuyen nay khong phai cua ban khong the su dung lenh nay."); 
                    if(PlayerVehicleInfo[playerid][i][VehicleThungID] != 0) return SendErrorMessage(playerid, "Tren thuyen da co thung ca"); 
                    for(new j = 1 ; j < MAX_THUNGHANG ; j++)
                    {
                        if(ThungCa[i][pThungCaSet] == 0) 
                        {
                            PlayerVehicleInfo[playerid][i][VehicleThungID] = i;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = i;
                            ThungCa[j][pThungType] = 1; // nho~
                            ThungCa[j][pThungAttachVeh] = i;
                            switch(PlayerInfo[playerid][pThungCa])
                            {
                                case 0..1:
                                {

                                }
                                case 2:
                                {
                                    ThungCa[j][pThungObject] = CreateObject(1224,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i,-0.005000,-2.735015,1.254999,-3.000000,1.000000,-180.500000);
                                }
                                case 3:
                                {
                                    ThungCa[j][pThungObject] = CreateObject(3800,0,0,-1000,0,0,0,100);
                                    AttachObjectToVehicle(ThungCa[j][pThungObject], i ,0.059999,-2.450008,1.009999,-3.000000,1.000000,-180.500000);
                                }
                            }
                            return 1;
                        }
                    }
                    return 1;
                }
            }
            return 1;
        }
    }
    return 1;
}*/
CMD:banthungca(playerid, params[])
{
    new i = ThungCaAttach[playerid];
    if(i == 0 ) return SendClientMessage(playerid, COLOR_GREY, "Trong thung khong co ca");
    if(PlayerInfo[playerid][pGiayPhepCauCa] != 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co giay phep cau ca");
    if(!IsPlayerInRangeOfPoint(playerid, 4, 2885.3867,-339.4484,2.2967)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o gan noi ban dung cu cau ca");

    if(GetPVarInt(playerid, "ThungCaObj"))
    {
        new file[1000];
        format(file, sizeof(file), "thungca/%d.ini", i);    
        fremove(file);
        new string[129];
        format(string, sizeof string, "Ban da ban %dKg ca voi gia %d", ThungCa[i][pSoKGCa],ThungCa[i][pSoKGCa] * 10);
        SendClientMessage(playerid, -1, string);
        PlayerInfo[playerid][pCash] += ThungCa[playerid][pSoKGCa] * 10;
        ThungCa[i][pSoKGCa] = 0;
        ThungCa[i][pThungCaSet] = 0;
        ThungCa[i][pThungType] = 0;
        RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
        ThungCaAttach[playerid] = 0;
        DeletePVar(playerid, "ThungCaObj");
        PlayerInfo[playerid][pThungCa] = 0;
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "Ban khong cam thung ca tren tay");
    }
    return 1;
}
new TimerDanhCa[MAX_PLAYERS];

CMD:thaluoi(playerid, params[])
{
    if(GetPVarInt(playerid, "DangThaLuoi") == 1) return SendClientMessage(playerid, COLOR_GREY, "Ban dang tha luoi...");
    if(PlayerInfo[playerid][pLuoiChai] != 1) return SendClientMessage(playerid, COLOR_GREY, "Ban khong co luoi");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong o tren thuyen khong the danh ca");
    if(PlayerVehicleInfo[playerid][GetPlayerVehicleID(playerid)][VehicleThungID] == 0) return SendClientMessage(playerid, COLOR_GREY, "Chiec thuyen nay khong co thung ca ...");
    SetPVarInt(playerid, "DanhCaTime", gettime()+20); 
    SetPVarInt(playerid, "DangThaLuoi", 1);
    cmd_me(playerid, "dang tha luoi danh ca.");
    TimerDanhCa[playerid] = SetTimerEx("ThaluoiNe", 1000, 0, "d", playerid);
    return 1;
}
CMD:vutthungca(playerid, params[])
{
    PlayerInfo[playerid][pThungCa] = 0;
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
    DeletePVar(playerid, "ThungCaObj");    
    return 1;
}
forward ThaluoiNe(playerid);
public ThaluoiNe(playerid)
{
    TimerDanhCa[playerid] = SetTimerEx("ThaluoiNe", 1000, 0, "d", playerid);
    new string[129] , time;
    time = GetPVarInt(playerid, "DanhCaTime") - gettime();
    format(string, sizeof string, "Dang danh ca thoi gian con lai: %d", GetPVarInt(playerid, "DanhCaTime") - gettime());
    SendClientTextDraw(playerid, string);
    new id = PlayerVehicleInfo[playerid][GetPlayerVehicleID(playerid)][VehicleThungID];
    if(time <= 1)
    {
        DeletePVar(playerid, "DangThaLuoi");
        KillTimer(TimerDanhCa[playerid]);
        DeletePVar(playerid, "DanhCaTime");
        new rad = 50 + random(100);
        ThungCa[id][pSoKGCa] += rad;
        new str[129] , toida;
        if(ThungCa[id][pThungType] == 1) {
            if(ThungCa[id][pSoKGCa] > 500) {
                ThungCa[id][pSoKGCa] = 500;
                toida = 500;
            }
        }     
        if(ThungCa[id][pThungType] == 2) {
            if(ThungCa[id][pSoKGCa] > 1000 ) {
                ThungCa[id][pSoKGCa] = 1000 ;
                toida = 1000;
            }
        }
        if(ThungCa[id][pThungType] == 3) {
            if(ThungCa[id][pSoKGCa] > 2500  ) {
                ThungCa[id][pSoKGCa] = 2500  ;
                toida = 2500;
            }
        }  
        if(ThungCa[id][pThungType] == 4) {
            if(ThungCa[id][pSoKGCa] > 5000 ) {
                ThungCa[id][pSoKGCa] = 5000 ;
                toida = 5000;
            }
        }    
        DeletePVar(playerid, "DanhCaTime");
        format(str, sizeof str, "Ban da nhan duoc %dkg ca, toi da thung ca la: %d", rad , toida );  
        SendClientMessage(playerid, COLOR_YELLOWEX, str);
        return 1; 
    }
    if(!IsPlayerInAnyVehicle(playerid)) 
    {
        DeletePVar(playerid, "DangThaLuoi");
        KillTimer(TimerDanhCa[playerid]);
        DeletePVar(playerid, "DanhCaTime");
        SendClientMessage(playerid, -1, "Ban da roi khoi thuyen");
        return 1;
    }
    return 1;
}
//VehicleThungID,
stock IsABoatne(carid) {
    switch(GetVehicleModel(carid)) {
        case 473, 454, 484: return 1;
    }
    return 0;
}

CMD:thungca(playerid,params[]) {
    new ys[32],check,veh = -1,Float:x,Float:y,Float:z;
    if(sscanf(params, "s[32]", ys))
    {
        SendUsageMessage(playerid, " /thunghang [dat,lay]");
        return 1;
    }
    if(strcmp(ys, "lay", true) == 0)
    {
        for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
        {
            if(PlayerVehicleInfo[playerid][d][pvId] != INVALID_PLAYER_VEHICLE_ID) GetVehiclePos(PlayerVehicleInfo[playerid][d][pvId], x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z))
            {
                if(!IsABoatne(PlayerVehicleInfo[playerid][d][pvId])) return SendClientMessage(playerid, COLOR_GREY, "Ban phai o gan phuong tien cua ban ( Luu y: Dinghy, Reefer, Speeder  ) "); 
                veh = d;
                check = 1;
                break;
            }
        }       
        if(check == 0) return SendErrorMessage(playerid, "Ban phai o gan phuong tien cua ban ( Luu y: Dinghy, Reefer, Speeder  )"); 
        switch(ThungCa[PlayerVehicleInfo[playerid][veh][VehicleThungID]][pThungType])
        {
            case 1: 
            {
                PlayerInfo[playerid][pThungCa] = 1;
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2040, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      

            }
            case 2: 
            {
                PlayerInfo[playerid][pThungCa] = 2;
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 2969, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            }
            case 3:
            {
                PlayerInfo[playerid][pThungCa] = 3;
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 3800, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                            }
            case 4:
            {
                PlayerInfo[playerid][pThungCa] = 4;
                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1224, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
            }
        }    
        SetPVarInt(playerid, "ThungCaObj", 1);
        ThungCaAttach[playerid] = PlayerVehicleInfo[playerid][veh][VehicleThungID];
        PlayerVehicleInfo[playerid][veh][VehicleThungID] = 0;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        return 1;
    }
    if(strcmp(ys, "dat", true) == 0)
    {
        for(new d = 0 ; d < MAX_PLAYERVEHICLES; d++)
        {
            if(PlayerVehicleInfo[playerid][d][pvId] != INVALID_PLAYER_VEHICLE_ID) GetVehiclePos(PlayerVehicleInfo[playerid][d][pvId], x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z))
            {
                if(!IsABoatne(PlayerVehicleInfo[playerid][d][pvId])) return SendClientMessage(playerid, COLOR_GREY, "Ban phai o gan phuong tien cua ban ( Luu y: Dinghy, Reefer, Speeder  ) "); 
                veh = d;
                check = 1;
                break;
            }
        }   
        if(check == 0) return SendErrorMessage(playerid, "Ban phai o gan phuong tien cua ban ( Luu y: Dinghy, Reefer, Speeder  )"); 
        if(PlayerVehicleInfo[playerid][veh][VehicleThungID] != 0 ) return SendErrorMessage(playerid, "Da co thung trong thuyen"); 
        printf("thung ca %d",PlayerInfo[playerid][pThungCa]);
        for(new j = 1 ; j < MAX_THUNGHANG ; j++)
        {
            if(ThungCa[j][pThungCaSet] == 0) 
            {
                print("toi day");
                switch(PlayerInfo[playerid][pThungCa])
                {
                    case 1: 
                    {
                        PlayerVehicleInfo[playerid][veh][VehicleThungID] = j;
                        ThungCa[j][pThungCaSet] = 1;
                        ThungCa[j][pThungCaID] = j;
                        ThungCa[j][pThungType] = 1;
                        SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                        cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                        ThungCa[j][pThungType] = 1; // nho~
                        ThungCa[j][pThungAttachVeh] = PlayerVehicleInfo[playerid][veh][VehicleThungID];
                        PlayerInfo[playerid][pThungCa] = 0;       
                        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                        RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                        DeletePVar(playerid, "ThungCaObj");   
                    }
                    case 2: 
                    {
                        PlayerVehicleInfo[playerid][veh][VehicleThungID] = j;
                        ThungCa[j][pThungCaSet] = 1;
                        ThungCa[j][pThungCaID] = j;
                        ThungCa[j][pThungType] = 1;
                        SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                        cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                        ThungCa[j][pThungType] = 1; // nho~
                        ThungCa[j][pThungAttachVeh] = PlayerVehicleInfo[playerid][veh][VehicleThungID];
                        PlayerInfo[playerid][pThungCa] = 0;       
                        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                        RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                        DeletePVar(playerid, "ThungCaObj");   
                    }
                    case 3: 
                    {
                        if(GetVehicleModel(PlayerVehicleInfo[playerid][veh][pvId]) == 454 || GetVehicleModel(PlayerVehicleInfo[playerid][veh][pvId]) == 484) 
                        {
                            PlayerVehicleInfo[playerid][veh][VehicleThungID] = j;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = j;
                            ThungCa[j][pThungType] = 1;
                            SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                            cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                            ThungCa[j][pThungType] = 1; // nho~
                            ThungCa[j][pThungAttachVeh] = PlayerVehicleInfo[playerid][veh][VehicleThungID];
                            PlayerInfo[playerid][pThungCa] = 0;       
                            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                            RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                            DeletePVar(playerid, "ThungCaObj"); 
                            return 1;
                        }
                        else 
                        {
                            SendErrorMessage(playerid, "Thuyen nay khong the dat thung ca vua ");
                        }                     
                    }
                    case 4: {
                        if(GetVehicleModel(PlayerVehicleInfo[playerid][veh][pvId]) == 484) {
                            PlayerVehicleInfo[playerid][veh][VehicleThungID] = j;
                            ThungCa[j][pThungCaSet] = 1;
                            ThungCa[j][pThungCaID] = j;
                            ThungCa[j][pThungType] = 1;
                            SendClientMessage(playerid, COLOR_WHITE, "Ban da dat thung ca vao trong thuyen ");
                            cmd_me(playerid, "da dat thung ca xuong."); // cai nay lay 
                            ThungCa[j][pThungType] = 1; // nho~
                            ThungCa[j][pThungAttachVeh] = PlayerVehicleInfo[playerid][veh][VehicleThungID];
                            PlayerInfo[playerid][pThungCa] = 0;       
                            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
                            RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
                            DeletePVar(playerid, "ThungCaObj"); 
                            return 1;
                        }
                        else 
                        {
                            SendErrorMessage(playerid, "Thuyen nay khong the dat thung ca vua ");
                        }
                        
                    }
                }
            }
        }
    }
    return 1;
}

