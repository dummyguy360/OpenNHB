event_inherited();
lightlevel = 1;
z = depth;
squish = 1;
hit = false;

canCollide = function(arg0, arg1, arg2)
{
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == noone;
    
    return true;
};

bounce_event = function(arg0, arg1)
{
    global.switchstate = !global.switchstate;
    var _ev = scr_fmod_soundeffectONESHOT("event:/sfx/misc/onoffcrate", x + (sprite_width / 2), y + (sprite_height / 2));
    fmod_studio_event_instance_set_parameter_by_name(_ev, "state", global.switchstate);
    
    with (arg0)
    {
        if (arg1 >= 0)
        {
            cratebounceeffect(arg0);
            player_bounce(input_check("jump") ? -18 : -15);
            gamepadvibrate(0.1, 0, 8);
        }
        else
        {
            player_bounce(abs(vsp) * 0.75);
            
            if (vsp < 4)
                vsp = 4;
            
            gamepadvibrate(0.2, 0, 8);
        }
    }
    
    squish = 0.7;
};
