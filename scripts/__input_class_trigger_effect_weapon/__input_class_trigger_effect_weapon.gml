function __input_class_trigger_effect_weapon(arg0, arg1, arg2, arg3) constructor
{
    static __mode_name = "weapon";
    static __mode = UnknownEnum.Value_2;
    
    static __apply_ps5 = function(arg0, arg1, arg2)
    {
        return ps5_gamepad_set_trigger_effect_weapon(arg0, arg1, variable_struct_get(__params, "start_position"), variable_struct_get(__params, "end_position"), variable_struct_get(__params, "strength") * arg2);
    };
    
    static __steam_get_state = function(arg0, arg1)
    {
        var _trigger_value = input_gamepad_value(arg0, arg1);
        
        if (_trigger_value > (min(9.9, variable_struct_get(__params, "end_position") + 2) / 10))
            return UnknownEnum.Value_5;
        else if (_trigger_value >= (variable_struct_get(__params, "start_position") / 10))
            return UnknownEnum.Value_4;
        
        return UnknownEnum.Value_3;
    };
    
    __params = {};
    variable_struct_set(__params, "start_position", clamp(arg1 * 10, 2, 7));
    variable_struct_set(__params, "end_position", clamp(arg2 * 10, max(arg2 * 10, arg1 * 10), 8));
    variable_struct_set(__params, "strength", clamp(arg3 * 8, 0, 8));
}
