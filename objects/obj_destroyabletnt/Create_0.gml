event_inherited();
z = depth;
squish = 1;
active = false;
explodesteps = 4;
steptimer = 0;
stepflash = 0;

canCollide = function(arg0, arg1, arg2)
{
    if (arg0.object_index == obj_player)
        return arg0.ondeathplatform == noone;
    
    return true;
};

bounce_event = function(arg0, arg1)
{
    if (!active)
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
        
        active = true;
        squish = 0.7;
        combo();
        gamepadvibrate(0.2, 0, 8);
    }
};
