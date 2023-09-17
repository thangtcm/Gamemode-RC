#include <YSI_Coding\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, 588.1791,866.1268,-42.4973))
	{
	    if(PRESSED(KEY_YES))
	    {
	    	Dialog_Show(playerid, minerdialog, DIALOG_STYLE_LIST, "Quan ly khu mo", "Nhan / tra dong phuc lam viec\nMua Pickaxe (dung cu de dao)", "Lua chon", "Huy bo");
	    }
	}
	if(IsPlayerInRangeOfPoint(playerid, 300.0, 588.1791,866.1268,-42.4973))
	{
		if(PRESSED(KEY_YES))
		{
			for(new i = 0; i < MAX_ROCKS; i++)
			{
				if(RockStatus[i] == 1)
				{
					if(IsPlayerInRangeOfPoint(playerid, 2.0, rockPositions[i][0], rockPositions[i][1], rockPositions[i][2]))
					{
						if(GetPlayerSkin(playerid) == 27)
						{
							if(Inventory_HasItem(playerid, 0, 1))
							{
								if(timerdc == 0)
								{
									OnPlayerPickUpRock(playerid, i);
								}
								else return SendErrorMessage(playerid, " Ban dang dao da roi.");
							}
							else return SendErrorMessage(playerid, " Ban chua mua Pickaxe.");
						}
						else return SendErrorMessage(playerid, " Ban dang khong mac quan ao bao ho cua cong viec miner, hay den NPC de lay quan ao.");
					}
				}
			}
		}
	}
	return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid, #skinsavezxc) != 0)
	{
		timerdc = 0;
		RemovePlayerAttachedObject(playerid, 8);
		RemovePlayerAttachedObject(playerid, 9);
		new skinc = GetPVarInt(playerid, #skinsavezxc);
		SetPlayerSkin(playerid, skinc);
		SetPVarInt(playerid, #skinsavezxc, 0);
	}
}
hook OnGameModeInit()
{
    for (new i = 0; i < MAX_ROCKS; i++)
    {
        RockStatus[i] = 1; 
        CreateRock(i);
    }
}
forward OnPlayerPickUpRock(playerid, rockIndex);
public OnPlayerPickUpRock(playerid, rockIndex)
{
    if (RockStatus[rockIndex] == 1)
    {
    	RockStatus[rockIndex] = 0;
		timerdc = 35+(random(40));
		timerd = timerdc*1000;
		SetTimerEx("OnRockMined", timerd, false, "i", playerid);
		SetTimerEx("StartCountTime", 1000, false, "i", playerid);
    	DestroyDynamicObject(RockObj[rockIndex]);
    	DestroyDynamic3DTextLabel(RockText[rockIndex]);
    	SetTimerEx("OnRockRespawn", 600000, false, "i", rockIndex);
   		ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,1,1,1,1,1);
		SetPVarInt(playerid, #dangdaoda, 1);
		TogglePlayerControllable(playerid, 0);
		SetPlayerAttachedObject(playerid, 9, 2228, 6, 0.036999, 0.041, 0.21, 0.0, 172.8, -89.3, 0.805, 1.046, 0.789999);
    }
}
forward StartCountTime(playerid);
public StartCountTime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(timerdc > 0)
		{
			timerdc--;
			new format_job[1280];
			format(format_job, sizeof(format_job), "Ban dang dao da, vui long doi~p~ %d~w~ de dao xong.", timerdc);
			SendClientTextDraw(playerid, format_job);
			SetTimerEx("StartCountTime", 1000, false, "i", playerid);
			ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,1,1,1,1,1);
		}
		else
		{
			TogglePlayerControllable(playerid, 1);
			ApplyAnimation(playerid,"SWORD","sword_1",0.87,1,0,0,0,0);
			ClearAnimations(playerid);
			new format_job[1280];
			switch(random(100))
			{
				case 0..34:
				{
					format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~y~1 Da~g~.");
					Inventory_Add(playerid, 0, 11);
				}
				case 35..65:
				{
					format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Sat~g~.");
					Inventory_Add(playerid, 0, 13);
				}
				case 66..95:
				{
					format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~b~1 Dong~g~.");
					Inventory_Add(playerid, 0, 12);
				}
				case 96..100:
				{
					format(format_job, sizeof(format_job), "~g~Ban da dao thanh cong va nhan duoc ~r~1 VANG~g~.");
					Inventory_Add(playerid, 0, 14);
				}
			}
			SendClientTextDraw(playerid, format_job);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
}

forward OnRockRespawn(rockIndex);
public OnRockRespawn(rockIndex)
{
    if (RockStatus[rockIndex] == 0)
    {
        RockStatus[rockIndex] = 1;
        CreateRock(rockIndex);
    }
}
forward CreateRock(rockIndex);
public CreateRock(rockIndex)
{
	new randomrzx = random(360);
	new Float:randomrz = float(randomrzx);
	RockText[rockIndex] = CreateDynamic3DTextLabel("<Rock>\n Bam phim 'Y' de bat dau dao da.", -1, rockPositions[rockIndex][0], rockPositions[rockIndex][1], rockPositions[rockIndex][2], 2.0);
    RockObj[rockIndex] = CreateDynamicObject(905, rockPositions[rockIndex][0], rockPositions[rockIndex][1], rockPositions[rockIndex][2]-0.8, 0.0, 0.0, randomrz, -1, -1, -1);
}
