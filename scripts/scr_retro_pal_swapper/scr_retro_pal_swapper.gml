function pal_swap_init_system(arg0, arg1, arg2)
{
    var _swapper = 
    {
        shader: -4,
        billboardshader: -4,
        premultipliedshader: -4,
        texel_size: [0],
        uvs: [0],
        index: [0],
        texture: [0]
    };
    _swapper.shader = arg0;
    _swapper.texel_size[0] = shader_get_uniform(arg0, "u_pixelSize");
    _swapper.uvs[0] = shader_get_uniform(arg0, "u_Uvs");
    _swapper.index[0] = shader_get_uniform(arg0, "u_paletteId");
    _swapper.texture[0] = shader_get_sampler_index(arg0, "u_palTexture");
    _swapper.billboardshader = arg1;
    _swapper.texel_size[1] = shader_get_uniform(arg1, "u_pixelSize");
    _swapper.uvs[1] = shader_get_uniform(arg1, "u_Uvs");
    _swapper.index[1] = shader_get_uniform(arg1, "u_paletteId");
    _swapper.texture[1] = shader_get_sampler_index(arg1, "u_palTexture");
    _swapper.premultipliedshader = arg2;
    _swapper.texel_size[2] = shader_get_uniform(arg2, "u_pixelSize");
    _swapper.uvs[2] = shader_get_uniform(arg2, "u_Uvs");
    _swapper.index[2] = shader_get_uniform(arg2, "u_paletteId");
    _swapper.texture[2] = shader_get_sampler_index(arg2, "u_palTexture");
    global.retro_pal_swapper = _swapper;
}

function pal_swap_set(arg0, arg1, arg2)
{
    var _swapper = global.retro_pal_swapper;
    
    if (arg1 == 0)
        exit;
    
    var _mode = 0;
    
    if (shader_current() == shd_billboard)
        _mode = 1;
    
    if (surface_get_target() == obj_drawcontroller.guisurf)
        _mode = 2;
    
    if (!arg2)
    {
        if (_mode == 1)
            shader_set(_swapper.billboardshader);
        else if (_mode == 2)
            shader_set(_swapper.premultipliedshader);
        else
            shader_set(_swapper.shader);
        
        var _tex = sprite_get_texture(arg0, 0);
        var _UVs = sprite_get_uvs(arg0, 0);
        texture_set_stage(_swapper.texture[_mode], _tex);
        var _texel_x = texture_get_texel_width(_tex);
        var _texel_y = texture_get_texel_height(_tex);
        var _texel_hx = _texel_x * 0.5;
        var _texel_hy = _texel_y * 0.5;
        shader_set_uniform_f(_swapper.texel_size[_mode], _texel_x, _texel_y);
        shader_set_uniform_f(_swapper.uvs[_mode], _UVs[0] + _texel_hx, _UVs[1] + _texel_hy, _UVs[2], _UVs[3]);
        shader_set_uniform_f(_swapper.index[_mode], arg1);
    }
    else
    {
        if (_mode == 1)
            shader_set(_swapper.billboardshader);
        else if (_mode == 2)
            shader_set(_swapper.premultipledshader);
        else
            shader_set(_swapper.shader);
        
        var _tex = surface_get_texture(arg0);
        texture_set_stage(_swapper.texture[_mode], _tex);
        var _texel_x = texture_get_texel_width(_tex);
        var _texel_y = texture_get_texel_height(_tex);
        var _texel_hx = _texel_x * 0.5;
        var _texel_hy = _texel_y * 0.5;
        shader_set_uniform_f(_swapper.texel_size[_mode], _texel_x, _texel_y);
        shader_set_uniform_f(_swapper.uvs[_mode], _texel_hx, _texel_hy, 1 + _texel_hx, 1 + _texel_hy);
        shader_set_uniform_f(_swapper.index[_mode], arg1);
    }
}

function pal_swap_reset()
{
    if (surface_get_target() == obj_drawcontroller.guisurf)
        shader_set(shd_premultiply);
    else if (shader_current() != -1)
        shader_reset();
}
