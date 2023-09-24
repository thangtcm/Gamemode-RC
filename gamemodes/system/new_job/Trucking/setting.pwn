#define MAX_PRODUCT         (24)
#define MAX_CARTRUCK        (30)
#define MAX_FACTORY         (30)
#define MAX_PLAYERPRODUCT   (7)

new const UnitType[][] = 
{
    {"Thung Hang"},//0
    {"Tan"}, //1
    {"Strongboxes"}, // 2
    {"Met Khoi"}, //3
    {"Lit"}, //4
    {"Khuc Go"}, //5
    {"Ke Hang"}, //6
    {"Transformer"},//7
    {"Phuong Tien"}//8
};

enum ProductInfo{
    ProductName[32],
    ProductUnitID
    //ItemReceived[32] -- Để sau này thêm sản phẩm nhận kèm khi hoàn thành
};

new const ProductData[][ProductInfo] = {
    { "Transformer", 7 }, // 0
    { "Car parts", 0 }, // 1
    { "Do gia dung", 0 }, // 2
    { "Giay", 0 }, // 3
    { "Noi that", 0 }, // 4
    { "Quan ao", 0 }, // 5
    { "Sat thep", 0 }, // 6
    { "Thit", 0 }, // 7
    { "Thuc pham", 0 }, // 8
    { "Thuoc sung", 0 }, // 9
    { "Trai cay", 0 }, // 10
    { "Trung", 0 }, // 11
    { "Bot mi", 1 }, // 12
    { "Ngu coc", 1 }, // 13
    { "Phe lieu", 1 }, // 14
    { "Vai cotton", 1 }, // 15
    { "Vat lieu", 1 }, // 16
    { "Vu khi", 2 }, // 17
    { "Phuong tien", 8 }, // 18
    { "Thuoc nhuom", 3 }, // 19
    { "Xang dau", 3 }, // 20
    { "Sua", 4 }, // 21
    { "Go", 5 }, // 22
    { "Vat lieu xay dung", 6 }, // 23
    { "Thuc uong", 0 } // 24
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
    { 499, "Benson", { 0, 6, -1, -1, -1, -1, -1 }, 18 }
};

enum FactoryInfo{ //Xuất khẩu
    FactoryName[108],
    ProductName[MAX_PRODUCT],// Danh sách ID ProductData
    ProductPrice[MAX_PRODUCT],
    Productivity[MAX_PRODUCT], 
    WareHouse[MAX_PRODUCT],
    MaxWareHouse[MAX_PRODUCT],
    Float:FactoryPos[3]
};

