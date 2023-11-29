#include <YSI_Coding\y_hooks>

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

CMD:createteam(playerid, params[])
{
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
			SendClientMessage(playerid, COLOR_LIGHTRED, string);
		}
		return 1;
	}
	return 1;
}
CMD:inviteteam(playerid, params[])
{
	if(TMInfo[playerid][LeaderTM] == 0) return SendErrorMessage(playerid, " Ban khong co quyen su dung lenh nay.");
	new
		iTargetID,
		string[555];

	if(sscanf(params, "u", iTargetID)) {
		SendUsageMessage(playerid, " /inviteteam [id nguoi ma ban muon moi]");
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
	if(GetPVarInt(playerid, #invitedgroup) == 0) return SendErrorMessage(playerid, " Ban khong nhan duoc loi moi tu bat ki ai.");
	SetPVarInt(playerid, #invitedgroup, 0);
	SendClientMessage(playerid, COLOR_LIGHTRED, "[TRASHMAN]: {ffffff}Ban da tu choi loi moi tham gia nhom lam viec trashman thanh cong.");
	return 1;
}
CMD:radioteam(playerid, params[])
{
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
