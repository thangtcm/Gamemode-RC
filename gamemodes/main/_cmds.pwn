
 //--------------------------------[ FUNCTIONS ]---------------------------




CMD:traloicauhoi(playerid, params[])
{
    if(PlayerInfo[playerid][pHelper] < 1 && PlayerInfo[playerid][pAdmin] < 1){
        SendErrorMessage(playerid," Ban khong phai la Helper.");
	}
	else {

		new Player, string[128];

		if(sscanf(params, "u", Player)) {
			SendUsageMessage(playerid, " /traloicauhoi [ID]");
		}
		else if(Player == playerid) {
		    SendErrorMessage(playerid," Ban khong the tra loi cau hoi cua chinh minh.");
		}
		else if(!IsPlayerConnected(Player)) {
			SendErrorMessage(playerid," Nguoi choi khong hop le.");
		}
		else if(GetPVarInt(Player, "CAUHOINEWB") == 0) {
			SendErrorMessage(playerid," Nguoi do khong co cau hoi nao.");
		}
		else {
            new advert[256];
            GetPVarString(Player, "CAUHOINEWBTEXT", advert, 256);
            ShowPlayerDialog(playerid, TRALOICAUHOI, DIALOG_STYLE_INPUT, "Tra loi cau hoi", advert, "Tra Loi", "Tu choi");
            strcpy(TraLoiCauHoi[playerid], advert, 256);
            SetPVarString(playerid, "TRALOICAUHOITEXT", TraLoiCauHoi[playerid]);
            SetPVarInt(playerid, "CAUHOINEWBID", Player);
		    format(string, sizeof(string), "* %s da chap nhan cau hoi cua %s.",GetPlayerNameEx(playerid), GetPlayerNameEx(Player));
			SendHelperMessage(TEAM_AZTECAS_COLOR, string);
			format(string, sizeof(string), "* Helper %s da chap nhan cau hoi cua ban.",GetPlayerNameEx(playerid));
			SendClientMessageEx(Player, COLOR_LIGHTBLUE, string);
			DeletePVar(Player, "CAUHOINEWB");
			DeletePVar(Player, "CAUHOINEWBTEXT");
			ReportCount[playerid]++;
			ReportHourCount[playerid]++;
			AddCAReportToken(playerid);
			return 1;

		}
	}
	return 1;
}

CMD:xemcauhoi(playerid, params[])
{
	if(PlayerInfo[playerid][pHelper] >= 1 || PlayerInfo[playerid][pAdmin] >= 1)
	{
		new string[128];
		SendClientMessageEx(playerid, COLOR_GREEN, "____________________ TRO GIUP NEWBIE _____________________");
		foreach(new i: Player)
		{
			if(GetPVarInt(i, "CAUHOINEWB"))
			{
				format(string, sizeof(string), "(%s ID:%i) Dang Cho Mot Cau Hoi Chua Duoc Tra Loi", GetPlayerNameEx(i), i);
				SendClientMessageEx(playerid, COLOR_LIGHTRED, string);
			}
		}
		SendClientMessageEx(playerid, COLOR_GREEN, "_________________________________________________________");
	}
	return 1;
}

CMD:newb(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0) return SendErrorMessage(playerid," Ban chua dang nhap.");
	if(PlayerInfo[playerid][pTut] == 0) return SendErrorMessage(playerid," Ban khong the lam dieu nay bay gio.");
	if((nonewbie) && PlayerInfo[playerid][pAdmin] < 2) return SendClientMessageEx(playerid, COLOR_GRAD2, "Kenh hoi dap newbie dang tat!");
	if(PlayerInfo[playerid][pNMute] == 1) return SendErrorMessage(playerid," Ban da bi cam noi chuyen tren kenh hoi dap.");
	if(gNewbie[playerid] == 1) return SendErrorMessage(playerid," Ban da tat kenh hoi dap, /tognewbie de mo!");

	new string[128];
	if(gettime() < NewbieTimer[playerid])
	{
		format(string, sizeof(string), "Ban phai cho %d giay de tiep tuc hoi dap tren kenh nay.", NewbieTimer[playerid]-gettime());
		SendClientMessageEx(playerid, COLOR_GREY, string);
		return 1;
	}
 	if(PlayerInfo[playerid][pHelper] >= 1 && PlayerInfo[playerid][pAdmin] < 2) return SendErrorMessage(playerid," Ban khong the su dung kenh nay!");
	if(PlayerInfo[playerid][pHelper] < 1 && PlayerInfo[playerid][pAdmin] < 1)
	{
		ShowPlayerDialog(playerid, CAUHOINEWB, DIALOG_STYLE_INPUT, "{3399FF}Nhap cau hoi", "{FFFFFF}Hay nhap cau hoi ma ban can hoi.", "Dong y", "Bo qua");
		return 1;
	}
	if(isnull(params)) return SendUsageMessage(playerid, " (/newb)ie [noi dung]");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	format(string, sizeof(string), "** Administrator %s: %s", GetPlayerNameEx(playerid), params);
	}
	foreach(new n: Player)
	{
		if (gNewbie[n]==0)
		{
			SendClientMessageEx(n, COLOR_NEWBIE, string);
		}
	}
	return 1;
}
/*
CMD:bango(playerid, params[])
{
	ShowPlayerDialog(playerid, BANGO, DIALOG_STYLE_LIST, "Danh Sach Gia Go","20KG Go, Gia 200$\n40KG Go, Gia 450$\n100KG Go, Gia 1.200$", "Ban Go", "Khong Ban");
	return 1;
}

forward DangChatGo(playerid);
public DangChatGo(playerid)
{
	RemovePlayerAttachedObject(playerid, 0);
	DeletePVar(playerid, "IsFrozen");
	TogglePlayerControllable(playerid, 1);
	SetPlayerCheckpoint(playerid, -450.9864, -48.1142, 59.7089, 3);
	PlayerInfo[playerid][pServiceTime] = gettime()+20;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 1, 1, 1, 0, 1);
	SetPlayerAttachedObject(playerid, 9, 1303, 1, 0.218000, 0.507000, 0.128000, 8.300000, 91.700000, -42.300000, 0.475000, 0.430999, 0.526000, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}
*/
CMD:credits(playerid, params[])
{
    new str[2460], name[1280];
    format(str, sizeof(str), "So Coin cua ban hien co la: (%d Coin)",PlayerInfo[playerid][pGcoin]);
    format(name, sizeof(name), "Coin cua - %s",GetPlayerNameEx(playerid));
    ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, name, str, "Dong Lai", "");
    return 1;
}


