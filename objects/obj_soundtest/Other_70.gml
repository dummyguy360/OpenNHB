if (ds_map_find_value(async_load, "type") != "fmod_studio_event_description_set_callback")
    exit;

if (ds_map_find_value(async_load, "kind") != UnknownEnum.Value_4096)
    exit;

flowstate = !flowstate;
flowspr = flowstate ? spr_soundtestflowright : spr_soundtestflowleft;
flowframe = 0;
