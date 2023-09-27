//Player TextDraws: 

#include <a_samp>
#include <YSI_Coding\y_hooks>

#define MAX_NOITHAT 120

enum NoiThat {
	nt_Object,
	nt_vW,
	nt_Interior,
	nt_HouseID,
	nt_ID,
	nt_TypeObject,
	Float:nt_Pos[3],
	Float:nt_Ros[3]
}
new NoiThatInfo[MAX_NOITHAT][NoiThat];
new PlayerText:Main_BNoiThat[MAX_PLAYERS][6];
new PlayerText:B_NoiThat[MAX_PLAYERS][22];
new NoithatObj[] = {	
	1704, // ghe sofa 120
 	1705, // ghe sofa 120 
	1708, // ghe sofa 120
	1711, // ghe sofa 120
	1723, // ghe sofa 120
	1724, // ghe sofa 120
	1726, // ghe sofa 120
	1727, // ghe sofa 120
	1728, // ghe sofa 120
	1729, // ghe sofa 120
	1735, // ghe sofa 120
	2739, // bon rua tay
	2120, // ghe go 100
	2124, // ghe go 100
	2096, // ghe go 100
	1516, // ban vuong 150 
    1433, // ban vuong 4 chan  150
	1827, // ban tron 150
	2764, // ban bar 150
	2180, // ban van phong 200
    2206, // ban van phong 200
    2173, // ban van phong 200
    2205, // ban van phong 200
    2172, // ban ke tu sach 300  
    2193, // ban ke tu sach 300 
    2174, // ban ke tu sach 300
    2175, // ban ke tu sach 300
    2182, // ban ke tu sach 300
    1701, // giuong  co niem 250
    1725, // giuong co niem 250
    1745, // giuong co niem 250
    1795, // giuong co niem 250
    1796,  // giuong co niem 250
    1800,  // giuong sat 180
    1801,  // giuong sat 180
    1802, // giuong sat 180
    1523,  // bon rua tay 100
    1514, // bon cau 80 
    2515, // bon cau 80 
    2738, // bon cau 80 
    1208, // may giat 90
    1718, // may lanh 90
    2322, // loa nghe nhac 120
    2331, // loa nghe nhac 120
    2226,// loa nghe nhac 120
    11705, // dien thoai ban 120
    19807, // dien thoai ban trang
    19825, // dong ho
    19830, // may xoay sinh to 100
    19830, // may xoay sinh to 100
    19819, // ly tam giac 50
    19818, // ly tron 50
    19820, // chai ruu 50
    19821, // chai ruu 50
    19822, // chai ruu 50
    19823, // chai ruu 50
    19824, // chai ruu 50
    19583, // dao thai 60
    19584, // noi 80
    19585, // noi to  80
    19586, // cai gi k biet ten 90
    19581, // chao chong dinh' 90
    19582, // thit heo 30
    2101, // may nghe nhac
    2103, // may nghe nhac
    2100 // may nghe nhac
    // toi day r
};
stock GetNoiThatPrice(objectid) {
	new price;
	switch(objectid) {
		case 1704: price = 100;
 		case 1705: price = 100; 
		case 1708: price = 100;
		case 1711: price = 100;
		case 1723: price = 100;
		case 1724: price = 100;
		case 1726: price = 100;
		case 1727: price = 100;
		case 1728: price = 100;
		case 1729: price = 100;
		case 1735: price = 100;
		case 2739: price = 100;
		case 2120: price = 100;
		case 2124: price = 100;
		case 2096: price = 100;
		case 1516: price = 150;
    	case 1433: price = 150;
		case 1827: price = 150;
		case 1644: price = 150;
		case 1637: price = 150;
		case 2764: price = 150;
		case 2180: price = 200;
    	case 2206: price = 200;
    	case 2173: price = 200;
    	case 2205: price = 200;
    	case 2172: price = 300;  
    	case 2193: price = 300; 
    	case 2174: price = 300;
        case 2175: price= 300;
        case 2182: price= 300;
        case 1701: price= 250;
        case 1725: price= 250;
        case 1745: price= 250;
        case 1795: price= 250;
        case 1796: price = 250;
        case 1800: price = 180;
        case 1801: price = 180;
        case 1802: price = 180;
        case 1523: price = 100;
        case 1525: price = 80;
        case 1528: price = 80;
        case 1514: price = 80;
        case 2515: price = 80;
        case 2738: price = 80;
        case 1208: price = 90;
        case 1718: price = 90;
        case 1719: price = 90;
        case 2322: price = 120;
        case 2331: price = 120;
        case 2332: price = 120;
        case 2226: price = 120;
        case 11705: price = 120;
        case 19807: price = 120;
        case 19825: price = 100;
        case 19830: price = 100; // may xoay sinh to 100 
        case 19819: price = 50; // ly tam giac 50
        case 19818: price = 50; // ly tron 50
        case 19820: price = 50; // chai ruu 50
        case 19821: price = 50; // chai ruu 50
        case 19822: price = 50; // chai ruu 50
        case 19823: price = 50; // chai ruu 50
        case 19824: price = 50; // chai ruu 50
        case 19583: price = 60; // dao thai 60
        case 19584: price = 80; // noi 80
        case 19585: price = 80; // noi to  80
        case 19586: price = 90; // cai gi k biet ten 90
        case 19581: price = 90; // chao chong dinh' 90
        case 19582: price = 30; // thit heo 30
        case 2101: price = 100;// may nghe nhac
        case 2103: price = 100;// may nghe nhac
        case 2100: price = 100;// may nghe nhac
	}
	return price;
}
stock GetNoiThatName(objectid) {
	new name[42];
	switch(objectid) {
		case 1704: name = "Ghe sofa"; //  120
 	    case 1705: name = "Ghe sofa "; 
	    case 1708: name = "Ghe sofa ";
	    case 1711: name = "Ghe sofa ";
	    case 1723: name = "Ghe sofa ";
	    case 1724: name = "Ghe sofa ";
	    case 1726: name = "Ghe sofa ";
	    case 1727: name = "Ghe sofa ";
	    case 1728: name = "Ghe sofa ";
	    case 1729: name = "Ghe sofa ";
	    case 1735: name = "Ghe sofa ";
	    case 2739: name = "Bon rua tay ";
	    case 2120: name = "Ghe go ";
	    case 2124: name = "Ghe go ";
	    case 2096: name = "Ghe go ";
	    case 1516: name = "Ban vuong";  
        case 1433: name = "Ban vuong"; 
	    case 1827: name = "Ban tron";
	    case 1644: name = "Ban vuong"; 
	    case 1637: name = "Ban vuong"; 
	    case 2764: name = "Ban bar ";
    	case 2180: name = "Ban van phong";
        case 2206:name = "Ban van phong";
        case 2173: name = "Ban van phong";
        case 2205:name = "Ban van phong";
        case 2172:name = "Ban ke tu sach" ; 
        case 2193:name = "Ban ke tu sach";
        case 2174:name = "Ban ke tu sach";
        case 2175:name = "Ban ke tu sach";
        case 2182:name = "Ban ke tu sach";
        case 1701:name = "giuong co niem";
        case 1725:name = "Giuong co niem";
        case 1745:name = "Giuong co niem";
        case 1795:name = "Giuong co niem";
        case 1796:name = "Giuong co niem";
        case 1800:name = "Giuong sat";
        case 1801:name = "Giuong sat";
        case 1802:name = "Giuong sat";
        case 1523:name = "Bon rua tay";
        case 1525:name = "Bon cau";
        case 1528:name = "Bon cau";
        case 1514:name = "Bon cau";
        case 2515:name = "Bon cau";
        case 2738:name = "Bon cau ";
        case 1208:name = "May giat"; 
        case 1718:name = "May lanh"; 
        case 1719:name = "May lanh ";
        case 2322:name = "Loa nghe nhac";  
        case 2331:name = "Loa nghe nhac";  
        case 2332:name = "Loa nghe nhac"; 
        case 2226:name ="Loa nghe nhac";
        case 11705:name ="Dien thoai ban";
        case 19807: name = "Dien thoai ban trang";
        case 19825: name = "Dong ho";
        case 19830: name = "May xoay sinh to"; 
        case 19819: name = "Ly tam giac"; 
        case 19818: name = "Ly tron ";
        case 19820: name = "Chai ruu"; 
        case 19821: name = "Chai ruu"; 
        case 19822: name = "Chai ruu"; 
        case 19823: name = "Chai ruu"; 
        case 19824: name = "Chai ruu"; 
        case 19583: name = "Dao thai"; 
        case 19584: name = "Noi"; 
        case 19585: name = "Noi to";  
        case 19586: name = "Thia";
        case 19581: name = "Chao chong dinh"; 
        case 19582: name = "Thit heo"; 
        case 2101: name = "May nghe nhac";
        case 2103: name = "May nghe nhac";
        case 2100: name = "May nghe nhac";
	}
	return name;
}
CMD:noithat(playerid,params[]) {
	if(Homes[playerid] > 0)
	{
		for(new i; i < MAX_HOUSES; i++)
		{
			if(GetPlayerSQLId(playerid) == HouseInfo[i][hOwnerID] && IsPlayerInRangeOfPoint(playerid, 50, HouseInfo[i][hInteriorX], HouseInfo[i][hInteriorY], HouseInfo[i][hInteriorZ]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][hIntVW] && GetPlayerInterior(playerid) == HouseInfo[i][hIntIW])
			{
				SelectTextDraw(playerid, COLOR_VANG);
			}
		}
	}
	return 1;
}
CMD:xemnoithat(playerid,params[]) {
	new string[329];
	for(new i = 1; i< 99;i++) 
	{
		if(IsPlayerInRangeOfPoint(playerid, 10, NoiThatInfo[i][nt_Pos][0],NoiThatInfo[i][nt_Pos][1],NoiThatInfo[i][nt_Pos][2])) 
		{
			printf("%d",NoiThatInfo[i][nt_TypeObject]);
		    format(string, sizeof(string), "%s%d\t%s\n", string,i,GetNoiThatName(NoiThatInfo[i][nt_TypeObject])); // 
		    ShowPlayerDialog(playerid, DIALOG_EDITNOITHAT, DIALOG_STYLE_TABLIST, "Danh sach noi that cua nha ban", string, "Chon","Thoat");
		} 
	}
	return 1;
}
CMD:editnt(playerid, params[])
{
	new noithat;
	if(sscanf(params, "d", noithat )) return SendUsageMessage(playerid, " /editnt [ID Noi that]");
	if(NoiThatInfo[noithat][nt_HouseID] != PlayerInfo[playerid][pPhousekey]) return SendErrorMessage(playerid, " Noi that nay khong phai trong nha cua ban");
	if(NoiThatInfo[noithat][nt_ID] == 0) return SendErrorMessage(playerid, " Noi that khong hop le");
	SetPVarInt(playerid,"EditNoiThat",1);
	SetPVarInt(playerid,"nt_ObjectSelect",noithat);
	EditDynamicObject(playerid, NoiThatInfo[noithat][nt_Object]);
	return 1;
}
CMD:xoanoithat(playerid, params[])
{
	new noithat;
	if(sscanf(params, "d", noithat )) return SendUsageMessage(playerid, " /editnt [ID Noi that]");
	if(NoiThatInfo[noithat][nt_HouseID] != PlayerInfo[playerid][pPhousekey]) return SendErrorMessage(playerid, " Noi that nay khong phai trong nha cua ban");
	if(NoiThatInfo[noithat][nt_ID] == 0) return SendErrorMessage(playerid, " Noi that khong hop le");
	XoaNoiThat(noithat);
	return 1;
}
/*
CMD:editnt(playerid,params[]) {
	if(GetPVarInt(playerid,"NewConfirmMuaNT") == 1) return SendClientMessage(playerid, -1, "Ban khong the edit khi dang mua noi that");
	for(new i = 0; i< MAX_NOITHAT;i++) {
		if(NoiThatInfo[i][nt_HouseID] == PlayerInfo[playerid][pPhousekey]) {
			if(IsPlayerInRangeOfPoint(playerid, 2, NoiThatInfo[i][nt_Pos][0],NoiThatInfo[i][nt_Pos][1],NoiThatInfo[i][nt_Pos][2])) {
				SetPVarInt(playerid,"EditNoiThat",1);
				EditDynamicObject(playerid, NoiThatInfo[i][nt_Object]);
				break;
			}
		}
	}
    return 1;
}
CMD:xoanoithat(playerid,params[]) {
	XoaNoiThat(strval(params));
	return 1;
}*/
stock XoaNoiThat(i) {
	DestroyDynamicObject(NoiThatInfo[i][nt_Object]);
	NoiThatInfo[i][nt_Pos][0] = 0;
    NoiThatInfo[i][nt_Pos][1] = 0;
    NoiThatInfo[i][nt_Pos][2] = 0;
    NoiThatInfo[i][nt_Ros][0] = 0;
    NoiThatInfo[i][nt_Ros][1] = 0;
    NoiThatInfo[i][nt_Ros][2] = 0;
    NoiThatInfo[i][nt_vW] = 0;
    NoiThatInfo[i][nt_Interior] = 0;
    NoiThatInfo[i][nt_TypeObject] = 0;
    NoiThatInfo[i][nt_ID] = 0;
	new query[129];
    mysql_format(MainPipeline, query, sizeof(query), "DELETE FROM noithat WHERE nt_ID = '%d' ",i);
    mysql_tquery(MainPipeline, query, "NoiThatUpdate", "d", i);
    return 1;
}
stock Showshopnoithat(playerid,page) {
	new ntvar,str[10],pg = sizeof(NoithatObj) / 21;
	ntvar = page - 1;
	SetPVarInt(playerid,"Page_",page);	
    format(str,sizeof str,"%d/%d",page,sizeof(NoithatObj) / 21);
    if(pg > 0)  format(str,sizeof str,"%d/%d",page,sizeof(NoithatObj) / 21 + 1);
    PlayerTextDrawSetString(playerid,Main_BNoiThat[playerid][5] ,str);
    if(page * 21 > sizeof(NoithatObj)) {
    	new number_page = page * 21 - sizeof(NoithatObj);
    	for(new i = 0; i < 21 ; i++) {
    		PlayerTextDrawHide(playerid, B_NoiThat[playerid][i]);
    	}
    	for(new i = 0; i < 21-number_page; i++) {
            PlayerTextDrawSetPreviewModel(playerid, B_NoiThat[playerid][i], NoithatObj[i + ( ntvar * 21)]);
		    PlayerTextDrawSetPreviewRot(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
		    PlayerTextDrawShow(playerid, B_NoiThat[playerid][i]);
    	}
    }
    else {
       	for(new i = 0; i < 21 ; i++) {
       	 	PlayerTextDrawSetPreviewModel(playerid, B_NoiThat[playerid][i], NoithatObj[i + ( ntvar * 21)]);
			PlayerTextDrawSetPreviewRot(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
			PlayerTextDrawShow(playerid, B_NoiThat[playerid][i]);
    	}
    }
   
    for(new i = 0 ; i < 6 ; i++) {
		PlayerTextDrawShow(playerid,Main_BNoiThat[playerid][i]);
	}
    SetPVarInt(playerid,"OpenNoiThat",1);	
    return 1;
}
stock HideNoiThatTD(playerid) {
	for(new i = 0; i < 21 ; i++) {
		PlayerTextDrawHide(playerid, B_NoiThat[playerid][i]);
    }
   
    for(new i = 0 ; i < 6 ; i++) {
		PlayerTextDrawHide(playerid,Main_BNoiThat[playerid][i]);
	}
	DeletePVar(playerid, "_Page");
	DeletePVar(playerid, "OpenNoiThat");
	CancelSelectTextDraw(playerid);
	return 1;
}
forward NoiThatCreate(playerid);
public NoiThatCreate(playerid)
{
	new rows = cache_num_rows();
    if(rows) {
    //    SendClientMessage(playerid, -1, "Noi that tao thanh cong");    
    } else {
     //   SendClientMessage(playerid, -1, "Co loi xay ra trong qua trinh tao du lieu noi that");
    }
    return 1;
}

stock SaveNoiThat(i) {
//	GetDynamicObjectPos(NoiThatInfo[i][nt_Object],NoiThatInfo[i][nt_Pos][0],NoiThatInfo[i][nt_Pos][1],NoiThatInfo[i][nt_Pos][2]);
//	GetDynamicObjectRot(NoiThatInfo[i][nt_Object],NoiThatInfo[i][nt_Ros][0],NoiThatInfo[i][nt_Ros][1],NoiThatInfo[i][nt_Ros][2]);
	new string[300];
 /*   mysql_format(MainPipeline, query, sizeof(query), "UPDATE noithat SET `nt_vW` = '%d', `nt_Interior` = '%d' ,`nt_HouseID` = '%d', \
    	`nt_TypeObject` = '%d',`nt_PosX` = '%f',`nt_PosY` = '%f', `nt_PosZ` = '%f',`nt_RosX` = '%f',`nt_RosY` = '%f' \
    	,`nt_RosZ` = '%f' WHERE `nt_ID` = '%d' ",
    	NoiThatInfo[i][nt_vW],NoiThatInfo[i][nt_Interior], 
    NoiThatInfo[i][nt_HouseID],NoiThatInfo[i][nt_TypeObject],NoiThatInfo[i][nt_Pos][0],NoiThatInfo[i][nt_Pos][1],
    NoiThatInfo[i][nt_Pos][2],NoiThatInfo[i][nt_Ros][0] ,NoiThatInfo[i][nt_Ros][1],NoiThatInfo[i][nt_Ros][2],
    NoiThatInfo[i][nt_ID]);
    mysql_tquery(MainPipeline, query, "NoiThatUpdate", "d", i);*/
    format(string, sizeof(string), "UPDATE noithat SET `nt_vW` = '%d', `nt_Interior` = '%d' ,`nt_HouseID` = '%d', \
    	`nt_TypeObject` = '%d',`nt_PosX` = '%f',`nt_PosY` = '%f', `nt_PosZ` = '%f',`nt_RosX` = '%f',`nt_RosY` = '%f' \
    	,`nt_RosZ` = '%f' WHERE `nt_ID` = '%d' ", NoiThatInfo[i][nt_vW],NoiThatInfo[i][nt_Interior], 
    NoiThatInfo[i][nt_HouseID],NoiThatInfo[i][nt_TypeObject],NoiThatInfo[i][nt_Pos][0],NoiThatInfo[i][nt_Pos][1],
    NoiThatInfo[i][nt_Pos][2],NoiThatInfo[i][nt_Ros][0] ,NoiThatInfo[i][nt_Ros][1],NoiThatInfo[i][nt_Ros][2],
    NoiThatInfo[i][nt_ID]);
	mysql_function_query(MainPipeline, string, false, "OnQueryFinish", "ii", SENDDATA_THREAD, i);

    printf("%s",string);
}
stock LoadNoiThat(i) {
	
	new query[128]; // SPos_x , SPos_y, SPos_z,
   	mysql_format(MainPipeline,query, sizeof query, "select * from noithat where nt_ID =%d ", i);
   	mysql_tquery(MainPipeline, query, "On_LoadNoiThat", "d", i);
} 
forward On_LoadNoiThat(index);
public On_LoadNoiThat(index) {
	new rows = cache_num_rows();
    if(rows)
    {
        for(new i=0; i<rows; i++)
        {      
            if(NoiThatInfo[index][nt_ID] == 0)
            {
            	NoiThatInfo[index][nt_Pos][0] = cache_get_field_content_float(i, "nt_PosX", MainPipeline);
            	NoiThatInfo[index][nt_Pos][1] = cache_get_field_content_float(i, "nt_PosY", MainPipeline);
            	NoiThatInfo[index][nt_Pos][2] = cache_get_field_content_float(i, "nt_PosZ", MainPipeline);
            	NoiThatInfo[index][nt_Ros][0] = cache_get_field_content_float(i, "nt_RosX", MainPipeline);
            	NoiThatInfo[index][nt_Ros][1] = cache_get_field_content_float(i, "nt_RosY", MainPipeline);
            	NoiThatInfo[index][nt_Ros][2] = cache_get_field_content_float(i, "nt_RosZ", MainPipeline);
                NoiThatInfo[index][nt_vW] = cache_get_field_content_int(i, "nt_vW", MainPipeline);
                NoiThatInfo[index][nt_HouseID] = cache_get_field_content_int(i, "nt_HouseID", MainPipeline);
                NoiThatInfo[index][nt_Interior] = cache_get_field_content_int(i, "nt_Interior", MainPipeline);
                NoiThatInfo[index][nt_TypeObject] = cache_get_field_content_int(i, "nt_TypeObject", MainPipeline);
                NoiThatInfo[index][nt_ID] = cache_get_field_content_int(i, "nt_ID", MainPipeline);
            }   
        }
    }
    NoiThatInfo[index][nt_Object] = CreateDynamicObject(NoiThatInfo[index][nt_TypeObject], NoiThatInfo[index][nt_Pos][0],NoiThatInfo[index][nt_Pos][1],NoiThatInfo[index][nt_Pos][2], NoiThatInfo[index][nt_Ros][0] ,NoiThatInfo[index][nt_Ros][1] ,NoiThatInfo[index][nt_Ros][2] , NoiThatInfo[index][nt_vW],NoiThatInfo[index][nt_Interior]);
  //  printf("[%d] House %d, ID: %d",index,NoiThatInfo[index][nt_ID],NoiThatInfo[index][nt_ID]);
    return 1;
}


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_EDITNOITHAT: {
			if(response) {
				SetPVarInt(playerid,"SelectNT",strval(inputtext));
				printf("%s %d",inputtext,strval(inputtext));
				ShowPlayerDialog(playerid,DIALOG_SELECTNT,DIALOG_STYLE_LIST,"Tuy chon","Edit noi that\nThong tin noi that\nXoa noi that","Tuy chon","Thoat");
			}
		}
		case DIALOG_SELECTNT: {
			if(response) {
                switch(listitem) {
                	case 0: {
                		new str[5];
                		valstr(str, GetPVarInt(playerid, "SelectNT"));		
                		cmd_editnt(playerid,str);
                	}
                	case 1: {
                		new i = GetPVarInt(playerid, "SelectNT");
                		new string[129];
                		format(string,sizeof(string),"Noi that %s\nID: %d\nObject ID: %d",GetNoiThatName(NoiThatInfo[i][nt_TypeObject]),i,NoiThatInfo[i][nt_TypeObject]);
                		ShowPlayerDialog(playerid,DIALOG_NOTHING,DIALOG_STYLE_MSGBOX,"Xem noi that",string,"Dong","");
                	}
                	case 2: {
                		new str[5];
                		valstr(str, GetPVarInt(playerid, "SelectNT"));
                		cmd_xoanoithat(playerid,str);
                	}
                }
			}
		}
		case DIALOG_NOITHAT: {
			if(response) {
                new Float:Pos[3];
                GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
                Pos[0] += 1;
                for(new i = 1 ; i < MAX_NOITHAT; i++) {
                	if(NoiThatInfo[i][nt_ID] == 0) {
                	    NoiThatInfo[i][nt_ID] = i;
                		NoiThatInfo[i][nt_TypeObject] = GetPVarInt(playerid, "MuaNoiThat");
                	    NoiThatInfo[i][nt_Pos][0] = Pos[0],NoiThatInfo[i][nt_Pos][1] = Pos[1],NoiThatInfo[i][nt_Pos][2] = Pos[2];
                	    NoiThatInfo[i][nt_Interior] = GetPlayerInterior(playerid);
                	    NoiThatInfo[i][nt_vW] = GetPlayerVirtualWorld(playerid);
                	    NoiThatInfo[i][nt_HouseID] = PlayerInfo[playerid][pPhousekey];
                        NoiThatInfo[i][nt_Object] = CreateDynamicObject(GetPVarInt(playerid, "MuaNoiThat"), Pos[0],Pos[1],Pos[2], 0,0,0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
                        SetPVarInt(playerid,"CreateNewNT",1);           
                        SetPVarInt(playerid,"nt_ObjectSelect",i);        	 	 
                        EditDynamicObject(playerid, NoiThatInfo[i][nt_Object]);            
                        break ;
                    }
                }
			}
		}
	}
	return 1;
}

stock CreateTDNoithat(playerid) {

	Main_BNoiThat[playerid][0] = CreatePlayerTextDraw(playerid, 222.064437, 144.499969, "box");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][0], 0.000000, 16.699850);
	PlayerTextDrawTextSize(playerid, Main_BNoiThat[playerid][0], 429.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][0], 1);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, Main_BNoiThat[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Main_BNoiThat[playerid][0], 690366207);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][0], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][0], 0);

	Main_BNoiThat[playerid][1] = CreatePlayerTextDraw(playerid, 221.927246, 147.916473, "box");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][1], 0.000000, 0.863837);
	PlayerTextDrawTextSize(playerid, Main_BNoiThat[playerid][1], 429.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][1], 1);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, Main_BNoiThat[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, Main_BNoiThat[playerid][1], 965992874);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][1], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][1], 0);

	Main_BNoiThat[playerid][2] = CreatePlayerTextDraw(playerid, 296.627868, 145.250106, "MUA_NOI_THAT");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][2], 0.254289, 1.320001);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][2], 1);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][2], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][2], 0);

	Main_BNoiThat[playerid][3] = CreatePlayerTextDraw(playerid, 414.458496, 279.766601, "LD_BEAT:right");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Main_BNoiThat[playerid][3], 13.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][3], 1);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][3], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid,Main_BNoiThat[playerid][3], true);

	Main_BNoiThat[playerid][4] = CreatePlayerTextDraw(playerid, 223.133316, 279.116760, "LD_BEAT:left");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Main_BNoiThat[playerid][4], 13.000000, 15.000000);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][4], 1);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][4], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid,Main_BNoiThat[playerid][4], true);

	Main_BNoiThat[playerid][5] = CreatePlayerTextDraw(playerid, 326.507934, 282.166809, "1/3");
	PlayerTextDrawLetterSize(playerid, Main_BNoiThat[playerid][5], 0.283338, 1.226666);
	PlayerTextDrawAlignment(playerid, Main_BNoiThat[playerid][5], 2);
	PlayerTextDrawColor(playerid, Main_BNoiThat[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Main_BNoiThat[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, Main_BNoiThat[playerid][5], 255);
	PlayerTextDrawFont(playerid, Main_BNoiThat[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, Main_BNoiThat[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Main_BNoiThat[playerid][5], 0);

	new Float:x,iz,Float:y;
	for(new i = 0; i < 7 ; i++) {
		x = 223.689575 + ( 29.6 *  i);
		y = 163.166702 + ( 39.6 * 0);
		printf("noi that %f,%d",x,i);
		B_NoiThat[playerid][i] = CreatePlayerTextDraw(playerid, x, y, "");
		PlayerTextDrawLetterSize(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, B_NoiThat[playerid][i], 26.000000, 31.000000);
		PlayerTextDrawAlignment(playerid, B_NoiThat[playerid][i], 1);
		PlayerTextDrawColor(playerid, B_NoiThat[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, B_NoiThat[playerid][i], 965992874);
		PlayerTextDrawFont(playerid, B_NoiThat[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
	//	PlayerTextDrawSetPreviewModel(playerid, B_NoiThat[playerid][i], 19563);
	//	PlayerTextDrawSetPreviewRot(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
	//	PlayerTextDrawSetSelectable(playerid,B_NoiThat[playerid][i], true);
	}
	for(new i = 7; i < 14 ; i++) {
		iz = i-7;
		x = 223.689575 + ( 29.6 *  iz);
		y = 163.166702 + (39.6 * 1);
		printf("noi that %f,%d",x,i);
		B_NoiThat[playerid][i] = CreatePlayerTextDraw(playerid, x, y, "");
		PlayerTextDrawLetterSize(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, B_NoiThat[playerid][i], 26.000000, 31.000000);
		PlayerTextDrawAlignment(playerid, B_NoiThat[playerid][i], 1);
		PlayerTextDrawColor(playerid, B_NoiThat[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, B_NoiThat[playerid][i], 965992874);
		PlayerTextDrawFont(playerid, B_NoiThat[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
	//	PlayerTextDrawSetPreviewModel(playerid, B_NoiThat[playerid][i], 19563);
	//	PlayerTextDrawSetPreviewRot(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
	//	PlayerTextDrawSetSelectable(playerid,B_NoiThat[playerid][i], true);
	}
	for(new i = 14; i < 21 ; i++) {
		iz = i-14;
		x = 223.689575 + ( 29.6 * iz );
		y = 163.166702 + ( 39.6 * 2);
		printf("noi that %f,%d",x,i);
		B_NoiThat[playerid][i] = CreatePlayerTextDraw(playerid, x, y, "");
		PlayerTextDrawLetterSize(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, B_NoiThat[playerid][i], 26.000000, 31.000000);
		PlayerTextDrawAlignment(playerid, B_NoiThat[playerid][i], 1);
		PlayerTextDrawColor(playerid, B_NoiThat[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, B_NoiThat[playerid][i], 965992874);
		PlayerTextDrawFont(playerid, B_NoiThat[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, B_NoiThat[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, B_NoiThat[playerid][i], 0);
	//	PlayerTextDrawSetPreviewModel(playerid, B_NoiThat[playerid][i], 19563);
	//	PlayerTextDrawSetPreviewRot(playerid, B_NoiThat[playerid][i], 0.000000, 0.000000, 0.000000, 1.000000);
	//	PlayerTextDrawSetSelectable(playerid,B_NoiThat[playerid][i], true);
	}
	return 1;
}

CMD:muanoithat(playerid,params[]) {
    Showshopnoithat(playerid,1);
    return 1;
}