#include <YSI_Coding\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 588.1791,866.1268,-42.4973))
	{
	    if(PRESSED(KEY_YES))
	    {
	    	Dialog_Show(playerid, minerdialog, DIALOG_STYLE_LIST, "Quan ly khu mo", "Nhan / tra dong phuc lam viec\nMua Pickaxe (dung cu de dao)", "Lua chon", "Huy bo");
	    }
	}
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid, #skinsavezxc) != 0)
	{
		new skinc = GetPVarInt(playerid, #skinsavezxc);
		SetPlayerSkin(playerid, skinc);
		SetPVarInt(playerid, #skinsavezxc, 0);
	}
}