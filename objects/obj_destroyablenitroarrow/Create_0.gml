event_inherited();
lightlevel = 1;
z = depth;
hp = 3;
squish = 1;
palettespr = spr_nitroarrowpal;
curpalette = hp;

canCollide = function(arg0, arg1, arg2)
{
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == noone;
    
    return true;
};

bounce_event = function(arg0, arg1)
{
    if (arg1 >= 0)
    {
        cratebounceeffect(arg0);
        
        with (arg0)
            player_bounce(input_check("jump") ? -18 : -15);
        
        squish = 0.7;
        hp--;
        
        if (hp <= 0)
        {
            instance_destroy();
            combo();
            gamepadvibrate(0.2, 0, 8);
        }
        else
            gamepadvibrate(0.1, 0, 8);
    }
};
