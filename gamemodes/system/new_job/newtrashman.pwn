#include <YSI_Coding\y_hooks>

// VARIABLES
#define MAX_GROUPS_TRASHMAN 100
enum TrashmanInfo {
	LeaderTM,
	GroupIDTM
}
enum TrashmanInfoGr {
	TMLeader,
	TMMembers,
	TMVehicle
}
new TMGInfo[MAX_GROUPS_TRASHMAN][TrashmanInfoGr];
new TMInfo[MAX_PLAYERS][TrashmanInfo];

// FUNCS
Dialog:trashmandialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] == INVALID_VEHICLE_ID)
				{
					if(TMInfo[playerid][LeaderTM] != 1) return SendErrorMessage(playerid, " Ban khong phai la truong nhom nen khong the lay xe.");
	                if(!IsPlayerInRangeOfPoint(playerid, 4,2208.2852,-2025.0245,13.5469)) return SendErrorMessage(playerid," Ban khong o gan noi lam viec.");
	                if(LamViec[playerid] != 0) return  SendClientMessage(playerid, COLOR_GREY, "Ban dang lam cong viec khac khong the lam Trashman.");  
	                SendClientMessage(playerid, COLOR_VANG, "Ban da bat dau lam viec Trashman hay di den checkpoint, su dung /trogiuptrashman de biet them chi tiet.");
	                ActSetPlayerPos(playerid, 2202.8777,-2047.4569,15.2173);
	                TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = CreateVehicle(408, 2202.8777,-2047.4569,15.2173 , 45.5 , 0, 0, 1000, 0);
	                ActPutPlayerInVehicle(playerid, TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] ,0);
	                for(new i = 0; i < MAX_PLAYERS; i++)
	                {
	                	if(TMInfo[playerid][GroupIDTM] == TMInfo[i][GroupIDTM])
	                	{
	                		LamViec[i] = 3;
	                	}
	                }
				}
				else return SendErrorMessage(playerid, " Nhom cua ban da lay xe roi!");
			}
			case 1:
			{
				return 1;
			}
		}
	}
	return 1;
}

// HOOKS
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == 0) return 1;
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 2208.2852,-2025.0245,13.5469))
	{
	    if(PRESSED(KEY_YES))
	    {
	    	Dialog_Show(playerid, trashmandialog, DIALOG_STYLE_LIST, "Quan ly bai rac", "Lay xe lam viec \n /trogiuptrashman", "Lua chon", "Huy bo");
	    }
	}
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	new string[555];
	if(TMInfo[playerid][LeaderTM] == 1)
	{
		DestroyVehicle(TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle]);
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMLeader] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
		TMInfo[playerid][LeaderTM] = 0;
		TMInfo[playerid][GroupIDTM] = 0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(playerid != i)
			{
				if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					SendClientMessage(playerid, COLOR_VANG, "[TM GROUP]: Nhom cua ban da bi giai tan! {ff4747}[LEADER DISCONNECTED]");
					TMInfo[playerid][GroupIDTM] = 0;
				}
			}
		}
	}
	else
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(playerid != i)
			{
				format(string, sizeof(string), "[TM GROUP]: Nguoi choi %s da thoat khoi nhom. {ff4747}[DISCONNECTED]", GetPlayerNameEx(playerid));
				SendClientMessage(playerid, COLOR_VANG, string);
			}
		}
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers]--; 
		TMInfo[playerid][GroupIDTM] = 0;
	}
	return 1;
}
// COMMANDS
CMD:createteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][GroupIDTM] != 0) return SendErrorMessage(playerid, " Ban da o trong mot nhom nao do roi!");
	for(new i = 1; i < MAX_GROUPS_TRASHMAN; i++)
	{
		if(TMGInfo[i][TMMembers] == 0)
		{
			new string[555];
			TMInfo[playerid][LeaderTM] = 1;
			TMInfo[playerid][GroupIDTM] = i;
			TMGInfo[i][TMLeader] = playerid;
			TMGInfo[i][TMMembers]++;
			format(string, sizeof(string), "[TRASHMAN]: {ffffff}Ban da tao thanh cong nhom lam viec, ID nhom ban la: {ff4747}%d{ffffff}.", i);
			TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
		}
		return 1;
	}
	return 1;
}
CMD:leaveteam(playerid, params[])
{
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban dang khong o trong mot nhom nao het!");
	new string[555];
	if(TMInfo[playerid][LeaderTM] == 1)
	{
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMLeader] = 0;
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMVehicle] = INVALID_VEHICLE_ID;
		TMInfo[playerid][LeaderTM] = 0;
		TMInfo[playerid][GroupIDTM] = 0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(playerid != i)
			{
				if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
				{
					SendClientMessage(playerid, COLOR_VANG, "[TM GROUP]: Nhom cua ban da bi giai tan!");
					TMInfo[playerid][GroupIDTM] = 0;

				}
			}
		}
	}
	else
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(playerid != i)
			{
				format(string, sizeof(string), "[TM GROUP]: Nguoi choi %s da thoat khoi nhom.", GetPlayerNameEx(playerid));
				SendClientMessage(playerid, COLOR_VANG, string);
			}
		}
		TMGInfo[TMInfo[playerid][GroupIDTM]][TMMembers]--; 
		TMInfo[playerid][GroupIDTM] = 0;
		SendClientMessage(playerid, COLOR_VANG, "Ban da roi khoi nhom lam viec trashman thanh cong!");
	}
	return 1;
}
CMD:kickteam(playerid, params[])
{
	if(TMInfo[playerid][LeaderTM] == 0) return SendErrorMessage(playerid, " Ban khong co quyen su dung lenh nay.");
	new
		iTargetID,
		string[555];

	if(sscanf(params, "u", iTargetID)) {
		SendUsageMessage(playerid, " /kickteam [id player]");
	}
	else if(IsPlayerConnected(iTargetID))
	{
		if(iTargetID == playerid) return SendErrorMessage(playerid, " Ban khong the kick chinh minh.");
		if(TMInfo[iTargetID][GroupIDTM] != TMInfo[playerid][GroupIDTM]) return SendErrorMessage(playerid, " Nguoi do khong o trong nhom cua ban");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(i != playerid)
			{
				if(i != iTargetID)
				{
					format(string, sizeof(string), "[TM GROUP]: %s da bi kick ra khoi nhom boi %s.", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
					SendClientMessage(playerid, COLOR_VANG, string);
				}
			}
		}
		TMGInfo[TMInfo[iTargetID][GroupIDTM]][TMMembers]--; 
		TMInfo[iTargetID][GroupIDTM] = 0;
		SendClientMessage(iTargetID, COLOR_VANG, "Ban da moi bi truong nhom kick!");
	}
	else return SendErrorMessage(playerid, " ID nguoi choi khong hop le.");
	return 1;
}

