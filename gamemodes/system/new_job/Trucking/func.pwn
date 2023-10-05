forward HijackTruck(playerid, target, pVehicleId);
public HijackTruck(playerid, target, pVehicleId)
{
    new vehicleid = PlayerVehicleInfo[playerid][pVehicleId][pvId];
	SetPVarInt(playerid, "LoadTruckTime", GetPVarInt(playerid, "LoadTruckTime")-1);
	new string[128];
	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~%d giay nua", GetPVarInt(playerid, "LoadTruckTime"));
	GameTextForPlayer(playerid, string, 1100, 3);
	if(GetPVarInt(playerid, "LoadTruckTime") > 0) SetTimerEx("HijackTruck", 1000, 0, "d", playerid);

	if(GetPVarInt(playerid, "LoadTruckTime") <= 0)
	{
		DeletePVar(playerid, "IsFrozen");
		TogglePlayerControllable(playerid, 1);
  		DeletePVar(playerid, "LoadTruckTime");

        if(!IsPlayerInVehicle(playerid, vehicleid))
        {
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
 			DisablePlayerCheckpoint(playerid);
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE,"* Ban cuop hang khong thanh cong.");
			return 1;
        }
        SendClientMessageEx(playerid, COLOR_MAIN, "Ban da cuop hang hoa thanh cong, ban co the lay hang hoa chuyen qua xe ban hoac toi nha may ban no.");
        SetPVarInt(playerid, "RobberyCarTruck", pVehicleId);
        SendClientMessageEx(target, COLOR_WHITE, "Xe van chuyen hang hoa cua ban da bi cuop.");
	}
	return 1;
}

stock RemoveMissionProduct(playerid, productId)
{
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        if(GetPVarInt(playerid, "MissionTruck") == 1)
        {
            if(PlayerTruckerData[playerid][MissionProduct][i] == productId)
            {
                PlayerTruckerData[playerid][MissionProduct][i] = -1;
                return 1;
            }
        }
    }
    return -1;
}

stock FactoryInformation(playerid)
{
    new string[4096];
    format(string, sizeof(string), "{FFFFFF}ID\t\tTen Nha May\t\tVi Tri\t\tMet");
    new zone[MAX_ZONE_NAME],Float:Distance;
    for(new i; i < sizeof(FactoryData); i++)
    {
        PlayerTruckerData[playerid][SuggestFactory][i] = i;
        Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[i][FactoryPos][0], FactoryData[i][FactoryPos][1], FactoryData[i][FactoryPos][2]);
        Get3DZone(FactoryData[i][FactoryPos][0], FactoryData[i][FactoryPos][1], FactoryData[i][FactoryPos][2], zone, sizeof(zone));
        format(string, sizeof(string),"%s\n%d\t\t%s\t\t%s\t\t%0.2f Met",string, i, FactoryData[i][FactoryName], zone, Distance);
    }
    Dialog_Show(playerid, DIALOG_LISTFACTORY ,DIALOG_STYLE_TABLIST_HEADERS, "Danh Sach Cac Nha May", string, "Xac nhan", "<");
}

stock FactorySuggest(playerid)
{
    new numFoundFactories = 0,
        MaxFactiory = sizeof(FactoryData), MaxExport;
    for (new i = 0; i < MaxFactiory; i++) {
        MaxExport = strlen(FactoryData[i][ProductName]);
        for (new j = 0; j < MaxExport; j++) {
            if(IsProductValid(playerid, FactoryData[i][ProductName][j])) {
                PlayerTruckerData[playerid][SuggestFactory][numFoundFactories++] = i;
                break;
            }
        }
    }
    new str[1200], zone[MAX_ZONE_NAME],Float:Distance;
    format(str, sizeof(str), "Ten Nha May\t\tVi Tri\t\tKhoang cach");
    for(new i; i < numFoundFactories;i++)
    {
        Distance = GetPlayerDistanceFromPoint(playerid, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2]);
        Get3DZone(FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][0], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][1], FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryPos][2], zone, sizeof(zone));
        format(str, sizeof(str), "%s\n%s\t\t%s\t\t%0.2f Met", str, FactoryData[PlayerTruckerData[playerid][SuggestFactory][i]][FactoryName], zone, Distance);
    }
    Dialog_Show(playerid, DIALOG_SUGGESTFACTORY, DIALOG_STYLE_TABLIST_HEADERS, "Cong viec Trucker", str, "Lua chon", "Huy bo");
}

