// task pizzajob

#include <YSI\y_hooks>

enum pzinfo
{
	Vehicle
}

new PizzaJob[MAX_PLAYERS][pzinfo];
new CPPizza[MAX_PLAYERS];
new Pizza_Quantity[MAX_VEHICLES];
new Pizza_Holding[MAX_PLAYERS];
new Pizza_Reward[MAX_PLAYERS];
new Text3D:PizzaTextInfo[MAX_PLAYERS];


GetRandomHouse(playerid) // check
{
	new index, houseIDs[MAX_HOUSES] = {-1, ...};

	for(new i = 0; i < MAX_HOUSES; i ++)
	{
	    if(HouseInfo[i][hOwned])
	    {
	        if(250 <= GetPlayerDistanceFromPoint(playerid, HouseInfo[houseid][hExteriorX], HouseInfo[houseid][hExteriorY], HouseInfo[houseid][hExteriorZ]) <= 1300.0)
	        {
	        	houseIDs[index++] = i;
			}
		}
	}

	if(index == 0)
	{
	    return -1;
	}

	return houseIDs[random(index)];
}


hook OnPlayerDisconnect(playerid, reason)
{
    if(PizzaJob[playerid][Vehicle])
	{
	    DestroyVehicle(PizzaJob[playerid][Vehicle]);
		Pizza_Quantity[PizzaJob[playerid][Vehicle]] = 0;
		Delete3DTextLabel(PizzaTextInfo[playerid]);
		PizzaJob[playerid][Vehicle] = INVALID_VEHICLE_ID;
	}
	Pizza_Holding[playerid] = 0;
	CPPizza[playerid] = 0;
}

