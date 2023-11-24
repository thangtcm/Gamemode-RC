// task nhiem vu (hang ngay, tan thu)


#include <YSI_Coding\y_hooks>

#define HELP_MISSON (7886)
#define MISSON (7887)
#define A_MISSON (7888)
#define B_MISSON (7889)

forward M_OnQueryFinish(extraid, handleid);

SendMissonMessage(playerid, const msg_job[])
{
	new format_job[1280];
	format(format_job, sizeof(format_job), "{FFCB00}[MISSON]:{FFFFFF}: %s", msg_job);
	SendClientMessage(playerid, COLOR_WHITE, format_job);
	return 1;
}

enum minfo
{
   m_name[100],
   m_count,
   m_reward
}
enum mminfo
{
   m_check_count[8],
   m_get[3], // type (1 nv hang ngay, 2 nv tan thu)
   m_danglamnv[3], // nv hang ngay
   a_m_done, // nv hang ngay
   b_m_done // nv tan thu
}
new NPC_Misson;
new M_check[MAX_PLAYERS][3]; // ham main check nv, 2 type
new PMisson[MAX_PLAYERS][mminfo];

new Misson[6][minfo] = {
// nhiem vu hang ngay
{"Giao 20 chuyen pizza", 20, 4000}, // 0
{"Dao 20 cuc da (MINER)", 20, 5000}, // 1
// nhiem vu tan thu
{"Dang ky CMND", 1, 1000}, // 2
{"Thi bang lai", 1, 1000}, // 3
{"Giao 20 chuyen pizza", 20, 4000}, // 4
{"Dao 20 cuc da (MINER)", 20, 5000} //5 
};


hook OnGameModeInit()
{
    NPC_Misson = CreateActor(2,1223.2640,246.9477,19.5469,61.2911);
    CreateDynamic3DTextLabel("Jhon Song\n(( Su dung [/nhiemvu] de nhan nhiem vu ))", -1, 1223.2640,246.9477,19.5469 , 10);           
}

hook OnPlayerDisconnect(playerid, reason)
{
	g_mysql_SaveMisson(playerid);
}

stock g_mysql_LoadMisson(playerid)
{
	new string[164];
	format(string, sizeof(string), "SELECT * FROM `accounts` WHERE `Username` = '%s'", GetPlayerNameExt(playerid));
 	mysql_function_query(MainPipeline, string, true, "M_OnQueryFinish", "ii", playerid, g_arrQueryHandle{playerid});
	return 1;
}

stock g_mysql_SaveMisson(playerid)
{
    new query[2048];

    format(query, 2048, "UPDATE `accounts` SET ");
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "Daily", PlayerInfo[playerid][pDaily]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_get_1", PMisson[playerid][m_get][1]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_get_2", PMisson[playerid][m_get][2]);
    
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "A_M_done", PMisson[playerid][a_m_done]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "B_M_done", PMisson[playerid][b_m_done]);
    
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_0", PMisson[playerid][m_check_count][0]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_1", PMisson[playerid][m_check_count][1]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_2", PMisson[playerid][m_check_count][2]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_3", PMisson[playerid][m_check_count][3]);
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_4", PMisson[playerid][m_check_count][4]); 
    SavePlayerInteger(query, GetPlayerSQLId(playerid), "M_count_5", PMisson[playerid][m_check_count][5]);
	SavePlayerInteger(query, GetPlayerSQLId(playerid), "DriveReward", pDriveReward[playerid]);
	MySQLUpdateFinish(query, GetPlayerSQLId(playerid));
    return 1;
}

