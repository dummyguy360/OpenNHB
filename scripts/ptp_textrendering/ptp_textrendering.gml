function __ptp_draw_text(arg0, arg1, arg2, arg3 = 1, arg4 = 1, arg5 = 0, arg6 = draw_get_color(), arg7 = draw_get_color(), arg8 = draw_get_color(), arg9 = draw_get_color(), arg10 = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_transformed_colour(arg0 - 0.01, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}

function __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5 = 1, arg6 = 1, arg7 = 0, arg8 = draw_get_color(), arg9 = draw_get_color(), arg10 = draw_get_color(), arg11 = draw_get_color(), arg12 = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_ext_transformed_colour(arg0 - 0.01, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}

function __draw_text_hook(arg0, arg1, arg2)
{
    __ptp_draw_text(arg0, arg1, arg2);
}

function __draw_text_ext_hook(arg0, arg1, arg2, arg3, arg4)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4);
}

function __draw_text_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    __ptp_draw_text(arg0, arg1, arg2, 1, 1, 0, arg3, arg4, arg5, arg6, arg7);
}

function __draw_text_transformed_hook(arg0, arg1, arg2, arg3, arg4, arg5)
{
    __ptp_draw_text(arg0, arg1, arg2, arg3, arg4, arg5);
}

function __draw_text_ext_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, 1, 1, 0, arg5, arg6, arg7, arg8, arg9);
}

function __draw_text_ext_transformed_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

function __draw_text_transformed_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
    __ptp_draw_text(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
}

function __draw_text_ext_transformed_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
}

function define_font_globals()
{
    global.FONTEXTRA = [];
    global.FONTEXTRA[global.font] = [spr_controllerbuttons, spr_keyboardkey, spr_keyfunctions, global.keyfont, 40, 0, 0, 6];
    global.FONTEXTRA[global.toonfont] = [spr_controllerbuttons, spr_keyboardkey, spr_keyfunctions, global.keyfont, 40, 0, 0, 6];
    global.FONTEXTRA[font_warning] = [spr_controllerbuttons, spr_keyboardkey, spr_keyfunctions, global.keyfont, 40, 0, 0, 0];
    global.FONTDEF = 
	[
		["font_caption", font_caption], 
		["font_debug", font_debug], 
		["font_warning", font_warning], 
		["font_fat", global.font], 
		["font_toon", global.toonfont]
	];
    global.COLOURDEF = 
	[
		["c_aqua", c_aqua], 
		["c_black", c_black], 
		["c_blue", c_blue], 
		["c_dkgrey", 4210752], 
		["c_fuchsia", c_fuchsia], 
		["c_grey", c_grey], 
		["c_green", c_green], 
		["c_lime", c_lime], 
		["c_ltgrey", c_ltgrey], 
		["c_maroon", c_maroon], 
		["c_navy", c_navy], 
		["c_olive", c_olive], 
		["c_purple", c_purple], 
		["c_red", c_red], 
		["c_silver", c_silver], 
		["c_teal", c_teal], 
		["c_white", c_white], 
		["c_yellow", c_yellow]
	];
}

