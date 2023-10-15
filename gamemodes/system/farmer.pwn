#include           <YSI_Coding\y_hooks>
#define        POSTION_SEEDS     0.0.0 , 0.0. , 123.6
#define        MAX_SEEDS           100
#define        D_BUYSEEDS          (1920)
#define        ACTION_SEEDS        (1921)
#define        DIALOG_AMOUNTB      (1922)
#define        DIALOG_AMOUNTC      (1923)
#define        LUA_PRICE             100
#define        CACHUA_PRICE             100
#define        DUALEO_PRICE             100
#define        BAPCAI_PRICE             100
#define        PHANBON_PRICE            20
#define        THUNGNUOC_PRICE          10
#define        THUOCTRUSAU_PRICE        30
#define        MAX_CAYTRPLAYER          10 // toi da 10 cay trong
// define      LOAD_XITTHUOC            10
enum seeds {
    s_Object,
    s_Type,
    Text3D:s_Text,
    s_Id,
    s_harvest,
    s_time,
    s_timer,
    s_vw,
    s_want,
    s_owner,
    Float:s_pos[3],
}
new seeds_info[MAX_SEEDS][seeds];
new a_str[229];
new seeds_type_time[] = {
	3, 
	3,
	3,
    3
};
new seedtype_object[] = {
	806, //  lúa
	862, // ca chua
	861, // dua leo
	2001 // bắp cãi 
};

enum player_seed {
    ps_HatGiong[4], // 4 seeds
    ps_SanPham[4], 
    ps_OwnerID[MAX_CAYTRPLAYER], // toi da cay trong
    ps_Count,
	ps_Phan,
	ps_Nuoc,
	ps_ThuocTruSau,

}
new PlayerSeed[MAX_PLAYERS][player_seed];