CMD:g(playerid, params[]) {

	new
		iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank];

	if (0 <= iGroupID < MAX_GROUPS) {
 		if (iRank >= arrGroupData[iGroupID][g_iRadioAccess]) {
			if(GetPVarInt(playerid, "togGroup") == 0) {
				if(!isnull(params))
				{
					new string[128], employer[GROUP_MAX_NAME_LEN], rank[GROUP_MAX_RANK_LEN], division[GROUP_MAX_DIV_LEN];
					//format(string, sizeof(string), "(radio) %s", params);
					//SetPlayerChatBubble(playerid, string, COLOR_WHITE, 15.0, 5000);
					GetPlayerGroupInfo(playerid, rank, division, employer);
					format(string, sizeof(string), "(( (%d) %s: %s ))",PlayerInfo[playerid][pRank], GetPlayerNameEx(playerid), params);
					foreach(new i: Player)
					{
						if(GetPVarInt(i, "togGroup") == 0)
						{
							if(PlayerInfo[i][pMember] == iGroupID && iRank >= arrGroupData[iGroupID][g_iRadioAccess]) {
								SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, string);
							}
							if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == iGroupID) {
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
								SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szBigEar);
							}
						}
					}
				}
				else return SendUsageMessage(playerid, " (/g)roup [group chat]");
			}
			else return SendErrorMessage(playerid," Kenh group cua ban hien dang tatt, su dung /toggroup de lien lac tro lai.");
		}
		else return SendErrorMessage(playerid," Ban khong co quyen truy cap tan so group nay.");
	}
	else return SendErrorMessage(playerid," Ban khong o trong nhom.");
	return 1;
}
/*
CMD:banvukhi(playerid, params[])
{
	return cmd_sellgun(playerid, params);
}

CMD:sellgun(playerid, params[])
{
    new string[128];
    if(GetPVarInt(playerid, "IsInArena") >= 0) {
        SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong the lam dieu nay khi dang trong arena!");
        return 1;
    }
   	if(GetPVarInt( playerid, "EventToken") != 0)
	{
		SendErrorMessage(playerid," Ban khong the lam dieu nay khi dang trong su kien.");
		return 1;
	}
    if (PlayerInfo[playerid][pJob] != 9 && PlayerInfo[playerid][pJob2] != 9) {
        SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong phai nguoi ban vu khi!");
        return 1;
    }
    if(WatchingTV[playerid] != 0) {
        SendErrorMessage(playerid," Ban khong the lam dieu nay khi dang xem TV!");
        return 1;
    }
    if (PlayerInfo[playerid][pScrewdriver] == 0) {
        SendClientMessageEx(playerid,COLOR_GREY,"   Ban Khong co tua vit!");
        return 1;
    }
    if (PlayerInfo[playerid][pJailTime] > 0) {
        SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong the dua sung khi dang trong tu!");
        return 1;
    }
    if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid," Ban khong the lam dieu nay bay gio.");
    if (GetPVarInt(playerid, "ArmsTimer") > 0) {
        format(string, sizeof(string), "   Ban phai doi %d giay truoc khi dua vu khi cho nguoi  khac.", GetPVarInt(playerid, "ArmsTimer"));
        SendClientMessageEx(playerid,COLOR_GREY,string);
        return 1;
    }
    if(PlayerInfo[playerid][pHospital] > 0) {
        SendErrorMessage(playerid," Ban khong the tao vu khi khi dang o benh vien.");
        return 1;
    }

    new giveplayerid,x_weapon[20],weapon,price,storageid;

    if(sscanf(params, "us[20]", giveplayerid, x_weapon)) {
        SendClientMessageEx(playerid, COLOR_GREEN, "________________________________________________");
        SendClientMessageEx(playerid, COLOR_YELLOW, "<< Danh sach vu khi >>");
        new level = PlayerInfo[playerid][pArmsSkill];
        if(level >= 0 && level < 50)
		{
            SendClientMessageEx(playerid, COLOR_GRAD1, "sdpistol(1500)	flowers(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "9mm(1550)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shotgun(8000)	knuckles(200)");
        }
        else if(level >= 50 && level < 100)
		{
            SendClientMessageEx(playerid, COLOR_GRAD1, "sdpistol(1500)	flowers(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "9mm(1550)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shotgun(3000)	knuckles(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "mp5(3500)		baseballbat(190)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "rifle(3000)	    cane(150)");
        }
        else if(level >= 100 && level < 200)
		{
            SendClientMessageEx(playerid, COLOR_GRAD1, "sdpistol(1500)	flowers(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "9mm(1550)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shotgun(3000)	knuckles(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "mp5(3500)		baseballbat(190)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "rifle(3000)	    cane(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shovel(100)");
        }
        else if(level >= 200 && level < 400)
		{
            SendClientMessageEx(playerid, COLOR_GRAD1, "sdpistol(1500)	flowers(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "9mm(1550)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shotgun(3000)	knuckles(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "mp5(3500)		baseballbat(190)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "rifle(3000)	    cane(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "deagle(4000)	shovel(100)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "golfclub(200)");
        }
        else if(level >= 400)
		{
            SendClientMessageEx(playerid, COLOR_GRAD1, "sdpistol(1500)	flowers(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "9mm(1550)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "shotgun(3000)	knuckles(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "rifle(3000)	    cane(150)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "deagle(8000)	shovel(100)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "golfclub(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "dildo(200)");
            SendClientMessageEx(playerid, COLOR_GRAD1, "uzi(3250)      tec9(3250)");
        }
        SendClientMessageEx(playerid, COLOR_GREEN, "________________________________________________");
        SendUsageMessage(playerid, " /chetaosung [nguoi choi] [ten vu khi]");
        return 1;
    }

	if(!IsPlayerConnected(giveplayerid)) {
		return SendClientMessageEx(playerid, COLOR_GRAD2, "Nguoi choi khong hop le.");
	}
    if(strcmp(x_weapon,"dildo",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 400) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 199) {
            weapon = 10; price = 25;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }
    else if(strcmp(x_weapon,"golfclub",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 200) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 200) {
            weapon = 2; price = 200;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }
    else if(strcmp(x_weapon,"shovel",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 100) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 99) {
            weapon = 6; price = 100;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"cane",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 50) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 149) {
            weapon = 15; price = 150;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"baseballbat",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 50) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 189) {
            weapon = 5; price = 190;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"knuckles",true) == 0) {
        if(PlayerInfo[playerid][pMats] > 199) {
            weapon = 1; price = 200;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"sdpistol",true) == 0) {
        if(PlayerInfo[playerid][pMats] > 1500) {
            weapon = 23; price = 1500;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"flowers",true) == 0) {
        if(PlayerInfo[playerid][pMats] > 149) {
            weapon = 14; price = 150;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"deagle",true) == 0)
	{
        if(PlayerInfo[playerid][pArmsSkill] < 400) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 8000)
		{
            weapon = 24; price = 8000;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"mp5",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 50) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 3000) {
            weapon = 29; price = 3000;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"uzi",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 400) return SendErrorMessage(playerid," Ky nang cong viec cua ban khong du de che tao vu khi nay");
        if(PlayerInfo[playerid][pMats] > 3249) {
            weapon = 28; price = 3250;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"tec9",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 400) return SendErrorMessage(playerid," Ky nang cong viec cua ban khong du de che tao vu khi nay");
        if(PlayerInfo[playerid][pMats] > 3249) {
            weapon = 32; price = 3250;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"shotgun",true) == 0) {
        if(PlayerInfo[playerid][pMats] > 3000) {
            weapon = 25; price = 3000;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else if(strcmp(x_weapon,"9mm",true) == 0) {
        if(PlayerInfo[playerid][pMats] > 1500) {
            weapon = 22; price = 1500;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }
    else if(strcmp(x_weapon,"rifle",true) == 0) {
        if(PlayerInfo[playerid][pArmsSkill] < 50) return SendErrorMessage(playerid,"  Ky nang cong viec cua ban khong du de che tao vu khi nay!");
        if(PlayerInfo[playerid][pMats] > 2999) {
            weapon = 33; price = 3000;
        }
        else {
            SendClientMessageEx(playerid,COLOR_GREY,"   Ban khong co du vat lieu!");
            return 1;
        }
    }

    else { SendClientMessageEx(playerid,COLOR_GREY,"   Ten vu  khi khong  hop le!"); return 1; }
    if (ProxDetectorS(5.0, playerid, giveplayerid))
	{
        if(PlayerInfo[giveplayerid][pConnectHours] < 2 || PlayerInfo[giveplayerid][pWRestricted] > 0) return SendClientMessageEx(playerid, COLOR_GRAD2, "Nguoi do dang bo han che so huu vu  khi!");

        if(giveplayerid == playerid)
		{
            format(string, sizeof(string), "(-) Ban Da Che Tao Cho Minh Khau Sung %s", x_weapon);
            PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            SendClientMessageEx(playerid, COLOR_GRAD1, string);
            PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
            switch( PlayerInfo[playerid][pSex] )
			{
                case 1: format(string, sizeof(string), "* %s da tao mot vu khi tu vat lieu cua minh.", GetPlayerNameEx(playerid));
                case 2: format(string, sizeof(string), "* %s da tao mot vu khi tu vat lieu cua minh.", GetPlayerNameEx(playerid));
            }
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            GivePlayerValidWeapon(playerid,weapon,1);
            PlayerInfo[playerid][pMats] -= price;
            if(weapon > 15)
			{
  				PlayerInfo[playerid][pArmsSkill] += 1;
            }
            if(PlayerInfo[playerid][pAdmin] < 3)
			{
                SetPVarInt(playerid, "ArmsTimer", 10); SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_ARMSTIMER);
            }
            if(PlayerInfo[playerid][pArmsSkill] == 50)
            { SendClientMessageEx(playerid, COLOR_YELLOW, "* Ky nang che tao vu khi cua ban dat cap do 2, se co them nhieu loai vu khi de ban."); }
            else if(PlayerInfo[playerid][pArmsSkill] == 100)
            { SendClientMessageEx(playerid, COLOR_YELLOW, "* Ky nang che tao vu khi cua ban dat cap do 3, se co them nhieu loai vu khi de ban."); }
            else if(PlayerInfo[playerid][pArmsSkill] == 200)
            { SendClientMessageEx(playerid, COLOR_YELLOW, "* Ky nang che tao vu khi cua ban dat cap do 4, se co them nhieu loai vu khi de ban."); }
            else if(PlayerInfo[playerid][pArmsSkill] == 400)
            { SendClientMessageEx(playerid, COLOR_YELLOW, "* Ky nang che tao vu khi cua ban dat cap do 5, se co them nhieu loai vu khi de ban."); }
            return 1;
        }
        format(string, sizeof(string), "* Ban cung cap cho %s mua mot khau %s.", GetPlayerNameEx(giveplayerid), x_weapon);
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), "* Nguoi ban vu khi %s muon ban cho ban mot %s, (Su dung /chapnhan vukhi) de mua.", GetPlayerNameEx(playerid), x_weapon);
        SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
        GunOffer[giveplayerid] = playerid;
		GunStorageID[giveplayerid] = storageid;
        GunId[giveplayerid] = weapon;
        GunMats[giveplayerid] = price;
	 	SetPVarInt(giveplayerid, "WeaponSeller_SQLId", GetPlayerSQLId(playerid));
        if(PlayerInfo[playerid][pAdmin] < 3) {
            SetPVarInt(playerid, "ArmsTimer", 10); SetTimerEx("OtherTimerEx", 1000, false, "ii", playerid, TYPE_ARMSTIMER);
        }
    }
    else
	{
        SendErrorMessage(playerid," Nguoi do khong gan ban.");
        return 1;
    }
	return 1;
}

CMD:muatoken(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid,3.0,2561.3586,1403.9874,7699.5845))
	{
	    ShowPlayerDialog(playerid, MUATOKEN, DIALOG_STYLE_LIST, "Ban muon mua bao nhiu Token","200Gcoin/40 Token\n500Gcoin/140 Token", "Chon", "Huy bo");
	}
    else
    {
         SendClientMessageEx(playerid, COLOR_WHITE,"(-) SHOP : Ban khong o noi ban token");
    }
    return 1;
}



*/
CMD:lockjob(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	    ShowPlayerDialog(playerid, DIALOG_LockJob, DIALOG_STYLE_LIST, "Khoa Job", "Pizza Boy\nTrucker", "Khoa", "Huy Bo");
	}
	return 1;
}

