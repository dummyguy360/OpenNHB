function gamepadvibrate(arg0, arg1, arg2, arg3 = 0, arg4 = false)
{
    if (global.rumble)
        input_vibrate_constant(arg0, arg1, arg2, arg3, arg4);
}

function create_key(arg0)
{
    return 
    {
        key: arg0
    };
}

function apply_inputglobals()
{
    input_axis_threshold_set(32785, global.horizdeadzone, 1);
    input_axis_threshold_set(32787, global.horizdeadzone, 1);
    input_axis_threshold_set(32786, global.vertdeadzone, 1);
    input_axis_threshold_set(32788, global.vertdeadzone, 1);
}