stock AttachProductToVehicle(playerid, vehicleid, Product, pVehicleId)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 422:
        {
            new count = VehicleTruckerCount(playerid, PlayerVehicleInfo[playerid][pVehicleId][pvSlotId]);
            if(count +1 >= PlayerVehicleInfo[playerid][pVehicleId][pvMaxSlotTrucker])
            {
                SendClientMessageEx(playerid, COLOR_MAIN, "Xe cua ban da chat day hang, hay su dung [ /truckergo ship ] de lay dia diem giao hang.");
            }
            for(new i; i < MAX_PLAYERPRODUCT; i++)
            {
                if(PlayerTruckerData[playerid][ClaimProduct][i] == -1)
                {
                    PlayerTruckerData[playerid][ClaimProduct][i]  = Product;
                    break;
                }
            }
            VEHICLETRUCKER_ADD(playerid, vehicleid, 1271, PlayerVehicleInfo[playerid][pVehicleId][pvSlotId], Product,  0.00, -0.82 - (1 * count), 0.05, 0.0, 0.0, 0);
            return 1;
        } 
        default:
        {
            new count = VehicleTruckerCount(playerid, PlayerVehicleInfo[playerid][pVehicleId][pvSlotId]);
            for(new i; i < MAX_PLAYERPRODUCT; i++)
            {
                if(PlayerTruckerData[playerid][ClaimProduct][i] == -1)
                {
                    PlayerTruckerData[playerid][ClaimProduct][i]  = Product;
                    break;
                }
            }
            VEHICLETRUCKER_ADD(playerid, vehicleid, 0, PlayerVehicleInfo[playerid][pVehicleId][pvSlotId], Product,  0.01, -0.82 - (0.1 * count), 0.05, 0.0, 0.0, -90);
            return 1;
        }
    }
    return 0;
}

stock IsPlayerNearCar(playerid, vehicleid)
{
	new
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehiclePos(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ);
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

// stock IsPlayerInFactory2(playerid)
// {
//     for(new i; i < sizeof(FactoryExportData); i++)
//     {
//         if(IsPlayerInRangeOfPoint(playerid, 5.0, FactoryExportData[i][FactoryPos][0], FactoryExportData[i][FactoryPos][1], FactoryExportData[i][FactoryPos][2]))
//             return i;
//     }
//     return -1;
// }

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

stock CheckProductCar(CarTruckID, Unit)
{
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        if(CarTruckWorking[CarTruckID][CarUnitType][i] == Unit)
        {
            return 1;
        }
    }
    return 0;
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

stock IsProductImport(FactoryId, ProductId)
{
    for(new i; i < strlen(FactoryData[FactoryId][ProductImportName]); i++)
    {
        if(FactoryData[FactoryId][ProductImportName][i] == ProductId)   return true;
    }
    return false;
}

stock ClearTrucker(playerid)
{
    DeletePVar(playerid, "MissionTruck");
    DeletePVar(playerid, "MaxMissionTruck");
    DeletePVar(playerid, "BUY_FactoryID");
    DeletePVar(playerid, "CarryProductToCar");
    DeletePVar(playerid, "Sell_ProductID");
    DeletePVar(playerid, "Sell_ProductID2");
    for(new i; i < MAX_PLAYERPRODUCT; i++)
    {
        PlayerTruckerData[playerid][ClaimProduct][i] = -1;
        PlayerTruckerData[playerid][MissionProduct][i] = -1;
        PlayerTruckerData[playerid][ClaimFromCar][i] = -1;
        PlayerTruckerData[playerid][SellProduct][i] = -1;
    }
    SaveWeigth[playerid] = 0;
    pLoadProduct[playerid] = -1;
    return 1;
}

public NextTutorialTruck(playerid)
{
    new type = GetPVarInt(playerid, "ViewTutorialTruck"), str[1080];
    switch(type)
    {
        case 0:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 1);
            TogglePlayerControllable(playerid, 0);
            SetPlayerFacingAngle(playerid, 90.0);
            SetPlayerPos(playerid, 58.6429, -288.6857, 2.00);
            InterpolateCameraPos(playerid, 53.9746, -220.4122, 13.00, 58.6429, -288.6857, 2.00, 10000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 53.9746, -220.4122, 13.00, 58.6429, -288.6857, 2.00, 5000, CAMERA_MOVE);
            format(str, sizeof(str), "Xin chao va chuc mung ban den voi Red County!~n~Toi la Mike, va toi da thay rang ban co the tro thanh mot tai xe xuat sac.");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 1000)  , false, "d", playerid);
        }
        case 1:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 2);
            format(str, sizeof(str), "Giao hang la mot cong viec tuyet voi tai day, va toi muon giup ban bat dau mot cach thanh cong.");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 1000)  , false, "d", playerid);
        }
        case 2:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 3);
            format(str, sizeof(str), "Dau tien, de bat dau giao hang, ban can co mot chiec xe van tai.~n~Hien tai, toi de xuat ban thue mot chiec bobcat.");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 1000)  , false, "d", playerid);
        }
        case 3:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 4);
            format(str, sizeof(str), "Neu ban so huu nhung chiec xe co trong tai lon, ban se co co hoi van chuyen nhung mat hang co loi nhuan cao hon.");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 1000)  , false, "d", playerid);
        }
        case 4:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 5);
            format(str, sizeof(str), "Hay bat dau bang viec thue chiec bobcat va sau do toi se gui cho ban nhiem vu dau tien.");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 1000)  , false, "d", playerid);
        }
        case 5:
        {
            SetPVarInt(playerid, "ViewTutorialTruck", 6);
            format(str, sizeof(str), "Hay nam vung van hanh xe va dam bao loi nhuan luon la uu tien hang dau~n~trong moi chuyen di cua ban.~n~Good luck!");
            ShowTutorialTruck(playerid, "Tutorial", str);
            TutorialTruck_Timer[playerid] = SetTimerEx("NextTutorialTruck", ((25 * strlen(str)) + 2000)  , false, "d", playerid);
        }
    }
    return 1;
}