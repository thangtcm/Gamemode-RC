#define MAX_INVENTORY_ITEM 30 // 
#define MAX_INVENTORY_SLOT 60 // 
#define  MAX_OBJECTS_ITEMS 300 //
// textdraw


// player inv
enum player_inventory {
	pSlot[MAX_INVENTORY_SLOT],
	pSoLuong[MAX_INVENTORY_ITEM],
}
new InventoryInfo[MAX_PLAYERS][player_inventory];


// car inv
enum invpvinfo {
	pSlot[MAX_INVENTORY_SLOT],
	pSoLuong[MAX_INVENTORY_ITEM],
}
new VehicleInventory[MAX_PLAYERS][MAX_PLAYERVEHICLES][invpvinfo];


enum ItemObj {
	WorldID,
	Interior,
	ItemID,
	Float:jtemPos[3],
	ObjectID,
	bool:ObjectItemSet,
	Text3D:ItemTextID,
}
new ItemInfo[MAX_OBJECTS_ITEMS][ItemObj];