function draw_input(arg0, arg1, arg2, arg3, arg4, arg5 = true, arg6 = input_profile_get(), arg7 = 0, arg8 = spr_controllerbuttons, arg9 = spr_keyboardkey, arg10 = spr_keyfunctions, arg11 = global.keyfont, arg12 = 0)
{
    var _width = 0;
    var _height = 0;
    var _rotxoff = 0;
    var _rotyoff = 0;
    
    if (arg4 != "any")
    {
        var _icon = input_verb_get_icon(arg4, 0, arg7, arg6);
        
        if (is_struct(_icon) || is_string(_icon))
        {
            if (arg3 != 0)
            {
                _width = sprite_get_width(arg9);
                _height = sprite_get_height(arg9);
                _rotxoff = (_width / 2) - lengthdir_x(_width / 2, arg3);
                _rotyoff = (_height / 2) - lengthdir_y(_height / 2, arg3 - 90);
                _rotxoff -= ((_height / 2) - lengthdir_y(_height / 2, arg3) - (_height / 2));
                _rotyoff -= ((_width / 2) - lengthdir_x(_width / 2, arg3 - 90) - (_width / 2));
            }
            
            draw_sprite_ext(arg9, 0, arg0 + _rotxoff, arg1 + _rotyoff, 1, 1, arg3, c_white, arg2);
            
            if (is_string(_icon))
            {
                var _prevfont = draw_get_font();
                draw_set_font(arg11);
                
                if (arg3 != 0)
                {
                    _width = string_width(_icon);
                    _height = string_height(_icon);
                    _rotxoff = (_width / 2) - lengthdir_x(_width / 2, arg3);
                    _rotyoff = (_height / 2) - lengthdir_y(_height / 2, arg3 - 90);
                    _rotxoff -= ((_height / 2) - lengthdir_y(_height / 2, arg3) - (_height / 2));
                    _rotyoff -= ((_width / 2) - lengthdir_x(_width / 2, arg3 - 90) - (_width / 2));
                }
                
                __draw_text_transformed_colour_hook(arg0 + _rotxoff, arg1 + _rotyoff, _icon, 1, 1, arg3, arg12, arg12, arg12, arg12, arg2);
                draw_set_font(_prevfont);
            }
            else
            {
                if (arg3 != 0)
                {
                    _width = sprite_get_width(arg10);
                    _height = sprite_get_height(arg10);
                    _rotxoff = (_width / 2) - lengthdir_x(_width / 2, arg3);
                    _rotyoff = (_height / 2) - lengthdir_y(_height / 2, arg3 - 90);
                    _rotxoff -= ((_height / 2) - lengthdir_y(_height / 2, arg3) - (_height / 2));
                    _rotyoff -= ((_width / 2) - lengthdir_x(_width / 2, arg3 - 90) - (_width / 2));
                }
                
                draw_sprite_ext(arg10, _icon.key, arg0 + _rotxoff, arg1 + _rotyoff, 1, 1, arg3, arg12, arg2);
            }
        }
        else
        {
            var _ind = _icon;
            
            if (arg5)
            {
                switch (_ind)
                {
                    case 7:
                    case 15:
                    case 20:
                        _ind = 39;
                        break;
                    
                    case 5:
                    case 13:
                    case 18:
                        _ind = 37;
                        break;
                    
                    case 6:
                    case 14:
                    case 19:
                        _ind = 38;
                        break;
                    
                    case 4:
                    case 12:
                    case 17:
                        _ind = 36;
                        break;
                }
            }
            
            if (arg3 != 0)
            {
                _width = sprite_get_width(arg8);
                _height = sprite_get_height(arg8);
                _rotxoff = (_width / 2) - lengthdir_x(_width / 2, arg3);
                _rotyoff = (_height / 2) - lengthdir_y(_height / 2, arg3 - 90);
                _rotxoff -= ((_height / 2) - lengthdir_y(_height / 2, arg3) - (_height / 2));
                _rotyoff -= ((_width / 2) - lengthdir_x(_width / 2, arg3 - 90) - (_width / 2));
            }
            
            draw_sprite_ext(arg8, _ind, arg0 + _rotxoff, arg1 + _rotyoff, 1, 1, arg3, c_white, arg2);
        }
    }
    else
    {
        if (arg3 != 0)
        {
            _width = sprite_get_width(arg8);
            _height = sprite_get_height(arg8);
            _rotxoff = (_width / 2) - lengthdir_x(_width / 2, arg3);
            _rotyoff = (_height / 2) - lengthdir_y(_height / 2, arg3 - 90);
            _rotxoff -= ((_height / 2) - lengthdir_y(_height / 2, arg3) - (_height / 2));
            _rotyoff -= ((_width / 2) - lengthdir_x(_width / 2, arg3 - 90) - (_width / 2));
        }
        
        draw_sprite_ext(arg8, 35, arg0 + _rotxoff, arg1 + _rotyoff, 1, 1, arg3, c_white, arg2);
    }
}

