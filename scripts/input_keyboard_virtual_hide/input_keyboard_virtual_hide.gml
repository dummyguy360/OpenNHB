function input_keyboard_virtual_hide()
{
    static _global = __input_global();
    
    if (_global.__using_steamworks)
    {
        steam_dismiss_floating_gamepad_text_input();
    }
    else if (keyboard_virtual_status() || os_type == os_android)
    {
        if (!(os_type == os_windows))
            keyboard_virtual_hide();
    }
}
