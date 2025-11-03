event_inherited();
z = depth;
hp = 5;
squish = 1;
toolong = false;

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
    
    if (!toolong)
    {
        with (instance_create_depth(x + (sprite_width / 2), y + (sprite_height / 2), z + 16, par_collect))
        {
            image_speed = 0.35;
            value = 11;
            splitfactor = 2;
            splittime = 3;
            particlespr = [spr_collect1, spr_collect2, spr_collect3, spr_collect4, spr_collect5];
            canmagnetise = false;
            splitsound = "event:/sfx/player/collect";
            saveroom = false;
            event_user(0);
        }
    }
    
    alarm[0] = 220;
    squish = 0.7;
    
    if (!in_saveroom(string("{0}_HIT", real(id)), global.respawnroom))
        add_saveroom(string("{0}_HIT", real(id)), global.respawnroom);
    
    hp--;
    
    if (hp <= 0)
    {
        instance_destroy();
        combo();
        gamepadvibrate(0.2, 0, 8);
    }
    else
    {
        combo();
        gamepadvibrate(0.1, 0, 8);
    }
};
