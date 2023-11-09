new ac_spawn[MAX_PLAYERS char];

stock ac_SpawnPlayer(playerid)
{
	ac_spawn{playerid} = 1;
    return SpawnPlayer(playerid);
}

#if defined _ALS_SpawnPlayer
    #undef SpawnPlayer
#else
    #define _ALS_SpawnPlayer
#endif
#define SpawnPlayer ac_SpawnPlayer
//FakeKill
new ac_fake_kill[MAX_PLAYERS char];
//Carshot
new Float: ac_last_vel_x[MAX_PLAYERS],
    Float: ac_last_vel_y[MAX_PLAYERS],
    Float: ac_last_vel_z[MAX_PLAYERS],
    Float: ac_last_veh_x[MAX_PLAYERS],
    Float: ac_last_veh_y[MAX_PLAYERS],
    Float: ac_last_veh_z[MAX_PLAYERS],
    ac_last_speed[MAX_PLAYERS],
    Float:ac_veh_pos_dif[MAX_VEHICLES];

new ac_carshot_flood[MAX_PLAYERS char],
	ac_veh_airbreak_flood[MAX_PLAYERS char],
	ac_veh_health[MAX_PLAYERS char];

#define GetVectorSpeed(%0,%1,%2) floatround(VectorSize(%0, %1, %2) * 179.28625)