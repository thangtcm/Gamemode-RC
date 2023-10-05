#include <a_samp>
#include <streamer>
#define FILTERSCRIPT
public OnPlayerConnect(playerid) {

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
