

new pLoopAnim[MAX_PLAYERS];
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
CMD:hanhdong(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "_________________________________________________________________");
	SendClientMessage(playerid, COLOR_GRAD1, "/dauhang /drunk /bomb /rob /laugh /lookout /robman /crossarms /sit /siteat /hide /vomit /eat");
	SendClientMessage(playerid, COLOR_GRAD2, "/wave /slapass /deal /taichi /crack /smoke /chat /dance /fucku /taichi /drinkwater /pedmove");
	SendClientMessage(playerid, COLOR_GRAD3, "/checktime /sleep /blob /opendoor /wavedown /shakehand /reload /cpr /dive /showoff /box /tag");
	SendClientMessage(playerid, COLOR_GRAD4, "/goggles /cry /dj /cheer /throw /robbed /hurt /nobreath /bar /getjiggy /fallover /rap /piss");
	SendClientMessage(playerid, COLOR_GRAD5, "/salute /crabs /washhands /signal /stop /gesture /jerkoff /idles /lowrider /carchat");
	SendClientMessage(playerid, COLOR_GRAD6, "/blowjob /spank /sunbathe /kiss /snatch /sneak /copa /sexy /holdup /misc /bodypush /hiker");
	SendClientMessage(playerid, COLOR_GRAD6, "/lowbodypush /headbutt /airkick /doorkick /leftslap /elbow /coprun /seat /angry /shake");
	SendClientMessage(playerid, COLOR_GREEN, "GOI Y: Bam phim F de dung tat ca hanh dong.");
	SendClientMessage(playerid, COLOR_GREEN, "_________________________________________________________________");
	return 1;
}


stock PlayAnim(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
    pLoopAnim[playerid] = true;
	//TextDrawShowForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

stock PlayAnimEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
	gPlayerUsingLoopingAnim[playerid] = 1;
	pLoopAnim[playerid] = true;
//	TextDrawShowForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

stock StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
	pLoopAnim[playerid] = false;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

CMD:office(playerid, params[])
{
    new type;

	if (!CheckAnimation(playerid)) return 1;

	if (sscanf(params, "d", type))
	    return SendClientMessage(playerid, COLOR_GREY,"/office [1-6]");

	if (type < 1 || type > 6)
	    return SendClientMessage(playerid, COLOR_GREY," So ban chon khong hop le.");
	switch (type) {
		case 1: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: PlayAnimEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

// Anim
CMD:bodypush(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
	return 1;
}

CMD:lowbodypush(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
	return 1;
}

CMD:seat(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: PlayAnimEx(playerid, "ped", "SEAT_idle", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "ped", "SEAT_up", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "Attractors", "Stepsit_in", 4.1, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnimEx(playerid, "Attractors", "Stepsit_out", 4.1, 0, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "PED", "SEAT_down", 4.1, 0, 0, 0, 0, 0, 1);
    case 6: PlayAnimEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 0, 0, 1);
    case 7: PlayAnimEx(playerid, "MISC", "SEAT_LR", 4.1, 0, 0, 0, 0, 0, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /seat [1-7]");
    }
    return 1;
}

CMD:angry(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "RIOT", "RIOT_ANGRY", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:shake(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: PlayAnimEx(playerid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /shake [1-3]");
    }
    return 1;
}

CMD:run(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: PlayAnimEx(playerid, "PED", "run_civi", 4.1, 1, 1, 1, 1, 1, 1);
    case 2: PlayAnimEx(playerid, "PED", "run_gang1", 4.1, 1, 1, 1, 1, 1, 1);
    case 3: PlayAnimEx(playerid, "PED", "run_old", 4.1, 1, 1, 1, 1, 1, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /shake [1-3]");
    }
    return 1;
}

CMD:headbutt(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
	return 1;
}

CMD:airkick(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
    
	return 1;
}

CMD:doorkick(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
    
	return 1;
}

CMD:leftslap(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
    
	return 1;
}

CMD:elbow(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
    
	return 1;
}

CMD:coprun(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,1,1,1,1);
    
	return 1;
} //ApplyAnimation(playerid, "SWEET", "LaFin_Sweet", 4.0, 0, 1, 1, 1, 0);

CMD:finc(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"FINALE","FIN_Land_Car",4.1,1,1,1,1,1,1);
	return 1;
}

CMD:finx(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimation(playerid, "SWEET", "LaFin_Sweet", 4.0, 0, 1, 1, 1, 0);
	return 1;
}
// SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);



CMD:dauhang(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    
	return 1;
}

CMD:piss(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
   	SetPlayerSpecialAction(playerid, 68);
   	
	return 1;
}

CMD:sneak(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1, 1);
	
	return 1;
}

CMD:drunk(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
   	PlayAnimEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
   	
    return 1;
}

CMD:bomb(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
   	PlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
   	
    return 1;
}

CMD:rob(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, 1, 1);
	
	return 1;
}

