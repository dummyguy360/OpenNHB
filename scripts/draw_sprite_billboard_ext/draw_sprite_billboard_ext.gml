function draw_sprite_billboard_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
    shader_set(shd_billboard);
    
    if (arg10 == true)
        pal_swap_set(palettespr, curpalette, false);
    
    matrix_set(2, matrix_build(arg2, arg3, arg4, 0, 0, 0, 1, 1, 1));
    draw_sprite_ext(arg0, arg1, 0, 0, arg5, arg6, arg7, arg8, arg9);
    matrix_set(2, matrix_build_identity());
    shader_reset();
}

function draw_sprite_3d_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    matrix_set(2, matrix_build(arg2, arg3, arg4, 0, 0, 0, 1, 1, 1));
    draw_sprite_ext(arg0, arg1, 0, 0, arg5, arg6, arg7, arg8, arg9);
    matrix_set(2, matrix_build_identity());
}

function draw_text_billboard(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = draw_get_colour(), arg8 = draw_get_colour(), arg9 = draw_get_colour(), arg10 = draw_get_colour(), arg11 = draw_get_alpha())
{
    shader_set(shd_billboard);
    matrix_set(2, matrix_build(arg0, arg1, arg2, 0, 0, 0, 1, 1, 1));
    __draw_text_transformed_colour_hook(0, 0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    matrix_set(2, matrix_build_identity());
    shader_reset();
}
