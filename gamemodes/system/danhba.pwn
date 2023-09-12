#define      MAX_PHONEBOOK        15
new Number_PhoneBook[MAX_PLAYERS][MAX_PHONEBOOK];
new Name_PhoneBook[MAX_PHONEBOOK][MAX_PLAYERS][50];

stock Add_Phonebook(playerid,numberphone, name[]) {
    new string[129];
	for(new i = 0 ; i < MAX_PHONEBOOK ; i++ ) {
        if(Number_PhoneBook[playerid][i] == numberphone) {
            SendErrorMessage(playerid," SDT Nay da ton tai trong danh ba roi.");
            break ;
        }
        if(Number_PhoneBook[playerid][i] == 0) {
            Number_PhoneBook[playerid][i] = numberphone;
            format(Name_PhoneBook[i][playerid], 50, "%s", name);
            format(string, sizeof string, "Ban da them SDT: {2791FF}%d{FFFFFF} vao danh ba voi ten la: {2791FF}%s",numberphone,name);
            SendClientMessage(playerid, -1, string);
            break ;
        }
	}
	return 1;
}
stock CheckPhoneSlot(playerid) {
    for(new i = 0 ; i < MAX_PHONEBOOK ; i++  ) {
        if(Number_PhoneBook[playerid][i] == 0) {
            return 1;
        }
    }
    return 0;
}
stock Delete_PhoneBook(playerid,slot) {
    Number_PhoneBook[playerid][slot] = 0;
    return 1;
}
stock Show_PhoneBook(playerid) {
    new string[300];
    string = "";
    for(new i = 0;i<MAX_PHONEBOOK;i++) {
    	if(Number_PhoneBook[playerid][i] != 0) {
            format(string, sizeof(string), "%s%d\t%s\n", string,Number_PhoneBook[playerid][i],Name_PhoneBook[i][playerid]);
        }
    }
    if(isnull(string))
    { 
        ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, "Danh ba", "Danh ba ban dang trong!", "Chon", "Thoat");
        return 1;
    }
    ShowPlayerDialog(playerid, DIALOG_PHONEBOOK, DIALOG_STYLE_TABLIST, "Danh ba", string, "Chon", "Thoat");
    return 1;
}
   