function string_clean(arg0)
{
    arg0 = string_replace_all(arg0, "{S}", "");
    arg0 = string_replace_all(arg0, "{V}", "");
    arg0 = string_replace_all(arg0, "{W}", "");
    arg0 = string_replace_all(arg0, "{R}", "");
    arg0 = string_replace_all(arg0, "{/}", "");
    arg0 = string_replace_all(arg0, "{/S}", "");
    arg0 = string_replace_all(arg0, "{/V}", "");
    arg0 = string_replace_all(arg0, "{/W}", "");
    arg0 = string_replace_all(arg0, "{/R}", "");
    arg0 = string_replace_all(arg0, "{/H}", "");
    arg0 = string_replace_all(arg0, "{/C}", "");
    arg0 = string_replace_all(arg0, "{/F}", "");
    
    repeat (string_count("{H:", arg0))
    {
        var _hyperlinkstart = string_pos("{H:", arg0);
        var _hyperlinkend = string_pos_ext("}", arg0, _hyperlinkstart);
        arg0 = string_delete(arg0, _hyperlinkstart, (_hyperlinkend + 1) - _hyperlinkstart);
    }
    
    repeat (string_count("{C:", arg0))
    {
        var _colstart = string_pos("{C:", arg0);
        var _colend = string_pos_ext("}", arg0, _colstart);
        arg0 = string_delete(arg0, _colstart, (_colend + 1) - _colstart);
    }
    
    repeat (string_count("{F:", arg0))
    {
        var _fontstart = string_pos("{F:", arg0);
        var _fontend = string_pos_ext("}", arg0, _fontstart);
        arg0 = string_delete(arg0, _fontstart, (_fontend + 1) - _fontstart);
    }
    
    return arg0;
}

function string_width_fancy(arg0)
{
    var _width = 0;
    var _font = draw_get_font();
    arg0 = string_clean(arg0);
    var _arrays = ds_map_keys_to_array(global.inputs);
    
    for (var _i = 0; _i < array_length(_arrays); _i++)
    {
        _width += (global.FONTEXTRA[_font][4] * string_count(_arrays[_i], arg0));
        arg0 = string_replace_all(arg0, _arrays[_i], "");
    }
    
    _width += string_width(arg0);
    return _width;
}

function string_height_fancy(arg0)
{
    var _height = 0;
    var _font = draw_get_font();
    arg0 = string_clean(arg0);
    var _strh = string_height("A");
    _height += ((string_count("\n", arg0) + 1) * _strh);
    _height += (string_count("\n", arg0) * global.FONTEXTRA[_font][7]);
    var _arrays = ds_map_keys_to_array(global.inputs);
    
    for (var _i = 0; _i < array_length(_arrays); _i++)
    {
        if (string_count(_arrays[_i], arg0))
        {
            _height += (_strh - global.FONTEXTRA[_font][4]);
            break;
        }
    }
    
    return _height;
}

