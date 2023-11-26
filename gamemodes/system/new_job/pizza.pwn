#include <a_samp>
#include <YSI_Coding\y_hooks>


new BanhPizzaInCar[MAX_PLAYERS];
new BanhPizzaInFoot[MAX_PLAYERS];
new Text3D:PizzaTextInfo[MAX_PLAYERS];
new zzstr[129];
new TienLuongPizza[MAX_PLAYERS];
new MonitorPizzaCar[MAX_PLAYERS];
new TimeExitsPizzaCar[MAX_PLAYERS];

new Float:pizza_postion[9][3] = {
{1372.5529,405.4841,19.9555},
{1475.7509,373.7871,19.6563},
{1233.3397,224.7737,19.5547},
{1299.1719,140.9764,20.4074},
{1234.5676,359.0692,19.5547},
{1213.0397,224.6016,19.5547},
{1323.5597,374.9776,19.5625},
{1244.1217,203.8483,19.6454},
{1394.6504,400.6509,19.7578}
};

forward MonitorPizzaCarPlayer(playerid);
 
CMD:laybanh(playerid,params[]) {
	if(LamViec[playerid] != 1 || LamViec[playerid] == 0 && LamViec[playerid] != 1) return SendErrorMessage(playerid, " Ban chua lam cong viec Pizza.");
	if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
	if(BanhPizzaInFoot[playerid] == 1) return SendErrorMessage(playerid, " Ban da cam banh tren tay khong the lay them.");
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec."); 
	if(IsPlayerInRangeOfPoint(playerid, 5, 1362.9523,253.9632,19.5669)) {
        SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1582, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        BanhPizzaInFoot[playerid] = 1;
       	return SendServerMessage(playerid, "Ban da cam banh tren tay, hay nhan nut 'N' de dua len xe.");
	}
	else {
	   SendErrorMessage(playerid, " Ban khong o noi lay banh khong the lay banh.");
	}
	return 1;
}
CMD:pizza(playerid,params[]) {
	if(LamViec[playerid] == 0) { 
		CP[playerid] = 0;
		ShowPlayerDialog(playerid, PIZZABOY_MENU, DIALOG_STYLE_LIST, "Pizza Boy", "Lam viec\nLay banh\nGiao banh\nVut bo banh", "Lua chon", "Thoat");
    }
    else if(LamViec[playerid] == 1) {
    	CP[playerid] = 0;
    	ShowPlayerDialog(playerid, PIZZABOY_MENU, DIALOG_STYLE_LIST, "Pizza Boy", "Dung lam viec\nLay banh\nGiao banh\nVut bo banh", "Lua chon", "Thoat");
    } 
    return 1;
}

CMD:giaobanh(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerVehicleID(playerid) != PizzaCar[playerid]) return SendErrorMessage(playerid, " Ban khong o tren xe [Pizza].");
	if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec."); 
	if(GetPVarInt(playerid, "giaobanh_Pizza") == 1) return SendErrorMessage(playerid, " Ban dang giao banh, hay giao xong roi hay tiep tuc.");
	if(BanhPizzaInCar[playerid] <= 0) return SendErrorMessage(playerid, "Ban chua co chiec banh nao tren xe de di giao hang.");
	if(LamViec[playerid] != 1) return SendErrorMessage(playerid, " Ban khong lam viec [PIZZA].");
	new postrandom = random(9);
	new zone[MAX_ZONE_NAME];
	Get3DZone(pizza_postion[postrandom][0],pizza_postion[postrandom][1],pizza_postion[postrandom][2], zone, sizeof(zone));
	SetPlayerCheckPointEx(playerid, pizza_postion[postrandom][0],pizza_postion[postrandom][1],pizza_postion[postrandom][2], 3);
	format(zzstr, sizeof(zzstr), "Giao banh pizza den: %s\nKhu vuc: %s\nKhoang cach: %0f met", GetNameDeliverPizza(postrandom),zone,GetPlayerDistanceFromPoint(playerid, pizza_postion[postrandom][0],pizza_postion[postrandom][1],pizza_postion[postrandom][2]));
	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Thong tin cong viec - Dia diem giao banh", zzstr, "Dong", "");
	SetPVarInt(playerid, "giaobanh_Pizza", 1);
	SetPVarInt(playerid, "postion_Pizza", postrandom);
	return 1;
}
stock GetNameDeliverPizza(iddeliver) {
	new name[32];
	switch(iddeliver) {
		case 0: name = "Chirs Fat";
		case 1: name = "Stanley Taellious";
		case 2: name = "Jacob Sylvester";
		case 3: name = "Deontray Travis";
		case 4: name = "Travis Scott";
		case 5: name = "Cristiano Ronaldo";
		case 6: name = "Roberto Carlos";
		case 7: name = "David Beckham";
		case 8: name = "Leoniel Messi";
		case 9: name = "Sergio Ramos";
	}
	return name;
}

