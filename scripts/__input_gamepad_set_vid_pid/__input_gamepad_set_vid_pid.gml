function __input_gamepad_set_vid_pid()
{
    if (false || os_type == os_gxgames)
    {
        __vendor = "";
        __product = "";
        __xinput = undefined;
        
        if (os_type == os_gxgames)
        {
        }
        else
        {
            var _vendor_pos = string_pos("Vendor: ", __description);
            var _product_pos = string_pos("Product: ", __description);
            
            if (_vendor_pos > 0 && _product_pos > 0)
            {
                __vendor = string_copy(__description, _vendor_pos + 8, 4);
                __product = string_copy(__description, _product_pos + 9, 4);
                __description = string_copy(__description, 1, _vendor_pos - 1);
            }
            else
            {
                var _firefoxy = false;
                var _hyphen_count = string_count("-", __description);
                var _vendor_slice, _product_slice, _work_string;
                
                if (_hyphen_count >= 2)
                {
                    _work_string = __description;
                    var _hyphen_pos = string_pos("-", _work_string);
                    _vendor_slice = string_copy(_work_string, 1, _hyphen_pos - 1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    _hyphen_pos = string_pos("-", _work_string);
                    _product_slice = string_copy(_work_string, 1, _hyphen_pos - 1);
                    _work_string = string_delete(_work_string, 1, _hyphen_pos);
                    
                    repeat (4 - string_length(_vendor_slice))
                        _vendor_slice = "0" + _vendor_slice;
                    
                    repeat (4 - string_length(_product_slice))
                        _product_slice = "0" + _product_slice;
                    
                    _vendor_slice = string_copy(_vendor_slice, 1, 4);
                    _product_slice = string_copy(_product_slice, 1, 4);
                    _firefoxy = true;
                    var _i = 1;
                    
                    repeat (4)
                    {
                        var _ord = ord(string_char_at(_vendor_slice, _i));
                        
                        if (!((_ord >= 48 && _ord <= 57) || (_ord >= 65 && _ord <= 70) || (_ord >= 97 && _ord <= 102)))
                        {
                            _firefoxy = false;
                            break;
                        }
                        
                        _i++;
                    }
                }
                
                if (_firefoxy)
                {
                    __vendor = _vendor_slice;
                    __product = _product_slice;
                    __description = _work_string;
                }
                else
                {
                    __input_trace("Gamepad __description could not be parsed. Bindings for this gamepad may be incorrect (was \"", __description, "\")");
                }
            }
            
            if (is_string(__vendor))
                __vendor = string_copy(__vendor, 3, 2) + string_copy(__vendor, 1, 2);
            
            if (is_string(__product))
                __product = string_copy(__product, 3, 2) + string_copy(__product, 1, 2);
        }
    }
    else if (!(false || os_type == os_gxgames) && (__input_global().__on_desktop || os_type == os_android))
    {
        if (os_type == os_windows)
        {
            var _legacy = __input_string_contains(__guid, "000000000000504944564944");
            var _result = __input_gamepad_guid_parse(__guid, _legacy, false);
            __vendor = _result.vendor;
            __product = _result.product;
            __xinput = __index < 4 && gamepad_get_description(__index) == "XInput STANDARD GAMEPAD";
        }
        else if (os_type == os_macosx || os_type == os_linux || os_type == os_android)
        {
            var _result = __input_gamepad_guid_parse(__guid, false, false);
            __vendor = _result.vendor;
            __product = _result.product;
            __xinput = undefined;
        }
        else
        {
            __input_trace("Warning! OS type check fell through unexpectedly (os_type = ", os_type, ")");
            __description = gamepad_get_description(__index);
            __vendor = "";
            __product = "";
            __xinput = undefined;
        }
    }
    else
    {
        __description = gamepad_get_description(__index);
        __vendor = "";
        __product = "";
        __xinput = undefined;
    }
}
