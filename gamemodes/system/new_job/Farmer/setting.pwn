//MYSQl
#define SENDDATA_FARM               (1)
#define SENDDATA_PLANTS          	(2)
#define SENDDATA_CATTLE        		(3)
#define SENDDATA_ORDERPRODUCT    	(4)
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
#define OBJ_DEER                    19315
#define OBJ_COW                     19833
#define WEIGHT_DEFAULT				10
#define Plant_ZDefault              100.75
#define CATTLE_TIME					600 //5 phut
#define MAX_ORDERPRODUCT			10

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
	c_Name[32],
	c_ObjectSpawn,
	Text3D:c_Text,
	c_SpawnPos,
	c_CattleTimer,
	c_Model,
	Float:c_Pos[4],
    Exsits
}

enum TreeGolbal{
	PlantName[32],
	PlantBuy,
	PlantSell,
	PlantProduct[32]
}

new PlantArr[][TreeGolbal] ={
	{"Hat Giong Lua", 5, 15, "Lua"},
	{"Hat Giong Duoc Lieu", 35, 65, "Thao Duoc"}
};

enum AnimalInfo{
	AnimalName[32],
	AnimalBuy,
	AnimalSell,
	AnimalProduct[32],
	AnimalModel
}

new AnimalArr[][AnimalInfo] ={
	{"Giong Bo", 500, 55, "Thit", 19833},
	{"Giong Nai", 400, 80, "Thit", 19315}
};

new FarmInfo[MAX_FARM][fmInfo];
new PlantTreeInfo[MAX_PLAYERS][MAX_PLAYER_PLANT][PLANT_INFO];
new RaiseCattleInfo[MAX_PLAYERS][MAX_CATTLES][CATTLE_INFO];
new FarmPlayer[MAX_PLAYERS];
forward OnCreateFarmFinish(playerid, index, type);
forward OnLoadFarms();
forward OnLoadPlants(playerid);
forward OnLoadCattles(playerid);
forward OnLoadOrderProduct(playerid);
new CostCow = 500;
new CostDeer = 500;
forward DangGieoGiong(playerid, plantId);

new Float:CattlePosDefault[2][4]=
{
	{-1425.0, -1464.4, 100.68, 90.0}, //8
	{-1417.0, -1464.3, 100.68, 270.0}
};

enum CattlePosInfo{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:RotZ,
	Exsits
}

new CattlePosData[MAX_PLAYERS][MAX_CATTLES][CattlePosInfo];

enum OrderFlourData{
	Id,
	OrderTimer,
	OrderQuantity,
	OwnerPlayerSQL,
	ProductName[32],
	Exsits
}

new OrderFlourInfo[MAX_PLAYERS][MAX_ORDERPRODUCT][OrderFlourData];
/* Ngang Left:
	-1425 -1462.9 100.68 , 90
	0		1.5		0		0

	Ngang Right
	-1417 -1462.7 100.68
	0		1.6		0

*/