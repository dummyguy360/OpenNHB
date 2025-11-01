function lerpAngle(arg0, arg1, arg2)
{
    var _return = arg0 + (angle_difference(arg1, arg0) * arg2);
    
    while (_return < 0)
        _return += 360;
    
    while (_return > 360)
        _return -= 360;
    
    return _return;
}

function wrap(arg0, arg1, arg2)
{
    var range = (arg2 + 1) - arg1;
    var _wrapped = ((((arg0 - arg1) % range) + range) % range) + arg1;
    
    if (_wrapped > arg2)
        _wrapped = arg1 + frac(_wrapped);
    
    return _wrapped;
}

function approach(arg0, arg1, arg2)
{
    return median(arg0 - arg2, arg1, arg0 + arg2);
}

function wave(arg0, arg1, arg2, arg3 = 0, arg4 = current_time)
{
    var _half = (arg1 - arg0) * 0.5;
    return arg0 + _half + (sin(((((arg4 + arg3) * 0.001) + arg2) / arg2) * (2 * pi)) * _half);
}

function easy_sin(arg0)
{
    return sin(arg0 * pi);
}

function calculate_projectile_motion(arg0, arg1, arg2, arg3, arg4, arg5)
{
    arg3 = arg1 - (arg3 - arg1);
    var _hsp = (arg2 - arg0) / arg5;
    var _vsp = ((arg3 - arg1) + (0.5 * arg4 * sqr(arg5))) / arg5;
    return 
    {
        hsp: _hsp,
        vsp: -_vsp
    };
}

function calculate_jump(arg0, arg1)
{
    return -sqrt(2 * arg1 * arg0);
}

function calculate_jump_height(arg0, arg1)
{
    return sqr(arg0) / (2 * arg1);
}
