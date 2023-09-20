
public OnPlayerSelectMenu(playerid,menuid,itemid,response) {
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	new string[129];
	switch(menuid) {
        case 1: {
        	if(!response) return HidePlayerMenu(playerid);
        	new str[50];
        	format(str, sizeof str, "[TEST] Tuy chon %d", itemid+1);
        	SendClientMessage(playerid, -1, str);
        }
 
	    case VUKHI_MENU: {
            if(response) {
        		switch(itemid) {
        			case 0: {
        				SendClientMessage(playerid,COLOR_GREY,"Mat hang da het, vui long quay lai sau.");
        			}
        			case 2: {
        				SendClientMessage(playerid,COLOR_GREY,"Mat hang da het, vui long quay lai sau.");
        			}
        			case 3: {
        				SendClientMessage(playerid,COLOR_GREY,"Mat hang da het, vui long quay lai sau.");
        			}
        		}
        		HidePlayerMenu(playerid);
        	}
        	else {
        		HidePlayerMenu(playerid);
        	}
		}
		case DIENTU_MENU: {
            if(response) {
        		switch(itemid) {
        			case 0: {
        				if(PlayerInfo[playerid][pCash] < 230) return SendErrorMessage(playerid," Ban khong du '$230' de mua vat pham 'GPS'");
        				PlayerInfo[playerid][pCash] -= 230;
        				new randphone = 99999 + random(900000);
						new query[128];
						SetPVarInt(playerid, "WantedPh", randphone);
						SetPVarInt(playerid, "CurrentPh", PlayerInfo[playerid][pPnumber]);
	       			    // SetPVarInt(playerid, "PhChangeCost", 500);
						format(query, sizeof(query), "SELECT `Username` FROM `accounts` WHERE `PhoneNr` = '%d'",randphone);
						mysql_function_query(MainPipeline, query, true, "OnPhoneNumberCheck", "ii", playerid, 2);
        			}
        			case 1: {
        				if(PlayerInfo[playerid][pCash] < 80) return SendErrorMessage(playerid," Ban khong du '$80' de mua vat pham 'Danh ba'");
        				PlayerInfo[playerid][pCash] -= 80;
        				PlayerInfo[playerid][pPhoneBook] = 1;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua danh ba dien thoai, bay gio ban co the tim so dien thoai cua moi nguoi.");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Su dung /sdt <id/name>.");
        			}
        			case 2: {
        				if(PlayerInfo[playerid][pCash] < 170) return SendErrorMessage(playerid," Ban khong du '$170' de mua vat pham 'Radio lien lac'");
        				PlayerInfo[playerid][pCash] -= 170;
        				PlayerInfo[playerid][pRadio] = 1;
						PlayerInfo[playerid][pRadioFreq] = 0;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua radio lien lac.");
						SendClientMessageEx(playerid, COLOR_WHITE, "HUONG DAN: Su dung /pr de lien lac voi nhung nguoi trong cung tan so.");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Su dung /tanso de thay doi tan so radio.");
        			}
        			case 3: {
        				if(PlayerInfo[playerid][pCash] < 121) return SendErrorMessage(playerid," Ban khong du '$121' de mua vat pham 'May nghe nhac'");
        				PlayerInfo[playerid][pCash] -= 121;
        				PlayerInfo[playerid][pCDPlayer] = 1;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua may nghe nhac");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Su dung /music de nghe nhac");
        			}
        			case 4: {
        				if(PlayerInfo[playerid][pCash] < 200) return SendErrorMessage(playerid," Ban khong du '$200' de mua vat pham 'CAMERA'");
        				PlayerInfo[playerid][pCash] -= 200;
        				GivePlayerValidWeapon(playerid, WEAPON_CAMERA, 99999);
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua May anh.");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Nho nhin va ngap chup nhung buc anh that tuyet nhe.");
        			}
        			case 5: {
        				if(PlayerInfo[playerid][pCash] < 80) return SendErrorMessage(playerid," Ban khong du '$80' de mua vat pham 'GPS'");
        				PlayerInfo[playerid][pCash] -= 80;
        				if(!Inventory_HasItem(playerid, "GPS")) {
							Inventory_Add(playerid, "GPS");
						}
						else return SendClientMessageEx(playerid, COLOR_WHITE, "Ban da so huu GPS");
        			}
        		}
        		HidePlayerMenu(playerid);
        	}
        	else {
        		HidePlayerMenu(playerid);
        	}
		}
        case QUANAN_MENU: {
        	if(response) {
        		switch(itemid) {
        			case 0: {
        				if(PlayerInfo[playerid][pCash] < 30) return SendErrorMessage(playerid," Ban khong du '$30' de mua vat pham 'Banh Pizza'");
        				PlayerInfo[playerid][pCash] -= 20;
        				SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua thanh cong 1 chiec banh Pizza.");
        			}
        			case 1: {
        				if(PlayerInfo[playerid][pCash] < 20) return SendErrorMessage(playerid," Ban khong du '$20' de mua vat pham 'Banh mi'");
        				PlayerInfo[playerid][pCash] -= 20;
        				SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua thanh cong 1 chiec banh Banh mi.");
        			}
        			case 2: {
        				if(PlayerInfo[playerid][pCash] < 20) return SendErrorMessage(playerid," Ban khong du '$80' de mua vat pham 'Chai nuoc'");
        				PlayerInfo[playerid][pCash] -= 20;
        				SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua thanh cong 1 chai nuoc.");
        			}
        		}
        		HidePlayerMenu(playerid);
        	}
        	else {
        		HidePlayerMenu(playerid);
        	}
        }
        case CUAHANGTIENDUNG_MENU: {
        	if(response) {
        		switch(itemid) {
                    case 0: {
                    	if(PlayerInfo[playerid][pCash] < 20) return SendErrorMessage(playerid," Ban khong du $20");
						PlayerInfo[playerid][pDice] = 1;
						PlayerInfo[playerid][pCash] -= 20;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua con xuc xac");
                    }
                    case 1: {
                    	if(PlayerInfo[playerid][pCash] < 25) return SendErrorMessage(playerid," Ban khong du $25");
						if(PlayerInfo[playerid][pRope] < 8)
						{
							PlayerInfo[playerid][pRope] += 3;
							PlayerInfo[playerid][pCash] -= 25;
							SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua 3 day thung.");
							SendClientMessageEx(playerid, -1, "HUONG DAN: Su dung /troi(/coitroi) de troi nguoi khac tren chiec xe cua minh.");
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD4, "Ban khong the mua them!");
                    }
                    case 2: {
                    	if(PlayerInfo[playerid][pCash] < 70) return SendErrorMessage(playerid," Ban khong du $70");
						PlayerInfo[playerid][pCash] -= 70;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua 10 chiec xi ga.");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Su dung (/my inv > su dung xi ga) de hut xi ga, bam chuot trai de hut thuoc, bam F de vut dieu thuoc di.");
                    }
                    case 3: {
                    	if(PlayerInfo[playerid][pCash] < 170) return SendErrorMessage(playerid," Ban khong du $170");
						PlayerInfo[playerid][pCash] -= 170;
						PlayerInfo[playerid][pLock] = 1;
						SendClientMessageEx(playerid, COLOR_VANG, "Ban da mua mot Khoa xe.");
						SendClientMessageEx(playerid, -1, "HUONG DAN: Su dunh /lock de khoac chiec xe cua ban.");
                    }
                    case 4: {
                    	if(PlayerInfo[playerid][pCash] < 170) return SendErrorMessage(playerid," Ban khong du $170");				
						if(PlayerInfo[playerid][pSpraycan] < 20)
						{
							PlayerInfo[playerid][pSpraycan] += 10;
							PlayerInfo[playerid][pCash] -= 170;
							SendClientMessageEx(playerid, COLOR_GRAD4, "Ban da mua 10 binh son xe.");
							SendClientMessageEx(playerid, COLOR_WHITE, "HUONG DAN: Su dung /mauxe hoac /paintcar de thay doi mau xe cua ban.");
						}
						else return SendClientMessageEx(playerid, COLOR_GRAD4, "You can't hold any more of this item!");
                    }
                    case 5: {
                    	if(PlayerInfo[playerid][pCash] < 15) return SendErrorMessage(playerid," Ban khong du $15");				
						if(PlayerInfo[playerid][pChecks] == 0)
	    				{
		        			PlayerInfo[playerid][pChecks] += 10;
		        			PlayerInfo[playerid][pCash] -= 15;
			    			SendClientMessageEx(playerid, COLOR_GRAD4, "Ban da mua 10 tam ngan phieu de viet sec chuyen tien");
			    			SendClientMessageEx(playerid, COLOR_WHITE, "HUONG DAN: Su dung /guisec de chuyen tien cho nguoi khac khi can chuyen so tien lon.");
		   			    }
						else return SendClientMessageEx(playerid, COLOR_GREY, "Ban van con ngan phieu.Ban khong the mua them.");
                    }
                    case 6: {
                    	if(PlayerInfo[playerid][pCash] < 10) return SendErrorMessage(playerid," Ban khong du $10");				
						if(PlayerInfo[playerid][pPaper] == 0)
	       			    {
		       			    PlayerInfo[playerid][pPaper] = 15;
		       			    PlayerInfo[playerid][pCash] -= 10;
			   			    SendClientMessageEx(playerid, COLOR_GRAD4, "Ban da mua giay trang, bay gio ban co 15 to giay trang de gui thu.");
		    			}
						else return SendClientMessageEx(playerid, COLOR_GREY, "Ban van con giay trang.Ban khong the mua them.");
                    }
                    case 7: {
                    	if(PlayerInfo[playerid][pCash] < 270) return SendErrorMessage(playerid," Ban khong du $270");	
                    	PlayerInfo[playerid][pCash] -= 270;		
                    	if(GetPlayerVehicleCount(playerid) != 0)
			        	{
				        	SetPVarInt(playerid, "lockmenu", 1);
                        	for(new i=0; i<MAX_PLAYERVEHICLES; i++)
                        	{
				             	if(PlayerVehicleInfo[playerid][i][pvId] != INVALID_PLAYER_VEHICLE_ID)
				             	{
	                             	format(string, sizeof(string), "Xe %d| Ten: %s.",i+1,GetVehicleName(PlayerVehicleInfo[playerid][i][pvId]));
	                             	SendClientMessageEx(playerid, COLOR_WHITE, string);
				             	}
			            	}
			            	ShowPlayerDialog(playerid, DIALOG_CDLOCKMENU, DIALOG_STYLE_INPUT, "Khoa xe;"," Chon mon chiec xe ma ban muon cai dat khoa len:", "Lua chon", "Huy bo");

			        	}
			        	else return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co chiec xe nao - Ban muon cai dat no len dau?");
                    }
                    case 8: {
                    	if(PlayerInfo[playerid][pCash] < 370) return SendErrorMessage(playerid," Ban khong du $270");	
                    	PlayerInfo[playerid][pCash] -= 370;		
                    	if(GetPlayerVehicleCount(playerid) != 0)
			        	{
				        	SetPVarInt(playerid, "lockmenu", 2);
                        	for(new i=0; i<MAX_PLAYERVEHICLES; i++)
                        	{
				             	if(PlayerVehicleInfo[playerid][i][pvId] != INVALID_PLAYER_VEHICLE_ID)
				             	{
	                             	format(string, sizeof(string), "Xe %d| Ten: %s.",i+1,GetVehicleName(PlayerVehicleInfo[playerid][i][pvId]));
	                             	SendClientMessageEx(playerid, COLOR_WHITE, string);
				             	}
			            	}
			            	ShowPlayerDialog(playerid, DIALOG_CDLOCKMENU, DIALOG_STYLE_INPUT, "Khoa xe;"," Chon mon chiec xe ma ban muon cai dat khoa len:", "Lua chon", "Huy bo");

			        	}
			        	else return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co chiec xe nao - Ban muon cai dat no len dau?");
                    }
        		}
        		HidePlayerMenu(playerid);
        	}
        	else {
        		HidePlayerMenu(playerid);
        	}
        }
        case WOOD_MENU: {
        	if(!response) return HidePlayerMenu(playerid);
        	switch(itemid) {
        		case 0: {
        			if (IsPlayerInRangeOfPoint(playerid,5.0,-543.2013,-197.4136,78.4063)) {
        				if(PlayerInfo[playerid][pJob] == 30 || PlayerInfo[playerid][pJob2] == 30) return SendErrorMessage(playerid, " Ban da lam viec Lam Tac roi.");
            			if(PlayerInfo[playerid][pJob] == 0)
                        {
                			SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
                			SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                			PlayerInfo[playerid][pJob] = 30;
                			return 1;
            			}
            			if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0 && PlayerInfo[playerid][pJob] != 30)
            			{
            				SendClientMessageEx(playerid, COLOR_YELLOW, " Ban da nhan cong viec lam tac thanh cong, hay thay dong phuc va bat dau lam viec.");
            				SendClientTextDraw(playerid, "Ban da nhan viec ~y~Lam Tac~w~ hay thay dong phuc va bat dau lam viec");
                		    PlayerInfo[playerid][pJob2] = 30;
                			return 1;
            			}		
        		    }
        		}
        		case 1: {
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        			SetPlayerSkin(playerid, 16);
        			PlayerInfo[playerid][pModel] = 16;
        			SendClientTextDraw(playerid, "Ban da thay trang phuc hay bat dau lam viec");
        		}
        		case 2: {
        			if(GetPVarInt(playerid, "Chatcay_var") != 0) return SendErrorMessage(playerid, " Ban da bat dau lam viec roi."); 
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        	        if(PlayerInfo[playerid][pModel] != 16) SendErrorMessage(playerid," Ban chua mac do bao ho khong the bat dau.");	
        	        SendClientTextDraw(playerid," Ban da bat dau lam viec, hay chat cay va lay go vao kho");
        	        SetPVarInt(playerid, "Chatcay_var", 1);

           		}
           		case 3: {
           			if(GetPVarInt(playerid, "Chatcay_var") == 0) return SendErrorMessage(playerid, " Ban chua lam viec khong the dung lam viec."); 
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
        	        if(PlayerInfo[playerid][pModel] != 16) SendErrorMessage(playerid," Ban chua mac do bao ho khong the bat dau.");	
        	        SendClientTextDraw(playerid," Ban da bat dau lam viec, hay chat cay va lay go vao kho");
        	        DeletePVar(playerid, "Chatcay_var");
           		}
        		case 4: {
        			if(PlayerInfo[playerid][pJob] != 30 && PlayerInfo[playerid][pJob2] != 30) return SendErrorMessage(playerid, " Ban chua phai Lam Tac."); 
                    if(PlayerInfo[playerid][pJob] == 30) {
                    	PlayerInfo[playerid][pJob] = 0;
                    }
                    else if(PlayerInfo[playerid][pJob2] == 30) {
                    	PlayerInfo[playerid][pJob] = 0;
                    }
                    DeletePVar(playerid, "Chatcay_var");
                    SendClientTextDraw(playerid,"Ban da nghi viec thanh cong");
        		}
        	}
        	HidePlayerMenu(playerid);
        	counttick[playerid] = GetTickCount() + 5000;
        }
        case BANK_MENU: {
        	if(!response) return HidePlayerMenu(playerid);
        	switch(itemid) {
        		case 0: {
        			counttick[playerid] = GetTickCount() + 6000;
        			SetPVarInt(playerid, "OpenBank", 1);
                    ShowPlayerDialog(playerid, DIALOG_CHUYENTIEN, DIALOG_STYLE_INPUT, "Chuyen tien", "Vui long nhap so tai khoan de tiep tuc giao dich", "Tuy chon", "Thoat");  
        		}
        		case 1: {
        			counttick[playerid] = GetTickCount() + 6000;
        			SetPVarInt(playerid, "OpenBank", 1);
                    ShowPlayerDialog(playerid, DIALOG_GUITIEN, DIALOG_STYLE_INPUT, "Gui tien", "Vui long nhap so tien ban muon gui", "Gui tien", "Thoat");	 
        		}
        		case 2: {
        			counttick[playerid] = GetTickCount() + 6000;
        			SetPVarInt(playerid, "OpenBank", 1);
             //       ShowPlayerDialog(playerid, DIALOG_RUTTIEN, DIALOG_STYLE_INPUT, "Rut tien", "Vui long nhap so tien ban muon rut", "Rut tien", "Thoat");	 
        		}
        		case 3: {
        			counttick[playerid] = GetTickCount() + 6000;
        			SetPVarInt(playerid, "OpenBank", 1);
        		    new ti[42];
	    		    format(ti, sizeof ti, "Tai khoan ngan hang cua %s", GetPlayerNameEx(playerid));
	    		    format(string, sizeof string, "{ffffff}Ten chu the\t\t\t\t{8b3721}%s{ffffff}\nSo tai khoan\t\t\t\t{eae000}%d{ffffff}\nSo du trong vi\t\t\t\t{289c59}$%s{ffffff}", GetPlayerNameEx(playerid),PlayerInfo[playerid][pSoTaiKhoan],number_format(PlayerInfo[playerid][pAccount]));
	    		    ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_MSGBOX, ti, string, "Dong", "");
        		}
        	}
        	HidePlayerMenu(playerid);

        }
       
        case PIZZABOY_MENU: {
        	if(!response) return HidePlayerMenu(playerid);
        	switch(itemid) {
        		case 0: {
        			if(LamViec[playerid] == 0) {
        				SendClientMessageEx(playerid,COLOR_VANG,"Ban da bat dau lam viec 'Pizza Boy' hay di den pickup lay banh va chat len xe (Press 'Y' de lay banh/cat banh vao xe)");
	    				SendClientMessageEx(playerid,COLOR_VANG,"/pizza giaobanh de bat dau di giao");
	    				SetPlayerPos(playerid, 2113.1775,-1772.8745,12.9609);
		    			PizzaCar[playerid] = CreateVehicle(482, 2113.1775,-1772.8745,12.9609 , 0 , random(255), random(255), 1000, 0);
	        			PutPlayerInVehicle(playerid, PizzaCar[playerid] ,0);
	       				SetPVarInt(playerid, "IsDaThue", 1);
	       				LamViec[playerid] =1;
	        			BanhPizzaInCar[playerid] = 0;
	        			format(zzstr, sizeof zzstr, "Xe Pizza cua: %s\nBanh trong xe: %d/5", GetPlayerNameEx(playerid),BanhPizzaInCar[playerid]);
	        			PizzaTextInfo[playerid] = Create3DTextLabel(zzstr, COLOR_WHITE, 0.0, 0.0, 0.0, 50.0, 0, 1);
           				Attach3DTextLabelToVehicle(PizzaTextInfo[playerid], PizzaCar[playerid], 0.0, 0.0, 2.0); // Attaching Text Label To Vehicle.
           				HidePlayerMenu(playerid);
           				counttick[playerid] = GetTickCount() + 500;
	        			return 1;
	    			}
	    			else {
	    				SendErrorMessage(playerid, " Ban dang lam viec khong the bat dau lam viec tiep.");
	    			}
        		}
        		case 1: {
    		        if(LamViec[playerid] != 1 || LamViec[playerid] == 0 && LamViec[playerid] != 1) return SendErrorMessage(playerid, " Ban chua lam cong viec Pizza.");
	    			if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, " Ban khong the lam dieu nay khi o tren xe.");
					if(BanhPizzaInFoot[playerid] == 1) return SendErrorMessage(playerid, " Ban da cam banh tren tay khong the lay them.");
					if(IsPlayerInRangeOfPoint(playerid, 5, 2098.5432,-1800.6925,13.3889)) {
        				SetPlayerAttachedObject( playerid, PIZZA_INDEX, 1582, 1, 0.002953, 0.469660, -0.009797, 269.851104, 88.443557, 0.000000, 0.804894, 1.000000, 0.822361 );                      
        				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
        				BanhPizzaInFoot[playerid] = 1;
        				HidePlayerMenu(playerid);
        				counttick[playerid] = GetTickCount() + 500;
        				return 1;
					}
					else {
	   					SendErrorMessage(playerid, " Ban khong o noi lay banh khong the lay banh.");
					}
        		}
        		case 2: {
        			if(LamViec[playerid] == 1) {
	        			LamViec[playerid] =0;
	        			DeletePVar(playerid, "IsDaThue");
	        			DestroyVehicle(PizzaCar[playerid]);
	        			BanhPizzaInCar[playerid] = 0;
	        			DeletePVar(playerid, "giaobanh_Pizza");
             			DeletePVar(playerid, "postion_Pizza");
             			DisablePlayerCheckpoint(playerid);
             			Delete3DTextLabel(PizzaTextInfo[playerid]);
             			HidePlayerMenu(playerid);
             			counttick[playerid] = GetTickCount() + 500;
             			return 1;
	    			}
	    			else {
	   					SendErrorMessage(playerid, " Ban khong o noi lay banh khong the lay banh.");
					}
        		}
        	}
        }
	}
	return 1;

}