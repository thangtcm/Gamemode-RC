
new Float:PosSpamXeLincese[13][4] = {
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938},
	{1228.9402,240.5223,19.4063,158.6938}
};



new Float:CheckPointLincense[21][3] = {
	{1243.7153,269.0829,19.4063}, //1
	{1201.8435,291.4996,19.4063}, //2
	{1226.1063,353.0921,19.4063}, //3
	{1274.4603,339.2561,19.4115}, //4
	{1296.4961,376.2139,19.4063}, //5
	{1338.5752,359.3585,19.4063}, //6
	{1317.5883,312.8614,19.4063}, //7
	{1363.9290,291.6877,19.4063}, //8
	{1336.5966,227.8452,19.4063}, //9
	{1390.1343,204.8535,19.4063}, //10
	{1440.6486,183.0667,22.8004}, //11
	{1488.1987,163.7778,29.8833}, //12
	{1527.3568,105.6040,29.4787}, //13
	{1462.4253,61.2825,30.6948}, //14
	{1407.7551,14.5576,32.4829}, //15
	{1301.5416,-78.6849,36.4803}, //16
	{1249.7988,3.5941,27.2588}, //17
	{1243.3496,139.0621,19.8191}, //18
	{1262.0869,183.2326,19.4063}, //19
	{1219.6520,207.8302,19.4063}, //20
	{1228.9402,240.5223,19.4063} //end task
};
new PlayerLincenseAttemp[MAX_PLAYERS];
new VehicleDrivertest[MAX_PLAYERS];

CMD:thibanglai(playerid,parmas[]) {
	if(PlayerInfo[playerid][pCarLic]) return SendErrorMessage(playerid, " Ban da co bang lai xe roi."); 
	if(GetPVarInt(playerid, "is_DriverTest") == 1) return SendErrorMessage(playerid, " Ban dang thi bang lai roi khong the tiep tuc.");
	if(!IsPlayerInRangeOfPoint(playerid, 3, 1222.5018,243.8309,19.5469)) return SendErrorMessage(playerid," Ban khong o gan noi thi bang lai.");
    SendClientMessageEx(playerid, COLOR_YELLOW, "Ban dang bat dau thi bang lai, hay thuc hien hoan thanh bai kiem tra thuc hanh nhe.");
    SendClientMessageEx(playerid, COLOR_YELLOW, "Dieu kien de hoan thanh: khong vuot qua 60 km/h, phuong tien khong bi hu hong.");
    new pos = random(13);
    SetPlayerPos(playerid,PosSpamXeLincese[pos][0],PosSpamXeLincese[pos][1],PosSpamXeLincese[pos][2]);
    VehicleDrivertest[playerid] = CreateVehicle(410, PosSpamXeLincese[pos][0],PosSpamXeLincese[pos][1],PosSpamXeLincese[pos][2],PosSpamXeLincese[pos][3], 1, 1, -1);
    PutPlayerInVehicle(playerid, VehicleDrivertest[playerid], 0);
    PlayerLincenseAttemp[playerid] = 0;

    SetPlayerRaceCheckpoint(playerid, 0, CheckPointLincense[PlayerLincenseAttemp[playerid]][0],CheckPointLincense[PlayerLincenseAttemp[playerid]][1],CheckPointLincense[PlayerLincenseAttemp[playerid]][2],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][0],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][1],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][2], 5);
    SetPVarInt(playerid, "is_DriverTest", 1);
    SendClientTextDraw(playerid, " Ban da bat dau ~g~thi bang lai~w~ hay di theo ~r~Checkpoint");

    return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "is_DriverTest") == 1) 
	{
	    PlayerLincenseAttemp[playerid]++; 

        if(PlayerLincenseAttemp[playerid] == 21) {
        	new Float:vehhp;
			new vehicleid = GetPlayerVehicleID(playerid);
        	GetVehicleHealth(vehicleid,vehhp);
        	if(vehhp < 900 || GetVehicleSpeed(vehicleid) >= 60) {
        		SendClientMessageEx(playerid,COLOR_VANG,"Ban da that bai trong bai kiem tra thuc hanh, ban khong duoc nhan bang lai xe.");
        		DestroyVehicle(VehicleDrivertest[playerid]);
        		DeletePVar(playerid, "is_DriverTest");
        		DisablePlayerRaceCheckpoint(playerid);
        		PlayerLincenseAttemp[playerid] = 0;
        		return 1;
        	}
        	SendClientMessageEx(playerid,COLOR_VANG,"Ban da hoan thanh cong thi va nhan duoc bang lai xe");
        	PlayerInfo[playerid][pCarLic] = 1;
        	DestroyVehicle(VehicleDrivertest[playerid]);
        	DeletePVar(playerid, "is_DriverTest");
            DisablePlayerRaceCheckpoint(playerid);
        	PlayerLincenseAttemp[playerid] = 0;
        	return 1;
        }
        else {
            SetPlayerRaceCheckpoint(playerid, 0, CheckPointLincense[PlayerLincenseAttemp[playerid]][0],CheckPointLincense[PlayerLincenseAttemp[playerid]][1],CheckPointLincense[PlayerLincenseAttemp[playerid]][2],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][0],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][1],CheckPointLincense[PlayerLincenseAttemp[playerid]+1][2], 5);
        }
	}
	return 1;
}
