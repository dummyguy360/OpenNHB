function DotobjModelLoad()
{
    var _buffer = argument[0];
    var _model_directory = (argument_count > 1 && argument[1] != undefined) ? argument[1] : "";
    
    if (string_char_at(_model_directory, string_length(_model_directory)) != "\\")
        _model_directory += "\\";
    
    var _vec4_error = false;
    var _texture_depth_error = false;
    var _smoothing_group_error = false;
    var _map_error = false;
    var _missing_positions = 0;
    var _missing_normals = 0;
    var _missing_uvs = 0;
    var _negative_references = 0;
    var _flip_texcoords = global.__dotobjFlipTexcoordV;
    var _reverse_triangles = global.__dotobjReverseTriangles;
    var _write_tangents = global.__dotobjWriteTangents;
    var _force_calculate_tangents = global.__dotobjForceTangentCalc;
    var _transform_on_load = global.__dotobjTransformOnLoad;
    var _aabb_x1 = infinity;
    var _aabb_y1 = infinity;
    var _aabb_z1 = infinity;
    var _aabb_x2 = -infinity;
    var _aabb_y2 = -infinity;
    var _aabb_z2 = -infinity;
    var _position_list = ds_list_create();
    ds_list_add(_position_list, 0, 0, 0);
    var _colour_list = ds_list_create();
    ds_list_add(_colour_list, 1, 1, 1, 1);
    var _normal_list = ds_list_create();
    ds_list_add(_normal_list, 0, 0, 0);
    var _texture_list = ds_list_create();
    ds_list_add(_texture_list, 0, 0);
    var _material_library = "__dotobj_library__";
    var _material_specific = "__dotobj_material__";
    var _unique_materials = {};
    var _model_struct = new DotobjClassModel();
    _model_struct.sha1 = buffer_sha1(_buffer, 0, buffer_get_size(_buffer));
    _model_struct.material_library = "__dotobj_library__";
    var _model_materials_array = _model_struct.materials_array;
    var _group_struct = __DotobjEnsureGroup(_model_struct, "__dotobj_group__", 0);
    var _mesh_struct = new DotobjClassMesh().AddTo(_group_struct);
    var _mesh_primitive = global.__dotobjWireframe ? 2 : 4;
    var _mrgb_buffer = undefined;
    var _mesh_vertexes_array;
    
    with (_mesh_struct)
    {
        material = "__dotobj_library__.__dotobj_material__";
        has_tangents = _write_tangents;
        primitive = _mesh_primitive;
        _mesh_vertexes_array = vertexes_array;
    }
    
    var _line_data_list = ds_list_create();
    var _meta_line = 1;
    var _meta_vertex_buffers = 0;
    var _meta_triangles = 0;
    var _buffer_size = buffer_get_size(_buffer);
    var _old_tell = buffer_tell(_buffer);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _line_started = false;
    var _value_read_start = 0;
    var _i = 0;
    
    repeat (_buffer_size)
    {
        var _value = buffer_read(_buffer, buffer_u8);
        _i++;
        
        if (!_line_started)
        {
            if (_value > 32)
            {
                _value_read_start = buffer_tell(_buffer) - 1;
                _line_started = true;
            }
        }
        else if (_value == 10 || _value == 13 || _value == 32 || _i >= _buffer_size)
        {
            if (_i < _buffer_size)
                buffer_poke(_buffer, buffer_tell(_buffer) - 1, buffer_u8, 0);
            
            buffer_seek(_buffer, buffer_seek_start, _value_read_start);
            var _string = buffer_read(_buffer, buffer_string);
            
            if (_string != "")
                ds_list_add(_line_data_list, _string);
            
            _value_read_start = buffer_tell(_buffer);
            
            if (_value != 32)
            {
                switch (ds_list_find_value(_line_data_list, 0))
                {
                    case "v":
                        if (ds_list_size(_line_data_list) == 5)
                        {
                            if (false && !_vec4_error)
                            {
                                show_debug_message("DotobjModelLoad(): Warning! 4-element vertex position data is for mathematical curves/surfaces. This is not supported. (ln=" + string(_meta_line) + ")");
                                _vec4_error = true;
                            }
                            
                            break;
                        }
                        
                        var _vx = real(ds_list_find_value(_line_data_list, 1));
                        var _vy = real(ds_list_find_value(_line_data_list, 2));
                        var _vz = real(ds_list_find_value(_line_data_list, 3));
                        
                        if (_transform_on_load)
                        {
                            var _old_vx = _vx;
                            var _old_vy = _vy;
                            var _old_vz = _vz;
                            _vx = _old_vx;
                            _vy = _old_vy;
                            _vz = _old_vz;
                        }
                        
                        _aabb_x1 = min(_aabb_x1, _vx);
                        _aabb_y1 = min(_aabb_y1, _vy);
                        _aabb_z1 = min(_aabb_z1, _vz);
                        _aabb_x2 = max(_aabb_x2, _vx);
                        _aabb_y2 = max(_aabb_y2, _vy);
                        _aabb_z2 = max(_aabb_z2, _vz);
                        ds_list_add(_position_list, _vx, _vy, _vz);
                        
                        if (ds_list_size(_line_data_list) == 7)
                            ds_list_add(_colour_list, real(ds_list_find_value(_line_data_list, 4)), real(ds_list_find_value(_line_data_list, 5)), real(ds_list_find_value(_line_data_list, 6)), 1);
                        else if (ds_list_size(_line_data_list) == 8)
                            ds_list_add(_colour_list, real(ds_list_find_value(_line_data_list, 4)), real(ds_list_find_value(_line_data_list, 5)), real(ds_list_find_value(_line_data_list, 6)), real(ds_list_find_value(_line_data_list, 7)));
                        else
                            ds_list_add(_colour_list, 1, 1, 1, 1);
                        
                        break;
                    
                    case "vt":
                        if (ds_list_size(_line_data_list) == 4)
                        {
                            if (false && !_texture_depth_error)
                            {
                                switch (ds_list_find_value(_line_data_list, 3))
                                {
                                    case "0":
                                    case "0.0":
                                    case "0.00":
                                    case "0.000":
                                    case "0.0000":
                                    case "0.00000":
                                        break;
                                    
                                    default:
                                        show_debug_message("DotobjModelLoad(): Warning! Texture depth is not supported; W-component of the texture coordinate will be ignored. (ln=" + string(_meta_line) + ")");
                                        _texture_depth_error = true;
                                        break;
                                }
                            }
                        }
                        
                        ds_list_add(_texture_list, real(ds_list_find_value(_line_data_list, 1)), real(ds_list_find_value(_line_data_list, 2)));
                        break;
                    
                    case "vn":
                        var _nx = real(ds_list_find_value(_line_data_list, 1));
                        var _ny = real(ds_list_find_value(_line_data_list, 2));
                        var _nz = real(ds_list_find_value(_line_data_list, 3));
                        
                        if (_transform_on_load)
                        {
                            var _old_nx = _nx;
                            var _old_ny = _ny;
                            var _old_nz = _nz;
                            _nx = _old_nx;
                            _ny = _old_ny;
                            _nz = _old_nz;
                        }
                        
                        ds_list_add(_normal_list, _nx, _ny, _nz);
                        break;
                    
                    case "f":
                        var _line_data_size = ds_list_size(_line_data_list);
                        _meta_triangles += (_line_data_size - 3);
                        var _f = 0;
                        
                        repeat (_line_data_size - 3)
                        {
                            if (!_reverse_triangles)
                                array_push(_mesh_vertexes_array, ds_list_find_value(_line_data_list, 1), ds_list_find_value(_line_data_list, 2 + _f), ds_list_find_value(_line_data_list, 3 + _f));
                            else
                                array_push(_mesh_vertexes_array, ds_list_find_value(_line_data_list, 1), ds_list_find_value(_line_data_list, 3 + _f), ds_list_find_value(_line_data_list, 2 + _f));
                            
                            _f++;
                        }
                        
                        break;
                    
                    case "l":
                        break;
                    
                    case "g":
                        var _group_name = "";
                        _i = 1;
                        var _size = ds_list_size(_line_data_list);
                        
                        repeat (_size - 1)
                        {
                            _group_name += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                            _i++;
                        }
                        
                        _group_struct = __DotobjEnsureGroup(_model_struct, _group_name, _meta_line);
                        _mesh_struct = new DotobjClassMesh().AddTo(_group_struct);
                        
                        with (_mesh_struct)
                        {
                            material = "__dotobj_library__.__dotobj_material__";
                            has_tangents = _write_tangents;
                            primitive = _mesh_primitive;
                            _mesh_vertexes_array = vertexes_array;
                        }
                        
                        break;
                    
                    case "o":
                        var _group_name = "";
                        _i = 1;
                        var _size = ds_list_size(_line_data_list);
                        
                        repeat (_size - 1)
                        {
                            _group_name += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                            _i++;
                        }
                        
                        _group_struct = __DotobjEnsureGroup(_model_struct, _group_name, _meta_line);
                        _mesh_struct = new DotobjClassMesh().AddTo(_group_struct);
                        
                        with (_mesh_struct)
                        {
                            material = "__dotobj_library__.__dotobj_material__";
                            has_tangents = _write_tangents;
                            primitive = _mesh_primitive;
                            _mesh_vertexes_array = vertexes_array;
                        }
                        
                        break;
                    
                    case "s":
                        if (false && !_smoothing_group_error)
                        {
                            show_debug_message("DotobjModelLoad(): Warning! Smoothing groups are not currently supported. (ln=" + string(_meta_line) + ")");
                            _smoothing_group_error = true;
                        }
                        
                        break;
                    
                    case "#":
                        break;
                    
                    case "mtllib":
                        _material_library = _model_directory;
                        _i = 1;
                        var _size = ds_list_size(_line_data_list);
                        
                        repeat (_size - 1)
                        {
                            _material_library += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                            _i++;
                        }
                        
                        _model_struct.material_library = _material_library;
                        DotobjMaterialLoadFile(_material_library);
                        break;
                    
                    case "usemtl":
                        _material_specific = "";
                        _i = 1;
                        var _size = ds_list_size(_line_data_list);
                        
                        repeat (_size - 1)
                        {
                            _material_specific += (ds_list_find_value(_line_data_list, _i) + ((_i < (_size - 1)) ? " " : ""));
                            _i++;
                        }
                        
                        var _material_name = _material_library + "." + _material_specific;
                        
                        if (!variable_struct_exists(_unique_materials, _material_name))
                        {
                            variable_struct_set(_unique_materials, _material_name, variable_struct_names_count(_unique_materials));
                            array_push(_model_materials_array, _material_name);
                        }
                        
                        if (_mesh_struct.material == "__dotobj_library__.__dotobj_material__" && array_length(_mesh_vertexes_array) <= 0)
                        {
                            _mesh_struct.material = _material_name;
                        }
                        else
                        {
                            _mesh_struct = new DotobjClassMesh().AddTo(_group_struct);
                            
                            with (_mesh_struct)
                            {
                                material = _material_name;
                                has_tangents = _write_tangents;
                                primitive = _mesh_primitive;
                                _mesh_vertexes_array = vertexes_array;
                            }
                        }
                        
                        break;
                    
                    case "#MRGB":
                    case "#mrgb":
                        if (_mrgb_buffer == undefined)
                            _mrgb_buffer = buffer_create(1024, buffer_grow, 1);
                        
                        buffer_write(_mrgb_buffer, buffer_text, ds_list_find_value(_line_data_list, 1));
                        break;
                    
                    case "maplib":
                    case "usemap":
                        if (false && !_map_error)
                        {
                            show_debug_message("DotobjModelLoad(): Warning! External texture map files are not currently supported. (ln=" + string(_meta_line) + ")");
                            _map_error = true;
                        }
                        
                        break;
                    
                    case "shadow_obj":
                    case "trace_obj":
                        break;
                    
                    case "vp":
                    case "cstype":
                    case "deg":
                    case "bmat":
                    case "step":
                    case "curv":
                    case "curv2":
                    case "surf":
                    case "end":
                    case "parm":
                    case "trim":
                    case "hole":
                    case "scrv":
                    case "sp":
                    case "con":
                    case "mg":
                    case "ctech":
                    case "stech":
                    case "bsp":
                    case "bzp":
                    case "cdc":
                    case "cdp":
                    case "res":
                        break;
                    
                    case "lod":
                        break;
                    
                    case "bevel":
                    case "c_interp":
                    case "d_interp":
                        break;
                    
                    default:
                        break;
                }
                
                ds_list_clear(_line_data_list);
                _line_started = false;
            }
        }
        
        if (_value == 10 || _value == 13)
            _meta_line++;
    }
    
    if (_mrgb_buffer != undefined)
    {
        var _mrgb_length = buffer_tell(_mrgb_buffer) / 8;
        
        if (_mrgb_length != floor(_mrgb_length))
            show_debug_message("DotobjModelLoad(): Warning! #MRGB length is not a multiple of 8, vertex colours may be malformed (ln=" + string(_meta_line) + ")");
        
        buffer_write(_mrgb_buffer, buffer_u8, 0);
        buffer_seek(_mrgb_buffer, buffer_seek_start, 8);
        var _tell = 0;
        _i = 4;
        
        repeat (_mrgb_length)
        {
            var _old_value = buffer_peek(_mrgb_buffer, _tell + 8, buffer_u8);
            buffer_poke(_mrgb_buffer, _tell + 8, buffer_u8, 0);
            var _hex_string = buffer_peek(_mrgb_buffer, _tell, buffer_string);
            buffer_poke(_mrgb_buffer, _tell + 8, buffer_u8, _old_value);
            var _value = real("0x" + _hex_string);
            ds_list_set(_colour_list, _i, ((_value >> 16) & 255) / 255);
            ds_list_set(_colour_list, _i + 1, ((_value >> 8) & 255) / 255);
            ds_list_set(_colour_list, _i + 2, (_value & 255) / 255);
            ds_list_set(_colour_list, _i + 3, 1);
            _tell += 8;
            _i += 4;
        }
    }
    
    var _tangent_list, _bitangent_list;
    
    if (_write_tangents)
    {
        _tangent_list = ds_list_create();
        _bitangent_list = ds_list_create();
        ds_list_set(_tangent_list, ds_list_size(_position_list) - 1, 0);
        ds_list_set(_bitangent_list, ds_list_size(_position_list) - 1, 0);
    }
    
    var _groups_array = _model_struct.groups_array;
    var _g = 0;
    
    repeat (array_length(_groups_array))
    {
        _group_struct = _groups_array[_g];
        var _group_line = _group_struct.line;
        var _group_name = _group_struct.name;
        var _group_meshes_array = _group_struct.meshes_array;
        var _mesh = 0;
        
        repeat (array_length(_group_meshes_array))
        {
            _mesh_struct = _group_meshes_array[_mesh];
            _mesh_vertexes_array = _mesh_struct.vertexes_array;
            var _mesh_material = _mesh_struct.material;
            _mesh_primitive = _mesh_struct.primitive;
            
            if (array_length(_mesh_vertexes_array) <= 0)
            {
                _mesh++;
            }
            else
            {
                var _material_struct = ds_map_find_value(global.__dotobjMaterialLibrary, _mesh_material);
                
                if (_material_struct == undefined)
                    _material_struct = ds_map_find_value(global.__dotobjMaterialLibrary, "__dotobj_library__.__dotobj_material__");
                
                var _write_null_tangent = false;
                
                if (_write_tangents)
                {
                    _material_struct = ds_map_find_value(global.__dotobjMaterialLibrary, _mesh_material);
                    
                    if (_material_struct.normal_map == undefined && !_force_calculate_tangents)
                    {
                        _write_null_tangent = true;
                    }
                    else
                    {
                        var _unpacked_mesh_vertex_list = ds_list_create();
                        _i = 0;
                        
                        repeat (array_length(_mesh_vertexes_array))
                        {
                            var _vertex_string = _mesh_vertexes_array[_i];
                            _i++;
                            var _slash_count = string_count("/", _vertex_string);
                            var _v_index, _t_index;
                            
                            if (_slash_count == 0)
                            {
                                ds_list_add(_unpacked_mesh_vertex_list, undefined, undefined);
                                continue;
                            }
                            else if (_slash_count == 1)
                            {
                                _v_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                                _t_index = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                            }
                            else if (_slash_count == 2)
                            {
                                var _double_slash_count = string_count("//", _vertex_string);
                                
                                if (_double_slash_count == 0)
                                {
                                    _v_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                                    _vertex_string = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                                    _t_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                                }
                                else if (_double_slash_count == 1)
                                {
                                    ds_list_add(_unpacked_mesh_vertex_list, undefined, undefined);
                                    continue;
                                }
                                else
                                {
                                    ds_list_add(_unpacked_mesh_vertex_list, undefined, undefined);
                                    continue;
                                }
                            }
                            else
                            {
                                ds_list_add(_unpacked_mesh_vertex_list, undefined, undefined);
                                continue;
                            }
                            
                            ds_list_add(_unpacked_mesh_vertex_list, 3 * real(_v_index), 2 * real(_t_index));
                        }
                        
                        _i = 0;
                        
                        repeat (ds_list_size(_unpacked_mesh_vertex_list) div 6)
                        {
                            var _pos_index_1 = ds_list_find_value(_unpacked_mesh_vertex_list, _i);
                            var _pos_index_2 = ds_list_find_value(_unpacked_mesh_vertex_list, _i + 2);
                            var _pos_index_3 = ds_list_find_value(_unpacked_mesh_vertex_list, _i + 4);
                            var _tex_index_1 = ds_list_find_value(_unpacked_mesh_vertex_list, _i + 1);
                            var _tex_index_2 = ds_list_find_value(_unpacked_mesh_vertex_list, _i + 3);
                            var _tex_index_3 = ds_list_find_value(_unpacked_mesh_vertex_list, _i + 5);
                            var _in_x1 = ds_list_find_value(_position_list, _pos_index_1);
                            var _in_y1 = ds_list_find_value(_position_list, _pos_index_1 + 1);
                            var _in_z1 = ds_list_find_value(_position_list, _pos_index_1 + 2);
                            var _in_u1 = ds_list_find_value(_texture_list, _tex_index_1);
                            var _in_v1 = ds_list_find_value(_texture_list, _tex_index_1 + 1);
                            var _in_x2 = ds_list_find_value(_position_list, _pos_index_2);
                            var _in_y2 = ds_list_find_value(_position_list, _pos_index_2 + 1);
                            var _in_z2 = ds_list_find_value(_position_list, _pos_index_2 + 2);
                            var _in_u2 = ds_list_find_value(_texture_list, _tex_index_2);
                            var _in_v2 = ds_list_find_value(_texture_list, _tex_index_2 + 1);
                            var _in_x3 = ds_list_find_value(_position_list, _pos_index_3);
                            var _in_y3 = ds_list_find_value(_position_list, _pos_index_3 + 1);
                            var _in_z3 = ds_list_find_value(_position_list, _pos_index_3 + 2);
                            var _in_u3 = ds_list_find_value(_texture_list, _tex_index_3);
                            var _in_v3 = ds_list_find_value(_texture_list, _tex_index_3 + 1);
                            var _x1 = _in_x2 - _in_x1;
                            var _y1 = _in_y2 - _in_y1;
                            var _z1 = _in_z2 - _in_z1;
                            var _u1 = _in_u2 - _in_u1;
                            var _v1 = _in_v2 - _in_v1;
                            var _x2 = _in_x3 - _in_x1;
                            var _y2 = _in_y3 - _in_y1;
                            var _z2 = _in_z3 - _in_z1;
                            var _u2 = _in_u3 - _in_u1;
                            var _v2 = _in_v3 - _in_v1;
                            var _r = (_u1 * _v2) - (_u2 * _v1);
                            
                            if (_r != 0)
                            {
                                _r = 1 / _r;
                                var _tx = ((_v2 * _x1) - (_v1 * _x2)) * _r;
                                var _ty = ((_v2 * _y1) - (_v1 * _y2)) * _r;
                                var _tz = ((_v2 * _z1) - (_v1 * _z2)) * _r;
                                var _bx = ((_u1 * _x2) - (_u2 * _x1)) * _r;
                                var _by = ((_u1 * _y2) - (_u2 * _y1)) * _r;
                                var _bz = ((_u1 * _z2) - (_u2 * _z1)) * _r;
                                ds_list_set(_tangent_list, _pos_index_1, ds_list_find_value(_tangent_list, _pos_index_1) + _tx);
                                ds_list_set(_tangent_list, _pos_index_2, ds_list_find_value(_tangent_list, _pos_index_2) + _ty);
                                ds_list_set(_tangent_list, _pos_index_3, ds_list_find_value(_tangent_list, _pos_index_3) + _tz);
                                ds_list_set(_bitangent_list, _pos_index_1, ds_list_find_value(_bitangent_list, _pos_index_1) + _bx);
                                ds_list_set(_bitangent_list, _pos_index_2, ds_list_find_value(_bitangent_list, _pos_index_2) + _by);
                                ds_list_set(_bitangent_list, _pos_index_3, ds_list_find_value(_bitangent_list, _pos_index_3) + _bz);
                            }
                            
                            _i += 6;
                        }
                    }
                }
                
                _meta_vertex_buffers++;
                var _vbuff = vertex_create_buffer();
                _mesh_struct.vertex_buffer = _vbuff;
                vertex_begin(_vbuff, _write_tangents ? global.__dotobjPNCTTanVertexFormat : global.__dotobjPNCTVertexFormat);
                _i = 0;
                var _line_counter = 0;
                var _repeat_count = array_length(_mesh_vertexes_array);
                
                if (_mesh_primitive == 2)
                    _repeat_count *= 2;
                
                repeat (_repeat_count)
                {
                    var _v_index = undefined;
                    var _c_index = undefined;
                    var _t_index = undefined;
                    var _n_index = undefined;
                    var _vx = undefined;
                    var _vy = undefined;
                    var _vz = undefined;
                    var _cr = 1;
                    var _cg = 1;
                    var _cb = 1;
                    var _ca = 1;
                    var _tx = 0;
                    var _ty = 0;
                    var _nx = 0;
                    var _ny = 0;
                    var _nz = 0;
                    
                    if (_mesh_primitive == 2)
                    {
                        if (_line_counter == 2)
                        {
                            _i--;
                        }
                        else if (_line_counter == 4)
                        {
                            _i--;
                        }
                        else if (_line_counter == 5)
                        {
                            _i -= 3;
                        }
                        else if (_line_counter == 6)
                        {
                            _line_counter = 0;
                            _i += 2;
                        }
                        
                        _line_counter++;
                    }
                    
                    var _vertex_string = _mesh_vertexes_array[_i];
                    _i++;
                    var _slash_count = string_count("/", _vertex_string);
                    
                    if (_slash_count == 0)
                    {
                        _v_index = _vertex_string;
                        _t_index = undefined;
                        _n_index = undefined;
                    }
                    else if (_slash_count == 1)
                    {
                        _v_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                        _t_index = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                        _n_index = undefined;
                    }
                    else if (_slash_count == 2)
                    {
                        var _double_slash_count = string_count("//", _vertex_string);
                        
                        if (_double_slash_count == 0)
                        {
                            _v_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                            _vertex_string = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                            _t_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                            _n_index = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                        }
                        else if (_double_slash_count == 1)
                        {
                            _vertex_string = string_replace(_vertex_string, "//", "/");
                            _v_index = string_copy(_vertex_string, 1, string_pos("/", _vertex_string) - 1);
                            _t_index = undefined;
                            _n_index = string_delete(_vertex_string, 1, string_pos("/", _vertex_string));
                        }
                        else
                        {
                            continue;
                        }
                    }
                    else
                    {
                        continue;
                    }
                    
                    if (_v_index == "" || _v_index == undefined)
                    {
                        _missing_positions++;
                    }
                    else
                    {
                        if (_n_index == "" || _n_index == undefined)
                            _n_index = 0;
                        
                        if (_t_index == "" || _t_index == undefined)
                            _t_index = 0;
                        
                        if (_v_index < 0 || _n_index < 0 || _t_index < 0)
                        {
                            _negative_references++;
                        }
                        else
                        {
                            _v_index = 3 * floor(real(_v_index));
                            _c_index = (4/3) * _v_index;
                            _n_index = 3 * floor(real(_n_index));
                            _t_index = 2 * floor(real(_t_index));
                            _vx = ds_list_find_value(_position_list, _v_index);
                            _vy = ds_list_find_value(_position_list, _v_index + 1);
                            _vz = ds_list_find_value(_position_list, _v_index + 2);
                            
                            if (_vx == undefined || _vy == undefined || _vz == undefined)
                            {
                                _missing_positions++;
                            }
                            else
                            {
                                vertex_position_3d(_vbuff, _vx, _vy, _vz);
                                
                                if (_n_index >= 0)
                                {
                                    _nx = ds_list_find_value(_normal_list, _n_index);
                                    _ny = ds_list_find_value(_normal_list, _n_index + 1);
                                    _nz = ds_list_find_value(_normal_list, _n_index + 2);
                                    
                                    if (_nx == undefined || _ny == undefined || _nz == undefined)
                                    {
                                        _missing_normals++;
                                        _nx = 0;
                                        _ny = 0;
                                        _nz = 0;
                                    }
                                }
                                
                                vertex_normal(_vbuff, _nx, _ny, _nz);
                                _cr = ds_list_find_value(_colour_list, _c_index) * 255;
                                _cg = ds_list_find_value(_colour_list, _c_index + 1) * 255;
                                _cb = ds_list_find_value(_colour_list, _c_index + 2) * 255;
                                _ca = ds_list_find_value(_colour_list, _c_index + 3);
                                vertex_colour(_vbuff, make_colour_rgb(_cr, _cg, _cb), _ca);
                                
                                if (_t_index >= 0)
                                {
                                    _tx = ds_list_find_value(_texture_list, _t_index);
                                    _ty = ds_list_find_value(_texture_list, _t_index + 1);
                                    
                                    if (_tx == undefined || _ty == undefined)
                                    {
                                        _missing_uvs++;
                                        _tx = 0;
                                        _ty = 0;
                                    }
                                    else if (_flip_texcoords)
                                    {
                                        _ty = 1 - _ty;
                                    }
                                }
                                
                                vertex_texcoord(_vbuff, _tx, _ty);
                                
                                if (_write_tangents)
                                {
                                    if (_write_null_tangent)
                                    {
                                        vertex_float4(_vbuff, 0, 0, 0, 0);
                                    }
                                    else
                                    {
                                        _tx = ds_list_find_value(_tangent_list, _v_index);
                                        _ty = ds_list_find_value(_tangent_list, _v_index + 1);
                                        var _tz = ds_list_find_value(_tangent_list, _v_index + 2);
                                        var _bx = ds_list_find_value(_bitangent_list, _v_index);
                                        var _by = ds_list_find_value(_bitangent_list, _v_index + 1);
                                        var _bz = ds_list_find_value(_bitangent_list, _v_index + 2);
                                        var _dot = dot_product_3d(_nx, _ny, _nz, _tx, _ty, _tz);
                                        _tx -= (_nx * _dot);
                                        _ty -= (_ny * _dot);
                                        _tz -= (_nz * _dot);
                                        var _length = sqrt((_tx * _tx) + (_ty * _ty) + (_tz * _tz));
                                        
                                        if (_length > 0)
                                        {
                                            _tx /= _length;
                                            _ty /= _length;
                                            _tz /= _length;
                                        }
                                        
                                        var _cross_x = (_ny * _tz) - (_nz * _ty);
                                        var _cross_y = (_nz * _tx) - (_nx * _tz);
                                        var _cross_z = (_nx * _ty) - (_ny * _tx);
                                        _dot = dot_product_3d(_cross_x, _cross_y, _cross_z, _bx, _by, _bz);
                                        var _handedness = (_dot < 0) ? -1 : 1;
                                        vertex_float4(_vbuff, _tx, _ty, _tz, _handedness);
                                    }
                                }
                            }
                        }
                    }
                }
                
                vertex_end(_vbuff);
                _mesh_struct.vertexes_array = undefined;
                _mesh++;
            }
        }
        
        _g++;
    }
    
    with (_model_struct.aabb)
    {
        x1 = _aabb_x1;
        y1 = _aabb_y1;
        z1 = _aabb_z1;
        x2 = _aabb_x2;
        y2 = _aabb_y2;
        z2 = _aabb_z2;
    }
    
    ds_list_destroy(_position_list);
    ds_list_destroy(_colour_list);
    ds_list_destroy(_normal_list);
    ds_list_destroy(_texture_list);
    ds_list_destroy(_line_data_list);
    
    if (_write_tangents)
    {
        ds_list_destroy(_tangent_list);
        ds_list_destroy(_bitangent_list);
    }
    
    if (_mrgb_buffer != undefined)
        buffer_delete(_mrgb_buffer);
    
    buffer_seek(_buffer, buffer_seek_start, _old_tell);
    return _model_struct;
}
