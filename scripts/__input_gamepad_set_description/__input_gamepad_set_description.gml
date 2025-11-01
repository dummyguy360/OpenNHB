function __input_gamepad_set_description()
{
    if (__xinput || (os_type == os_xboxone || os_type == os_gdk))
    {
        __description = "XInput";
    }
    else if (os_type == os_gxgames)
    {
        __description = "";
        var _work_string = __guid;
        var _i = 1;
        
        repeat (string_length(_work_string) div 2)
        {
            var _ord_msf = string_byte_at(_work_string, _i);
            var _ord_lsf = string_byte_at(_work_string, _i + 1);
            var _value = (((_ord_msf >= 97) ? (_ord_msf - 87) : (_ord_msf - 48)) << 4) | ((_ord_lsf >= 97) ? (_ord_lsf - 87) : (_ord_lsf - 48));
            __description += chr(_value);
            _i += 2;
        }
    }
    else if (!(!(false || os_type == os_gxgames) && (__input_global().__on_desktop || os_type == os_android)))
    {
        __input_trace("SDL2 remapping unsupported for this platform");
        __description = gamepad_get_description(__index);
    }
    else
    {
    }
}
