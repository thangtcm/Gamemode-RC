//MYSQl
#define SENDDATA_FARM               (1)
#define SENDDATA_CROPTIMER          (2)
#define SENDDATA_ANIMALTIMER        (3)
#define FARM_DEFAULT                (0)
#define FARM_RENT                   (1)
#define FARM_OWNER                  (2)
#define MAX_FARM                    1000

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

new FarmInfo[MAX_FARM][fmInfo];
new FarmPlayer[MAX_PLAYERS];
forward OnCreateFarmFinish(playerid, farmid, type);
forward OnLoadFarms();