CMD:laugh(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0, 1);
	
	return 1;
}

CMD:lookout(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
   	PlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0, 1);
   	
    return 1;
}

CMD:robman(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:hide(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:vomit(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:eat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:slapass(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:fucku(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	PlayAnim(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:bed(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: PlayAnimEx(playerid, "INT_HOUSE","BED_In_L", 4.1, 0, 1, 1, 1, 0, 1);
        case 2: PlayAnimEx(playerid, "INT_HOUSE","BED_In_R", 4.1, 0, 1, 1, 1, 0, 1);
        case 3: PlayAnimEx(playerid, "INT_HOUSE","BED_Loop_L", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "INT_HOUSE","BED_Loop_R", 4.1, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /bed [1-4]");
    }
    return 1;
}

CMD:gym(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: PlayAnimEx(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
        case 3: PlayAnimEx(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
        case 5: PlayAnimEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
        case 6: PlayAnimEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
        case 7: PlayAnimEx(playerid,"benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /gym [1-7]");
    }
    return 1;
}

CMD:handsup(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
    return 1;
}



CMD:crack(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: PlayAnimEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid,"CRACK", "crckidle1", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid,"CRACK","crckidle3", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid,"CRACK","crckdeth3", 4.0, 0, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /crack [1-4]");
    }
    return 1;
}

CMD:taichi(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:drinkwater(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:tapcig(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0,1);
    
    return 1;
}
CMD:namxuong(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:fallfront(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:checktime(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 0, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
    {
    	case 1: PlayAnimEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
        case 2: PlayAnimEx(playerid, "CRACK", "crckidle4", 4.1, 0, 1, 1, 1, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /sleep [1-2]");
    }
    return 1;
}

CMD:blob(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
    
    return 1;
}

CMD:opendoor(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "AIRPORT", "thrw_barl_thrw", 4.0, 0, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:wavedown(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "BD_FIRE", "BD_Panic_01", 4.0, 0, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:cpr(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "MEDIC", "CPR", 4.0, 0, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:dive(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:showoff(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:goggles(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "goggles", "goggles_put_on", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: PlayAnimEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /cry [1-2]");
    }
    return 1;
}

CMD:throw(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robbed(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "SHP_Rob_GiveCash", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hurt(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:camera1(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CAMERA","camcrch_cmon", 4.0, 1, 0, 0, 1, 0, 1);
    return 1;
}

CMD:box(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:washhands(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crabs(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:salute(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:jerkoff(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:stop(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "endchat_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}


CMD:liftcase(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "MISC", "Case_pickup", 4.0, 0, 0, 0, 0, 0,1);
    return 1;
}
/*

CMD:bye(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "KISSING", 		"BD_GF_Wave", 	4.0, 0, 0, 1, 0, 0);
		case 2: PlayAnimEx(playerid, "ON_LOOKERS", 	"wave_in", 		4.0, 0, 0, 1, 0, 0);
		case 3: PlayAnimEx(playerid, "ON_LOOKERS", 	"wave_loop", 	4.0, 0, 0, 1, 0, 0);
		case 4: PlayAnimEx(playerid, "ON_LOOKERS", 	"wave_out", 	4.0, 0, 0, 1, 0, 0);
		case 5: PlayAnimEx(playerid, "BD_FIRE",		"BD_GF_Wave", 	4.0, 0, 0, 1, 0, 0);
		case 6: PlayAnimEx(playerid, "ped", 			"endchat_01", 	4.0, 0, 0, 1, 0, 0);
		case 7: PlayAnimEx(playerid, "ped", 			"endchat_02", 	4.0, 0, 0, 1, 0, 0);
		case 8: PlayAnimEx(playerid, "ped", 			"endchat_03", 	4.0, 0, 0, 1, 0, 0);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bye [1-8]");
	}
	return 1;
}
*/
CMD:rap(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "RAPPING", "RAP_A_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "RAPPING", "RAP_B_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "RAPPING", "RAP_C_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /rap [1-3]");
	}
	return 1;
}

CMD:chat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
		case 3:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
		case 4: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
		case 5: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
		case 6: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
		case 7:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /chat [1-7]");
	}
	return 1;
}


CMD:gsign(playerid, params[]) {
	return cmd_gesture(playerid, params);
}
CMD:gesture(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "GHANDS", "gsign1", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "GHANDS", "gsign1LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnim(playerid, "GHANDS", "gsign2", 4.0, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnim(playerid, "GHANDS", "gsign2LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnim(playerid, "GHANDS", "gsign3", 4.0, 0, 0, 0, 0, 0, 1);
	case 6: PlayAnim(playerid, "GHANDS", "gsign3LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 7: PlayAnim(playerid, "GHANDS", "gsign4", 4.0, 0, 0, 0, 0, 0, 1);
	case 8: PlayAnim(playerid, "GHANDS", "gsign4LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 9: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
	case 10: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
	case 11: PlayAnim(playerid, "GHANDS", "gsign5LH", 4.0, 0, 0, 0, 0, 0, 1);
	case 12: PlayAnim(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0, 1);
	case 13: PlayAnim(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0, 1);
	case 14: PlayAnim(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 0, 0, 0, 0, 1);
	case 15: PlayAnim(playerid, "GANGS", "smkcig_prtl", 4.0, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /gesture [1-15]");
	}
	return 1;
}

CMD:lay(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid,"BEACH", "parksit_w_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid,"BEACH","parksit_m_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid,"SUNBATHE","Lay_Bac_in",3.0, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid,"SUNBATHE","batherdown",3.0, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid,"SUNBATHE","parksit_m_in",3.0, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid,"CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /lay [1-9]");
	}
	return 1;
}

CMD:wave(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid,"BD_Fire", "BD_GF_Wave", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid,"WUZI", "Wuzi_Follow", 5.0, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /wave [1-5]");
	}
	
	return 1;
}

CMD:signal(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "POLICE", "CopTraf_Come", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /signal [1-2]");
	}
	
	return 1;
}

CMD:nobreath(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /nobreath [1-3]");
	}
	
	return 1;
}

CMD:pedmove(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 9: PlayAnimEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 10: PlayAnimEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 11: PlayAnimEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
	case 12: PlayAnimEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
	case 13: PlayAnimEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 14: PlayAnimEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
	case 15: PlayAnimEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 16: PlayAnimEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 17: PlayAnimEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 18: PlayAnimEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
	case 19: PlayAnimEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 20: PlayAnimEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 21: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 22: PlayAnimEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
	case 23: PlayAnimEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
	case 24: PlayAnimEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
	case 25: PlayAnimEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 26: PlayAnimEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /pedmove [1-26]");
	}
	
	return 1;
}

CMD:getjiggy(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /getjiggy [1-10]");
	}
	
	return 1;
}

CMD:stripclub(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "STRIP", "PUN_CASH", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /stripclub [1-2]");
	}
	
	return 1;
}

CMD:smoke(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "SMOKING", "M_smk_in", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /smoke [1-4]");
	}
	
	return 1;
}

CMD:dj(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dj [1-4]");
	}
	
	return 1;
}

CMD:reload(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /reload [1-2]");
	}
	
	return 1;
}

CMD:tag(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /tag [1-2]");
	}
	
	return 1;
}

CMD:deal(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid,"DEALER","DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid,"DEALER","DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /deal [1-6]");
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1, 1);
	case 2: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /crossarms [1-4]");
	}
	
	return 1;
}

CMD:cheer(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "ON_LOOKERS", "shout_01", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "ON_LOOKERS", "shout_02", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "ON_LOOKERS", "shout_in", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "RIOT", "RIOT_CHANT", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "RIOT", "RIOT_shout", 4.0, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "STRIP", "PUN_HOLLER", 4.0, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "OTB", "wtchrace_win", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /cheer [1-8]");
	}
	
	return 1;
}

CMD:sit(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid,"PED","SEAT_down",4.1,0,1,1,1,0,1);
	case 2: PlayAnimEx(playerid,"MISC","seat_lr",2.0,1,0,0,0,0,1);
	case 3: PlayAnimEx(playerid,"MISC","seat_talk_01",2.0,1,0,0,0,0,1);
	case 4: PlayAnimEx(playerid,"MISC","seat_talk_02",2.0,1,0,0,0,0,1);
	case 5: PlayAnimEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "CRIB", "PED_Console_Loose", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "CRIB", "PED_Console_Win", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /sit [1-6]");
	}
	
	return 1;
}

CMD:siteat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /siteat [1-2]");
	}
	return 1;
}

CMD:bar(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "BAR", "Barcustom_get", 4.0, 0, 1, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnim(playerid, "BAR", "Barserve_give", 4.0, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnim(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "BAR", "BARman_idle", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bar [1-5]");
	}
	
	return 1;
}

CMD:dance(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: SetPlayerSpecialAction(playerid, 5);
	case 2: SetPlayerSpecialAction(playerid, 6);
	case 3: SetPlayerSpecialAction(playerid, 7);
	case 4: SetPlayerSpecialAction(playerid, 8);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dance [1-4]");
	}
	return 1;
}

CMD:hiphop(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "DANCING", "bd_clap",4.0,1,0,0,0,0,1);
	case 2: PlayAnimEx(playerid, "DANCING", "bd_clap1", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 6: PlayAnimEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /hiphop [1-12]");
	}
	return 1;
}


