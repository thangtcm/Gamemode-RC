#define MAX_PRODUCT     (24)
#define MAX_CARTRUCK    (30)
#define MAX_FACTORY     (30)

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
    { "Vat lieu xay dung", 6 } // 23
};

enum CarTruckInfo{
    CarModel,
    CarName[40],
    CarUnitType[7],// danh sách vị trí đơn vị
    Weight
};
new CarTruckWorking[][CarTruckInfo] = {
    { 422, "Bobcat", { 0 }, 2 },
    { 478, "Walton", { 0 }, 4 },
    { 543, "Sadler", { 0 }, 2 },
    { 600, "Picador", { 0 }, 2 },
    { 605, "Sadler Shit", { 0 }, 2 },
    { 554, "Yosemite", { 0, 6 }, 6 },
    { 413, "Pony", { 0 }, 10 },
    { 459, "Topfun Van", { 0 }, 10 },
    { 482, "Burrito", { 0 }, 10 },
    { 498, "Boxville", { 0 }, 12 },
    { 440, "Rumpo", { 0 }, 12 },
    { 499, "Benson", { 0, 6 }, 18 }
};

enum FactoryInfo{ //Xuất khẩu
    FactoryName[108],
    ProductName[MAX_PRODUCT],// Danh sách ID ProductData
    ProductPrice[MAX_PRODUCT],
    Productivity[MAX_PRODUCT], 
    WareHouse[MAX_PRODUCT],
    Float:FactoryPos[3]
};

new FactoryData[][FactoryInfo] = {
    {//0
        "Green Palms Reafinery", 
        {20}, 
        {300},
        {40}, 
        {640},
        {0.0, 0.0, 0.0}
    },
    {//1
        "Easter Bay Chemicals", 
        {9, 19}, 
        {60, 160},
        {30, 40}, 
        {180, 260},
        {0.0, 0.0, 0.0}
    },
    {//2
        "Whetstone Scrap Yard", 
        {14}, 
        {80},
        {50}, 
        {300},
        {0.0, 0.0, 0.0}
    },
    {//3
        "The Panopticon Forest - West", 
        {22}, 
        {300},
        {5}, 
        {20},
        {0.0, 0.0, 0.0}
    },
    {//4
        "The Panopticon Forest - East", 
        {22}, 
        {300},
        {5}, 
        {20},
        {0.0, 0.0, 0.0}
    },
    {//5
        "The Impounder’s Farm", 
        {15, 21, 7}, 
        {30, 30, 70},
        {15, 15, 8}, 
        {100, 160, 60},
        {0.0, 0.0, 0.0}
    },
    {//6
        "The Farm On a Rock", 
        {15, 21}, 
        {30, 30},
        {15, 15}, 
        {100, 160},
        {0.0, 0.0, 0.0}
    },
    {//7
        "The Beacon Hill Eggs", 
        {11}, 
        {50},
        {10}, 
        {100},
        {0.0, 0.0, 0.0}
    },
    {//8
        "EasterBoard Farm", 
        {13, 21, 7}, 
        {50, 40, 80},
        {50, 15, 8}, 
        {350, 160, 60},
        {0.0, 0.0, 0.0}
    },
    {//9
        "The Palomino Farm", 
        {13}, 
        {40},
        {50}, 
        {350},
        {0.0, 0.0, 0.0}
    },
    {//10
        "The Palomino Farm", 
        {13}, 
        {40},
        {50}, 
        {350},
        {0.0, 0.0, 0.0}
    },
    {//11
        "The Leafy Hollow Orchards", 
        {10}, 
        {30},
        {12}, 
        {100},
        {0.0, 0.0, 0.0}
    },
    {//12
        "The Hilltop Farm", 
        {7, 21, 11}, 
        {90, 50, 70},
        {8, 15, 10}, 
        {60, 160, 100},
        {0.0, 0.0, 0.0}
    },
    {//13
        "Fort Carson Quarry", 
        {16}, 
        {30},
        {50}, 
        {300},
        {0.0, 0.0, 0.0}
    },
    {//14
        "Blueberry Distribution Hub", 
        {13, 10, 23, 6, 20, 19, 8}, 
        {50, 50, 700, 165, 340, 170, 245},
        {100, 100, 100, 100, 100, 100, 100}, 
        {500, 1000, 1000, 1000, 1000, 1000, 1000},
        {0.0, 0.0, 0.0}
    },
    {//15
        "San Andreas Federal Weapon Factory", 
        {17}, 
        {250},
        {16}, 
        {100},
        {0.0, 0.0, 0.0}
    },
    {//16
        "San Andreas Steel Mill", 
        {6}, 
        {90},
        {15}, 
        {200},
        {0.0, 0.0, 0.0}
    },
    {//17
        "Angel Pine Sawmill", 
        {4, 3}, 
        {220, 220},
        {5, 30}, 
        {50, 300},
        {0.0, 0.0, 0.0}
    }
};

new RegisterCarTruck[MAX_PLAYERS];