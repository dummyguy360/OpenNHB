function DotobjClassGroup() constructor
{
    static Submit = function()
    {
        var _m = 0;
        
        repeat (array_length(meshes_array))
        {
            meshes_array[_m].Submit();
            _m++;
        }
        
        return self;
    };
    
    static Freeze = function()
    {
        var _m = 0;
        
        repeat (array_length(meshes_array))
        {
            meshes_array[_m].Freeze();
            _m++;
        }
        
        return self;
    };
    
    static Duplicate = function()
    {
        var _new_group = new DotobjClassGroup();
        
        with (_new_group)
        {
            name = other.name;
            line = other.line;
        }
        
        var _i = 0;
        
        repeat (array_length(meshes_array))
        {
            meshes_array[_i].Duplicate().AddTo(_new_group);
            _i++;
        }
        
        return _new_group;
    };
    
    static Serialize = function(arg0)
    {
        buffer_write(arg0, buffer_string, name);
        buffer_write(arg0, buffer_u32, line);
        var _size = array_length(meshes_array);
        buffer_write(arg0, buffer_u16, _size);
        var _i = 0;
        
        repeat (_size)
        {
            meshes_array[_i].Serialize(arg0);
            _i++;
        }
        
        return self;
    };
    
    static Deserialize = function(arg0)
    {
        name = buffer_read(arg0, buffer_string);
        line = buffer_read(arg0, buffer_u32);
        
        repeat (buffer_read(arg0, buffer_u16))
        {
            with (new DotobjClassMesh())
            {
                Deserialize(arg0);
                AddTo(other);
            }
        }
        
        return self;
    };
    
    static Destroy = function()
    {
        var _m = 0;
        
        repeat (array_length(meshes_array))
        {
            meshes_array[_m].Destroy();
            _m++;
        }
        
        meshes_array = [];
        return undefined;
    };
    
    static AddTo = function(arg0)
    {
        variable_struct_set(arg0.groups_struct, name, self);
        array_push(arg0.groups_array, self);
        return self;
    };
    
    static SetMaterialForMeshes = function(arg0, arg1)
    {
        var _i = 0;
        
        repeat (array_length(meshes_array))
        {
            meshes_array[_i].SetMaterial(arg0, arg1);
            _i++;
        }
        
        return self;
    };
    
    line = 0;
    name = undefined;
    meshes_array = [];
}

function __DotobjEnsureGroup(arg0, arg1, arg2)
{
    if (variable_struct_exists(arg0.groups_struct, arg1))
    {
        return variable_struct_get(arg0.groups_struct, arg1);
    }
    else
    {
        var _group = new DotobjClassGroup();
        
        with (_group)
        {
            name = arg1;
            line = arg2;
            AddTo(arg0);
        }
        
        return _group;
    }
}