Dialog:JOB_PIZZA(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
       //     if(IsPlayerInAnyVehicle(playerid)) return 1;
            
            case 0:
            {
                cmd_jhonsongrentpizza(playerid, "");
            }
            case 1:
            {
                if(PizzaJob[playerid][Vehicle])
            	{
            	    DestroyVehicle(PizzaJob[playerid][Vehicle]);
            		Pizza_Quantity[PizzaJob[playerid][Vehicle]] = 0;
            		Delete3DTextLabel(PizzaTextInfo[playerid]);
                    PizzaJob[playerid][Vehicle] = INVALID_VEHICLE_ID;
            	}
            	Pizza_Holding[playerid] = 0;
            	CPPizza[playerid] = 0;
            	new str[1280];
            	format(str,sizeof(str),"(JOB PIZZA) Ban da ngung lam viec, ban duoc thuong ~g~%d$~w~",Pizza_Reward[playerid]);
				SendClientTextDraw(playerid, str);
				PlayerInfo[playerid][pCash] += Pizza_Reward[playerid];
				Pizza_Reward[playerid] = 0;
            }
            case 2:
            {
                cmd_jhonsonglaybanh(playerid, "");
            }
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new Float:Pos[3];
 	GetVehiclePos(PizzaJob[playerid][Vehicle],Pos[0],Pos[1],Pos[2]);
 	if(newkeys & KEY_CTRL_BACK)
 	{
		if(Pizza_Holding[playerid] == 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0,Pos[0],Pos[1],Pos[2]))
			{
				if(!IsPlayerInAnyVehicle(playerid))
				{
				    new level = JobSkill[playerid][Pizza];
				    new str[230], strr[230];
					Pizza_Quantity[PizzaJob[playerid][Vehicle]] ++;
					ClearAnimations(playerid);
					Pizza_Holding[playerid] = 0;
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
					RemovePlayerAttachedObject(playerid,9);
					
					if(level < 200)
				    {
				        format(strr, sizeof strr, "(XE PIZZA - LEVEL 1)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/5{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
				        Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, strr);
				        format(str,sizeof(str),"Ban da bo banh vao cop xe so banh hien tai tren xe cua ban la: [~y~%d/5~w~] (Su dung N de lay banh ra).",Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
					    SendClientTextDraw(playerid, str);
				    }
				    else 
				    if(level >= 200)
				    {
				        format(strr, sizeof strr, "(XE PIZZA - LEVEL 2)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/10{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
				        Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, strr);
				        format(str,sizeof(str),"Ban da bo banh vao cop xe so banh hien tai tren xe cua ban la: [~y~%d/10~w~] (Su dung N de lay banh ra).",Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
					    SendClientTextDraw(playerid, str);
				    }
				}
			}
		}
	}
	if(newkeys & KEY_NO)
	{
		if(Pizza_Quantity[PizzaJob[playerid][Vehicle]] > 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0,Pos[0],Pos[1],Pos[2])) //return SendClientMessage(playerid,-1,"Ban can o gan phuong tien cua ban");
			{
				    if(Pizza_Quantity[PizzaJob[playerid][Vehicle]])
				    {
				          if(!Pizza_Holding[playerid])
				          {
				                if(IsPlayerInAnyVehicle(playerid)) return 1;
								Pizza_Holding[playerid] = 1;
						        SetPlayerAttachedObject(playerid, 9, 1582, 5, 0.219000, 0.000000, 0.145000, -82.599922, 0.000000, 102.000038, 1.000000, 1.000000, 1.000000, 0, 0);
								ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
								SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
								new string[1240], strr[1240];
								Pizza_Quantity[PizzaJob[playerid][Vehicle]] --;
								
								new level = JobSkill[playerid][Pizza];
								if(level < 200)
            				    {
            				        format(strr, sizeof strr, "(XE PIZZA - LEVEL 1)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/5{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
            				        Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, strr);
            				        format(string, sizeof(string), "Ban da lay banh tu trong xe ra (So luong con: [~y~%d/5]~w~)", Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
								    SendClientTextDraw(playerid, string);
            				    }
            				    else 
            				    if(level >= 200)
            				    {
            				        format(strr, sizeof strr, "(XE PIZZA - LEVEL 2)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/10{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
            				        Update3DTextLabelText(PizzaTextInfo[playerid], COLOR_WHITE, strr);
            				        format(string, sizeof(string), "Ban da lay banh tu trong xe ra (So luong con: [~y~%d/10]~w~)", Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
						      		SendClientTextDraw(playerid, string);
            				    }
							}
							else SendClientTextDraw(playerid, "~r~Ban dang cam banh roi.");
					}
					else SendClientTextDraw(playerid, "~r~Xe cua ban khong con banh nao de lay.");
			}
		}
	}
	return 1;
}
hook OnPlayerEnterCheckpoint(playerid)
{
	if(CPPizza[playerid] == 1)
	{
		if(Pizza_Holding[playerid] == 1)
		{
			Pizza_Holding[playerid] = 0;
			CPPizza[playerid] = 0;
			DisablePlayerCheckpoint(playerid);
			RemovePlayerAttachedObject(playerid,9);
			ClearAnimations(playerid);
			CheckDoneMisson(playerid, 0);
			JobSkill[playerid][Pizza] += 1;
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
			new str[1080];
		    new Float:doxa = GetPlayerDistanceFromPoint(playerid,2099.0378,-1801.4995,13.3889);
		    if(doxa <= 750)
			{
			    new randomm = 15 + random(10);
			    Pizza_Reward[playerid] += randomm;
			    format(str, sizeof str,"(JOB PIZZA) Ban da giao thanh cong va nhan duoc %d$ tien thuong (vi tri gan) - Tien thuong hien tai %d$", randomm, Pizza_Reward[playerid]);
			    SendClientMessage(playerid, COLOR_WHITE, str);
				if(Pizza_Quantity[PizzaJob[playerid][Vehicle]] == 0)
				{
					SendClientTextDraw(playerid, "~r~Hay ve cua hang lay them, xe cua ban da het banh.");
				}
				else
				{
					cmd_giaobanh(playerid,"");
				}
			}
			else
			{
			    new randomm = 20 + random(10);
			    Pizza_Reward[playerid] += randomm;
			    format(str, sizeof str,"(JOB PIZZA) Ban da giao thanh cong va nhan duoc %d$ tien thuong (vi tri xa) - Tien thuong hien tai %d$", randomm, Pizza_Reward[playerid]);
			    SendClientMessage(playerid, COLOR_WHITE, str);
			    if(Pizza_Quantity[PizzaJob[playerid][Vehicle]] == 0)
				{
					SendClientTextDraw(playerid, "~r~Hay ve cua hang lay them, xe cua ban da het banh.");
				}
				else
				{
					cmd_giaobanh(playerid,"");
				}
			}
			
			
		}
		else SendClientMessage(playerid,-1,"Ban chua co banh tren tay");
	}
	return 0;
}

CMD:pizza(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 5, 2099.0378,-1801.4995,13.3889)) return SendErrorMessage(playerid,"(JOB PIZZA) Ban khong o gan NPC pizza");
    Dialog_Show(playerid, JOB_PIZZA, DIALOG_STYLE_LIST, "Pizza Job", "Bat dau (lay xe)\nTra xe (Nhan tien thuong)\nLay banh", "Chon","Huy bo");
    return 1;
}

