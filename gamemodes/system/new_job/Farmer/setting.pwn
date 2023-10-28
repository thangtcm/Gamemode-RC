//MYSQl
#define SENDDATA_FARM               (1)
#define SENDDATA_PLANTS          (2)
#define SENDDATA_CATTLE        (3)
#define FARM_DEFAULT                (0)
#define FARM_RENT                   (1)
#define FARM_OWNER                  (2)
#define MAX_FARM                    1000
#define MAX_PLAYER_PLANT            50
#define PLANT_TINE_LEVEL_1          120
#define PLANT_TINE_LEVEL_2          180
#define PLANT_TINE_LEVEL_3          180
#define MAX_CATTLES                 16
#define CATTLE_DEFAULT_STATUS       0
#define ROW_1_POS_X                 -1424
#define ROW_1_POS_Y                 -1464
#define ROW_1_POS_Z                 101

#define ROW_2_POS_X                 -1417
#define ROW_2_POS_Y                 -1464
#define ROW_2_POS_Z                 101
#define OBJ_DEER                    19315
#define OBJ_COW                     19833

#define Plant_ZDefault              100.75

enum fmInfo
{
    Id,
    OwnerPlayerId,
	OwnerName[MAX_PLAYER_NAME],
    VirtualWorld,
    Float:ExteriorX,
    Float:ExteriorY,
    Float:ExteriorZ,
    FarmType,
    FarmPrice,
    RentFee,
    RentTimer,
    Exsits,
    fPickupID,
	Text3D: fTextID
};

enum PLANT_INFO{
	Id,
	plantLevel,
    OwnerPlayerId,
	plantType,
	plantTimer,
	ObjectSpawn,
	Text3D:PlantText,
	Float:plantPos[3],
    Exsits
}

enum CATTLE_INFO{
	Id,
	c_Weight,
	c_Status,
	c_Timer,
	OwnerPlayerId,
	c_ObjectSpawn,
	Text3D:c_Text,
	c_CattleTimer,
	c_Animal,
	Float:c_Pos[3],
    Exsits
}

enum TreeGolbal{
	PlantName[32],
	PlantBuy,
	PlantSell,
	PlantProduct[32]
}

new PlantArr[][TreeGolbal] ={
	{"Hat Giong Lua", 5, 10, "Lua"},
	{"Hat Giong Duoc Lieu", 50, 100, "Thao Duoc"}
};

new FarmInfo[MAX_FARM][fmInfo];
new PlantTreeInfo[MAX_PLAYERS][MAX_PLAYER_PLANT][PLANT_INFO];
new RaiseCattleInfo[MAX_PLAYERS][MAX_CATTLES][CATTLE_INFO];
new FarmPlayer[MAX_PLAYERS];
forward OnCreateFarmFinish(playerid, index, type);
forward OnLoadFarms();
forward OnLoadPlants(playerid);
forward OnLoadCattles(playerid);
new CostCow = 500;
new CostDeer = 500;
forward DangGieoGiong(playerid, plantId);

new CattlePosClaim[2][4]=
{
	{-1424, -1464.4, 100.68, 90},
	{-1417, -1464, 101}
};

/* Ngang Left:
	-1425 -1462.8 100.68 , 90


	Ngang Right

*/