CMD:gotosz(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1338 || PlayerInfo[playerid][pShopTech] == 1)
	{
		new housenum;
		if(sscanf(params, "d", housenum)) return SendErrorMessage(playerid," SUDUNG: /gotosz [ID Khu An Toan]");

		SetPlayerPos(playerid,SafeZoneInfo[housenum][szExteriorX],SafeZoneInfo[housenum][szExteriorY],SafeZoneInfo[housenum][szExteriorZ]);
		GameTextForPlayer(playerid, "~w~Teleporting", 5000, 1);
		SetPlayerInterior(playerid, 0);
		PlayerInfo[playerid][pInt] = 0;
	}
	return 1;
}

CMD:szedit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 99999)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Lenh nay khong ton tai. Neu ban khong biet lenh hay su dung lenh /help");
		return 1;
	}

	new string[128], choice[32], szid, amount;
	if(sscanf(params, "s[32]dd", choice, szid, amount))
	{
		SendErrorMessage(playerid," SUDUNG: /szedit [name] [Khu An Toan ID] [(Optional)amount]");
		SendErrorMessage(playerid," Available names: Toado, Khoangcach");
		return 1;
	}
	if(strcmp(choice, "toado", true) == 0)
	{
		GetPlayerPos(playerid, SafeZoneInfo[szid][szExteriorX], SafeZoneInfo[szid][szExteriorY], SafeZoneInfo[szid][szExteriorZ]);
		SendClientMessageEx( playerid, COLOR_WHITE, "Ban da chinh sua toa do Khu An Toan!" );
		DestroyPickup(SafeZoneInfo[szid][szPickupID]);
		SaveSafeZones();

		format(string, sizeof(string), "%s da chinh sua toa do Khu An Toan (ID %d).", GetPlayerNameEx(playerid), szid);
		Log("logs/khuantoan.log", string);

		DestroyPickup(SafeZoneInfo[szid][szPickupID]);
		DestroyDynamic3DTextLabel(SafeZoneInfo[szid][szTextID]);
		format(string, sizeof(string), "{FFFF66}Khu an toan\nID: %d",szid);
		SafeZoneInfo[szid][szTextID] = CreateDynamic3DTextLabel( string, COLOR_WHITE, SafeZoneInfo[szid][szExteriorX], SafeZoneInfo[szid][szExteriorY], SafeZoneInfo[szid][szExteriorZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
		SafeZoneInfo[szid][szPickupID] = CreatePickup(1314, 23, SafeZoneInfo[szid][szExteriorX], SafeZoneInfo[szid][szExteriorY], SafeZoneInfo[szid][szExteriorZ]);
	}
	else if(strcmp(choice, "Khoangcach", true) == 0)
	{
	    SafeZoneInfo[szid][szKhoangcach] = amount;
		SendClientMessageEx( playerid, COLOR_WHITE, "Ban da chinh sua khoang cach Khu An Toan!" );
		SaveSafeZones();

		format(string, sizeof(string), "%s da chinh sua khoang cach Khu An Toan (ID %d).", GetPlayerNameEx(playerid), szid);
		Log("logs/khuantoan.log", string);

		DestroyDynamic3DTextLabel(SafeZoneInfo[szid][szTextID]);
		format(string, sizeof(string), "{FFFF66}Khu an toan\nID: %d",szid);
		SafeZoneInfo[szid][szTextID] = CreateDynamic3DTextLabel( string, COLOR_WHITE, SafeZoneInfo[szid][szExteriorX], SafeZoneInfo[szid][szExteriorY], SafeZoneInfo[szid][szExteriorZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
	}
	SaveSafeZones();
	return 1;
}

CMD:szdelete(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1338)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "Ban khong du kha nang de su dung lenh nay`!");
		return 1;
	}
	new h, string[128];
	if(sscanf(params,"d",h)) return SendClientMessage(playerid, COLOR_WHITE,"USAGE: /szdelete [Khu An Toan ID]");
	if(!IsValidDynamicPickup(SafeZoneInfo[h][szPickupID])) return SendClientMessage(playerid, COLOR_WHITE,"Khu An Toan do khong ton tai.");
	SafeZoneInfo[h][szExteriorX] = 0;
	SafeZoneInfo[h][szExteriorY] = 0;
	SafeZoneInfo[h][szExteriorZ] = 0;
	DestroyDynamicPickup(SafeZoneInfo[h][szPickupID]);
	DestroyDynamic3DTextLabel(SafeZoneInfo[h][szTextID]);
	SaveSafeZones();
	format(string, sizeof(string), "Ban da xoa Khu An Toan (ID %d).", h);
	SendClientMessageEx(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "%s da xoa Khu An Toan (ID %d).", GetPlayerNameEx(playerid), h);
	Log("logs/khuantoan.log", string);
	return 1;
}
CMD:capmaphuhieu(playerid, params[])
{
    if(PlayerInfo[playerid][pLeader] >= 0 || PlayerInfo[playerid][pFactionModerator] >= 1)
    {
 	    new giveplayerid, mahieu;
	    if(sscanf(params, "ud", giveplayerid, mahieu)) return SendUsageMessage(playerid, " /capmaphuhieu [player] [mahieu]");
	    else if(!(1 <= mahieu <= 999)) SendClientMessageEx(playerid, COLOR_GRAD2, "Tu 1 den 999.");
	    else if(!IsPlayerConnected(giveplayerid)) return SendErrorMessage(playerid," Nguoi choi khong hop le.");
	    else
	    {
            new string[128];
            PlayerInfo[giveplayerid][pMaHieu1] = 0;
            PlayerInfo[giveplayerid][pMaHieu1] = mahieu;
            format(string, sizeof(string), "{9999FF} %s cap ma hieu cho ban ( Ma hieu: %d )", GetPlayerNameEx(playerid), mahieu);
            SendClientMessageEx(giveplayerid, COLOR_GRAD2, string);
            format(string, sizeof(string), "{9999FF} Ban cap ma hieu cho %s ( Ma hieu: %d )", GetPlayerNameEx(giveplayerid), mahieu);
            SendClientMessageEx(playerid, COLOR_GRAD2, string);
     	}
	}
	else SendErrorMessage(playerid," Ban khong duoc phep su dung lenh nay.");
	return 1;
}

