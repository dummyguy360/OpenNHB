global.sound_map = ds_map_create();

function scr_fmod_soundeffect(arg0, arg1, arg2, arg3 = 0)
{
    fmod_studio_event_instance_start(arg0);
    event_set_3d_position(arg0, arg1, arg2, arg3);
}

function scr_fmod_soundeffectONESHOT(arg0, arg1, arg2, arg3 = 0)
{
    var event_id = event_instance(arg0);
    fmod_studio_event_instance_start(event_id);
    event_set_3d_position(event_id, arg1, arg2, arg3);
    fmod_studio_event_instance_release(event_id);
    return event_id;
}

function event_play_oneshot(arg0)
{
    var event_id = event_instance(arg0);
    fmod_studio_event_instance_start(event_id);
    fmod_studio_event_instance_release(event_id);
    return event_id;
}

function event_isplaying(arg0)
{
    var _playback = fmod_studio_event_instance_get_playback_state(arg0);
    return _playback != UnknownEnum.Value_2 && _playback != UnknownEnum.Value_4;
}

function event_count_description(arg0)
{
    return fmod_studio_event_description_get_instance_count(fmod_studio_system_get_event(arg0));
}

function event_instance(arg0)
{
    return fmod_studio_event_description_create_instance(fmod_studio_system_get_event(arg0));
}

function event_pause_all(arg0)
{
    var _bus = ["bus:/Music/Pausable", "bus:/SFX/Pausable"];
    
    for (var i = 0; i < array_length(_bus); i++)
        fmod_studio_bus_set_paused(fmod_studio_system_get_bus(_bus[i]), arg0);
}

function event_set_3d_position(arg0, arg1, arg2, arg3 = 0)
{
    if (!event_isplaying(arg0))
        exit;
    
    var _attr = new Fmod3DAttributes();
    _attr.position.x = arg1;
    _attr.position.y = arg2;
    _attr.position.z = arg3;
    _attr.forward.z = 1;
    _attr.up.y = 1;
    fmod_studio_event_instance_set_3d_attributes(arg0, _attr);
}

function event_set_3d_position_struct(arg0, arg1)
{
    if (!event_isplaying(arg0))
        exit;
    
    fmod_studio_event_instance_set_3d_attributes(arg0, arg1);
}

function event_stop(arg0, arg1)
{
    fmod_studio_event_instance_stop(arg0, arg1 ? UnknownEnum.Value_1 : UnknownEnum.Value_0);
}

function event_stop_description(arg0, arg1)
{
    var _insts = fmod_studio_event_description_get_instance_list(fmod_studio_system_get_event(arg0));
    
    for (var _i = 0; _i < array_length(_insts); _i++)
        event_stop(_insts[_i], arg1);
}

function listener_setPosition(arg0, arg1, arg2, arg3 = 0)
{
    var _attr = new Fmod3DAttributes();
    _attr.position.x = arg1;
    _attr.position.y = arg2;
    _attr.position.z = arg3;
    _attr.forward.z = 1;
    _attr.up.y = 1;
    fmod_studio_system_set_listener_attributes(arg0, _attr);
}

function destroy_sounds(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
        event_stop(b, 1);
        fmod_studio_event_instance_release(b);
    }
}

function event_replay(arg0, arg1, arg2, arg3 = 0)
{
    if (ds_map_find_value(global.sound_map, arg0) == undefined)
        ds_map_set(global.sound_map, arg0, ds_list_create());
    
    var _list = ds_map_find_value(global.sound_map, arg0);
    
    for (var i = 0; i < ds_list_size(_list); i++)
    {
        b = ds_list_find_value(_list, i);
        event_stop(b, 0);
        fmod_studio_event_instance_release(b);
    }
    
    ds_list_clear(_list);
    var b = event_instance(arg0);
    fmod_studio_event_instance_start(b);
    event_set_3d_position(b, arg1, arg2, arg3);
    ds_list_add(_list, b);
}