public M_OnQueryFinish(extraid, handleid)
{
    new rows, fields;
	if(extraid != INVALID_PLAYER_ID) {
		if(g_arrQueryHandle{extraid} != -1 && g_arrQueryHandle{extraid} != handleid) return 0;
	}
	cache_get_data(rows, fields, MainPipeline);
	new month, day, year, datetimenow;
    getdate(year,month,day);
	datetimenow = day*1000000 + month*10000 + year;
	if(IsPlayerConnected(extraid))
	{
		new szResult[64];

		for(new row;row < rows;row++)
		{
			cache_get_field_content(row,  "Daily", szResult, MainPipeline); PlayerInfo[extraid][pDaily] = strval(szResult);
			if(PlayerInfo[extraid][pDaily] != datetimenow)
			{
				PlayerInfo[extraid][pDaily] = datetimenow;
				
			}
			SendServerMessage(extraid, "Su dung /trogiup de tim hieu ro hon ve cac cong viec va cac lenh can dung trong may chu");
			cache_get_field_content(row,  "M_get_1", szResult, MainPipeline); PMisson[extraid][m_get][1] = strval(szResult);
			cache_get_field_content(row,  "M_get_2", szResult, MainPipeline); PMisson[extraid][m_get][2] = strval(szResult);
			
			cache_get_field_content(row,  "A_M_done", szResult, MainPipeline); PMisson[extraid][a_m_done] = strval(szResult); // hang ngay
			cache_get_field_content(row,  "B_M_done", szResult, MainPipeline); PMisson[extraid][b_m_done] = strval(szResult); // tan thu
			
			cache_get_field_content(row,  "M_count_0", szResult, MainPipeline); PMisson[extraid][m_check_count][0] = strval(szResult);
			cache_get_field_content(row,  "M_count_1", szResult, MainPipeline); PMisson[extraid][m_check_count][1] = strval(szResult);
			cache_get_field_content(row,  "M_count_2", szResult, MainPipeline); PMisson[extraid][m_check_count][2] = strval(szResult);
			cache_get_field_content(row,  "M_count_3", szResult, MainPipeline); PMisson[extraid][m_check_count][3] = strval(szResult);
			cache_get_field_content(row,  "M_count_4", szResult, MainPipeline); PMisson[extraid][m_check_count][4] = strval(szResult);
			cache_get_field_content(row,  "M_count_5", szResult, MainPipeline); PMisson[extraid][m_check_count][5] = strval(szResult);
			cache_get_field_content(row,  "DriveReward", szResult, MainPipeline); pDriveReward[extraid] = strval(szResult);
			if(PMisson[extraid][m_get][1] == 0)
			{
				SendServerMessage(extraid, "Ban lam nhiem vu ngay hom nay, hay tim NPC tại CityHall de lam nhiem vu ngay nhe");
			}
		}
	}
	return 1;
}

