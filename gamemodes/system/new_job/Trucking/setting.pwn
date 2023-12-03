#define MAX_PRODUCT         (25)
#define MAX_CARTRUCK        (30)
#define MAX_FACTORY         (30)
#define MAX_PLAYERPRODUCT   (18)
#define MAX_OBJECTTRUCKER   (100)
forward VEHICLETRUCKER_LOAD(playerid);
forward OnAddVehicleTruckerFinish(playerid, index);
forward NextTutorialTruck(playerid);

enum VehicleTruckerInfo{
    vtId,
    vtPSQL,
    vtSlotId, //pvSlotId
    vtObject,
    Float:vtPos[6],
    vtProductID, //ID PRODUCTDATA
    vtFactoryID
};

new VehicleTruckerData[MAX_PLAYERS][MAX_OBJECTTRUCKER][VehicleTruckerInfo];

/* new const UnitType[][] = 
{
    {"Thung Hang"},//0
    {"Tan"}, //1
    {"Strongboxes"}, // 2
    {"Met Khoi"}, //3
    {"Lit"}, //4
    {"Khuc Go"}, //5
    {"Ke Hang"}, //6
    {"Transformer"},//7
    {"Phuong Tien"},//8,
    {"Not Working"}//9
}; */

enum ProductInfo{
    ProductName[32],
    ProductUnitID,
    ItemReceived[32], //-- Để sau này thêm sản phẩm nhận kèm khi hoàn thành
    Percen
};

new const ProductData[][ProductInfo] = {
    { "Transformer", 7 }, // 0
    { "Car parts", 9 }, // 1
    { "Do gia dung", 0 }, // 2
    { "Giay", 0 }, // 3
    { "Noi that", 0 }, // 4
    { "Quan ao", 0 }, // 5
    { "Sat thep", 0, "Sat", 4}, // 6
    { "Thit", 0, "Thit", 5}, // 7
    { "Thuc pham", 0, "Bread", 5 }, // 8
    { "Thuoc sung", 0, "Thuoc sung", 10}, // 9
    { "Trai cay", 0, "Trai Cay", 5 }, // 10
    { "Trung", 0 }, // 11
    { "Bot mi", 1 }, // 12
    { "Ngu coc", 1 }, // 13
    { "Phe lieu", 1, "Dong", 10}, // 14
    { "Vai cotton", 1 }, // 15
    { "Vat lieu", 1, "Vat lieu", 10 }, // 16
    { "Vu khi", 2 }, // 17
    { "Phuong tien", 8 }, // 18
    { "Thuoc nhuom", 3 }, // 19
    { "Xang dau", 3 }, // 20
    { "Sua", 4 }, // 21
    { "Go", 5, "Go", 30}, // 22
    { "Vat lieu xay dung", 6, "Vat lieu", 10}, // 23
    { "Thuc uong", 0, "Juice", 5 } // 24
};

enum CarTruckInfo{
    CarModel,
    CarName[40],
    CarUnitType[MAX_PLAYERPRODUCT],// danh sách vị trí đơn vị
    Weight
};

new CarTruckWorking[][CarTruckInfo] = {
    { 422, "Bobcat", { 0, -1, -1, -1, -1, -1, -1}, 2 },
    { 478, "Walton", { 0, -1, -1, -1, -1, -1, -1 }, 4 },
    { 543, "Sadler", { 0, -1, -1, -1, -1, -1, -1 }, 2 },
    { 600, "Picador", { 0, -1, -1, -1, -1, -1, -1 }, 2 },
    { 605, "Sadler Shit", { 0, -1, -1, -1, -1, -1, -1 }, 2 },
    { 554, "Yosemite", { 0, 6, -1, -1, -1, -1, -1 }, 6 },
    { 413, "Pony", { 0, -1, -1, -1, -1, -1, -1 }, 10 },
    { 459, "Topfun Van", { 0, -1, -1, -1, -1, -1, -1 }, 10 },
    { 482, "Burrito", { 0, -1, -1, -1, -1, -1, -1 }, 10 },
    { 498, "Boxville", { 0, -1, -1, -1, -1, -1, -1 }, 12 },
    { 440, "Rumpo", { 0, -1, -1, -1, -1, -1, -1 }, 12 },
    { 499, "Benson", { 0, 6, -1, -1, -1, -1, -1 }, 18 },
    { 414, "Mule", { 0, 6, -1, -1, -1, -1, -1 }, 18 },
    { 456, "Yankee", { 0, 6, -1, -1, -1, -1, -1 }, 24 }
};

enum FactoryInfo{ //Xuất khẩu
    IsLocked,
    FactoryName[108],
    ProductName[MAX_PRODUCT],// Danh sách ID ProductData
    ProductPrice[MAX_PRODUCT],
    Productivity[MAX_PRODUCT], 
    WareHouse[MAX_PRODUCT],
    MaxWareHouse[MAX_PRODUCT],
    Float:FactoryPos[3],
    ProductImportName[MAX_PRODUCT],
    ProductImportPrice[MAX_PRODUCT],
    ProductImport[MAX_PRODUCT],
    ImportWareHouse[MAX_PRODUCT],
    ImportMaxWareHouse[MAX_PRODUCT]
};

