vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
global.__dotobjPNCTVertexFormat = vertex_format_end();
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
vertex_format_add_custom(vertex_type_float4, vertex_usage_color);
global.__dotobjPNCTTanVertexFormat = vertex_format_end();
global.__dotobjMtlFileLoaded = ds_map_create();
global.__dotobjMaterialLibrary = ds_map_create();
global.__dotobjSpriteMap = ds_map_create();
global.__dotobjFlipTexcoordV = false;
global.__dotobjReverseTriangles = false;
global.__dotobjWriteTangents = false;
global.__dotobjForceTangentCalc = false;
global.__dotobjWireframe = false;
global.__dotobjTransformOnLoad = false;
__DotobjEnsureMaterial("__dotobj_library__", "__dotobj_material__");

function __DotobjError()
{
    var _string = "dotobj:\n";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_error(_string + "\n ", true);
    return _string;
}

function __DotobjAddExternalSprite(arg0)
{
    var _sprite = -1;
    
    if (ds_map_exists(global.__dotobjSpriteMap, arg0))
    {
        _sprite = ds_map_find_value(global.__dotobjSpriteMap, arg0);
        
        if (sprite_exists(_sprite))
        {
            return _sprite;
        }
        else
        {
        }
    }
    
    if (!file_exists(arg0))
    {
    }
    else
    {
        _sprite = sprite_add(arg0, 1, false, false, 0, 0);
        
        if (_sprite > 0)
        {
            ds_map_set(global.__dotobjSpriteMap, arg0, _sprite);
        }
        else
        {
        }
    }
    
    return _sprite;
}