CMD:inviteteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][LeaderTM] == 0) return SendErrorMessage(playerid, " Ban khong co quyen su dung lenh nay.");
	new
		iTargetID,
		string[555];

	if(sscanf(params, "u", iTargetID)) {
		SendUsageMessage(playerid, " /inviteteam [id player]");
	}
	else if(IsPlayerConnected(iTargetID))
	{
		if(iTargetID == playerid) return SendErrorMessage(playerid, " Ban khong the moi chinh minh.");
		if(TMInfo[iTargetID][GroupIDTM] != 0) return SendErrorMessage(playerid, " Nguoi choi ma ban moi da o trong mot nhom khac.");
		format(string, sizeof(string), "[TRASHMAN]: {ffffff}Nguoi choi {ff4747}%s(%d){ffffff} muon moi ban vao nhom lam viec TRASHMAN (don rac) cua ho.", GetPlayerNameEx(playerid), playerid);
		SendClientMessage(iTargetID, COLOR_LIGHTRED, string);
		SendClientMessage(iTargetID, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}su dung {ff4747}/acceptteam{ffffff} de chap nhan vao nhom.");
		SendClientMessage(iTargetID, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}hoac su dung {ff4040}/declineteam{ffffff} de {ff3030}tu choi {ffffff}vao nhom.");
		format(string, sizeof(string), "[TRASHMAN]: {ffffff}Ban da moi nguoi choi {ff4747}%s(%d){ffffff} vao nhom, hay doi ho chap nhan.", GetPlayerNameEx(iTargetID), playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		SetPVarInt(playerid, #invitedgroup, TMInfo[playerid][GroupIDTM]);
	}
	else return SendErrorMessage(playerid, " ID nguoi choi khong hop le.");
	return 1;
}
CMD:acceptteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(GetPVarInt(playerid, #invitedgroup) == 0) return SendErrorMessage(playerid, " Ban khong nhan duoc loi moi tu bat ki ai.");
	if(TMGInfo[GetPVarInt(playerid, #invitedgroup)][TMMembers] > 3) return SendErrorMessage(playerid, " Nhom da day, vui long tham gia nhom khac."), SetPVarInt(playerid, #invitedgroup, 0);
	if(TMInfo[playerid][GroupIDTM] != 0) return SendErrorMessage(playerid, " Ban dang o trong mot nhom nao do roi."), SetPVarInt(playerid, #invitedgroup, 0);

	TMInfo[playerid][GroupIDTM] = GetPVarInt(playerid, #invitedgroup);
	TMGInfo[GetPVarInt(playerid, #invitedgroup)][TMMembers]++;
	SetPVarInt(playerid, #invitedgroup, 0);
	return 1;
}
CMD:declineteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(GetPVarInt(playerid, #invitedgroup) == 0) return SendErrorMessage(playerid, " Ban khong nhan duoc loi moi tu bat ki ai.");
	SetPVarInt(playerid, #invitedgroup, 0);
	SendClientMessage(playerid, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}Ban da tu choi loi moi tham gia nhom lam viec trashman thanh cong.");
	return 1;
}
CMD:radioteam(playerid, params[])
{
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec.");
	if(TMInfo[playerid][GroupIDTM] == 0) return SendErrorMessage(playerid, " Ban khong o trong bat ki nhom nao!");
	new string[555];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(TMInfo[i][GroupIDTM] == TMInfo[playerid][GroupIDTM])
		{
			if(!isnull(params))
			{
				format(string, sizeof(string), "[TM GROUP] {EA906C}%s(%d): %s", GetPlayerNameEx(playerid), i, params);
				SendClientMessage(playerid, COLOR_LIGHTRED, string);
				format(string, sizeof(string), "(radio) %s", params);
				SetPlayerChatBubble(playerid, string, COLOR_WHITE, 15.0, 5000);
			}
			else return SendUsageMessage(playerid, " /radioteam [text] hoac /rd [text]");
		}
	}
	return 1;
}
CMD:rd(playerid, params[]) {
	return cmd_radioteam(playerid, params);
}
