function array_get_undefined(arg0, arg1)
{
    try
    {
        return array_get(arg0, arg1);
    }
    catch (_ex)
    {
        return undefined;
    }
}

function roundlower(arg0)
{
    if (frac(arg0) <= 0.5)
        return floor(arg0);
    
    if (frac(arg0) > 0.5)
        return ceil(arg0);
}

function array_find_pos(arg0, arg1)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] == arg1)
            return i;
    }
    
    return -1;
}

function object_is_parent_or_ancestor(arg0, arg1 = object_index)
{
    return arg1 == arg0 || object_is_ancestor(arg1, arg0);
}

function check_in_rect(arg0, arg1, arg2, arg3, arg4)
{
    return point_in_rectangle(arg0.x, arg0.y, arg1, arg3, arg2, arg4);
}

function string_padzeros(arg0, arg1 = true, arg2 = 2)
{
    var _str = "";
    
    repeat (arg2 - string_length(string(arg0)))
        _str += "0";
    
    if (arg1)
        return _str + string(arg0);
    
    if (!arg1)
        return string(arg0) + _str;
}

function struct_equals(arg0, arg1)
{
    var _varA = variable_struct_get_names(arg0);
    var _varB = variable_struct_get_names(arg1);
    
    if (array_length(_varA) != array_length(_varB))
        return false;
    
    for (var i = 0; i < array_length(_varA); i++)
    {
        if (!variable_struct_exists(arg1, _varA[i]) || !variable_struct_exists(arg0, _varB[i]))
            return false;
        
        var _n = _varA[i];
        var _valtype = typeof(variable_struct_get(arg0, _n));
        
        if (typeof(variable_struct_get(arg1, _n)) != _valtype)
            return false;
        
        switch (_valtype)
        {
            case "struct":
                if (!struct_equals(variable_struct_get(arg0, _n), variable_struct_get(arg1, _n)))
                    return false;
                
                break;
            
            case "array":
                if (!array_equals(variable_struct_get(arg0, _n), variable_struct_get(arg1, _n)))
                    return false;
                
                break;
            
            default:
                if (variable_struct_get(arg0, _n) != variable_struct_get(arg1, _n))
                    return false;
        }
    }
    
    return true;
}

function sprite_animation_end(arg0 = sprite_index, arg1 = image_index, arg2 = sprite_get_number(arg0), arg3 = image_speed)
{
    return (arg1 + ((arg3 * sprite_get_speed(arg0)) / ((sprite_get_speed_type(arg0) == 1) ? 1 : game_get_speed(gamespeed_fps)))) >= arg2;
}

function count_in_room(arg0, arg1)
{
    if (is_array(arg0))
    {
        var _count = 0;
        
        for (var i = 0; i < array_length(arg0); i++)
            _count += count_in_room(arg0[i], arg1);
        
        return _count;
    }
    else
    {
        var _info = room_get_info(arg0, false, true, false, false, false);
        return array_length(array_filter(_info.instances, arg1));
    }
}

function loop_in_room(arg0, arg1)
{
    if (is_array(arg0))
    {
        for (var i = 0; i < array_length(arg0); i++)
            loop_in_room(arg0[i], arg1);
    }
    else
    {
        var _info = room_get_info(arg0, false, true, false, false, false);
        array_foreach(_info.instances, arg1);
    }
}

function running_on_steamdeck()
{
    return environment_get_variable("SteamDeck") == "1";
}

function hexstr_to_col(arg0)
{
    if (string_char_at(arg0, 0) == "#")
        arg0 = string_copy(arg0, 2, string_length(arg0) - 1);
    
    arg0 = string_upper(arg0);
    arg0 = string_copy(arg0, 5, 2) + string_copy(arg0, 3, 2) + string_copy(arg0, 1, 2);
    var _hex = "0123456789ABCDEF";
    var _colour = 0;
    
    for (var i = 1; i < (string_length(arg0) + 1); i++)
        _colour = (_colour << 4) + (string_pos(string_char_at(arg0, i), _hex) - 1);
    
    return _colour;
}

function surface_fallback(arg0)
{
    if (!surface_format_is_supported(arg0))
    {
        trace("Platform does not support format ", arg0, "! Falling back to standard surface format...");
        return 6;
    }
    
    return arg0;
}

function game_paused()
{
    return global.gamePaused || global.mapOpen || global.noControlType;
}

function add_saveroom(arg0 = id, arg1 = global.saveroom)
{
    ds_map_add(arg1, arg0, true);
}

function in_saveroom(arg0 = id, arg1 = global.saveroom)
{
    return ds_map_exists(arg1, arg0);
}
