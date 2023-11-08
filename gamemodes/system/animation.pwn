

new pLoopAnim[MAX_PLAYERS];
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
CMD:hanhdong(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "_________________________________________________________________");
	SendClientMessage(playerid, COLOR_GRAD1, "/airport /attractors /bar /baseball /bdfire /benchpress /bomber /box /bsktball /animbuddy /animbus /camera /animcar");
	SendClientMessage(playerid, COLOR_GRAD2, "/animcarry /carchat /animcasino /chainsaw /animclothes /coach /animcolt /copambient /crack /crib /damjump /paulnmac");
	SendClientMessage(playerid, COLOR_GRAD3, "/dealer /dildo /dodge /fightb /fightc /fightd /fighte /finale /flame /flowers /food /freeweights");
	SendClientMessage(playerid, COLOR_GRAD4, "/animgangs /ghands /ghettodb /graffity /goggles /greya /grenade /animgym /haircut /heist /inthouse /intoffic /intshop");
	SendClientMessage(playerid, COLOR_GRAD5, "/jst /kissing /animknife /lowrider /mdchase /cpr /misc /musculcar /onlookers /otb");
	SendClientMessage(playerid, COLOR_GRAD6, "/animuzi /otb /ped /animuzi /wayfarer /police /animpool /python /wuzi /animrifle /riot /ryder");
	SendClientMessage(playerid, COLOR_GRAD6, "/animsword /animshop /animshotgun /animsilenced /animtec /animsniper /stripclub /train /animswat /animsweet");
	SendClientMessage(playerid, COLOR_GREEN, "GOI Y: Bam phim Space de dung tat ca hanh dong.");
	SendClientMessage(playerid, COLOR_GREEN, "_________________________________________________________________");
	return 1;
}


stock PlayAnim(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
    pLoopAnim[playerid] = true;
	//TextDrawShowForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
	gPlayerUsingLoopingAnim[playerid] = 1;
	pLoopAnim[playerid] = true;
//	TextDrawShowForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	SendClientTextDraw(playerid,"Su dung nut ~y~SPACE~w~ de dung hanh dong.");
}

stock StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
	pLoopAnim[playerid] = false;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

// Anim
CMD:airport(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "AIRPORT", "thrw_barl_thrw", 4.0, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:attractors(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: PlayAnim(playerid, "Attractors", "Stepsit_in", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "Attractors", "Stepsit_loop", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "Attractors", "Stepsit_out", 4.0, 1, 0, 0, 0, 0, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /attractors [1-3]");
    }
    return 1;
}

CMD:bar(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BAR", "Barcustom_get", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BAR", "Barcustom_order", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BAR", "Barserve_bottle", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BAR", "Barserve_give", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "BAR", "Barserve_glass", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "BAR", "Barserve_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "BAR", "Barserve_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "BAR", "Barserve_order", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "BAR", "dnk_stndM_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bar [1 - 11]");
        }
    return 1;
}

CMD:baseball(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BASEBALL", "Bat_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BASEBALL", "Bat_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BASEBALL", "Bat_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BASEBALL", "Bat_4", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "BASEBALL", "Bat_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "BASEBALL", "Bat_Hit_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "BASEBALL", "Bat_Hit_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "BASEBALL", "Bat_Hit_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "BASEBALL", "Bat_M", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "BASEBALL", "BAT_PART", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /baseball [1 - 11]");
        }
    return 1;
}

CMD:bdfire(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BD_FIRE", "BD_GF_Wave", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BD_FIRE", "BD_Panic_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BD_FIRE", "BD_Panic_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BD_FIRE", "BD_Panic_03", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "BD_FIRE", "BD_Panic_04", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "BD_FIRE", "BD_Panic_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "BD_FIRE", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "BD_FIRE", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "BD_FIRE", "Playa_Kiss_03", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bdfire [1 - 10]");
        }
    return 1;
}

CMD:beach(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "BEACH", "BD_Fire3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /beach [1 - 5]");
        }
    return 1;
}

CMD:benchpress(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "benchpress", "gym_bp_getoff", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "benchpress", "gym_bp_geton", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /benchpress [1 - 7]");
        }
    return 1;
}

CMD:bomber(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BOMBER", "BOM_Plant_2Idle", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BOMBER", "BOM_Plant_Crouch_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "BOMBER", "BOM_Plant_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bomber [1 - 6]");
        }
    return 1;
}

CMD:box(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BOX", "boxhipin", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BOX", "boxhipup", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BOX", "boxshdwn", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BOX", "boxshup", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "BOX", "bxhipwlk", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "BOX", "bxshwlk", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "BOX", "catch_box", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /box [1 - 7]");
        }
    return 1;
}

CMD:bsktball(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BSKTBALL", "BBALL_def_jump_shot", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_def_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_idle", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_idle2", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_idleloop", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "BSKTBALL", "BBALL_react_miss", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "BSKTBALL", "BBALL_react_score", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_walk", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bsktball [1 - 10]");
        }
    return 1;
}

CMD:animbuddy(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BUDDY", "buddy_crouchfire", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "BUDDY", "buddy_crouchreload", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "BUDDY", "buddy_fire", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "BUDDY", "buddy_fire_poor", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "BUDDY", "buddy_reload", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animbuddy [1 - 5]");
        }
    return 1;
}

CMD:animbus(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "BUS", "BUS_open_RHS", 4.0, 1, 0, 0, 0, 0, 1);
    
	return 1;
}

CMD:camera(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "CAMERA", "camcrch_cmon", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "CAMERA", "camcrch_idleloop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CAMERA", "camcrch_to_camstnd", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CAMERA", "camstnd_cmon", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "CAMERA", "camstnd_idleloop", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "CAMERA", "camstnd_lkabt", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CAMERA", "camstnd_to_camcrch", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "CAMERA", "piccrch_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "CAMERA", "piccrch_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "CAMERA", "piccrch_take", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "CAMERA", "picstnd_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "CAMERA", "picstnd_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: ApplyAnimationEx(playerid, "CAMERA", "picstnd_take", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /camera [1 - 13]");
        }
    return 1;
}

CMD:animcar(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "CAR", "Fixn_Car_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CAR", "flag_drop", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.0, 1, 0, 0, 0, 0, 1);
			case 6: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CAR_CHAT", "car_talkm_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "CAR_CHAT", "car_talkm_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "CAR_CHAT", "car_talkm_out", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /car [1 - 9]");
        }
    return 1;
}

CMD:animcarry(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "CARRY", "liftup", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CARRY", "liftup05", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CARRY", "liftup105", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CARRY", "putdwn", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "CARRY", "putdwn05", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CARRY", "putdwn105", 4.0, 1, 0, 0, 0, 0, 1);
            default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /carry [1 - 3]");
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
		case 20: PlayAnim(playerid, "PED", "CAR_sit", 4.1, 0, 1, 1, 1, 1, 1); 
        case 21: PlayAnim(playerid, "PED", "CAR_sitp", 4.1, 0, 1, 1, 1, 1, 1); 
        case 22: PlayAnim(playerid, "PED", "CAR_sitpLO", 4.1, 0, 1, 1, 1, 1, 1); 
        case 23: PlayAnim(playerid, "PED", "CAR_sit_pro", 4.1, 0, 1, 1, 1, 1, 1); 
        case 24: PlayAnim(playerid, "PED", "CAR_sit_weak", 4.1, 0, 1, 1, 1, 1, 1);
        case 25: PlayAnim(playerid, "PED", "CAR_tune_radio", 4.1, 0, 1, 1, 1, 1, 1);
        default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /carchat [1 - 25]");
    }
    return 1;
}

