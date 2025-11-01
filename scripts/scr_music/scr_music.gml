function add_music(arg0, arg1, arg2, arg3 = -4)
{
    var musicstruct = 
    {
        continuous: arg2,
        event: -4,
        mumethod: -4
    };
    
    with (musicstruct)
    {
        if (arg3 != -4)
            mumethod = method(self, arg3);
        
        if (arg1 != -4)
        {
            eventname = arg1;
            event = event_instance(arg1);
        }
    }
    
    ds_map_set(musicmap, arg0, musicstruct);
}

function stop_music()
{
    with (obj_music)
    {
        if (global.music != -4)
        {
            if (global.music.event != -4)
                event_stop(global.music.event, game_paused() || room == Jeg);
            
            global.music = -4;
        }
    }
}

function timeline_wrapauto(arg0, arg1, arg2)
{
    var pos = fmod_studio_event_instance_get_timeline_position(arg0);
    var length = fmod_studio_event_description_get_length(fmod_studio_system_get_event(arg1));
    fmod_studio_event_instance_set_timeline_position(arg2, wrap(pos, 1, length - 1));
}

function play_music(arg0, arg1 = true)
{
    var mu = ds_map_find_value(musicmap, arg0);
    
    if (!is_undefined(mu))
    {
        var prevmusic = global.music;
        
        if (prevmusic == -4 || mu.eventname != prevmusic.eventname)
        {
            fmod_studio_event_instance_start(mu.event);
            fmod_studio_event_instance_set_paused(mu.event, false);
            
            if (mu.continuous && prevmusic != -4)
                timeline_wrapauto(prevmusic.event, mu.eventname, mu.event);
            
            if (prevmusic != -4)
            {
                if (prevmusic.event != -4)
                    event_stop(prevmusic.event, arg1);
            }
            
            global.music = mu;
        }
    }
    
    if (global.music != -4 && global.music.mumethod != -4)
        global.music.mumethod(arg0);
}
