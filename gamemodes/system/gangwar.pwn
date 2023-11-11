#include <YSI_Coding\y_hooks>
#define MAX_TURF 9 
#define DIALOG_DIABAN 15123

#define DIALOG_RUTTIENDB 15124
enum Turf {
	Float:TurfZone[3],
	TurfName[50],
	TurfID,
	TurfIsWarning,
	TurfFamilyWarning,
	TurfType,
	Float:TurfKhoangCach,
	TurfPickUP,
	TurfTime,
	TurfCountTime,
	TurfCash,
	TurfLast,
	TurfOwnerID = INVALID_FAMILY_ID,
	Text3D:TurfLabel
}

new Turf_Info[MAX_TURF][Turf];
new IsWarning[MAX_PLAYERS] = 0;
new DCC_Channel:diaban;



stock SaveDiaBan(diabanid) {
    new query[300];
    format(query, sizeof(query), "UPDATE `diaban` SET");
    format(query, sizeof(query), "%s `TurfLast` = '%d', `TurfID` = '%d', `TurfName` =  '%s', `TurfType` = '%d', `TurfKhoangCach` = '%f', `TurfCash` = '%d', `TurfOwnerID` = '%d', `TurfZone0` = '%f', `TurfZone1` = '%f', `TurfZone2` = '%f'", query,
    Turf_Info[diabanid][TurfLast],  Turf_Info[diabanid][TurfID],Turf_Info[diabanid][TurfName],Turf_Info[diabanid][TurfType],Turf_Info[diabanid][TurfKhoangCach],Turf_Info[diabanid][TurfCash], 
     Turf_Info[diabanid][TurfOwnerID],Turf_Info[diabanid][TurfZone][0],Turf_Info[diabanid][TurfZone][1],Turf_Info[diabanid][TurfZone][2]);
    format(query, sizeof(query), "%s WHERE `TurfID` = %d", query, diabanid);
    mysql_function_query(MainPipeline, query, false, "OnQueryFinish", "ii", SENDDATA_THREAD, INVALID_PLAYER_ID);
    return 1;
}
stock SaveDiaBans() {
    for(new i = 1; i < MAX_TURF; i++) {
        SaveDiaBan(i);
    }
}
stock LoadDiaBan()
{
    printf("[ca] Loading data from database...");
    mysql_function_query(MainPipeline, "SELECT * FROM `diaban`", true, "DiaBanLoadQuery", "");
}


forward DiaBanLoadQuery();
public DiaBanLoadQuery()
{
    new i, rows, fields, szResult[24], string[128];
    cache_get_data(rows, fields, MainPipeline);

    while(i < rows)
    {
        cache_get_field_content(i, "TurfName", Turf_Info[i][TurfName], MainPipeline, 64);
        cache_get_field_content(i, "TurfID", szResult, MainPipeline); Turf_Info[i][TurfID] = strval(szResult);
        cache_get_field_content(i, "TurfType", szResult, MainPipeline); Turf_Info[i][TurfType] = strval(szResult);
        cache_get_field_content(i, "TurfKhoangCach", szResult, MainPipeline); Turf_Info[i][TurfKhoangCach] = floatstr(szResult);
        cache_get_field_content(i, "TurfLast", szResult, MainPipeline); Turf_Info[i][TurfLast] = strval(szResult);
        cache_get_field_content(i, "TurfCash", szResult, MainPipeline); Turf_Info[i][TurfCash] = strval(szResult);
        cache_get_field_content(i, "TurfOwnerID", szResult, MainPipeline); Turf_Info[i][TurfOwnerID] = strval(szResult);
        cache_get_field_content(i, "TurfZone0", szResult, MainPipeline); Turf_Info[i][TurfZone][0] = floatstr(szResult);
        cache_get_field_content(i, "TurfZone1", szResult, MainPipeline); Turf_Info[i][TurfZone][1] = floatstr(szResult);
        cache_get_field_content(i, "TurfZone2", szResult, MainPipeline); Turf_Info[i][TurfZone][2] = floatstr(szResult);

        if(Turf_Info[i][TurfID] != 0) {
            if(Turf_Info[i][TurfOwnerID] != INVALID_FAMILY_ID) {
                format(string, sizeof string, "Dia ban: %s\nFamily dang chiem dong: %s",  Turf_Info[i][TurfName],FamilyInfo[Turf_Info[i][TurfOwnerID]][FamilyName]);
            }
            else {
                format(string, sizeof string, "Dia ban: %s\nFamily dang chiem dong: Chua co",  Turf_Info[i][TurfName]);

            }

            Turf_Info[i][TurfPickUP] = CreateDynamicPickup(1575, 1,Turf_Info[i][TurfZone][0],Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2]);
            Turf_Info[i][TurfLabel] = CreateDynamic3DTextLabel(string, -1,Turf_Info[i][TurfZone][0],Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2],100); 
        }
        i++;
    }
    if(i > 0) printf("[LoadDiaBan] %d tai dia ban.", i);
    else printf("[LoadDiaBan] Khong the tai vi tri db.");
}

