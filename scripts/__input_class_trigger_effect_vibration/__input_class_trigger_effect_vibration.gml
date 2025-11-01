function __input_class_trigger_effect_vibration(arg0, arg1, arg2) constructor
{
    static __mode_name = "vibration";
    static __mode = UnknownEnum.Value_3;
    
    static __apply_ps5 = function(arg0, arg1, arg2)
    {
        return ps5_gamepad_set_trigger_effect_vibration(arg0, arg1, variable_struct_get(__params, "position"), variable_struct_get(__params, "amplitude") * arg2, variable_struct_get(__params, "frequency"));
    };
    
    static __steam_get_state = function(arg0, arg1)
    {
        if (input_gamepad_value(arg0, arg1) >= (variable_struct_get(__params, "position") / 10))
            return UnknownEnum.Value_7;
        
        return UnknownEnum.Value_6;
    };
    
    __params = {};
    variable_struct_set(__params, "position", clamp(arg0 * 10, 0, 9));
    variable_struct_set(__params, "amplitude", clamp(arg1 * 8, 0, 8));
    variable_struct_set(__params, "frequency", clamp(arg2 * 255, 0, 255));
}
