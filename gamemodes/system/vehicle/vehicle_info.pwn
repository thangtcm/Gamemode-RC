CMD:dangkygiaytoxe(playerid,params[]) {
	if(IsPlayerInRangeOfPoint(playerid, 5, 222.3378,2343.4067,1017.0952)) {
        new vstring[1000], icount = GetPlayerVehicleSlots(playerid);
		for(new i, iModelID; i < icount; i++)
		{
			if((iModelID = PlayerVehicleInfo[playerid][i][pvModelId] - 400) >= 0)
			{
			    format(vstring, sizeof(vstring), "%s\n[%d]%s", vstring,PlayerVehicleInfo[playerid][i][pvSlotId], VehicleName[iModelID]);	
			}		
		}
		ShowPlayerDialog(playerid, GIAYTOXE, DIALOG_STYLE_LIST, "Kho phuong tien", vstring, "Chon", "Huy bo");
	}
	return 1;
}
// GetPlayerVehicle(playerid, vehicleid)
stock ShowPlayerCarText(playerid,giveplayerid,vehslot) {
	new carstr[2000],sonha[100],typecar[50],modelid = PlayerVehicleInfo[giveplayerid][vehslot][pvModelId];
    sonha = "Vo gia cu";
    if( PlayerInfo[giveplayerid][pPhousekey] != INVALID_HOUSE_ID )
    {
        new h = PlayerInfo[giveplayerid][pPhousekey], zone[50];
        Get3DZone(HouseInfo[h][hExteriorX], HouseInfo[h][hExteriorY], HouseInfo[h][hExteriorZ],zone, sizeof(zone));
        format(sonha,sizeof(sonha),"%d %s San Andreas",PlayerInfo[giveplayerid][pPhousekey],zone);
    }
      
    typecar = "Xe 4 banh";
    if(IsABike(modelid)) {
        typecar = "Xe gan may";
    } 
      
    else if(IsAPlane(modelid)) {
        typecar = "May bay";
    } 
        		
    else if(IsABoat(modelid)) {
        typecar = "Tau Thuyen";
    } 
	format(carstr, sizeof(carstr), "{ffffff}\\c    Vui long xac nhan dang ky giay to xe\n\
        \\c      Ten chu xe: {07b4f6}%s{ffffff}\n\
        \\c      Dia chi: {07b4f6}%s{ffffff} \n\
        \\c      Loai xe: {07b4f6}%s{ffffff} \n\
        \\c      Nhan hieu: {07b4f6}%s{ffffff} \n\
        \\c      Mau xe: {8d2828}Khong xac dinh{ffffff} \n\
        \\c      Nguon goc: {97ffb3}San Andreas{ffffff} \n\
        \\c      Bien so xe: {07b4f6}LS-Ngau nhien{ffffff} \n\
        \\c      Phi dang ky: {07b4f6}Mien phi(chinh phu tai tro)",GetPlayerNameEx(giveplayerid),sonha,typecar,GetVehicleName(PlayerVehicleInfo[giveplayerid][vehslot][pvId]));
    ShowPlayerDialog(playerid,DIALOG_NOTHING,DIALOG_STYLE_MSGBOX,"Car Information" ,carstr ,"Dong y","Thoat");
    return 1;
}
//  
      