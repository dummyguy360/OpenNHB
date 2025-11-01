function DotobjMaterialLoad()
{
    var _library_name = argument[0];
    var _buffer = argument[1];
    var _directory = (argument_count > 2 && argument[2] != undefined) ? argument[2] : "";
    
    if (string_char_at(_directory, string_length(_directory)) != "\\")
        _directory += "\\";
    
    var _line_data_list = ds_list_create();
    var _material_struct = undefined;
    var _texture_struct = undefined;
    var _meta_line = 0;
    var _buffer_size = buffer_get_size(_buffer);
    var _old_tell = buffer_tell(_buffer);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _line_started = false;
    var _value_read_start = 0;
    var _b = 0;
    
    repeat (_buffer_size + 1)
    {
        var _value;
        
        if (_b < _buffer_size)
        {
            _value = buffer_read(_buffer, buffer_u8);
            _b++;
        }
        else
        {
            _value = 0;
        }
        
        if (!_line_started)
        {
            if (_value > 32)
            {
                _value_read_start = buffer_tell(_buffer) - 1;
                _line_started = true;
            }
        }
        else if (_value == 0 || _value == 10 || _value == 13 || _value == 32)
        {
            if (_value != 0)
                buffer_poke(_buffer, buffer_tell(_buffer) - 1, buffer_u8, 0);
            
            buffer_seek(_buffer, buffer_seek_start, _value_read_start);
            ds_list_add(_line_data_list, buffer_read(_buffer, buffer_string));
            _value_read_start = buffer_tell(_buffer);
            
            if (_value != 32)
            {
                if (ds_list_find_value(_line_data_list, 0) == "newmtl")
                {
                    var _material_name = "";
                    var _i = 1;
                    var _size = ds_list_size(_line_data_list);
                    
                    repeat (_size - 1)
                    {
                        _material_name += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                        _i++;
                    }
                    
                    _material_struct = __DotobjEnsureMaterial(_library_name, _material_name);
                }
                else if (ds_list_find_value(_line_data_list, 0) == "#")
                {
                }
                else if (!is_struct(_material_struct))
                {
                }
                else
                {
                    switch (ds_list_find_value(_line_data_list, 0))
                    {
                        case "Ka":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "spectral":
                                    break;
                                
                                case "xyz":
                                    break;
                                
                                default:
                                    _material_struct.ambient = make_colour_rgb(255 * real(ds_list_find_value(_line_data_list, 1)), 255 * real(ds_list_find_value(_line_data_list, 2)), 255 * real(ds_list_find_value(_line_data_list, 3)));
                                    break;
                            }
                            
                            break;
                        
                        case "Kd":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "spectral":
                                    break;
                                
                                case "xyz":
                                    break;
                                
                                default:
                                    _material_struct.diffuse = make_colour_rgb(255 * real(ds_list_find_value(_line_data_list, 1)), 255 * real(ds_list_find_value(_line_data_list, 2)), 255 * real(ds_list_find_value(_line_data_list, 3)));
                                    break;
                            }
                            
                            break;
                        
                        case "Ks":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "spectral":
                                    break;
                                
                                case "xyz":
                                    break;
                                
                                default:
                                    _material_struct.specular = make_colour_rgb(255 * real(ds_list_find_value(_line_data_list, 1)), 255 * real(ds_list_find_value(_line_data_list, 2)), 255 * real(ds_list_find_value(_line_data_list, 3)));
                                    break;
                            }
                            
                            break;
                        
                        case "Ke":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "spectral":
                                    break;
                                
                                case "xyz":
                                    break;
                                
                                default:
                                    _material_struct.emissive = make_colour_rgb(255 * real(ds_list_find_value(_line_data_list, 1)), 255 * real(ds_list_find_value(_line_data_list, 2)), 255 * real(ds_list_find_value(_line_data_list, 3)));
                                    break;
                            }
                            
                            break;
                        
                        case "Ns":
                            _material_struct.specular_exp = real(ds_list_find_value(_line_data_list, 1));
                            break;
                        
                        case "Tr":
                            _material_struct.transparency = real(ds_list_find_value(_line_data_list, 1));
                            break;
                        
                        case "Tf":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "spectral":
                                    break;
                                
                                case "xyz":
                                    break;
                                
                                default:
                                    _material_struct.transmission = make_colour_rgb(255 * real(ds_list_find_value(_line_data_list, 1)), 255 * real(ds_list_find_value(_line_data_list, 2)), 255 * real(ds_list_find_value(_line_data_list, 3)));
                                    break;
                            }
                            
                            break;
                        
                        case "illum":
                            switch (ds_list_find_value(_line_data_list, 1))
                            {
                                case "0":
                                case "1":
                                case "2":
                                case "8":
                                case "9":
                                case "10":
                                    _material_struct.illumination_model = real(ds_list_find_value(_line_data_list, 1));
                                    break;
                                
                                case "3":
                                case "4":
                                case "5":
                                case "6":
                                case "7":
                                    break;
                                
                                default:
                                    break;
                            }
                            
                            break;
                        
                        case "d":
                            if (ds_list_find_value(_line_data_list, 1) == "-halo")
                                _material_struct.dissolve = -real(ds_list_find_value(_line_data_list, 1));
                            else
                                _material_struct.dissolve = real(ds_list_find_value(_line_data_list, 1));
                            
                            break;
                        
                        case "sharpness":
                            _material_struct.sharpness = real(ds_list_find_value(_line_data_list, 1));
                            break;
                        
                        case "Ni":
                            _material_struct.optical_density = real(ds_list_find_value(_line_data_list, 1));
                            break;
                        
                        case "map_Ka":
                        case "map_Kd":
                        case "map_Ks":
                        case "map_Ke":
                        case "map_Ns":
                        case "map_d":
                        case "map_decal":
                        case "decal":
                        case "map_disp":
                        case "disp":
                        case "map_bump":
                        case "bump":
                            var _texture_filename = _directory + ds_list_find_value(_line_data_list, 1);
                            var _i = 1;
                            var _size = ds_list_size(_line_data_list);
                            
                            repeat (_size - 2)
                            {
                                _texture_filename += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                                _i++;
                            }
                            
                            var _sprite = __DotobjAddExternalSprite(_texture_filename);
                            _texture_struct = (_sprite >= 0) ? new DotobjClassTexture(_sprite, 0, true) : undefined;
                            
                            if (is_struct(_texture_struct))
                                _texture_struct.filename = _texture_filename;
                            
                            switch (ds_list_find_value(_line_data_list, 0))
                            {
                                case "map_Ka":
                                    _material_struct.ambient_map = _texture_struct;
                                    break;
                                
                                case "map_Kd":
                                    _material_struct.diffuse_map = _texture_struct;
                                    break;
                                
                                case "map_Ks":
                                    _material_struct.specular_map = _texture_struct;
                                    break;
                                
                                case "map_Ke":
                                    _material_struct.emissive_map = _texture_struct;
                                    break;
                                
                                case "map_Ns":
                                    _material_struct.specular_exp_map = _texture_struct;
                                    break;
                                
                                case "map_d":
                                    _material_struct.dissolve_map = _texture_struct;
                                    break;
                                
                                case "map_decal":
                                case "decal":
                                    _material_struct.decal_map = _texture_struct;
                                    break;
                                
                                case "map_disp":
                                case "disp":
                                    _material_struct.ambient_map = _texture_struct;
                                    break;
                                
                                case "map_bump":
                                case "bump":
                                    _material_struct.normal_map = _texture_struct;
                                    break;
                            }
                            
                            break;
                        
                        case "-blenu":
                        case "-blenv":
                            break;
                        
                        case "-bm":
                        case "-boost":
                        case "-cc":
                        case "-clamp":
                        case "-imfchan":
                        case "-mm":
                        case "-o":
                        case "-s":
                        case "-t":
                        case "-texres":
                            break;
                        
                        case "refl":
                            break;
                        
                        default:
                            break;
                    }
                }
                
                ds_list_clear(_line_data_list);
                _line_started = false;
            }
        }
        
        if (_value == 10 || _value == 13)
            _meta_line++;
    }
    
    ds_list_destroy(_line_data_list);
    buffer_seek(_buffer, buffer_seek_start, _old_tell);
    return true;
}
