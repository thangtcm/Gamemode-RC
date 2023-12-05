 
#define SERVER_GM_TEXT "RCRP 1.0"


#include <a_samp>

#include <a_mysql>
#include <streamer>
#include <fixobject>
#include <yom_buttons>
#include <ZCMD>
#include <sscanf2>
#include <foreach>
#include <YSF>
#include <YSI\y_timers>
#include <YSI\y_utils>
#include <YSI\y_ini>
#include <compat>
#include <easyDialog>
#include <mSelection>
#include <eInventory>
#include <eInvCarHouse>
#include <stamina>
#include <discord-connector>
#include <discord-cmd>
#include <bcrypt>
#include <GPS>
#include <samp-player-gangzones>
#if defined SOCKET_ENABLED


#include <socket>
#endif
#pragma disablerecursion
// player - inventory
// mapping
#include "./system/map/cityhall.pwn"
#include "./include/messclient.pwn"
#include "./include/checkgame.pwn"
#include "./main/dialog_defines.pwn"
#include "./main/color_defines.pwn"
#include "./include/textclient.pwn"
#include "./main/defines.pwn"
#include "./main/variables.pwn"
#include "./include/loading.pwn"
#include "./system/new_job/pickup.pwn"
#include "./system/new_job/newtrashman.pwn"
// #include "./system/new_job/Farmer/raise.pwn"
#include "./system/noithat.pwn"
#include "./system/haha.pwn"
#include "./system/danhba.pwn"
// #include "./system/driver_test.pwn"


#include "./system/register_char.pwn"
#include "./main/discord-bot.pwn"
// Doi, no, suc khoe
#include "./system/playerstatus.pwn"
#include "./system/vehicle/vehicle_info.pwn"
#include "./system/drug/drug.pwn"
#include "./system/inventory/main.pwn"
#include "./system/bussiness/inventorybiz.pwn"
#include "./system/weapon/ammo.pwn"

#include "./main/functions.pwn"

#include "./system/casino/casino.pwn"

#include "./system/chiemdong.pwn"
#include "./system/speedo.pwn"
#include "./system/help.pwn"
#include "./system/gps_system.pwn"

#include "./system/LevelJob.pwn"

#include "./system/newfaction/handcuff.pwn"
#include "./system/newfaction/factionkick.pwn"
#include "./system/animation.pwn"
#include "./system/charactertd.pwn"
//#include "./system/hunger.pwn"
#include "./main/timers.pwn"

// #include "./system/sell_car.pwn"
#include "./main/command.pwn"
#include "./system/chat.pwn"
#include "./main/area.pwn"

#include "./main/_funcs.pwn"
#include "./main/_cmds.pwn"

#include "./main/mysql.pwn"
//#include "./system/login.pwn"`
//#include "./system/register.pwn"

#include "./system/new_job/Trucking/textdrawanim.pwn"
#include "./system/new_job/Farmer/main.pwn"
#include "./system/new_job/Trucking/main.pwn"
#include "./system/new_job/Trucking/tutorial.pwn"
#include "./system/new_job/pizza.pwn"
#include "./system/new_job/miner/mn_variables.pwn"
#include "./system/new_job/miner/mn_callbacks.pwn"
#include "./system/new_job/miner/mn_funcs.pwn"
#include "./system/new_job/wood.pwn"
#include "./system/new_job/fishing.pwn"

// #include "./system/farmer.pwn"
//#include "./system/bodydame/bodydamage.pwn"
#include "./system/vehicle/vehicle_info.pwn"
#include "./system/vehicle/vehsign.pwn"
#include "./system/nametag.pwn"
#include "./system/mission/Misson.pwn"
#include "./system/mission/ThiBanglai.pwn"
#include "./system/mechanic/mechanic.pwn"
// ============= GPS ============= //
#include "./system/gps/gps.pwn"
// ============= ANTI ============= //
#include "./anticheat/anti_airbreak.pwn"
#include "./anticheat/cartroll.pwn"

#include "./system/death/bodydamage.pwn"
#include "./system/death/dmg.pwn"

#include "./system/rob/bank.pwn"

#include "./include/onplayerfishnishloading.pwn"

main() {
}

public OnGameModeInit()
{
	DCC_SetBotActivity("RC:RPvn");
	DCC_SetBotPresenceStatus(DO_NOT_DISTURB);
	ShowNameTags(0);
	DisableNameTagLOS();
	print("Chuong trinh may chu dang duoc khoi dong, vui long cho doi....");
	g_mysql_Init();


	new slot;
	for(new i; i < Streamer_CountItems( STREAMER_TYPE_OBJECT ); i++) 
	{
		if (!IsValidDynamicObject(i)) continue;

		switch (Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID)) 
		{
			case 849, 850, 851, 852, 853, 854, 1220, 1221, 
				1264, 1265, 1328, 1449, 1455, 1484, 1485, 1486, 1487, 1509, 1510, 1512, 1517, 1520, 
				1543, 1544, 1546, 1551, 1664, 1665, 1667, 1668, 1669, 1672, 1886, 2055, 2056, 2057, 
				2059, 2102, 2103, 2114, 2221, 2222, 2223, 2342, 2345, 2353, 2354, 2355, 2384, 2386, 
				2396, 2397, 2398, 2399, 2401, 2611, 2612, 2615, 2619, 2670, 2671, 2672, 2673, 2674, 
				2675, 2676, 2677, 2690, 2812, 2814, 2816, 2819, 2820, 2821, 2823, 2824, 2825, 2826, 
				2827, 2829, 2830, 2831, 2832, 2684, 2685, 2686, 2687, 2702, 2703, 2726, 2749, 2750, 
				2751, 2752, 2753, 2767, 2768, 2769, 2828, 2856, 2857, 2858, 2859, 2860, 2861, 2866, 
				2867, 2894, 2913, 2915, 2916, 3042, 3675, 9831, 10984, 11707, 11745, 14842, 19792, 
				19804, 19808, 19807, 19811, 19813, 19814, 19818, 19819, 19820, 19821, 19822, 19823, 
				19824, 19826, 19827, 19828, 19829, 19835, 19836, 19847, 19873, 19874, 19883, 19892, 
				19893, 19896, 19897, 19898 : 
			{
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, i, E_STREAMER_DRAW_DISTANCE, 30.0);
				slot++;
			}
		}
	}
	
	printf("[Streamer] Objects are optimized. Total: %d", slot);


	return 1;
}
public OnGameModeExit()
{
    g_mysql_Exit();
	return 1;
}