hook OnPlayerConnect(playerid)
{
	PizzaCar[playerid] = INVALID_VEHICLE_ID;
	TimeExitsPizzaCar[playerid] = 10*60; // 5 phut
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyVehiclePizza(playerid);
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PizzaCar[playerid] == vehicleid)
	{
		KillTimer(MonitorPizzaCar[playerid]);
		TimeExitsPizzaCar[playerid] = 10*60; // 10 phut
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PizzaCar[playerid] == vehicleid)
	{
		MonitorPizzaCar[playerid] = SetTimerEx("MonitorPizzaCarPlayer", 1000, true, "d", playerid);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid) {
			case PIZZABOY_MENU: {
        	if(!response) return 1;
        	switch(listitem) {
        		case 0: {
        			if(!IsPlayerInRangeOfPoint(playerid, 5, 1362.9523,253.9632,19.5669)) return SendErrorMessage(playerid, " Ban khong dung gan noi lam viec Pizza."); 
        			if(PlayerInfo[playerid][pStrong] <= 1) return SendErrorMessage(playerid, " Ban da qua met moi khong the lam viec."); 
        			if(LamViec[playerid] == 0) {
						if(PizzaCar[playerid] == - 1) DestroyVehiclePizza(PizzaCar[playerid]);
	    				ActSetPlayerPos(playerid, 1380.8643,270.4954,21.9751);
		    			PizzaCar[playerid] = CreateVehicle(448, 1367.3431,270.6667,19.5669, 0 , random(255), random(255), -1);
						VehicleFuel[PizzaCar[playerid]] = GetVehicleFuelCapacity(PizzaCar[playerid]);
						PlayerOnVehicle[playerid] = PizzaCar[playerid] ;
						new fVW = GetPlayerVirtualWorld(playerid);
						SetVehicleHealth(PizzaCar[playerid], 900.0);
						Vehicle_ResetData(PizzaCar[playerid]);
						LinkVehicleToInterior(PizzaCar[playerid], GetPlayerInterior(playerid));
						SetVehicleVirtualWorld(PizzaCar[playerid], fVW);
	        			ActPutPlayerInVehicle(playerid, PizzaCar[playerid] ,0);
	       				SetPVarInt(playerid, "IsDaThue", 1);
	       				LamViec[playerid] =1;
	        			BanhPizzaInCar[playerid] = 0;
	        			format(zzstr, sizeof zzstr, "Xe Pizza cua: {2791FF}%s{ffffff}\nBanh trong xe: {2791FF}%d/5{ffffff}", GetPlayerNameEx(playerid),BanhPizzaInCar[playerid]);
	        			PizzaTextInfo[playerid] = Create3DTextLabel(zzstr, COLOR_WHITE, 0.0, 0.0, 0.0, 50.0, 0, 1);
           				Attach3DTextLabelToVehicle(PizzaTextInfo[playerid], PizzaCar[playerid], 0.0, 0.0, 2.0); // Attaching Text Label To Vehicle.
           				SendClientMessageEx(playerid,COLOR_VANG,"Ban da bat dau lam viec 'Pizza Boy' hay di den pickup lay banh va chat len xe (Press 'H' de lay banh/Press 'N' de cat banh vao xe)");
	    				SendClientMessageEx(playerid,COLOR_VANG,"Bam '2' chon giao banh de bat dau di giao");
	    				SetPVarInt(playerid, #danglamviec, 1);
	        			return 1;
	    			}
	    			else if(LamViec[playerid] == 1) {
	        			new str[129];
	    				format(str, sizeof str,"Ban da ngung lam viec thanh cong, so tien luong ban nhan duoc la $%d", TienLuongPizza[playerid]*2);
	    				PlayerInfo[playerid][pCash] += TienLuongPizza[playerid]*2;
	    				TienLuongPizza[playerid] = 0;
	    				SendClientMessageEx(playerid,COLOR_VANG,str);
	        			LamViec[playerid] =0;
	        			DeletePVar(playerid, "IsDaThue");
	        			DestroyVehiclePizza(playerid);
	        			BanhPizzaInCar[playerid] = 0;
	        			DeletePVar(playerid, "giaobanh_Pizza");
             			DeletePVar(playerid, "postion_Pizza");
             			DisablePlayerCheckpoint(playerid);
             			Delete3DTextLabel(PizzaTextInfo[playerid]);
             			SetPVarInt(playerid, #danglamviec, 0);
             			return 1;
	    			}
        		}
        		case 1: {
    		       return cmd_laybanh(playerid, "\1");
        		}
        		case 2: {  			
		    		if(BanhPizzaInFoot[playerid] != 1) return SendErrorMessage(playerid, " Ban phai cam banh tren tay moi co the vut bo.");
		    		BanhPizzaInFoot[playerid] = 0;
		    		RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
            		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        		}
            }
	    }
	}
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid) {

	if(GetPVarInt(playerid, "giaobanh_Pizza") == 1) 
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Vui long xuong xe de giao banh.");
        if(BanhPizzaInFoot[playerid] != 1) return SendErrorMessage(playerid, " Ban khong cam banh tren tay.");
        new pizzamoney = 10 + random(10);
        TienLuongPizza[playerid] += pizzamoney;
        format(zzstr, sizeof zzstr, "Ban da giao banh 'Pizza' thanh cong va nhan duoc '$%d' Dollar (Tien luong hien tai la: %d )", pizzamoney, TienLuongPizza[playerid]);     
        SendClientMessage(playerid,COLOR_WHITE,zzstr);
        RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        DeletePVar(playerid, "giaobanh_Pizza");
        DeletePVar(playerid, "postion_Pizza");
        DisablePlayerCheckpoint(playerid);	
		BanhPizzaInFoot[playerid] = 0;
		CheckDoneMisson(playerid, 0);
	//	if(LamViec[playerid] != 1) return 1;
		if(BanhPizzaInCar[playerid] > 0)
		{
			SendClientMessageEx(playerid,COLOR_VANG,"Bam '2' de tiep tuc giao banh.");
		}
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(IsPlayerInRangeOfPoint(playerid, 5, 1362.9523,253.9632,19.5669))
	{
	    if(newkeys & KEY_CTRL_BACK)
	    { 
	    	return cmd_pizza(playerid, "/1"); 
	    }
	}
	if(LamViec[playerid] == 1)
    {
		if(newkeys & 512)
		{
			return cmd_giaobanh(playerid, "/1"); 
		}
    	if(newkeys & KEY_NO)
	    { 
	    	if(!IsPlayerInRangeOfVehicle(playerid, PizzaCar[playerid], 3)) return 1;
			if(IsPlayerInAnyVehicle(playerid)) return 1;
            if(BanhPizzaInFoot[playerid] == 1) {
            	if(BanhPizzaInCar[playerid] >= 5)  return SendErrorMessage(playerid, " Banh Pizza tren xe da dat den gioi han (5/5).");
             	BanhPizzaInFoot[playerid] = 0;
             	BanhPizzaInCar[playerid] ++;
            	RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
           	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
           	    format(zzstr, sizeof zzstr, "Ban da bo 1 Pizza vao xe, so banh ({2791FF}%d/5{ffffff})",BanhPizzaInCar[playerid]);
           	    SendClientMessageEx(playerid,-1,zzstr);
            	format(zzstr, sizeof zzstr, "Xe Pizza cua: {2791FF}%s{ffffff}\nBanh trong xe: {2791FF}%d/5{ffffff}", GetPlayerNameEx(playerid),BanhPizzaInCar[playerid]);
            	Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, zzstr);
            	return 1;
            }
            else if(BanhPizzaInFoot[playerid] == 0) { 
            	if(BanhPizzaInCar[playerid] <= 0)  return SendErrorMessage(playerid, " Banh Pizza tren xe da het (0/5).");
            	if(PlayerInfo[playerid][pStrong] > 1) // The luc
            	{
	             	BanhPizzaInFoot[playerid] = 1;
	             	BanhPizzaInCar[playerid] --;
	            	SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1582, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
	            	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	            	format(zzstr, sizeof zzstr, "Ban da lay 1 Pizza tu xe, so banh ({2791FF}%d/5{ffffff})",BanhPizzaInCar[playerid]);
	           	    SendClientMessageEx(playerid,-1,zzstr);
	            	format(zzstr, sizeof zzstr, "Xe Pizza cua: {2791FF}%s{ffffff}\nBanh trong xe: {2791FF}%d/5{ffffff}", GetPlayerNameEx(playerid),BanhPizzaInCar[playerid]);
	            	Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, zzstr);
					new postrandom = GetPVarInt(playerid, "postion_Pizza");
					SetPlayerCheckPointEx(playerid, pizza_postion[postrandom][0],pizza_postion[postrandom][1],pizza_postion[postrandom][2], 3);
	            }
	            else return SendErrorMessage(playerid, " Ban da qua met moi va khong the lam viec, hay an uong de tang the luc.");

            }
        }
    }
    return 1;
}

stock DestroyVehiclePizza(playerid)
{
	Delete3DTextLabel(PizzaTextInfo[playerid]);
	DestroyVehicle(PizzaCar[playerid]);
	PizzaCar[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

public MonitorPizzaCarPlayer(playerid)
{
	if(PizzaCar[playerid] == INVALID_VEHICLE_ID) return 1;
	--TimeExitsPizzaCar[playerid];
	if(TimeExitsPizzaCar[playerid] <= 0)
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "Xe Pizza cua ban da duoc thu hoi vi qua 10 phut khong su dung");
		DestroyVehiclePizza(playerid);
		KillTimer(MonitorPizzaCar[playerid]);
		TimeExitsPizzaCar[playerid] = 10*60; // 5 phut
	}
	return 1;
}