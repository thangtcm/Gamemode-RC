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
Dialog:thuksdialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, banda, DIALOG_STYLE_INPUT, "Ban {a8a7a7}DA", "{ffffff}Hay nhap so luong ma ban muon ban", "Ban", "Huy");
			}
			case 1:
			{
				Dialog_Show(playerid, bandong, DIALOG_STYLE_INPUT, "Ban {c96c02}DONG", "{ffffff}Hay nhap so luong ma ban muon ban", "Ban", "Huy");
			}
			case 2:
			{
				Dialog_Show(playerid, bansat, DIALOG_STYLE_INPUT, "Ban {5c5c5c}SAT", "{ffffff}Hay nhap so luong ma ban muon ban", "Ban", "Huy");
			}
			case 3:
			{
				Dialog_Show(playerid, banvang, DIALOG_STYLE_INPUT, "Ban {f7ff05}VANG", "{ffffff}Hay nhap so luong ma ban muon ban", "Ban", "Huy");
			}
		}
	}
	return 1;
}
Dialog:banda(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
		{
			return Dialog_Show(playerid, banda, DIALOG_STYLE_INPUT, "Ban {a8a7a7}DA", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(strval(inputtext) < 1)
		{
			return Dialog_Show(playerid, banda, DIALOG_STYLE_INPUT, "Ban {a8a7a7}DA", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(Inventory_Count(playerid, "Da") < strval(inputtext))
		{
			return Dialog_Show(playerid, banda, DIALOG_STYLE_INPUT, "Ban {a8a7a7}DA", "{8f0a03}Ban da nhap nhieu hon so {a8a7a7}DA{8f0a03} ma ban co trong tui do !", "Ban", "Huy");
		}
		else
		{
			new format_job[1280], moneyselled = RandomMoney[0]*strval(inputtext);
			format(format_job, sizeof(format_job), "[SERVER] {ffffff}Ban da ban {6e69ff}%d {a8a7a7}DA {ffffff}thanh cong va nhan duoc %d$.", strval(inputtext), moneyselled);
			PlayerInfo[playerid][pCash] += moneyselled;
			SendClientMessage(playerid, COLOR_LIGHTRED, format_job);
			new pItemId = Inventory_GetItemID(playerid, "Da", strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
        	new moneyzxc[30];
        	format(moneyzxc, 30, "%d$", moneyselled);
			SendLogToDiscordRoom4("RC:RP LOG - BÁN ĐÁ", "1157988261382328392", "Name", GetPlayerNameEx(playerid), "Đã bán", "Đá", "Số lượng", inputtext, "TỔNG TIỀN", moneyzxc, 0x229926);
		}
	}
	return 1;
}
Dialog:bandong(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
		{
			return Dialog_Show(playerid, bandong, DIALOG_STYLE_INPUT, "Ban {c96c02}DONG", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(strval(inputtext) < 1)
		{
			return Dialog_Show(playerid, bandong, DIALOG_STYLE_INPUT, "Ban {c96c02}DONG", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(Inventory_Count(playerid, "Dong") < strval(inputtext))
		{
			return Dialog_Show(playerid, bandong, DIALOG_STYLE_INPUT, "Ban {c96c02}DONG", "{8f0a03}Ban da nhap nhieu hon so {c96c02}DONG{8f0a03} ma ban co trong tui do !", "Ban", "Huy");
		}
		else
		{
			new format_job[1280], moneyselled = RandomMoney[1]*strval(inputtext);
			format(format_job, sizeof(format_job), "[SERVER] {ffffff}Ban da ban {6e69ff}%d {c96c02}DONG {ffffff}thanh cong va nhan duoc %d$.", strval(inputtext), moneyselled);
			PlayerInfo[playerid][pCash] += moneyselled;
			SendClientMessage(playerid, COLOR_LIGHTRED, format_job);
			new pItemId = Inventory_GetItemID(playerid, "Dong", strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
        	new moneyzxc[30];
        	format(moneyzxc, 30, "%d$", moneyselled);
			SendLogToDiscordRoom4("RC:RP LOG - BÁN ĐỒNG", "1157988261382328392", "Name", GetPlayerNameEx(playerid), "Đã bán", "Đồng", "Số lượng", inputtext, "TỔNG TIỀN", moneyzxc, 0x229926);
		}
	}
	return 1;
}
Dialog:bansat(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
		{
			return Dialog_Show(playerid, bansat, DIALOG_STYLE_INPUT, "Ban {5c5c5c}SAT", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(strval(inputtext) < 1)
		{
			return Dialog_Show(playerid, bansat, DIALOG_STYLE_INPUT, "Ban {5c5c5c}SAT", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(Inventory_Count(playerid, "Sat") < strval(inputtext))
		{
			return Dialog_Show(playerid, bansat, DIALOG_STYLE_INPUT, "Ban {5c5c5c}SAT", "{8f0a03}Ban da nhap nhieu hon so {5c5c5c}SAT{8f0a03} ma ban co trong tui do !", "Ban", "Huy");
		}
		else
		{
			new format_job[1280], moneyselled = RandomMoney[2]*strval(inputtext);
			format(format_job, sizeof(format_job), "[SERVER] {ffffff}Ban da ban {6e69ff}%d {5c5c5c}SAT {ffffff}thanh cong va nhan duoc %d$.", strval(inputtext), moneyselled);
			PlayerInfo[playerid][pCash] += moneyselled;
			SendClientMessage(playerid, COLOR_LIGHTRED, format_job);
			new pItemId = Inventory_GetItemID(playerid, "Sat", strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
        	new moneyzxc[30];
        	format(moneyzxc, 30, "%d$", moneyselled);
			SendLogToDiscordRoom4("RC:RP LOG - BÁN SẮT", "1157988261382328392", "Name", GetPlayerNameEx(playerid), "Đã bán", "Sắt", "Số lượng", inputtext, "TỔNG TIỀN", moneyzxc, 0x229926);
		}
	}
	return 1;
}
Dialog:banvang(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
		{
			return Dialog_Show(playerid, banvang, DIALOG_STYLE_INPUT, "Ban {f7ff05}VANG", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(strval(inputtext) < 1)
		{
			return Dialog_Show(playerid, banvang, DIALOG_STYLE_INPUT, "Ban {f7ff05}VANG", "{8f0a03}Hay nhap so luong hop le !", "Ban", "Huy");
		}
		else if(Inventory_Count(playerid, "Vang") < strval(inputtext))
		{
			return Dialog_Show(playerid, banvang, DIALOG_STYLE_INPUT, "Ban {f7ff05}VANG", "{8f0a03}Ban da nhap nhieu hon so {f7ff05}VANG{8f0a03} ma ban co trong tui do !", "Ban", "Huy");
		}
		else
		{
			new format_job[1280], moneyselled = RandomMoney[3]*strval(inputtext);
			format(format_job, sizeof(format_job), "[SERVER] {ffffff}Ban da ban {6e69ff}%d {f7ff05}VANG {ffffff}thanh cong va nhan duoc %d$.", strval(inputtext), moneyselled);
			PlayerInfo[playerid][pCash] += moneyselled;
			SendClientMessage(playerid, COLOR_LIGHTRED, format_job);
			new pItemId = Inventory_GetItemID(playerid, "Vang", strval(inputtext));
			Inventory_Remove(playerid, pItemId, strval(inputtext));
        	new moneyzxc[30];
        	format(moneyzxc, 30, "%d$", moneyselled);
			SendLogToDiscordRoom4("RC:RP LOG - BÁN VÀNG NÈ", "1157988261382328392", "Name", GetPlayerNameEx(playerid), "Đã bán", "VÀNGGGGGGGGGG", "Số lượng", inputtext, "TỔNG TIỀN", moneyzxc, 0x229926);
		}
	}
	return 1;
}


Dialog:muapickaxedialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(Inventory_Count(playerid, "Pickaxe") >= 1) return SendErrorMessage(playerid, "Ban da mua Pickaxe roi, hay di tim nhung khoang san de dao");
		PlayerInfo[playerid][pCash] -= 500;
		Inventory_Add(playerid, "Pickaxe", 1, 60);
		SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: {ffffff}Ban da mua thanh cong Pickaxe, hay di tim khoang san de dao");
	}
	return 1;
}

