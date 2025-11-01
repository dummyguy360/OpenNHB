function DotobjClassModel() constructor
{
    static GetAABB = function()
    {
        return aabb;
    };
    
    static Submit = function()
    {
        var _g = 0;
        
        repeat (array_length(groups_array))
        {
            groups_array[_g].Submit();
            _g++;
        }
        
        return self;
    };
    
    static Freeze = function()
    {
        var _g = 0;
        
        repeat (array_length(groups_array))
        {
            groups_array[_g].Freeze();
            _g++;
        }
        
        return self;
    };
    
    static Duplicate = function()
    {
        var _new_model = new DotobjClassModel();
        var _i = 0;
        
        repeat (array_length(groups_array))
        {
            groups_array[_i].Duplicate().AddTo(_new_model);
            _i++;
        }
        
        return _new_model;
    };
    
    static Serialize = function(arg0)
    {
        buffer_write(arg0, buffer_string, "dotobj @jujuadams");
        buffer_write(arg0, buffer_string, "5.5.0");
        buffer_write(arg0, buffer_string, sha1);
        buffer_write(arg0, buffer_string, material_library);
        buffer_write(arg0, buffer_f64, aabb.x1);
        buffer_write(arg0, buffer_f64, aabb.y1);
        buffer_write(arg0, buffer_f64, aabb.z1);
        buffer_write(arg0, buffer_f64, aabb.x2);
        buffer_write(arg0, buffer_f64, aabb.y2);
        buffer_write(arg0, buffer_f64, aabb.z2);
        var _size = array_length(materials_array);
        buffer_write(arg0, buffer_u16, _size);
        var _i = 0;
        
        repeat (_size)
        {
            buffer_write(arg0, buffer_string, materials_array[_i]);
            _i++;
        }
        
        _size = array_length(groups_array);
        buffer_write(arg0, buffer_u16, _size);
        _i = 0;
        
        repeat (_size)
        {
            groups_array[_i].Serialize(arg0);
            _i++;
        }
        
        return self;
    };
    
    static Deserialize = function(arg0)
    {
        var _header = buffer_read(arg0, buffer_string);
        
        if (_header != "dotobj @jujuadams")
        {
            __DotobjError("File is not a dotobj raw file");
            return undefined;
        }
        
        var _version = buffer_read(arg0, buffer_string);
        
        if (_version != "5.5.0")
        {
            __DotobjError("Version mismatch (file=", _version, ", dotobj=", "5.5.0", ")");
            return undefined;
        }
        
        sha1 = buffer_read(arg0, buffer_string);
        var _material_library = buffer_read(arg0, buffer_string);
        
        if (_material_library != "")
            DotobjMaterialLoadFile(_material_library);
        
        aabb.x1 = buffer_read(arg0, buffer_f64);
        aabb.y1 = buffer_read(arg0, buffer_f64);
        aabb.z1 = buffer_read(arg0, buffer_f64);
        aabb.x2 = buffer_read(arg0, buffer_f64);
        aabb.y2 = buffer_read(arg0, buffer_f64);
        aabb.z2 = buffer_read(arg0, buffer_f64);
        
        repeat (buffer_read(arg0, buffer_u16))
            array_push(materials_array, buffer_read(arg0, buffer_string));
        
        repeat (buffer_read(arg0, buffer_u16))
        {
            with (new DotobjClassGroup())
            {
                Deserialize(arg0);
                AddTo(other);
            }
        }
        
        return self;
    };
    
    static Destroy = function()
    {
        var _g = 0;
        
        repeat (array_length(groups_array))
        {
            groups_array[_g].Destroy();
            _g++;
        }
        
        groups_struct = {};
        groups_array = [];
        return undefined;
    };
    
    static SetMaterialForMeshes = function(arg0, arg1)
    {
        var _i = 0;
        
        repeat (array_length(groups_array))
        {
            groups_array[_i].SetMaterialForMeshes(arg0, arg1);
            _i++;
        }
        
        return self;
    };
    
    static GetFirstMesh = function()
    {
        if (array_length(groups_array) <= 0)
            return undefined;
        
        var _group = groups_array[0];
        
        if (array_length(_group.meshes_array) <= 0)
            return undefined;
        
        return _group.meshes_array[0];
    };
    
    static GetMaterials = function()
    {
        var _array = [];
        var _i = 0;
        
        repeat (array_length(materials_array))
        {
            var _material = ds_map_find_value(global.__dotobjMaterialLibrary, array_get(materials_array, _i));
            
            if (is_struct(_material))
                array_push(_array, _material);
            
            _i++;
        }
        
        return _array;
    };
    
    aabb = 
    {
        x1: 0,
        y1: 0,
        z1: 0,
        x2: 0,
        y2: 0,
        z2: 0
    };
    sha1 = undefined;
    groups_struct = {};
    groups_array = [];
    material_library = "";
    materials_array = [];
}
