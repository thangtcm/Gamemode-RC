#define MAX_PLAYER_PLANT 100
#define PLANT_TINE_LEVEL_1 60
#define PLANT_TINE_LEVEL_2 120
#define PLANT_TINE_LEVEL_3 180
new CountPlayerPlant[MAX_PLAYERS];
enum PLANT_INFO{
	pi_ID,
	pi_Level,
	pi_Time,
	pi_Timer,
	pi_Object,
	Text3D:pi_Text,
	Float:pi_PosX,
	Float:pi_PosY,
	Float:pi_PosZ,
}
new PlantTreeInfo[MAX_PLAYERS][MAX_PLAYER_PLANT][PLANT_INFO];
hook OnPlayerConnect(playerid)
{
	for(new i = 0; i < MAX_PLAYER_PLANT; i++) {
		PlantTreeInfo[playerid][i][pi_ID] = -1;
	}
}
FreePlantID(playerid)
{
	if(CountPlayerPlant[playerid] >= MAX_PLAYER_PLANT) return -1;
	new freeid;
	for(new i = 0; i < MAX_PLAYER_PLANT; i++)
	{
		if(PlantTreeInfo[playerid][i][pi_ID] == -1)
		{
			freeid = i;
			break;
		}
	}
	return freeid;
}
PlantTree(playerid)
{
	if(PlayerInfo[playerid][pCayGiong] <= 0) return SendFarmerJob(playerid, "Ban can phai co hat giong de thuc hien trong cay");
	PlayerInfo[playerid][pCayGiong] --;
	new idplant = FreePlantID(playerid);
	if(idplant == -1) return SendFarmerJob(playerid, "Ban da dat gioi han cay trong !");

	PlantTreeInfo[playerid][idplant][pi_ID] = idplant;
	PlantTreeInfo[playerid][idplant][pi_Level] = 1;
	PlantTreeInfo[playerid][idplant][pi_Time] = PLANT_TINE_LEVEL_1;
	new Float:PosPlant[3];
	GetPlayerPos(playerid, PosPlant[0], PosPlant[1], PosPlant[2]);
	PlantTreeInfo[playerid][idplant][pi_PosX] = PosPlant[0];
	PlantTreeInfo[playerid][idplant][pi_PosY] = PosPlant[1];
	PlantTreeInfo[playerid][idplant][pi_PosZ] = PosPlant[2];

	PlantTreeInfo[playerid][idplant][pi_Object] = CreateDynamicObject(19837, 
							PlantTreeInfo[playerid][idplant][pi_PosX],
							PlantTreeInfo[playerid][idplant][pi_PosY],
							PlantTreeInfo[playerid][idplant][pi_PosZ]-1, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	new plantinfomsg[1280];
	format(plantinfomsg, sizeof(plantinfomsg), 
		"Cay So {212c58}%d{FFFFFF}\n\
		Cap do: {212c58}%d{FFFFFF}\n\
		Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
		Chu so huu: {212c58}%s{FFFFFF}\n\
		Thu hoach: {FF0000}Chua{FFFFFF}", 
		PlantTreeInfo[playerid][idplant][pi_ID],
		PlantTreeInfo[playerid][idplant][pi_Level],
		PlantTreeInfo[playerid][idplant][pi_Time],
		GetPlayerNameEx(playerid));

	PlantTreeInfo[playerid][idplant][pi_Text] = CreateDynamic3DTextLabel(plantinfomsg, -1, 
							PlantTreeInfo[playerid][idplant][pi_PosX],
							PlantTreeInfo[playerid][idplant][pi_PosY],
							PlantTreeInfo[playerid][idplant][pi_PosZ]-1, 50);
	CountPlayerPlant[playerid]++;
	if(PlantTreeInfo[playerid][idplant][pi_Text] && PlantTreeInfo[playerid][idplant][pi_Object]) return 1;
	else return 0;
}
CMD:trongcay(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 100, -272.7119,-1362.5492,9.4217) && PlayerInfo[playerid][pJob] == JOB_FARMER || PlayerInfo[playerid][pJob2] == JOB_FARMER)
	{
		if(PlantTree(playerid)) SendFarmerJob(playerid, "Ban da trong {00FF00}thanh cong{FFFFFF} 1 cay giong");
		else SendFarmerJob(playerid, "Ban da trong {FF0000}that bai{FFFFFF} 1 cay giong");
	}
	else SendFarmerJob(playerid, "Ban khong phai nong dan hoac khong o trong khu vuc trong cay");
	return 1;
}
CMD:trongz(playerid, params[])
{
	PlayerInfo[playerid][pCayGiong] = 100;
	return 1;
}

