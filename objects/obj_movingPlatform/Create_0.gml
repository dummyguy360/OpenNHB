done_move = false;
landed = false;
movetimer = 0;

canCollide = function(arg0, arg1, arg2)
{
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == noone;
    
    return true;
};
