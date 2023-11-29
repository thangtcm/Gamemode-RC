#include <YSI_Coding\y_hooks>

new PlayerText:character_button[MAX_PLAYERS][4];
new PlayerText:character_preview[MAX_PLAYERS][6];
new PlayerText:Character_create[MAX_PLAYERS][17];
new character[MAX_PLAYERS][4];
hook OnGameModeInit() {
    new tmpobjid;
    tmpobjid = CreateDynamicObject(8229, 2102.799804, -1863.299804, 15.300000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 4, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetObjectMaterial(tmpobjid, 5, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetObjectMaterial(tmpobjid, 6, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(8229, 2124.799804, -1863.299804, 15.199998, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 9514, "711_sfw", "brick", 0x00000000);
    tmpobjid = CreateDynamicObject(8229, 2147.000000, -1863.300048, 15.100000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 4, 9514, "711_sfw", "brick", 0x00000000);
    tmpobjid = CreateDynamicObject(8229, 2169.100097, -1863.300048, 15.100000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetObjectMaterial(tmpobjid, 1, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 2, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 3, 9514, "711_sfw", "brick", 0x00000000);
    SetObjectMaterial(tmpobjid, 4, 9514, "711_sfw", "brick", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(2110, 2129.699951, -1868.599975, 14.199998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(14820, 2129.699951, -1869.099975, 15.100000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2872, 2135.299804, -1871.399414, 14.199998, 0.000000, 0.000000, 268.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2615, 2135.804687, -1869.030273, 15.724280, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2055, 2131.932617, -1869.380859, 15.702798, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2104, 2131.699951, -1867.800048, 14.300000, 0.000000, 0.000000, 272.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2231, 2127.699951, -1866.199951, 15.899998, 0.000000, 0.000000, 270.242004,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2231, 2127.699951, -1873.300048, 15.899998, 0.000000, 0.000000, 270.242004,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2229, 2128.270507, -1866.643554, 14.255168, 0.000000, 0.000000, 287.996002,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2229, 2127.699951, -1873.900024, 14.300000, 0.000000, 0.000000, 253.992996,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2229, 2131.800048, -1871.300048, 14.199998, 0.000000, 0.000000, 266.989990,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2229, 2131.800048, -1866.900024, 14.199998, 0.000000, 0.000000, 268.736999,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17037, 2129.500000, -1869.500000, 16.799999, 0.000000, 0.000000, 179.735992,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2147.588867, -1872.568359, 13.632478, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2147.589599, -1872.569213, 11.357480, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2144.888671, -1872.560546, 11.332468, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2142.644531, -1872.562377, 11.307470, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2144.884521, -1872.575317, 13.657480, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2142.733154, -1872.554565, 13.632478, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.726318, -1870.582275, 11.307470, 0.000000, 0.000000, 90.994003,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.681640, -1867.748657, 11.307470, 0.000000, 0.000000, 90.988998,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.625732, -1864.923828, 11.307470, 0.000000, 0.000000, 90.988998,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.641357, -1867.624023, 11.482480, 0.000000, 0.000000, 90.236000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.644287, -1864.770507, 11.482480, 0.000000, 0.000000, 90.236000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.683349, -1870.423461, 11.457480, 0.000000, 0.000000, 90.236000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.579833, -1870.380004, 13.707509, 0.000000, 0.000000, 270.235992,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.567382, -1867.523437, 13.707509, 0.000000, 0.000000, 270.230987,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2149.544677, -1864.688476, 13.682510, 0.000000, 0.000000, 270.230987,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.726318, -1870.582275, 13.607488, 0.000000, 0.000000, 90.988998,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.690185, -1867.760864, 13.557490, 0.000000, 0.000000, 90.488998,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1464, 2140.699951, -1864.900024, 13.600000, 0.000000, 0.000000, 90.477996,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 2131.199218, -1879.699218, 16.299999, 0.000000, 0.000000, 271.235992,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1476, 2149.583007, -1872.511718, 12.055100, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1476, 2140.722656, -1872.580078, 11.955108, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2140.799804, -1872.699218, 14.699998, 334.697998, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 2150.700927, -1870.447387, 13.312430, 0.000000, 0.000000, 90.741996,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 2139.568359, -1870.124023, 13.162420, 0.000000, 0.000000, 271.240997,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(985, 2141.300048, -1867.699951, 10.500000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(985, 2148.899902, -1867.699951, 10.500000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(985, 2145.100097, -1871.900024, 10.500000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2691, 2131.600097, -1869.099975, 15.500000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2806, 2118.625000, -1875.841796, 13.444849, 0.000000, 0.000000, 286.743011,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1481, 2121.899414, -1875.799804, 13.199998, 0.000000, 0.000000, 216.744003,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2110, 2119.083984, -1875.835083, 12.568940, 0.000000, 0.000000, 177.750000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2229, 2119.522949, -1876.173706, 12.588838, 0.000000, 0.000000, 179.490997,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1487, 2117.873046, -1875.979492, 13.564958, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1664, 2117.930664, -1875.547851, 13.534210, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(933, 2121.599609, -1868.899414, 12.500000, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(933, 2118.709960, -1871.990234, 12.500000, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(933, 2118.899414, -1866.799804, 12.500000, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2118.390625, -1869.754882, 12.605798, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2121.336914, -1873.441406, 12.605798, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2122.508789, -1870.536132, 12.580800, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2122.459960, -1865.543945, 12.770770, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1665, 2119.086914, -1871.632812, 13.524140, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1670, 2121.451171, -1869.431640, 13.513689, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1670, 2118.733398, -1867.208007, 13.513689, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2119.485351, -1870.789062, 12.557350, 0.000000, 0.000000, 326.739013,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2118.577148, -1868.702148, 12.557350, 0.000000, 0.000000, 186.740005,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2121.560546, -1870.900390, 12.532348, 0.000000, 0.000000, 186.735000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2121.843750, -1866.845703, 12.532348, 0.000000, 0.000000, 6.739998,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2117.299804, -1866.899414, 12.500000, 0.000000, 0.000000, 96.735000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1780, 2116.299804, -1876.000000, 13.500000, 0.000000, 0.000000, 179.242004,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(3221, 2120.073242, -1876.583984, 12.515000, 0.000000, 0.000000, 356.747985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2117.299804, -1871.399414, 12.600000, 0.000000, 0.000000, 66.741996,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(3594, 2109.899414, -1871.899414, 12.899998, 0.000000, 0.000000, 21.995000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1728, 2114.500000, -1875.799804, 12.500000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(941, 2155.000000, -1867.199218, 13.000000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(941, 2157.899902, -1867.300048, 13.000000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(936, 2155.199951, -1872.699951, 13.100000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1421, 2156.989257, -1864.690429, 13.350000, 0.000000, 0.000000, 178.494995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2156.958007, -1870.571289, 12.773368, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2155.100097, -1870.599975, 12.800000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2156.399414, -1867.699218, 12.800000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2158.959960, -1869.427734, 12.773368, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2159.233398, -1871.648437, 12.773368, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2159.081054, -1866.688476, 12.773368, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2673, 2154.699951, -1866.000000, 12.699998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2155.931640, -1869.585937, 12.721730, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2159.391601, -1868.901367, 12.721730, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(918, 2155.699951, -1864.599975, 12.949998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1558, 2159.000000, -1872.300048, 13.199998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1279, 2154.800048, -1864.599975, 12.699998, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1279, 2154.759765, -1864.584960, 12.981860, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1578, 2153.841796, -1864.933593, 12.902388, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1577, 2153.353515, -1864.926757, 12.902388, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1580, 2153.841796, -1864.923828, 13.047900, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1576, 2153.343261, -1864.897827, 13.032030, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2057, 2156.899902, -1865.400024, 12.750000, 0.000000, 0.000000, 202.483993,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2902, 2158.032226, -1864.409179, 12.797168, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2158.000000, -1870.300048, 12.600000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2676, 2154.500000, -1871.599975, 12.699998, 0.000000, 0.000000, 256.250000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1577, 2153.853515, -1864.954101, 12.752248, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1580, 2153.366210, -1864.934570, 12.747610, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2676, 2154.714843, -1867.255859, 12.803270, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2332, 2159.600097, -1865.199951, 13.000000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17037, 2154.699218, -1867.199218, 15.000000, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17037, 2159.189941, -1867.300048, 15.000000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17037, 2154.699951, -1874.699951, 15.000000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17037, 2159.189941, -1874.800048, 15.000000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(708, 2108.599609, -1875.099609, 12.100000, 0.000000, 0.000000, 15.491000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(969, 2091.899414, -1873.799804, 11.800000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1492, 2091.899414, -1865.199218, 12.399998, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(16637, 2092.500000, -1867.000000, 13.500000, 0.000000, 339.998992, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1492, 2152.500000, -1872.699951, 12.500000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(946, 2113.000000, -1864.300048, 14.720000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(8229, 2131.299804, -1883.799804, 16.399999, 0.000000, 0.000000, 179.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1439, 2098.299804, -1864.099609, 12.500000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1450, 2101.199951, -1864.199951, 13.000000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(5153, 2129.600097, -1866.599975, 14.097998, 359.769012, 23.236000, 179.841003,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1797, 2133.399902, -1869.099975, 14.199998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1829, 2132.399902, -1866.300048, 14.699998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2146, 2159.100097, -1870.400024, 13.100000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2146, 2152.000000, -1869.099975, 13.000000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1492, 2131.799804, -1873.099609, 14.000000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2190, 2132.699951, -1865.699951, 15.199998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2596, 2133.899902, -1873.000000, 15.899998, 0.000000, 0.000000, 178.500000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2628, 2136.899902, -1870.699951, 12.500000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2629, 2136.800048, -1868.800048, 12.500000, 0.000000, 0.000000, 92.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2815, 2133.500000, -1870.699951, 14.300000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(949, 2135.399902, -1867.199951, 14.899998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(2255, 2133.899902, -1866.099975, 15.899998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2129.000000, -1867.000000, 14.199998, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19398, 2131.799804, -1872.399414, 15.699998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2131.799804, -1869.299804, 15.699998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2129.000000, -1870.199951, 14.199998, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2129.000000, -1872.799804, 14.199797, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2132.500000, -1867.000000, 14.199998, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399902, -1867.000000, 14.199798, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399902, -1870.199951, 14.199798, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2132.500000, -1870.199951, 14.199998, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2132.199951, -1872.800048, 14.198801, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399414, -1872.799804, 14.197997, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2131.803710, -1867.000000, 15.699998, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2133.299804, -1865.481445, 15.699998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1866.999023, 15.699998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1870.199218, 15.699998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1873.400024, 15.699998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2133.500000, -1873.399047, 15.699997, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2134.500000, -1873.400024, 15.699998, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2135.299804, -1865.482421, 15.699998, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2127.300048, -1872.699951, 12.536000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2127.300048, -1869.500000, 12.536000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2127.304931, -1867.000000, 12.536000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2131.300048, -1876.000000, 14.199998, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2128.000000, -1876.099975, 13.500000, 0.000000, 67.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2125.199951, -1876.099975, 12.300000, 0.000000, 66.498001, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2128.799804, -1874.399414, 12.536000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2128.850097, -1865.481445, 12.536000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2135.299804, -1865.482421, 12.199998, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2133.299804, -1865.481445, 12.199998, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2131.199951, -1865.477050, 12.536000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1867.000000, 12.199998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1870.199951, 12.199998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2136.069335, -1873.400024, 12.199998, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2133.500000, -1867.000000, 17.399499, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2133.500000, -1870.199951, 17.399499, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2133.500000, -1873.400024, 17.399499, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399902, -1867.000000, 17.399900, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399902, -1870.199951, 17.399900, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19360, 2134.399902, -1873.400024, 17.399999, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19377, 2145.100097, -1868.500000, 12.500000, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2142.899902, -1863.699951, 13.600000, 0.000000, 0.000000, 89.995002,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2146.100097, -1863.699951, 13.600000, 0.000000, 0.000000, 89.995002,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2148.000000, -1863.699951, 13.600000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(17969, 2145.100097, -1863.900024, 13.899998, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2149.600097, -1872.500000, 14.699998, 334.692993, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19377, 2119.899414, -1869.399414, 12.500000, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2152.500000, -1869.599975, 13.300000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2152.500000, -1874.300048, 13.300000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2152.500000, -1866.400024, 13.300000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2154.100097, -1864.199951, 13.300000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2157.300048, -1864.199951, 13.300000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2160.500000, -1864.199951, 13.300000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2160.000000, -1865.900024, 13.300000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2160.000000, -1869.099975, 13.300000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2160.000000, -1872.300048, 13.300000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19377, 2157.699951, -1869.000000, 12.500000, 0.000000, 90.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2154.199951, -1873.400024, 13.300000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2157.399902, -1873.400024, 13.300000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2160.600097, -1873.400024, 13.300000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2152.510009, -1864.099975, 13.300000, 0.000000, 0.000000, 180.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1578, 2153.841796, -1864.900024, 12.600000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1578, 2153.353515, -1864.934570, 12.600000, 0.000000, 0.000000, 270.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(16779, 2156.399902, -1867.400024, 15.500000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(708, 2137.800048, -1872.400024, 10.000000, 0.000000, 0.000000, 285.484985,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(708, 2151.300048, -1865.699951, 10.399998, 0.000000, 0.000000, 103.490997,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2150.100097, -1864.900024, 17.200000, 334.692993, 0.000000, 139.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2151.300048, -1864.199951, 14.699998, 334.692993, 0.000000, 89.995002,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2149.899902, -1866.000000, 17.200000, 334.692993, 0.000000, 196.494995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2150.699951, -1866.800048, 17.200000, 334.692993, 0.000000, 256.489990,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 2152.600097, -1867.300048, 16.399999, 330.000000, 0.000000, 76.741996,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1810, 2149.800048, -1865.699951, 17.299999, 0.000000, 0.000000, 302.742004,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1473, 2151.600097, -1864.199951, 14.699998, 334.692993, 0.000000, 89.995002,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1492, 2131.821044, -1865.199951, 12.600000, 0.000000, 0.000000, 90.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2131.840087, -1865.199951, 15.899998, 90.000000, 180.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19444, 2131.840087, -1865.900024, 13.352000, 0.000000, 0.000000, 0.000000,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(1728, 2106.199951, -1864.099975, 12.500000, 0.000000, 0.000000, 359.994995,-1,-1,-1, 300.00); 
    tmpobjid = CreateDynamicObject(19371, 2127.100097, -1874.500000, 11.300000, 337.250000, 0.000000, 90.000000,-1,-1,-1, 300.00);
}
stock LoadCharacterTD(playerid) {

   
    DeletePVar(playerid,#open_character);
    Character_create[playerid][0] = CreatePlayerTextDraw(playerid, 247.9163, 331.5550, "Box"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][0], 0.0000, 10.6183);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][0], 390.0000, 0.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][0], 1);
    PlayerTextDrawColor(playerid, Character_create[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][0], 336860301);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][0], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][0], 0);
    
    Character_create[playerid][1] = CreatePlayerTextDraw(playerid, 255.3998, 315.9997, "Create_Character"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][1], 0.4237, 2.4136);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][1], 1);
    PlayerTextDrawColor(playerid, Character_create[playerid][1], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][1], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][1], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][1], 0);
    
    Character_create[playerid][2] = CreatePlayerTextDraw(playerid, 318.8999, 342.4259, "Ten_nhan_vat"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][2], 0.1383, 1.1591);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][2], 10.0000, 106.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][2], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][2], -1061109505);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][2], -200);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][2], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][2], true);
    
    Character_create[playerid][3] = CreatePlayerTextDraw(playerid, 291.7341, 417.0295, "Tham_gia"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][3], 0.1949, 1.0296);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][3], 10.0000, 50.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][3], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][3], 8388709);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][3], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][3], true);
    
    Character_create[playerid][4] = CreatePlayerTextDraw(playerid, 346.0690, 417.1369, "Reset"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][4], 0.1949, 1.0296);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][4], 10.0000, 51.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][4], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][4], -1523963253);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][4], -1523963137);
    PlayerTextDrawFont(playerid, Character_create[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][4], true);
    
    Character_create[playerid][5] = CreatePlayerTextDraw(playerid, 241.6334, 332.7998, "X"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][5], 0.1272, 0.6873);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][5], 10.0000, 4.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][5], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][5], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][5], 129);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][5], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][5], true);
    
    Character_create[playerid][6] = CreatePlayerTextDraw(playerid, 318.8999, 357.2268, "Tuoi"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][6], 0.1383, 1.1591);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][6], 10.0000, 106.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][6], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][6], -1061109505);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][6], -200);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][6], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][6], true);
    
    Character_create[playerid][7] = CreatePlayerTextDraw(playerid, 319.0999, 372.3277, "Gioi_tinh"); // str gioi tinh
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][7], 0.1383, 1.1591);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][7], 10.0000, 106.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][7], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][7], -1061109505);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][7], -200);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][7], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][7], 0);
    
    Character_create[playerid][8] = CreatePlayerTextDraw(playerid, 319.0999, 387.2286, "Quoc_tich"); // str qtich
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][8], 0.1383, 1.1591);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][8], 10.0000, 106.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][8], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][8], -1061109505);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][8], -200);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][8], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][8], 0);
    
    Character_create[playerid][9] = CreatePlayerTextDraw(playerid, 319.0999, 402.2295, "Trang_phuc"); // str trang phuc
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][9], 0.1383, 1.1591);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][9], 10.0000, 106.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][9], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][9], -1061109505);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][9], -200);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][9], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][9], 0);
    
    Character_create[playerid][10] = CreatePlayerTextDraw(playerid, 258.4999, 372.9259, ">"); // gioi tinh
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][10], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][10], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][10], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][10], 130);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][10], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][10], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][10], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][10], true);
    
    Character_create[playerid][11] = CreatePlayerTextDraw(playerid, 258.4165, 387.6083, ">"); // qtich
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][11], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][11], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][11], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][11], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][11], 130);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][11], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][11], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][11], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][11], true);
    
    Character_create[playerid][12] = CreatePlayerTextDraw(playerid, 258.4165, 402.4092, ">"); // trang phuc
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][12], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][12], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][12], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][12], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][12], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][12], 130);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][12], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][12], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][12], true);
    
    Character_create[playerid][13] = CreatePlayerTextDraw(playerid, 379.6499, 373.0721, "<"); // // gioi tinh
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][13], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][13], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][13], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][13], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][13], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][13], 130);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][13], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][13], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][13], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][13], true);
    
    Character_create[playerid][14] = CreatePlayerTextDraw(playerid, 379.5501, 387.3544, "<"); // qtich
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][14], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][14], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][14], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][14], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][14], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][14], 130);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][14], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][14], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][14], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][14], true);
    
    Character_create[playerid][15] = CreatePlayerTextDraw(playerid, 379.8500, 402.2738, "<"); // trangphuc
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][15], 0.1620, 1.0347);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][15], 10.0000, 9.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][15], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][15], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][15], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][15], 131);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][15], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][15], 3);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][15], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][15], true);
    
    Character_create[playerid][16] = CreatePlayerTextDraw(playerid, 241.6334, 342.8004, "?"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, Character_create[playerid][16], 0.1272, 0.6873);
    PlayerTextDrawTextSize(playerid, Character_create[playerid][16], 10.0000, 4.0000);
    PlayerTextDrawAlignment(playerid, Character_create[playerid][16], 2);
    PlayerTextDrawColor(playerid, Character_create[playerid][16], -1);
    PlayerTextDrawUseBox(playerid, Character_create[playerid][16], 1);
    PlayerTextDrawBoxColor(playerid, Character_create[playerid][16], 149);
    PlayerTextDrawBackgroundColor(playerid, Character_create[playerid][16], 255);
    PlayerTextDrawFont(playerid, Character_create[playerid][16], 1);
    PlayerTextDrawSetProportional(playerid, Character_create[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, Character_create[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, Character_create[playerid][16], true);

    character_button[playerid][0] = CreatePlayerTextDraw(playerid, 208.3333, 105.9998, "Cuong_Nguyen"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_button[playerid][0], 0.1112, 0.8426);
    PlayerTextDrawTextSize(playerid, character_button[playerid][0], 10.0000, 36.0000);
    PlayerTextDrawAlignment(playerid, character_button[playerid][0], 2);
    PlayerTextDrawColor(playerid, character_button[playerid][0], -47);
    PlayerTextDrawUseBox(playerid, character_button[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, character_button[playerid][0], 94);
    PlayerTextDrawBackgroundColor(playerid, character_button[playerid][0], 255);
    PlayerTextDrawFont(playerid, character_button[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, character_button[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, character_button[playerid][0], 0);
    PlayerTextDrawSetSelectable(playerid, character_button[playerid][0], true);
    
    character_button[playerid][1] = CreatePlayerTextDraw(playerid, 525.6666, 218.2262, "Cuong_Nguyen1"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_button[playerid][1], 0.1308, 0.9204);
    PlayerTextDrawTextSize(playerid, character_button[playerid][1], 10.0000, 47.0000);
    PlayerTextDrawAlignment(playerid, character_button[playerid][1], 2);
    PlayerTextDrawColor(playerid, character_button[playerid][1], -47);
    PlayerTextDrawUseBox(playerid, character_button[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, character_button[playerid][1], 111);
    PlayerTextDrawBackgroundColor(playerid, character_button[playerid][1], 255);
    PlayerTextDrawFont(playerid, character_button[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, character_button[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, character_button[playerid][1], 0);
    PlayerTextDrawSetSelectable(playerid, character_button[playerid][1], true);
    
    character_button[playerid][2] = CreatePlayerTextDraw(playerid, 379.3497, 214.3516, "Cuong_Nguyen1"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_button[playerid][2], 0.1229, 0.9412);
    PlayerTextDrawTextSize(playerid, character_button[playerid][2], 10.0000, 47.0000);
    PlayerTextDrawAlignment(playerid, character_button[playerid][2], 2);
    PlayerTextDrawColor(playerid, character_button[playerid][2], -47);
    PlayerTextDrawUseBox(playerid, character_button[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, character_button[playerid][2], 110);
    PlayerTextDrawBackgroundColor(playerid, character_button[playerid][2], 255);
    PlayerTextDrawFont(playerid, character_button[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, character_button[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, character_button[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, character_button[playerid][2], true);
    
    character_button[playerid][3] = CreatePlayerTextDraw(playerid, 424.5831, 168.2221, "Tao_nhan_vat"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_button[playerid][3], 0.1229, 0.9412);
    PlayerTextDrawTextSize(playerid, character_button[playerid][3], 10.0000, 47.0000);
    PlayerTextDrawAlignment(playerid, character_button[playerid][3], 2);
    PlayerTextDrawColor(playerid, character_button[playerid][3], -47);
    PlayerTextDrawUseBox(playerid, character_button[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, character_button[playerid][3], 114);
    PlayerTextDrawBackgroundColor(playerid, character_button[playerid][3], 255);
    PlayerTextDrawFont(playerid, character_button[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, character_button[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, character_button[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, character_button[playerid][3], true);
    
    
    
    character_preview[playerid][0] = CreatePlayerTextDraw(playerid, 257.9165, 352.8146, "Box"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][0], 0.0000, 8.2435);
    PlayerTextDrawTextSize(playerid, character_preview[playerid][0], 383.0000, 0.0000);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][0], 1);
    PlayerTextDrawColor(playerid, character_preview[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, character_preview[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, character_preview[playerid][0], 183);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][0], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][0], 0);
    
    character_preview[playerid][1] = CreatePlayerTextDraw(playerid, 249.9998, 343.9999, "Character_Preview"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][1], 0.2560, 1.5686);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][1], 1);
    PlayerTextDrawColor(playerid, character_preview[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][1], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][1], 0);
    
    character_preview[playerid][2] = CreatePlayerTextDraw(playerid, 259.6832, 357.9814, "Nhan_vat_:_Cuong_Nguyen_~n~Level:_16~n~Playing_Time:_21~n~Vi_tri_cuoi_cung:_San_Andreas_~n~Lan_cuoi_dang_nhap:_22/2/22/_2/2/2"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][2], 0.1383, 1.1591);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][2], 1);
    PlayerTextDrawColor(playerid, character_preview[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][2], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][2], 0);
    
    character_preview[playerid][3] = CreatePlayerTextDraw(playerid, 288.4175, 414.9555, "Tham_gia"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][3], 0.1949, 1.0296);
    PlayerTextDrawTextSize(playerid, character_preview[playerid][3], 10.0000, 58.0000);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][3], 2);
    PlayerTextDrawColor(playerid, character_preview[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, character_preview[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, character_preview[playerid][3], 8388698);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][3], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, character_preview[playerid][3], true);
    
    character_preview[playerid][4] = CreatePlayerTextDraw(playerid, 351.8172, 415.1000, "Xoa_nhan_vat"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][4], 0.1949, 1.0296);
    PlayerTextDrawTextSize(playerid, character_preview[playerid][4], 10.0000, 58.0000);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][4], 2);
    PlayerTextDrawColor(playerid, character_preview[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, character_preview[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, character_preview[playerid][4], -2147483535);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][4], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, character_preview[playerid][4], true);
    
    character_preview[playerid][5] = CreatePlayerTextDraw(playerid, 376.6665, 354.3703, "X"); // ïóñòî
    PlayerTextDrawLetterSize(playerid, character_preview[playerid][5], 0.2662, 1.1799);
    PlayerTextDrawTextSize(playerid, character_preview[playerid][5], 10.0000, 11.0000);
    PlayerTextDrawAlignment(playerid, character_preview[playerid][5], 2);
    PlayerTextDrawColor(playerid, character_preview[playerid][5], -1);
    PlayerTextDrawUseBox(playerid, character_preview[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, character_preview[playerid][5], -1523963303);
    PlayerTextDrawBackgroundColor(playerid, character_preview[playerid][5], 255);
    PlayerTextDrawFont(playerid, character_preview[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, character_preview[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, character_preview[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, character_preview[playerid][5], true);
}

forward ShowTD(playerid);
public ShowTD(playerid) {
    for(new i = 0 ; i < 4 ; i++) PlayerTextDrawShow(playerid, character_button[playerid][i]);
}

stock ShowPlayerCharacter(playerid,reshow = 0) {
    SetCameraBehindPlayer(playerid);
    
    new string[300];
    for(new i = 0 ; i < 4 ; i++) {
        if(reshow == 0) {
            if(IsValidDynamicActor(character[playerid][i])) DestroyDynamicActor(character[playerid][i]);
        }
       
        if(TempCharacter[playerid][i][IsCreated])
        {
           
            format(string, sizeof(string), "%s",TempCharacter[playerid][i][Name]);
            PlayerTextDrawSetString(playerid, character_button[playerid][i], string);
          
        }
        else if(!TempCharacter[playerid][i][IsCreated]) {
            PlayerTextDrawSetString(playerid, character_button[playerid][i], "Tao nhan vat");
            
        }
        
    }

    if(reshow == 0) {
        if(TempCharacter[playerid][0][IsCreated]) character[playerid][0] = CreateDynamicActor(TempCharacter[playerid][0][Skin], 2130.524169,-1869.071166,15.285935,95.021751, 1,100.0, playerid+1,  -1);
        else character[playerid][0] = CreateDynamicActor(1 + random(200), 2130.524169,-1869.071166,15.285935,95.021751, 1,100.0, playerid+1,  -1);

        if(TempCharacter[playerid][1][IsCreated]) character[playerid][1] = CreateDynamicActor(TempCharacter[playerid][1][Skin], 2121.841796,-1870.430175,13.585937,14.430438, 1,  100.0, playerid+1,  -1);
        else character[playerid][1] = CreateDynamicActor(1 + random(200), 2121.841796,-1870.430175,13.585937,14.430438, 1,  100.0, playerid+1,  -1);

        if(TempCharacter[playerid][2][IsCreated]) character[playerid][0] = character[playerid][2] = CreateDynamicActor(TempCharacter[playerid][2][Skin], 2122.877685,-1868.652832,13.585937,87.559570,1,  100.0, playerid+1,  -1);
        else character[playerid][2] = character[playerid][2] = CreateDynamicActor(1 + random(200), 2122.877685,-1868.652832,13.585937,87.559570,1,  100.0, playerid+1,  -1);
        
        if(TempCharacter[playerid][3][IsCreated]) character[playerid][0] = character[playerid][3] = CreateDynamicActor(TempCharacter[playerid][3][Skin], 2126.846923,-1873.591186,13.546875,82.842185, 1,  100.0,playerid+1,  -1);
        else character[playerid][3] = character[playerid][3] = CreateDynamicActor(1 + random(200), 2126.846923,-1873.591186,13.546875,82.842185, 1,  100.0,playerid+1,  -1);

        //  character[playerid][0] = CreateDynamicActor(1 + random(200), 2130.524169,-1869.071166,15.285935,95.021751, 1,100.0, playerid+1,  -1);
        // character[playerid][1] = CreateDynamicActor(1 + random(200), 2121.841796,-1870.430175,13.585937,14.430438, 1,  100.0, playerid+1,  -1);
        // character[playerid][2] = CreateDynamicActor(1 + random(200), 2126.846923,-1873.591186,13.546875,82.842185, 1,  100.0,playerid+1,  -1);
        // character[playerid][3] = CreateDynamicActor(1 + random(200), 2122.877685,-1868.652832,13.585937,87.559570,1,  100.0, playerid+1,  -1);
        InterpolateCameraPos(playerid, 2095.088623, -1865.832519, 13.257120, 2118.102050, -1864.503906, 16.002574, 4000);
        InterpolateCameraLookAt(playerid, 2100.007568, -1866.223632, 12.450499, 2122.167724, -1867.171386, 14.838608, 4000);
    }
    else {
        switch(GetPVarInt(playerid,#select_character)) {
            case 0: {
                // SetPlayerCameraPos(playerid, 2494.0857, -1697.6871, 1016.0413);
                // SetPlayerCameraLookAt(playerid, 2494.0054, -1696.6927, 1015.3209,CAMERA_MOVE);
                InterpolateCameraPos(playerid,  2128.635742, -1869.387084, 15.977824, 2118.102050, -1864.503906, 16.002574,3000);
                InterpolateCameraLookAt(playerid, 2133.453857, -1868.650268, 14.862911, 2122.167724, -1867.171386, 14.838608, 3000);
            }
            case 1: {
               // SetPlayerCameraPos(playerid, 2493.4937, -1697.2549, 1015.5622);
               // SetPlayerCameraLookAt(playerid, 2494.4385, -1697.5751, 1014.8873,CAMERA_MOVE);
        
                InterpolateCameraPos(playerid, 2121.721191, -1869.287109, 14.011209,2118.102050, -1864.503906, 16.002574, 3000);
                InterpolateCameraLookAt(playerid, 2122.865966, -1874.154296, 13.996252, 2122.167724, -1867.171386, 14.838608, 3000);
            }
            case 2: {
               // SetPlayerCameraPos(playerid, 2493.6079, -1697.2856, 1016.0413);
               // SetPlayerCameraLookAt(playerid, 2493.2866, -1698.2301, 1015.5665,CAMERA_MOVE);
                InterpolateCameraPos(playerid, 2121.612792, -1868.598144, 14.267834,2118.102050, -1864.503906, 16.002574,  3000);
                InterpolateCameraLookAt(playerid,  2126.326171, -1868.613159, 12.599309,2122.167724, -1867.171386, 14.838608, 3000);
                
            }
            case 3: {
               // SetPlayerCameraPos(playerid, 2493.6079, -1697.2856, 1016.0413);
                // SetPlayerCameraLookAt(playerid, 2493.9602, -1698.2191, 1015.4063,CAMERA_MOVE);
                InterpolateCameraPos(playerid,  2125.654052, -1873.481445, 14.032361,2118.102050, -1864.503906, 16.002574, 3000);
                InterpolateCameraLookAt(playerid,  2130.647460, -1873.269653, 14.179213,2122.167724, -1867.171386, 14.838608, 3000);
            }
        }
       
    }
  
    SetPlayerVirtualWorld(playerid, playerid+1);
    SelectTextDraw(playerid, COLOR_YELLOW);
    SetTimerEx("ShowTD", 3000, 0, "d", playerid);
    SetPVarInt(playerid,#open_character,1);
    return 1;
}

stock destroy_CharacterTD(playerid) {
    for(new i = 0 ; i < 17 ; i++) {
        PlayerTextDrawHide(playerid, Character_create[playerid][i]);
    }

    PlayerTextDrawHide(playerid,character_button[playerid][0]);
    PlayerTextDrawHide(playerid,character_button[playerid][1]);
    PlayerTextDrawHide(playerid,character_button[playerid][2]);
    PlayerTextDrawHide(playerid,character_button[playerid][3]);
    PlayerTextDrawHide(playerid,character_preview[playerid][0]);
    PlayerTextDrawHide(playerid,character_preview[playerid][1]);
    PlayerTextDrawHide(playerid,character_preview[playerid][2]);
    PlayerTextDrawHide(playerid,character_preview[playerid][3]);
    PlayerTextDrawHide(playerid,character_preview[playerid][4]);
    PlayerTextDrawHide(playerid,character_preview[playerid][5]);
    DeletePVar(playerid,#open_character);
    for(new i = 0 ; i < 4 ; i++) {
        if(IsValidDynamicActor(character[playerid][i])) DestroyDynamicActor(character[playerid][i]);
    }
    return 1;
}
stock hide_PreviewCharacter(playerid) {
    PlayerTextDrawHide(playerid,character_button[playerid][0]);
    PlayerTextDrawHide(playerid,character_button[playerid][1]);
    PlayerTextDrawHide(playerid,character_button[playerid][2]);
    PlayerTextDrawHide(playerid,character_button[playerid][3]);
    PlayerTextDrawHide(playerid,character_preview[playerid][0]);
    PlayerTextDrawHide(playerid,character_preview[playerid][1]);
    PlayerTextDrawHide(playerid,character_preview[playerid][2]);
    PlayerTextDrawHide(playerid,character_preview[playerid][3]);
    PlayerTextDrawHide(playerid,character_preview[playerid][4]);
    PlayerTextDrawHide(playerid,character_preview[playerid][5]);
    
    CancelSelectTextDraw(playerid);
}

forward showPreviewCharacter(playerid,characterid);
public showPreviewCharacter(playerid,characterid)
{
    
    new string[129],zone[32];
    Get3DZone(TempCharacter[playerid][characterid][SPos_x],TempCharacter[playerid][characterid][SPos_y] ,TempCharacter[playerid][characterid][SPos_z],zone ,sizeof(zone));
    format(string, sizeof(string),"Nhan vat: %s~n~Level: %d~n~Playing Time: %d~n~Vi tri cuoi cung: %s~n~Lan cuoi dang nhap: %s", 
        TempCharacter[playerid][characterid][Name],
        TempCharacter[playerid][characterid][Lv],
        TempCharacter[playerid][characterid][pPlayingHours],
        zone,
        TempCharacter[playerid][characterid][pLastOnline]);
    PlayerTextDrawSetString(playerid, character_preview[playerid][2], string);
    PlayerTextDrawShow(playerid,character_preview[playerid][0]);
    PlayerTextDrawShow(playerid,character_preview[playerid][1]);
    PlayerTextDrawShow(playerid,character_preview[playerid][2]);
    PlayerTextDrawShow(playerid,character_preview[playerid][3]);
    PlayerTextDrawShow(playerid,character_preview[playerid][4]);
    PlayerTextDrawShow(playerid,character_preview[playerid][5]);
    SelectTextDraw(playerid, COLOR_YELLOW);
    SetPVarInt(playerid,#select_character,characterid);
    return 1;
  
}
forward ShowCreateCharacter(playerid,characterid);
public ShowCreateCharacter(playerid,characterid) {
    SetPVarInt(playerid,#select_character,characterid);
    update_CreateCharacter(playerid);
    show_CreateCharacter(playerid);
    
}
stock show_CreateCharacter(playerid) {
    for(new i = 0 ; i < 17 ; i++) {
        PlayerTextDrawShow(playerid, Character_create[playerid][i]);
    }
  
    SelectTextDraw(playerid, COLOR_YELLOW);
    return 1;
}

stock update_CreateCharacter(playerid,change_skin = 0) {
    new return_str[32],string[128];
    GetPVarString(playerid, #character_name, return_str, sizeof(return_str));
    if(isnull(return_str)) return_str = "Ten nhan vat";
    format(string, sizeof(string), "%s", return_str);
    PlayerTextDrawSetString(playerid,Character_create[playerid][2] , string);
  
    format(string, sizeof(string), "%d", GetPVarInt(playerid,#age_character));
    if(GetPVarInt(playerid,#age_character) < 8) string = "Tuoi";
    PlayerTextDrawSetString(playerid,Character_create[playerid][6] , string);
  
    switch(GetPVarInt(playerid,#sex_character)) {
        case 0: return_str = "Gioi tinh";
        case 1: return_str = "Nam";
        case 2: return_str = "Nu";
    }
    PlayerTextDrawSetString(playerid,Character_create[playerid][7] , return_str);
    switch(GetPVarInt(playerid,#nation_character)) {
        case 0: return_str = "Quoc tich";
        case 1: return_str = "San Andreas";
        case 2: return_str = "Tierra Robada";
    }
    PlayerTextDrawSetString(playerid,Character_create[playerid][8] , return_str);

    format(string, sizeof(string), "Trang phuc: ~y~%d", GetPVarInt(playerid,#skin_character));
    PlayerTextDrawSetString(playerid,Character_create[playerid][9] , string);
    if(change_skin == 1) {
        // if(IsValidDynamicActor(character[playerid][GetPVarInt(playerid,#select_character)])) 
        DestroyDynamicActor(character[playerid][GetPVarInt(playerid,#select_character)]);
        printf("sel c: %d",GetPVarInt(playerid, #select_character));
        switch(GetPVarInt(playerid,#select_character)) {
            case 0: character[playerid][0] = CreateDynamicActor(GetSkinCreateCharacter(playerid), 2130.524169,-1869.071166,15.285935,95.021751, 1,100.0, playerid+1,  -1);
            case 1: character[playerid][1] = CreateDynamicActor(GetSkinCreateCharacter(playerid), 2121.841796,-1870.430175,13.585937,14.430438, 1,  100.0, playerid+1,  -1);
            case 2: character[playerid][2] = CreateDynamicActor(GetSkinCreateCharacter(playerid), 2122.877685,-1868.652832,13.585937,87.559570,1,  100.0, playerid+1,  -1); 
            case 3: character[playerid][3] = CreateDynamicActor(GetSkinCreateCharacter(playerid), 2126.846923,-1873.591186,13.546875,82.842185, 1,  100.0,playerid+1,  -1);
        }
    }
 
    return 1;
}
Dialog:create_CharacterAge(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(strval(inputtext) > 5 && strval(inputtext) < 80) {
            SetPVarInt(playerid , #age_character, strval(inputtext));
            update_CreateCharacter(playerid);
            show_CreateCharacter(playerid);
        }
        else Dialog_Show(playerid, create_CharacterAge, DIALOG_STYLE_INPUT, "Create Character - Age", "Vui long nhap so tuoi cua nhan vat\nSo phai la don vi, bat dau tu 6-80\nVi du: 16", "Xac nhan", "Quay lai");

    }
}
Dialog:create_CharacterName(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(IsValidName(inputtext)) {
            SetPVarString(playerid , #character_name, inputtext);
            update_CreateCharacter(playerid);
            show_CreateCharacter(playerid);
        }
        else Dialog_Show(playerid, create_CharacterName, DIALOG_STYLE_INPUT, "Create Character - Name", "Vui long nhap ten dang nhap phia ben duoi\nTen dang nhap phai co _ giua ho va ten\nVi du: Cuong_Nguyen", "Xac nhan", "Quay lai");
    }
}

CheckCharacterNameExist(playerid, name[])
{
    new query[128];
    mysql_format(MainPipeline, query, sizeof query, "select Username from accounts where Username='%s'", name);
    mysql_tquery(MainPipeline, query, "OnCheckCharacterExist", "ds", playerid, name);

}
forward OnCheckCharacterExist(playerid, name[]);
public OnCheckCharacterExist(playerid, name[])
{
    if(cache_num_rows())
    {
         SendClientTextDraw(playerid,"Ten nhan vat nay ~r~da ton tai~w~ trong co so du lieu may chu ~y~#GTASANVN");
       // ShowPlayerDialog(playerid, DIALOG_TAONHANVAT, DIALOG_STYLE_INPUT, "khoi tao Nhan vat", "Ten nhan vat da ton tai!\n\nNhap ten nhan vat cua ban \nDe khoi tao , ten nhan vat se la ten goi IC Cua ban\nVi vay phai can nhac va dat dung quy dinh", "Nhap","Quay lai");
    }
    else {
        // not exist
        // new fName[129];
        // GetPVarString(playerid, "NhapUserName", fName, sizeof(fName));
        SetPlayerName(playerid, name);
        new i = GetPVarInt(playerid, #select_character);
        // new fName[24];
        TempCharacter[playerid][i][Skin] = GetSkinCreateCharacter(playerid);
        TempCharacter[playerid][i][Lv] = 1;
        g_mysql_CreateAccountzz(playerid, name);
        TempCharacter[playerid][i][IsCreated] = true;
        format(TempCharacter[playerid][i][Name], 24, "%s", name);
    }
    return 1;
}
stock GetSkinCreateCharacter(playerid) {
    new skin;
    if(GetPVarInt(playerid,#sex_character) == 1) {
        switch(GetPVarInt(playerid,#skin_character)) {
            case 0: skin = 7;
            case 1: skin = 3;
            case 2: skin = 15;
            case 3: skin = 23;
            case 4: skin = 37;
            case 5: skin = 98;
        }
    }
    else if(GetPVarInt(playerid,#sex_character) == 2) {
        switch(GetPVarInt(playerid,#skin_character)) {
            case 0: skin = 40;
            case 1: skin = 41;
            case 2: skin = 55;
            case 3: skin = 56;
            case 4: skin = 91;
            case 5: skin = 141;
        }
    }
    return skin;
}
stock hide_CreateCharacter(playerid) {
    
    for(new i = 0 ; i < 17 ; i++) {
        PlayerTextDrawHide(playerid, Character_create[playerid][i]);
    }
    DeletePVar(playerid,#sex_character);
    DeletePVar(playerid,#nation_character);
    DeletePVar(playerid,#skin_character);
    DeletePVar(playerid,#character_age);
    DeletePVar(playerid,#character_name);
    SelectTextDraw(playerid, COLOR_YELLOW);
}
stock g_mysql_CreateAccountzz(playerid, name[])
{
    new string[256];
    new passbuffer[129];
    passbuffer = "lsrvn";
    if(GetPVarInt(playerid,#sex_character) == 2) SetPVarInt(playerid,#sex_character,0);
    if(GetPVarInt(playerid,#nation_character) == 2) SetPVarInt(playerid,#nation_character,0);

    format(string, sizeof(string), "INSERT INTO `accounts` (`master_id`,`RegiDate`, `LastLogin`, `Username`, `Key`, `Sex`,`Nation`,`Model`) VALUES ('%d', NOW(), NOW(), '%s','%s','%d','%d','%d')",MasterInfo[playerid][acc_id],name, passbuffer
        ,GetPVarInt(playerid,#sex_character),GetPVarInt(playerid,#nation_character),GetSkinCreateCharacter(playerid));
    mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "iii", REGISTER_THREAD, playerid, g_arrQueryHandle{playerid});
    hide_CreateCharacter(playerid);
    return 1;
}