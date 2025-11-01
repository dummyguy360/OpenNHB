function ext_buffer_unpack(arg0, arg1 = false)
{
    var _type = buffer_read(arg0, buffer_u8);
    
    switch (_type)
    {
        case 254:
            var _size = buffer_read(arg0, buffer_u16);
            var _array = array_create(_size);
            
            for (var _i = 0; _i < _size; _i++)
                _array[_i] = ext_buffer_unpack(arg0, arg1);
            
            return _array;
        
        case 250:
            _size = buffer_read(arg0, buffer_u16);
            var _elem_type = buffer_read(arg0, buffer_u8);
            _array = array_create(_size);
            
            for (var _i = 0; _i < _size; _i++)
                _array[_i] = buffer_read(arg0, _elem_type);
            
            return _array;
        
        case 255:
            _size = buffer_read(arg0, buffer_u16);
            
            if (arg1)
            {
                var _map = ds_map_create();
                
                for (var _i = 0; _i < _size; _i++)
                {
                    var _key = ext_buffer_unpack(arg0);
                    var _value = ext_buffer_unpack(arg0);
                    ds_map_add(_map, _key, _value);
                }
                
                return _map;
            }
            else
            {
                var _struct = {};
                
                for (var _i = 0; _i < _size; _i++)
                {
                    var _key = ext_buffer_unpack(arg0);
                    var _value = ext_buffer_unpack(arg0);
                    struct_set(_struct, _key, _value);
                }
                
                return _struct;
            }
        
        case 251:
            return undefined;
        
        default:
            return buffer_read(arg0, _type);
    }
}

function ext_buffer_pack(arg0, arg1, arg2 = undefined)
{
    if (is_array(arg1))
    {
        var _length = array_length(arg1);
        buffer_write(arg0, buffer_u8, 254);
        buffer_write(arg0, buffer_u16, _length);
        
        for (var _i = 0; _i < _length; _i++)
            ext_buffer_pack(arg0, arg1[_i], arg2);
    }
    else if (is_struct(arg1))
    {
        var _names = struct_get_names(arg1);
        var _length = array_length(_names);
        buffer_write(arg0, buffer_u8, 255);
        buffer_write(arg0, buffer_u16, _length);
        
        for (var _i = 0; _i < _length; _i++)
        {
            var _key = _names[_i];
            buffer_write(arg0, buffer_string, _key);
            ext_buffer_pack(arg0, variable_struct_get(arg1, _key), arg2);
        }
    }
    else if (!is_undefined(arg2))
    {
        buffer_write(arg0, buffer_u8, arg2);
        
        if (arg2 == 253)
        {
            var _length = is_undefined(arg1) ? 0 : buffer_get_size(arg1);
            var _address = is_undefined(arg1) ? ptr(0) : buffer_get_address(arg1);
            buffer_write(arg0, buffer_u32, _length);
            buffer_write(arg0, buffer_u64, _address);
        }
        else if (arg2 == 252)
        {
            var _address = is_undefined(arg1) ? 0 : arg1;
            buffer_write(arg0, buffer_u64, _address);
        }
        else
        {
            buffer_write(arg0, arg2, arg1);
        }
    }
    else if (is_ptr(arg1))
    {
        buffer_write(arg0, buffer_u8, 252);
        buffer_write(arg0, buffer_u64, arg1);
    }
    else if (is_string(arg1))
    {
        buffer_write(arg0, buffer_u8, 11);
        buffer_write(arg0, buffer_string, arg1);
    }
    else if (is_bool(arg1))
    {
        buffer_write(arg0, buffer_u8, 10);
        buffer_write(arg0, buffer_bool, arg1);
    }
    else if (is_int32(arg1))
    {
        buffer_write(arg0, buffer_u8, 6);
        buffer_write(arg0, buffer_s32, arg1);
    }
    else if (is_int64(arg1))
    {
        buffer_write(arg0, buffer_u8, 12);
        buffer_write(arg0, buffer_u64, arg1);
    }
    else if (is_real(arg1))
    {
        buffer_write(arg0, buffer_u8, 9);
        buffer_write(arg0, buffer_f64, arg1);
    }
    else
    {
        show_debug_message(string("[ERROR] {0} :: Cannot encoding value: '{1}', invalid type.", "gml_Script_ext_buffer_pack", arg1));
    }
}

function ext_pack_args(arg0)
{
    static _ext_args_buffer = buffer_create(1, buffer_grow, 1);
    
    var _length = array_length(arg0);
    buffer_seek(_ext_args_buffer, buffer_seek_start, 0);
    buffer_write(_ext_args_buffer, buffer_u16, _length);
    
    for (var _i = 0; _i < _length; _i++)
    {
        var _arg = arg0[_i];
        ext_buffer_pack(_ext_args_buffer, _arg[0], _arg[1]);
    }
    
    return buffer_get_address(_ext_args_buffer);
}

function ext_return_buffer()
{
    static _return_buffer = buffer_create(2048, buffer_fixed, 1);
    
    buffer_seek(_return_buffer, buffer_seek_start, 0);
    return _return_buffer;
}

function ext_return_buffer_address()
{
    var _buffer = ext_return_buffer();
    buffer_poke(_buffer, 0, buffer_u8, 251);
    return buffer_get_address(_buffer);
}
