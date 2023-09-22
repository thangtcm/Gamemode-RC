stock IsValidCarTruck(vehicleid)
{
    new carModel = GetVehicleModel(vehicleid);
    new maxCarTruckWorking = sizeof(CarTruckWorking);
    for(new i; i < maxCarTruckWorking; i++)
        if(CarTruckWorking[i][CarModel] == carModel) return i;
    return -1;
}

stock RemoveMissionProduct(playerid, productId)
{
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        if(PlayerTruckerData[playerid][MissionProduct][i] == productId)
        {
            PlayerTruckerData[playerid][MissionProduct][i] = -1;
            PlayerTruckerData[playerid][ClaimProduct][i] = productId;
            return true;
        }
    }
    return false;
}

stock IsProductValid(playerid, productId)
{
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        if(PlayerTruckerData[playerid][MissionProduct][i] == -1)
            continue;
        if(PlayerTruckerData[playerid][MissionProduct][i] == productId)  return true;
    }
    return false;
}

stock ShowMissionTrucker(playerid)
{
    new str[256];
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        if(PlayerTruckerData[playerid][MissionProduct][i] == -1)
            continue;
        format(str, sizeof(str), "%s\nSan Pham %d: {FF0000}%s{FFFFFF}", str, i, ProductData[PlayerTruckerData[playerid][MissionProduct][i]][ProductName]);
    }
    format(str, sizeof(str), "Ban da nhan duoc nhiem vu lay san pham %s .\nSu dung lenh ({1eff00}/goiynhamay{ffffff}) :\nDe co the biet duoc nha may can den de lay san pham.", str);
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Trucker", "{FFFFFF}%s", "<", "", str);
    return 1;
}

stock IsPlayerInFactory(playerid)
{
    for(new i; i < sizeof(FactoryData); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, FactoryData[i][FactoryPos][0], FactoryData[i][FactoryPos][1], FactoryData[i][FactoryPos][2]))
            return i;
    }
    return -1;
}

stock GetUnitType(index) //CarTruckWorking
{
    new arr[7], count = 0;
    for(new i; i < 7; i++)
    {
        if(CarTruckWorking[index][CarUnitType][i] != -1)
        {
            arr[count++] = CarTruckWorking[index][CarUnitType][i];
        }
    }
    new rand = random(count);
    return arr[rand];
}

stock GetCarTruckID(vehicleid) // Return CarTruckWorking
{
    new carModel = GetVehicleModel(vehicleid);
    for(new i; i < sizeof(CarTruckWorking); i++)
    {
        if(CarTruckWorking[i][CarModel] == carModel) return i;
    }
    return -1;
}

forward ToggleCameraMove(playerid);
public ToggleCameraMove(playerid)
{
	TogglePlayerControllable(playerid, 1);
    SetCameraBehindPlayer(playerid);
}

stock ClearTrucker(playerid)
{
    DeletePVar(playerid, "MissionTruck");
    DeletePVar(playerid, "BUY_FactoryID");
    DeletePVar(playerid, "CarryProductToCar");
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        PlayerTruckerData[playerid][ClaimProduct][i] = -1;
        PlayerTruckerData[playerid][MissionProduct][i] = -1;
    }
    return 1;
}