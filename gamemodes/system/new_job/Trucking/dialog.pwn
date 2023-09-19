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