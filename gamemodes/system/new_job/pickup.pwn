
stock LoadTextUpJob() {
	CreateDynamic3DTextLabel("<Quan ly khu mo> {2791FF}Miner{ffffff}\n(Den gan va bam phim 'Y' de bat dau lam viec)", -1, 960.1240,-2142.9419,13.0938+1.15, 2.5);
	CreateDynamic3DTextLabel("<Thu mua khoang san/go> {2791FF}Miner{ffffff}\n(Den gan va bam phim 'Y' de ban khoang san)", -1, 1136.7050,-1439.3700,15.7969+1.15, 2.5);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Farmer{ffffff}\n{2791FF}/farmer{ffffff} de bat dau lam viec", -1, -1420.0443, -1474.9486, 101.6293, 30);
	CreateDynamic3DTextLabel("<Quan ly Pizza Stack> {2791FF}Pizza{ffffff}\n(Den gan va bam '/pizza' de lam viec)", -1, 2099.0378,-1801.4995,13.3889+1.15, 5);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Chat go{ffffff}\n{2791FF}/wood{ffffff} de bat dau xin viec/lam viec", -1, 2357.2139, -651.3280, 128.0547, 30);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}Trucker{ffffff}\n{2791FF}/xinviec{ffffff} de bat dau xin viec/lam viec", -1, 2447.0867,-2100.8335,13.5469, 30);
	CreateDynamic3DTextLabel("Khu vuc {2791FF}dang ky CMND{ffffff}\n{2791FF}/dangkycmnd{ffffff} de dang ky CMND", -1, 359.7139,173.6452,1008.3893, 30);
	//CreateDynamic3DTextLabel("Khu vuc {2791FF}Thi bang lai{ffffff}\n{2791FF}/thibanglai{ffffff} de thi bang lai xe", -1, 1222.5018,243.8309,19.5469, 30);
	CreateDynamic3DTextLabel("Khu vuc {FF0000}dang ky CMND{ffffff}\n{FF0000}/dangkycmnd{ffffff} de dang ky CMND", -1, 359.7139,173.6452,1008.3893, 15);
	Create3DTextLabel("Cua hang do tien dung\nChuyen buon ban cac vat pham", COLOR_VANG, 1103.4659,-1433.9872,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang quan ao nam\nBan trang phuc danh cho nam", COLOR_VANG, 1102.7621,-1445.4734,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang quan ao nu\n/Ban trang phuc danh cho Nu", COLOR_VANG,1103.2670,-1452.7322,15.7969, 20, 0, 0);
	Create3DTextLabel("Quan an vat\nBan thuc an", COLOR_VANG,1099.1849,-1473.7426,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang dien tu\nBan thiet bi dien tu", COLOR_VANG, 1154.3347,-1457.8260,15.7969, 20, 0, 0);
	Create3DTextLabel("Cua hang vu khi\nBuon ban vu khi", COLOR_VANG,  1154.3931,-1445.0968,15.7969, 20, 0, 0);

	MinerActor[0] = CreateDynamicActor(111, 960.1240,-2142.9419,13.0938,261.8049, true, 100.0, 0, 0, -1);
	MinerActor[1] = CreateDynamicActor(6, 2124.2324,-1738.6648,13.5645,268.9953, true, 100.0, 0, 0, -1);
	PizzaActor = CreateDynamicActor(155, 2099.0378,-1801.4995,13.3889,88.5935, true, 100.0, 0, 0, -1);
	TruckActor = CreateDynamicActor(133, 2447.0867,-2100.8335,13.5469,95.5176, true, 100.0, 0, 0, -1);
	// ActorFarmer = CreateDynamicActor(158, -1420.0443, -1474.9486, 101.6293, true, 100.0, 0, 0, -1);
	// ApplyActorAnimation(ActorFarmer, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(MinerActor[0], "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(MinerActor[1], "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0);
	ApplyActorAnimation(PizzaActor, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0);

    return 1;
}
/*

AddPlayerClass(4,2447.0867,-2100.8335,13.5469,95.5176,0,0,0,0,0,0); //  NPC Trucker (Them cho a dong /xinviec truoc mat thang NPC)
AddPlayerClass(4,2431.9810,-2118.9050,13.5469,359.6823,0,0,0,0,0,0); //  Vi tri /truckergo car (Kem ca text va checkpoint sang nhe)

AddPlayerClass(213,1103.4659,-1433.9872,15.7969,258.0890,0,0,0,0,0,0); // // cua hang tien dung
AddPlayerClass(213,1102.7621,-1445.4734,15.7969,262.8826,0,0,0,0,0,0); // // cua hang quan ao nam
AddPlayerClass(213,1103.2670,-1452.7322,15.7969,246.9024,0,0,0,0,0,0); // // cua hang quan ao nu
AddPlayerClass(213,1099.1849,-1473.7426,15.7969,252.8558,0,0,0,0,0,0); // // quan an vat
AddPlayerClass(213,1154.3347,-1457.8260,15.7969,92.4509,0,0,0,0,0,0); // // cua hang dien tu
AddPlayerClass(213,1154.3931,-1445.0968,15.7969,91.1976,0,0,0,0,0,0); // // Cua hang vu khi*/
