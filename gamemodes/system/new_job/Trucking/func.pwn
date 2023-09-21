stock IsValidCarTruck(vehicleid)
{
    new carModel = GetVehicleModel(vehicleid);
    for(new i; i < sizeof(CarTruckWorking); i++)
        if(CarTruckWorking[i][CarModel] == carModel) return i;
    return -1;
}

stock GetCarTruckID(vehicleid) // Return CarTruckWorking
{
    new carModel = GetVehicleModel(vehicleid);
    for(new i; i < sizeof(CarTruckWorking); i++)
        if(CarTruckWorking[i][CarModel] == carModel) return i;
    return -1;
}

forward ToggleCameraMove(playerid);
public ToggleCameraMove(playerid)
{
	TogglePlayerControllable(playerid, 1);
    SetCameraBehindPlayer(playerid);
}