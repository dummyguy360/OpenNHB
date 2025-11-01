global.startingseed = random_get_seed();

function reroll()
{
    randomise();
    global.startingseed = random_get_seed();
}

function chance(arg0)
{
    return random(100) <= arg0;
}

function do_specific(arg0)
{
    random_set_seed(global.startingseed + real(room) + x + y);
    arg0();
    random_set_seed(global.startingseed);
}