new FactoryData[][FactoryInfo] = {
    {//0
        false,
        "Green Palms Reafinery", 
        {20, -1}, 
        {300, -1},
        {40, -1}, 
        {640, -1},
        {640, -1},
        {260.7484,1412.1002,11.1693},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//1
        false,
        "Easter Bay Chemicals", 
        {9, 19, -1}, 
        {60, 160, -1},
        {30, 40, -1}, 
        {180, 260, -1},
        {180, 260, -1},
        {-992.8083,-696.1418,32.0078},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//2
        false,
        "Whetstone Scrap Yard", 
        {14, -1}, 
        {80, -1},
        {50, -1}, 
        {300, -1},
        {300, -1},
        {-1869.1418,-1717.2013,21.7500},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//3
        false,
        "The Panopticon Forest - West", 
        {22, -1}, 
        {300, -1},
        {5, -1}, 
        {20, -1},
        {20, -1},
        {-788.3041,-133.7872,64.5020},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//4
        false,
        "The Panopticon Forest - East", 
        {22, -1}, 
        {300, -1},
        {5, -1}, 
        {20, -1},
        {20, -1},
        {-528.1472,-191.3672,78.4063},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//5
        false,
        "The Impounder's Farm", 
        {15, 21, 7, -1}, 
        {30, 30, 70, -1},
        {15, 15, 8, -1}, 
        {100, 160, 60, -1},
        {100, 160, 60, -1},
        {-1058.7488,-1195.4639,129.2188},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//6
        false,
        "The Farm On a Rock", 
        {15, 21, -1}, 
        {30, 30, -1},
        {15, 15, -1}, 
        {100, 160, -1},
        {100, 160, -1},
        {-1448.5803,-1499.0050,101.3283},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//7
        false,
        "The Beacon Hill Eggs", 
        {11, -1}, 
        {50, -1},
        {10, -1}, 
        {100, -1},
        {100, -1},
        {-384.0244,-1041.0443,58.8835},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//8
        false,
        "EasterBoard Farm", 
        {13, 21, 7, -1}, 
        {50, 40, 80, -1},
        {50, 15, 8, -1}, 
        {350, 160, 60, -1},
        {350, 160, 60, -1},
        {-21.1862,81.3918,3.1096},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//9
        false,
        "The Palomino Farm", 
        {13, -1}, 
        {40, -1},
        {50, -1}, 
        {350, -1},
        {350, -1},
        {1938.3217,166.3846,37.2813},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//10
        false,
        "The Leafy Hollow Orchards", 
        {10, -1}, 
        {30, -1},
        {12, -1}, 
        {100, -1},
        {100, -1},
        {-1092.4702,-1622.1119,76.3672},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//11
        false,
        "The Hilltop Farm", 
        {7, 21, 11, -1}, 
        {90, 50, 70, -1},
        {8, 15, 10, -1}, 
        {60, 160, 100, -1},
        {60, 160, 100, -1},
        {1059.6445,-345.3934,73.9922},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//12
        false,
        "Fort Carson Quarry", 
        {16, -1}, 
        {30, -1},
        {50, -1}, 
        {300, -1},
        {300, -1},
        {325.7538,1147.9755,8.1741},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//13
        false,
        "Blueberry Distribution Hub", 
        {13, 10, 23, 6, 20, 19, 8, -1}, 
        {50, 50, 117, 165, 340, 170, 245, -1},
        {100, 100, 100, 100, 100, 100, 100, -1}, 
        {500, 1000, 1000, 1000, 1000, 1000, 1000, -1},
        {500, 1000, 1000, 1000, 1000, 1000, 1000, -1},
        {-226.1169,-190.0281,0.9920},
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1}
    },
    {//14
        false,
        "San Andreas Federal Weapon Factory", 
        {17, -1}, 
        {250, -1},
        {16, -1}, 
        {100, -1},
        {100, -1},
        {2511.4922,2799.9509,10.8203},
        {9, 6, -1}, 
        {300, 290, -1},
        {8, 8, -1}, 
        {0, 0, -1},
        {60, 100, -1}
    },
    {//15
        false,
        "San Andreas Steel Mill", 
        {6, -1}, 
        {90, -1},
        {15, -1}, 
        {200, -1},
        {200, -1},
        {2658.2119,-1591.6473,13.7133},
        {14, -1}, 
        {250, -1},
        {10, -1}, 
        {0, -1},
        {300, -1}
    },
    {//16
        false,
        "Angel Pine Sawmill", 
        {4, 3, -1}, 
        {220, 220, -1},
        {5, 30, -1}, 
        {50, 300, -1},
        {50, 300, -1},
        {-1999.1478,-2415.9165,30.6250},
        {22, -1}, 
        {3300, -1},
        {30, -1}, 
        {0, -1},
        {300, -1}
    },
    {//17
        false,
        "Doherty Textile Factory", 
        {5, -1}, 
        {210, -1},
        {20, -1}, 
        {200, -1},
        {200, -1},
        {-2121.7207,-264.5204,34.8916},
        {15, 19, -1}, 
        {130, 200, -1},
        {20, 10, -1}, 
        {0, 0, -1},
        {200, 100, -1}
    },
    {//18
        false,
        "FleischBerg Brewery", 
        {24, -1}, 
        {210, -1},
        {25, -1}, 
        {400, -1},
        {400, -1},
        {-58.0229,83.4377,3.1172},
        {12, -1}, 
        {340, -1},
        {5, -1}, 
        {0, -1},
        {120, -1}
    },
    {//19
        false,
        "SA Food Processing Plant", 
        {8, -1}, 
        {190, -1},
        {8, -1}, 
        {100, -1},
        {100, -1},
        {1052.5149,2134.7427,10.8203},
        {7, 13, 11, 10, -1}, 
        {170, 130, 170, 170, -1},
        {8, 8, 8, 8, -1}, 
        {0, 0, 0, 0, -1},
        {200, 200, 200, 200, -1}
    },
    {//20
        false,
        "Ocean Docks Concrete Plant", 
        {23, -1}, 
        {130, -1},
        {6, -1}, 
        {150, -1},
        {150, -1},
        {1059.6445,-345.3934,73.9922},
        {16, -1}, 
        {240, -1},
        {40, -1}, 
        {0, -1},
        {300, -1}
    },
    {//21
        false,
        "Fort Carson Distillery", 
        {24, - 1}, 
        {210, - 1},
        {10, - 1}, 
        {120, - 1},
        {120, - 1},
        {-116.8637,1133.0490,19.7422},
        {10, - 1}, 
        {170, - 1},
        {10, - 1}, 
        {0, - 1},
        {80, - 1}
    },
    {//22
        false,
        "Las Payasdas Malt House", 
        {12, -1}, 
        {230, -1},
        {20, -1}, 
        {120, -1},
        {120, -1},
        {-317.8109,2662.0435,63.0919},
        {13, -1}, 
        {190, -1},
        {20, -1}, 
        {0, -1},
        {120, -1}
    },
    {//23
        false,
        "Shafted Appliances", 
        {2, 0, -1}, 
        {210, 1000, -1},
        {25, 3, -1}, 
        {200, 30, -1},
        {200, 30, -1},
        {1703.7877,998.6878,10.8203},
        {6, -1}, 
        {235, -1},
        {15, -1}, 
        {0, -1},
        {150, -1}
    },
    {//24
        false,
        "Solarin Autos", 
        {18, 1, -1}, 
        {800, 250, -1},
        {5, 350, -1}, 
        {40, 65535, -1},
        {40, 65535, -1},
        {-1835.2246,115.1202,15.1172},
        {6, 19, -1}, 
        {280, 200, -1},
        {10, 30, -1}, 
        {0, 0, -1},
        {100, 160, -1}
    },
    {//25
        false,
        "Rockshore Construction Site", 
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1},
        {2703.8293,902.2045,10.4221},
        {23, -1}, 
        {300, -1},
        {4, -1}, 
        {0, -1},
        {40, -1}
    },
    {//26
        false,
        "Doherty Construction Site", 
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1},
        {-2063.1355,227.1720,35.8125},
        {23, -1}, 
        {380, -1},
        {6, -1}, 
        {0, -1},
        {75, -1}
    },
    {//27
        false,
        "Bone County Substation", 
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1},
        {-766.9951,1634.0951,27.2124},
        {0, -1}, 
        {1450, -1},
        {2, -1}, 
        {0, -1},
        {18, -1}
    },
    {//28
        false,
        "Sherman Dam Powerplant", 
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1},
        {782.8306,2035.0806,6.7109},
        {0, -1}, 
        {2000, -1},
        {3, -1}, 
        {0, -1},
        {25, -1}
    },
    {//29
        false,
        "The Ship", 
        {-1}, 
        {-1},
        {-1}, 
        {-1},
        {-1},
        {2771.0579,-2421.7144,13.6543},
        {0 ,5, 24, 2, 18, 8, 4, 20, 3, -1}, 
        {2000, 360, 360, 360, 1500, 360, 360, 410, 400, -1},
        {1, 1, 1, 1, 1, 1, 1, 1, -1}, 
        {0, 0, 0, 0, 0, 0, 0, 0, -1},
        {20, 500, 500, 500, 20, 500, 500, 500, 500, -1},
    }
};

enum PlayerTruckerInfo{
    SuggestFactory[sizeof(FactoryData)],
    MissionProduct[MAX_PLAYERPRODUCT],
    ClaimProduct[MAX_PLAYERPRODUCT],
    MissionBuy[MAX_PLAYERPRODUCT],
    ClaimFromCar[MAX_PLAYERPRODUCT],
    SellProduct[MAX_PLAYERPRODUCT],
    MAXPRODUCT,
    MAXPRODUCTIMPORT,
    ClaimFactoryID
};
new PlayerTruckerData[MAX_PLAYERS][PlayerTruckerInfo];
new pLoadProduct[MAX_PLAYERS];
new SaveWeigth[MAX_PLAYERS];