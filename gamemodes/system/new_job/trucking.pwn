#include <a_samp>
#include <YSI\y_hooks>

#define TRUCKBACKCAR 1030
#define DIALOG_TRUCKER1 1031
#define DIALOG_TRUCKER2 1031
#define DIALOG_TRUCKER 1033
#define DIALOG_MENUVIEC 1034	



new TruckVehicleID[MAX_PLAYERS];
new TimeExitsTruckCar[MAX_PLAYERS];
new MonitorTruckCar[MAX_PLAYERS];
forward MonitorTruckCarPlayer(playerid);
new TimeExitsTruckerCar[MAX_PLAYERS];
new PlayerText:PizzaText[MAX_PLAYERS][3];
new Float:PosOne[12][3] = {
{1420.2244,1055.5012,10.8203}, // Kakagawa's Electronic Store , thiết bị điện tử
{1697.5702,1040.8556,10.8203 }, // Carrie & Goodes Loading Bay linh kiện xe hơi 
{1725.9431,1291.8706,10.6719},
{1689.3011,1760.1648,10.8203},
{1496.7932,2197.1035,10.8203},
{1087.5483,1873.9329,10.8203},
{1059.1980,-337.7552,73.9851},
{2467.0938,-2548.4641,13.6484},
{2082.9478,-2210.8584,13.5469},
{-52.1709,-1142.1111,1.0781},
{-1945.6929,-1080.0854,30.7734}, 
{-1742.1216,154.7138,3.5496}
};

