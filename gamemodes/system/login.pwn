
stock LoadLoginTextDraws(playerid)
{
	LoginTD[playerid][0] = CreatePlayerTextDraw(playerid, 242.405487, 106.000015, "mdl-2016:main_dangnhap");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoginTD[playerid][0], 206.000000, 234.000000);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, LoginTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][0], 0);

	LoginTD[playerid][1] = CreatePlayerTextDraw(playerid, 298.733581, 210.550094, "mdl-2016:button");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoginTD[playerid][1], 126.000000, 20.239982);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, LoginTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][1], true);

	LoginTD[playerid][2] = CreatePlayerTextDraw(playerid, 298.733581, 235.633377, "mdl-2016:button");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoginTD[playerid][2], 126.000000, 20.239982);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, LoginTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][2], true);

	LoginTD[playerid][3] = CreatePlayerTextDraw(playerid, 376.482208, 259.550109, "mdl-2016:dangnhap_blue");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoginTD[playerid][3], 47.000000, 20.000000);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, LoginTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][3], true);

	LoginTD[playerid][4] = CreatePlayerTextDraw(playerid, 392.701110, 282.616790, "mdl-2016:dangky_dark");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, LoginTD[playerid][4], 39.000000, 17.000000);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, LoginTD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, LoginTD[playerid][4], true);

	LoginTD[playerid][5] = CreatePlayerTextDraw(playerid, 358.936004, 213.266677, "cuong_khongzz");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][5], 0.208374, 1.384166);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, LoginTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][5], 0);

	LoginTD[playerid][6] = CreatePlayerTextDraw(playerid, 358.467437, 237.849990, "0352755532");
	PlayerTextDrawLetterSize(playerid, LoginTD[playerid][6], 0.208374, 1.384166);
	PlayerTextDrawAlignment(playerid, LoginTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, LoginTD[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, LoginTD[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, LoginTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, LoginTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, LoginTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, LoginTD[playerid][6], 0);


}
stock HideLoginTD(playerid)
{
	PlayerTextDrawHide(playerid, LoginTD[playerid][0]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][1]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][2]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][3]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][4]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][5]);
	PlayerTextDrawHide(playerid, LoginTD[playerid][6]);
	CancelSelectTextDraw(playerid);

}

stock LoadLogin(playerid)
{
	// PlayerTextDrawSetString(playerid, LoginTD[playerid][6], string);
	PlayerTextDrawShow(playerid, LoginTD[playerid][0]);
	PlayerTextDrawShow(playerid, LoginTD[playerid][1]);
	PlayerTextDrawShow(playerid, LoginTD[playerid][2]);
	PlayerTextDrawShow(playerid, LoginTD[playerid][3]);
	PlayerTextDrawShow(playerid, LoginTD[playerid][4]);
	SelectTextDraw(playerid, 0xe1dfa2FF);
	return 1;
}

stock clicklogin_check_account(playerid)
{
	new string[128],name[32];
	GetPVarString(playerid, "enter_UserName", name, 32);
	format(string, sizeof(string), "SELECT `acc_name`,`acc_id`,`acc_pass`,`acc_ban`  from masterdb WHERE acc_name = '%s'", name);
	//mysql_function_query(MainPipeline, string, true, "OnQueryFinish", "iii", LOGIN_THREAD, playerid, g_arrQueryHandle{playerid});
	mysql_tquery(MainPipeline, string, "logingametd", "d", playerid);

	return 1;
}