new FactoryData[][FactoryInfo] = {
    {//0
        "Green Palms Reafinery", 
        {20}, 
        {300},
        {40}, 
        {640},
        {640},
        {260.7484,1412.1002,11.1693}
    },
    {//1
        "Easter Bay Chemicals", 
        {9, 19}, 
        {60, 160},
        {30, 40}, 
        {180, 260},
        {180, 260},
        {-992.8083,-696.1418,32.0078}
    },
    {//2
        "Whetstone Scrap Yard", 
        {14}, 
        {80},
        {50}, 
        {300},
        {300},
        {-1869.1418,-1717.2013,21.7500}
    },
    {//3
        "The Panopticon Forest - West", 
        {22}, 
        {300},
        {5}, 
        {20},
        {20},
        {-788.3041,-133.7872,64.5020}
    },
    {//4
        "The Panopticon Forest - East", 
        {22}, 
        {300},
        {5}, 
        {20},
        {20},
        {-528.1472,-191.3672,78.4063}
    },
    {//5
        "The Impounder’s Farm", 
        {15, 21, 7}, 
        {30, 30, 70},
        {15, 15, 8}, 
        {100, 160, 60},
        {100, 160, 60},
        {-1058.7488,-1195.4639,129.2188}
    },
    {//6
        "The Farm On a Rock", 
        {15, 21}, 
        {30, 30},
        {15, 15}, 
        {100, 160},
        {100, 160},
        {-1448.5803,-1499.0050,101.3283}
    },
    {//7
        "The Beacon Hill Eggs", 
        {11}, 
        {50},
        {10}, 
        {100},
        {100},
        {-384.0244,-1041.0443,58.8835}
    },
    {//8
        "EasterBoard Farm", 
        {13, 21, 7}, 
        {50, 40, 80},
        {50, 15, 8}, 
        {350, 160, 60},
        {350, 160, 60},
        {-21.1862,81.3918,3.1096}
    },
    {//9
        "The Palomino Farm", 
        {13}, 
        {40},
        {50}, 
        {350},
        {350},
        {1938.3217,166.3846,37.2813}
    },
    {//10
        "The Leafy Hollow Orchards", 
        {10}, 
        {30},
        {12}, 
        {100},
        {100},
        {-1092.4702,-1622.1119,76.3672}
    },
    {//11
        "The Hilltop Farm", 
        {7, 21, 11}, 
        {90, 50, 70},
        {8, 15, 10}, 
        {60, 160, 100},
        {60, 160, 100},
        {1059.6445,-345.3934,73.9922}
    },
    {//12
        "Fort Carson Quarry", 
        {16}, 
        {30},
        {50}, 
        {300},
        {300},
        {325.7538,1147.9755,8.1741}
    },
    {//13
        "Blueberry Distribution Hub", 
        {13, 10, 23, 6, 20, 19, 8}, 
        {50, 50, 700, 165, 340, 170, 245},
        {100, 100, 100, 100, 100, 100, 100}, 
        {500, 1000, 1000, 1000, 1000, 1000, 1000},
        {500, 1000, 1000, 1000, 1000, 1000, 1000},
        {-226.1169,-190.0281,0.9920}
    },
    {//14
        "San Andreas Federal Weapon Factory", 
        {17}, 
        {250},
        {16}, 
        {100},
        {100},
        {2511.4922,2799.9509,10.8203}
    },
    {//15
        "San Andreas Steel Mill", 
        {6}, 
        {90},
        {15}, 
        {200},
        {200},
        {2658.2119,-1591.6473,13.7133}
    },
    {//16
        "Angel Pine Sawmill", 
        {4, 3}, 
        {220, 220},
        {5, 30}, 
        {50, 300},
        {50, 300},
        {-1999.1478,-2415.9165,30.6250}
    },
    {//17
        "Doherty Textile Factory", 
        {5}, 
        {210},
        {20}, 
        {200},
        {200},
        {-2121.7207,-264.5204,34.8916}
    },
    {//18
        "FleischBerg Brewery", 
        {24}, 
        {210},
        {25}, 
        {400},
        {400},
        {-58.0229,83.4377,3.1172}
    },
    {//19
        "SA Food Processing Plant", 
        {8}, 
        {190},
        {8}, 
        {100},
        {100},
        {1052.5149,2134.7427,10.8203}
    },
    {//20
        "Ocean Docks Concrete Plant", 
        {23}, 
        {130},
        {6}, 
        {150},
        {150},
        {1059.6445,-345.3934,73.9922}
    },
    {//21
        "Fort Carson Distillery", 
        {24}, 
        {210},
        {10}, 
        {120},
        {120},
        {-116.8637,1133.0490,19.7422}
    },
    {//22
        "Las Payasdas Malt House", 
        {12}, 
        {230},
        {20}, 
        {120},
        {120},
        {-317.8109,2662.0435,63.0919}
    },
    {//23
        "Shafted Appliances", 
        {2, 0}, 
        {210, 1000},
        {25, 3}, 
        {200, 30},
        {200, 30},
        {1703.7877,998.6878,10.8203}
    },
    {//24
        "Solarin Autos", 
        {18, 1}, 
        {800, 250},
        {5, 350}, 
        {40, 65535},
        {40, 65535},
        {-1835.2246,115.1202,15.1172}
    }
};

