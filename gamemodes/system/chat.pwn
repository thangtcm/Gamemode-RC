CMD:me(playerid, params[])
{
	if(isnull(params)) return SendUsageMessage(playerid, " /me [action]");
	new string[128];
	format(string, sizeof(string), "{FF8000}* {C2A2DA}%s %s", GetPlayerNameEx(playerid), params);
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	return 1;
}

CMD:whisper(playerid, params[]) {
	return cmd_w(playerid, params);
}

CMD:w(playerid, params[])
{
	new giveplayerid, whisper[128];

	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}
	if(sscanf(params, "us[128]", giveplayerid, whisper))
	{
		SendUsageMessage(playerid, " (/w)hisper [player] [text]");
		return 1;
	}
	if(WatchingTV[playerid] != 0 && PlayerInfo[playerid][pAdmin] < 2)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "Ban khong the lam dieu nay khi dang xem TV.");
		return 1;
	}
	if (IsPlayerConnected(giveplayerid))
	{
		if(HidePM[giveplayerid] > 0 && PlayerInfo[playerid][pAdmin] < 2)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "That person is blocking whispers!");
			return 1;
		}
		new giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME], string[128];
		sendername = GetPlayerNameEx(playerid);
		giveplayer = GetPlayerNameEx(giveplayerid);
		if(giveplayerid == playerid)
		{
			if(PlayerInfo[playerid][pSex] == 1) format(string, sizeof(string), "* %s mutters something to himself.", GetPlayerNameEx(playerid));
			else format(string, sizeof(string), "* %s mutters something to herself.", GetPlayerNameEx(playerid));
			return ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
		if(ProxDetectorS(5.0, playerid, giveplayerid) || PlayerInfo[playerid][pAdmin] >= 2)
		{
		    foreach(new i: Player)
		    {
		        if(GetPVarInt(i, "BigEar") == 6 && (GetPVarInt(i, "BigEarPlayer") == playerid || GetPVarInt(i, "BigEarPlayer")  == giveplayerid))
		        {
					format(string, sizeof(string), "(BE)%s(ID %d) thi tham voi %s(ID %d): %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(giveplayerid), giveplayerid, whisper);
					SendClientMessageWrap(i, COLOR_YELLOW, 92, string);
				}
			}

			format(string, sizeof(string), "%s (ID %d) thi tham voi ban: %s", GetPlayerNameEx(playerid), playerid, whisper);
			SendClientMessageWrap(giveplayerid, COLOR_YELLOW, 92, string);

			format(string, sizeof(string), "Ban thi tham voi %s: %s", GetPlayerNameEx(giveplayerid),whisper);
			SendClientMessageWrap(playerid, COLOR_YELLOW, 92, string);
			return 1;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Nguoi do khong gan ban.");
		}
		return 1;
	}
	else
	{
		SendErrorMessage(playerid, "Nguoi choi khong hop le");
	}
	return 1;
}

CMD:do(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}
	if(isnull(params)) return SendUsageMessage(playerid, " /do [action]");
	else if(strlen(params) > 120) return SendClientMessageEx(playerid, COLOR_GREY, "The specified message must not be longer than 120 characters in length.");
	new
		iCount,
		iPos,
		iChar;

	while((iChar = params[iPos++])) {
		if(iChar == '@') iCount++;
	}
	if(iCount >= 5) {
		return SendClientMessageEx(playerid, COLOR_GREY, "The specified message must not contain more than 4 '@' symbols.");
	}

	new string[150];
	format(string, sizeof(string), "* %s (( %s ))", params, GetPlayerNameEx(playerid));
	ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
	return 1;
}

CMD:o(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}
	if ((noooc) && PlayerInfo[playerid][pAdmin] < 2 && EventKernel[EventCreator] != playerid)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "   Kenh chat OOC da bi tat boi Admin!");
		return 1;
	}
	if(gOoc[playerid])
	{
		SendClientMessageEx(playerid, TEAM_CYAN_COLOR, "   Ban da an hien thi OOC chat, de hien len su dung /togooc!");
		return 1;
	}
	if(isnull(params)) return SendUsageMessage(playerid, " (/o)oc [ooc chat]");

	if(PlayerInfo[playerid][pAdmin] == 1)
	{
		new string[128];
		format(string, sizeof(string), "(( Moderator %s: %s ))", GetPlayerNameEx(playerid), params);
		OOCOff(COLOR_OOC,string);
	}
	else if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new string[128];
		format(string, sizeof(string), "(( Administrator %s: %s ))", GetPlayerNameEx(playerid), params);
		OOCOff(COLOR_OOC,string);
	}
	else if(PlayerInfo[playerid][pHelper] >= 2)
	{
		new string[128];
		format(string, sizeof(string), "(( Community Advisor %s: %s ))", GetPlayerNameEx(playerid), params);
		OOCOff(COLOR_OOC,string);
		return 1;
	}
	else if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pHelper] <= 2)
	{
		new string[128];
		format(string, sizeof(string), "(( %s: %s ))", GetPlayerNameEx(playerid), params);
		OOCOff(COLOR_OOC,string);
		return 1;
	}
	return 1;
}

CMD:shout(playerid, params[]) {
	return cmd_s(playerid, params);
}

CMD:s(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}

	if(isnull(params)) return SendUsageMessage(playerid, " (/s)hout [shout chat]");
	new string[128];
	format(string, sizeof(string), "(het to) %s!", params);
	SetPlayerChatBubble(playerid,string,COLOR_WHITE,60.0,5000);
	format(string, sizeof(string), "%s het to: %s!", GetPlayerNameEx(playerid), params);
	ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2, 1);
	return 1;
}

CMD:low(playerid, params[]) {
	return cmd_l(playerid, params);
}

CMD:l(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}

	if(isnull(params)) return SendUsageMessage(playerid, " (/l)ow [close chat]");

	new string[128];
	format(string, sizeof(string), "%s noi nho: %s", GetPlayerNameEx(playerid), params);
	ProxDetector(5.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5, 1);
	format(string, sizeof(string), "(noi nho) %s", params);
	SetPlayerChatBubble(playerid,string,COLOR_WHITE,5.0,5000);
	return 1;
}

CMD:b(playerid, params[])
{
	if(gPlayerLogged{playerid} == 0)
	{
		SendErrorMessage(playerid, " Ban chua dang nhap.");
		return 1;
	}
	if(isnull(params)) return SendUsageMessage(playerid, " /b [Chat ooc]");
	new string[128];
	format(string, sizeof(string), "%s: (( %s ))", GetPlayerNameEx(playerid), params);
	ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

	foreach(new i: Player)
	{
	    if(PlayerInfo[i][pAdmin] > 1 && GetPVarInt(i, "BigEar") == 2)
	    {
			new szAntiprivacy[128];
			format(szAntiprivacy, sizeof(szAntiprivacy), "(BE) %s: %s", GetPlayerNameEx(playerid), params);
			SendClientMessageEx(i, COLOR_FADE1, szAntiprivacy);
		}
	}
	return 1;
}
CMD:ame(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/ame [Noi dung]");

	new str[128]; 
	
	format (str, sizeof(str), "> %s %s", GetPlayerNameEx(playerid), params);
	SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
	
	sendMessage(playerid, COLOR_EMOTE, "* %s %s", GetPlayerNameEx(playerid), params);
	return 1;
}
