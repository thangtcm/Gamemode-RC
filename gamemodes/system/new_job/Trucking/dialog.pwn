Dialog:DIALOG_LISTFACTORY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[5000], szString[100];
        format(szString, sizeof(szString), "{FFFFFF}Thong tin nha may - {FF8000}%s (ID: %d)", FactoryData[listitem][FactoryName], listitem);
        format(string, sizeof(string), "\t\t\tNhap Khau\t\t\n\n");
        printf("%d", strlen(FactoryData[listitem][ProductName]));
        for(new i; i < strlen(FactoryData[listitem][ProductName]); i++)
        {
            format(string, sizeof(string), "%s{FF8000}Mat Hang: {FFFFFF}%s({FF8000}ID: {FFFFFF}%i)\n{FF8000}Gia tien: {FFFFFF}$%d\n{FF8000}Kho ton: {FFFFFF}$%d{FFFFFF}\
            \n\t\t~~~~~~~~~~~~~~~~\n\n", 
                string, ProductData[FactoryData[listitem][ProductName][i]][ProductName], listitem, FactoryData[listitem][ProductPrice][i], FactoryData[listitem][WareHouse][i]);
        }
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, szString, string, "<", "");
	}
	return 1;
}

Dialog:DIALOG_STARTTRUCKER(playerid, response, listitem, inputtext[])
{
    if(response)
	{
        new str[256];
        switch(listitem)
        {
            case 0:{
                SetPVarInt(playerid, "IntroMissionTruck", 1);
                ///
                new CarTruckID = GetCarTruckID(PlayerInfo[playerid][pRegisterCarTruck]);
                new UnitID = CarTruckWorking[CarTruckID][CarUnitType][random(strlen(CarTruckWorking[CarTruckID][CarUnitType]))];
                new matchingProducts[sizeof(ProductData)];
                new numMatchingProducts = 0;
                for (new i = 0; i < sizeof(ProductData); i++)
                {
                    if (ProductData[i][ProductUnitID] == UnitID)
                    {
                        matchingProducts[numMatchingProducts] = i;
                        numMatchingProducts++;
                    }
                }
                if (numMatchingProducts == 0)
                {
                    return -1;
                }
                new weight = CarTruckWorking[CarTruckID][Weight];
                printf("%d", weight);
                new randomIndex[2];
                for(new i; i < CarTruckWorking[CarTruckID][Weight]; i++)
                {
                    randomIndex[i] = matchingProducts[random(numMatchingProducts)]; 
                }
                format(str, sizeof(str), "Ban da nhan duoc nhiem vu giao %s va %s", ProductData[randomIndex[0]][ProductName], ProductData[randomIndex[1]][ProductName]);
                SendClientMessage(playerid, COLOR_YELLOW, str);
            }
        }
    }
    return 1;
}