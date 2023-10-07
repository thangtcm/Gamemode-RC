

stock LoadTextUpJob() {
	CreateDynamic3DTextLabel("<Quan ly khu mo> {2791FF}Miner{ffffff}\n(Den gan va bam phim 'Y' de bat dau lam viec)", -1, 588.1791,866.1268,-42.4973+1.15, 2.5);
	CreateDynamic3DTextLabel("<Thu mua khoang san> {2791FF}Miner{ffffff}\n(Den gan va bam phim 'Y' de ban khoang san)", -1, 2126.8018,-76.6521,2.4721+1.15, 2.5);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Farmer{ffffff}\n{2791FF}/farmer{ffffff} de bat dau lam viec", -1, -382.8567,-1430.5543,25.7266, 30);
	CreateDynamic3DTextLabel("<Quan ly Pizza Stack> {2791FF}Pizza{ffffff}\n(Den gan va bam phim 'H' de lam viec)", -1, 1362.9523,253.9632,19.5669+1.15, 5);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Chat go{ffffff}\n{2791FF}/chatgo{ffffff} de bat dau xin viec/lamviec", -1, -544.0293,-196.8639,78.4063, 30);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Trucker{ffffff}\n{2791FF}/truck{ffffff} de bat dau xin viec/lamviec", -1, 2507.7554,-2120.0732,13.546, 30);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}dang ky CMND{ffffff}\n{2791FF}/dangkycmnd{ffffff} de dang ky CMND", -1, 226.8533,2348.1772,1017.1298, 30);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Thi bang lai{ffffff}\n{2791FF}/thibanglai{ffffff} de thi bang lai xe", -1, 222.4692,2353.8494,1017.1298, 30);
	Create3DTextLabel("Cua hang do tien dung\nChuyen buon ban cac vat pham", COLOR_VANG, 1103.4659,-1433.9872,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang quan ao nam\nBan trang phuc danh cho nam", COLOR_VANG, 1102.7621,-1445.4734,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang quan ao nu\n/Ban trang phuc danh cho Nu", COLOR_VANG,1103.2670,-1452.7322,15.7969, 20, 0, 0);
	Create3DTextLabel("Quan an vat\nBan thuc an", COLOR_VANG,1099.1849,-1473.7426,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang dien tu\nBan thiet bi dien tu", COLOR_VANG, 1154.3347,-1457.8260,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang vu khi\nBuon ban vu khi", COLOR_VANG,  1154.3931,-1445.0968,15.7969, 20, 0, 0);
	CreateDynamicActor(111, 588.1791,866.1268,-42.4973,182.9709, true, 100.0, 0, 0, -1);
	CreateDynamicActor(155, 1362.9523,253.9632,19.5669, true, 100.0, 0, 0, -1);
	CreateDynamicActor(6, 2126.8018,-76.6521,2.4721,275.2467, true, 100.0, 0, 0, -1);
	TruckActor = CreateDynamicActor(133, 58.5952,-292.2914,1.5781,6.3205, true, 100.0, 0, 0, -1);
    return 1;
}
/*

AddPlayerClass(213,1103.4659,-1433.9872,15.7969,258.0890,0,0,0,0,0,0); // // cua hang tien dung
AddPlayerClass(213,1102.7621,-1445.4734,15.7969,262.8826,0,0,0,0,0,0); // // cua hang quan ao nam
AddPlayerClass(213,1103.2670,-1452.7322,15.7969,246.9024,0,0,0,0,0,0); // // cua hang quan ao nu
AddPlayerClass(213,1099.1849,-1473.7426,15.7969,252.8558,0,0,0,0,0,0); // // quan an vat
AddPlayerClass(213,1154.3347,-1457.8260,15.7969,92.4509,0,0,0,0,0,0); // // cua hang dien tu
AddPlayerClass(213,1154.3931,-1445.0968,15.7969,91.1976,0,0,0,0,0,0); // // Cua hang vu khi*/