hook OnGameModeInit()
{
	LoadDiaBan();
}
hook OnGameModeExit()
{
	SaveDiaBans();
}
forward ffff(sfas);
public ffff(sfas) {
	print("1");
}

stock GetTypeDiaBan(type) {
	new typetext[32];
	switch(type) {
		case 0: {

		}
		case 1: typetext = "Dia ban Pizza";
		case 2: typetext = "Dia ban Trucker";
	}
	return typetext;
}
CMD:creatediaban(playerid,params[]) {
	new turfname[53],turftype = 0, dristance,string[129];
	if(sscanf(params, "dds[53]", turftype,dristance,turfname))
		return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /creatediaban [type] [khoang cach] [ten]");

    for(new i = 1 ; i < MAX_TURF; i++) {
    	if(Turf_Info[i][TurfID] == 0) {
    		Turf_Info[i][TurfID] = i;
    		Turf_Info[i][TurfType] = turftype;
    		Turf_Info[i][TurfKhoangCach] = dristance;
    		Turf_Info[i][TurfOwnerID] = INVALID_FAMILY_ID;
    		format(Turf_Info[i][TurfName] , 80, "%s", turfname);
    		new Float:pos[3];
    		GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
    		Turf_Info[i][TurfPickUP] = CreateDynamicPickup(1575, 1, pos[0],pos[1],pos[2]);
    		format(string, sizeof string, "Dia ban: %s[ID: %d]\nFamily dang chiem dong: Chua co", turfname,Turf_Info[i][TurfID]);
    		Turf_Info[i][TurfLabel] = CreateDynamic3DTextLabel(string, -1,pos[0],pos[1],pos[2],100);
    		Turf_Info[i][TurfZone][0] = pos[0],Turf_Info[i][TurfZone][1] = pos[1],Turf_Info[i][TurfZone][2] = pos[2];
    		SaveDiaBan(i);
    		break ;
    	}
    }
    return 1;
}
CMD:diaban(playerid,params[]) {
	for(new i = 1; i < MAX_TURF; i++) {
		if(IsPlayerInRangeOfPoint(playerid, 5, Turf_Info[i][TurfZone][0] ,Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2]) ) {
			if(Turf_Info[i][TurfOwnerID] != PlayerInfo[playerid][pFMember]) return 1;
			if(PlayerInfo[playerid][pRank] < 6) return 1;
			ShowPlayerDialog(playerid, DIALOG_DIABAN, DIALOG_STYLE_LIST, "Dia ban",  "Xem tien bao ke\nRut Tien", "Dong y", "Huy bo");
			SetPVarInt(playerid, "Turf:Select", i);
			return 1;
		}
	}
	
	return 1;
}
stock CongTienBaoKe(playerid,typebb) {
	new string[129];
	for(new g = 1; g < MAX_TURF; g++) {
		if(Turf_Info[g][TurfID] != 0) {
			if(Turf_Info[g][TurfType] == typebb && Turf_Info[g][TurfOwnerID] != INVALID_FAMILY_ID) {
				new giatien;
				switch(typebb) {
					case 1: {
						
						giatien = 500;
					}
					case 2: {

						giatien = 500;
					}
				}
				Turf_Info[g][TurfCash]+= giatien;
				format(string, sizeof string, "[DIA BAN] Ban da dong tien bao ke $%s cho bang dang %s", number_format(giatien),FamilyInfo[Turf_Info[g][TurfOwnerID]][FamilyName]);
				SendClientMessage(playerid,-1, string);
				format(string, sizeof string, "[DB] Địa bàn %s [Owner: %s] +%d, tổng tiền trong địa bàn: %s", Turf_Info[g][TurfName],
				FamilyInfo[Turf_Info[g][TurfOwnerID] ][FamilyName],giatien,number_format(Turf_Info[g][TurfCash]));
				DCC_SendChannelMessage(diaban, string);
				SaveDiaBan(g);
			}
		}	
	}
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(dialogid == DIALOG_DIABAN) {
		if(response) {
			if(listitem == 0) {
				new g = GetPVarInt(playerid, "Turf:Select"),string[129];
                format(string, sizeof(string), "So tien bao ke hien co: %s", number_format(Turf_Info[g][TurfCash]));
                ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "Thong bao", string, "Dong y", "Thoat");
			}
			if(listitem == 1) {
				new g = GetPVarInt(playerid, "Turf:Select");
				if(gettime() < Turf_Info[g][TurfLast] ) return SendClientMessage(playerid, COLOR_WHITE, "Ban phai doi 24h sau " );
				ShowPlayerDialog(playerid, DIALOG_RUTTIENDB, DIALOG_STYLE_INPUT, "Rut tien dia ban", "Vui long nhap so tien can rut", "Dong y", "Thoat");
			}
		}
	}
	if(dialogid == DIALOG_RUTTIENDB) {
		if(response) {
			if(strval(inputtext) < 0 || strval(inputtext) > 20000000) return ShowPlayerDialog(playerid, DIALOG_RUTTIENDB, DIALOG_STYLE_INPUT, "Rut tien dia ban", "Vui long nhap so tien can rut", "Dong y", "Thoat");
			new g = GetPVarInt(playerid, "Turf:Select");
			if(Turf_Info[g][TurfCash] < strval(inputtext)) return  ShowPlayerDialog(playerid, DIALOG_RUTTIENDB, DIALOG_STYLE_INPUT, "Rut tien dia ban", "Vui long nhap so tien can rut", "Dong y", "Thoat");
			Turf_Info[g][TurfCash] -= strval(inputtext);
			PlayerInfo[playerid][pCash] += strval(inputtext);
			new string[129];
			format(string, sizeof string, "Ban da rut %s tien ra tu dia ban", number_format( strval(inputtext)));
			SendClientMessage(playerid,-1,string);
		}
	}
	return 1;
}
CMD:achiemdiaban(playerid,params[]) {
//	new string[129];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(IsWarning[playerid] != 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(PlayerInfo[playerid][pFMember] == INVALID_FAMILY_ID)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the lam viec nay.");
		return 1;
	}
    if(PlayerInfo[playerid][pRank] == 6)
	{
		for(new i = 1; i < MAX_TURF; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 5, Turf_Info[i][TurfZone][0] ,Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2]) ) {
                if( Turf_Info[i][TurfIsWarning] == 1) return SendClientMessageEx(playerid,-1,"Dia ban dang duoc chiem dong, ban khong the tep tuc.") ;
	            Turf_Info[i][TurfFamilyWarning] = INVALID_FAMILY_ID;
		        Turf_Info[i][TurfIsWarning] = 0;
		        Turf_Info[i][TurfOwnerID] =  PlayerInfo[playerid][pFMember] ;
		        Turf_Info[i][TurfCountTime] = 0;
		        KillTimer(Turf_Info[i][TurfTime]);
		        SaveDiaBan(i);
			   
			    break ;
			}
		}

	}
	return 1;
}
CMD:typediaban(playerid,params[]) {
	new i,type;
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(sscanf(params, "dd", i,type))
	return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /typediaban [id] [type]");
	new Float:pos[3];
    GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
    if( Turf_Info[i][TurfID] == 0) return 1;
    Turf_Info[i][TurfType] = type ;
    SaveDiaBan(i);
    return 1;

}
CMD:xoadiaban(playerid,params[]) {
	new i;
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(sscanf(params, "d", i))
	return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /xoadiaban [id]");
	new Float:pos[3];
    GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
    if( Turf_Info[i][TurfID] == 0) return 1;
    if(IsValidDynamicObject(Turf_Info[i][TurfPickUP] )) DestroyDynamicPickup(Turf_Info[i][TurfPickUP] ) ; 
    if(IsValidDynamic3DTextLabel( Turf_Info[i][TurfLabel])) DestroyDynamic3DTextLabel( Turf_Info[i][TurfLabel]) ; 
    Turf_Info[i][TurfZone][0] = 0.0,Turf_Info[i][TurfZone][1] = 0.0,Turf_Info[i][TurfZone][2] = 100.0;
    Turf_Info[i][TurfType] = 0 ;
    SaveDiaBan(i);
    return 1;

}
CMD:vitridiaban(playerid,params[]) {
	new string[129],i;
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(sscanf(params, "d", i))
	return SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /vitridiaban [id]");
	new Float:pos[3];
    GetPlayerPos(playerid, pos[0],pos[1],pos[2]);
    if( Turf_Info[i][TurfID] == 0) return 1;
    if(IsValidDynamicObject(Turf_Info[i][TurfPickUP] )) DestroyDynamicPickup(Turf_Info[i][TurfPickUP] ) ; 
    if(IsValidDynamic3DTextLabel( Turf_Info[i][TurfLabel])) DestroyDynamic3DTextLabel( Turf_Info[i][TurfLabel]) ; 
    Turf_Info[i][TurfPickUP] = CreateDynamicPickup(1575, 1, pos[0],pos[1],pos[2]);
    format(string, sizeof string, "Dia ban: %s[%d]\nFamily dang chiem dong: Chua co", Turf_Info[i][TurfName] ,Turf_Info[i][TurfID]);
    Turf_Info[i][TurfLabel] = CreateDynamic3DTextLabel(string, -1,pos[0],pos[1],pos[2],100);
    Turf_Info[i][TurfZone][0] = pos[0],Turf_Info[i][TurfZone][1] = pos[1],Turf_Info[i][TurfZone][2] = pos[2];
    SaveDiaBan(i);
    return 1;

}
CMD:chiemdiaban(playerid,params[]) {
	new string[129];
	if(IsWarning[playerid] != 0) return SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the su dung lenh nay.");
	if(PlayerInfo[playerid][pFMember] == INVALID_FAMILY_ID)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the lam viec nay.");
		return 1;
	}
    if(PlayerInfo[playerid][pRank] == 6)
	{
		for(new i = 1; i < MAX_TURF; i++) {
			if(IsPlayerInRangeOfPoint(playerid, 5, Turf_Info[i][TurfZone][0] ,Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2]) ) {
                if( Turf_Info[i][TurfIsWarning] == 1) return SendClientMessageEx(playerid,-1,"Dia ban dang duoc chiem dong, ban khong the tep tuc.") ;
			    Turf_Info[i][TurfFamilyWarning] = PlayerInfo[playerid][pFMember] ;
			    Turf_Info[i][TurfIsWarning]  = 1;
			    if(Turf_Info[i][TurfOwnerID] != INVALID_FAMILY_ID) {
			    	format(string, sizeof(string), "%s dang bat dau chiem dong dia ban %s cua bang dan %s, neu trong vong 15p khong ai ngan can Turf se tro thanh chu so huu.", FamilyInfo[PlayerInfo[playerid][pFMember]][FamilyName],
			    		FamilyInfo[Turf_Info[i][TurfOwnerID]][FamilyName],Turf_Info[i][TurfName]);
			    }
			    else {
			    	format(string, sizeof(string), "%s dang bat dau chiem dong dia ban %s , neu trong vong 15p khong ai ngan can Turf se tro thanh chu so huu.", FamilyInfo[PlayerInfo[playerid][pFMember]][FamilyName],Turf_Info[i][TurfName]);
			       
			    }
			    SendClientMessageToAll(-1,string);
			    IsWarning[playerid] = i;

			 
			    Turf_Info[i][TurfCountTime] = 0 ; // 30s
			    Turf_Info[i][TurfTime] = SetTimerEx("UpdateChiemDong", 1000, true, "d", i);

			    foreach(new player : Player) {
			    	if(PlayerInfo[playerid][pFMember] == PlayerInfo[player][pFMember]  )
			    	{
			    		if(IsPlayerInRangeOfPoint(player, 30, Turf_Info[i][TurfZone][0] ,Turf_Info[i][TurfZone][1],Turf_Info[i][TurfZone][2]) ) {
			    		    SendClientMessageEx(player,-1,"Ban da bat dau tham gia Turf War, neu ban chet hoac roi khoi vung nay ban se bi loai khoi cuoc chien");
			    		    IsWarning[player] = i;
			    		}
			        }
			    }
			    break ;
			}
		}

	}
	return 1;
}
new stringz[129];
forward UpdateChiemDong(turf);
public UpdateChiemDong(turf) {
	new countz = 0,string[129];
	new familytf = Turf_Info[turf][TurfFamilyWarning];
	Turf_Info[turf][TurfCountTime]++;
	foreach(new i : Player) 
	{
        if(PlayerInfo[i][pFMember] == familytf) 
        {

            if(IsWarning[i] == turf) 
            {
            	if(IsPlayerInRangeOfPoint(i, 100,  Turf_Info[turf][TurfZone][0] ,Turf_Info[turf][TurfZone][1],Turf_Info[turf][TurfZone][2])) {
                    format(stringz, sizeof(stringz), "{fc2c1d}Nguoi choi nay dang chiem dong dia ban\n{e2c527}%s",  FamilyInfo[PlayerInfo[i][pFMember]][FamilyName]);
                    SetPlayerChatBubble(i, stringz, -1, 20, 1000);
                    format(stringz, sizeof(stringz), "Thoi gian chiem dia ban con lai %d giay", 600 - Turf_Info[turf][TurfCountTime]);
                    SendClientTextDraw(i,stringz);
            		countz++;
            	}
            	else {
            		SendClientMessageEx(i,-1,"Ban da roi khoi vung War dia ban, ban bi loai khoi cuoc chien");
            		IsWarning[i] = 0;

            	}
            	break ;
            }
        }
	}
	printf("turf update: %d,familytf: %d, coutz: %d,counttime: %d",turf,familytf,countz,Turf_Info[turf][TurfCountTime]);
	if(countz >= 1 && Turf_Info[turf][TurfCountTime] >= 600) {
        format(string, sizeof(string), "%s Da chiem thanh cong dia ban %s.", FamilyInfo[familytf][FamilyName],
			    	Turf_Info[turf][TurfName]);
        SendClientMessageToAll(-1,string);
		Turf_Info[turf][TurfFamilyWarning] = INVALID_FAMILY_ID;
		Turf_Info[turf][TurfIsWarning] = 0;
		Turf_Info[turf][TurfOwnerID] = familytf;
		Turf_Info[turf][TurfCountTime] = 0;
		Turf_Info[turf][TurfLast] = gettime() + 86400;
		KillTimer(Turf_Info[turf][TurfTime]);
		SaveDiaBan(turf);
		format(string, sizeof string, "Dia ban: %s[%d]\nFamily dang chiem dong: %s",Turf_Info[turf][TurfName],Turf_Info[turf][TurfID],FamilyInfo[familytf][FamilyName]);
		UpdateDynamic3DTextLabelText(Turf_Info[turf][TurfLabel], -1,string);
		foreach(new i : Player) {
            if(PlayerInfo[i][pFMember] == familytf) {
            	IsWarning[i] = 0;
            }
        }
		KillTimer(Turf_Info[turf][TurfTime]);
	}
	if(countz == 0) {
		format(string, sizeof(string), "%s Da that bai trong viec chiem dong dia ban %s.", FamilyInfo[familytf][FamilyName],
		Turf_Info[turf][TurfName]);
		SendClientMessageToAll(-1,string);
		Turf_Info[turf][TurfFamilyWarning] = INVALID_FAMILY_ID;
		Turf_Info[turf][TurfIsWarning] = 0;
		KillTimer(Turf_Info[turf][TurfTime]);
	}
}
OutCombat(playerid) {
	if(IsWarning[playerid] != 0) {
		new turfid = IsWarning[playerid];
		IsWarning[playerid] = 0;
		UpdateChiemDong(turfid);
	}
}
hook OnPlayerDeath(playerid) {
	OutCombat(playerid);
}
hook OnPlayerDisconnect(playerid) {
	OutCombat(playerid);
}
hook OnPlayerSpawn(playerid) {
	OutCombat(playerid);
}