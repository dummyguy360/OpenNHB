function DotobjClassMaterial(arg0, arg1) constructor
{
    static SetDiffuseMap = function(arg0)
    {
        diffuse_map = arg0;
        return self;
    };
    
    static SetNormalMap = function(arg0)
    {
        normal_map = arg0;
        return self;
    };
    
    static Destroy = function()
    {
        if (cache_name == "__dotobj_library__.__dotobj_material__")
        {
            show_debug_message("DotobjClassMaterial.Destroy(): Warning! Cannot destroy default material \"__dotobj_library__.__dotobj_material__\"");
            exit;
        }
        
        show_debug_message("DotobjClassMaterial.Destroy(): Destroying \"" + cache_name + "\"");
        
        if (is_struct(ambient_map))
            ambient_map.Free();
        
        if (is_struct(diffuse_map))
            diffuse_map.Free();
        
        if (is_struct(emissive_map))
            emissive_map.Free();
        
        if (is_struct(specular_map))
            specular_map.Free();
        
        if (is_struct(specular_exp_map))
            specular_exp_map.Free();
        
        if (is_struct(dissolve_map))
            dissolve_map.Free();
        
        if (is_struct(decal_map))
            decal_map.Free();
        
        if (is_struct(displacement_map))
            displacement_map.Free();
        
        if (is_struct(normal_map))
            normal_map.Free();
        
        ambient_map = undefined;
        diffuse_map = undefined;
        emissive_map = undefined;
        specular_map = undefined;
        specular_exp_map = undefined;
        dissolve_map = undefined;
        decal_map = undefined;
        displacement_map = undefined;
        normal_map = undefined;
        ds_map_delete(global.__dotobjMaterialLibrary, cache_name);
        
        if (ds_map_exists(global.__dotobjMtlFileLoaded, library))
        {
            show_debug_message("DotobjClassMaterial.Destroy(): Invalidating cache for library \"" + library + "\"");
            ds_map_delete(global.__dotobjMtlFileLoaded, library);
        }
    };
    
    static toString = function()
    {
        return cache_name;
    };
    
    library = arg0;
    name = arg1;
    ambient = undefined;
    diffuse = undefined;
    emissive = undefined;
    specular = undefined;
    specular_exp = undefined;
    transparency = undefined;
    transmission = undefined;
    illumination_model = undefined;
    dissolve = undefined;
    sharpness = undefined;
    optical_density = undefined;
    ambient_map = undefined;
    diffuse_map = undefined;
    emissive_map = undefined;
    specular_map = undefined;
    specular_exp_map = undefined;
    dissolve_map = undefined;
    decal_map = undefined;
    displacement_map = undefined;
    normal_map = undefined;
    cache_name = arg0 + "." + arg1;
    ds_map_set(global.__dotobjMaterialLibrary, cache_name, self);
}

function __DotobjEnsureMaterial(arg0, arg1)
{
    var _name = arg0 + "." + arg1;
    
    if (ds_map_exists(global.__dotobjMaterialLibrary, _name))
    {
        show_debug_message("__DotobjEnsureMaterial(): Warning! Material \"" + string(_name) + "\" already exists");
        return ds_map_find_value(global.__dotobjMaterialLibrary, _name);
    }
    else
    {
        return new DotobjClassMaterial(arg0, arg1);
    }
}
