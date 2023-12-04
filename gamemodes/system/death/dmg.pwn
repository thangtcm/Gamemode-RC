
const MAX_SHOW_DMG = 50;

enum dmgInfo
{
    dmgBody,
    Float:dmgHit,
    dmgReason
};

new DamagedInfo[MAX_PLAYERS][MAX_SHOW_DMG][dmgInfo];

stock GetBodyName(bodypart)
{
    new szResult[128];
    switch(bodypart)
    {
        case 3: szResult = "Than";
        case 4: szResult = "Hang";
        case 5: szResult = "Tay trai";
        case 6: szResult = "Tay phai";
        case 7: szResult = "Chan trai";
        case 8: szResult = "Chan phai";
        case 9: szResult = "Dau";
        default: szResult = "Khong ro";
    }
    return szResult;
}

stock ResetDamagedPlayer(playerid)
{
    for(new i; i < MAX_SHOW_DMG; i ++)
    {
        DamagedInfo[playerid][i][dmgBody] = 0;
        DamagedInfo[playerid][i][dmgHit] = 0.0;
        DamagedInfo[playerid][i][dmgReason] = -1;
        DamagedReset[playerid] = -1;
    }
    return 1;
}

CMD:damages(playerid, const params[])
{
    new targetid;
    if(sscanf(params, "d", targetid)) return SendUsageMessage(playerid, " /damages [playerid]");

    if(GetPVarInt(targetid, "Injured") == 0) 
        return SendClientMessage(playerid, COLOR_GRAD2, "Nguoi choi nay khong bi thuong.");
    if(!ProxDetectorS(5.0, playerid, targetid))
        return SendClientMessage(playerid, COLOR_GRAD2, "Nguoi choi nay khong o gan ban.");
    if(GetPVarInt(playerid, "Injured") != 0)
        return SendClientMessage(playerid, COLOR_GRAD2, "Ban khong the lam dieu nay khi bi thuong.");

    new title[128], szDialog[1028];
    strcat(szDialog, "Vu khi\tSat thuong\tBo phan\n");
    for(new i; i < MAX_SHOW_DMG; i ++)
    {
        if(DamagedInfo[targetid][i][dmgHit] != 0)
        {
            format(szDialog, sizeof(szDialog), "%s%s\tgay ra {A81F1F}%0.1f\t{FFFFFF}%s\n", 
            szDialog,
            GetWeaponNameEx(DamagedInfo[targetid][i][dmgReason]),
            DamagedInfo[targetid][i][dmgHit],
            GetBodyName(DamagedInfo[playerid][i][dmgBody]));
        }
    }

    format(title, sizeof(title), "Thong tin sat thuong [ID: %d]", targetid);
    ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_TABLIST_HEADERS, title, szDialog, "Dong", "");

    return 1;
}


/*=====================================*/
#include <YSI_Coding\y_hooks>
hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    for(new i; i < MAX_SHOW_DMG; i++)
    {
        if(DamagedInfo[playerid][i][dmgBody] == 0)
        {
            DamagedInfo[playerid][i][dmgBody] = bodypart;
            DamagedInfo[playerid][i][dmgHit] = amount;
            DamagedInfo[playerid][i][dmgReason] = weaponid;
            
            DamagedReset[playerid] = 45;
            break;
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    ResetDamagedPlayer(playerid);
    return 1;
}