CMD:jhonsongrentpizza(playerid, params[])
{
    //if(!IsPlayerInRangeOfPoint(playerid, 5, 2109.3142, -1780.5560, 13.3864)) return SendErrorMessage(playerid,"(JOB PIZZA) Ban khong o noi thue xe.");
    if(PizzaJob[playerid][Vehicle]) return SendErrorMessage(playerid,"(JOB PIZZA) Ban da thue xe roi.");
    
    if(JobSkill[playerid][Pizza] < 200)
    {
        ActSetPlayerPos(playerid, 2112.9497, -1771.9745, 12.9538);
    	PizzaJob[playerid][Vehicle] = CreateVehicle(448, 2112.9497, -1771.9745, 12.9538, 0 , 3, 3, -1);
    	VehicleFuel[PizzaJob[playerid][Vehicle]] = GetVehicleFuelCapacity(PizzaJob[playerid][Vehicle]);
    	PlayerOnVehicle[playerid] = PizzaJob[playerid][Vehicle] ;
    	new fVW = GetPlayerVirtualWorld(playerid);
    	SetVehicleHealth(PizzaJob[playerid][Vehicle], 900.0);
    	Vehicle_ResetData(PizzaJob[playerid][Vehicle]);
    	ActPutPlayerInVehicle(playerid, PizzaJob[playerid][Vehicle] ,0);
    	SendServerMessage(playerid, "(JOB PIZZA) Ban da lay xe tu cua hang, hay chay can than nhe!");
    	new zzstr[150];
    	format(zzstr, sizeof zzstr, "(XE PIZZA - LEVEL 1)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/5{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
        PizzaTextInfo[playerid] = Create3DTextLabel(zzstr, COLOR_WHITE, 0.0, 0.0, 0.0, 50.0, 0, 1);
        Attach3DTextLabelToVehicle(PizzaTextInfo[playerid], PizzaJob[playerid][Vehicle], 0.0, 0.0, 2.0); // Attaching Text Label To Vehicle.
    }
    else if(JobSkill[playerid][Pizza] >= 200)
    {
        ActSetPlayerPos(playerid, 2112.9497, -1771.9745, 12.9538);
    	PizzaJob[playerid][Vehicle] = CreateVehicle(561, 2112.9497, -1771.9745, 12.9538, 0 , 3, 3, -1);
    	VehicleFuel[PizzaJob[playerid][Vehicle]] = GetVehicleFuelCapacity(PizzaJob[playerid][Vehicle]);
    	PlayerOnVehicle[playerid] = PizzaJob[playerid][Vehicle] ;
    	new fVW = GetPlayerVirtualWorld(playerid);
    	SetVehicleHealth(PizzaJob[playerid][Vehicle], 900.0);
    	Vehicle_ResetData(PizzaJob[playerid][Vehicle]);
    	ActPutPlayerInVehicle(playerid, PizzaJob[playerid][Vehicle] ,0);
    	SendServerMessage(playerid, "(JOB PIZZA) Ban da lay xe tu cua hang, hay chay can than nhe!");
    	new zzstr[150];
    	format(zzstr, sizeof zzstr, "(XE PIZZA - LEVEL 2)\nChu so huu: {FFCB00}%s{ffffff}\nBanh trong xe: {FFCB00}%d/10{ffffff}", GetPlayerNameEx(playerid),Pizza_Quantity[PizzaJob[playerid][Vehicle]]);
        PizzaTextInfo[playerid] = Create3DTextLabel(zzstr, COLOR_WHITE, 0.0, 0.0, 0.0, 50.0, 0, 1);
        Attach3DTextLabelToVehicle(PizzaTextInfo[playerid], PizzaJob[playerid][Vehicle], 0.0, 0.0, 2.0); // Attaching Text Label To Vehicle.
    }
	return 1;
}
CMD:jhonsonglaybanh(playerid, params[])
{
    new
            level = JobSkill[playerid][Pizza],
			carid = GetPlayerVehicleID(playerid);

	if(carid)
		return SendErrorMessage(playerid, "Vui long xuong xe.");

    if(!PizzaJob[playerid][Vehicle]) return SendErrorMessage(playerid,"(JOB PIZZA) Ban hay lay xe truoc.");
    if(Pizza_Holding[playerid] == 1) return SendErrorMessage(playerid,"(JOB PIZZA) Ban dang mot chiec banh khong the lay them duoc nua.");
	if(level < 200 && Pizza_Quantity[PizzaJob[playerid][Vehicle]] == 5 || level >= 200 && Pizza_Quantity[PizzaJob[playerid][Vehicle]] == 10) return SendErrorMessage(playerid,"(JOB PIZZA) Xe ban da FULL banh khong the lay them nua.");
	if(!IsPlayerInRangeOfPoint(playerid, 5, 2097.4573, -1804.7722, 13.5529)) return SendErrorMessage(playerid,"(JOB PIZZA) Ban khong o noi lay banh.");
	SetPlayerAttachedObject(playerid, 9, 1582, 5, 0.219000, 0.000000, 0.145000, -82.599922, 0.000000, 102.000038, 1.000000, 1.000000, 1.000000, 0, 0);
	ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_CARRY);
    Pizza_Holding[playerid] = 1;
    SendClientTextDraw(playerid, "Ban da lay banh tu cua hang - An phim [~y~H~W~] de bo vao phuong tien.");
    return 1;
}

CMD:giaobanh(playerid, params[])
{
    new houseid;
    
    if(CPPizza[playerid]) return 1;
    if(!Pizza_Quantity[PizzaJob[playerid][Vehicle]]) return SendErrorMessage(playerid,"(JOB PIZZA) Xe da het banh hay di lay them.");
    if((houseid = GetRandomHouse(playerid)) == -1)
	{
	    return SendErrorMessage(playerid, "Khong co ngoi nha nao yeu cau ban giao banh Pizza. Hay yeu cau Ban Quan Tri thiet lap.");
	}
	new str[120];
	format(str, sizeof str, "(JOB PIZZA) Hay giao pizza den nha cua ~y~%s~w~", HouseInfo[houseid][hOwnerName]);
    CPPizza[playerid] = 1;
    SendClientTextDraw(playerid, str);
    SetPlayerCheckPointEx(playerid, HouseInfo[houseid][hExteriorX], HouseInfo[houseid][hExteriorY], HouseInfo[houseid][hExteriorZ], 3);
    return 1;
}