new Float:PosTwo[13][3] = {
{-2457.5754,2290.4949,4.9844},
{-161.1713,1228.0072,19.7422},
{337.1104,854.2507,20.4063},
{136.8513,-268.3735,1.5781},
{677.9984,-442.8136,16.3359},
{1823.1954,-1141.1267,24.0744},
{337.1104,854.2507,20.4063},
{1375.0060,-1886.3628,13.4940},
{-267.5153,-2192.8596,28.8271},
{-1090.7732,-1624.5985,76.3672},
{-512.1000,-550.1252,25.5234},
{-763.5640,-103.7077,65.6992},
{2230.3364,63.2628,26.4844,}
};
new RandomPosTruck[MAX_PLAYERS];
new LamViec[MAX_PLAYERS];
new Trailer[MAX_PLAYERS];
/*hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if ((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP))
 	{
 		if(IsPlayerAttachedObjectSlotUsed(playerid,PIZZA_INDEX))
        {

        	if(GetPVarInt(playerid, "ThungCaObj")) return 1;
        	cmd_me(playerid,"da bi te nga va rot banh xuong dat.");
        	ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
			ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);
			RemovePlayerAttachedObject(playerid,PIZZA_INDEX);
		    DisablePlayerCheckpoint(playerid);
			PlayerCheckpoints[playerid] = CHECKPOINT_NONE;
			return 1;
        }
 	}
	if(newkeys == KEY_YES)
	{
	    if(LamViec[playerid] == 1)
        {
            if(GetPVarInt(playerid, "BiThuong") == 1) return SendClientTextDraw(playerid, "Ban khong the lam viec nay khi ~y~ bi thuong");
            if(!IsPlayerAttachedObjectSlotUsed(playerid,PIZZA_INDEX))
            {
                if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
                {
                    new Float:X,Float:Y,Float:Z;
                    for(new j=0;j<MAX_PIZZA_CARS;j++)
                    {
                        GetVehiclePos(ThueXePizza[playerid],X,Y,Z);
                        if(IsPlayerInRangeOfPoint(playerid,3.0,X,Y,Z))
                        {
                            if(PizzaBikesPizzas[ThueXePizza[playerid]] >= 1)
                            {
                            	cmd_me(playerid, "lay mot chiec banh Pizza tu xe ra.");
                                PizzaBikesPizzas[ThueXePizza[playerid]]--;
                              //  ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
                                SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1582, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
                                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                                return 1;
                            }
                            else
                            {
                                SendClientMessage(playerid,-1," Pizza khong con banh hay quay ve su dung /laybanh!");
                                return 1;
                            }   
                        }
                    }
                }
                else return SendClientMessage(playerid,-1 , "Ban khong duoc lam hanh dong nay khi o tren xe!");
            }
            else if(IsPlayerAttachedObjectSlotUsed(playerid,PIZZA_INDEX))
            {
                new Float:X,Float:Y,Float:Z;
                for(new j=0;j<MAX_PIZZA_CARS;j++)
                {
                    GetVehiclePos(ThueXePizza[playerid],X,Y,Z);
                    if(IsPlayerInRangeOfPoint(playerid,3.0,X,Y,Z))
                    {
                    	if(PizzaBikesPizzas[ThueXePizza[playerid]] < 10)
                        {
                            cmd_me(playerid, "cat mot chiec banh vao xe.");
                            PizzaBikesPizzas[ThueXePizza[playerid]]++;
                            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                            RemovePlayerAttachedObject(playerid, PIZZA_INDEX);
                            return 1;
                        }
                        else
                        {
                            SendClientMessage(playerid,-1," Pizza khong con banh hay quay ve su dung /laybanh!");
                            return 1;
                        } 
                    }
                }
            } 
        }
    }
    return 1;
}*/
hook OnPlayerConnect(playerid)
{
    LamViec[playerid] = 0;
	TruckerCar[playerid] = INVALID_VEHICLE_ID;
    TimeExitsTruckerCar[playerid] = 5*60; // 5 phut
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	DestroyVehicle(TruckerCar[playerid]);
	TruckerCar[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(TruckerCar[playerid] == vehicleid)
	{
		KillTimer(MonitorTruckCar[playerid]);
		TimeExitsTruckerCar[playerid] = 5*60; // 5 phut
	}
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(TruckerCar[playerid] == vehicleid)
	{
		MonitorTruckCar[playerid] = SetTimerEx("MonitorTruckCarPlayer", 1000, true, "d", playerid);
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
    switch(dialogid) { 
        case TRUCKER_MENU: {
            if(!response) return 1;
            switch(listitem) {
                case 0: {
                    if(!IsPlayerInRangeOfPoint(playerid, 4,2507.7554,-2120.0732,13.5469)) return SendErrorMessage(playerid," Ban khong o gan noi lam viec truck.");
                    if(LamViec[playerid] != 0 && LamViec[playerid] != 2) return  SendClientMessage(playerid, COLOR_GREY, "Ban dang lam cong viec khac khong the lam Trucker.");  
                    if(LamViec[playerid] != 0) return SendErrorMessage(playerid," Ban dang lam viec khong the lam viec tiep.");
                    SendClientMessage(playerid, COLOR_VANG, "Ban da bat dau lam viec Container, su dung /truck > Lay thung hang de lay thung hang va giao.");
                    SetPlayerPos(playerid, 2519.6191,-2089.2661,13.5469);
                    TruckerCar[playerid] = CreateVehicle(515, 2519.4590,-2090.2463,13.5469 , 0 , random(255), random(255), 1000, 0);
                    PutPlayerInVehicle(playerid, TruckerCar[playerid] ,0);
                    SetPVarInt(playerid, "IsDaThue", 1);
                    LamViec[playerid] =2;
                    return 1;
                }
                case 1: {
                    cmd_adsbabalaythunghang(playerid,"");               
                    return 1;
                }
                case 2: {
                    cmd_adsbabahuygiaohang(playerid,"");
                    return 1;
                }
                case 3: {
                    if(LamViec[playerid] != 0 && LamViec[playerid] != 2) return  SendClientMessage(playerid, COLOR_GREY, "Ban dang lam cong viec khac khong the lam Trucker!");  
                    if(LamViec[playerid] != 2) return SendErrorMessage(playerid," Ban chua lam viec khong the dung lam viec.");
                    LamViec[playerid] =0;
                    DeletePVar(playerid, "IsDaThue");
                    DestroyVehicle(TruckerCar[playerid]);
                    return 1;
                }
            }
        }
    }
    if(dialogid == TRUCKBACKCAR)
    {
        if(response)
        {
            DestroyVehicle( TruckVehicleID[playerid] );
            TruckVehicleID[playerid] =0;              
            DeletePVar(playerid, "ThueTruck");
            SendClientTextDraw(playerid, "Ban da tra xe ~y~truck~w~ thanh cong!!");
        }
    }
    if(dialogid == DIALOG_TRUCKER1)
    {
        if(response)
        {
            if(listitem == 0)
            {
                SetPVarInt(playerid, "SelectType", 1); // vat lieu
                GiaoHang(playerid);
                return 1;
            }
            if(listitem == 1)
            {
                    SetPVarInt(playerid, "SelectType", 2); // thuc pham
                    GiaoHang(playerid);
                    return 1;
            }
            if(listitem == 2)
            {
                SetPVarInt(playerid, "SelectType", 3); // suc vat
                GiaoHang(playerid);  
                return 1;
            }
            if(listitem == 3)
            {
                ShowPlayerDialog(playerid, DIALOG_TRUCKER, DIALOG_STYLE_LIST, "Trucker ", "Hang hop phap\nHang bat hop phap", "Chon", "Huy");
            }
        }
    }
    if(dialogid == DIALOG_TRUCKER2)
    {
        if(response)
        {
            if(listitem == 0)
            {
                SetPVarInt(playerid, "SelectType", 4); //  vu khi
                GiaoHang(playerid);
                return 1;
            }
            if(listitem == 1)
            {
                SetPVarInt(playerid, "SelectType", 5); // ma tuy
                GiaoHang(playerid);
                return 1;
            }
            if(listitem == 2)
            {
                ShowPlayerDialog(playerid, DIALOG_TRUCKER, DIALOG_STYLE_LIST, "Trucker ", "Hang hop phap\nHang bat hop phap", "Chon", "Huy");
            }
        }
    }
    if(dialogid == DIALOG_TRUCKER)
    {
        if(response)
        {
            if(listitem == 0)
            {
                ShowPlayerDialog(playerid, DIALOG_TRUCKER1, DIALOG_STYLE_LIST, "Tuy chon", "Vat lieu\nThuc An\nSuc vat", "Tuy chon", "Huy");
            }
            if(listitem == 1)
            {
                ShowPlayerDialog(playerid, DIALOG_TRUCKER2, DIALOG_STYLE_LIST, "Tuy chon", "Vu khi\nMa tuy", "Tuy chon", "Huy");
            }
        }
    }
    return 0;
}


forward AttachTrailer(playerid);
public AttachTrailer(playerid)
{
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid,pX,pY,pZ);
    new Float:vX, Float:vY, Float:vZ;
    GetVehiclePos(Trailer[playerid],vX,vY,vZ);
    if((floatabs(pX-vX)<100.0)&&(floatabs(pY-vY)<100.0)&&(floatabs(pZ-vZ)<100.0)&&(Trailer[playerid]!=GetPlayerVehicleID(playerid)))  AttachTrailerToVehicle(Trailer[playerid],GetPlayerVehicleID(playerid));
    TogglePlayerControllable(playerid, true);
    return 1;
} 
hook OnPlayerEnterCheckpoint(playerid) {

// entercp
    if(GetPVarInt(playerid, "LayTraing") == 1)
	{
		if(GetPVarInt(playerid, "IsDaThue") == 0) return SendClientMessage(playerid, COLOR_GREY, "Xe nay khong hop le");
		if(GetPlayerVehicleID(playerid) != TruckerCar[playerid]) return SendClientMessage(playerid, COLOR_GREY, "Xe nay khong hop le");
		if(LamViec[playerid] != 2) return 1;
		new vehicleid = GetPlayerVehicleID(playerid);
		new Float: X, Float: Y, Float: Z;
		GetVehiclePos(vehicleid, X, Y, Z);
		//TogglePlayerControllable(playerid, false);
		Trailer[playerid] = CreateVehicle(435, X-1, Y, Z, 0, random(255), random(255), 60 * 10);
	//	AttachTrailerToVehicle(Trailer[playerid], TruckerCar[playerid]);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("AttachTrailer", 1000, 0, "d", playerid);
	//	MuiTenPos[playerid][0] = PosTwo[RandomPosTruck[playerid]][0];
	//	MuiTenPos[playerid][1] = PosTwo[RandomPosTruck[playerid]][1];
	//	MuiTenPos[playerid][2] = PosTwo[RandomPosTruck[playerid]][2];
		//ShowNavigate(playerid);
		SetPlayerCheckpoint(playerid, PosTwo[RandomPosTruck[playerid]][0], PosTwo[RandomPosTruck[playerid]][1], PosTwo[RandomPosTruck[playerid]][2], 10);
		SetPVarInt(playerid, "LayTraing", 2);
		SendClientTextDraw(playerid, "Hay di toi checkpoint de giao thung hang ~y~Container");
		return 1;
	}
	if(GetPVarInt(playerid, "LayTraing") == 2)
	{
		if(LamViec[playerid] != 2) return 1;
		if(IsPlayerInAnyVehicle(playerid))
	    {
	    	new vehicleid = GetPlayerVehicleID(playerid);
	   	 	new trailer = GetVehicleTrailer(vehicleid);
	    	if(IsTrailerAttachedToVehicle(vehicleid) && trailer == Trailer[playerid])
			{
	    	    if(GetPlayerVehicleID(playerid) != TruckerCar[playerid]) return SendClientTextDraw(playerid , "Ban khong o tren xe trucker cua ban da lay");
	            DestroyVehicle(Trailer[playerid] );
	            SetPVarInt(playerid, "LayTraing", 3);
	            SetPlayerCheckpoint(playerid, 2536.2314,-2084.8591,13.5469, 10);
	            SendClientTextDraw(playerid, "Ban da giao thanh cong hay quay ve tra xe va ~y~nhan tien");
	         //   MuiTenPos[playerid][0] = 2536.2314;
		    //    MuiTenPos[playerid][1] = -2084.8591;
		    //    MuiTenPos[playerid][2] = 13.5469;
		      //  ShowNavigate(playerid);
	            return 1;
	        }
	        else
	        {
	        	SendClientMessage(playerid, -1, "Thung hang khong hop le ...?");
	        }
	    }
	    return 1;
	}
	if(GetPVarInt(playerid, "LayTraing") == 3)
	{
		if(LamViec[playerid] != 2) return 1;
		if(GetPVarInt(playerid, "IsDaThue") == 0) return SendClientMessage(playerid, COLOR_GREY, "Xe nay khong hop le");
		if(GetPlayerVehicleID(playerid) != TruckerCar[playerid]) return SendClientMessage(playerid, COLOR_GREY, "Xe nay khong hop le");
		new Float:hp;
        GetVehicleHealth(TruckerCar[playerid] , hp);
        new moneyrand = 50000 + random(30000);
        new Float:tientru = 0;

        new Float:tong =  moneyrand - ( tientru / 10 );
  //      PlayerInfo[playerid][pTimeJob][1] = 30;
      //  PlayerInfo[playerid][pDaLamJob][1] = 1; 
        LamViec[playerid] = 0;
        if(hp <= 1000) {
        	new string[129];
        	PlayerInfo[playerid][pCash] += floatround(tong);
        	format(string, sizeof string, "Ban da nhan duoc {33CC33}$%d{FFFFFF} tu cong viec trucker.", floatround(tong));
            SendClientMessage(playerid, -1, string);
        }
		DisablePlayerCheckpoint(playerid);
		DestroyVehicle(TruckerCar[playerid]);
		DeletePVar(playerid, "LayTraing");
		DeletePVar(playerid, "IsDaThue");
		TatPizza(playerid);
		return 1;
	}
	if(GetPVarInt(playerid, "LayHang") == 1)
    {
    	if(LamViec[playerid] != 2) return 1;
    	DisablePlayerCheckpoint(playerid);
        ShowPlayerDialog(playerid, DIALOG_TRUCKER, DIALOG_STYLE_LIST, "Trucker ", "Hang hop phap\nHang bat hop phap", "Chon", "Huy");
        DeletePVar(playerid, "LayHang");
    }

    if(GetPVarInt(playerid, "GiaoHang") == 1)
    {
        SendClientTextDraw(playerid, "Dang ~y~giao hang");
        TogglePlayerControllable(playerid, 0);
        SetTimerEx("DeliverComplite", 2000, 0, "d", playerid);
        DisablePlayerCheckpoint(playerid);
    }
    if(GetPVarInt(playerid, "GiaoHang") == 2)
    {
        BackDeliver(playerid);
        DisablePlayerCheckpoint(playerid);
    }
    // dialog
    return 0; 
} 

CMD:truck(playerid,params[]) {
    if(CMND < 1) return SendErrorMessage(playerid,"Ban khong co CMND khong the xin viec.");
    ShowPlayerDialog(playerid, TRUCKER_MENU, DIALOG_STYLE_LIST, "Cong viec trucker", "Lam viec (Thue xe, Bat dau cong viec)\nLay thung hang ( giao hang )", "Tuy chon", "Thoat");
    return 1;
}
/*
CMD:truck(playerid, params[])
{
	//	if(IsPlayerInRangeOfPoint(playerid, 4,2507.7554,-2120.0732,13.5469))
    {
     //   if(GetPVarInt(playerid, "IsDaThue") == 1) return SendClientTextDraw(playerid , "Ban da thue phuong tien trucker roi hay su dung ~g~/laythunghang de tiep tuc");	    
	    if(LamViec[playerid] == 0) {
           
	    	SetPlayerPos(playerid, 2519.6191,-2089.2661,13.5469);
		    TruckerCar[playerid] = CreateVehicle(515, 2519.4590,-2090.2463,13.5469 , 0 , random(255), random(255), 1000, 0);
	        PutPlayerInVehicle(playerid, TruckerCar[playerid] ,0);
	        SetPVarInt(playerid, "IsDaThue", 1);
	        LamViec[playerid] =2;
	        return 1;
	    }
	    else if(LamViec[playerid] == 2) {
	        LamViec[playerid] =0;
	        DeletePVar(playerid, "IsDaThue");
	        DestroyVehicle(TruckerCar[playerid]);
	    }
	      
        return 1;

    }
    else {
    	SendClientMessage(playerid, COLOR_GREY, "Ban khong o gan cho trucker");
    }
    return 1;
}*/
/*
CMD:thuexe(playerid, params[])
{
   // if(GetPVarInt(playerid, "BiThuong") == 1) return SendClientTextDraw(playerid, "Ban khong the lam viec nay khi ~y~ bi thuong");
    if(IsPlayerInRangeOfPoint(playerid, 4, 2098.5281,-1800.8645,13.3889))
    {
        if(CheckThueXe[playerid] == 1) return  SendClientMessage(playerid, COLOR_GREY, "Ban da thue phuong tien pizza roi nen khong the thue nua.");
        if(LamViec[playerid] != 1) return SendClientMessage(playerid, COLOR_GREY, "Ban phai bat dau lam viec (/lamviec) thi moi co the thue phuong tien.");
     //   if(PlayerInfo[playerid][pJob] != JOB_PIZZA) return SendClientTextDraw(playerid, "Ban khong phai la ~y~Pizza boy");
        for(new i = 1; i < MAX_PIZZA_CARS ; i++)
        {
            if(IsDaThue[i] == 0)
            {
                ThueXePizza[playerid] = CreateVehicle(482,2092.4355,-1799.6438,13.3828,3,6,60 * 10,0); // Pizzaboy
                PutPlayerInVehicle(playerid, ThueXePizza[playerid], 0);
                PizzaBikesPizzas[ThueXePizza[playerid]]=10;
                SendClientTextDraw(playerid, "Ban da thue phuong tien ~g~thanh cong");
                CheckThueXe[playerid] = 1;
                IsDaThue[i] = 1;
                IDXeThue[playerid] = i;
                return 1;
            }
        }
    }
    else if(IsPlayerInRangeOfPoint(playerid, 4,2507.7554,-2120.0732,13.5469))
    {
        if(GetPVarInt(playerid, "IsDaThue") == 1) return SendClientTextDraw(playerid , "Ban da thue phuong tien trucker roi hay su dung ~g~/laythunghang de tiep tuc");
	    if(LamViec[playerid] == 2) {
	    	SetPlayerPos(playerid, 2519.6191,-2089.2661,13.5469);
		    TruckerCar[playerid] = CreateVehicle(515, 2519.4590,-2090.2463,13.5469, random(255), random(255), 60 * 10, 0);
	        PutPlayerInVehicle(playerid, TruckerCar[playerid] ,0);
	        SetPVarInt(playerid, "IsDaThue", 1);
	        return 1;
	    }
	    SendClientTextDraw(playerid, "Ban chua bat dau lam viec, hay su dung lenh /lamviec de bat dau.");
        return 1;

    }
    return 1;
}*/

CMD:adsbabahuygiaohang(playerid, params[])
{
	if(!GetPVarInt(playerid, "LayTraing")) return SendClientTextDraw(playerid, "Ban chua ~y~giao hang~w~khong the huy  ");
    if(GetPVarInt(playerid, "IsDaThue")) {
        SendClientTextDraw(playerid , "Ban da huy giao hang");
        DisablePlayerCheckpoint(playerid);
		DestroyVehicle(TruckerCar[playerid]);
		DeletePVar(playerid, "LayTraing");
		DeletePVar(playerid, "IsDaThue");
		TatPizza(playerid);
		return 1;
    }

    return 1;
}
CMD:adsbabalaythunghang(playerid , params[])
{
	if(GetPVarInt(playerid, "LayTraing")) return SendClientTextDraw(playerid, "Ban dang lay ~y~hang~w~roi khong the tiep tuc lay nua ");
    if(!GetPVarInt(playerid, "IsDaThue")) return SendClientTextDraw(playerid , "Ban chua thue phuong tien, hay ~y~/trucker~w~ de thue phuong tien.");
	if(LamViec[playerid] != 2) return SendClientTextDraw(playerid , "Ban chua bat dau lam viec, hay su dung lenh /lamviec de bat dau.");
	SetPVarInt(playerid, "LayTraing", 1);
	switch(random(2))
	{
		case 0:
		{
			RandomPosTruck[playerid] = random(11);
		}
		case 1:
		{
			RandomPosTruck[playerid] = random(11);
		}
		case 2:
		{
			RandomPosTruck[playerid] = random(9) + 2;
		}
		case 3:
		{
			RandomPosTruck[playerid] = random(10) + 1;
		}
		case 4:
		{
			RandomPosTruck[playerid] = 11;
		}
	}
	new str[180] , pin[80] , pint[80];
	SetPVarInt(playerid, "CheckTH", RandomPosTruck[playerid] );
	switch(RandomPosTruck[playerid] )
	{
		case 0:
		{
            pin = "Kakagawa's Electronic Store";
            pint = "Thiet bi dien tu";
		}
		case 1:
		{
            pin = "Carrie & Goodes Loading Bay";
            pint = "Linh kien xe hoi";
		}
		case 2:
		{
            pin = "Las Venturas Airport Authority";
            pint = "Do da dung";
		}
		case 3:
		{
            pin = "The Binco";
            pint = "Quan ao";
		}
		case 4:
		{
            pin = "Parc des Bandits Stadiumo"; //Triple T Loading Bay
            pint = "Dung cu the thao";
		}
		case 5:
		{
            pin = "Triple T Loading Bay"; //Triple T Loading Bay
            pint = "Dung cu xay dung";
		}
		case 6:
		{
            pin = "Hilltop Farm"; //Triple T Loading Bay
            pint = "Go noi that";
		}
		case 7:
		{
            pin = "Los Santos Loading Dock"; //Triple T Loading Bay
            pint = "Hang xuat khau";
		}
		case 8:
		{
            pin = "Los Santos Airport Authority"; //Flint County Garage
            pint = "Hang xuat khau";
		}
		case 9:
		{
            pin = "Flint County Garage"; //Flint County Garage
            pint = "Linh kien xe o to va moto";
		}
		case 10:
		{
            pin = "Foster Valley Loading Bay"; //Flint County Garage
            pint = "Nguyen lieu";
		}
		case 11:
		{
            pin = "San Fierro Loading Docks"; //Flint County Garage
            pint = "Thiet bi dien tu";
		}
	}
	format(str, sizeof str, "Ban giao hang toi tu %s\nKien Hang : %s\nKhoang cach : %0f\nThoi gian uoc tinh : 15 phut ", pin , pint, GetPlayerDistanceFromPoint(playerid, PosTwo[RandomPosTruck[playerid]][0], PosTwo[RandomPosTruck[playerid]][1], PosTwo[RandomPosTruck[playerid]][2]));
	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Thong tin hang hoa", str, "Xac nhan", "Huy bo");
//	MuiTenPos[playerid][0] = PosOne[RandomPosTruck[playerid]][0];
//	MuiTenPos[playerid][1] = PosOne[RandomPosTruck[playerid]][1];
//	MuiTenPos[playerid][2] = PosOne[RandomPosTruck[playerid]][2];
	//ShowNavigate(playerid);
	SetPlayerCheckpoint(playerid, PosOne[RandomPosTruck[playerid]][0], PosOne[RandomPosTruck[playerid]][1], PosOne[RandomPosTruck[playerid]][2], 10);
	return 1;
}
CMD:lamviec(playerid, params[])
{
    if(GetPVarInt(playerid, "DaChet") == 1) return SendClientTextDraw(playerid, "Ban khong the lam viec nay khi ~red~bi thuong");
    if(IsPlayerInRangeOfPoint(playerid, 3, 2425.1533,-2098.2800,13.5469))
    {
    	if(LamViec[playerid] != 0 && LamViec[playerid] != 2) return  SendClientMessage(playerid, COLOR_GREY, "Ban dang lam cong viec khac khong the lam Pizza!");
        if(LamViec[playerid] == 2)
        {
        	SendClientTextDraw(playerid, "~red~Ban da ngung lam cong viec Trucker!");
    	    LamViec[playerid] = 0;
    	    return 1;
        }
        else if(LamViec[playerid] == 0)
        {
        	SendClientTextDraw(playerid, "~green~Ban da lam cong viec ~y~Trucker!");
    	    LamViec[playerid] = 2;
        }
        return 1;
    }
    else
    { 
        SendClientMessage(playerid, COLOR_GREY, "Ban khong o gan noi nhan viec / nghi viec");
    }
    return 1;
}


forward DeliverComplite(playerid);
public DeliverComplite(playerid)
{
    new i = GetPVarInt(playerid, "DeliverType");
    TogglePlayerControllable(playerid, 1);
    SendClientTextDraw(playerid, "Ban da chon giao ~y~hang~w~ thanh cong ~y~ hay quay ve ben cang ( checkpoint )");  
    SetPlayerCheckpoint(playerid, 2534.1013,-2089.8118,13.5469, 4);
    SetPVarInt(playerid, "OnCheckPoint", 1);
    SetPVarInt(playerid, "BackDeliverType", i);
    DeletePVar(playerid, "DeliverType");
    SetPVarInt(playerid, "GiaoHang", 2);
    return 1;
}
forward BackDeliver(playerid);
public BackDeliver(playerid)
{
    switch(GetPVarInt(playerid, "BackDeliverType"))
    {
        case 1:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~vat lieu~w~ thanh cong va nhan duoc ~y~ 25$");   
            PlayerInfo[playerid][pCash] += 25;
        }
        case 2:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~thuc pham~w~ thanh cong va nhan duoc ~y~ 20$");   
            PlayerInfo[playerid][pCash] += 20;        
        }
        case 3:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~suc vat~w~ thanh cong va nhan duoc ~y~ 20$");   
            PlayerInfo[playerid][pCash] += 20;        
        }
        case 4:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~vu khi~w~ thanh cong va nhan duoc ~y~ 20$");   
            PlayerInfo[playerid][pCash] += 20;        
        }
        case 5:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~ma tuy~w~ thanh cong va nhan duoc ~y~ 20$");   
            PlayerInfo[playerid][pCash] += 20;        
        }
    }
    DeletePVar(playerid, "BackDeliverType");
    DeletePVar(playerid, "GiaoHang");
    ShowPlayerDialog(playerid, TRUCKBACKCAR, DIALOG_STYLE_MSGBOX, "Tra xe hay khong tra", "Ban co muon tra xe ( dung giao hang ) hay van tiep tuc giao hang", "Tra xe", "Tiep tuc");
    return 1;
}
forward GiaoHang(playerid);
public GiaoHang(playerid)
{
    SetPVarInt(playerid, "GiaoHang", 1);
    switch(GetPVarInt(playerid, "SelectType"))
    {
        case 1:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~vat lieu~w~ hay di den ~y~ noi giao hang ( checkpoint )");   
            SetPlayerCheckpoint(playerid, 901.5916,-1202.6233,16.9832, 5); // vat lieu
            SetPVarInt(playerid, "DeliverType", 1);
            DeletePVar(playerid, "SelectType");
            SetPVarInt(playerid, "OnCheckPoint", 1);
        }
        case 2:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~thuc pham~w~ hay di den ~y~ noi giao hang ( checkpoint )");   
            SetPlayerCheckpoint(playerid, 180.1835,-323.5073,1.5781, 5); // thu nuoi
            SetPVarInt(playerid, "DeliverType", 2);
            DeletePVar(playerid, "SelectType");
            SetPVarInt(playerid, "OnCheckPoint", 1);
        }
        case 3:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~suc vat~w~ hay di den ~y~ noi giao hang ( checkpoint )"); 
            SetPlayerCheckpoint(playerid, 1113.4196,-922.5567,43.3906, 5); // thuc pham
            SetPVarInt(playerid, "DeliverType", 3);
            DeletePVar(playerid, "SelectType");
            SetPVarInt(playerid, "OnCheckPoint", 1);
        }
        case 4:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~vu khi~w~ hay di den ~y~ noi giao hang ( checkpoint )"); 
            SetPlayerCheckpoint(playerid, 637.4970,-1776.6399,14.0677, 5); // vu khi
            SetPVarInt(playerid, "DeliverType", 4);
            DeletePVar(playerid, "SelectType");
            SetPVarInt(playerid, "OnCheckPoint", 1);
        }
        case 5:
        {
            SendClientTextDraw(playerid, "Ban da chon giao ~y~ma tuy~w~ hay di den ~y~ noi giao hang ( checkpoint )"); 
            SetPlayerCheckpoint(playerid, 2351.9026,-1170.6484,28.0739,5); // ma tuy
            SetPVarInt(playerid, "DeliverType", 5);
            DeletePVar(playerid, "SelectType");            
            SetPVarInt(playerid, "OnCheckPoint", 1);
        }
    }
}
stock HienThiTrucker(playerid)
{
	new pin[80] , pint[80];
	switch(GetPVarInt(playerid, "CheckTH"))
	{
		case 0:
		{
            pin = "Kakagawa's Electronic Store";
            pint = "Thiet bi dien tu";
		}
		case 1:
		{
            pin = "Carrie & Goodes Loading Bay";
            pint = "Linh kien xe hoi";
		}
		case 2:
		{
            pin = "Las Venturas Airport Authority";
            pint = "Do da dung";
		}
		case 3:
		{
            pin = "The Binco";
            pint = "Quan ao";
		}
		case 4:
		{
            pin = "Parc des Bandits Stadiumo"; //Triple T Loading Bay
            pint = "Dung cu the thao";
		}
		case 5:
		{
            pin = "Triple T Loading Bay"; //Triple T Loading Bay
            pint = "Dung cu xay dung";
		}
		case 6:
		{
            pin = "Hilltop Farm"; //Triple T Loading Bay
            pint = "Go noi that";
		}
		case 7:
		{
            pin = "Los Santos Loading Dock"; //Triple T Loading Bay
            pint = "Hang xuat khau";
		}
		case 8:
		{
            pin = "Los Santos Airport Authority"; //Flint County Garage
            pint = "Hang xuat khau";
		}
		case 9:
		{
            pin = "Flint County Garage"; //Flint County Garage
            pint = "Linh kien xe o to va moto";
		}
		case 10:
		{
            pin = "Foster Valley Loading Bay"; //Flint County Garage
            pint = "Nguyen lieu";
		}
		case 11:
		{
            pin = "San Fierro Loading Docks"; //Flint County Garage
            pint = "Thiet bi dien tu";
		}
	}
    new string[129] , string1[129];
    format(string, sizeof string, "Doan duong di: %s", pin);
    format(string1, sizeof string1, "Kien hang : %s", pint);
    PlayerTextDrawSetString(playerid, PizzaText[playerid][1], string);
    PlayerTextDrawSetString(playerid, PizzaText[playerid][2], string1);
    PlayerTextDrawShow(playerid, PizzaText[playerid][0]);
    PlayerTextDrawShow(playerid, PizzaText[playerid][2]);
    PlayerTextDrawShow(playerid, PizzaText[playerid][1]);
    return 1;
}
stock HienThiPizza(playerid)
{
    new string[129];
    format(string, sizeof string, "So banh con lai : %d/10", PizzaBikesPizzas[GetPlayerVehicleID(playerid)]);
  //  format(string1, sizeof string1, "", TimeConvert(TipTime[playerid]));
  //  string1 = "giao het 10 banh se phai lay them banh";
    PlayerTextDrawSetString(playerid, PizzaText[playerid][1], string);
    //PlayerTextDrawSetString(playerid, PizzaText[playerid][2], string1);
    PlayerTextDrawShow(playerid, PizzaText[playerid][0]);
    //PlayerTextDrawShow(playerid, PizzaText[playerid][2]);
    PlayerTextDrawShow(playerid, PizzaText[playerid][1]);
    return 1;
}
stock TatPizza(playerid)
{
    PlayerTextDrawHide(playerid, PizzaText[playerid][0]);
    PlayerTextDrawHide(playerid, PizzaText[playerid][2]);
    PlayerTextDrawHide(playerid, PizzaText[playerid][1]);
    return 1;
}
stock GiaoBanh(playerid)
{
	    if(GetPVarInt(playerid, "BatDauGiao") == 1) {
            if(IsPlayerAttachedObjectSlotUsed(playerid,PIZZA_INDEX))
            {
                RemovePlayerFromVehicle(playerid);
                SetPlayerArmedWeapon(playerid,0);
                ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,1,1,1,1,1);
            }
            new vehid = GetPlayerVehicleID(playerid);
            if(vehid == GetPVarInt(playerid, "Xenek"))
            {
                if(LamViec[playerid] == 1)
                {
                    if(PlayerCheckpoints[playerid] == CHECKPOINT_NONE)
                    {    
                //    ShowPlayerInfoTexts(playerid);
                        PlayerTextDrawHide(playerid,Textdraw0[playerid]);
                        PlayerTextDrawSetString(playerid,Textdraw0[playerid],"Ban dang lam viec hay di den~y~Checkpoint may do~y~!an Y de ~n~                   lay banh va vao ~y~Checkpoint~w~!");
                        PlayerTextDrawShow(playerid,Textdraw0[playerid]);
                        InfoTimer[playerid] = SetTimerEx("HidePlayerInfoTexts",5000,false,"d",playerid);
                        new rand = random(sizeof(Houses));
                        new skin = random(311)+1;
                        if(skin == 74) return skin=75;
                        SetPlayerCheckpoint(playerid,Houses[rand][0],Houses[rand][1],Houses[rand][2],2.0);                    
                        PlayerCheckpoints[playerid]=PIZZA_CHECKPOINT;
                        TipTime[playerid] = 30;
                        ShowTipTimeText(playerid);
                        if(PizzaBikesPizzas[GetPlayerVehicleID(playerid)] <= 0)  
                        {
                        	SendClientMessage(playerid, 0x0080FFFF, "[JOB]: Ban da giao xong hay quay ve Pizza de tra xe va nhan tien.");
                        	DisablePlayerCheckpoint(playerid); 
                        	return 1;
                        }
                    }    
                }
                else
                {
                    RemovePlayerFromVehicle(playerid);
                }
            }
            return 1;
	    } 
        return 1;
}
forward CloseGiaoBanh(playerid);
public CloseGiaoBanh(playerid)
{
	TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid);
	ApplyAnimation(playerid, "INT_HOUSE", "wash_up",4.1,0,0,0,0,0,1);
	return 1;
}

public MonitorTruckCarPlayer(playerid)
{
	--TimeExitsTruckCar[playerid];
	if(TimeExitsTruckCar[playerid] <= 0)
	{
		SendClientMessageEx(playerid, COLOR_YELLOW, "Xe Pizza cua ban da duoc thu hoi vi qua 10 phut khong su dung");
		DestroyVehicle(TruckerCar[playerid]);
		TruckerCar[playerid] = INVALID_VEHICLE_ID;
		KillTimer(TruckerCar[playerid]);
	}
	return 1;
}