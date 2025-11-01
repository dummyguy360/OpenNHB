global.game_cycleF = 0;
global.game_cycleMS = 0;

function reset_cycle()
{
    global.game_cycleF = 0;
    global.game_cycleMS = 0;
}

function update_cycle()
{
    global.game_cycleMS += 16.666666666666668;
    global.game_cycleF++;
}

function get_cycle(arg0, arg1 = 0)
{
    return (global.game_cycleF + arg1) % arg0;
}

function get_cycle_region(arg0, arg1, arg2, arg3)
{
    return clamp(arg0 - arg1, arg2, arg3);
}