forward logingametd(playerid);
public logingametd(playerid)
{
	new rows = cache_num_rows();
	new banned;
	for (new i; i < rows; i++)
	{
		new
			szResult[129],
					szBuffer[129],
					named[32],
					szEmail[256];

		cache_get_field_content(i, "acc_name", szResult, MainPipeline);
		GetPVarString(playerid, "enter_UserName", named, 32);
		if (strcmp(szResult, named, true) != 0)
		{
			//g_mysql_AccountAuthCheck(extraid);

			return 1;
		}
		MasterInfo[playerid][acc_id] = cache_get_field_content_int(i, "acc_id", MainPipeline);
		banned = cache_get_field_content_int(i, "acc_ban", MainPipeline);
		printf("acc id %d", MasterInfo[playerid][acc_id]);
		cache_get_field_content(i, "acc_email", szEmail, MainPipeline);
		cache_get_field_content(i, "acc_pass", szResult, MainPipeline);


		GetPVarString(playerid, "enter_password", szBuffer, sizeof(szBuffer));

		if (isnull(szEmail)) SetPVarInt(playerid, "NullEmail", 1);

		if (strcmp(szBuffer, szResult) != 0)
		{
			PlayerTextDrawShow(playerid, LoginTD[playerid][0]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][1]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][2]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][3]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][4]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][5]);
			PlayerTextDrawShow(playerid, LoginTD[playerid][6]);
			SelectTextDraw(playerid, 0xe1dfa2FF);
			//LoadLogin(playerid);
			//		SelectTextDraw(playerid, -1);
			ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Thong bao", "Ban da nhap sai mat khau, vui long kiem tra lai", "Dong y", "");
			// Invalid Password - Try Again!
			//	new string[229],ip[32];
			//	GetPlayerIp(playerid, ip, 32);
			//	format(string,sizeof (string),"\n\nDang nhap that bai: %d/3\n\n\nDia chi IP cua ban: %s\n\nLan dang nhap cua tai khoan: %s\n\nThoi gian tao tai khoan: %s\n\nTai khoan ban da dang ky hay nhap mat khau de dang nhap\n\n\n",gPlayerLogTries[playerid]+1,ip,MasterInfo[playerid][acc_lastlogin],MasterInfo[playerid][acc_regidate]);
			//	ShowPlayerDialog(playerid,DANGNHAP,DIALOG_STYLE_PASSWORD,"Dang nhap",string,"Dang nhap","Thoat");
			SetPlayerCameraPos(playerid, 1527.1915, -1388.5413, 405.3455);
			SetPlayerCameraLookAt(playerid, 1527.1210, -1389.5367, 403.4106);
			SetPlayerPos(playerid, 1535.3447, -1357.3451, 329.4568);
			HideNoticeGUIFrame(playerid);

			/*	if(++gPlayerLogTries[playerid] == 4)
				{
					SendClientMessage(playerid, COLOR_RED, "(SERVER) Sai mat khau, ban tu dong bi kich ra khoi may chu.");
					Kick(playerid);
				}*/
			return 1;
		}
		DeletePVar(playerid, "PassAuth");
		break;
	}
	if (banned == 1)
	{
		ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Thong bao - khoa tai khoan", "Tai khoan Master Account cua ban da bi khoa vinh vien\nNeu co thac mac vui long lien he Admin de biet them chi tiet", "Dong", "");
		SetTimerEx("KickEx", 1000, 0, "i", playerid);
		return 1;
	}
	HideNoticeGUIFrame(playerid);
	//	g_mysql_LoadAccount(playerid);
	SendClientMessage(playerid, 0xa5bbd0FF, "(LOGIN) Ban da dang nhap thanh cong hay chon nhan vat de tham gia game!.");
	LoadTempCharacters(playerid);
	HideLoginTD(playerid);
	new years,month,day,hourz,minz,sec,time[50];
	getdate(years, month, day);
	gettime(hourz, minz, sec);
	format(time, sizeof time , "%d/%d/%d %d:%d:%d", day, month, years, hourz, minz, sec);
	if (sec < 10)
	{
		format(time, sizeof time , "%d/%d/%d %d:%d:0%d", day, month, years, hourz, minz, sec);
	}
	new query[300];
	format(query, sizeof(query), "UPDATE `masterdb` SET `acc_lastlogin` = '%s' WHERE `acc_id` = '%d'", time, MasterInfo[playerid][acc_id]);
	mysql_function_query(MainPipeline, query, false, "OnQueryFinish", "i", SENDDATA_THREAD);
	return 1;
}
forward account_check_dialog_user(playerid);
public account_check_dialog_user(playerid)
{
	new rows = cache_num_rows();
	if (rows != 0)
	{
		SetPVarInt(playerid, "username_check", 2);
	}
	else
	{
		SetPVarInt(playerid, "username_check", 1);
	}
	return 1;
}