startdepth = depth;
hsp = 0;
vsp = 0;
grav = 0.5;
var _gw = get_game_width();
var _gh = get_game_height();
middlex = _gw / 2;

switch (type ?? UnknownEnum.Value_0)
{
    case UnknownEnum.Value_0:
        x = middlex;
        y = -100;
        vsp = 8;
        break;
    
    case UnknownEnum.Value_1:
        x = 16;
        break;
    
    case UnknownEnum.Value_2:
        x = _gw - 16;
        break;
}

if (type == UnknownEnum.Value_1 || type == UnknownEnum.Value_2)
{
    y = _gh + 64;
    var _motion = calculate_projectile_motion(x, y, middlex, 365, grav, 48);
    hsp = _motion.hsp;
    vsp = _motion.vsp;
}
