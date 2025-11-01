function __input_class_trigger_effect_feedback(arg0, arg1) constructor
{
    static __mode_name = "feedback";
    static __mode = UnknownEnum.Value_1;
    
    static __steam_get_state = function(arg0, arg1)
    {
        if (input_gamepad_value(arg0, arg1) >= (variable_struct_get(__params, "position") / 10))
            return UnknownEnum.Value_2;
        
        return UnknownEnum.Value_1;
    };
    
    static __apply_ps5 = function(arg0, arg1, arg2)
    {
        return ps5_gamepad_set_trigger_effect_feedback(arg0, arg1, variable_struct_get(__params, "position"), variable_struct_get(__params, "strength") * arg2);
    };
    
    __params = {};
    variable_struct_set(__params, "position", clamp(arg0 * 10, 0, 9));
    variable_struct_set(__params, "strength", clamp(arg1 * 8, 0, 8));
}