CMD:spank(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "SNM", "SPANKINGP", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /spank [1-4]");
	}
	return 1;
}

CMD:sexy(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SNM","SPANKING_IDLEW", 4.1, 0, 0, 0, 1, 0, 1);
	case 2: PlayAnimEx(playerid, "SNM","SPANKING_IDLEP", 4.1, 0, 0, 0, 1, 0, 1);
	case 3: PlayAnimEx(playerid, "SNM","SPANKINGW", 4.1, 0, 0, 0, 1, 0, 1);
	case 4: PlayAnimEx(playerid, "SNM","SPANKINGP", 4.1, 0, 0, 0, 1, 0, 1);
	case 5: PlayAnimEx(playerid, "SNM","SPANKING_ENDW", 4.1, 0, 0, 0, 1, 0, 1);
	case 6: PlayAnimEx(playerid, "SNM","SPANKING_ENDP", 4.1, 0, 0, 0, 1, 0, 1);
	case 7: PlayAnimEx(playerid, "SNM", "SPANKEDW", 4.1, 0, 0, 0, 1, 0, 1);
	case 8: PlayAnimEx(playerid, "SNM", "SPANKEDP", 4.1, 0, 0, 0, 1, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /sexy [1-8]");
	}
	
	return 1;
}

CMD:cell(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: 
	{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
		pLoopAnim[playerid] = 1;
	}	
	case 2: 
	{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
		pLoopAnim[playerid] = 1;
	}	
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /cell [1-2]");
	}
	
	return 1;
}