stock CheckDoneMisson(playerid, type)
{
	new str[128];
    switch(type)
    {
         // nhiem vu hang ngay
         case 0: // pizza
         {
            if(PMisson[playerid][m_get][1] == 1) // hang ngay
            {
					if(!PMisson[playerid][m_danglamnv][1]) return 1;
					PMisson[playerid][m_check_count][0] += 1;
					format(str, sizeof(str),  "Tien do nhiem vu giao pizza hien tai cua ban la {FFCB00}%d/%d{FFFFFF} (/nhiemvu de xem chi tiet).", PMisson[playerid][m_check_count][0], Misson[0][m_count]);
					SendMissonMessage(playerid, str);
					if(PMisson[playerid][m_check_count][0] >= Misson[0][m_count])
					{
						GiveRewardMisson(playerid);
					}
		    }
			else if(PMisson[playerid][m_get][2] == 1) // tan thu
            {
				PMisson[playerid][m_check_count][4] += 1;
				format(str, sizeof(str),  "Tien do nhiem vu tan thu giao pizza hien tai cua ban la {FFCB00}%d/%d{FFFFFF} (/nhiemvu de xem chi tiet).", PMisson[playerid][m_check_count][4], Misson[4][m_count]);
				SendMissonMessage(playerid, str);
				if(PMisson[playerid][m_check_count][5] >= Misson[5][m_count] && PMisson[playerid][m_check_count][4] >= Misson[4][m_count] && PMisson[playerid][m_check_count][2] && PMisson[playerid][m_check_count][3])
				{
					GiveRewardMisson(playerid);
				}
		    }
         }
         case 1: // miner
         {
		    if(PMisson[playerid][m_get][1] == 2) // nv hang ngay
            {
				if(!PMisson[playerid][m_danglamnv][2]) return 1;
				PMisson[playerid][m_check_count][1] += 1;
				format(str, sizeof(str),  "Tien do nhiem vu dao duoc da(MINER) hien tai cua ban la {FFCB00}%d/%d{FFFFFF} (/nhiemvu de xem chi tiet).", PMisson[playerid][m_check_count][1], Misson[1][m_count]);
				SendMissonMessage(playerid, str);
				if(PMisson[playerid][m_check_count][1] >= Misson[1][m_count])
				{
					GiveRewardMisson(playerid);
				}
		    }
			else if(PMisson[playerid][m_get][2] == 1) // nv tan thu
            {
				PMisson[playerid][m_check_count][5] += 1;
				format(str, sizeof(str),  "Tien do nhiem vu tan thu dao duoc da(MINER) hien tai cua ban la {FFCB00}%d/%d{FFFFFF} (/nhiemvu de xem chi tiet).", PMisson[playerid][m_check_count][5], Misson[5][m_count]);
				SendMissonMessage(playerid, str);
				if(PMisson[playerid][m_check_count][5] >= Misson[5][m_count] && PMisson[playerid][m_check_count][4] >= Misson[4][m_count] && PMisson[playerid][m_check_count][2] && PMisson[playerid][m_check_count][3])
				{
					GiveRewardMisson(playerid);
				}
		    }
         }
         case 2: //  CMND (mv tan thu)
         {
		      if(PMisson[playerid][m_get][2] == 1) // nv tan thu
		      {
	              if(PMisson[playerid][m_check_count][2]) return 1;
	              PMisson[playerid][m_check_count][2] += 1;
		          SendMissonMessage(playerid, "Nhiem vu tan thu dang ky CMND da hoan thanh (/nhiemvu de xem chi tiet).");
		          if(PMisson[playerid][m_check_count][5] >= Misson[5][m_count] && PMisson[playerid][m_check_count][4] >= Misson[4][m_count] && PMisson[playerid][m_check_count][2] && PMisson[playerid][m_check_count][3])
				  {
				      GiveRewardMisson(playerid);
				  }
		      }
         }
         case 3: //  Thi bang lai (mv tan thu)
         {
		      if(PMisson[playerid][m_get][2] == 1) // nv tan thu
		      {
		          if(PMisson[playerid][m_check_count][3]) return 1;
		          PMisson[playerid][m_check_count][3] += 1;
		          SendMissonMessage(playerid, "Nhiem vu tan thu thi bang lai da hoan thanh (/nhiemvu de xem chi tiet).");
		          if(PMisson[playerid][m_check_count][5] >= Misson[5][m_count] && PMisson[playerid][m_check_count][4] >= Misson[4][m_count] && PMisson[playerid][m_check_count][2] && PMisson[playerid][m_check_count][3])
				  {
				      GiveRewardMisson(playerid);
				  }
		      }
         }
    }
    return 1;
}

stock Main_ResetCountMisson(playerid)
{
    PMisson[playerid][m_check_count][1] = 0;
    PMisson[playerid][m_check_count][0] = 0;
    PMisson[playerid][m_get][1] = 0;
    PMisson[playerid][a_m_done] = 0;
}

stock ResetCountMisson(playerid)
{
    PMisson[playerid][m_check_count][1] = 0;
    PMisson[playerid][m_check_count][0] = 0;
    PMisson[playerid][m_get][1] = 0;
}

