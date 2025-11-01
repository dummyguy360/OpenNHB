function DotobjClassMesh() constructor
{
    static Submit = function()
    {
        if (vertex_buffer != undefined)
        {
            var _material_struct = ds_map_find_value(global.__dotobjMaterialLibrary, material);
            
            if (!is_struct(_material_struct))
                _material_struct = ds_map_find_value(global.__dotobjMaterialLibrary, "__dotobj_library__.__dotobj_material__");
            
            var _diffuse_texture_struct = _material_struct.diffuse_map;
            
            if (is_struct(_diffuse_texture_struct))
            {
                var _diffuse_texture_pointer = _diffuse_texture_struct.pointer;
                vertex_submit(vertex_buffer, primitive, _diffuse_texture_pointer);
            }
            else
            {
                var _diffuse_colour = _material_struct.diffuse;
                
                if (_diffuse_colour == undefined)
                    _diffuse_colour = 16777215;
                
                gpu_set_fog(true, _diffuse_colour, 0, 0);
                vertex_submit(vertex_buffer, primitive, -1);
                gpu_set_fog(false, c_fuchsia, 0, 0);
            }
        }
    };
    
    static Freeze = function()
    {
        if (vertex_buffer != undefined)
        {
            if (!frozen)
            {
                frozen = true;
                vertex_freeze(vertex_buffer);
            }
        }
    };
    
    static Duplicate = function()
    {
        var _new_mesh = new DotobjClassMesh();
        
        with (_new_mesh)
        {
            material = other.material;
            has_tangents = other.has_tangents;
            primitive = other.primitive;
            vertex_buffer = other.vertex_buffer;
            frozen = other.frozen;
        }
        
        return _new_mesh;
    };
    
    static Serialize = function(arg0)
    {
        buffer_write(arg0, buffer_string, material);
        buffer_write(arg0, buffer_bool, has_tangents);
        buffer_write(arg0, buffer_u8, primitive);
        
        if (vertex_buffer == undefined)
        {
            buffer_write(arg0, buffer_u32, 0);
        }
        else
        {
            var _vbuff = buffer_create_from_vertex_buffer(vertex_buffer, buffer_fixed, 1);
            var _vbuff_size = buffer_get_size(_vbuff);
            buffer_write(arg0, buffer_u32, _vbuff_size);
            buffer_resize(arg0, buffer_get_size(arg0) + _vbuff_size);
            buffer_copy(_vbuff, 0, _vbuff_size, arg0, buffer_tell(arg0));
            buffer_seek(arg0, buffer_seek_relative, _vbuff_size);
            buffer_delete(_vbuff);
        }
        
        return self;
    };
    
    static Deserialize = function(arg0)
    {
        material = buffer_read(arg0, buffer_string);
        has_tangents = buffer_read(arg0, buffer_bool);
        primitive = buffer_read(arg0, buffer_u8);
        var _vbuff_size = buffer_read(arg0, buffer_u32);
        
        if (_vbuff_size == 0)
        {
            vertex_buffer = undefined;
        }
        else
        {
            var _vbuff = buffer_create(_vbuff_size, buffer_fixed, 1);
            buffer_copy(arg0, buffer_tell(arg0), _vbuff_size, _vbuff, 0);
            buffer_seek(arg0, buffer_seek_relative, _vbuff_size);
            vertex_buffer = vertex_create_buffer_from_buffer(_vbuff, has_tangents ? global.__dotobjPNCTTanVertexFormat : global.__dotobjPNCTVertexFormat);
            buffer_delete(_vbuff);
        }
        
        return self;
    };
    
    static Destroy = function()
    {
        if (vertex_buffer != undefined)
        {
            vertex_delete_buffer(vertex_buffer);
            vertex_buffer = undefined;
        }
        
        return undefined;
    };
    
    static AddTo = function(arg0)
    {
        group_name = arg0.name;
        array_push(arg0.meshes_array, self);
        return self;
    };
    
    static SetMaterial = function(arg0, arg1)
    {
        material = string(arg0) + "." + string(arg1);
        return self;
    };
    
    group_name = undefined;
    vertexes_array = [];
    vertex_buffer = undefined;
    frozen = false;
    material = "__dotobj_library__.__dotobj_material__";
    has_tangents = false;
    primitive = 4;
}