function draw_text_fancy(arg0, arg1, arg2, arg3 = c_white, arg4 = 1, arg5 = true, arg6 = input_profile_get(), arg7 = 0, arg8 = false)
{
    var _font = draw_get_font();
    var _halign = draw_get_halign();
    var _valign = draw_get_valign();
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_set_colour(arg3);
    var _width = -5;
    var _lines = string_split(arg2, "\n");
    
    for (var l = 0; l < array_length(_lines); l++)
    {
        if (string_width(_lines[l]) > _width)
            _width = string_width_fancy(_lines[l]);
    }
    
    var _startingx = arg0;
    var _firstline = string_copy(arg2, 1, string_pos("\n", arg2));
    
    if (string_pos("\n", arg2) == 0)
        _firstline = arg2;
    
    if (_halign == 1)
        arg0 -= (string_width_fancy(_firstline) / 2);
    else if (_halign == 2)
        arg0 -= string_width_fancy(_firstline);
    
    var _lineheight = string_height("A") + global.FONTEXTRA[_font][7];
    var _height = (string_count("\n", arg2) + 1) * _lineheight;
    
    if (_valign == 1)
        arg1 -= (_height / 2);
    else if (_valign == 2)
        arg1 -= _height;
    
    var _frame = floor(current_time / 16.666666666666668);
    var _shake = false;
    var _vertshake = false;
    var _wave = false;
    var _rotwave = false;
    var _hyperlink = -1;
    var _codefont = draw_get_font();
    var _codecolour = draw_get_colour();
    var _vertshakedir = floor(_frame / 2) % 2;
    var _drawinputs = [];
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(_codefont);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    for (var i = 1; i < (string_length(arg2) + 1); i++)
    {
        var _char = string_char_at(arg2, i);
        var _input = string_copy(arg2, i, 3);
        var _xoff = 0;
        var _yoff = 0;
        var _rotoff = 0;
        
        if (_char == "\n")
        {
            arg1 += _lineheight;
            var _nextlineendpos = string_pos_ext("\n", arg2, i + 1);
            
            if (_nextlineendpos == 0)
                _nextlineendpos = string_length(arg2);
            
            _nextlineendpos -= i;
            var _nextlinestr = string_copy(arg2, i + 1, _nextlineendpos);
            arg0 = _startingx;
            
            if (_halign == 1)
                arg0 -= (string_width_fancy(_nextlinestr) / 2);
            
            if (_halign == 2)
                arg0 -= string_width_fancy(_nextlinestr);
        }
        else
        {
			switch (_input)
            {
                case "{S}":
                    _shake = true;
                    i += 2;
                    break;
					
                case "{V}":
                    _vertshake = true;
                    i += 2;
                    break;
					
                case "{W}":
                    _wave = true;
                    i += 2;
                    break;
					
                case "{R}":
                    _rotwave = true;
                    i += 2;
                    break;
					
                case "{H:":
                    i += 2;
                    var _startpos = i + 1;
                    var _endpos = string_pos_ext("}", arg2, i);
                    i = _endpos;
                    _hyperlink = string_copy(arg2, _startpos, (_endpos - _startpos));
                    break;
					
                case "{F:":
                    i += 2;
                    _startpos = i + 1;
                    _endpos = string_pos_ext("}", arg2, i);
                    i = _endpos;
                    var _fnt = string_copy(arg2, _startpos, (_endpos - _startpos));
                    var f = 0;
					
                    while (f < array_length(global.FONTDEF))
                    {
                        if (global.FONTDEF[f][0] == _fnt)
                        {
                            draw_set_font(global.FONTDEF[f][1]);
                            _font = global.FONTDEF[f][1];
                            break;
                        }
                        else
                        {
                            f++
                            continue;
                        }
                    }
                    break;
					
                case "{C:":
                    i += 2;
                    _startpos = i + 1;
                    _endpos = string_pos_ext("}", arg2, i);
                    i = _endpos;
                    var _col = string_copy(arg2, _startpos, (_endpos - _startpos));
                    var _colset = false;
                    var c = 0;
					
                    while (c < array_length(global.COLOURDEF))
                    {
                        if (global.COLOURDEF[c][0] == _col)
                        {
                            draw_set_colour(global.COLOURDEF[c][1]);
                            arg3 = global.COLOURDEF[c][1];
                            _colset = true;
                            break;
                        }
                        else
                        {
                            c++
                            continue;
                        }
                    }
                    if (_colset == false)
                    {
                        var _hexcol = hexstr_to_col(_col);
                        draw_set_colour(_hexcol);
                        arg3 = _hexcol;
                    }
                    break;
					
                case "{/S":
                    _shake = false;
                    i += 3;
                    break;
					
                case "{/V":
                    _vertshake = false;
                    i += 3;
                    break;
					
                case "{/W":
                    _wave = false;
                    i += 3;
                    break;
					
                case "{/R":
                    _rotwave = false;
                    i += 3;
                    break;
					
                case "{/H":
                    _hyperlink = -1;
                    i += 3;
                    break;
					
                case "{/F":
                    draw_set_font(_codefont);
                    _font = _codefont;
                    i += 3;
                    break;
					
                case "{/C":
                    draw_set_colour(_codecolour);
                    arg3 = _codecolour;
                    i += 3;
                    break;
					
                case "{/}":
                    _shake = false;
                    _vertshake = false;
                    _wave = false;
                    _rotwave = false;
                    _hyperlink = -1;
                    draw_set_font(_codefont);
                    draw_set_colour(_codecolour);
                    arg3 = _codecolour;
                    i += 2;
                    break;
					
                default:
                    if (!game_paused() || arg8)
                    {
                        if (_shake)
                        {
                            _xoff = irandom_range(-1, 1);
                            _yoff = irandom_range(-1, 1);
                        }
						
                        _vertshakedir = !_vertshakedir;
						
                        if (_vertshake)
                            _yoff = _vertshakedir;
                        if (_wave)
                            _yoff = wave(-2, 2, 1, ((i - 1) * 250));
                        if (_rotwave)
                            _rotoff = wave(-12, 12, 1, ((i - 1) * 50));
                    }
                    if !is_undefined(ds_map_find_value(global.inputs, _input))
                    {
                        var _verb = ds_map_find_value(global.inputs, _input);
                        array_push(_drawinputs, [round(arg0 + global.FONTEXTRA[_font][5] + _xoff), round(arg1 + global.FONTEXTRA[_font][6] + _yoff), _rotoff, _verb, _font]);
                        arg0 += global.FONTEXTRA[_font][4];
                        i += 2;
                        break;
                    }
                    else
                    {
                        _width = string_width(_char);
                        _height = string_height(_char);
                        _rotxoff = _width / 2 - (lengthdir_x((_width / 2), _rotoff));
                        _rotyoff = _height / 2 - (lengthdir_y((_height / 2), (_rotoff - 90)));
                        _rotxoff -= (_height / 2 - (lengthdir_y((_height / 2), _rotoff)) - _height / 2);
                        _rotyoff -= (_width / 2 - (lengthdir_x((_width / 2), (_rotoff - 90))) - _width / 2);
                        var _charx = (round(arg0 + _xoff)) + _rotxoff;
                        var _chary = (round(arg1 + _yoff)) + _rotyoff;
                        draw_text_transformed_colour(_charx, _chary, _char, 1, 1, _rotoff, arg3, arg3, arg3, arg3, arg4);
                        _prevshader = shader_current();
                        var _prevalpha = draw_get_alpha();
                        shader_reset();
                        draw_set_alpha(arg4);
						
                        if (_hyperlink != -1)
                        {
                            draw_line((_charx - 1), (_chary + string_height(_char)), (_charx + string_width(_char) + 1), (_chary + string_height(_char)));
                            if point_in_rectangle(global.screenmouse_x, global.screenmouse_y, (_charx - 1), (_chary - 1), (_charx + string_width(_char) + 1), (_chary + _lineheight))
                            {
                                obj_drawcontroller.hovering = true;
                                obj_drawcontroller.clicklink = _hyperlink;
                                obj_drawcontroller.alarm[0] = 2;
                            }
                        }
						
                        draw_set_alpha(_prevalpha);
                        shader_set(_prevshader);
                        arg0 += string_width(_char);
                    }
            }
        }
    }
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
    
    for (var _i = 0; _i < array_length(_drawinputs); _i++)
        draw_input(_drawinputs[_i][0], _drawinputs[_i][1], arg4, _drawinputs[_i][2], _drawinputs[_i][3], arg5, arg6, arg7, global.FONTEXTRA[_drawinputs[_i][4]][0], global.FONTEXTRA[_drawinputs[_i][4]][1], global.FONTEXTRA[_drawinputs[_i][4]][2], global.FONTEXTRA[_drawinputs[_i][4]][3]);
    
    draw_set_halign(_halign);
    draw_set_valign(_valign);
    draw_set_font(_codefont);
    draw_set_colour(_codecolour);
}
