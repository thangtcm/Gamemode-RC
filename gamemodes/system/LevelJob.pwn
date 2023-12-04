#include <ysi\y_hooks>


enum job_skill
{
    Pizza,
    Fish
}

new JobSkill[MAX_PLAYERS][job_skill];


CMD:leveljob(playerid, params[])
{
    if(isnull(params))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /leveljob [number]");
		SendClientMessageEx(playerid, COLOR_GREY, "| 1: Pizza | 2: Cau ca");
		return 1;
	}
	else switch(strval(params)) 
	{
		case 1: //pizz
		{
			new level = JobSkill[playerid][Pizza], string[48];
			if(level >= 0 && level < 200) { SendClientMessageEx(playerid, COLOR_YELLOW, "Ky nang Giao Pizza cap do = 1."); format(string, sizeof(string), "Ban can %d chuyen nua de co the len level 2", 200 - level); SendClientMessageEx(playerid, COLOR_YELLOW, string); }
			else if(level >= 200 && level < 400) { SendClientMessageEx(playerid, COLOR_YELLOW, "Ky nang Giao Pizza cap do = 2.(MAX - DOI UPDATE THEM)"); }
		}
		case 2: //fish
		{
			new level = JobSkill[playerid][Fish], string[48];
			if(level >= 0 && level < 200) { SendClientMessageEx(playerid, COLOR_YELLOW, "Ky nang Cau Ca cap do = 1."); format(string, sizeof(string), "Ban can %d lan cau thanh cong nua de co the len level 2", 250 - level); SendClientMessageEx(playerid, COLOR_YELLOW, string); }
			else if(level >= 250 && level < 400) { SendClientMessageEx(playerid, COLOR_YELLOW, "Ky nang Cau Ca cap do = 2.(MAX - DOI UPDATE THEM)"); }
		}
	}
	return 1;
}

CMD:testlvjobjs(playerid, params[])
{
    JobSkill[playerid][Pizza] = 250;
    return 1;
}