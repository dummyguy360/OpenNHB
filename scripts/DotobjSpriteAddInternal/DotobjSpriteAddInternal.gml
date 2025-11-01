function DotobjSpriteAddInternal(arg0, arg1)
{
    if (ds_map_exists(global.__dotobjSpriteMap, arg0))
        __DotobjError("\"", arg0, "\" has already been added");
    
    show_debug_message("DotobjSpriteAddInternal(): Set \"" + string(arg0) + "\" to internal sprite \"" + sprite_get_name(arg1) + "\" (" + string(arg1) + ")");
    ds_map_set(global.__dotobjSpriteMap, arg0, arg1);
}