CMD:showmahieu(playerid, params[])
{
    if(PlayerInfo[playerid][pMaHieu1] >= 1)
    {
	    new giveplayerid, nation[24], string[128];
	    if(sscanf(params, "u", giveplayerid))  return SendUsageMessage(playerid, " /showmahieu [player]");
	    if(gettime() < ShowTimer[playerid])
	    {
		    format(string, sizeof(string), "Ban phai cho %d giay de su dung lenh nay.", ShowTimer[playerid]-gettime());
		    SendClientMessageEx(playerid, COLOR_GREY, string);
		    return 1;
	    }
	    if(IsPlayerConnected(giveplayerid))
	    {
		    new iGroupID = PlayerInfo[playerid][pMember],
		    rank[GROUP_MAX_RANK_LEN],
		    division[GROUP_MAX_DIV_LEN],
		    employer[GROUP_MAX_NAME_LEN];
		    if(0 <= iGroupID < MAX_GROUPS)
		    if(ProxDetectorS(8.0, playerid, giveplayerid))
		    {
                switch(PlayerInfo[playerid][pNation])
		        {
				    case 0: nation = "San Andreas";
				    case 1: nation = "Tierra Robada";
	     	    }
				GetPlayerGroupInfo(playerid, rank, division, employer);
				format(string, sizeof(string), "{FFFFFF}Ho Ten: %s\nLam viec tai:{%06x} %s{FFFFFF}\nChuc vu: %s (%s)\nMa phu hieu: %d", GetPlayerNameEx(playerid), GetPlayerColor(playerid) >>> 8, employer, rank, division, PlayerInfo[playerid][pMaHieu1]);
				ShowPlayerDialog(giveplayerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "The nhan vien", string, "Dong Lai", "");
				format(string, sizeof(string), "{FF8000}** {C2A2DA}%s da lay the nhan vien dua cho %s xem.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
				ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				format(string, sizeof(string), "* %s da show ma hieu cua minh.", GetPlayerNameEx(playerid));
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				ShowTimer[playerid] = gettime()+5;
			}
			else SendErrorMessage(playerid," Nguoi do khong gan ban.");
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Nguoi choi khong hop le.");
    }
    else SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co Ma Hieu.");
    return 1;
}
CMD:xemtruyduoi(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pTruyDuoi] < 1)
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "Ban da het bi truy duoi");
	}
	else
	{
		format(string, sizeof(string), "Ban con %d phut se het bi bi truy duoi boi canh sat!Hay chay tron!", PlayerInfo[playerid][pTruyDuoi]);
		SendClientMessageEx(playerid, COLOR_YELLOW, string);
	}
	return 1;
}
CMD:truyduoi(playerid,params[])
{
    if (IsACop(playerid))
    {
            new iTargetID,strc[128];
            if(sscanf(params, "u", iTargetID)) {
                return SendUsageMessage(playerid, " /truyduoi [player]");
            }
            else if(iTargetID == playerid) {
                return SendErrorMessage(playerid," Ban khong the su dung lenh nay cho ban.");
            }
            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid," Ban Phai Ngoi o Tren xe moi co the Pursuit");
            else if(IsACop(iTargetID))
            {
                return SendErrorMessage(playerid," Ban khong the truy duoi nhan vien thi hanh phap luat.");
            }
            else if(!IsPlayerConnected(iTargetID)) {
                return SendErrorMessage(playerid," Nguoi choi khong hop le.");
            }
            else if(GetPlayerInterior(iTargetID) != 0) {
                return SendErrorMessage(playerid," Ban khong the su dung lenh nay trong khi dang o trong mot noi that.");
            }
            else if(PlayerInfo[iTargetID][pAdmin] >= 2 && PlayerInfo[iTargetID][pTogReports] != 1) {
                return SendErrorMessage(playerid," You are unable to find this person.");
            }
            else if (GetPVarInt(playerid, "_SwimmingActivity") >= 1) {
                return SendClientMessageEx(playerid, COLOR_GRAD2, "Ban khong the tim thay nguoi nay trong khi dang boi loi.");
            }
            if(PlayerInfo[iTargetID][pTruyDuoi] >= 1)
            {
                SendClientMessageEx(playerid, COLOR_GRAD2, "  Nguoi nay dang bi canh sat truy duoi");
                return 1;
            }
            if(!ProxDetectorS(200,playerid,iTargetID))
            {
                SendClientMessageEx(playerid, COLOR_GRAD2, "Ban phai gan nguoi nay trong pham vi 200m");
                return 1;
            }
            if (GetPVarInt(playerid, "_SwimmingActivity") >= 1)
            {
                SendClientMessageEx(playerid, COLOR_GRAD2, "  Ban phai dung boi! (/stopswimming)");
                return 1;
            }
            if(gettime()<TimeTruyDuoi[playerid])
            {
                format(strc,sizeof(strc),"Ban phai doi %d giay moi duoc su dung lai!",TimeTruyDuoi[playerid]-gettime());
                SendClientMessageEx(playerid, COLOR_GRAD2,strc);
                return 1;
            }
            else
            {
                new str[128],str2[128];
                TimeTruyDuoi[playerid]=gettime()+200;
                format(str,128,"** Ban dang truy duoi doi tuong %s (ID: %i) (( Co hieu luc trong 7 phut ))",GetPlayerNameExt(iTargetID),playerid);
                SendClientMessageEx(playerid, COLOR_YELLOW,str);
                SendClientMessageEx(iTargetID, COLOR_LIGHTRED, "Ban dang bi truy duoi boi canh sat neu ban /q ban se o tu 20 phut (( Hieu luc 7 phut ))");
                GameTextForPlayer(iTargetID, "~y~Ban dang bi truy duoi", 2500, 3);
                PlayerInfo[iTargetID][pTruyDuoi] = 7;
                timetrd[iTargetID] = SetTimerEx("TruyDuoiC",420000,false,"ii",iTargetID,playerid);
                format(str2,128,"HQ: Si quan %s dang truy duoi doi tuong %s",GetPlayerNameExt(playerid),GetPlayerNameExt(iTargetID));
                SendGroupMessage(1,TEAM_BLUE_COLOR,str2);
            }
    }
    else  SendClientMessageEx(playerid, COLOR_GRAD1, "Ban khong duoc phep su dung lenh nay.");
    return 1;
}
CMD:dungtruyduoi(playerid, params[])
{
	if(IsACop(playerid))
	{
		new string[128], giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendUsageMessage(playerid, " /dungtruyduoi [Player]");

		if(IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(1000.0, playerid, giveplayerid))
			{
				if(giveplayerid == playerid) { SendErrorMessage(playerid," Ban khong the truy duoi chinh minh"); return 1; }
				if(PlayerInfo[giveplayerid][pTruyDuoi] > 0)
				{
					format(string, sizeof(string), "* Ban da duoc tron thoat do canh sat %s da mat dau cua ban", GetPlayerNameEx(playerid));
					SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Ban da dung truy duoi %s.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
					GameTextForPlayer(giveplayerid, "~y~Da dung truy duoi", 2500, 3);
					PlayerInfo[giveplayerid][pTruyDuoi] = 0;
					KillTimer(timetrd[giveplayerid]);
				}
				else SendClientMessageEx(playerid, COLOR_YELLOW, "Nguoi do khong bi truy duoi");
			}
			else
			{
				SendErrorMessage(playerid," Nguoi do khong o gan ban.");
				return 1;
			}
		}
		else
		{
			SendErrorMessage(playerid," Nguoi choi khong hop le.");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid," Ban khong phai nhan vien chinh phu");
	}
	return 1;
}
/*
CMD:sudungbanh(playerid, params[])
{
	if(GetPVarType(playerid, "PlayerCuffed") || GetPVarType(playerid, "Injured") || GetPVarType(playerid, "IsFrozen") || PlayerInfo[playerid][pHospital]) {
   		return SendClientMessage(playerid, COLOR_GRAD2, "Ban ko the lam dieu do vao luc nay!");
	}
	if(GetPVarInt(playerid, "IsInArena") >= 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong the lam dieu do khi dang o tai arena!");
		return 1;
	}
	if(PlayerInfo[playerid][pJailTime] > 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong the lam dieu nay trong khi O tu/Trai giam.");
		return 1;
	}
	if(PlayerBoxing[playerid] > 0)
	{
		SendErrorMessage(playerid," Ban ko the dung thuoc trong khi dang dau.");
		return 1;
	}
	if(UsedWeed[playerid] == 1)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "Ban can cho 5 giay truoc khi su dung them.");
		return 1;
	}
	if(GetPVarInt(playerid, "EventToken") != 0)
    {
    	SendErrorMessage(playerid," Ban khong the su dung lenh nay trong Su Kien.");
		return 1;
	}
	new string[128], loaidoan[32];

	if(sscanf(params, "s[32]", loaidoan))
	{
		SendUsageMessage(playerid, " /sudungbanh [loai thuc an]");
		format(string, sizeof(string), "Banhmi: %d, Hambuger: %d, Pizza: %d ",PlayerInfo[playerid][pBanhmi],PlayerInfo[playerid][pHambuger],PlayerInfo[playerid][pPizza]);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		return 1;
	}
	if(strcmp(loaidoan, "hambuger", true) == 0)
	{
		if(PlayerInfo[playerid][pHambuger] >= 1)
		{
            new Float:healthint;
            GetPlayerHealth(playerid, healthint);
			SetPVarInt(playerid, "CuocGoiAnimtion", 1);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SendErrorMessage(playerid," Ban da su dung mot Hambuger");
			format(string, sizeof(string), "* %s dang an mot Hambuger.", GetPlayerNameEx(playerid));
			ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        	PlayerInfo[playerid][pHambuger]-= 1;
        	ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
			if((healthint+7) < 98)
			{
				SetPlayerHealth(playerid, healthint + 7.0);
			}
			UsedWeed[playerid] = 1;
			SetTimerEx("ClearDrugs", 5000, false, "d", playerid);
			if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else
		{
			SendErrorMessage(playerid," Ban khong co Hambuger.");
			return 1;
		}
	}
	else if(strcmp(loaidoan, "pizza", true) == 0)
	{
		if(PlayerInfo[playerid][pPizza] >= 1)
		{
            new Float:healthint;
			GetPlayerHealth(playerid, healthint);
			
			SetPVarInt(playerid, "CuocGoiAnimtion", 1);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SendErrorMessage(playerid," Ban Da Su Dung Pizza");
			format(string, sizeof(string), "* %s dang an mot Pizza.", GetPlayerNameEx(playerid));
			ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        	PlayerInfo[playerid][pPizza]-= 1;
        	ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            if((healthint+7) < 98)
			{
				SetPlayerHealth(playerid, healthint + 7.0);
			}
			UsedWeed[playerid] = 1;
			SetTimerEx("ClearDrugs", 5000, false, "d", playerid);
			if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else
		{
			SendErrorMessage(playerid," Ban khong co Pizza.");
			return 1;
		}
	}
	else if(strcmp(loaidoan, "banhmi", true) == 0)
	{
		if(PlayerInfo[playerid][pBanhmi] >= 1)
		{
			new Float:healthint;
			GetPlayerHealth(playerid, healthint);
		
			SetPVarInt(playerid, "CuocGoiAnimtion", 1);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SendErrorMessage(playerid," Ban da su dung mot Banh Mi");
			format(string, sizeof(string), "* %s dang an mot Banh Mi.", GetPlayerNameEx(playerid));
			ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        	PlayerInfo[playerid][pBanhmi]-= 1;
        	ApplyAnimation(playerid,"FOOD","EAT_Burger",3.0,1,0,0,0,0,1);
            if((healthint+5) < 98)
			{
				SetPlayerHealth(playerid, healthint + 5.0);
			}

			UsedWeed[playerid] = 1;
			SetTimerEx("ClearDrugs", 5000, false, "d", playerid);
			if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else
		{
			SendErrorMessage(playerid," Ban khong co Banh Mi.");
			return 1;
		}
	}
	return 1;
}
CMD:ghepxe(playerid, params[])
{
	if(!vehicleCountCheck(playerid)) return SendErrorMessage(playerid," Kho xe da day, Ban khong the mua them xe duoc nua - Ban co the mua them slot xe cua ban thong qua /vstorage.");
	if(IsPlayerInRangeOfPoint(playerid, 5.0, -2026.7479,124.5131,29.1175))
	{
	    ShowPlayerDialog(playerid, GHEPXE, DIALOG_STYLE_MSGBOX, "GHEP XE","{FFFFFF}Ban co chac chan muon ghep xe\nTi le thanh cong: {ff1900}80%\n{FFFFFF}Chi phi: {ff1900}5 manh ghep xe", "Dong y", "Huy bo");
	}
	else SendClientMessage(playerid, COLOR_GRAD2, "Ban khong o dia diem ghep xe.");
	return 1;
}
forward GhepXe(playerid);
public GhepXe(playerid)
{
    SetPVarInt(playerid, "TimeGhepXe", GetPVarInt(playerid, "TimeGhepXe")-1);
    new string[128];
    format(string, sizeof(string), "Dang ghep xe %d giay", GetPVarInt(playerid, "TimeGhepXe"));
    GameTextForPlayer(playerid, string, 1100, 3);

    if(GetPVarInt(playerid, "TimeGhepXe") > 0) SetTimerEx("GhepXe", 700, 0, "d", playerid);

    if(GetPVarInt(playerid, "TimeGhepXe") <= 0)
    {
   	   new Float:posX, Float:posY, Float:posZ;
   	   GetPlayerPos(playerid, posX, posY, posZ);
       if(GhepxeFloats[playerid][0] != posX || GhepxeFloats[playerid][1] != posY || GhepxeFloats[playerid][2] != posZ)
       {
	   	   SendClientMessageEx(playerid, COLOR_YELLOW, "Ghep xe that bai ban da di chuyen, hay su dung '/ghepxe' de ghep lai");
 	       DeletePVar(playerid, "Move");
   	       return 1;
       }
       switch(random(100))
       {
 			case 0..20:
		 	{
				DeletePVar(playerid, "Move");
				DeletePVar(playerid, "TimeGhepXe");
    			format(string, sizeof(string), "~y~Da ghep xong");
				GameTextForPlayer(playerid, string, 5000, 3);
 				SendClientMessageEx(playerid, COLOR_WHITE,"Ghep xe that bai, ban bi mat 5 manh xe.");
				format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) da ghep xe that bai", GetPlayerNameEx(playerid), playerid);
				ABroadCast( COLOR_YELLOW, string, 2 );
		 		PlayerInfo[playerid][pManhxe] -= 5;
			}
			case 21..100:
			{
				switch(random(172))
				{
					case 0..50:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 468, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe Sanchez.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) ghep xe thanh cong, nhan duoc Sanchez.", GetPlayerNameEx(playerid), playerid);
						ABroadCast( COLOR_YELLOW, string, 2 );
					}
					case 51..90:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 422, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe Bobcab.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) ghep xe thanh cong, nhan duoc Bobcab.", GetPlayerNameEx(playerid), playerid);
						ABroadCast( COLOR_YELLOW, string, 2 );
					}
					case 91..120:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 589, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe Club.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) ghep xe thanh cong, nhan duoc Club.", GetPlayerNameEx(playerid), playerid);
						ABroadCast( COLOR_YELLOW, string, 2 );
					}
					case 121..140:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 461, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3], 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe PCJ-600.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) ghep xe thanh cong, nhan duoc PCJ-600.", GetPlayerNameEx(playerid), playerid);
						ABroadCast( COLOR_YELLOW, string, 2 );
					}
					case 141..150:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 469, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]+7, arr_fPlayerPos[3], 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec may bay Sparrow.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s (ID %d) ghep xe thanh cong, nhan duoc Sparrow.", GetPlayerNameEx(playerid), playerid);
						ABroadCast( COLOR_YELLOW, string, 2 );
					}
					case 151..161:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 560, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3]+5, 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe Sultan.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{33AA33}[{FFFFFF}GHEP XE{33AA33}]{FFFFFF} %s dung la thien tai, da ghep xe va nhan duoc xe Sultan.", GetPlayerNameEx(playerid));
						SendClientMessageToAll(COLOR_WHITE, string);
					}
					case 162..171:
					{
	    				DeletePVar(playerid, "Move");
					    DeletePVar(playerid, "TimeGhepXe");
					    PlayerInfo[playerid][pManhxe] -= 5;
						new Float: arr_fPlayerPos[4];
						GetPlayerPos(playerid, arr_fPlayerPos[0], arr_fPlayerPos[1], arr_fPlayerPos[2]);
						GetPlayerFacingAngle(playerid, arr_fPlayerPos[3]);
						CreatePlayerVehicle(playerid, GetPlayerFreeVehicleId(playerid), 522, arr_fPlayerPos[0]+2, arr_fPlayerPos[1], arr_fPlayerPos[2], arr_fPlayerPos[3]+5, 0, 0, 2000000, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
						SendClientMessageEx(playerid, COLOR_GREEN, "Ban ghep xe thanh cong, nhan duoc 1 chiec xe NRG-500.");
						format(string, sizeof(string), "~y~Da ghep xong");
						GameTextForPlayer(playerid, string, 5000, 3);
						format(string, sizeof(string), "{33AA33}[{FFFFFF}GHEP XE{33AA33}]{FFFFFF} %s dung la thien tai, da ghep xe va nhan duoc xe NRG-500.", GetPlayerNameEx(playerid));
						SendClientMessageToAll(COLOR_WHITE, string);
					}
				}
			}
  		}
	}
	return 1;
}
*/
CMD:finegcoin(playerid, params[])
{
	new string[128], giveplayerid, amount, reason[64];
	if(sscanf(params, "uds[64]", giveplayerid, amount, reason)) return SendUsageMessage(playerid, " /finegcoin [player] [amount] [reason]");

	if (PlayerInfo[playerid][pAdmin] >= 3)
	{
		if(IsPlayerConnected(giveplayerid))
		{
			if (amount < 1)
			{
				SendClientMessageEx(playerid, COLOR_GRAD2, "Amount must be greater than 0");
				return 1;
			}
			format(string, sizeof(string), "AdmCmd: %s da tru $%s Gcoin boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), number_format(amount), GetPlayerNameEx(playerid), reason);
			Log("logs/admin.log", string);
			format(string, sizeof(string), "AdmCmd: %s da tru $%s Gcoin boi %s, ly do: %s", GetPlayerNameEx(giveplayerid), number_format(amount), GetPlayerNameEx(playerid), reason);
			SendClientMessageToAllEx(COLOR_LIGHTRED, string);
			PlayerInfo[playerid][pGcoin] -= amount;
			return 1;
		}
		else SendClientMessageEx(playerid, COLOR_GRAD1, "Nguoi choi khong hop le.");
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "You're not a level three admin.");
	}
	return 1;
}
CMD:makiemsoat(playerid,params[])
{

    new
    veh = GetPlayerVehicleID(playerid);
    if (0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS)
    {
        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            if (isnull(params)) return SendUsageMessage(playerid, " /makiemsoat [noidung]");
            if (!veicolo_callsign_status[veh])
            {

                new string[128];
                format(string, sizeof(string), "%s",params);
                veicolo_callsign_testo[veh] = Create3DTextLabel(string, 0xFFFFFFFF, 0.0, 0.0, 0.0, 50.0, 0, 1);
                new szEmployer[GROUP_MAX_NAME_LEN], szRank[GROUP_MAX_RANK_LEN], szDivision[GROUP_MAX_DIV_LEN];
                GetPlayerGroupInfo(playerid, szRank, szDivision, szEmployer);
                if(arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == 1)
                {
                    new idveh[10];
                    format(idveh, 10, "%d", GetPlayerVehicleID(playerid));
                    SendLogToDiscordRoom4(string ,"1158002044381188188", "Name", GetPlayerNameEx(playerid, false), "Rank", szRank, "Division", szDivision, "ID Veh", idveh, 0x226199);
                }
                else if(arrGroupData[PlayerInfo[playerid][pMember]][g_iGroupType] == 3)
                {
                    new idveh[10];
                    format(idveh, 10, "%d", GetPlayerVehicleID(playerid));
                    SendLogToDiscordRoom4(string ,"1158006184347963432", "Name", GetPlayerNameEx(playerid, false), "Rank", szRank, "Division", szDivision, "ID Veh", idveh, 0x226199);
                }
                format(string, sizeof(string), " %s su dung ma kiem soat: %s ", GetPlayerNameEx(playerid), string);
                foreach (new i: Player)
                {
                    new iRank = PlayerInfo[playerid][pRank];
                    if (PlayerInfo[i][pMember] == PlayerInfo[playerid][pMember] && iRank >= arrGroupData[PlayerInfo[playerid][pMember]][g_iRadioAccess])
                    {
                        SendClientMessageEx(i, arrGroupData[PlayerInfo[playerid][pMember]][g_hRadioColour] * 256 + 255, string);
                    }
                    if (GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == PlayerInfo[playerid][pMember])
                    {
                        new szBigEar[128];
                        format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
                        SendClientMessageEx(i, arrGroupData[PlayerInfo[playerid][pMember]][g_hRadioColour] * 256 + 255, szBigEar);
                    }
                }
                Attach3DTextLabelToVehicle(veicolo_callsign_testo[veh], veh, -0.7, -1.9, -0.3);
                veicolo_callsign_status[veh] = 1;
            }
            else
            {
                Delete3DTextLabel(veicolo_callsign_testo[veh]);
                veicolo_callsign_status[veh] = 0;
                return 1;
            }
        }
        else return SendErrorMessage(playerid, " Ban khong o tren xe de su dung lenh nay");
    }
    else return SendErrorMessage(playerid, " Ban khong the su dung lenh nay");
    return 1;
}
CMD:xoamakiemsoat(playerid,params[])
{
    new veh = GetPlayerVehicleID(playerid);
    if (0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS)
	{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        if(veicolo_callsign_status[veh])
		{
        new string[128];
        format(string, sizeof(string), " %s Da xoa ma kiem soat ", GetPlayerNameEx(playerid));
        foreach(new i: Player)
					{
                            new iRank = PlayerInfo[playerid][pRank];
							if(PlayerInfo[i][pMember] == PlayerInfo[playerid][pMember] && iRank >= arrGroupData[PlayerInfo[playerid][pMember]][g_iRadioAccess]) {
								SendClientMessageEx(i, arrGroupData[PlayerInfo[playerid][pMember]][g_hRadioColour] * 256 + 255, string);
							}
							if(GetPVarInt(i, "BigEar") == 4 && GetPVarInt(i, "BigEarGroup") == PlayerInfo[playerid][pMember]) {
								new szBigEar[128];
								format(szBigEar, sizeof(szBigEar), "(BE) %s", string);
								SendClientMessageEx(i, arrGroupData[PlayerInfo[playerid][pMember]][g_hRadioColour] * 256 + 255, szBigEar);
							}
					}
        Delete3DTextLabel(veicolo_callsign_testo[veh]);
        veicolo_callsign_status[veh] = 0;
        }
        else return SendErrorMessage(playerid," Ban khong su dung ma kiem soat nao");
    }
    else return SendErrorMessage(playerid," Ban khong co o tren xe");
    }
    else return SendErrorMessage(playerid," Ban khong the su dung lenh nay");
    return 1;
}