CMD:animcasino(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
		{
            case 1: PlayAnim(playerid, "CASINO", "cards_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "CASINO", "cards_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CASINO", "cards_lose", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CASINO", "cards_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CASINO", "cards_pick_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "CASINO", "cards_pick_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CASINO", "cards_raise", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "CASINO", "cards_win", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "CASINO", "dealone", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "CASINO", "manwinb", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "CASINO", "manwind", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "CASINO", "Roulette_bet", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "CASINO", "Roulette_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: PlayAnim(playerid, "CASINO", "Roulette_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "CASINO", "Roulette_lose", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: PlayAnim(playerid, "CASINO", "Roulette_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: PlayAnim(playerid, "CASINO", "Roulette_win", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: PlayAnim(playerid, "CASINO", "Slot_bet_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: PlayAnim(playerid, "CASINO", "Slot_bet_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: PlayAnim(playerid, "CASINO", "Slot_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 21: PlayAnim(playerid, "CASINO", "Slot_lose_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 22: PlayAnim(playerid, "CASINO", "Slot_Plyr", 4.0, 1, 0, 0, 0, 0, 1);
            case 23: PlayAnim(playerid, "CASINO", "Slot_wait", 4.0, 1, 0, 0, 0, 0, 1);
            case 24: PlayAnim(playerid, "CASINO", "Slot_win_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 25: PlayAnim(playerid, "CASINO", "wof", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /casino [1 - 25]");
        }
    return 1;
}

CMD:chainsaw(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "CHAINSAW", "CSAW_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "CHAINSAW", "CSAW_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CHAINSAW", "CSAW_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "CHAINSAW", "CSAW_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CHAINSAW", "CSAW_Hit_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "CHAINSAW", "CSAW_Hit_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CHAINSAW", "CSAW_Hit_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "CHAINSAW", "csaw_part", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "CHAINSAW", "IDLE_csaw", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "CHAINSAW", "WEAPON_csaw", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "CHAINSAW", "WEAPON_csawlo", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /chainsaw [1 - 11]");
        }
    return 1;
}

CMD:animclothes(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "CLOTHES", "CLO_Buy", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "CLOTHES", "CLO_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CLOTHES", "CLO_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Hat", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CLOTHES", "CLO_Pose_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Legs", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Shoes", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Torso", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "CLOTHES", "CLO_Pose_Watch", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animclothes [1 - 12]");
        }
    return 1;
}

CMD:coach(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "COACH", "COACH_opnL", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "COACH", "COACH_opnR", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /coach [1 - 2]");
        }
    return 1;
}

CMD:animcolt(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "COLT45", "2guns_crouchfire", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "COLT45", "colt45_crouchfire", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "COLT45", "colt45_crouchreload", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "COLT45", "colt45_fire", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "COLT45", "colt45_fire_2hands", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "COLT45", "colt45_reload", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "COLT45", "sawnoff_reload", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animcolt [1 - 7]");
        }
    return 1;
}

CMD:copambient(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "COP_AMBIENT", "Copbrowse_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_nod", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "COP_AMBIENT", "Copbrowse_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_shake", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "COP_AMBIENT", "Coplook_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_nod", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_think", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /copambient [1 - 11]");
        }
    return 1;
}

CMD:crack(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "CRACK", "Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "CRACK", "Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "CRACK", "crckdeth1", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "CRACK", "crckdeth3", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "CRACK", "crckdeth4", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /crack [1 - 10]");
        }
    return 1;
}

CMD:crib(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "CRIB", "CRIB_Use_Switch", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loose", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "CRIB", "PED_Console_Win", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /crib [1 - 4]");
        }
    return 1;
}

CMD:damjump(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	ApplyAnimationEx(playerid, "DAM_JUMP", "DAM_Dive_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    
	return 1;
}

CMD:dancing(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "DANCING", "bd_clap", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "DANCING", "bd_clap1", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: ApplyAnimationEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dancing [1 - 13]");
        }
    return 1;
}

CMD:dealer(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "DEALER", "DRUGS_BUY", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "DEALER", "shop_pay", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dealer [1 - 7]");
        }
    return 1;
}

CMD:dildo(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "DILDO", "DILDO_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "DILDO", "DILDO_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "DILDO", "DILDO_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "DILDO", "DILDO_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "DILDO", "DILDO_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "DILDO", "DILDO_Hit_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "DILDO", "DILDO_Hit_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "DILDO", "DILDO_Hit_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "DILDO", "DILDO_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dildo [1 - 9]");
        }
    return 1;
}

CMD:dodge(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    
	return 1;
}

CMD:fightb(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "FIGHT_B", "FightB_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "FIGHT_B", "FightB_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "FIGHT_B", "FightB_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "FIGHT_B", "FightB_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "FIGHT_B", "FightB_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "FIGHT_B", "FightB_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "FIGHT_B", "FightB_M", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "FIGHT_B", "HitB_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "FIGHT_B", "HitB_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "FIGHT_B", "HitB_3", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /fightb [1 - 10]");
        }
    return 1;
}

CMD:fightc(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "FIGHT_C", "FightC_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "FIGHT_C", "FightC_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "FIGHT_C", "FightC_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "FIGHT_C", "FightC_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "FIGHT_C", "FightC_blocking", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "FIGHT_C", "FightC_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "FIGHT_C", "FightC_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "FIGHT_C", "FightC_M", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "FIGHT_C", "FightC_Spar", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "FIGHT_C", "HitC_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "FIGHT_C", "HitC_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "FIGHT_C", "HitC_3", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /fightc [1 - 12]");
        }
    return 1;
}

CMD:fightd(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "FIGHT_D", "FightD_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "FIGHT_D", "FightD_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "FIGHT_D", "FightD_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "FIGHT_D", "FightD_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "FIGHT_D", "FightD_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "FIGHT_D", "FightD_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "FIGHT_D", "FightD_M", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "FIGHT_D", "HitD_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "FIGHT_D", "HitD_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "FIGHT_D", "HitD_3", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /fightd [1 - 10]");
        }
    return 1;
}

CMD:fighte(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
         {
            case 1: PlayAnim(playerid, "FIGHT_E", "FightKick", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "FIGHT_E", "FightKick_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "FIGHT_E", "Hit_fightkick", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "FIGHT_E", "Hit_fightkick_B", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /fighte [1 - 4]");
        }
    return 1;
}

CMD:finale(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "FINALE", "FIN_Cop1_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "FINALE", "FIN_Cop1_Stomp", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "FINALE", "FIN_Land_Die", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "FINALE", "FIN_LegsUp_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /finale [1 - 4]");
        }
    return 1;
}

CMD:flame(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	ApplyAnimationEx(playerid, "FLAME", "FLAME_fire", 4.0, 1, 0, 0, 0, 0, 1);    
	return 1;
}

CMD:flowers(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "Flowers", "Flower_attack", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "Flowers", "Flower_attack_M", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "Flowers", "Flower_Hit", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /flowers [1 - 3]");
        }
    return 1;
}

