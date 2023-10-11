stock OnSettingOpen(playerid)
{
    new string[64], content[512], discord[128];
    format(string, sizeof(string), "Setting for [%s]", GetPlayerNameEx(playerid));
    format(content, sizeof(content), "%s\n\
                     Chat Settings\n\
                     HUD Settings\n\
                     Keybind Settings\n\
                     Chat/Walk Style\n\
                     Freeze Time", discord);
    Dialog_Show(playerid, SETTING, DIALOG_STYLE_TABLIST_HEADERS, string, content, ">", "<");
    return 1;
}

CMD:setting(playerid, params[])
{

    return 1;
}