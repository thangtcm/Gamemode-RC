
new Float:PosSpamXeLincese[13][4] = {
	{1445.9119,-1837.9928,13.2016,88.0349},
	{1456.4446,-1838.3541,13.2029,88.0348},
	{1468.9463,-1838.7815,13.2062,88.0344},
	{1484.0825,-1839.3005,13.2060,88.0341},
	{1500.9413,-1839.8793,13.2037,88.0343},
	{1519.9199,-1840.5289,13.2050,88.0341},
	{1535.8464,-1841.0750,13.2059,88.0338},
	{1532.2242,-1845.2850,13.2027,89.2910},
	{1515.8356,-1845.0823,13.1972,89.2909},
	{1496.7513,-1844.8461,13.2005,89.2913},
	{1477.4598,-1844.6074,13.1970,89.2915},
	{1451.9580,-1844.2924,13.1965,89.2920},
	{1433.6875,-1844.0659,13.1965,89.2914}
};



new Float:CheckPointLincense[19][3] = {
{1396.2833,-1854.1860,13.1987},
{1308.9808,-1851.7272,13.0378},
{1066.1506,-1852.4757,13.0503},
{920.3820,-1772.8195,13.0435},
{918.4958,-1564.0211,13.0383},
{917.0357,-1404.9038,12.9121},
{1358.0099,-1401.8512,12.9620},
{1455.8229,-1444.2722,13.0435},
{1677.1183,-1442.5297,13.0362},
{1850.2520,-1461.0669,13.0506},
{2106.7249,-1465.4827,23.4856},
{2086.7739,-1753.6436,13.0571},
{1834.9203,-1749.9318,13.0361},
{1705.7441,-1731.6935,13.0360},
{1572.7560,-1732.0654,13.0385},
{1391.3323,-1742.4547,13.0367},
{1430.3444,-1831.0839,13.1935},
{1430.3444,-1831.0839,13.1935},
{1430.3444,-1831.0839,13.1935}
};
new PlayerLincenseAttemp[MAX_PLAYERS];
new VehicleDrivertest[MAX_PLAYERS];

CMD:thibanglai(playerid,parmas[]) {
	if(PlayerInfo[playerid][pCarLic]) return SendErrorMessage(playerid, " Ban da co bang lai xe roi."); 
	if(GetPVarInt(playerid, "is_DriverTest") == 1) return SendErrorMessage(playerid, " Ban dang thi bang lai roi khong the tiep tuc.");
<<<<<<< HEAD
	if(!IsPlayerInRangeOfPoint(playerid, 3, 1222.5018,243.8309,19.5469)) return SendErrorMessage(playerid," Ban khong o gan noi thi bang lai.");
=======
	if(!IsPlayerInRangeOfPoint(playerid, 3, 1222.7645,243.7523,19.5469)) return SendErrorMessage(playerid," Ban khong o gan noi thi bang lai.");
>>>>>>> main
    SendClientMessageEx(playerid, COLOR_YELLOW, "Ban dang bat dau thi bang lai, hay thuc hien hoan thanh bai kiem tra thuc hanh nhe.");
    SendClientMessageEx(playerid, COLOR_YELLOW, "Dieu kien de hoan thanh: khong vuot qua 70 km/h, phuong tien khong bi hu hong.");
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

        if(PlayerLincenseAttemp[playerid] == 17) {
        	new Float:vehhp;
			new vehicleid = GetPlayerVehicleID(playerid);
        	GetVehicleHealth(vehicleid,vehhp);
        	if(vehhp < 900 || GetVehicleSpeed(vehicleid) >= 70) {
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
