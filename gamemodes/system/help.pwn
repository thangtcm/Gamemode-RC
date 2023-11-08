// task /help

#include <YSI\y_hooks>
#define HELP_MAIN (9999)
#define HELP_JOB (9998)



ShowHelpDialog(playerid)
{
	ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_LIST, "{007BD0}Tro giup - RCRP.VN{FFFFFF}", "Account\nGeneral\nChat\nJob", ">>", "<<");
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == HELP_MAIN) // Help
	{
		if(response)
		{
			if(listitem == 0) // Account
			{
				new hstr[1024];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Tai Khoan:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sCac lenh sau day deu lien quan den tai khoan cua ban:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/thongtin{B4B5B7} - Lenh nay giup ban kiem tra cap do, mau, giap, cong viec ban dang lam.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/lencap{B4B5B7} - Lenh nay dung de nang cap do cua ban, duoc vi nhu do nam sinh song cua ban tai thanh pho.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/doimatkhau{B4B5B7} - Lenh nay giup ban doi mat khau, phong truong hop neu tai khoan cua ban bi ro ri.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/newb{B4B5B7} - Lenh nay giup ban dat cau hoi cho ban co van.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/yeucautrogiup{B4B5B7} - Gui mot noi dung den doi ngu Co Van.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/baocao{B4B5B7} - De bao cao nhung thanh vien vi pham cho admin co tham quyen.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Help - Account", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 1) // General
			{
				new hstr[4000];
				format(hstr, sizeof(hstr), "{007BD0}General Help:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sDanh Sach Lenh Co Ban:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/pay{B4B5B7} - Chuyen tien cho nguoi khac.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/gps{B4B5B7} - De tim cac dia diem quan trong o thi tran.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/bank{B4B5B7} - De su dung dich vu BANK cua may chu.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/atm{B4B5B7} - De su dung dich vu ATM cua may chu.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/phone{B4B5B7} - De su dung dien thoai.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/inv{B4B5B7} - De mo tui do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/time{B4B5B7} - Hien thoi gian tai may chu, khi o trong tu no se hien thoi gian ra tu co  lai cua ban.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/hanhdong{B4B5B7} - Hien thi hanh dong (Giup ich cho viec ban Nhap vai).", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/eject{B4B5B7} - Duoi nguoi khac ra khoi xe neu ban la nguoi lai xe.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/clearmychat{B4B5B7} - Xoa cuoc tro chuyen cua rieng ban.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "General", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 2) // Chat
			{
				new hstr[1024];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Chat:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sLenh lien quan toi kenh chat va kenh tro chuyen:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/me{B4B5B7} - De thuc hien cac hanh dong ben ngoai nhan vat.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/ame{B4B5B7} - De thuc hien cac hanh dong ben ngoai nhan vat, khong the hien len chatlog.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/do{B4B5B7} - De thuc hien cac hanh dong ben trong nhan vat.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}(/w)hisper{B4B5B7} - Thi tham voi nguoi choi khac.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}(/o)oc{B4B5B7} - Dung de tham gia chat kenh OOC.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}(/s)hout{B4B5B7} - Dung de noi trong pham vi lon hon.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}(/l)ow{B4B5B7} - Dung de noi chuyen trong pham vi nho.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}/b{B4B5B7} - Dung de noi chuyen noi dung lien qan den OOC.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Chat", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 3) // Job
			{
				
				ShowPlayerDialog(playerid, HELP_JOB, DIALOG_STYLE_LIST, "Help - Job", "Pizza\nMiner\nTrucker\nFarmer", ">>", "<<");
				return 1;
			}
		}
		return 1;
	}
	if(dialogid == HELP_JOB) // Help
	{
		if(response)
		{
			if(listitem == 0) // Pizza
			{
				new hstr[1024];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Pizza:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sDay la cach lam cong viec Pizza:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 1:{B4B5B7} Su dung [/gps] -> Cong viec -> Pizza, roi di den diem mau do tren ban do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 2:{B4B5B7} Den gan NPC Pizza, an phim 'Y' chon 'Lam viec' de bat dau lam cong viec.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 3:{B4B5B7} Den gan NPC Pizza mot lan nua, an phim 'Y' chon 'Lay banh' roi den gan xe Pizza an phim 'N' de bo banh len xe (Toi da 5 banh/1xe).", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 4:{B4B5B7} Len xe Pizza su dung phim '2' de nhan cuoc goi banh pizza va chay den checkpoint mau do tren ban do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 5:{B4B5B7} Khi den gan checkpoint mau do, xuong xe an phim 'N' de lay banh roi chay vao diem mau do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 6:{B4B5B7} Khi ban giao het so luong pizza tren xe, co the ve NPC lay them va giao tiep hoac ban co the\nchon 'Dung viec' de nhan luong cong viec va ket thuc.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Help - Job", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 1) // Miner
			{
				new hstr[1024];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Miner:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sDay la cach lam cong viec Miner:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 1:{B4B5B7} Su dung [/gps] -> Cong viec -> Miner, roi di den diem mau do tren ban do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 2:{B4B5B7} Den gan NPC Miner, an phim 'Y' chon 'Thay dong phuc' de nhan dong phuc cong viec.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 3:{B4B5B7} An phim 'Y' chon 'Mua Piaxel' voi gia 500$.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 4:{B4B5B7} Sau khi mua Piaxel, hay di tim ROCK xung quanh, den gan an phim 'Y' de bat dau dao.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Help - Job", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 2) // trucker
			{
				new hstr[5000];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Trucker:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sDay la cach lam cong viec Truck:\n", hstr);
				format(hstr, sizeof(hstr), "%s{FF6100}Luu y:{B4B5B7} Ban phai so huu xe tai de co the lam cong viec nay.\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 1:{B4B5B7} Su dung [/gps] -> Cong viec -> Trucker, roi di den diem mau do tren ban do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 2:{B4B5B7} Den gan NPC, an '/xinviec' de nhan cong viec.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 3:{B4B5B7} Ngoi tren xe va dung lenh /truckergo car, khi den checkpoint, su dung /truckergo car mot lan nua de dang ky xe.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 4:{B4B5B7} Quay tro lai NPC va /truckergo mission.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 5:{B4B5B7} Khi nhan Mission, hay ghi nho nhung loai hang hoa ma ban phai tro, sau do /goiynhamay de tim diem lay hang.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 6:{B4B5B7} Khi den diem xuat khau hang hoa, /truckergo buy de mua loai hang ma ban can, sau do mo cop xe ((/xe copxe)) va an N de chat hang len xe.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 7:{B4B5B7} Khi ban da lay du loai hang hoa ma NPC yeu cau, /truckergo ship de tim diem giao hang.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 8:{B4B5B7} Khi da den diem giao hang, lai gan cop xe va an N de lay hang ra, sau do /truckergo sell.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Khi da hoan thanh nhiem vu, ban se duoc x2 loi nhuan.", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Help - Job", hstr, ">>", "<<");
				return 1;
			}
			if(listitem == 3) // farmer
			{
				new hstr[5000];
				format(hstr, sizeof(hstr), "{007BD0}Tro Giup Farmer:{B4B5B7}\n", hstr);
				format(hstr, sizeof(hstr), "%sDay la cach lam cong viec Farmer:\n", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 1:{B4B5B7} Su dung [/gps] -> Cong viec -> Farmer, roi di den diem mau do tren ban do.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 2:{B4B5B7} Tim mot nong trai xung quanh do de thue hoac mua.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 3:{B4B5B7} Sau khi thue nong trai (it nhat 5 ngay), /enter hoac alt de vao nong trai. Su dung /exitfarm de roi khoi nong trai.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 4:{B4B5B7} Su dung /farmer canh NPC de mua hat giong hoac mua ticker bo.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 5:{B4B5B7} Den khu vuc bai trong o trong nong trai, /inv va an su dung hat giong de trong cay.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 6:{B4B5B7} Den khu vuc bai nuoi truoc cua nong trai, /inv va an sung Ticket bo de nuoi bo\n((Them cai trai cay cua ong vao day)).", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 7:{B4B5B7} Khi cay da phat trien, /thuhoach de thu hoach cay.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 8:{B4B5B7} Khi Bo bi doi, su dung /feed de cho an ((Mat 1 lua)) và cho uong nuoc (Mat 5$).", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Buoc 9:{B4B5B7} Khi Bo tren 100KG hoac nang nhat 500KG, /feed de thu hoach lay thit.", hstr);
				format(hstr, sizeof(hstr), "%s\n{007BD0}Thit, lua va Duoc lieu co the ban cho NPC trong nong trai hoach doi ra Bot mi va ban cho Pizza Stacked..", hstr);
				ShowPlayerDialog(playerid, HELP_MAIN, DIALOG_STYLE_MSGBOX, "Help - Job", hstr, ">>", "<<");
				return 1;
			}
		}
		return 1;
	}
	return 1;
}

CMD:trogiupnew(playerid, params[])
{
    ShowHelpDialog(playerid);
    return 1;
}