/*
CMD:laygps(playerid, params[])
{
	PlayerInfo[playerid][pGPS] += 1;
}
*/
CMD:toglichsu(playerid, params[])
{
    if(InfoMessage[playerid] == false)
    {
        SendClientMessageEx(playerid, COLOR_WHITE, "*** Ban da bat lich su chien dau ( /toglichsu lan nua de tat )***");

        InfoMessage[playerid] = true;
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_WHITE, "*** Ban da tat lich su chien dau ( /toglichsu lan nua de bat )***");

        InfoMessage[playerid] = false;
    }
    return 1;
}
stock JoinGame(playerid) {
    OnPlayerLoad(playerid);
    HideRegCharTD(playerid);
    PlayerHasNationSelected[playerid] = 1;
    TextDrawHideForPlayer(playerid,txtNationSelHelper);
    TextDrawHideForPlayer(playerid,txtNationSelMain);
    TextDrawHideForPlayer(playerid,txtSanAndreas);
    TextDrawHideForPlayer(playerid,txtTierraRobada);
    RegistrationStep[playerid] = 0;
    PlayerInfo[playerid][pTut] = 1;
    gOoc[playerid] = 0; gNews[playerid] = 0; gFam[playerid] = 0;
    TogglePlayerControllable(playerid, 1);
    SetCamBack(playerid);
    DeletePVar(playerid, "MedicBill");
    SetPlayerColor(playerid,TEAM_HIT_COLOR);
    DeletePVar(playerid,"DangTaoAcc");
    SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
    SetCameraBehindPlayer(playerid);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    TextDrawHideForPlayer(playerid, BannerServer[1]);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);
    SetPlayerInterior(playerid,0);
    Streamer_UpdateEx(playerid,1355.6627, 259.0992, 19.5547);
    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pModel], 1355.6627, 259.0992, 19.5547, 1.0, -1, -1, -1, -1, -1, -1);
    SetPlayerPos(playerid, 1355.6627,259.0992, 19.5547);
    Player_StreamPrep(playerid, 1355.6627, 259.0992, 19.5547, FREEZE_TIME);
    SetPlayerFacingAngle(playerid, 247.5060);
    
    ClearChatbox(playerid);
    SendClientMessageEx(playerid,COLOR_VANG,"Chao mung ban da den voi may chu RC-RP.");
    //  SendClientMessageEx(playerid,COLOR_VANG,"(HUONG DAN) Hay di vao Market tim cua hang dien tu mua mot cai GPS nhe.");
    return 1;
}
CMD:vwcuatao(playerid, params[]) {
	printf("vw cua may la %d",GetPlayerVirtualWorld(playerid));
	return 1;
}
/*
CMD:hihi(playerid, params[]) return   SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);

forward UpdateTK(playerid);
public UpdateTK(playerid) {
	new namez[24],bank;
	new rows = cache_num_rows();
	if(rows)
    {
        for(new i=0; i<rows; i++)
        {   
    	    cache_get_field_content(i, "UserName", namez, MainPipeline, 24);
    	    bank = cache_get_field_content_int(i, "Bank", MainPipeline);
            bank += GetPVarInt(playerid, "TienGD");
            PlayerInfo[playerid][pAccount] -= GetPVarInt(playerid, "TienGD") + ( GetPVarInt(playerid, "TienGD") / 100);
		    new string[129];
		    format(string, sizeof(string), "UPDATE accounts SET `Bank`=%d WHERE `SoTaiKhoan` = %d", bank, GetPVarInt(playerid, "STK"));
		    mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "ii", SENDDATA_THREAD, playerid);		
        }
    }
    else 
    {
    	ShowPlayerDialog(playerid, DIALOG_CHUYENTIEN, DIALOG_STYLE_INPUT, "Chuyen tien", "So tai khoan khong ton tai !\nVui long nhap so tai khoan de tiep tuc giao dich", "Tuy chon", "Thoat");	    	
    }
}
forward STK_check(playerid);
public STK_check(playerid) {
	new namez[24],stk;
	new rows = cache_num_rows();
    printf("rows %d ", rows);
    if(rows)
    {
        for(new i=0; i<rows; i++)
        {   
    	    cache_get_field_content(i, "UserName",  namez, MainPipeline, 24);
            printf("name load duoc la :v %s", namez);
    	    stk = cache_get_field_content_int(i, "SoTaiKhoan", MainPipeline);
            SetPVarString(playerid, "_NguoiNhan", namez);
		    SetPVarInt(playerid, "Offline", 1);
		    SetPVarInt(playerid, "STK", stk);
		    new string[129];
		    format(string, sizeof string, "Ten chu the\t\t\t\t%s\nSo tai khoan\t\t\t\t%d\nBan hay nhap so tien muon giao dich o ben duoi", namez,stk);
		    ShowPlayerDialog(playerid, DIALOG_CHUYENTIEN1, DIALOG_STYLE_INPUT, "Chuyen tien", string, "Tuy chon", "Thoat");
        }
    }
    else {
 		ShowPlayerDialog(playerid, DIALOG_CHUYENTIEN, DIALOG_STYLE_INPUT, "Chuyen tien", "So tai khoan khong ton tai !\nVui long nhap so tai khoan de tiep tuc giao dich", "Tuy chon", "Thoat");	    	
    }
}
*/
CMD:atm(playerid, params[]) {
	if(!IsAtATM(playerid))
	{
		SendErrorMessage(playerid," Ban khong o gan ATM!");
		return 1;
	}
	if(PlayerInfo[playerid][pSoTaiKhoan] < 100) return ShowPlayerDialog(playerid,DIALOG_NOTHING,DIALOG_STYLE_MSGBOX,"Tai khoan ngan hang","Ban chua dang ky tai khoan ngan hang khong the su dung...","Dong y","Huy bo");
	new ti[42],string[230];
	format(ti, sizeof ti, "Tai khoan ngan hang cua %s", GetPlayerNameEx(playerid));
	format(string, sizeof string, "Ten chu the\t\t\t\t{8b3721}%s{ffffff}\nSo tai khoan\t\t\t\t{eae000}%d{ffffff}\nSo du trong vi\t\t\t\t{289c59}$%s{ffffff}\n___________________\nChuyen tien\nGui tien\nRut tien", GetPlayerNameEx(playerid),PlayerInfo[playerid][pSoTaiKhoan],number_format(PlayerInfo[playerid][pAccount]));
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, ti, string, "Tuy chon", "Thoat");
	return 1;
}
CMD:bank(playerid, params[]) {
	if(!IsPlayerInRangeOfPoint(playerid, 15.0, 2308.7346, -11.0134, 26.7422))
	{
		SendErrorMessage(playerid," Ban khong o trong ngan hang!");
		return 1;
	}
	if(PlayerInfo[playerid][pSoTaiKhoan] < 100) return ShowPlayerDialog(playerid,DANGKYBANK,DIALOG_STYLE_MSGBOX,"Tai khoan ngan hang","Ban chua co tai khoan ngan hang khong the su dung,ban co muon dang ky khong\nPhi dang ky: Mien phi","Dang ky","Huy bo");
	new ti[42],string[230];
	format(ti, sizeof ti, "Tai khoan ngan hang cua %s", GetPlayerNameEx(playerid));
	format(string, sizeof string, "Ten chu the\t\t\t\t{8b3721}%s{ffffff}\nSo tai khoan\t\t\t\t{eae000}%d{ffffff}\nSo du trong vi\t\t\t\t{289c59}$%s{ffffff}\n___________________\nChuyen tien\nGui tien\nRut tien", GetPlayerNameEx(playerid),PlayerInfo[playerid][pSoTaiKhoan],number_format(PlayerInfo[playerid][pAccount]));
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, ti, string, "Tuy chon", "Thoat");
	return 1;
}
CMD:datthung(playerid,params[]) {
	if(PlayerInfo[playerid][pHop] < 1) return SendErrorMessage(playerid," Ban khong co hop trai cay");
    if(PlayerInfo[playerid][pJob] != 22 && PlayerInfo[playerid][pJob2] != 22) return SendErrorMessage(playerid," Ban khong phai la nguoi Hai Trai Cay.");
    new Float:Pos[3],string[129];
    GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
    PlayerInfo[playerid][pObjHop] = CreateDynamicObject(19638, Pos[0],Pos[1],Pos[2]-1, 0,0,0,10); // tao ra hop
    format(string ,sizeof string, "Thung cam cua %s\nSo cam trong thung: %d/50\n(( Bam Y de bo cam vao thung ))", GetPlayerNameEx(playerid),PlayerInfo[playerid][pTraiCamHop]);
    PlayerInfo[playerid][HopText] = CreateDynamic3DTextLabel(string, 0xa5bbd0FF, Pos[0],Pos[1],Pos[2]-1, 10, 0, 0);
    PlayerInfo[playerid][pPosHop][0] = Pos[0];
    PlayerInfo[playerid][pPosHop][1] = Pos[1];
    PlayerInfo[playerid][pPosHop][2] = Pos[2];
    PlayerInfo[playerid][pHop] = 0;
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, 1);
    return 1;
}

