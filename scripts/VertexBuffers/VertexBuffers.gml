vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_custom(vertex_type_float1, vertex_usage_texcoord);
global.vFormat = vertex_format_end();

function vertex_create_face(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = false, arg7 = false, arg8 = 0)
{
    var _tex = sprite_get_texture(arg5, arg8);
    var _uvs = sprite_get_uvs(arg5, arg8);
    var _uvSx = _uvs[0];
    var _uvSy = _uvs[1];
    var _uvEx = _uvs[2];
    var _uvEy = _uvs[3];
    
    if (arg6)
    {
        vertex_position_3d(arg0, arg4.x, arg4.y, arg4.z);
        vertex_texcoord(arg0, _uvSx, _uvEy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg3.x, arg3.y, arg3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg1.x, arg1.y, arg1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg3.x, arg3.y, arg3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg2.x, arg2.y, arg2.z);
        vertex_texcoord(arg0, _uvEx, _uvSy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg1.x, arg1.y, arg1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg7);
    }
    else
    {
        vertex_position_3d(arg0, arg1.x, arg1.y, arg1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg2.x, arg2.y, arg2.z);
        vertex_texcoord(arg0, _uvEx, _uvSy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg3.x, arg3.y, arg3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg1.x, arg1.y, arg1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg3.x, arg3.y, arg3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg7);
        vertex_position_3d(arg0, arg4.x, arg4.y, arg4.z);
        vertex_texcoord(arg0, _uvSx, _uvEy);
        vertex_float1(arg0, arg7);
    }
}

function vertex_create_face_tile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = false, arg13 = false)
{
    var _tex = tileset_get_texture(arg10);
    var _uvs = texture_get_uvs(_tex);
    var _tileTexels = 
    {
        width: texture_get_texel_width(_tex),
        height: texture_get_texel_height(_tex)
    };
    var _texX = _uvs[0] / _tileTexels.width;
    var _texY = _uvs[1] / _tileTexels.width;
    var _texW = (_uvs[2] / _tileTexels.width) - _texX;
    var _texH = (_uvs[3] / _tileTexels.width) - _texY;
    var _tiledX = arg11 * (arg4 + (arg6 * 2));
    var _uvSx = _texX + (_tiledX % _texW) + arg6;
    var _uvSy = _texY + ((_tiledX div _texW) * (arg5 + (arg7 * 2))) + arg7;
    var _uvEx = _uvSx + arg4;
    var _uvEy = _uvSy + arg5;
    _uvSx *= _tileTexels.width;
    _uvSy *= _tileTexels.height;
    _uvEx *= _tileTexels.width;
    _uvEy *= _tileTexels.height;
    var _p1 = new Vec3(arg1 + (arg4 * (arg8 == -1)), arg2 + (arg5 * (arg9 == -1)), arg3);
    var _p2 = new Vec3(arg1 + (arg4 * (arg8 == 1)), arg2 + (arg5 * (arg9 == -1)), arg3);
    var _p3 = new Vec3(arg1 + (arg4 * (arg8 == 1)), arg2 + (arg5 * (arg9 == 1)), arg3);
    var _p4 = new Vec3(arg1 + (arg4 * (arg8 == -1)), arg2 + (arg5 * (arg9 == 1)), arg3);
    
    if (arg12)
    {
        vertex_position_3d(arg0, _p4.x, _p4.y, _p4.z);
        vertex_texcoord(arg0, _uvSx, _uvEy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p3.x, _p3.y, _p3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p1.x, _p1.y, _p1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p3.x, _p3.y, _p3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p2.x, _p2.y, _p2.z);
        vertex_texcoord(arg0, _uvEx, _uvSy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p1.x, _p1.y, _p1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg13);
    }
    else
    {
        vertex_position_3d(arg0, _p1.x, _p1.y, _p1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p2.x, _p2.y, _p2.z);
        vertex_texcoord(arg0, _uvEx, _uvSy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p3.x, _p3.y, _p3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p1.x, _p1.y, _p1.z);
        vertex_texcoord(arg0, _uvSx, _uvSy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p3.x, _p3.y, _p3.z);
        vertex_texcoord(arg0, _uvEx, _uvEy);
        vertex_float1(arg0, arg13);
        vertex_position_3d(arg0, _p4.x, _p4.y, _p4.z);
        vertex_texcoord(arg0, _uvSx, _uvEy);
        vertex_float1(arg0, arg13);
    }
}

function map_create_face(arg0, arg1, arg2, arg3, arg4, arg5)
{
    vertex_position(arg0, arg1.x, arg1.y);
    vertex_color(arg0, arg5, 1);
    vertex_position(arg0, arg2.x, arg2.y);
    vertex_color(arg0, arg5, 1);
    vertex_position(arg0, arg3.x, arg3.y);
    vertex_color(arg0, arg5, 1);
    vertex_position(arg0, arg1.x, arg1.y);
    vertex_color(arg0, arg5, 1);
    vertex_position(arg0, arg3.x, arg3.y);
    vertex_color(arg0, arg5, 1);
    vertex_position(arg0, arg4.x, arg4.y);
    vertex_color(arg0, arg5, 1);
}