CMD:win(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "CASINO","cards_win", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /win [1-2]");
	}
	
	return 1;
}

CMD:celebrate(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "benchpress","gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: PlayAnimEx(playerid, "GYMNASIUM","gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /celebrate [1-2]");
	}
	
	return 1;
}

CMD:leanon(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid,  "GANGS", "leanIDLE", 4.0, 1, 0, 0, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "MISC", "Plyrlean_loop", 4.0, 1, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /celebrate [1-2]");
	}
	
	return 1;
}

CMD:holdup(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "POOL", "POOL_Long_Start", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "POOL", "POOL_Med_Shot", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "POOL", "POOL_Med_Start", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /holdup [1-5]");
	}
	
	return 1;
}

CMD:copa(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnim(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnim(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnimEx(playerid, "POLICE", "Cop_move_FWD", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 0, 0, 1, 5000, 1);
	case 7: PlayAnim(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnim(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 5000, 1);
	case 9: PlayAnim(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /copa [1-9]");
	}
	
	return 1;
}
CMD:hiker(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
	{
         case 1: PlayAnimEx(playerid, "MISC", "Hiker_Pose_L", 4.0, 0, 1, 1, 1, 0, 1);
         case 2: PlayAnimEx(playerid,"MISC","Hiker_Pose", 4.0, 1, 0, 0, 0, 0, 1);
         default: SendClientMessage(playerid, COLOR_GREY, " HIND: /hiker [1-2]");
    }     
	return 1;
}

CMD:snatch(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "PED", "BIKE_elbowL", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "PED", "BIKE_elbowR", 4.1, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /snatch [1-2]");
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	case 4: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /blowjob [1-4]");
	}
	
	return 1;
}

CMD:kiss(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnim(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
	case 5: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
	case 6: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /kiss [1-6]");
	}
	return 1;
}

CMD:idles(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "PLAYIDLES", "shift", 4.1, 1, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "PLAYIDLES", "shldr", 4.1, 1, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "PLAYIDLES", "strleg", 4.1, 1, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "PLAYIDLES", "time", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 7: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 8: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0, 1);
	case 9: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0, 1);
	case 10: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 1, 0, 0, 0, 0, 1);
	case 11: PlayAnimEx(playerid, "PED", "roadcross", 4.1, 1, 0, 0, 0, 0, 1);
	case 12: PlayAnimEx(playerid, "PED", "roadcross_female", 4.1, 1, 0, 0, 0, 0, 1);
	case 13: PlayAnimEx(playerid, "PED", "roadcross_gang", 4.1, 1, 0, 0, 0, 0, 1);
	case 14: PlayAnimEx(playerid, "PED", "roadcross_old", 4.1, 1, 0, 0, 0, 0, 1);
	case 15: PlayAnimEx(playerid, "PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /idles [1-15]");
	}
	
	return 1;
}

