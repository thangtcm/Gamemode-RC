CMD:daoda(playerid,params[]) {
	if(GetPVarInt(playerid, "DangDaoDa") == 1) return SendClientTextDraw(playerid," Ban ~r~dang dao da~w~ roi");
	if(InventoryInfo[playerid][pSoLuong][23] == 0) return SendClientTextDraw(playerid," Ban ~r~khong co cuoc~w~ de dao da");
	if(IsPlayerInRangeOfPoint(playerid,30, 581.6000,939.5470,-42.6158))
	{
		LoaderStarting(playerid, LoadingDaoDa, "Dang dao da...", 1,5);
		ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
		SetPVarInt(playerid,"DangDaoDa",1);
		SetPlayerAttachedObject(playerid, PIZZA_INDEX, 19631, 6, -0.059999,	0.034,	0.319,	21,	-110.5,	112.8,	1,	1,	1, 0, 0);
	}
	return 1; 
}