CMD:muahatgiong(playerid,params[]) {
	if(IsPlayerInRangeOfPoint(playerid, 4, -382.9515,-1426.3911,26.3127)) {
	ShowPlayerDialog(playerid, D_BUYSEEDS, DIALOG_STYLE_TABLIST, "Mua hat giong", "{ffffff}Hat giong lua\t{2ea31c}$100{ffffff} \n\
		Hat giong ca chua\t{2ea31c}$100{ffffff} \n\
		Hat giong dua leo\t{2ea31c}$100{ffffff} \n\
		Hat giong bap cai\t{2ea31c}$200{ffffff} \n\
		Phan bon cho cay\t{2ea31c}$20{ffffff} \n\
		Can Nuoc\t{2ea31c}10${ffffff} \n\
		Thuoc tru sau\t{2ea31c}30${ffffff}", "Chon mua", "Thoat");
    }
    else {
		SendClientMessageEx(playerid,-1, "Ban khong o dung cu nong dan");
	}
	return 1;
}
CMD:farmer(playerid,params[]) {
	ShowPlayerDialog(playerid, ACTION_SEEDS, DIALOG_STYLE_LIST, "Mua hat giong", "Tuoi nuoc \n\
		Bon phan \n\
		Xit thuoc tru sau \n\
		Bat sau \n\
		Thu hoach \n\
		Xem nong san", "Thao tac", "Thoat");
    return 1;
}
CMD:trongcay(playerid,params[]) {
	if(IsPlayerInRangeOfPoint(playerid, 100, -261.2119,-1317.5320,9.9862)) {
	    if(isnull(params)) {
	    	SendClientMessageEx(playerid,-1, "/trongcay [lua chon]");
	    	SendClientMessageEx(playerid,-1, "Luc chon: Lua,cachua,dualeo,bapcai");
	    	return 1;
	    }
	    if(strcmp(params, "Lua", true) == 0) {
	    	Farmer_plant(playerid,0);
	    }
		if(strcmp(params, "cachua", true) == 0) {
	    	Farmer_plant(playerid,1);
	    }
	    if(strcmp(params, "dualeo", true) == 0) {
	    	Farmer_plant(playerid,2);
	    }
	    if(strcmp(params, "bapcai", true) == 0) {
	    	Farmer_plant(playerid,3);
	    }
	}
	else {
		SendClientMessageEx(playerid,-1, "Ban khong o khu nong trai");
	}
	return 1;
}
stock thuhoach(playerid,i) {
    if(seeds_info[i][s_harvest] != 1) return SendClientMessageEx(playerid,-1,"Cay trong chua den luc thu hoach.");
    new rd = 1 + random(5);
    PlayerSeed[playerid][ps_SanPham][seeds_info[i][s_Type]] += rd; 
    format(a_str, sizeof(a_str), "[{f9e312}NONG SAN{ffffff}] Ban da thu hoach duoc {12f916}%d{ffffff} {f9e312}%s", rd,getseed_name(seeds_info[i][s_Type]));
    SendClientMessageEx(playerid,-1,a_str);
    DestroyCayTrong(i);
    return 1;
}
stock DestroyCayTrong(i) {
	seeds_info[i][s_Id] = 0;
    seeds_info[i][s_harvest] = 0;
    seeds_info[i][s_vw] = 0;
    seeds_info[i][s_want] = 0;
    seeds_info[i][s_owner] = -1;
    seeds_info[i][s_Type] = -1;
	if(IsValidDynamicObject(seeds_info[i][s_Object]))
    	DestroyDynamicObject(seeds_info[i][s_Object]);
	if(IsValidDynamic3DTextLabel(seeds_info[i][s_Text]))
    	DestroyDynamic3DTextLabel(seeds_info[i][s_Text]);
    seeds_info[i][s_pos][0] = 0,seeds_info[i][s_pos][1] = 0,seeds_info[i][s_pos][2] = 0;
    return 1;
}
stock TuoiNuoc(playerid,i) {
	if(PlayerSeed[playerid][ps_Nuoc] < 1) return SendClientMessageEx(playerid,-1,"Ban khong co thung nuoc.");
    SetPlayerAttachedObject(playerid, 8, 18727, 6,-1.559,	-0.025,	0.155999,	0,	104.1,	0,	1,	1,	1,	1);
    SetPlayerAttachedObject(playerid, 9, 1650, 6, 0.078999,	0.030999,	-0.032,	1.3,	39.7,	-8.79995,	1,	1,	1);
    SetPVarInt(playerid, "LoadCay", i);  
    PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);  
    LoaderStarting(playerid, LOAD_TUOINUOC, "Dang tuoi nuoc...", 1,4);
    return 1;
}
stock BonPhan(playerid,i) {
	if(PlayerSeed[playerid][ps_Phan] < 1) return SendClientMessageEx(playerid,-1,"Ban khong co phan bon.");
    SetPVarInt(playerid, "LoadCay", i);  
    PlayAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0, 1);
    LoaderStarting(playerid, LOAD_BONPHAN, "Dang bon phan...", 1,4);
    return 1;
}
stock XitThuoc(playerid,i) {
	if(PlayerSeed[playerid][ps_ThuocTruSau] < 1) return SendClientMessageEx(playerid,-1,"Ban khong co Thuoc Tru Sau.");
    SetPVarInt(playerid, "LoadCay", i);    
    SetPlayerAttachedObject(playerid, 8, 366, 6,-0.094999,	0.001,	0.089998,	0,	29.2,	0,	1,	1,	1);
    SetPlayerAttachedObject(playerid, 9, 18727, 6,-1.559,	-0.025,	0.155999,	0,	104.1,	0,	1,	1,	1,	1);
    PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);  
    LoaderStarting(playerid, LOAD_XITTHUOC, "Dang xit thuoc...", 1,4);
    return 1;
}
stock BatSau(playerid,i) {
    PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    LoaderStarting(playerid, LOAD_BATSAU, "Dang bat sau...", 1,4);
    SetPVarInt(playerid, "LoadCay", i); 
    return 1;
}
stock Farmer_plant(playerid,type) {
	if(PlayerSeed[playerid][ps_HatGiong][type] < 1) return SendClientMessageEx(playerid,-1,"Ban khong co hat giong nay.");
	if(PlayerSeed[playerid][ps_Count] >= 10 ) return SendClientMessageEx(playerid,-1,"Ban da vuot qua gioi han cay trong.");
	new Float:_pos[3],_strseed[229];
	GetPlayerPos(playerid, _pos[0],_pos[1],_pos[2]);
	for(new i = 1 ; i < MAX_SEEDS; i++) {
		if(seeds_info[i][s_Id] == 0) {
			seeds_info[i][s_Id] = 1; // id is plane
			seeds_info[i][s_Type] = type;
			seeds_info[i][s_vw] = GetPlayerVirtualWorld(playerid);
			seeds_info[i][s_owner] = playerid;
			seeds_info[i][s_pos][0] = _pos[0],seeds_info[i][s_pos][1] = _pos[1],seeds_info[i][s_pos][2] = _pos[2];
			seeds_info[i][s_Object] = CreateDynamicObject(seedtype_object[type], _pos[0],_pos[1],_pos[2]-1, 0,0,0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		    PlayerSeed[playerid][ps_HatGiong][type] --;
		    seeds_info[i][s_timer] = SetTimerEx("PlaningSeed", 1000, true, "i", i);
		    seeds_info[i][s_time] = seeds_type_time[type] * 60; // 1 = 10s
		    format(_strseed, sizeof(_strseed), "Cay trong: {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})\nNguoi trong: {f9ef1e}%s{ffffff}\ntinh trang: {f9ef1e}%s{ffffff}(Bam Y de thao tac)\nThoi gian co the thu hoach: {f9ef1e}%d{ffffff}s con lai", getseed_name(type), 
		    	i,GetPlayerNameEx(seeds_info[i][s_owner]), getseed_want(type),seeds_info[i][s_time]);
		    seeds_info[i][s_Text] = CreateDynamic3DTextLabel(_strseed, -1, _pos[0],_pos[1],_pos[2]-1, 20);
		    PlayerSeed[playerid][ps_Count]++;
		    for(new j = 0;j<MAX_CAYTRPLAYER;j++) {
                if(PlayerSeed[playerid][ps_OwnerID][j] == 0) {
                	PlayerSeed[playerid][ps_OwnerID][j] = i;
                	break;
                }
		    }
		    break;
		}
	}
	return 1;
}


forward PlaningSeed(i);
public PlaningSeed(i)
{
    if(seeds_info[i][s_Id] > 0) 
    {
    	if(seeds_info[i][s_harvest] == 1) return 1;
        if(seeds_info[i][s_want] == 0) 
        {    
              	seeds_info[i][s_time]--;
           	//format(_str, sizeof(_str), "[CAY TRONG] Cay trong cua ban can phai %s, neu khong cay trong khong the phat trien",getseed_want(seeds_info[i][s_want]));
               //SendClientMessage(playerid, -1, _str);
//               SendClientTextDraw(playerid,"Cay trong ban dang gap van de");
                format(a_str, sizeof(a_str), "Cay trong: {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})\nNguoi trong: {f9ef1e}%s{ffffff}\ntinh trang: {f9ef1e}%s{ffffff}(Bam Y de thao tac)\nThoi gian co the thu hoach: {f9ef1e}%d{ffffff}s con lai", getseed_name(seeds_info[i][s_Type]), 
	       	    	i,GetPlayerNameEx(seeds_info[i][s_owner]), getseed_want(seeds_info[i][s_want]),seeds_info[i][s_time]);
                UpdateDynamic3DTextLabelText(seeds_info[i][s_Text], -1, a_str);
           
                format(a_str, sizeof(a_str), "Cay trong: {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})\nNguoi trong: {f9ef1e}%s{ffffff}\ntinh trang: {f9ef1e}%s{ffffff}(Bam Y de thao tac)\nThoi gian co the thu hoach: {f9ef1e}%d{ffffff}s con lai", getseed_name(seeds_info[i][s_Type]), 
	           	    	i,GetPlayerNameEx(seeds_info[i][s_owner]), getseed_want(seeds_info[i][s_want]),seeds_info[i][s_time]);
                UpdateDynamic3DTextLabelText(seeds_info[i][s_Text], -1, a_str);
	    //       if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 1) * 60) {
                if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 1) * 60) {
	            	switch(random(4)) {
               	        case 0: seeds_info[i][s_want] = 1;
               	        case 1: seeds_info[i][s_want] = 2;
               	        case 2: seeds_info[i][s_want] = 3;
               	        case 3: seeds_info[i][s_want] = 4;
                    }
	            } 

	     //      if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 2) * 60)  {
	            if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 2) * 60) {
	            	switch(random(4)) {
               	        case 0: seeds_info[i][s_want] = 1;
               	        case 1: seeds_info[i][s_want] = 2;
               	        case 2: seeds_info[i][s_want] = 3;
               	        case 3: seeds_info[i][s_want] = 4;
                    }
	           }   
	     /*      if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 4) * 60)  {
	            	switch(random(5)) {
               	        case 0: seeds_info[i][s_want] = 1;
               	        case 1: seeds_info[i][s_want] = 2;
               	        case 2: seeds_info[i][s_want] = 3;
               	        case 3: seeds_info[i][s_want] = 4;
                   }
	           }     
	           if(seeds_info[i][s_time] == (seeds_type_time[seeds_info[i][s_Type]] - 7) * 60)  {
	          	    switch(random(5)) {
               	        case 0: seeds_info[i][s_want] = 1;
               	        case 1: seeds_info[i][s_want] = 2;
               	        case 2: seeds_info[i][s_want] = 3;
               	        case 3: seeds_info[i][s_want] = 4;
                   }
	           }   */
			if(seeds_info[i][s_time] <= 0) {
				seeds_info[i][s_harvest] = 1;
				KillTimer(seeds_info[i][s_timer]);
				format(a_str, sizeof(a_str), "Cay trong: {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})\nNguoi trong: {f9ef1e}%s{ffffff}\ntinh trang: {f9ef1e}co the thu hoach{ffffff}(Bam Y de thao tac)\nThoi gian co the thu hoach: {f9ef1e}%d{ffffff}s con lai", getseed_name(seeds_info[i][s_Type]), 
					i,GetPlayerNameEx(seeds_info[i][s_owner]),seeds_info[i][s_time]);
				UpdateDynamic3DTextLabelText(seeds_info[i][s_Text], -1, a_str);
			}
        }
        else {
        	format(a_str, sizeof(a_str), "Cay trong: {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})\nNguoi trong: {f9ef1e}%s{ffffff}\ntinh trang: {f9ef1e}%s{ffffff}(Bam Y de thao tac)\nThoi gian co the thu hoach: {f9ef1e}%d{ffffff}s con lai", getseed_name(seeds_info[i][s_Type]), 
	       	    	i,GetPlayerNameEx(seeds_info[i][s_owner]), getseed_want(seeds_info[i][s_want]),seeds_info[i][s_time]);
            UpdateDynamic3DTextLabelText(seeds_info[i][s_Text], -1, a_str);
        }
    }
    return 1;
}
stock getseed_name(type) {
	new name[32];
    switch(type)
    {
    	case 0: name = "Lua";
    	case 1: name = "Ca chua";
    	case 2: name = "Dua leo";
    	case 3: name = "bap cai";
    }
    return name;
}
stock getseed_want(type) {
    new name[32];
    switch(type)
    {
    	case 0: name = "Phat trien tot";
    	case 1: name = "Tuoi nuoc";
    	case 2: name = "Bon phan";
    	case 3: name = "Xit thuoc tru sau";
    	case 4: name = "Bat sau";
    }
    return name;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case ACTION_SEEDS: {
			if(response) {
				switch(listitem) {
					case 0: TuoiNuoc(playerid,GetPVarInt(playerid, "SelectCay"));
					case 1: BonPhan(playerid,GetPVarInt(playerid, "SelectCay"));
					case 2: {
						XitThuoc(playerid,GetPVarInt(playerid, "SelectCay"));
					} 
					case 3: BatSau(playerid,GetPVarInt(playerid, "SelectCay"));
					case 4: thuhoach(playerid,GetPVarInt(playerid, "SelectCay"));
					case 5: {
					//	lua,ca chua, dua leo, bap cai
						new _str[120];
						format(_str, sizeof(_str), "Lua mach: %d\nCa chua: %d\nDua leo: %d\nBap cai: %d", PlayerSeed[playerid][ps_SanPham][0],
							PlayerSeed[playerid][ps_SanPham][1],PlayerSeed[playerid][ps_SanPham][2],PlayerSeed[playerid][ps_SanPham][3]);
						ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Thong tin nong san", _str, "Dong", "");
					}
				}
			}
		}
		case DIALOG_AMOUNTB: {
			if(response) {
				if(!IsNumeric(inputtext) || strval(inputtext) < 1 || strval(inputtext) > 1000000) return SendClientMessageEx(playerid, COLOR_GREY,"So luong phai tren 1 va duoi 1000");
				new type;
				switch(GetPVarInt(playerid,"MuaHatGiong")) {
					case 0: type = LUA_PRICE;
					case 1: type = CACHUA_PRICE;
					case 2: type = DUALEO_PRICE;
					case 3: type = BAPCAI_PRICE;
				}
				if(PlayerInfo[playerid][pCash] < type * strval(inputtext)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du tien de mua hat giong");
				PlayerInfo[playerid][pCash] -= type * strval(inputtext);
				PlayerSeed[playerid][ps_HatGiong][GetPVarInt(playerid,"MuaHatGiong")] += strval(inputtext); 
				new hastr[128];
			    format(hastr, sizeof(hastr), "Ban da mua thanh cong {eec239}%d{ffffff} hat giong {eec239}%s{ffffff} voi gia {21c134}$%s", strval(inputtext),
			    	getseed_name(GetPVarInt(playerid,"MuaHatGiong")),number_format(strval(inputtext) * type));
			    SendClientMessageEx(playerid,-1,hastr);
			}
			DeletePVar(playerid,"MuaHatGiong");
		}
		case DIALOG_AMOUNTC: {
			if(response) {
			    if(!IsNumeric(inputtext) || strval(inputtext) < 1 || strval(inputtext) > 1000000) return SendClientMessageEx(playerid, COLOR_GREY,"So luong phai tren 1 va duoi 1000");
		        new type,typename[32];
		        switch(GetPVarInt(playerid,"MuaDungCu")) {
			    	case 0: {
			    		typename = "Phan bon";
			    		type = PHANBON_PRICE;
			    	} 
			    	case 1: {
			    		typename = "Thung nuoc";
                        type = THUNGNUOC_PRICE;
			    	} 
			    	case 2: {
			    		type = THUOCTRUSAU_PRICE;		
			    		typename = "Thuoc tru sau";	
			    	}			
			    }		
			    if(PlayerInfo[playerid][pCash] < type * strval(inputtext)) return SendClientMessage(playerid, COLOR_GREY, "Ban khong du tien de mua dung cu");
			    PlayerInfo[playerid][pCash] -= type * strval(inputtext);
			    switch(GetPVarInt(playerid,"MuaDungCu")) {
			    	case 0:PlayerSeed[playerid][ps_Phan] += strval(inputtext); 
			    	case 1:PlayerSeed[playerid][ps_Nuoc]+= strval(inputtext); 
			    	case 2:PlayerSeed[playerid][ps_ThuocTruSau] += strval(inputtext); 				
			    }
			    
			    new hastr[128];
			    format(hastr, sizeof(hastr), "Ban da mua thanh cong {eec239}%d{ffffff} {eec239}%s{ffffff} voi gia {21c134}$%s", strval(inputtext),
			        typename,number_format(strval(inputtext) * type));
			    SendClientMessageEx(playerid,-1,hastr);
			}
			DeletePVar(playerid,"MuaDungCu");
		}
		case D_BUYSEEDS: {
			if(response) {
			    switch(listitem) {
			    	case 0: {
                       	ShowPlayerDialog(playerid, DIALOG_AMOUNTB, DIALOG_STYLE_INPUT, "Mua hat giong","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
			    	    SetPVarInt(playerid,"MuaHatGiong",0);
			    	}
			    	case 1: {
                 		ShowPlayerDialog(playerid, DIALOG_AMOUNTB, DIALOG_STYLE_INPUT, "Mua hat giong","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
			    	    SetPVarInt(playerid,"MuaHatGiong",1);
			    	}
			    	case 2: {
                        ShowPlayerDialog(playerid, DIALOG_AMOUNTB, DIALOG_STYLE_INPUT, "Mua hat giong","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
			    	    SetPVarInt(playerid,"MuaHatGiong",2);
			    	}
			    	case 3: {
                        ShowPlayerDialog(playerid, DIALOG_AMOUNTB, DIALOG_STYLE_INPUT, "Mua hat giong","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
			    	    SetPVarInt(playerid,"MuaHatGiong",3);
			    	}
			    	case 4: {
			    		ShowPlayerDialog(playerid, DIALOG_AMOUNTC, DIALOG_STYLE_INPUT, "Mua dung cu","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
                        SetPVarInt(playerid,"MuaDungCu",0);
			    	}
			    	case 5: {
			    		ShowPlayerDialog(playerid, DIALOG_AMOUNTC, DIALOG_STYLE_INPUT, "Mua dung cu","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
                        SetPVarInt(playerid,"MuaDungCu",1);
			    	}
			    	case 6: {
			    		ShowPlayerDialog(playerid, DIALOG_AMOUNTC, DIALOG_STYLE_INPUT, "Mua dung cu","Vui long nhap so luong ban muon mua", "Mua", "Thoat");
                        SetPVarInt(playerid,"MuaDungCu",2);
			    	}
			    }
			}
		}
	}
	return 1;
}
hook OnGameModeInit()
{
	CreateDynamic3DTextLabel("Noi ban dung cu nong san\n/muahatgiong", -1, -382.9515,-1426.3911,26.3127, 10);
	CreateDynamicPickup(1580, 1, -382.9515,-1426.3911,26.3127);
}

hook OnPlayerDisconnect(playerid, reason) {
	printf("MAX_CAYTRPLAYER");
	for(new i = 0 ; i < MAX_CAYTRPLAYER ; i++) {
        if(PlayerSeed[playerid][ps_OwnerID][i] > 0) {
        	DestroyCayTrong(PlayerSeed[playerid][ps_OwnerID][i]);
        }
        PlayerSeed[playerid][ps_OwnerID][i] = 0;
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if(newkeys & KEY_YES) {
    	for(new j = 0;j<MAX_CAYTRPLAYER;j++) {
            if(PlayerSeed[playerid][ps_OwnerID][j] != 0) {
        	    new i = PlayerSeed[playerid][ps_OwnerID][j];
        	    if(IsPlayerInRangeOfPoint(playerid, 1, seeds_info[i][s_pos][0] ,seeds_info[i][s_pos][1],seeds_info[i][s_pos][2])) {
                    SetPVarInt(playerid, "SelectCay", i);
                    new hastr[120];
                    format(hastr, sizeof(hastr), "Thao tac > {f9ef1e}%s{ffffff}({6dfd34}%d{ffffff})", getseed_name(seeds_info[i][s_Type]),i);
        	    	ShowPlayerDialog(playerid, ACTION_SEEDS, DIALOG_STYLE_LIST, hastr, "Tuoi nuoc \n\
			    	Bon phan \n\
			    	Xit thuoc tru sau \n\
			    	Bat sau \n\
			    	Thu hoach \n\
			    	Xem nong san", "Thao tac", "Thoat");
			    	break ; 
        	    }
        	}
        }
    }
    return 1;
}