stock GiveRewardMisson(playerid)
{
	new str[128];
    if(PMisson[playerid][m_get][1] == 1) // nv hang ngay (pizza)
    {
        if(PMisson[playerid][m_check_count][0] < Misson[0][m_count] ) return SendMissonMessage(playerid, "Ban chua hoan thanh nhiem vu");
        ResetCountMisson(playerid);
        PMisson[playerid][a_m_done] = 1;
        PMisson[playerid][m_danglamnv][1] = 0;
        PlayerInfo[playerid][pCash] += Misson[0][m_reward];
        M_check[playerid][1] = 0;
		format(str, sizeof(str), "CHUC MUNG! Ban da hoan thanh nhiem vu hang ngay va nhan duoc {FFCB00}%d${FFFFFF}", Misson[0][m_reward]);
        SendMissonMessage(playerid, str);
    }
    else if(PMisson[playerid][m_get][1] == 2) // nv hang ngay (miner)
    {
        if(PMisson[playerid][m_check_count][2] < Misson[1][m_count]) return SendMissonMessage(playerid, "Ban chua hoan thanh nhiem vu");
        ResetCountMisson(playerid);
        PMisson[playerid][a_m_done] = 1;
        PMisson[playerid][m_danglamnv][1] = 0;
        PlayerInfo[playerid][pCash] += Misson[1][m_reward];
        M_check[playerid][1] = 0;
		format(str, sizeof(str), "CHUC MUNG! Ban da hoan thanh nhiem vu hang ngay va nhan duoc {FFCB00}%d${FFFFFF}", Misson[0][m_reward]);
        SendMissonMessage(playerid, str);
    }
    else if(PMisson[playerid][m_get][2] == 1) // nv tan thu
    {
        if(PMisson[playerid][m_check_count][5] >= Misson[5][m_count] && PMisson[playerid][m_check_count][4] >= Misson[4][m_count] && PMisson[playerid][m_check_count][2] && PMisson[playerid][m_check_count][3]) 
        {
	        ResetCountMisson(playerid);
	        PMisson[playerid][b_m_done] = 1;
	        PlayerInfo[playerid][pCash] += Misson[2][m_reward] + Misson[3][m_reward] + Misson[4][m_reward] + Misson[5][m_reward];
	        M_check[playerid][2] = 0;
	        PMisson[playerid][m_get][2] = 0;
			format(str, sizeof(str), "CHUC MUNG! Ban da hoan thanh nhiem vu tan thu va nhan duoc {FFCB00}%d${FFFFFF}", Misson[2][m_reward] + Misson[3][m_reward] + Misson[4][m_reward] + Misson[5][m_reward]);
	        SendMissonMessage(playerid, str);
	    }
	    else return SendMissonMessage(playerid, "Ban chua hoan thanh nhiem vu tan thu.");
    }
    return 1;
}



hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(!response)return 1;
	switch(dialogid) {
	    case HELP_MISSON: {
        	switch(listitem) {        		
            	case 0: { //pizza 
                    new hstr[1024];
					format(hstr, sizeof(hstr), "{FFB000}Huong Dan Lam Nhiem Vu MINER(Tan thu - Hang ngay):\n", hstr);
					format(hstr, sizeof(hstr),  "%s\nSu dung [/trogiup -> Job -> Pizza] de xem chi tiet.",hstr);
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Huong dan nhiem vu", hstr, "Thoat", "");
			        return 1;
                }
                case 1: { // miner
                    new hstr[1024];
					format(hstr, sizeof(hstr), "{FFB000}Huong Dan Lam Nhiem Vu MINER (Tan thu - Hang ngay):\n", hstr);
					format(hstr, sizeof(hstr), "%s\nSu dung [/trogiup -> Job -> Miner] de xem chi tiet.\n\n Luu y: Dao duoc cuc da moi tinh'.", hstr);
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Huong dan nhiem vu", hstr, "Thoat", "");
			        return 1;
                }
                case 2: { // dang ky cmnd
			        new hstr[1024];
					format(hstr, sizeof(hstr), "{FFB000}update...\n", hstr);
					
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Huong dan nhiem vu", hstr, "Thoat", "");
			        return 1;
                }
                case 3: { // thi bang lai
                    new hstr[1024];
			        format(hstr, sizeof(hstr), "{FFB000}Huong Dan Lam Nhiem Vu (Tan thu):\n", hstr);
					format(hstr, sizeof(hstr), "%s\n{FFB000}Buoc 1:{B4B5B7} Su dung [/gps -> Dia diem -> Thi bang lai] di den checkpoint.", hstr);
					format(hstr, sizeof(hstr), "%s\n{FFB000}Buoc 2:{B4B5B7} Den gan pickup, su dung [/thibanglai] de bat dau thi.", hstr);
					format(hstr, sizeof(hstr), "%s\n{FFB000}Buoc 3:{B4B5B7} Doc ky luat le va lam cau hoi trac nghiem.", hstr);
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Huong dan nhiem vu", hstr, "Thoat", "");
			        return 1;
                }
        	}
        }
	    case MISSON: {
        	switch(listitem) {        		
            	case 0: { // nv hang ngay
                    if(M_check[playerid][2]) return SendMissonMessage(playerid, "Ban da nhan nhien vu tan thu hay hoan thanh truoc.");
                    if(PMisson[playerid][a_m_done]) return SendMissonMessage(playerid, "Hom nay ban da hoan thanh nhiem vu hang ngay roi.");
			        if(M_check[playerid][1] == 0)
			        {
			            ShowPlayerDialog(playerid, A_MISSON, DIALOG_STYLE_LIST, "Nhiem vu hang ngay - RCRP.VN ", "[ - ]   Nhan nhiem vu hang ngay", "Chon","Thoat");
			        }
			        else {
			            ShowPlayerDialog(playerid, A_MISSON, DIALOG_STYLE_LIST, "Nhiem vu hang ngay - RCRP.VN ", "[ - ]   Nhan nhiem vu hang ngay\n[ - ]   Thong tin nhiem vu", "Chon","Thoat");
	                }
			        return 1;
                }
                case 1: { // nv tan thu
                    if(PMisson[playerid][b_m_done]) return SendMissonMessage(playerid, "Ban da hoan thanh nhiem vu tan thu roi.");
			        ShowPlayerDialog(playerid, B_MISSON, DIALOG_STYLE_LIST, "Nhiem vu tan thu - RCRP.VN ", "[ - ]   Nhan nhiem vu tan thu\n[ - ]   Thong tin nhiem vu", "Chon","Thoat");
			        return 1;
                }
                case 2: { // huong lam nv
			        ShowPlayerDialog(playerid,HELP_MISSON, DIALOG_STYLE_LIST, "Huong dan nhiem vu - RCRP.VN ", "[ - ]   Pizza\n[ - ]   Miner\n[ - ]   Dang ky CMND\n[ - ]   Thi bang lai", "Chon","Thoat");
			        return 1;
                }
        	}
        }
        case A_MISSON: { // nv hang ngay
        	switch(listitem) {        		
        		case 0: {                   // nhan nv
                    new value = 1 + random(1);
                    if(M_check[playerid][1]) return SendMissonMessage(playerid, "Ban da nhan nhiem vu roi.");
					PMisson[playerid][m_get][1] = value; // 0 = pizza, 1= dao da
					M_check[playerid][1] = 1; // ham main check dang lam nhiem vu
					PMisson[playerid][m_danglamnv][value] = 1;
				    SendMissonMessage(playerid, "Ban da nhan nhiem vu hang ngay thanh cong, su dung [/nhiemvu -> Nhiem vu hang ngay] de xem thong tin.");
				}
				case 1: {    // thong tin
				    if(PMisson[playerid][m_get][1] == 1)
				    {
					    new str[1280];
					    format(str, sizeof str,"Thong tin nhiem vu hang ngay:\n\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n\n Phan thuong: {FFB000}%d${FFFFFF}.", 
	                        Misson[0][m_name], 
	                        PMisson[playerid][m_check_count][0], 
	                        Misson[0][m_count],
	                        Misson[0][m_reward]
                        );
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Nhiem vu hang ngay - RCRP.VN",str, "Thoat", "");
					} 
					else if(PMisson[playerid][m_get][1] == 2)
				    {
					    new str[1280];
					    format(str, sizeof str,"Thong tin nhiem vu hang ngay:\n\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n\n Phan thuong: {FFB000}%d${FFFFFF}.", 
	                        Misson[1][m_name], 
	                        PMisson[playerid][m_check_count][1], 
	                        Misson[1][m_count],
	                        Misson[1][m_reward]
                        );
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Nhiem vu hang ngay - RCRP.VN",str, "Thoat", "");
					} 
				}
        	}
        }
        case B_MISSON: { // nv tan thu 
        	switch(listitem) {        		
        		case 0: {                   // nhan nv
                    
                    if(M_check[playerid][1]) return SendMissonMessage(playerid, "Ban da nhan nhien vu hang ngay hay hoan thanh truoc.");
                    if(M_check[playerid][2]) return SendMissonMessage(playerid, "Ban da nhan nhiem vu roi.");
					PMisson[playerid][m_get][2] = 1; // get nv tan thu
					M_check[playerid][2] = 1; // ham main check dang lam nhiem vu
				    SendMissonMessage(playerid, "Ban da nhan nhiem vu tan thu thanh cong, su dung [/nhiemvu -> Nhiem vu tan thu] de xem thong tin.");
				}
				case 1: {    // thong tin
				    if(PMisson[playerid][m_get][2] == 1)
				    {
					    new str[1280];
					    format(str, sizeof str,"Thong tin nhiem vu tan thu:\n\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n[ - ] %s [{FFB000}%d/%d{FFFFFF}].\n\n Phan thuong: {FFB000}%d${FFFFFF}.", 
	                        Misson[2][m_name], 
	                        PMisson[playerid][m_check_count][2], 
	                        Misson[2][m_count],
	                        
	                        //
	                        Misson[3][m_name], 
	                        PMisson[playerid][m_check_count][3], 
	                        Misson[3][m_count],
	                        
                            //
                            Misson[4][m_name], 
	                        PMisson[playerid][m_check_count][4], 
	                        Misson[4][m_count],
	
                            //
                            Misson[5][m_name], 
	                        PMisson[playerid][m_check_count][5], 
	                        Misson[5][m_count],
	                        Misson[2][m_reward] + Misson[3][m_reward] + Misson[4][m_reward] + Misson[5][m_reward]
                        );
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Nhiem vu tan thu - RCRP.VN",str, "Thoat", "");
					} 
				}
        	}
        }
	}
	return 1;
}



