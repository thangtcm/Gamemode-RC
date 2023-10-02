
#define SERVER_GM_TEXT "LSR 1.0"


#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <yom_buttons>
#include <ZCMD>
#include <sscanf2>
#include <foreach>
#include <YSI\y_timers>
#include <YSI\y_utils>
#include <YSI\y_ini>
#include <crashdetect>
#include <DialogCenter>
#include <compat>
#include <easyDialog>
#include <mSelection>
#include <eInventory>
#include <stamina>
#include <YSF>
#include <discord-connector>
#include <discord-cmd>
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
#include "./system/new_job/Farmer/main.pwn"
#include "./system/noithat.pwn"
#include "./system/haha.pwn"
#include "./system/danhba.pwn"
#include "./system/driver_test.pwn"
#include "./system/weapon/ammo.pwn"
#include "./system/register_char.pwn"
#include "./main/discord-bot.pwn"
// Doi, no, suc khoe
#include "./system/playerstatus.pwn"

#include "./system/vehicle/vehicle_info.pwn"

#include "./main/functions.pwn"

#include "./system/inventory/inventory.pwn"
#include "./system/speedo.pwn"
#include "./system/gps_system.pwn"

#include "./system/newfaction/handcuff.pwn"
#include "./system/animation.pwn"
#include "./system/charactertd.pwn"
//#include "./system/hunger.pwn"
#include "./main/timers.pwn"


#include "./system/sell_car.pwn"
#include "./main/command.pwn"
#include "./system/chat.pwn"
#include "./main/area.pwn"

#include "./main/_funcs.pwn"
#include "./main/_cmds.pwn"

#include "./main/mysql.pwn"
//#include "./system/login.pwn"
//#include "./system/register.pwn"
#include "./system/drug/drug.pwn"
#include "./system/new_job/Trucking/textdrawanim.pwn"
#include "./system/new_job/Trucking/main.pwn"
#include "./system/new_job/Trucking/tutorial.pwn"
#include "./system/new_job/pizza.pwn"
#include "./system/new_job/miner/mn_variables.pwn"
#include "./system/new_job/miner/mn_callbacks.pwn"
#include "./system/new_job/miner/mn_funcs.pwn"
//#include "./system/new_job/daoda.pwn"  bảo trì
#include "./system/new_job/wood.pwn"
#include "./system/new_job/caucanew.pwn"
// #include "./system/farmer.pwn"
#include "./system/bodydame/bodydamage.pwn"
#include "./system/vehicle/vehicle_info.pwn"
#include "./system/nametag.pwn"

#include "./include/onplayerfishnishloading.pwn"

main() {
}

public OnGameModeInit()
{
	DCC_SetBotActivity("RC:RPvn");
	DCC_SetBotPresenceStatus(DO_NOT_DISTURB);
	ShowNameTags(0);
	print("Chuong trinh may chu dang duoc khoi dong, vui long cho doi....");
	g_mysql_Init();
	return 1;
}
public OnGameModeExit()
{
    g_mysql_Exit();
	return 1;
}
