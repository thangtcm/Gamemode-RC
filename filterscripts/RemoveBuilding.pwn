#include <a_samp>
#include <streamer>
#define FILTERSCRIPT
new Float:VMachines[][3] = {
//Candy machines:
{2480.86,-1959.27,12.9609},
{1634.11,-2237.53,12.8906},
{2139.52,-1161.48,23.3594},
{2153.23,-1016.15,62.2344},
{-1350.12,493.859,10.5859},
{-2229.19,286.414,34.7031},
{1659.46,1722.86,10.2188},
{2647.7,1129.66,10.2188},
{2845.73,1295.05,10.7891},
{1398.84,2222.61,10.4219},
{-1455.12,2591.66,55.2344},
{-76.0312,1227.99,19.125},
{662.43,-552.164,15.7109},
{-253.742,2599.76,62.2422},
{2271.73,-76.4609,25.9609},

//Sprunk machines:
{1789.21,-1369.27,15.1641},
{1729.79,-1943.05,12.9453},
{2060.12,-1897.64,12.9297},
{1928.73,-1772.45,12.9453},
{2325.98,-1645.13,14.2109},
{2352.18,-1357.16,23.7734},
{1154.73,-1460.89,15.1562},
{-1350.12,492.289,10.5859},
{-2118.97,-423.648,34.7266},
{-2118.62,-422.414,34.7266},
{-2097.27,-398.336,34.7266},
{-2092.09,-490.055,34.7266},
{-2063.27,-490.055,34.7266},
{-2005.65,-490.055,34.7266},
{-2034.46,-490.055,34.7266},
{-2068.56,-398.336,34.7266},
{-2039.85,-398.336,34.7266},
{-2011.14,-398.336,34.7266},
{-1980.79,142.664,27.0703},
{2319.99,2532.85,10.2188},
{1520.15,1055.27,10.00},
{2503.14,1243.7,10.2188},
{2085.77,2071.36,10.4531},
{-862.828,1536.61,21.9844},
{-14.7031,1175.36,18.9531},
{-253.742,2597.95,62.2422},
{201.016,-107.617,0.898438},
{1277.84,372.516,18.9531}
};
public OnPlayerConnect(playerid) {

    RemoveVendingMachines(playerid);
    //Remove công viên RC//
    RemoveBuildingForPlayer(playerid, 764, 1341.180, 274.531, 17.843, 0.250);
    RemoveBuildingForPlayer(playerid, 764, 1337.130, 265.156, 18.937, 0.250);
    RemoveBuildingForPlayer(playerid, 764, 1333.060, 255.789, 17.492, 0.250);
    RemoveBuildingForPlayer(playerid, 764, 1329.000, 246.414, 18.937, 0.250);
    RemoveBuildingForPlayer(playerid, 13562, 1308.458, 255.022, 27.804, 0.250);
    RemoveBuildingForPlayer(playerid, 1687, 1326.660, 264.062, 24.858, 0.250);
    RemoveBuildingForPlayer(playerid, 12847, 1320.838, 266.687, 22.850, 0.250);
    RemoveBuildingForPlayer(playerid, 13224, 1320.838, 266.687, 22.850, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 1351.828, 288.381, 23.006, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1338.250, 259.773, 18.819, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 1330.630, 240.578, 23.006, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1316.390, 247.867, 18.819, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 1301.078, 253.929, 23.006, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 1311.338, 277.773, 23.023, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1322.869, 300.031, 18.819, 0.250);
    RemoveBuildingForPlayer(playerid, 12848, 1333.348, 271.006, 19.554, 0.250);
    RemoveBuildingForPlayer(playerid, 1351, 1334.150, 240.679, 18.475, 0.250);


    //Remove Cow Fram//
    RemoveBuildingForPlayer(playerid, 3374, -50.015, 3.179, 3.476, 0.250);

    //Remove Map Blueberry//
    RemoveBuildingForPlayer(playerid, 13077, 272.804, -239.046, 5.578, 0.250);
    RemoveBuildingForPlayer(playerid, 13079, 272.804, -239.046, 5.578, 0.250);

    //Remove Map Dillimore//
    RemoveBuildingForPlayer(playerid, 1410, 731.859, -599.726, 16.000, 0.250);
    RemoveBuildingForPlayer(playerid, 1410, 731.859, -595.054, 16.039, 0.250);
    RemoveBuildingForPlayer(playerid, 782, 735.531, -599.015, 15.453, 0.250);

    return 1;
}
RemoveVendingMachines(playerid)
{
    // Remove 24/7 machines
    RemoveBuildingForPlayer(playerid, 1776, -33.8750, -186.7656, 1003.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 1775, -32.4453, -186.6953, 1003.6328, 0.25);
    
    // Remove all other machines
    for(new i = 0; i < sizeof(VMachines); i++)
    {
        RemoveBuildingForPlayer(playerid, 955, VMachines[i][0], VMachines[i][1], VMachines[i][2], 0.50);
        RemoveBuildingForPlayer(playerid, 956, VMachines[i][0], VMachines[i][1], VMachines[i][2], 0.50);
    }
    return 1;
}