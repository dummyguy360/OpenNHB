event_inherited();
lightlevel = 1;
z = depth;
squish = 1;

canCollide = function(arg0, arg1, arg2)
{
    if (global.switchstate ^^ reverse)
        return false;
    
    with (arg0)
    {
        if (place_meeting(arg1, arg2, other))
            return false;
    }
    
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == -4;
    
    return true;
};

outlining = shader_get_uniform(shd_sadblock, "u_Outlining");
reverse = false;