CMD:sunbathe(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnimEx(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: PlayAnimEx(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 6: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 9: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 10: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 11: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 12: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 13: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 14: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 15: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);
	case 16: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);
	case 17: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);
	case 18: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /sunbathe [1-18]");
	}
	return 1;
}

CMD:lowrider(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	if(IsCLowrider(GetPlayerVehicleID(playerid)))
	{
		switch(strval(params))
		{
		case 1: PlayAnim(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnim(playerid, "LOWRIDER", "lrgirl_hair", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: PlayAnim(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: PlayAnim(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: PlayAnim(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: PlayAnim(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: PlayAnim(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 19: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, 0, 1, 1, 1, 1, 1);
		case 20: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 21: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 22: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, 0, 1, 1, 1, 1, 1);
		case 23: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, 0, 1, 1, 1, 1, 1);
		case 24: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 25: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);
		case 26: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, 0, 1, 1, 1, 1, 1);
		case 27: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);
		case 28: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);
		case 29: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);
		case 30: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);
		case 31: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /lowrider [1-31]");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{ffffff} Phuong tien nay khong the dung lenh.");
	}
	return 1;
}

CMD:carchat(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnim(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: PlayAnim(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BL", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 19: PlayAnim(playerid, "CAR", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);
		//case 20: PlayAnim(playerid, "CAR", "Tap_hand", 4.1, 1, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /carchat [1-19]");
	}
	
	return 1;
}
stock CheckAnimation(playerid)
{
  //  if(HandCuff[playerid] != 0 || ChonHang[playerid] != 0 || ThuHoachGo[playerid] != 0 || DangKhaiThac[playerid] != -1 || DangDonGo[playerid] != -1 || GetPlayerAnimationIndex(playerid) == 1130 || GetPlayerAnimationIndex(playerid) == 1195 || DangBiTazer[playerid] != 0 || VCHang[playerid] != 0 || LayHangJob[playerid] == 1 || DangBiDanh[playerid] == 1 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 || DangBiThuong[playerid] == 1 || BiBeanBag[playerid] == 1)
   // if(HandCuff[playerid] != 0 || ChonHang[playerid] != 0 || ThuHoachGo[playerid] != 0 || DangKhaiThac[playerid] != 0 || DangDonGo[playerid] != -1 || GetPlayerAnimationIndex(playerid) == 1130 || GetPlayerAnimationIndex(playerid) == 1195 || DangBiTazer[playerid] != 0 || VCHang[playerid] != 0 || LayHangJob[playerid] == 1 || DangBiDanh[playerid] == 1 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 || DangBiThuong[playerid] == 1 || BiBeanBag[playerid] == 1)
    if(HandCuff[playerid] != 0  || GetPlayerAnimationIndex(playerid) == 1130 || GetPlayerAnimationIndex(playerid) == 1195 || PlayerCuffed[playerid] != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 )
	{
   		SendClientMessage(playerid, COLOR_GRAD2, " Ban khong the lam vao thoi diem nay.");
   		return 0;
	}
    if(IsPlayerInAnyVehicle(playerid) == 1)
    {
		SendClientMessage(playerid, COLOR_GRAD2, " Ban khong the lam viec nay khi dang o tren mot chiec xe.");
		return 0;
	}
	return 1;
}
IsAbleVehicleAnimation(playerid)
{
    if(HandCuff[playerid] == 1 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 || GetPVarInt(playerid, "Injured") == 1)
	{
   		SendClientMessage(playerid, COLOR_GRAD2, " Ban khong the lam vao thoi diem nay.");
   		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0)
    {
		SendClientMessage(playerid, COLOR_GRAD2, "doi hoi ban phai duoc ben trong 1 chiec xe.");
		return 0;
	}
	return 1;
}
IsCLowrider(carid)
{
	new Cars[] = { 536, 575, 567};
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}
