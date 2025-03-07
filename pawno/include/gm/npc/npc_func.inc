CreateActorEx(actorid, actortype, Float:a_px, Float:a_py, Float:a_pz, Float:a_pr, a_int, a_vw)
{
    if (SNPC_GetFreeID() == -1) return printf("Da vuot qua gioi han cua cac actor tren may chu. Vui long thu lai sau.");
    new id = SNPC_GetFreeID();
    E_ACTOR[id][aID] = CreateDynamicActor(1, a_px, a_py, a_pz, a_pr, 1, 100.0, a_vw, a_int);

    if (actortype == ACTOR_TYPE_DRUGS)
    {
        DNPC_OnActorInit(actorid);
    }
    return 1;
}