draw_set_font(global.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

with (obj_drawcontroller)
{
    surface_reset_target();
    surface_set_target(guisurf);
}

bgqueue = array_unique(bgqueue, -1, -infinity);
bgqueue = array_reverse(bgqueue);
array_foreach(bgqueue, function(arg0, arg1)
{
    draw_sprite_tiled_ext(arg0.background, -1, bgx, bgy, 1, 1, c_white, arg0.fade);
    arg0.fade += arg0.dofade ? -0.1 : 0.1;
    arg0.fade = clamp(arg0.fade, 0, 1);
});
bgqueue = array_filter(bgqueue, function(arg0, arg1)
{
    return arg0.fade > 0;
});
ds_stack_top(optionstack).drawoptions();
draw_set_font(global.font);
draw_set_valign(fa_bottom);
draw_set_halign(fa_left);
draw_text_fancy(20, get_game_height() - 20, optiontip);