CMD:layhopz(playerid,params[]) return PlayerInfo[playerid][pHop] = 1;
CMD:laythung(playerid,params[]) {
	if(GetPVarInt(playerid,"CamHop") == 1) return  SendErrorMessage(playerid," Khong the thao tac.");
	if(!IsPlayerInRangeOfPoint(playerid, 2, PlayerInfo[playerid][pPosHop][0],PlayerInfo[playerid][pPosHop][1],PlayerInfo[playerid][pPosHop][2])) return SendClientMessage(playerid, -1, "Ban khong o gan hop cam cua ban");
    DestroyDynamicObject(PlayerInfo[playerid][pObjHop]);
    DestroyDynamic3DTextLabel(PlayerInfo[playerid][HopText]);
    SetPlayerAttachedObject(playerid, 1, 19638, 4,0.339,  -0.421999,  0.145,  1.2,  -98.9,  82.5, 1,  1,  1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPVarInt(playerid,"CamHop",1);
    PlayerInfo[playerid][pHop] = 1;
    PlayerInfo[playerid][pPosHop][0] = -1;
    PlayerInfo[playerid][pPosHop][1] = -1;
    PlayerInfo[playerid][pPosHop][2] = -1;
    return 1;
}
CMD:haitraicay(playerid,params[]) {
	if(GetPVarInt(playerid,"CamHop") == 1) return  SendErrorMessage(playerid," Khong the thao tac.");
    if(PlayerInfo[playerid][pJob] != 22 && PlayerInfo[playerid][pJob2] != 22) {
        SendErrorMessage(playerid," Ban khong phai la nguoi Hai Trai Cay.");
        return 1;
    }
    if(GetPVarInt(playerid, "DangHaiTr") == 1) return SendClientMessage(playerid, -1, "Ban dang hai trai cay roi");
    if(PlayerInfo[playerid][pTraiCam] == 1) return SendClientMessage(playerid, -1, "Ban khong the hai tiep nua");
    if(IsPlayerInRangeOfPoint(playerid, 10, 1937.7081,196.7023,33.2101)) {
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("DangHaiTr", 10000, false,"d",playerid);
	SetPVarInt(playerid, "IsFrozen", 1);
	SetPVarInt(playerid, "DangHaiTr", 1);
	GameTextForPlayer(playerid, "~w~Dang Hai Trai Cay", 10000, 3);
	ApplyAnimation(playerid, "BD_FIRE", "wash_up",4.0,1,0,0,0,0,1);
    }
    return 1;
}

CMD:adsadsbotraicay(playerid, params[]) {
	if(GetPVarInt(playerid,"CamHop") == 1) return  SendErrorMessage(playerid," Khong the thao tac.");
    if(PlayerInfo[playerid][pJob] != 22 && PlayerInfo[playerid][pJob2] != 22) {
        SendErrorMessage(playerid," Ban khong phai la nguoi Hai Trai Cay.");
    }
   // if(gettime() < PlayerInfo[playerid][pServiceTime]) return SendClientMessage(playerid, COLOR_WHITE, "Ban phai cho 5 giay truoc khi su dung lenh nay mot lan nua.");
   // PlayerInfo[playerid][pServiceTime] = gettime()+5;
    if(PlayerInfo[playerid][pTraiCam] < 1) return SendClientMessage(playerid, -1, "Ban khong co trai cam nao");
    if(PlayerInfo[playerid][pTraiCamHop] > 49) return SendClientMessage(playerid, -1, "Hop cua ban da day trai cay");
    new string[129];
    if(!IsPlayerInRangeOfPoint(playerid, 2, PlayerInfo[playerid][pPosHop][0],PlayerInfo[playerid][pPosHop][1],PlayerInfo[playerid][pPosHop][2])) return SendClientMessage(playerid, -1, "Ban khong o gan hop cam cua ban");
    PlayerInfo[playerid][pTraiCam] -= 1;
    PlayerInfo[playerid][pTraiCamHop] += 1;
    RemovePlayerAttachedObject(playerid, 1);
    format(string ,sizeof string, "Thung cam cua %s\nSo cam trong thung: %d/50\n(( Bam Y de bo cam vao thung ))", GetPlayerNameEx(playerid),PlayerInfo[playerid][pTraiCamHop]);
    ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.0,0,0,0,0,0,1);
    UpdateDynamic3DTextLabelText( PlayerInfo[playerid][HopText], 0xa5bbd0FF, string);
    return 1;
}
forward DangHaiTr(playerid);
public DangHaiTr(playerid) {
    PlayerInfo[playerid][pTraiCam] += 1; //
    DeletePVar(playerid, "DangHaiTr");
    DeletePVar(playerid, "IsFrozen");
    TogglePlayerControllable(playerid, 1);
    SetPlayerAttachedObject(playerid, 1, 19574, 6,0.037,	0.063,	0.02,	0,	0,	0,	1,	1.247,	1.127);
	SendClientMessageEx(playerid, COLOR_YELLOW, "Ban da hai trai cay xong.");
    return 1;
}