new FactoryExportData[][FactoryInfo] = {
    {//0
        "San Andreas Federal Weapon Factory", 
        {9, 6}, 
        {300, 290},
        {8, 8}, 
        {0, 0},
        {60, 100},
        {2511.4922,2799.9509,10.8203}
    },
    {//1
        "San Andreas Steel Mill", 
        {14}, 
        {250},
        {10}, 
        {0},
        {300},
        {2658.2119,-1591.6473,13.7133}
    },
    {//2
        "Angel Pine Sawmill", 
        {22}, 
        {3300},
        {30}, 
        {0},
        {300},
        {2658.2119,-1591.6473,13.7133}
    },
    {//3
        "Doherty Textile Factory", 
        {15, 19}, 
        {130, 200},
        {20, 10}, 
        {0, 0},
        {200, 100},
        {-2176.4045,-209.2566,34.8844}
    },
    {//4
        "FleischBerg Brewery", 
        {12}, 
        {340},
        {5}, 
        {0},
        {120},
        {-58.0229,83.4377,3.1172}
    },
    {//5
        "SA Food Processing Plant", 
        {7, 13, 11, 10}, 
        {170, 130, 170, 170},
        {8, 8, 8, 8}, 
        {0, 0, 0, 0},
        {200, 200, 200, 200},
        {1052.5149,2134.7427,10.8203}
    },
    {//6
        "Ocean Docks Concrete Plant", 
        {16}, 
        {240},
        {40}, 
        {0},
        {300},
        {2505.8315,-2119.4412,13.1183}
    },
    {//7
        "Fort Carson Distillery", 
        {10}, 
        {170},
        {10}, 
        {0},
        {80},
        {-116.8637,1133.0490,19.7422}
    },
    {//8
        "Las Payasdas Malt House", 
        {13}, 
        {190},
        {20}, 
        {0},
        {120},
        {-317.8109,2662.0435,63.0919}
    },
    {//9
        "Shafted Appliances", 
        {6}, 
        {235},
        {15}, 
        {0},
        {150},
        {1703.7877,998.6878,10.8203}
    },
    {//10
        "Solarin Autos", 
        {6, 19}, 
        {280, 200},
        {10, 30}, 
        {0, 0},
        {100, 160},
        {-1835.2246,115.1202,15.1172}
    },
    {//11
        "Rockshore Construction Site", 
        {23}, 
        {915},
        {4}, 
        {0},
        {40},
        {2703.8293,902.2045,10.4221}
    },
    {//12
        "Doherty Construction Site", 
        {23}, 
        {1300},
        {6}, 
        {0},
        {75},
        {-2063.1355,227.1720,35.8125}
    },
    {//13
        "Bone County Substation", 
        {0}, 
        {1450},
        {2}, 
        {0},
        {18},
        {-766.9951,1634.0951,27.2124}
    },
    {//14
        "Sherman Dam Powerplant", 
        {0}, 
        {2000},
        {3}, 
        {0},
        {25},
        {782.8306,2035.0806,6.7109}
    },
    {//15
        "The Ship", 
        {5, 24, 2, 18, 8, 4, 20}, 
        {2000, 360, 360, 360, 1500, 360, 360, 410},
        {0, 0, 0, 0, 0, 0, 0}, 
        {0, 0, 0, 0, 0, 0, 0},
        {20, 500, 500, 500, 20, 500, 500, 500},
        {2771.0579,-2421.7144,13.6543}
    }
};

new CarTruckProduct[MAX_PLAYERPRODUCT][CarTruckInfo] = {-1,...};
enum PlayerTruckerInfo{
    SuggestFactory[sizeof(FactoryData)],
    MissionProduct[MAX_PLAYERPRODUCT],
    ClaimProduct[MAX_PLAYERPRODUCT],
    MissionBuy[MAX_PLAYERPRODUCT]
};
new PlayerTruckerData[MAX_PLAYERS][PlayerTruckerInfo];

enum CarTruckerInfo{
    Object[30], 
    ClaimProduct[30]
}
new SaveWeigth[MAX_PLAYERS];
new PlayerCarTrucker[MAX_VEHICLES][CarTruckerInfo];