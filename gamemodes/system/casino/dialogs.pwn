
Dialog:CASINO_EDIT(playerid, response, listitem, inputtext[])
{
    if(!response) {
        DeletePVar(playerid, #TableID);
        DeletePVar(playerid, #casinoType);
        return 1;
    }
    
    new i = GetPVarInt(playerid, #TableID), amount;

    switch (GetPVarInt(playerid, #casinoType))
    {
        case 1: {
            amount = strval(inputtext);
            if (amount < 1 || isnull(inputtext)) {
                return Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
                        {AD0505}ERROR: Vui long nhap mot con so phu hop.\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1]);
            }
            if (amount > CasinoTable[i][cPrices][1]) {
                return Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
                        {AD0505}ERROR: Tien dat cuoc toi thieu khong the lon hon tien dat cuoc toi da.\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1]);
            }

            CasinoTable[i][cPrices][0] = amount;
            sendMessage(playerid, 0x2DBE7FFF, "CASINO:{FFFFFF} Ban da chinh tien dat cuoc toi thieu cua ban nay la {29AE2F}$%d{FFFFFF}.", amount);
            DeletePVar(playerid, #TableID);
            DeletePVar(playerid, #casinoType);
            return SaveCasinoTable(i); 
        }
        case 2: {
            amount = strval(inputtext);
            if (amount < 1 || isnull(inputtext)) {
                return Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
                        {AD0505}ERROR: Vui long nhap mot con so phu hop.\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1]);
            }
            if (amount < CasinoTable[i][cPrices][0]) {
                return Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
                        {AD0505}ERROR: Tien dat cuoc toi da phai lon hon tien dat cuoc toi thieu.\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1]);
            }

            CasinoTable[i][cPrices][1] = amount;
            sendMessage(playerid, 0x2DBE7FFF, "CASINO:{FFFFFF} Ban da chinh tien dat cuoc toi da cua ban nay la {29AE2F}$%d{FFFFFF}.", amount);
            DeletePVar(playerid, #TableID);
            DeletePVar(playerid, #casinoType);
            return SaveCasinoTable(i); 
        }
    }

    switch (listitem)
    {
        case 0: {
            Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
            {FFFFFF}[#] Dat cuoc toi thieu: {29AE2F}$%d\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1], CasinoTable[i][cPrices][0]);
            SetPVarInt(playerid, #casinoType, 1);
        }
        case 1: {
            Dialog_Show(playerid, CASINO_TYPE_1, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "\
            {FFFFFF}[#] Dat cuoc toi da: {29AE2F}$%d\n\n{0679CB}-> Nhap so tien dat cuoc ban muon:", "Xong", "Huy", i, CasinoType[CasinoTable[i][cType]-1], CasinoTable[i][cPrices][1]);
            SetPVarInt(playerid, #casinoType, 2);
        }
    }
    return 1;
}

Dialog:CASINO_BET(playerid, response, listitem, inputtext[]) 
{
    if (!response) {
        DeletePVar(playerid, #interactTable);
        DeletePVar(playerid, #betType);
        return 1;
    }

    new 
        i = GetPVarInt(playerid, #interactTable), 
        szDialog[448];
    
    if (PlayerBet[playerid])                    return SendErrorMessage(playerid, "Ban da dat cuoc roi.");
    if (CasinoTable[i][cTotalPlayer] == 10)     return SendErrorMessage(playerid, "Casino Table nay khong con cho trong.");
    if (CasinoTable[i][cTimeLeft] <= 20)        return SendErrorMessage(playerid, "Khong the dat cuoc vao thoi gian nay.");
    if (CasinoTable[i][cPause])                 return sendMessage(playerid, 0xFF0F3FFF, "CASINO:{FFFFFF} Vui long doi %d giay nua de bat dau mot phien miu.", CasinoTable[i][cPause]);

    if (GetPVarInt(playerid, #betType)) {
        switch (GetPVarInt(playerid, #betType)) {
            case 1: {
                if (strval(inputtext) > CasinoTable[i][cPrices][1] || strval(inputtext) < CasinoTable[i][cPrices][0]) 
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: So tien cuoc khong hop le.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                if (GetPlayerCash(playerid) < strval(inputtext))
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: So tien khong du de cuoc.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                if ((strval(inputtext) + ((strval(inputtext) * 90) / 100)) + GetBet_AllTable(CasinoTable[i][cBizID]) > Businesses[CasinoTable[i][cBizID]][bSafeBalance]) // tiền cược + 90% tiền + tiền cược tất cả bàn > số dư doanh nghiệp
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: Tong tien cuoc hien tai da vuot qua so du doanh nghiep.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                
                sendMessage(playerid, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da dat cuoc {006BB8}TAI{FFFFFF} voi so tien $%d.", strval(inputtext));
                sendMessage(playerid, 0xFF0F3FFF, "CASINO:{FFFFFF} Vui long khong di chuyen cho den khi ket thuc phien.");
                BetAmount[playerid] = strval(inputtext);
                PlayerBet[playerid] = 1;
                GivePlayerCash(playerid, -strval(inputtext));

                CasinoTable[i][cTotalPlayer]++;
                CasinoTable[i][cTotalBet] += strval(inputtext);
                return 1;
            }
            case 2: {
                if (strval(inputtext) > CasinoTable[i][cPrices][1] || strval(inputtext) < CasinoTable[i][cPrices][0]) 
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: So tien cuoc khong hop le.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                if (GetPlayerCash(playerid) < strval(inputtext))
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: So tien khong du de cuoc.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                if ((strval(inputtext) + ((strval(inputtext) * 90) / 100)) + GetBet_AllTable(CasinoTable[i][cBizID]) > Businesses[CasinoTable[i][cBizID]][bSafeBalance] || Businesses[CasinoTable[i][cBizID]][bSafeBalance] < 50000) // tiền cược + 90% tiền + tiền cược tất cả bàn > số dư doanh nghiệp
                    return Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{B31414}ERROR: Tong so tien cua doanh nghiep khong the chi tra.\n\n{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
                
                sendMessage(playerid, 0xFF0F3FFF, "CASINO:{FFFFFF} Ban da dat cuoc {006BB8}XIU{FFFFFF} voi so tien $%d.", strval(inputtext));
                sendMessage(playerid, 0xFF0F3FFF, "CASINO:{FFFFFF} Vui long khong di chuyen cho den khi ket thuc phien.");
                BetAmount[playerid] = strval(inputtext);
                PlayerBet[playerid] = 2;
                GivePlayerCash(playerid, -strval(inputtext));

                CasinoTable[i][cTotalPlayer]++;
                CasinoTable[i][cTotalBet] += strval(inputtext);
                return 1;
            }
        }
    }

    switch (listitem)
    {
        case 8: {
            Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
            SetPVarInt(playerid, #betType, 1);
            return 1;
        }
        case 9: {
            Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_INPUT, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", "{FFFFFF}-> Nhap so tien ma ban muon cuoc:", "Cuoc", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
            SetPVarInt(playerid, #betType, 2);
            return 1;
        }
        default: {
            if (CasinoTable[i][cType] == 1) {
            
                format(szDialog, sizeof(szDialog), "{00A326}\
                Phien Tai/Xiu: \t#%03d\n{FFFFFF}Thoi gian con lai: \t{706572}%02d giay{FFFFFF}\n\
                Dat toi thieu: \t{00B803}$%d{FFFFFF}\nDat toi da: \t{00B803}$%d{FFFFFF}\nTong tien da cuoc: \t{00B803}$%s{FFFFFF}\n \n\
                -> Dat cuoc:\n{006BB8}[#] Tai\n[#] Xiu", 
                CasinoTable[i][cSession], CasinoTable[i][cTimeLeft], CasinoTable[i][cPrices][0], CasinoTable[i][cPrices][1],
                number_format(CasinoTable[i][cTotalBet]));
                Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_TABLIST, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", szDialog, "Chon", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);
            
            }
            else if (CasinoTable[i][cType] == 2) {

                format(szDialog, sizeof(szDialog), "{00A326}\
                Phien Chan/Le: \t#%03d\n{FFFFFF}Thoi gian con lai: \t{706572}%02d giay{FFFFFF}\n\
                Dat toi thieu: \t{00B803}$%d{FFFFFF}\nDat toi da: \t{00B803}$%d{FFFFFF}\nTong tien da cuoc: \t{00B803}$%s{FFFFFF}\n \n\
                -> Dat cuoc:\n{006BB8}[#] Chan\n[#] Le", 
                CasinoTable[i][cSession], CasinoTable[i][cTimeLeft], CasinoTable[i][cPrices][0], CasinoTable[i][cPrices][1],
                number_format(CasinoTable[i][cTotalBet]));
                Dialog_Show(playerid, CASINO_BET, DIALOG_STYLE_TABLIST, "Casino Table {2DBE7F}#%d{FFFFFF} (%s)", szDialog, "Chon", "Dong", i, CasinoType[CasinoTable[i][cType]-1]);

            }
        }
    }
    return 1;
}