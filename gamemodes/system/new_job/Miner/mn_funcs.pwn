Dialog:minerdialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				if(GetPVarInt(playerid, #skinsavezxc) == 0)
				{
					new skinz = GetPlayerSkin(playerid);
					SetPVarInt(playerid, #skinsavezxc, skinz);
					SetPlayerSkin(playerid, 27);
					SetPlayerAttachedObject(playerid, 8, 19559, 1, 0.119999, -0.051999, 0.0, 0.0, 87.9, 0.0, 1.034, 1.283, 1.0);
					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Ban da nhan dong phuc, hay mua Pickaxe de dao.");
				}
				else
				{
					new skinx = GetPVarInt(playerid, #skinsavezxc);
					SetPlayerSkin(playerid, skinx);
					SetPVarInt(playerid, #skinsavezxc, 0);
					RemovePlayerAttachedObject(playerid, 8);
				}
			}
			case 1:
			{
				Dialog_Show(playerid, muapickaxedialog, DIALOG_STYLE_MSGBOX, "Mua PICKAXE", "Ban co chac chan muon mua PICKAXE voi gia 500$?\n1 PICKAXE chi duoc su dung trong vong 60 phut", "Dong y", "Khong");
			}
		}
	}
	return 1;
}

Dialog:muapickaxedialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!Inventory_HasItem(playerid, 0))
		{
			GivePlayerMoney(playerid, -500);
			Inventory_Add(playerid, 0, 1, 60);
			SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Ban da mua thanh cong Pickaxe, hay di tim khoang san de dao");
		}
		else return SendErrorMessage(playerid, "Ban da mua Pickaxe roi, hay di tim nhung khoang san de dao");
	}
	return 1;
}

