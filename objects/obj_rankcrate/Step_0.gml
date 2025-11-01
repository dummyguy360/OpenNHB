vsp += grav;
x += hsp;
y += vsp;
var _destroy = false;

switch (type)
{
    case UnknownEnum.Value_0:
        var _maxy = 330;
        
        if (obj_rankscreen.noisespr == spr_player_rankmanycrates)
            _maxy = 340;
        
        if (obj_rankscreen.noisespr == spr_player_ranktoomanycrates)
            _maxy = 365;
        
        _destroy = y >= _maxy;
        break;
    
    case UnknownEnum.Value_1:
        _destroy = x >= middlex;
        break;
    
    case UnknownEnum.Value_2:
        _destroy = x <= middlex;
        break;
}

if (type == UnknownEnum.Value_1 || type == UnknownEnum.Value_2)
{
    image_xscale = tween(2, 1, 1 - (abs(x - middlex) / middlex), EASE_OUT_CUBIC);
    image_yscale = image_xscale;
    depth = startdepth - ((image_xscale - 1) * 32);
}

if (_destroy)
{
    obj_rankscreen.noiseind = 0;
    obj_rankscreen.crateshit++;
    
    repeat (4)
        instance_create_depth(get_game_width() / 2, y, startdepth - 1, obj_rankcratedebris);
    
    scr_fmod_soundeffectONESHOT("event:/sfx/misc/cratedestroy", obj_player.x, obj_player.y);
    gamepadvibrate(0.4, 0, 8);
    instance_destroy();
}
