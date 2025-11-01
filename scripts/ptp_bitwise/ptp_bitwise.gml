function bit_set(arg0, arg1, arg2 = false)
{
    if (arg2)
        return arg0 & ~(1 << arg1);
    
    if (!arg2)
        return arg0 | (1 << arg1);
}

function bit_get(arg0, arg1)
{
    return (arg0 >> arg1) & 1;
}

function bit_toggle(arg0, arg1)
{
    return arg0 ^ (1 << arg1);
}

function bit_flip(arg0)
{
    return ~arg0;
}

function bit_mask(arg0, arg1)
{
    return arg1 & arg0;
}

function bit_count(arg0)
{
    var _ones;
    
    for (_ones = 0; arg0 != 0; _ones++)
        arg0 &= (arg0 - 1);
    
    return _ones;
}
