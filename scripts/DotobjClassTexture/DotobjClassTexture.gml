function DotobjClassTexture(arg0, arg1, arg2) constructor
{
    static Free = function()
    {
        if (external && sprite != undefined)
        {
            ds_map_delete(global.__dotobjSpriteMap, filename);
            sprite_delete(sprite);
        }
        
        sprite = undefined;
        pointer = undefined;
    };
    
    filename = undefined;
    sprite = arg0;
    index = arg1;
    external = arg2;
    pointer = sprite_get_texture(arg0, arg1);
    blend_u = undefined;
    blend_v = undefined;
    bump_multiplier = undefined;
    sharpness_boost = undefined;
    colour_correction = undefined;
    channel = undefined;
    scalar_range = undefined;
    uv_clamp = undefined;
    uv_offset = undefined;
    uv_scale = undefined;
    turbulence = undefined;
    resolution = undefined;
    invert_v = undefined;
}
