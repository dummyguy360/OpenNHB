function input_system_import(arg0)
{
    static _global = __input_global();
    
    var _json;
    
    if (is_string(arg0))
        _json = json_parse(arg0);
    else
        _json = arg0;
    
    if (!is_struct(_json))
    {
        __input_error("Input must be valid JSON (typeof=", typeof(arg0), ")");
        exit;
    }
    
    input_system_reset();
    
    if (!is_struct(variable_struct_get(_json, "__accessibility")))
    {
        if (is_struct(variable_struct_get(_json, "accessibility")))
        {
            _json.__accessibility = variable_struct_get(_json, "accessibility");
            _json.__accessibility.__momentary_state = variable_struct_get(_json.__accessibility, "momentary_state");
            _json.__accessibility.__momentary_verbs = variable_struct_get(_json.__accessibility, "momentary_verbs");
            _json.__accessibility.__cooldown_state = variable_struct_get(_json.__accessibility, "cooldown_state");
            _json.__accessibility.__cooldown_verbs = variable_struct_get(_json.__accessibility, "cooldown_verbs");
        }
        else
        {
            __input_error("Accessibility settings are corrupted");
            exit;
        }
    }
    
    _global.__toggle_momentary_state = _json.__accessibility.__momentary_state;
    _global.__toggle_momentary_dict = {};
    var _momentary_verb_array = _json.__accessibility.__momentary_verbs;
    
    if (!is_array(_momentary_verb_array))
    {
        __input_error("Momentary toggle verbs are corrupted");
        exit;
    }
    
    var _i = 0;
    
    repeat (array_length(_momentary_verb_array))
    {
        variable_struct_set(_global.__toggle_momentary_dict, array_get(_momentary_verb_array, _i), true);
        _i++;
    }
    
    _global.__cooldown_state = _json.__accessibility.__cooldown_state;
    _global.__cooldown_dict = {};
    var _cooldown_verb_array = _json.__accessibility.__cooldown_verbs;
    
    if (!is_array(_cooldown_verb_array))
    {
        __input_error("Cooldown verbs are corrupted");
        exit;
    }
    
    _i = 0;
    
    repeat (array_length(_cooldown_verb_array))
    {
        variable_struct_set(_global.__cooldown_dict, array_get(_cooldown_verb_array, _i), true);
        _i++;
    }
    
    if (!is_struct(variable_struct_get(_json, "__mouse")))
    {
        if (is_struct(variable_struct_get(_json, "mouse")))
        {
            _json.__mouse = variable_struct_get(_json, "mouse");
            input_mouse_capture_set(variable_struct_get(_json.__mouse, "capture"), variable_struct_get(_json.__mouse, "sensitivity"));
        }
        else
        {
            __input_error("Mouse settings are corrupted");
            exit;
        }
    }
    else
    {
        input_mouse_capture_set(_json.__mouse.__capture, _json.__mouse.__sensitivity);
    }
    
    if (!is_array(variable_struct_get(_json, "__players")))
    {
        if (is_array(variable_struct_get(_json, "players")))
        {
            _json.__players = variable_struct_get(_json, "players");
        }
        else
        {
            __input_error("Player settings are corrupted");
            exit;
        }
    }
    
    var _players_array = _json.__players;
    
    if (!is_array(_players_array))
    {
        __input_error("Player settings are corrupted");
        exit;
    }
    
    if (array_length(_players_array) != array_length(_global.__players))
    {
        __input_error("Player settings length mismatch\nFound ", array_length(_players_array), " players in JSON but we are expecting ", array_length(_global.__players), " players");
        exit;
    }
    
    var _p = 0;
    
    repeat (array_length(_players_array))
    {
        with (_global.__players[_p])
            __import(_players_array[_p]);
        
        _p++;
    }
}
