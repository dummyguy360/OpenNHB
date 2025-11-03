event_inherited();
z = depth;
hp = 1;
squish = 1;

canCollide = function(arg0, arg1, arg2)
{
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == noone;
    
    return true;
};

bounce_event = function(arg0, arg1)
{
    with (arg0)
    {
        if (arg1 >= 0)
        {
            cratebounceeffect(arg0);
            player_bounce(input_check("jump") ? -13 : -10);
        }
        else
        {
            player_bounce(abs(vsp) * 0.75);
            
            if (vsp < 4)
                vsp = 4;
        }
    }
    
    squish = 0.7;
    hp--;
    
    if (hp <= 0)
    {
        instance_destroy();
        gamepadvibrate(0.2, 0, 8);
    }
    else
        gamepadvibrate(0.1, 0, 8);
};
