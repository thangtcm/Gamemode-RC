#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	CreateObject(2332, 2305.73047, -0.39158, 26.16562,   0.00000, 0.00000, 90);
	CreateDynamic3DTextLabel("{FF0000}Su dung '/cuoptien' de cuop", -1, 2305.73047, -0.39158, 26.16562+0.6,12.0);
	return 1;
}