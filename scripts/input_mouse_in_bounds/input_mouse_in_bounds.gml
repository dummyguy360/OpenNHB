function input_mouse_in_bounds()
{
    static _global = __input_global();
    
    var _mx, _my;
    
    if (os_type == os_windows)
    {
        _mx = display_mouse_get_x() - window_get_x();
        _my = display_mouse_get_y() - window_get_y();
    }
    else
    {
        _mx = device_mouse_raw_x(_global.__pointer_index);
        _my = device_mouse_raw_y(_global.__pointer_index);
    }
    
    return !(_mx < 0 || _mx >= window_get_width() || _my < 0 || _my >= window_get_height());
}
