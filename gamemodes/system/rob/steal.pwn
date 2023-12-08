#include <YSI_Coding\y_hooks>

const 
        COLE_PRICE = 4;

static 
    Float:checkPos[MAX_PLAYERS][3],
    vSteal[MAX_PLAYERS],
    decayCP[MAX_PLAYERS];

stock Stealing_Cancel(playerid)
{
    DeletePVar(playerid, #Stealing);
    DeletePVar(playerid, #Stealing_timer);
    DeletePVar(playerid, #steal_captcha);
    ClearAnimations(playerid);
    ClosedClientText(playerid);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

forward Tires_Decay(playerid, amount);
public Tires_Decay(playerid, amount)
{
    if (Inventory_Count(playerid, "Lop Xe") < amount) return SendErrorMessage(playerid, " Loi trong qua trinh phan ra.");

    Inventory_Remove(playerid, Inventory_GetItemID(playerid, "Lop Xe", amount), amount);

    sendMessage(playerid, -1, "Ban da phan ra thanh cong %d lop xe, hay di den diem danh dau de nhan thanh pham.", amount);
    SetPlayerCheckpoint(playerid, -1880.6027, -1658.2773, 21.7500, 2.0);
    decayCP[playerid] = amount;
    return 1;
}

forward Get_Tire(playerid);
public Get_Tire(playerid)
{
    Inventory_Add(playerid, "Lop Xe");
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, 9);
    return 1;
}

forward Stealing_Tires(playerid);
public Stealing_Tires(playerid)
{
    if (!GetPVarInt(playerid, #Stealing)) return 1;

    new Float:pcPos[3], v, zone[MAX_ZONE_NAME];
    GetPlayerPos(playerid, pcPos[0], pcPos[1], pcPos[2]);
    if (GetPVarInt(playerid, #Stealing_timer))
    {

        if (checkPos[playerid][0] != pcPos[0]) {
            SendErrorMessage(playerid, " Hanh dong bi huy bo do ban da di chuyen.");
            return Stealing_Cancel(playerid);
        }
        if (vSteal[playerid] != GetClosestCar(playerid)) {
            SendErrorMessage(playerid, " Hanh dong bi huy bo do chiec xe khong ton tai.");
            return Stealing_Cancel(playerid);
        }

        SetPVarInt(playerid, #Stealing_timer, GetPVarInt(playerid, #Stealing_timer) - 1);
        if (GetPVarInt(playerid, #Stealing_timer) == 20 || GetPVarInt(playerid, #Stealing_timer) == 40)
        {
            new i = 7, captcha[12], szDialog[128];
            while(i--) captcha[i] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');

            SetPVarString(playerid, #steal_captcha, captcha);
            format(szDialog, sizeof(szDialog), "Ma kiem tra: {1EEBB5}%s{FFFFFF}\n\n{EC2727}-> Vui long nhap ma kiem tra ben duoi de tiep tuc:", captcha);
            Dialog_Show(playerid, STEAL_CAPTCHA, DIALOG_STYLE_INPUT, "Stealing Captcha", szDialog, "Xac nhan", "Dong");
            return 1;
        }

        if (GetPVarInt(playerid, #Stealing_timer) == 10)
        {
            Get3DZone(pcPos[0], pcPos[1], pcPos[2], zone, MAX_ZONE_NAME);  
            foreach (new i: Player)
            {
                if((0 <= PlayerInfo[i][pMember] < MAX_GROUPS) && (arrGroupData[PlayerInfo[i][pMember]][g_iGroupType] == 1))
                {
                    sendMessage(i, arrGroupData[PlayerInfo[i][pMember]][g_hRadioColour] * 256 + 255, "WARNING: Co mot vu trom xay ra tai khu vuc {EC9509}%s{FFFFFF}.", zone);
                }
            }
        }

        SetTimerEx("Stealing_Tires", 1000, 0, "d", playerid);
        return 1;
    }
    

    v = vSteal[playerid];
    SetVehicleTireState(v, 0, 0, 0, 0);
    sendMessage(playerid, -1, "Ban da trom thanh cong lop xe (vID: %d).", v);
    Stealing_Cancel(playerid);
    SetTimerEx("Get_Tire", 5000, 0, "d", playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, 9, 1096, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);

    Inventory_RemoveTimer(playerid, "Co Le", 1);
    return 1;
}

hook OnGameModeInit()
{
    CreateDynamicActor(1, 1136.7523, -1456.1343, 15.7969, 86.0599, 1, 100.0, 0, -1, -1);
    CreateDynamic3DTextLabel("Nguoi Trao Doi\n{FFFFFF}(Nhan Y de tuong tac)", 0xD96208FF, 1136.7523, -1456.1343, 15.7969+0.4, 10.0);
    CreateDynamic3DTextLabel("Khu Phan Ra\n{FFFFFF}(Nhan Y de tuong tac)", 0xD96208FF, -1868.8105, -1654.7738, 23.2877+0.1, 10.0);
    CreateDynamicPickup(19134, 23, -1868.8105, -1654.7738, 23.2877, 0, 0);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_YES))
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.5, 1136.7523, -1456.1343, 15.7969) && GetPlayerVirtualWorld(playerid) == 0)
        {
            Dialog_Show(playerid, DIALOG_COLE, DIALOG_STYLE_MSGBOX, "Nguoi Trao Doi", 
            "{088FE2}[#]{FFFFFF} Vat pham: Co le\n\
            {088FE2}[#]{FFFFFF} Chi phi: %d Sat\n\n\
            {088FE2}-> Ban co muon trao doi khong?", "Dong y", "Dong", COLE_PRICE);
        }
        else if (IsPlayerInRangeOfPoint(playerid, 2.5, -1868.8105, -1654.7738, 23.2877) && GetPlayerVirtualWorld(playerid) == 0)
        {
            Dialog_Show(playerid, DIALOG_DECAY, DIALOG_STYLE_INPUT, "Khu Phan Ra", 
            "{088FE2}[#]{FFFFFF} Vat pham: Lop xe\n\
            {088FE2}[#]{FFFFFF} Thu duoc: Vat lieu, Tien ban.\n\n\
            {088FE2}-> Nhap so luong lop ban muon phan ra:", "Xong", "Dong");
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    checkPos[playerid][0] = EOS;
    vSteal[playerid] = INVALID_VEHICLE_ID;
    decayCP[playerid] = 0;
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if (decayCP[playerid] && IsPlayerInRangeOfPoint(playerid, 2.0, -1880.6027, -1658.2773, 21.7500))
    {
        new tien_ban;
        for (new i; i < decayCP[playerid]; i ++) tien_ban += Random(3, 5);

        Inventory_Add(playerid, "Vat lieu", decayCP[playerid]);
        Inventory_Add(playerid, "Tien Ban", tien_ban);
        sendMessage(playerid, -1, "Ban nhan duoc:");
        sendMessage(playerid, 0x878787FF, "Vat lieu: {1A7DFF}%d cai{878787} - Tien ban: {FF1A1A}$%s{878787}.", decayCP[playerid], number_format(tien_ban));

        DisableCheckPoint(playerid);
        decayCP[playerid] = 0;
    }
    return 1;
}

CMD:steal(playerid, params[])
{
    if (GetPVarInt(playerid, #Stealing_timer) && GetPVarInt(playerid, #Stealing)) {
        SendClientMessage(playerid, -1, "Ban da huy bo hanh dong nay.");
        return Stealing_Cancel(playerid);
    }
    
    if (!Inventory_HasItem(playerid, "Co Le")) return SendErrorMessage(playerid, " Ban khong co Co le de lam dieu nay.");
    
    new 
        carid = GetPlayerVehicleID(playerid), v,
        closestcar = GetClosestCar(playerid, carid),
        panels, doors, lights, tires;

    if (!IsPlayerInRangeOfVehicle(playerid, closestcar, 5.0)) return SendErrorMessage(playerid, " Ban khong o gan phuong tien nao.");

    GetVehicleDamageStatus(closestcar, panels, doors, lights, tires);
    if (tires != 0) return SendErrorMessage(playerid, " Lop cua chiec xe nay da bi hu hong.");

    foreach (new i: Player)
    {
        v = GetPlayerVehicle(i, closestcar);
        if (v != -1) {
            
            if (playerid == i) return SendErrorMessage(playerid, " Ban khong trom duoc chiec xe cua minh.");
            /* Kiểm tra xem lốp xe người chơi còn hạn không */
            if (PlayerVehicleInfo[i][v][pvTiresDays] < gettime()) return SendErrorMessage(playerid, " Lop cua chiec xe nay da het han su dung.");
        
            vSteal[playerid] = closestcar;
            ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 1, 0, 1);
            SendClientTextDraw(playerid, "Ban dang trom lop xe...", 60);
            SetTimerEx("Stealing_Tires", 1000, false, "d", playerid);
            SetPVarInt(playerid, #Stealing_timer, 60);
            SetPVarInt(playerid, #Stealing, 1);
            SendClientMessage(playerid, -1, "Go '/steal' mot lan nua de huy bo hanh dong.");
            GetPlayerPos(playerid, checkPos[playerid][0], checkPos[playerid][1], checkPos[playerid][2]);
        }
    }

    SendErrorMessage(playerid, " Phuong tien khong kha dung.");
    return 1;
}

Dialog:DIALOG_COLE(playerid, response, listitem, inputtext[])
{
    if (!response) return 1;

    if (Inventory_HasItem(playerid, "Co Le"))           return SendErrorMessage(playerid, " Ban dang so huu mot cai co le roi.");
    if (Inventory_Count(playerid, "Sat") < COLE_PRICE)  return SendErrorMessage(playerid, " Ban khong du Sat de lam dieu nay (Can: %d sat nua).", COLE_PRICE - Inventory_Count(playerid, "Sat"));
    
    Inventory_Remove(playerid, Inventory_GetItemID(playerid, "Sat", COLE_PRICE), COLE_PRICE);
    Inventory_Add(playerid, "Co Le", 1, 60 * 24); // AddItem "Co Le" -> 24 giờ

    sendMessage(playerid, -1, "Ban da trao doi mot cay co le voi chi phi la %d Sat.", COLE_PRICE);
    return 1;
}

Dialog:STEAL_CAPTCHA(playerid, response, listitem, inputtext[])
{
    if (!response) {
        SendClientMessage(playerid, -1, "Ban da huy bo hanh dong nay.");
        return Stealing_Cancel(playerid);
    }

    new captcha[12];
    GetPVarString(playerid, #steal_captcha, captcha, 12);

    if (strcmp(inputtext, captcha, true) != 0) {
        SendClientMessage(playerid, -1, "Ban da that bai trong viec xac thuc, hanh dong bi huy bo.");
        return Stealing_Cancel(playerid);
    }

    SetTimerEx("Stealing_Tires", 1000, false, "d", playerid);
    return 1;
}

Dialog:DIALOG_DECAY(playerid, response, listitem, inputtext[])
{
    if (!response) return 1;

    new amount = strval(inputtext);
    if (isnull(inputtext) || amount < 1)
        return Dialog_Show(playerid, DIALOG_DECAY, DIALOG_STYLE_INPUT, "Khu Phan Ra", 
                "{C70000}[!] Ban da nhap mot con so khong hop le.\n\n\
                {088FE2}[#]{FFFFFF} Vat pham: Lop xe\n\
                {088FE2}[#]{FFFFFF} Thu duoc: Vat lieu, Tien ban.\n\n\
                {088FE2}-> Nhap so luong lop ban muon phan ra:", "Xong", "Dong");

    if (Inventory_Count(playerid, "Lop Xe") < amount)
        return Dialog_Show(playerid, DIALOG_DECAY, DIALOG_STYLE_INPUT, "Khu Phan Ra", 
                "{C70000}[!] Ban khong du so luong yeu cau de phan ra.\n\n\
                {088FE2}[#]{FFFFFF} Vat pham: Lop xe\n\
                {088FE2}[#]{FFFFFF} Thu duoc: Vat lieu, Tien ban.\n\n\
                {088FE2}-> Nhap so luong lop ban muon phan ra:", "Xong", "Dong");

    SetTimerEx("Tires_Decay", amount * 7000, 0, "dd", playerid, amount); /* 2 giây / 1 lốp */
    sendMessage(playerid, -1, "Dang bat dau phan ra, vui long doi %d giay de hoan tat.", amount * 7);
    sendMessage(playerid, 0xE7B40DFF, "LUU Y: KHONG ROI KHOI KHU VUC KHI CHUA HOAN THANH PHAN RA.");
    return 1;
}