CMD:my(playerid, params[])
{
    new choice[32];
    if(sscanf(params, "s[32]", choice))
    {
        SendUsageMessage(playerid, " /my [name]");
        SendUsageMessage(playerid, "inv, car, gun, coin, stats, item, giayto");
        return 1;
    }

    if(strcmp(choice,"car",true) == 0) {
        cmd_chinhxe(playerid,"");
    }
    else if(strcmp(choice,"cmnd",true) == 0) {
        if(PlayerInfo[playerid][pCMND] < 10) return SendErrorMessage(playerid," Ban khong co CMND");
        ShowCMND(playerid,playerid); 
    }
    else if(strcmp(choice,"gun",true) == 0) {
        cmd_myguns(playerid,"");
    }
    else if(strcmp(choice,"stats",true) == 0) {
        cmd_thongtin(playerid,"");
    }
    else if(strcmp(choice,"stats",true) == 0) {
        cmd_credits(playerid,"");
    }
    // else if(strcmp(choice,"inventory",true) == 0) {
    //     if(IsPlayerAndroid(playerid)) {
    //         ShowPlayerInventoryDialog(playerid);
    //         return 1;
    //     }
    //     else {
    //         cmd_invz(playerid,"");
    //     }
    // }
    // else if(strcmp(choice,"inv",true) == 0) {
    //     if(IsPlayerAndroid(playerid)) {
    //         ShowPlayerInventoryDialog(playerid);
    //         return 1;
    //     }
    //     else {
    //         cmd_invz(playerid,"");
    //     }
    // }
    else if(strcmp(choice,"giaytoxe",true) == 0) {
        new vstring[1000], icount = GetPlayerVehicleSlots(playerid);
        for(new i, iModelID; i < icount; i++)
        {
            if((iModelID = PlayerVehicleInfo[playerid][i][pvModelId] - 400) >= 0)
            {
                format(vstring, sizeof(vstring), "%s\n[%d]%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID]);    
            }       
        }
        if(isnull(vstring))
        { 
            ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Kho phuong tien", "Khong co phuong tien!", "Chon", "Thoat");
            return 1;
        }
        ShowPlayerDialog(playerid, XENGIAYXE, DIALOG_STYLE_LIST, "Kho phuong tien", vstring, "Chon", "Huy bo");
    }
    else if(strcmp(choice,"giayto",true) == 0) {
        ShowPlayerDialog(playerid, XEMGIAYTO, DIALOG_STYLE_LIST, "Giay to tuy than", "CMND\nGiay to xe\nBang lai xe", "Chon", "Huy bo");
    }
  /*  else if(strcmp(choice,"Item",true) == 0) {
        cmd_invzz(playerid,"");
    }
    */
    else if(strcmp(choice,"lincense",true) == 0) {
        new string[260], text1[50], text2[50], text3[50], text4[50];
        if(PlayerInfo[playerid][pCarLic]) { text1 = "{5db278}Da dang ky{ffffff}"; } else { text1 = "{b45151}Chua dang ky{ffffff}"; }
        if(PlayerInfo[playerid][pFlyLic]) { text4 = "{5db278}Da dang ky{ffffff}"; } else { text4 = "{b45151}Chua dang ky{ffffff}"; }
        if(PlayerInfo[playerid][pBoatLic]) { text2 = "{5db278}Da dang ky{ffffff}"; } else { text2 = "{b45151}Chua dang ky{ffffff}"; }
        if(PlayerInfo[playerid][pTaxiLicense]) { text3 = "{5db278}Da dang ky{ffffff}"; } else { text3 = "{b45151}Chua dang ky{ffffff}"; }
        format(string, sizeof(string), "{ffffff}Giay to cua ban \n\
            Giay phep lai xe: %s \n\
            Giay phep may bay: %s \n\
            Giay phep thuyen: %s \n\
            Giay phep taxi: %s", text1,text4,text2,text3);
        ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Giay phep", string, "Chon", "Huy bo");
    }
    return 1;
}


CMD:menu(playerid,params[]) {
	ShowPlayerDialog(playerid, DIALOG_MAIN_MENU, DIALOG_STYLE_LIST, "Menu Action", "Action\nCai dat", "Chon", "Huy bo");
	return 1;
}

CMD:xemthue(playerid, params[]) {
	if(!IsACop(playerid)) return SendClientMessageEx(playerid,COLOR_WHITE,"Ban khong phai la canh sat");
	new str[300];
	str = "Ten Biz\tChu so huu\tThue dang no";
	for(new i = 0; i < sizeof(Businesses); i++)
	{
	    if (Businesses[i][bNoThue] >= 1)
	    {
	        format(str, sizeof str, "%s\n\%s\t%s\t%s", str,Businesses[i][bName],Businesses[i][bOwnerName],number_format(Businesses[i][bNoThue] ));	
	    }
    }
    ShowPlayerDialog(playerid, DIALOG_STYLE_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Danh sach doanh nghiep no thue", str, "Chon", "Huy bo");
    return 1;
}

CMD:phone(playerid,params[]) return ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST, "Phone - Main", "Goi dien\nNhan tin\nLog SMS\nDanh ba\nChuyen tien", "Chon", "Huy bo");
CMD:dangkycmnd(playerid,params[]) {
    new string[129];
    if(!IsPlayerInRangeOfPoint(playerid, 5, 359.7139,173.6452,1008.3893)) return SendErrorMessage(playerid," Ban khong o gan city hall khong the dang ky CMND.");
    if(PlayerInfo[playerid][pCMND] < 10) {
        new cmnd;
        cmnd = 10000000 + random(99999999);
        PlayerInfo[playerid][pCMND] = cmnd;
        format(string,sizeof(string),"Ban da dang ky CMND thanh cong, so CMND la: {edee67}%d{FFFFFF} (/my 'cmnd' de xem)",cmnd);
        SendClientMessageEx(playerid,-1,string);
    }
    return 1;
}
stock ShowCMND(playerid,giveplayerid) {
    new sonha[100],string[229];
    sonha = "Khong co";
    if( PlayerInfo[giveplayerid][pPhousekey] != INVALID_HOUSE_ID )
    {
        new h = PlayerInfo[giveplayerid][pPhousekey], zone[50];
        Get3DZone(HouseInfo[h][hExteriorX], HouseInfo[h][hExteriorY], HouseInfo[h][hExteriorZ],zone, sizeof(zone));
        format(sonha,sizeof(sonha),"%d %s San Andreas",PlayerInfo[giveplayerid][pPhousekey],zone);
    }
    
    format(string,sizeof(string),"\\c    Thong tin CMND\n\
        \\c   So CMND: %d\n\
        \\c   Ho va ten: %s\n\
        \\c   Ngay thang nam sinh: %s\n\
        \\c   Quoc tich: San Andreas\n\
        \\cDia chi nha: %s",PlayerInfo[giveplayerid][pCMND],GetPlayerNameEx(giveplayerid),PlayerInfo[giveplayerid][pBirthDate],sonha);
    ShowPlayerDialog(playerid,DIALOG_NOTHING,DIALOG_STYLE_MSGBOX,"Thong tin CMND",string,"Dong","");
    return 1;
}


stock g_mysql_AccountAuthCheck(playerid)
{
        new string[128];
        format(string, sizeof(string), "SELECT * FROM masterdb WHERE acc_name = '%s'", GetPlayerNameExt(playerid));
//      mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", AUTH_THREAD, playerid, g_arrQueryHandle{playerid});
        mysql_tquery(MainPipeline, string, "AUTH_TH", "d", playerid);
        ClearChatbox(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
}
forward AUTH_TH(playerid);
public AUTH_TH(playerid) {
    new rows, fields, tmp[128];
    cache_get_data(rows, fields, MainPipeline);
    for(new i;i < rows;i++)
    {
        cache_get_field_content(i, "acc_name", MasterInfo[playerid][acc_name], MainPipeline, MAX_PLAYER_NAME);
        cache_get_field_content(i, "acc_pass", MasterInfo[playerid][acc_pass], MainPipeline, 61);
        cache_get_field_content(i, "acc_lastlogin", MasterInfo[playerid][acc_lastlogin], MainPipeline, 24);
        cache_get_field_content(i, "acc_regidate", MasterInfo[playerid][acc_regidate], MainPipeline, 24);
        cache_get_field_content(i, "acc_id", tmp, MainPipeline); MasterInfo[playerid][acc_id] = strval(tmp);
        cache_get_field_content(i, "IsConfirm", tmp, MainPipeline); MasterInfo[playerid][acc_confirm] = strval(tmp);
        if(MasterInfo[playerid][acc_confirm] != 1)
        {
            SafeLogin(playerid, 1);
            return 1;
        }
        if(strcmp(MasterInfo[playerid][acc_name], GetPlayerNameExt(playerid), true) == 0)
        {
                HideNoticeGUIFrame(playerid);
                SafeLogin(playerid, 1);
                return 1;
        }
        else
        {
                return 1;
        }
    }
    HideNoticeGUIFrame(playerid);
    SafeLogin(playerid, 2);
    return 1;
}

CMD:bb(playerid, params[]) {
    return cmd_beanbag(playerid, params);
}
CMD:nbp(playerid, params[]) {
    return cmd_nobackup(playerid, params);
}
CMD:td(playerid, params[]) {
    return cmd_truyduoi(playerid, params);
}
CMD:tz(playerid, params[]) {
    return cmd_tazer(playerid, params);
}
CMD:khongche(playerid, params[]) {
    return cmd_tackle(playerid, params);
}
CMD:kc(playerid, params[]) {
    return cmd_tackle(playerid, params);
}
CMD:beanbag(playerid, params[])
{
    if(!IsACop(playerid)) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong phai la canh sat de su dung lenh nay.");

    if(GetPlayerWeapon(playerid) == 25)
    {
        new string[128];
        if(GetPVarInt(playerid, "pBeanBag") >= 1)
        {
            format(string, sizeof string, "{FF8000}* {C2A2DA}%s loads their shotgun with live action rounds.", GetPlayerNameEx(playerid));
            SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);
            format(string, sizeof string, "{FF8000}> {C2A2DA}%s loads their shotgun with live action rounds.", GetPlayerNameEx(playerid));
            SendClientMessage(playerid, COLOR_PURPLE, string);

            DeletePVar(playerid, "pBeanBag");
        }
        else
        {
            format(string, sizeof string, "{FF8000}* {C2A2DA}%s loads their shotgun with beanbag rounds.", GetPlayerNameEx(playerid));
            SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 6000);
            format(string, sizeof string, "{FF8000}> {C2A2DA}%s loads their shotgun with beanbag rounds.", GetPlayerNameEx(playerid));
            SendClientMessage(playerid, COLOR_PURPLE, string);

            SetPVarInt(playerid, "pBeanBag", 1);
        }
    }
    else SendClientMessageEx(playerid, COLOR_GREY, "Ban can cam shotgun tren tay!");
    return 1;
}