CMD:nhiemvu(playerid, params[])
{
    new Float:PosXACtor, Float:PosYACtor, Float:PosZACtor;
	GetActorPos(NPC_Misson, PosXACtor, PosYACtor, PosZACtor);
	if(IsPlayerInRangeOfPoint(playerid, 2.0, PosXACtor, PosYACtor, PosZACtor))
	{
	    ShowPlayerDialog(playerid, MISSON, DIALOG_STYLE_LIST, "Misson - RCRP.VN ", "{FF9800}[ - ]{FFFFFF}   Nhiem vu hang ngay\n{FF9800}[ - ]{FFFFFF}   Nhiem vu tan thu\n{FF9800}[ - ]{FFFFFF}   Huong dan lam nhiem vu", "Chon","Thoat");
	    return 1;
	}
	else return SendMissonMessage(playerid, "Ban khong dung gan NPC nhan nhiem vu."); 
}



//CMD TEST 
CMD:mtest1(playerid, params[])
{
    CheckDoneMisson(playerid, 0);
    return 1;
}

CMD:mtest2(playerid, params[])
{
    CheckDoneMisson(playerid, 1);
    return 1;
}

CMD:mtest3(playerid, params[])
{
    CheckDoneMisson(playerid, 2);
    return 1;
}

CMD:mtest4(playerid, params[])
{
    CheckDoneMisson(playerid, 3);
    return 1;
}