CMD:food(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "FOOD", "EAT_Chicken", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "FOOD", "EAT_Pizza", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "FOOD", "EAT_Vomit_P", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "FOOD", "EAT_Vomit_SK", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "FOOD", "FF_Dam_Bkw", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "FOOD", "FF_Dam_Fwd", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "FOOD", "FF_Dam_Left", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "FOOD", "FF_Dam_Right", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "FOOD", "FF_Die_Bkw", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "FOOD", "FF_Die_Fwd", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "FOOD", "FF_Die_Left", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "FOOD", "FF_Die_Right", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat1", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: PlayAnim(playerid, "FOOD", "FF_Sit_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: PlayAnim(playerid, "FOOD", "FF_Sit_In_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: PlayAnim(playerid, "FOOD", "FF_Sit_In_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Look", 4.0, 1, 0, 0, 0, 0, 1);
            case 21: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 22: PlayAnim(playerid, "FOOD", "FF_Sit_Out_180", 4.0, 1, 0, 0, 0, 0, 1);
            case 23: PlayAnim(playerid, "FOOD", "FF_Sit_Out_L_180", 4.0, 1, 0, 0, 0, 0, 1);
            case 24: PlayAnim(playerid, "FOOD", "FF_Sit_Out_R_180", 4.0, 1, 0, 0, 0, 0, 1);
            case 25: PlayAnim(playerid, "FOOD", "SHP_Thank", 4.0, 1, 0, 0, 0, 0, 1);
            case 26: PlayAnim(playerid, "FOOD", "SHP_Tray_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 27: PlayAnim(playerid, "FOOD", "SHP_Tray_Lift", 4.0, 1, 0, 0, 0, 0, 1);
            case 28: PlayAnim(playerid, "FOOD", "SHP_Tray_Lift_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 29: PlayAnim(playerid, "FOOD", "SHP_Tray_Lift_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 30: PlayAnim(playerid, "FOOD", "SHP_Tray_Lift_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 31: PlayAnim(playerid, "FOOD", "SHP_Tray_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 32: PlayAnim(playerid, "FOOD", "SHP_Tray_Pose", 4.0, 1, 0, 0, 0, 0, 1);
            case 33: PlayAnim(playerid, "FOOD", "SHP_Tray_Return", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /food [1 - 33]");
        }
    return 1;
}

CMD:freeweights(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 2: ApplyAnimationEx(playerid, "Freeweights", "gym_free_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "Freeweights", "gym_free_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "Freeweights", "gym_free_down", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "Freeweights", "gym_free_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "Freeweights", "gym_free_pickup", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "Freeweights", "gym_free_putdown", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "Freeweights", "gym_free_up_smooth", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /freeweights [1 - 9]");
        }
    return 1;
}

CMD:animgangs(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "GANGS", "DEALER_DEAL", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "GANGS", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "GANGS", "drnkbr_prtl", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "GANGS", "drnkbr_prtl_F", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "GANGS", "DRUGS_BUY", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "GANGS", "hndshkaa", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "GANGS", "hndshkba", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "GANGS", "hndshkca", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "GANGS", "hndshkcb", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "GANGS", "hndshkda", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "GANGS", "hndshkea", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "GANGS", "hndshkfa", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "GANGS", "hndshkfa_swt", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: PlayAnim(playerid, "GANGS", "Invite_No", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "GANGS", "Invite_Yes", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: ApplyAnimationEx(playerid, "GANGS", "leanIDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: PlayAnim(playerid, "GANGS", "leanIN", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkCt", 4.0, 1, 0, 0, 0, 0, 1);
            case 21: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkD", 4.0, 1, 0, 0, 0, 0, 1);
            case 22: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
            case 23: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
            case 24: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
            case 25: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
            case 26: PlayAnim(playerid, "GANGS", "prtial_hndshk_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 27: PlayAnim(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 28: PlayAnim(playerid, "GANGS", "shake_cara", 4.0, 1, 0, 0, 0, 0, 1);
            case 29: PlayAnim(playerid, "GANGS", "shake_carK", 4.0, 1, 0, 0, 0, 0, 1);
            case 30: PlayAnim(playerid, "GANGS", "shake_carSH", 4.0, 1, 0, 0, 0, 0, 1);
            case 31: PlayAnim(playerid, "GANGS", "smkcig_prtl", 4.0, 1, 0, 0, 0, 0, 1);
            case 32: PlayAnim(playerid, "GANGS", "smkcig_prtl_F", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animgangs [1 - 32]");
        }
    return 1;
}

CMD:ghands(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
        {
            case 1: PlayAnim(playerid, "GHANDS", "gsign1", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "GHANDS", "gsign1LH", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "GHANDS", "gsign2", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "GHANDS", "gsign2LH", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "GHANDS", "gsign3", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "GHANDS", "gsign3LH", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "GHANDS", "gsign4", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "GHANDS", "gsign4LH", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "GHANDS", "gsign5LH", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "GHANDS", "LHGsign1", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "GHANDS", "LHGsign2", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "GHANDS", "LHGsign3", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: PlayAnim(playerid, "GHANDS", "LHGsign4", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "GHANDS", "LHGsign5", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: PlayAnim(playerid, "GHANDS", "RHGsign1", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: PlayAnim(playerid, "GHANDS", "RHGsign2", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: PlayAnim(playerid, "GHANDS", "RHGsign3", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: PlayAnim(playerid, "GHANDS", "RHGsign4", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: PlayAnim(playerid, "GHANDS", "RHGsign5", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /ghands [1 - 20]");
        }
    return 1;
}

CMD:ghettodb(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car2_PLY", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car2_SMO", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car2_SWE", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car_PLY", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car_RYD", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car_SMO", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "GHETTO_DB", "GDB_Car_SWE", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /ghettodb [1 - 7]");
        }
	
	return 1;
}

CMD:graffity(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /graffity [1 - 2]");
        }
	
	return 1;
}

CMD:goggles(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	PlayAnim(playerid, "goggles", "goggles_put_on", 4.0, 1, 0, 0, 0, 0, 1);    
	return 1;
}

CMD:greya(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /greya [1 - 3]");
        }
	
	return 1;
}

CMD:grenade(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "GRENADE", "WEAPON_throwu", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /grenade [1 - 2]");
        }
	
	return 1;
}

CMD:animgym(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "GYMNASIUM", "gym_jog_falloff", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_shadowbox", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "GYMNASIUM", "gym_tread_geton", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_jog", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_sprint", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_tired", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: ApplyAnimationEx(playerid, "GYMNASIUM", "gym_tread_walk", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: PlayAnim(playerid, "GYMNASIUM", "gym_walk_falloff", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animgym [1 - 2]");
            }
	
	return 1;
}

CMD:haircut(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Beard_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Buy", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Cut", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "HAIRCUTS", "BRB_Cut_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "HAIRCUTS", "BRB_Cut_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Hair_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Hair_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Sit_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "HAIRCUTS", "BRB_Sit_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_Sit_Out", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /haircut [1 - 10]");
        }
	
	return 1;
}

CMD:heist(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "HEIST9", "CAS_G2_GasKO", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "HEIST9", "swt_wllpk_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "HEIST9", "swt_wllpk_L_back", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "HEIST9", "swt_wllpk_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "HEIST9", "swt_wllpk_R_back", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "HEIST9", "swt_wllshoot_in_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "HEIST9", "swt_wllshoot_in_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "HEIST9", "swt_wllshoot_out_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "HEIST9", "swt_wllshoot_out_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "HEIST9", "Use_SwipeCard", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /heist [1 - 10]");
        }
	
	return 1;
}

CMD:inthouse(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "INT_HOUSE", "BED_In_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "INT_HOUSE", "BED_In_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "INT_HOUSE", "BED_Loop_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "INT_HOUSE", "BED_Out_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "INT_HOUSE", "BED_Out_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "INT_HOUSE", "LOU_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "INT_HOUSE", "LOU_Out", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "INT_HOUSE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /inthouse [1 - 10]");
        }
	return 1;
}

CMD:intoffice(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "INT_OFFICE", "FF_Dam_Fwd", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "INT_OFFICE", "OFF_Sit_2Idle_180", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Idle_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "INT_OFFICE", "OFF_Sit_In", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /intoffice [1 - 10]");
        }
	return 1;
}

CMD:intshop(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "INT_SHOP", "shop_cashier", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "INT_SHOP", "shop_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "INT_SHOP", "shop_lookA", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "INT_SHOP", "shop_lookB", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "INT_SHOP", "shop_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "INT_SHOP", "shop_pay", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "INT_SHOP", "shop_shelf", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /intshop [1 - 7]");
        }
	return 1;
}

CMD:jst(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	ApplyAnimationEx(playerid, "JST_BUISNESS", "girl_02", 4.0, 1, 0, 0, 0, 0, 1);	
	return 1;
}

CMD:kissing(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "KISSING", "BD_GF_Wave", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "KISSING", "GF_CarArgue_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "KISSING", "GF_CarArgue_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "KISSING", "GF_CarSpot", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "KISSING", "GF_StreetArgue_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "KISSING", "GF_StreetArgue_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "KISSING", "gift_get", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "KISSING", "gift_give", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "KISSING", "Playa_Kiss_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: PlayAnim(playerid, "KISSING", "Playa_Kiss_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "KISSING", "Playa_Kiss_03", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /kissing [1 - 15]");
        }
	return 1;
}

CMD:animknife(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "KNIFE", "KILL_Knife_Player", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "KNIFE", "KILL_Partial", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "KNIFE", "knife_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "KNIFE", "knife_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "KNIFE", "knife_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "KNIFE", "knife_4", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "KNIFE", "knife_block", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "KNIFE", "Knife_G", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "KNIFE", "knife_hit_1", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "KNIFE", "knife_hit_2", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "KNIFE", "knife_hit_3", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: ApplyAnimationEx(playerid, "KNIFE", "knife_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: ApplyAnimationEx(playerid, "KNIFE", "knife_part", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: ApplyAnimationEx(playerid, "KNIFE", "WEAPON_knifeidle", 4.0, 1, 0, 0, 0, 0, 1);
        	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animknife [1 - 16]");
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

CMD:mdchase(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "MD_CHASE", "MD_BIKE_Lnd_Roll", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "MD_CHASE", "MD_BIKE_Lnd_Roll_F", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /mdchase [1-2]");
        }
	return 1;
}

CMD:cpr(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "MEDIC", "CPR", 4.0, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:misc(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "MISC", "bitchslap", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "MISC", "BMX_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "MISC", "BMX_comeon", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "MISC", "bmx_idleloop_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: PlayAnim(playerid, "MISC", "bmx_idleloop_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: PlayAnim(playerid, "MISC", "bmx_talkleft_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "MISC", "bmx_talkleft_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: PlayAnim(playerid, "MISC", "bmx_talkleft_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "MISC", "bmx_talkright_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: PlayAnim(playerid, "MISC", "bmx_talkright_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: PlayAnim(playerid, "MISC", "bmx_talkright_out", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: PlayAnim(playerid, "MISC", "bng_wndw", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: PlayAnim(playerid, "MISC", "bng_wndw_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: PlayAnim(playerid, "MISC", "Case_pickup", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: PlayAnim(playerid, "MISC", "GRAB_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: PlayAnim(playerid, "MISC", "GRAB_R", 4.0, 1, 0, 0, 0, 0, 1);
            case 17: ApplyAnimationEx(playerid, "MISC", "Hiker_Pose", 4.0, 1, 0, 0, 0, 0, 1);
            case 18: ApplyAnimationEx(playerid, "MISC", "Hiker_Pose_L", 4.0, 1, 0, 0, 0, 0, 1);
            case 19: ApplyAnimationEx(playerid, "MISC", "Idle_Chat_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 20: PlayAnim(playerid, "MISC", "KAT_Throw_K", 4.0, 1, 0, 0, 0, 0, 1);
            case 21: PlayAnim(playerid, "MISC", "KAT_Throw_P", 4.0, 1, 0, 0, 0, 0, 1);
            case 22: PlayAnim(playerid, "MISC", "PASS_Rifle_Ped", 4.0, 1, 0, 0, 0, 0, 1);
            case 23: PlayAnim(playerid, "MISC", "PASS_Rifle_Ply", 4.0, 1, 0, 0, 0, 0, 1);
            case 24: PlayAnim(playerid, "MISC", "pickup_box", 4.0, 1, 0, 0, 0, 0, 1);
            case 25: PlayAnim(playerid, "MISC", "Plunger_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 26: ApplyAnimationEx(playerid, "MISC", "Plyrlean_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 27: PlayAnim(playerid, "MISC", "plyr_shkhead", 4.0, 1, 0, 0, 0, 0, 1);
            case 28: PlayAnim(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 29: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.0, 1, 0, 0, 0, 0, 1);
            case 30: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 31: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 32: ApplyAnimationEx(playerid, "MISC", "SEAT_watch", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /misc [1-32]");
        }
	return 1;
}

CMD:musculcar(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleIdle_armed", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleIdle_Csaw", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleIdle_rocket", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /musculcar [1-3]");
        }
	return 1;
}

CMD:onlookers(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "ON_LOOKERS", "lkaround_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "ON_LOOKERS", "lkup_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "lkup_point", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_cower", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_hide", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_point", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "ON_LOOKERS", "panic_shout", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 10: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_shout", 4.0, 1, 0, 0, 0, 0, 1);
            case 11: ApplyAnimationEx(playerid, "ON_LOOKERS", "point_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 12: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_01", 4.0, 1, 0, 0, 0, 0, 1);
            case 13: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_02", 4.0, 1, 0, 0, 0, 0, 1);
            case 14: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 15: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 16: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /onlookers [1-16]");
        }
	return 1;
}

CMD:otb(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "OTB", "betslp_lkabt", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: ApplyAnimationEx(playerid, "OTB", "betslp_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: ApplyAnimationEx(playerid, "OTB", "betslp_tnk", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "OTB", "wtchrace_cmon", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "OTB", "wtchrace_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "OTB", "wtchrace_lose", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: ApplyAnimationEx(playerid, "OTB", "wtchrace_win", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /otb [1-7]");
        }
	return 1;
}

CMD:taichi(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:paulnmac(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "PAULNMAC", "PnM_Argue1_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 2: PlayAnim(playerid, "PAULNMAC", "PnM_Argue1_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 3: PlayAnim(playerid, "PAULNMAC", "PnM_Argue2_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 4: PlayAnim(playerid, "PAULNMAC", "PnM_Argue2_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 5: ApplyAnimationEx(playerid, "PAULNMAC", "PnM_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
            case 6: ApplyAnimationEx(playerid, "PAULNMAC", "PnM_Loop_B", 4.0, 1, 0, 0, 0, 0, 1);
            case 7: PlayAnim(playerid, "PAULNMAC", "wank_in", 4.0, 1, 0, 0, 0, 0, 1);
            case 8: ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0, 1);
            case 9: PlayAnim(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /paulnmac [1-9]");
        }
	return 1;
}

CMD:ped(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "PED", "abseil", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "PED", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "PED", "ATM", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "PED", "BIKE_elbowL", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "PED", "BIKE_elbowR", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: PlayAnim(playerid, "PED", "BIKE_pickupL", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: PlayAnim(playerid, "PED", "BIKE_pickupR", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: PlayAnim(playerid, "PED", "BIKE_pullupL", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: PlayAnim(playerid, "PED", "BIKE_pullupR", 4.1, 0, 1, 1, 1, 1, 1);
            case 11: PlayAnim(playerid, "PED", "bomber", 4.1, 0, 1, 1, 1, 1, 1);
            case 12: PlayAnim(playerid, "PED", "CAR_close_LHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 13: PlayAnim(playerid, "PED", "CAR_close_RHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 14: PlayAnim(playerid, "PED", "CAR_crawloutRHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 15: PlayAnim(playerid, "PED", "CAR_doorlocked_LHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 16: PlayAnim(playerid, "PED", "CAR_doorlocked_RHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 17: PlayAnim(playerid, "PED", "CAR_pulloutL_LHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 18: PlayAnim(playerid, "PED", "CAR_pulloutL_RHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 19: PlayAnim(playerid, "PED", "CAR_pullout_LHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 20: PlayAnim(playerid, "PED", "CAR_pullout_RHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 21: ApplyAnimationEx(playerid, "PED", "CLIMB_idle", 4.1, 0, 1, 1, 1, 1, 1);
            case 22: PlayAnim(playerid, "PED", "CLIMB_jump", 4.1, 0, 1, 1, 1, 1, 1);
            case 23: PlayAnim(playerid, "PED", "CLIMB_jump2fall", 4.1, 0, 1, 1, 1, 1, 1);
            case 24: ApplyAnimationEx(playerid, "PED", "cower", 4.1, 0, 1, 1, 1, 1, 1);
            case 25: ApplyAnimationEx(playerid, "PED", "DRIVE_BOAT", 4.1, 0, 1, 1, 1, 1, 1);
            case 26: ApplyAnimationEx(playerid, "PED", "endchat_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 27: ApplyAnimationEx(playerid, "PED", "endchat_02", 4.1, 0, 1, 1, 1, 1, 1);
            case 28: ApplyAnimationEx(playerid, "PED", "endchat_03", 4.1, 0, 1, 1, 1, 1, 1);
            case 29: PlayAnim(playerid, "PED", "EV_dive", 4.1, 0, 1, 1, 1, 1, 1);
            case 30: PlayAnim(playerid, "PED", "flee_lkaround_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 31: PlayAnim(playerid, "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1, 1);
            case 32: PlayAnim(playerid, "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
            case 33: PlayAnim(playerid, "PED", "fucku", 4.1, 0, 1, 1, 1, 1, 1);
            case 34: ApplyAnimationEx(playerid, "PED", "gang_gunstand", 4.1, 0, 1, 1, 1, 1, 1);
            case 35: PlayAnim(playerid, "PED", "gas_cwr", 4.1, 0, 1, 1, 1, 1, 1);
            case 36: PlayAnim(playerid, "PED", "gum_eat", 4.1, 0, 1, 1, 1, 1, 1);
            case 37: PlayAnim(playerid, "PED", "GunCrouchBwd", 4.1, 0, 1, 1, 1, 1, 1);
            case 38: PlayAnim(playerid, "PED", "GunCrouchFwd", 4.1, 0, 1, 1, 1, 1, 1);
            case 39: PlayAnim(playerid, "PED", "GunMove_BWD", 4.1, 0, 1, 1, 1, 1, 1);
            case 40: PlayAnim(playerid, "PED", "GunMove_FWD", 4.1, 0, 1, 1, 1, 1, 1);
            case 41: PlayAnim(playerid, "PED", "GunMove_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 42: PlayAnim(playerid, "PED", "GunMove_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 43: PlayAnim(playerid, "PED", "GUN_BUTT", 4.1, 0, 1, 1, 1, 1, 1);
            case 44: PlayAnim(playerid, "PED", "GUN_BUTT_crouch", 4.1, 0, 1, 1, 1, 1, 1);
            case 45: ApplyAnimationEx(playerid, "PED", "Gun_stand", 4.1, 0, 1, 1, 1, 1, 1);
            case 46: PlayAnim(playerid, "PED", "handscower", 4.1, 0, 1, 1, 1, 1, 1);
            case 47: PlayAnim(playerid, "PED", "handsup", 4.1, 0, 1, 1, 1, 1, 1);
            case 48: PlayAnim(playerid, "PED", "HitA_2", 4.1, 0, 1, 1, 1, 1, 1);
            case 49: PlayAnim(playerid, "PED", "HitA_3", 4.1, 0, 1, 1, 1, 1, 1);
            case 50: PlayAnim(playerid, "PED", "HIT_back", 4.1, 0, 1, 1, 1, 1, 1);
            case 51: PlayAnim(playerid, "PED", "HIT_behind", 4.1, 0, 1, 1, 1, 1, 1);
            case 52: PlayAnim(playerid, "PED", "HIT_front", 4.1, 0, 1, 1, 1, 1, 1);
            case 53: PlayAnim(playerid, "PED", "HIT_GUN_BUTT", 4.1, 0, 1, 1, 1, 1, 1);
            case 54: PlayAnim(playerid, "PED", "HIT_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 55: PlayAnim(playerid, "PED", "HIT_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 56: PlayAnim(playerid, "PED", "HIT_walk", 4.1, 0, 1, 1, 1, 1, 1);
            case 57: PlayAnim(playerid, "PED", "HIT_wall", 4.1, 0, 1, 1, 1, 1, 1);
            case 58: ApplyAnimationEx(playerid, "PED", "Idlestance_fat", 4.1, 0, 1, 1, 1, 1, 1);
            case 59: ApplyAnimationEx(playerid, "PED", "idlestance_old", 4.1, 0, 1, 1, 1, 1, 1);
            case 60: ApplyAnimationEx(playerid, "PED", "IDLE_armed", 4.1, 0, 1, 1, 1, 1, 1);
            case 61: ApplyAnimationEx(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1, 1);
            case 62: ApplyAnimationEx(playerid, "PED", "IDLE_csaw", 4.1, 0, 1, 1, 1, 1, 1);
            case 63: ApplyAnimationEx(playerid, "PED", "Idle_Gang1", 4.1, 0, 1, 1, 1, 1, 1);
            case 64: ApplyAnimationEx(playerid, "PED", "IDLE_HBHB", 4.1, 0, 1, 1, 1, 1, 1);
            case 65: ApplyAnimationEx(playerid, "PED", "IDLE_ROCKET", 4.1, 0, 1, 1, 1, 1, 1);
            case 66: PlayAnim(playerid, "PED", "IDLE_taxi", 4.1, 0, 1, 1, 1, 1, 1);
            case 67: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.1, 0, 1, 1, 1, 1, 1);
            case 68: ApplyAnimationEx(playerid, "PED", "Jetpack_Idle", 4.1, 0, 1, 1, 1, 1, 1);
            case 69: PlayAnim(playerid, "PED", "KD_left", 4.1, 0, 1, 1, 1, 1, 1);
            case 70: PlayAnim(playerid, "PED", "KD_right", 4.1, 0, 1, 1, 1, 1, 1);
            case 71: PlayAnim(playerid, "PED", "KO_shot_face", 4.1, 0, 1, 1, 1, 1, 1);
            case 72: PlayAnim(playerid, "PED", "KO_shot_front", 4.1, 0, 1, 1, 1, 1, 1);
            case 73: PlayAnim(playerid, "PED", "KO_shot_stom", 4.1, 0, 1, 1, 1, 1, 1);
            case 74: PlayAnim(playerid, "PED", "KO_skid_back", 4.1, 0, 1, 1, 1, 1, 1);
            case 75: PlayAnim(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 1, 1);
            case 76: PlayAnim(playerid, "PED", "KO_spin_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 77: PlayAnim(playerid, "PED", "KO_spin_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 78: ApplyAnimationEx(playerid, "PED", "pass_Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);
            case 79: PlayAnim(playerid, "PED", "phone_talk", 4.1, 0, 1, 1, 1, 1, 1);
            case 80: PlayAnim(playerid, "PED", "roadcross", 4.1, 0, 1, 1, 1, 1, 1);
            case 81: PlayAnim(playerid, "PED", "roadcross_female", 4.1, 0, 1, 1, 1, 1, 1);
            case 82: PlayAnim(playerid, "PED", "roadcross_gang", 4.1, 0, 1, 1, 1, 1, 1);
            case 83: PlayAnim(playerid, "PED", "roadcross_old", 4.1, 0, 1, 1, 1, 1, 1);
            case 84: PlayAnim(playerid, "PED", "run_1armed", 4.1, 0, 1, 1, 1, 1, 1);
            case 85: PlayAnim(playerid, "PED", "Shove_Partial", 4.1, 0, 1, 1, 1, 1, 1);
            case 86: PlayAnim(playerid, "PED", "Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);
            case 87: PlayAnim(playerid, "PED", "woman_idlestance", 4.1, 0, 1, 1, 1, 1, 1);
            case 88: PlayAnim(playerid, "PED", "XPRESSscratch", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /ped [1-88]");
        }
	return 1;
}

CMD:pedmove(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 2: ApplyAnimationEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
	case 3: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 4: ApplyAnimationEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 5: ApplyAnimationEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 6: ApplyAnimationEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 7: ApplyAnimationEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
	case 8: ApplyAnimationEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 9: ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
	case 10: ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 11: ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
	case 12: ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
	case 13: ApplyAnimationEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
	case 14: ApplyAnimationEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
	case 15: ApplyAnimationEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
	case 16: ApplyAnimationEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 17: ApplyAnimationEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 18: ApplyAnimationEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
	case 19: ApplyAnimationEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 20: ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
	case 21: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
	case 22: ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
	case 23: ApplyAnimationEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
	case 24: ApplyAnimationEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
	case 25: ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
	case 26: ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /pedmove [1-26]");
	}
	
	return 1;
}

CMD:idles(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "PLAYIDLES", "shift", 4.1, 1, 1, 1, 1, 1, 1);
	case 2: ApplyAnimationEx(playerid, "PLAYIDLES", "shldr", 4.1, 1, 1, 1, 1, 1, 1);
	case 3: ApplyAnimationEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
	case 4: ApplyAnimationEx(playerid, "PLAYIDLES", "strleg", 4.1, 1, 1, 1, 1, 1, 1);
	case 5: ApplyAnimationEx(playerid, "PLAYIDLES", "time", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: ApplyAnimationEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 7: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 8: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0, 1);
	case 9: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0, 1);
	case 10: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 1, 0, 0, 0, 0, 1);
	case 11: ApplyAnimationEx(playerid, "PED", "roadcross", 4.1, 1, 0, 0, 0, 0, 1);
	case 12: ApplyAnimationEx(playerid, "PED", "roadcross_female", 4.1, 1, 0, 0, 0, 0, 1);
	case 13: ApplyAnimationEx(playerid, "PED", "roadcross_gang", 4.1, 1, 0, 0, 0, 0, 1);
	case 14: ApplyAnimationEx(playerid, "PED", "roadcross_old", 4.1, 1, 0, 0, 0, 0, 1);
	case 15: ApplyAnimationEx(playerid, "PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /idles [1-15]");
	}
	
	return 1;
}

CMD:police(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: PlayAnim(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: PlayAnim(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: PlayAnim(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid, "POLICE", "Cop_move_FWD", 4.1, 1, 1, 1, 1, 1, 1);
	case 6: ApplyAnimationEx(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 0, 0, 1, 5000, 1);
	case 7: PlayAnim(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: PlayAnim(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 5000, 1);
	case 9: PlayAnim(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 0, 0, 0, 0, 1);
	case 10: ApplyAnimationEx(playerid,"SWORD","sword_block",50.0,0,1,1,1,1,1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /police [1-10]");
	}
	
	return 1;
}

CMD:animpool(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "POOL", "POOL_Long_Shot", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "POOL", "POOL_Med_Shot", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "POOL", "POOL_Place_White", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "POOL", "POOL_Short_Shot", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: PlayAnim(playerid, "POOL", "POOL_XLong_Shot", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animpool [1-7]");
        }
	return 1;
}

CMD:python(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "PYTHON", "python_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "PYTHON", "python_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "PYTHON", "python_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "PYTHON", "python_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "PYTHON", "python_reload", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /python [1-7]");
        }
	return 1;
}

CMD:rap(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: ApplyAnimationEx(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "RAPPING", "RAP_A_Loop", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: ApplyAnimationEx(playerid, "RAPPING", "RAP_B_Loop", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "RAPPING", "RAP_C_Loop", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /rap [1-4]");
        }
	return 1;
}

CMD:animrifle(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "RIFLE", "RIFLE_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "RIFLE", "RIFLE_crouchload", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "RIFLE", "RIFLE_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "RIFLE", "RIFLE_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "RIFLE", "RIFLE_load", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animrifle [1-5]");
        }
	return 1;
}


CMD:riot(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "RIOT", "RIOT_ANGRY", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "RIOT", "RIOT_challenge", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "RIOT", "RIOT_FUKU", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "RIOT", "RIOT_PUNCHES", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: ApplyAnimationEx(playerid, "RIOT", "RIOT_shout", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /riot [1-7]");
	}
	
	return 1;
}


CMD:ryder(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "RYDER", "RYD_Beckon_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "RYDER", "RYD_Beckon_02", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "RYDER", "RYD_Beckon_03", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: ApplyAnimationEx(playerid, "RYDER", "Van_Crate_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: ApplyAnimationEx(playerid, "RYDER", "Van_Crate_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: ApplyAnimationEx(playerid, "RYDER", "Van_Lean_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 11: ApplyAnimationEx(playerid, "RYDER", "Van_Lean_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 14: ApplyAnimationEx(playerid, "RYDER", "Van_Stand", 4.1, 0, 1, 1, 1, 1, 1);
            case 15: ApplyAnimationEx(playerid, "RYDER", "Van_Stand_Crate", 4.1, 0, 1, 1, 1, 1, 1);
            case 16: PlayAnim(playerid, "RYDER", "Van_Throw", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /ryder [1-16]");
	}
	
	return 1;
}


CMD:dj(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: ApplyAnimationEx(playerid, "SCRATCHING", "sclng_l", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: ApplyAnimationEx(playerid, "SCRATCHING", "sclng_r", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: ApplyAnimationEx(playerid, "SCRATCHING", "scmid_l", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: ApplyAnimationEx(playerid, "SCRATCHING", "scmid_r", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: ApplyAnimationEx(playerid, "SCRATCHING", "scshrtl", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: ApplyAnimationEx(playerid, "SCRATCHING", "scshrtr", 4.1, 0, 1, 1, 1, 1, 1);
            case 11: ApplyAnimationEx(playerid, "SCRATCHING", "sc_ltor", 4.1, 0, 1, 1, 1, 1, 1);
            case 12: ApplyAnimationEx(playerid, "SCRATCHING", "sc_rtol", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /dj [1-12]");
	}
	
	return 1;
}

CMD:animshop(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "SHOP", "ROB_Loop", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "SHOP", "SHP_Gun_Aim", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "SHOP", "SHP_Gun_Duck", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "SHOP", "SHP_Gun_Fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: PlayAnim(playerid, "SHOP", "SHP_Gun_Grab", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: PlayAnim(playerid, "SHOP", "SHP_Gun_Threat", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: PlayAnim(playerid, "SHOP", "SHP_HandsUp_Scr", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: ApplyAnimationEx(playerid, "SHOP", "SHP_Jump_Glide", 4.1, 0, 1, 1, 1, 1, 1);
            case 11: PlayAnim(playerid, "SHOP", "SHP_Rob_GiveCash", 4.1, 0, 1, 1, 1, 1, 1);
            case 12: PlayAnim(playerid, "SHOP", "SHP_Rob_HandsUp", 4.1, 0, 1, 1, 1, 1, 1);
            case 13: PlayAnim(playerid, "SHOP", "SHP_Rob_React", 4.1, 0, 1, 1, 1, 1, 1);
            case 14: ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 1, 1);
            case 15: ApplyAnimationEx(playerid, "SHOP", "SHP_Serve_Loop", 4.1, 0, 1, 1, 1, 1, 1);
            case 16: ApplyAnimationEx(playerid, "SHOP", "Smoke_RYD", 4.1, 0, 1, 1, 1, 1, 1);
            case 17: ApplyAnimationEx(playerid, "SHOP", "donutdrop", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animshop [1-17]");
	}
	
	return 1;
}

CMD:animshotgun(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "SHOTGUN", "shotgun_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "SHOTGUN", "shotgun_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "SHOTGUN", "shotgun_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animshotgun [1-3]");
	}
	
	return 1;
}

CMD:animsilenced(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "SILENCED", "CrouchReload", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "SILENCED", "SilenceCrouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "SILENCED", "Silence_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animsilenced [1-4]");
	}
	
	return 1;
}

CMD:smoke(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: PlayAnim(playerid, "SMOKING", "M_smk_in", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "SMOKING", "F_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);
    case 3: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);
    case 4: ApplyAnimationEx(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 1, 1, 1, 1, 1);
    case 5: ApplyAnimationEx(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 1, 1, 1, 1, 1);
    case 6: ApplyAnimationEx(playerid, "SMOKING", "M_smk_loop", 4.1, 0, 1, 1, 1, 1, 1);
    case 7: ApplyAnimationEx(playerid, "SMOKING", "M_smk_tap", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /smoke [1-7]");
	}
	
	return 1;
}

CMD:animsniper(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "SNIPER", "WEAPON_sniper", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:stripclub(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: ApplyAnimationEx(playerid, "STRIP", "PLY_CASH", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "STRIP", "PUN_CASH", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: ApplyAnimationEx(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "STRIP", "PUN_LOOP", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1, 1);
            case 11: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1, 1);
            case 12: ApplyAnimationEx(playerid, "STRIP", "STR_A2B", 4.1, 0, 1, 1, 1, 1, 1);
            case 14: ApplyAnimationEx(playerid, "STRIP", "STR_B2C", 4.1, 0, 1, 1, 1, 1, 1);
            case 15: ApplyAnimationEx(playerid, "STRIP", "STR_C1", 4.1, 0, 1, 1, 1, 1, 1);
            case 16: ApplyAnimationEx(playerid, "STRIP", "STR_C2", 4.1, 0, 1, 1, 1, 1, 1);
            case 17: ApplyAnimationEx(playerid, "STRIP", "STR_Loop_A", 4.1, 0, 1, 1, 1, 1, 1);
            case 18: ApplyAnimationEx(playerid, "STRIP", "STR_Loop_B", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /stripclub [1-18]");
	}
	
	return 1;
}

CMD:sunbathe(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: ApplyAnimationEx(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: ApplyAnimationEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: ApplyAnimationEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 6: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 9: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 10: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);
	case 11: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);
	case 12: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);
	case 13: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);
	case 14: ApplyAnimationEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);
	case 15: ApplyAnimationEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);
	case 16: ApplyAnimationEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);
	case 17: ApplyAnimationEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);
	case 18: ApplyAnimationEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /sunbathe [1-18]");
	}
	return 1;
}

CMD:animswat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: ApplyAnimationEx(playerid, "SWAT", "gnstwall_injurd", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "SWAT", "swt_lkt", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "SWAT", "swt_sty", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "SWAT", "swt_wllpk_L", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "SWAT", "swt_wllpk_R", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: PlayAnim(playerid, "SWAT", "swt_wllshoot_in_L", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animswat [1-8]");
	}
	return 1;
}

CMD:animsweet(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "SWEET", "ho_ass_slapped", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "SWEET", "plyr_hndshldr_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "SWEET", "sweet_hndshldr_01", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animsweet [1-8]");
	}
	return 1;
}

CMD:animsword(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "SWORD", "sword_1", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "SWORD", "sword_2", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "SWORD", "sword_3", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "SWORD", "sword_4", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: ApplyAnimationEx(playerid, "SWORD", "sword_block", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "SWORD", "Sword_Hit_1", 4.1, 0, 1, 1, 1, 1, 1);
            case 7: PlayAnim(playerid, "SWORD", "Sword_Hit_2", 4.1, 0, 1, 1, 1, 1, 1);
            case 8: PlayAnim(playerid, "SWORD", "Sword_Hit_3", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: ApplyAnimationEx(playerid, "SWORD", "sword_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
            case 10: ApplyAnimationEx(playerid, "SWORD", "sword_part", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animsweet [1-8]");
	}
	return 1;
}

CMD:animtec(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "TEC", "TEC_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "TEC", "TEC_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "TEC", "TEC_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "TEC", "TEC_reload", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animtec [1-4]");
	}
	return 1;
}

CMD:train(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    PlayAnim(playerid, "TRAIN", "tran_ouch", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:animuzi(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: PlayAnim(playerid, "UZI", "UZI_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "UZI", "UZI_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "UZI", "UZI_fire", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "UZI", "UZI_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "UZI", "UZI_reload", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /animuzi [1-5]");
	}
	return 1;
}

CMD:vending(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
            case 1: ApplyAnimationEx(playerid, "VENDING", "VEND_Drink2_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: ApplyAnimationEx(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: ApplyAnimationEx(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "VENDING", "VEND_Eat_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "VENDING", "VEND_Use", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "VENDING", "VEND_Use_pt2", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /vending [1-6]");
	}
	return 1;
}

CMD:wayfarer(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	if(IsWayfarer(GetPlayerVehicleID(playerid)))
	{
		switch(strval(params))
		{
            case 1: PlayAnim(playerid, "WAYFARER", "WF_Back", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "WAYFARER", "WF_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "WAYFARER", "WF_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "WAYFARER", "WF_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "WAYFARER", "WF_Fwd", 4.1, 0, 1, 1, 1, 1, 1);
            case 9: PlayAnim(playerid, "WAYFARER", "WF_hit", 4.1, 0, 1, 1, 1, 1, 1);
            case 13: PlayAnim(playerid, "WAYFARER", "WF_Left", 4.1, 0, 1, 1, 1, 1, 1);
            case 14: PlayAnim(playerid, "WAYFARER", "WF_passenger", 4.1, 0, 1, 1, 1, 1, 1);
            case 15: PlayAnim(playerid, "WAYFARER", "WF_pushes", 4.1, 0, 1, 1, 1, 1, 1);
            case 16: PlayAnim(playerid, "WAYFARER", "WF_Ride", 4.1, 0, 1, 1, 1, 1, 1);
            case 17: PlayAnim(playerid, "WAYFARER", "WF_Right", 4.1, 0, 1, 1, 1, 1, 1);
            case 18: PlayAnim(playerid, "WAYFARER", "WF_Still", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /wayfarer [1-31]");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{ffffff} Phuong tien nay khong the dung lenh.");
	}
	return 1;
}

CMD:wuzi(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "WUZI", "Wuzi_follow", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: PlayAnim(playerid, "WUZI", "Wuzi_Greet_Plyr", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: PlayAnim(playerid, "WUZI", "Wuzi_Greet_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);
            case 5: PlayAnim(playerid, "WUZI", "Wuzi_grnd_chk", 4.1, 0, 1, 1, 1, 1, 1);
            case 6: PlayAnim(playerid, "WUZI", "Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1);
		    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /wuzi [1-6]");
        }
	return 1;
}

CMD:blowjob(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
        {
            case 1: PlayAnim(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 2: PlayAnim(playerid, "BLOWJOBZ", "BJ_COUCH_END_W", 4.1, 0, 1, 1, 1, 1, 1);
            case 3: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 0, 1, 1, 1, 1, 1);
            case 4: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 0, 1, 1, 1, 1, 1);
		    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /wuzi [1-6]");
        }
	return 1;
}
/*------------------------Here--------------------------------*/

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
    case 1: ApplyAnimationEx(playerid, "ped", "SEAT_idle", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: ApplyAnimationEx(playerid, "ped", "SEAT_up", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: ApplyAnimationEx(playerid, "Attractors", "Stepsit_in", 4.1, 0, 0, 0, 0, 0, 1);
    case 4: ApplyAnimationEx(playerid, "Attractors", "Stepsit_out", 4.1, 0, 0, 0, 0, 0, 1);
    case 5: ApplyAnimationEx(playerid, "PED", "SEAT_down", 4.1, 0, 0, 0, 0, 0, 1);
    case 6: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 0, 0, 1);
    case 7: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, 0, 0, 0, 0, 0, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /seat [1-7]");
    }
    return 1;
}

CMD:angry(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:shake(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: ApplyAnimationEx(playerid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
    case 2: ApplyAnimationEx(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: ApplyAnimationEx(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
    default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /shake [1-3]");
    }
    return 1;
}

CMD:run(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    case 1: ApplyAnimationEx(playerid, "PED", "run_civi", 4.1, 1, 1, 1, 1, 1, 1);
    case 2: ApplyAnimationEx(playerid, "PED", "run_gang1", 4.1, 1, 1, 1, 1, 1, 1);
    case 3: ApplyAnimationEx(playerid, "PED", "run_old", 4.1, 1, 1, 1, 1, 1, 1);
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


CMD:dauhang(playerid, params[]) {
	return cmd_handsup(playerid, params);
}

CMD:sneak(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	ApplyAnimationEx(playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1, 1);
	
	return 1;
}

CMD:drunk(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
   	ApplyAnimationEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
   	
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
	ApplyAnimationEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, 1, 1);
	
	return 1;
}

CMD:laugh(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	ApplyAnimationEx(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0, 1);
	
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
    ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:hide(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:vomit(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:eat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1);
    
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
    	case 1: ApplyAnimationEx(playerid, "INT_HOUSE","BED_In_L", 4.1, 0, 1, 1, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "INT_HOUSE","BED_In_R", 4.1, 0, 1, 1, 1, 0, 1);
        case 3: ApplyAnimationEx(playerid, "INT_HOUSE","BED_Loop_L", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "INT_HOUSE","BED_Loop_R", 4.1, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /bed [1-4]");
    }
    return 1;
}

CMD:gym(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
        case 3: ApplyAnimationEx(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
        case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
        case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
        case 7: ApplyAnimationEx(playerid,"benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
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

CMD:drinkwater(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    
    return 1;
}

CMD:tapcig(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0,1);
    
    return 1;
}
CMD:namxuong(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:fallfront(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0, 1);
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
    	case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.1, 0, 1, 1, 1, 0, 1);
        default: SendClientMessage(playerid, COLOR_GREY, "HIND: /sleep [1-2]");
    }
    return 1;
}

CMD:blob(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
    
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

CMD:dive(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:showoff(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
    {
    	case 1: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
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
    ApplyAnimationEx(playerid, "SHOP", "SHP_Rob_GiveCash", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hurt(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:camera1(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "CAMERA","camcrch_cmon", 4.0, 1, 0, 0, 1, 0, 1);
    return 1;
}

CMD:washhands(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crabs(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:salute(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:jerkoff(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:stop(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "PED", "endchat_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}


CMD:liftcase(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
    ApplyAnimationEx(playerid, "MISC", "Case_pickup", 4.0, 0, 0, 0, 0, 0,1);
    return 1;
}
/*

CMD:bye(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: ApplyAnimationEx(playerid, "KISSING", 		"BD_GF_Wave", 	4.0, 0, 0, 1, 0, 0);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS", 	"wave_in", 		4.0, 0, 0, 1, 0, 0);
		case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", 	"wave_loop", 	4.0, 0, 0, 1, 0, 0);
		case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", 	"wave_out", 	4.0, 0, 0, 1, 0, 0);
		case 5: ApplyAnimationEx(playerid, "BD_FIRE",		"BD_GF_Wave", 	4.0, 0, 0, 1, 0, 0);
		case 6: ApplyAnimationEx(playerid, "ped", 			"endchat_01", 	4.0, 0, 0, 1, 0, 0);
		case 7: ApplyAnimationEx(playerid, "ped", 			"endchat_02", 	4.0, 0, 0, 1, 0, 0);
		case 8: ApplyAnimationEx(playerid, "ped", 			"endchat_03", 	4.0, 0, 0, 1, 0, 0);
		default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /bye [1-8]");
	}
	return 1;
}
*/

CMD:chat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: ApplyAnimationEx(playerid, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
		case 3:	ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
		case 7:	ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
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
	case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid,"BEACH", "parksit_w_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid,"BEACH","parksit_m_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: ApplyAnimationEx(playerid,"SUNBATHE","Lay_Bac_in",3.0, 1, 0, 0, 0, 0, 1);
	case 7: ApplyAnimationEx(playerid,"SUNBATHE","batherdown",3.0, 1, 0, 0, 0, 0, 1);
	case 8: ApplyAnimationEx(playerid,"SUNBATHE","parksit_m_in",3.0, 1, 0, 0, 0, 0, 1);
	case 9: ApplyAnimationEx(playerid,"CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /lay [1-9]");
	}
	return 1;
}

CMD:wave(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid,"BD_Fire", "BD_GF_Wave", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid,"WUZI", "Wuzi_Follow", 5.0, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /wave [1-5]");
	}
	
	return 1;
}

CMD:signal(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "POLICE", "CopTraf_Come", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /signal [1-2]");
	}
	
	return 1;
}

CMD:nobreath(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /nobreath [1-3]");
	}
	
	return 1;
}



CMD:getjiggy(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
	case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
	case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
	case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /getjiggy [1-10]");
	}
	
	return 1;
}

CMD:tag(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimation(playerid, "SPRAYCAN", "spraycan_fire", 4.1, 0, 1, 1, 1, 1, 1);
    case 4: ApplyAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /tag [1-4]");
	}
	
	return 1;
}

CMD:deal(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid,"DEALER","DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
	case 6: ApplyAnimationEx(playerid,"DEALER","DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /deal [1-6]");
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1, 1);
	case 2: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /crossarms [1-4]");
	}
	
	return 1;
}

CMD:sit(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid,"PED","SEAT_down",4.1,0,1,1,1,0,1);
	case 2: ApplyAnimationEx(playerid,"MISC","seat_lr",2.0,1,0,0,0,0,1);
	case 3: ApplyAnimationEx(playerid,"MISC","seat_talk_01",2.0,1,0,0,0,0,1);
	case 4: ApplyAnimationEx(playerid,"MISC","seat_talk_02",2.0,1,0,0,0,0,1);
	case 5: ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0, 1);
	case 6: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 0, 1, 1, 1, 1, 1);
	case 8: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loose", 4.1, 0, 1, 1, 1, 1, 1);
	case 7: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Win", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /sit [1-6]");
	}
	
	return 1;
}

CMD:siteat(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /siteat [1-2]");
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
	case 1: ApplyAnimationEx(playerid, "DANCING", "bd_clap",4.0,1,0,0,0,0,1);
	case 2: ApplyAnimationEx(playerid, "DANCING", "bd_clap1", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 7: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 8: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /hiphop [1-12]");
	}
	return 1;
}


CMD:spank(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "SNM", "SPANKINGP", 4.1, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimationEx(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimationEx(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /spank [1-4]");
	}
	return 1;
}

CMD:sexy(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "SNM","SPANKING_IDLEW", 4.1, 0, 0, 0, 1, 0, 1);
	case 2: ApplyAnimationEx(playerid, "SNM","SPANKING_IDLEP", 4.1, 0, 0, 0, 1, 0, 1);
	case 3: ApplyAnimationEx(playerid, "SNM","SPANKINGW", 4.1, 0, 0, 0, 1, 0, 1);
	case 4: ApplyAnimationEx(playerid, "SNM","SPANKINGP", 4.1, 0, 0, 0, 1, 0, 1);
	case 5: ApplyAnimationEx(playerid, "SNM","SPANKING_ENDW", 4.1, 0, 0, 0, 1, 0, 1);
	case 6: ApplyAnimationEx(playerid, "SNM","SPANKING_ENDP", 4.1, 0, 0, 0, 1, 0, 1);
	case 7: ApplyAnimationEx(playerid, "SNM", "SPANKEDW", 4.1, 0, 0, 0, 1, 0, 1);
	case 8: ApplyAnimationEx(playerid, "SNM", "SPANKEDP", 4.1, 0, 0, 0, 1, 0, 1);
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
	case 1: ApplyAnimationEx(playerid, "CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "CASINO","cards_win", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /win [1-2]");
	}
	
	return 1;
}

CMD:celebrate(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "benchpress","gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimationEx(playerid, "GYMNASIUM","gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /celebrate [1-2]");
	}
	
	return 1;
}

CMD:leanon(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid,  "GANGS", "leanIDLE", 4.0, 1, 0, 0, 1, 1, 1);
	case 2: ApplyAnimationEx(playerid, "MISC", "Plyrlean_loop", 4.0, 1, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /celebrate [1-2]");
	}
	
	return 1;
}

CMD:holdup(playerid, params[])
{
	if(!CheckAnimation(playerid)) return 1;
	switch(strval(params))
	{
	case 1: ApplyAnimationEx(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
	case 2: ApplyAnimationEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
	case 3: ApplyAnimationEx(playerid, "POOL", "POOL_Long_Start", 4.1, 0, 1, 1, 1, 1, 1);
	case 4: ApplyAnimationEx(playerid, "POOL", "POOL_Med_Shot", 4.1, 0, 1, 1, 1, 1, 1);
	case 5: ApplyAnimationEx(playerid, "POOL", "POOL_Med_Start", 4.1, 0, 1, 1, 1, 1, 1);
	default: SendClientMessage(playerid, COLOR_LIGHTRED, "SU DUNG:{FFFFFF} /holdup [1-5]");
	}
	
	return 1;
}


CMD:hiker(playerid, params[])
{
    if(!CheckAnimation(playerid)) return 1;
    switch(strval(params))
	{
         case 1: ApplyAnimationEx(playerid, "MISC", "Hiker_Pose_L", 4.0, 0, 1, 1, 1, 0, 1);
         case 2: ApplyAnimationEx(playerid,"MISC","Hiker_Pose", 4.0, 1, 0, 0, 0, 0, 1);
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
IsWayfarer(carid)
{
	new Cars[] = {586};
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}