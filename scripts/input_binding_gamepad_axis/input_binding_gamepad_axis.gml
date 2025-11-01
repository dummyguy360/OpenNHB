function input_binding_gamepad_axis(arg0, arg1)
{
    __input_initialize();
    
    if ((os_type == os_switch || ((os_type == os_ios || os_type == os_tvos) && !(false || os_type == os_gxgames))) && (arg0 == 32775 || arg0 == 32776))
        return new __input_class_binding().__set_gamepad_button(arg0);
    
    return new __input_class_binding().__set_gamepad_axis(arg0, arg1);
}
