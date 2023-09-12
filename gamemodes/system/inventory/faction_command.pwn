
CMD:kiemtracopxe(playerid, params[])
{
	if(IsACop(playerid))
	{
		new vehicleid ,  iVehType, iVehIndex, iTargetOwner;
		if(sscanf(params, "d", vehicleid)) return SendUsageMessage(playerid, " /kiemtracopxe [vehicleid]");
		
		if(IsPlayerInAnyVehicle(playerid))
		{
			SendErrorMessage(playerid, " Ban khong the lam dieu nay, ban dang trong xe.");
			return 1;
		}
		if(GetPVarInt(playerid, "IsInArena") >= 0)
		{
			SendServerMessage(playerid, " Ban khong the lam dieu nay bay gio, ban dang trong arena!");
			return 1;
		}
		if(GetPVarInt( playerid, "EventToken") != 0)
		{
			SendErrorMessage(playerid, " Ban khong the lam dieu nay khi dang tham gia su kien.");
			return 1;
		}
		if(PlayerCuffedTime[playerid] > 0)
		{
			SendErrorMessage(playerid, " Ban khong the lam dieu nay bay gio.");
			return 1;
		}
		if(GetPVarInt(playerid, "Injured") == 1)
		{
			SendErrorMessage(playerid, " Ban khong the lam dieu nay bay gio.");
			return 1;
		}
		if(PlayerInfo[playerid][pJailTime] > 0)
		{
			SendServerMessage(playerid, " Ban khong the lam dieu nay trong tu.");
			return 1;
		}
		if(PlayerCuffed[playerid] >= 1) {
			SendServerMessage(playerid, " Ban khong the lam dieu nay bay gio.");
			return 1;
		}

		if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 5)) return SendErrorMessage(playerid, " Ban khong dung gan chiec xe do.");
		foreach(new i: Player)
		{
			iVehIndex = GetPlayerVehicle(i, vehicleid);
			if(iVehIndex != -1)
			{
				iVehType = 1;
				iTargetOwner = i;
				break;
			}
		}
		if(iVehType == 1)
		{
			new inventorystr[900]; 
			inventorystr = "Slot\tTen vat pham\tSo luong";
			for(new i = 0 ; i < 20 ; i++) {
				if(VehicleInventory[iTargetOwner][iVehIndex][pSlot][i] != 0) {
					format(inventorystr, sizeof inventorystr, "%s\n> %d\t %s\t %d", inventorystr,i,GetInventoryItemName(VehicleInventory[iTargetOwner][iVehIndex][pSlot][i]),VehicleInventory[iTargetOwner][iVehIndex][pSoLuong][VehicleInventory[iTargetOwner][iVehIndex][pSlot][i]] );           
				}        
            }
            new vavas[80];
            format(vavas, sizeof vavas, "Cop xe %s(%d) ( Chu so huu %s(%d) )", GetVehicleName(PlayerVehicleInfo[iTargetOwner][iVehIndex][pvId]),PlayerVehicleInfo[iTargetOwner][iVehIndex][pvId],GetPlayerNameEx(iTargetOwner),iTargetOwner);
            ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_TABLIST_HEADERS, vavas, inventorystr, "Dong Y", "Thoat");
            return 1;
		}
		else {
			SendErrorMessage(playerid, " Phuong tien khong co chu so huu hop le.");
		}
	}
	else {
		SendErrorMessage(playerid, " Ban khong phai canh sat.");
	}
	return 1;
}