task UpdatePlant[1000]()
{
	foreach(new playerid: Player)
	{
		for(new plant_id = 0; plant_id < CountPlayerPlant[playerid]; plant_id++)
		{
			if(PlantTreeInfo[playerid][plant_id][pi_Time] > 0)
			{
				PlantTreeInfo[playerid][plant_id][pi_Time] --;

				new plantinfomsg[1280];
				format(plantinfomsg, sizeof(plantinfomsg), 
					"Cay So {212c58}%d{FFFFFF}\n\
					Cap do: {212c58}%d{FFFFFF}\n\
					Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
					Chu so huu: {212c58}%s{FFFFFF}\n\
					Thu hoach: {FF0000}Chua{FFFFFF}", 
					PlantTreeInfo[playerid][plant_id][pi_ID],
					PlantTreeInfo[playerid][plant_id][pi_Level],
					PlantTreeInfo[playerid][plant_id][pi_Time],
					GetPlayerNameEx(playerid));
				UpdateDynamic3DTextLabelText(PlantTreeInfo[playerid][plant_id][pi_Text], -1, plantinfomsg);
			}
			else if(PlantTreeInfo[playerid][plant_id][pi_Time] <= 0)
			{
				switch(PlantTreeInfo[playerid][plant_id][pi_Level])
				{
					case 1:{
						PlantTreeInfo[playerid][plant_id][pi_Level] ++;
						PlantTreeInfo[playerid][plant_id][pi_Time] = PLANT_TINE_LEVEL_2;
						DestroyDynamicObject(PlantTreeInfo[playerid][plant_id][pi_Object]);

						PlantTreeInfo[playerid][plant_id][pi_Object] = CreateDynamicObject(19473, 
								PlantTreeInfo[playerid][plant_id][pi_PosX],
								PlantTreeInfo[playerid][plant_id][pi_PosY],
								PlantTreeInfo[playerid][plant_id][pi_PosZ]-1, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

					}
					case 2:{
						PlantTreeInfo[playerid][plant_id][pi_Level] ++;
						PlantTreeInfo[playerid][plant_id][pi_Time] = PLANT_TINE_LEVEL_3;
						DestroyDynamicObject(PlantTreeInfo[playerid][plant_id][pi_Object]);

						PlantTreeInfo[playerid][plant_id][pi_Object]= CreateDynamicObject(804, 
								PlantTreeInfo[playerid][plant_id][pi_PosX],
								PlantTreeInfo[playerid][plant_id][pi_PosY],
								PlantTreeInfo[playerid][plant_id][pi_PosZ]-0.5, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
						
					}
					case 3:{
						new plantinfomsg[1280];
						format(plantinfomsg, sizeof(plantinfomsg), 
							"Cay So {212c58}%d{FFFFFF}\n\
							Cap do: {212c58}%d{FFFFFF}\n\
							Thoi gian phat trien: {212c58}%d{FFFFFF},\n\
							Chu so huu: {212c58}%s{FFFFFF}\n\
							Su dung {212c58}/thuhoach %d{FFFFFF} de thu hoach", 
							PlantTreeInfo[playerid][plant_id][pi_ID],
							PlantTreeInfo[playerid][plant_id][pi_Level],
							PlantTreeInfo[playerid][plant_id][pi_Time],
							GetPlayerNameEx(playerid),
							PlantTreeInfo[playerid][plant_id][pi_ID]);
						UpdateDynamic3DTextLabelText(PlantTreeInfo[playerid][plant_id][pi_Text], -1, plantinfomsg);
					}
				}
			}
		}
	}
}

CMD:settimep(playerid, params[])
{
	new idplantp, time;
	if(sscanf(params, "ii", idplantp, time)) return SendUsageMessage(playerid, "/settimep [plant id] [time]");

	PlantTreeInfo[playerid][idplantp][pi_Time] = time;
	return 1;
}

CMD:thuhoach(playerid, params[])
{
	new idplantp;
	if(sscanf(params, "i", idplantp)) return SendUsageMessage(playerid, "/thuhoach [id]");

	if(PlantTreeInfo[playerid][idplantp][pi_Time] == 0 && PlantTreeInfo[playerid][idplantp][pi_Level] == 3)
	{
		DestroyDynamicObject(PlantTreeInfo[playerid][idplantp][pi_Object]);
		DestroyDynamic3DTextLabel(PlantTreeInfo[playerid][idplantp][pi_Text]);

		PlantTreeInfo[playerid][idplantp][pi_ID] = -1;
		PlantTreeInfo[playerid][idplantp][pi_Time] = 0;
		PlantTreeInfo[playerid][idplantp][pi_Level] = 0;

		PlantTreeInfo[playerid][idplantp][pi_PosX] = 0.0;
		PlantTreeInfo[playerid][idplantp][pi_PosY] = 0.0;
		PlantTreeInfo[playerid][idplantp][pi_PosZ] = 0.0;
		PlantTreeInfo[playerid][idplantp][pi_Object] = -1;

		PlayerInfo[playerid][pCayThuHoach] ++;

		new thuhoachmsg[1280];
		format(thuhoachmsg, sizeof(thuhoachmsg), "Ban da thu hoach thanh cong cay so %d", idplantp);
		SendFarmerJob(playerid, thuhoachmsg);
	}
	else SendFarmerJob(playerid, "Cay nay van chua the thu hoach !");
	return 1;
}

CMD:setjob(playerid, params[])
{
	new playersetjob, jobid;
	if(sscanf(params, "ii", playersetjob, jobid)) return SendUsageMessage(playerid, "/setjob [playerid] [jobid]");

	PlayerInfo[playersetjob][pJob] = jobid;
	PlayerInfo[playersetjob][pJob2] = jobid;
	return 1;
}