function scr_createparticle(_anim_end = true, _x, _y, _depth, _sprite, _xscale = 1, _yscale = 1, 
	_index = 0, _speed = 0.5, _angle = 0, _grav = 0, _hsp = 0, _vsp = 0, _zsp = 0, _blend = undefined
)
{
    var _id = instance_create_depth(_x, _y, _depth - 7, obj_particle);
    
    with (_id)
    {
        animationend = _anim_end;
        sprite_index = _sprite;
        image_xscale = _xscale;
        image_yscale = _yscale;
        image_index = _index;
        image_speed = _speed;
        image_angle = _angle;
        grav = _grav;
        hsp = _hsp;
        vsp = _vsp;
        zsp = _zsp;
        
        if (sprite_index == spr_star && is_undefined(_blend))
            image_blend = choose(make_color_rgb(255, 255, 0), make_color_rgb(255, 208, 18), make_color_rgb(255, 208, 133));
        else
            image_blend = _blend ?? c_white;
    }
    
    return _id;
}

function scr_tiptext(_text, _depth = -8000, _shouldpause = true)
{
    instance_destroy(obj_tiptext);
    
    with (instance_create_depth(x, y, _depth, obj_tiptext))
    {
        shouldpause = _shouldpause;
        depth = _depth;
        text = _text;
    }
}

function scr_hudroom()
{
    return array_find_pos([Init, Logos, Titlescreen, RankRoom, Credits, Jeg], room) == -1;
}

function crateeffect(_blend)
{
    repeat (5)
    {
        scr_createparticle(true, x + (sprite_width / 2), y + (sprite_height / 2), z + 4, spr_cratepoofeffect, 1, 1, 0, 0.5);
        var _wall = wall_behind(x + (sprite_width / 2), y + (sprite_height / 2), z);
        
        with (scr_createparticle(false, irandom_range(bbox_left, bbox_right), irandom_range(bbox_top, bbox_bottom), z + 16, spr_cratedebris, image_xscale / 2, image_yscale / 2, irandom(4), 0, irandom(360), 0.5, irandom_range(-4, 4), irandom_range(-6, -2), irandom_range(-2, 2 * !_wall)))
            image_blend = _blend;
    }
}

function cratebounceeffect(_effect_obj)
{
    with (_effect_obj)
        scr_createparticle(true, x, bbox_bottom, z + 4, spr_cratebounceeffect, 1, 1, 0, 0.5);
}

#region Models
function draw_model(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    matrix_set(2, matrix_build(arg1, arg2, arg3, arg7, arg8, arg9, arg4, arg5, arg6));
    
    if (is_array(arg0))
    {
        for (var i = 0; i < array_length(arg0); i++)
            model_submit(arg0[i]);
    }
    else if (is_string(arg0))
        model_submit(arg0);
    
    matrix_set(2, matrix_build_identity());
}

function model_submit(arg0)
{
    var _altmaterial = variable_struct_get(global.altMaterials, arg0);
    
    if (!is_undefined(_altmaterial))
    {
        var _model = ds_map_find_value(global.loadedModels, _altmaterial.model);
        _model.SetMaterialForMeshes(_altmaterial.library, _altmaterial.material);
        _model.Submit();
    }
    else
        ds_map_find_value(global.loadedModels, arg0).Submit();
}

function import_material(arg0, arg1)
{
    var _buffer = buffer_load(arg1);
    var _result = DotobjMaterialLoad(arg0, _buffer, filename_dir(arg1));
    var _name = "";
    var _file = file_text_open_read(arg1);
    
    while (!file_text_eof(_file))
    {
        var _line = file_text_readln(_file);
        
        if (string_starts_with(_line, "newmtl "))
        {
            _name = string_copy(_line, 8, string_length(_line) - 8);
            break;
        }
    }
    
    file_text_close(_file);
    _name = string_replace(_name, "\r\n", "");
    _name = string_replace(_name, "\n", "");
    _name = string_replace(_name, "\r", "");
    _name = string_replace(_name, " ", "");
    buffer_delete(_buffer);
    return _name;
}
#endregion

function offset_camera(_x1, _y1, _x2, _y2)
{
    with (obj_drawcontroller)
    {
        camXINTERP = _x1 - _x2;
        camYINTERP = _y1 - _y2;
    }
}

function world_to_screen(arg0, arg1, arg2, arg3, arg4, arg5 = false)
{
    var cx, cy;
    
    if (arg4[15] == 0)
    {
        var w = (arg3[2] * arg0) + (arg3[6] * arg1) + (arg3[10] * arg2) + arg3[14];
        
        if (w <= 0 && arg5)
            return undefined;
        
        if (w == 0)
            return [-1, -1];
        
        cx = arg4[8] + ((arg4[0] * ((arg3[0] * arg0) + (arg3[4] * arg1) + (arg3[8] * arg2) + arg3[12])) / w);
        cy = arg4[9] + ((arg4[5] * ((arg3[1] * arg0) + (arg3[5] * arg1) + (arg3[9] * arg2) + arg3[13])) / w);
    }
    else
    {
        cx = arg4[12] + (arg4[0] * ((arg3[0] * arg0) + (arg3[4] * arg1) + (arg3[8] * arg2) + arg3[12]));
        cy = arg4[13] + (arg4[5] * ((arg3[1] * arg0) + (arg3[5] * arg1) + (arg3[9] * arg2) + arg3[13]));
    }
    
    return [(0.5 + (0.5 * cx)) * get_game_width(), (0.5 + (0.5 * cy)) * get_game_height()];
}

function screen_to_world(arg0, arg1, arg2, arg3)
{
    var mx = (2 * ((arg0 / get_game_width()) - 0.5)) / arg3[0];
    var my = (2 * ((arg1 / get_game_height()) - 0.5)) / arg3[5];
    var camX = -((arg2[12] * arg2[0]) + (arg2[13] * arg2[1]) + (arg2[14] * arg2[2]));
    var camY = -((arg2[12] * arg2[4]) + (arg2[13] * arg2[5]) + (arg2[14] * arg2[6]));
    var camZ = -((arg2[12] * arg2[8]) + (arg2[13] * arg2[9]) + (arg2[14] * arg2[10]));
    
    if (arg3[15] == 0)
        return [arg2[2] + (mx * arg2[0]) + (my * arg2[1]), arg2[6] + (mx * arg2[4]) + (my * arg2[5]), arg2[10] + (mx * arg2[8]) + (my * arg2[9]), camX, camY, camZ];
    else
        return [arg2[2], arg2[6], arg2[10], camX + (mx * arg2[0]) + (my * arg2[1]), camY + (mx * arg2[4]) + (my * arg2[5]), camZ + (mx * arg2[8]) + (my * arg2[9])];
}

function draw_3d_cone(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    static vertex = function(_vbuff, _x, _y, _z, arg4, arg5, arg6, _u, _v, arg9, arg10)
    {
        vertex_position_3d(_vbuff, _x, _y, _z);
        vertex_texcoord(_vbuff, _u, _v);
        vertex_float1(_vbuff, false);
    };
    
    static prevspr = undefined;
    static vb = undefined;
    static vb_bottom = undefined;
    static r = 0.5;
    static nr = -r;
    static steps = 32;
    
    if (arg6 != prevspr)
    {
        if (!is_undefined(vb))
            vertex_delete_buffer(vb);
        
        if (!is_undefined(vb_bottom))
            vertex_delete_buffer(vb_bottom);
        
        vb = undefined;
        vb_bottom = undefined;
    }
    
    var tex = sprite_get_texture(arg6, 0);
    
    if (vb == undefined)
    {
        var uvs = sprite_get_uvs(arg6, 0);
        var format = global.vFormat;
        vb = vertex_create_buffer();
        vertex_begin(vb, format);
        var cc = array_create(steps + 1);
        var ss = array_create(steps + 1);
        var hsteps = 1 / steps;
        
        for (var i = 0; i <= steps; i++)
        {
            var rad = (i * 2 * pi) / steps;
            cc[i] = cos(rad);
            ss[i] = sin(rad);
        }
        
        var rows = floor((steps + 1) / 2);
        var vrows = 1 / rows;
        
        for (var i = 0; i <= steps; i++)
        {
            var cci = cc[i];
            var ssi = ss[i];
            vertex(vb, 0, r, 0, 0, 1, 0, lerp(uvs[0], uvs[2], hsteps * i), uvs[3], c_white, 1);
            vertex(vb, cci * r, nr, ssi * r, cci, 0, ssi, lerp(uvs[0], uvs[2], hsteps * i), uvs[1], c_white, 1);
        }
        
        vertex_end(vb);
        vertex_freeze(vb);
        vb_bottom = vertex_create_buffer();
        vertex_begin(vb_bottom, format);
        
        for (var i = steps; i > 0; i--)
        {
            var cci = cc[i] / 2;
            var ssi = ss[i] / 2;
            var cci2 = cc[i - 1] / 2;
            var ssi2 = ss[i - 1] / 2;
            vertex(vb_bottom, 0, 0, 0, 0, 1, 0, lerp(uvs[0], uvs[2], 0.5), lerp(uvs[1], uvs[3], 0.5), c_white, 1);
            vertex(vb_bottom, cci, 0, ssi, 0, -1, 0, lerp(uvs[0], uvs[2], 0.5 + cci), lerp(uvs[1], uvs[3], 0.5 + ssi), c_white, 1);
            vertex(vb_bottom, cci2, 0, ssi2, 0, -1, 0, lerp(uvs[0], uvs[2], 0.5 + cci2), lerp(uvs[1], uvs[3], 0.5 + ssi2), c_white, 1);
        }
        
        vertex_end(vb_bottom);
        vertex_freeze(vb_bottom);
    }
    
    var sx = arg3 - arg0;
    var sy = arg4 - arg1;
    var sz = arg5 - arg2;
    var cx = mean(arg0, arg3);
    var cy = mean(arg1, arg4);
    var cz = mean(arg2, arg5);
    var transform = matrix_build(cx, cy, cz, 0, 0, 0, sx, sy, sz);
    var current = matrix_get(2);
    matrix_set(2, matrix_multiply(transform, current));
    vertex_submit(vb, pr_trianglestrip, tex);
    
    if (arg7)
    {
        transform = matrix_build(cx, arg1, cz, 0, 0, 0, sx, 1, sz);
        matrix_set(2, matrix_multiply(transform, current));
        vertex_submit(vb_bottom, pr_trianglelist, tex);
    }
    
    matrix_set(2, current);
}

function is_outofview3d(arg0, arg1, arg2, arg3 = 0)
{
    var _sp = world_to_screen(arg0, arg1, arg2, obj_drawcontroller.viewMat, obj_drawcontroller.projMat);
    return !point_in_rectangle(_sp[0], _sp[1], -arg3, -arg3, get_game_width() + arg3, get_game_height() + arg3);
}

function set_player_checkpoint(_id = id, _save_score = false)
{
    with (obj_player)
    {
        currcheckpoint.id = _id;
        currcheckpoint.object_index = _id.object_index;
        currcheckpoint.room = room;
        currcheckpoint.x = _id.x;
        currcheckpoint.y = _id.y;
        currcheckpoint.collect = global.collect;
        currcheckpoint.destroyedcount = global.destroyedcount;
        currcheckpoint.switchstate = global.switchstate;
        ds_map_copy(currcheckpoint.respawnroom, global.respawnroom);
        
        if (_save_score)
        {
            currcheckpoint.pumpkins = global.pumpkintotal;
            currcheckpoint.gems = global.gems;
            
            if (currcheckpoint.saveroom == noone)
                currcheckpoint.saveroom = ds_map_create();
            
            ds_map_copy(currcheckpoint.saveroom, global.saveroom);
        }
        else
        {
            currcheckpoint.pumpkins = noone;
            currcheckpoint.gems = noone;
            
            if (currcheckpoint.saveroom != noone)
                ds_map_destroy(currcheckpoint.saveroom);
            
            currcheckpoint.saveroom = noone;
        }
    }
}

function get_gem(_gem)
{
    global.gems = bit_set(global.gems, _gem);
}

function has_gem(_gem)
{
    return bit_get(global.gems, _gem);
}

function lighting_set(arg0, arg1, arg2, arg3 = 1, arg4 = c_white, arg5 = 0, arg6 = 1, arg7 = false, arg8 = false)
{
    var _shd = shd_basiclighting;
    var u_light = shader_get_uniform(_shd, "u_Light");
    var u_flashcol = shader_get_uniform(_shd, "u_FlashCol");
    var u_shadingmul = shader_get_uniform(_shd, "u_ShadingMul");
    var u_lightlevel = shader_get_uniform(_shd, "u_LightLevel");
    var u_time = shader_get_uniform(_shd, "u_Time");
    var u_boilscale = shader_get_uniform(_shd, "u_BoilScale");
    var u_paletted = shader_get_uniform(_shd, "u_Paletted");
    shader_set(_shd);
    shader_set_uniform_f(u_light, arg0, arg1, arg2);
    shader_set_uniform_f(u_flashcol, colour_get_red(arg4) / 255, colour_get_green(arg4) / 255, colour_get_blue(arg4) / 255, arg5);
    shader_set_uniform_f(u_shadingmul, arg6);
    shader_set_uniform_f(u_lightlevel, arg3);
    shader_set_uniform_f(u_time, floor((current_time * 60) / 350));
    shader_set_uniform_f(u_boilscale, arg7);
    var u_outlining = shader_get_uniform(_shd, "u_Outlining");
    shader_set_uniform_i(u_outlining, global.outlineDrawing);
    shader_set_uniform_i(u_paletted, arg8);
    
    if (arg8)
    {
        var u_pixelsize = shader_get_uniform(_shd, "u_pixelSize");
        var u_uvs = shader_get_uniform(_shd, "u_Uvs");
        var u_paletteid = shader_get_uniform(_shd, "u_paletteId");
        var u_paltexture = shader_get_sampler_index(_shd, "u_palTexture");
        var _tex = sprite_get_texture(palettespr, 0);
        var _UVs = sprite_get_uvs(palettespr, 0);
        texture_set_stage(u_paltexture, _tex);
        var _texel_x = texture_get_texel_width(_tex);
        var _texel_y = texture_get_texel_height(_tex);
        var _texel_hx = _texel_x * 0.5;
        var _texel_hy = _texel_y * 0.5;
        shader_set_uniform_f(u_pixelsize, _texel_x, _texel_y);
        shader_set_uniform_f(u_uvs, _UVs[0] + _texel_hx, _UVs[1] + _texel_hy, _UVs[2], _UVs[3]);
        shader_set_uniform_f(u_paletteid, curpalette);
    }
}

function lighting_end()
{
    shader_reset();
}

function combo()
{
    global.combo = approach(global.combo, 10, 1);
}

function combosparkles()
{
    if (sparkletimer <= 0)
    {
        scr_createparticle(true, x + random_range(-10, 10), y + random_range(-10, 10), z - 1, choose(spr_collectsparkleeffect1, spr_collectsparkleeffect2), image_xscale, image_yscale, 0, 0.5, 0, 0, 0, 0, 0, c_yellow);
        sparkletimer = 5;
    }
}

function draw_texture_radial(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    if (arg1 <= 0)
        exit;
    
    if (arg1 >= 1)
    {
        draw_primitive_begin_texture(pr_trianglelist, arg0);
        draw_vertex_texture_color(arg2, arg3, 0, 0, arg6, arg7);
        
        repeat (2)
        {
            draw_vertex_texture_color(arg4, arg3, 1, 0, arg6, arg7);
            draw_vertex_texture_color(arg2, arg5, 0, 1, arg6, arg7);
        }
        
        draw_vertex_texture_color(arg4, arg5, 1, 1, arg6, arg7);
        draw_primitive_end();
        exit;
    }
    
    var _mx = (arg2 + arg4) / 2;
    var _my = (arg3 + arg5) / 2;
    draw_primitive_begin_texture(pr_trianglelist, arg0);
    draw_vertex_texture_color(_mx, _my, 0.5, 0.5, arg6, arg7);
    draw_vertex_texture_color(_mx, arg3, 0.5, 0, arg6, arg7);
    
    if (arg1 >= 0.125)
    {
        draw_vertex_texture_color(arg4, arg3, 1, 0, arg6, arg7);
        draw_vertex_texture_color(_mx, _my, 0.5, 0.5, arg6, arg7);
        draw_vertex_texture_color(arg4, arg3, 1, 0, arg6, arg7);
    }
    
    if (arg1 >= 0.375)
    {
        draw_vertex_texture_color(arg4, arg5, 1, 1, arg6, arg7);
        draw_vertex_texture_color(_mx, _my, 0.5, 0.5, arg6, arg7);
        draw_vertex_texture_color(arg4, arg5, 1, 1, arg6, arg7);
    }
    
    if (arg1 >= 0.625)
    {
        draw_vertex_texture_color(arg2, arg5, 0, 1, arg6, arg7);
        draw_vertex_texture_color(_mx, _my, 0.5, 0.5, arg6, arg7);
        draw_vertex_texture_color(arg2, arg5, 0, 1, arg6, arg7);
    }
    
    if (arg1 >= 0.875)
    {
        draw_vertex_texture_color(arg2, arg3, 0, 0, arg6, arg7);
        draw_vertex_texture_color(_mx, _my, 0.5, 0.5, arg6, arg7);
        draw_vertex_texture_color(arg2, arg3, 0, 0, arg6, arg7);
    }
    
    var _dir = pi * ((arg1 * 2) - 0.5);
    var _dx = cos(_dir);
    var _dy = sin(_dir);
    var _dmax = max(abs(_dx), abs(_dy));
    
    if (_dmax < 1)
    {
        _dx /= _dmax;
        _dy /= _dmax;
    }
    
    _dx = (1 + _dx) / 2;
    _dy = (1 + _dy) / 2;
    draw_vertex_texture_color(lerp(arg2, arg4, _dx), lerp(arg3, arg5, _dy), _dx, _dy, arg6, arg7);
    draw_primitive_end();
}

function draw_sprite_radial(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = true)
{
    var _x1, _y1, _x2, _y2;
    
    if (arg9)
    {
        var _ox = sprite_get_xoffset(arg0);
        var _oy = sprite_get_yoffset(arg0);
        _x1 = arg3 + (arg5 * (sprite_get_bbox_left(arg0) - _ox));
        _x2 = arg3 + (arg5 * ((sprite_get_bbox_right(arg0) + 1) - _ox));
        _y1 = arg4 + (arg6 * (sprite_get_bbox_top(arg0) - _oy));
        _y2 = arg4 + (arg6 * ((sprite_get_bbox_bottom(arg0) + 1) - _oy));
    }
    else
    {
        _x1 = arg3 - (arg5 * sprite_get_xoffset(arg0));
        _x2 = _x1 + (arg5 * sprite_get_width(arg0));
        _y1 = arg4 - (arg6 * sprite_get_yoffset(arg0));
        _y2 = _y1 + (arg6 * sprite_get_height(arg0));
    }
    
    draw_texture_radial(sprite_get_texture(arg0, arg1), arg2, _x1, _y1, _x2, _y2, arg7, arg8);
}

function wall_behind(xx = x, yy = y, _depth = depth)
{
    var _layers = layer_get_all();
    
    for (var i = 0; i < array_length(_layers); i++)
    {
        var _layer = _layers[i];
        var _mapid = layer_tilemap_get_id(_layer);
        
        if (_mapid < 0)
            continue;
        
        var _data = tilemap_get_at_pixel(_mapid, floor(x) + 1, floor(y) + 1);
        var _tileid = tile_get_index(_data);
        
        if (_tileid > 0 && layer_get_depth(_layer) > _depth)
            return true;
    }
    
    return false;
}

function can_pause()
{
    return array_find_pos([Init, Logos, Titlescreen, RankRoom, Credits, Jeg], room) == -1 && !instance_exists(obj_deathtransition1) && !instance_exists(obj_deathtransition2) && !instance_exists(obj_endplatplayer) && !instance_exists(obj_nitrodetonatorcutscene);
}

function finish_explosion_chains()
{
    while (instance_exists(obj_explosion))
    {
        with (obj_explosion)
        {
            var _thingstodestroy = [par_destructible, par_enemy];
            
            while (instance_place(x, y, _thingstodestroy))
            {
                var _obj = instance_place(x, y, _thingstodestroy);
                
                if (_obj.object_index == obj_destroyablenitro || _obj.object_index == obj_destroyabletnt || _obj.object_index == obj_destroyablepow)
                {
                    with (instance_create_depth(_obj.x + (_obj.sprite_width / 2), _obj.y + (_obj.sprite_height / 2), _obj.z, obj_explosion))
                        pow = _obj.object_index == obj_destroyablepow;
                }
                
                if (_obj.object_index == obj_destroyablenitro)
                {
                    if (_obj.arrowid != -4)
                        add_saveroom(string("{0}_NITRO", real(_obj.arrowid)), global.respawnroom);
                    else
                        add_saveroom(_obj, global.respawnroom);
                }
                else
                    add_saveroom(_obj, global.respawnroom);
                
                if (object_is_ancestor(_obj.object_index, par_destructible))
                    global.destroyedcount++;
                
                trace(string("destroyed object of type {0} in room {1} at {2}, {3}", object_get_name(_obj.object_index), room_get_name(room), _obj.x, _obj.y));
                instance_destroy(_obj, false);
            }
            
            instance_destroy();
        }
    }
}

function deathplat_camupdate()
{
    with (obj_drawcontroller)
    {
        curlock = noone;
        curlockbboxdata = [];
        
        with (obj_player)
        {
            var _meetx = x;
            var _meety = y;
            
            if (state == states.levelintro)
                _meety = levelstarty;
            
            if (state == states.nitrocutscene)
            {
                var _scene = obj_nitrodetonatorcutscene;
                _meetx = _scene.nitrox + (_scene.nitrow / 2);
                _meety = _scene.nitroy + (_scene.nitroh / 2);
            }
            
            if (state == states.platformlocked)
            {
                with (ondeathplatform)
                {
                    _meetx = path_get_x(currpath, 1);
                    _meety = path_get_y(currpath, 1) - 46;
                }
            }
            
            if ((player_collideable() || state == states.levelintro || state == states.platformlocked || obj_player.state == states.outhouse) && (place_meeting(_meetx, _meety, par_camlock) || place_meeting(_meetx, _meety, obj_lockcamextender)))
            {
                var _lockid = noone;
                
                if (place_meeting(_meetx, _meety, par_camlock))
                    _lockid = instance_place(_meetx, _meety, par_camlock);
                else
                    _lockid = instance_place(_meetx, _meety, obj_lockcamextender).lock;
                
                other.curlock = _lockid.object_index;
                other.curlockbboxdata = [_lockid.bbox_left, _lockid.bbox_top, _lockid.bbox_right, _lockid.bbox_bottom];
            }
            else
            {
                other.curlock = noone;
                other.curlockbboxdata = [];
            }
        }
        
        if (curlock != noone)
        {
            var _lock = lock_cam(camX, camY, curlock, curlockbboxdata);
            camX = _lock[0];
            camY = _lock[1];
        }
        
        prevlock = curlock;
        prevlockbboxdata = curlockbboxdata;
        interpplaypos = false;
        camXINTERP = 0;
        camYINTERP = 0;
    }
}

function get_rank(arg0, arg1, arg2, arg3)
{
    var _workingrank = Rank.Perfect;
    var _gemcount = bit_count(arg3);
    
    if (_workingrank == Rank.Perfect)
    {
        if (arg0 < 8000 || arg1 < 10 || arg2 < global.cratecount || _gemcount < 3)
            _workingrank = Rank.Good;
    }
    
    if (_workingrank == Rank.Good)
    {
        if (arg0 < 4000 || arg1 < 9 || arg2 < 250 || _gemcount < 2)
            _workingrank = Rank.Meh;
    }
    
    if (_workingrank == Rank.Meh)
    {
        if (arg0 < 2000 || arg1 < 7 || arg2 < 250 || _gemcount < 1)
            _workingrank = Rank.Shit;
    }
    
    return _workingrank;
}

function in_deathroute()
{
    return room == PatchDeathRoute || room == PatchDeathRoute2;
}

function in_perilousroute()
{
    return room == PatchPerilousRoute;
}

function get_cycleind(arg0, arg1)
{
    var _num = sprite_get_number(arg0);
    var _ind = (get_cycle(_num / arg1) / (_num / arg1)) * _num;
    return _ind;
}

function save_easteregg(arg0)
{
    var _update = false;
    save_open();
    
    if (!has_easteregg(arg0))
        _update = true;
    
    ini_write_real("ObtuseAndFranklyUnnecessary", arg0, 1);
    save_close();
    save_dump();
    
    if (_update)
    {
        with (obj_titlescreen)
        {
            update_stars();
            update_pal();
        }
        
        event_play_oneshot("event:/sfx/misc/secret");
    }
}

function has_easteregg(arg0)
{
    return bool(ini_read_real("ObtuseAndFranklyUnnecessary", arg0, 0));
}

function string_shift(arg0, arg1)
{
    var _newstr = "";
    
    for (var _i = 1; _i <= string_length(arg0); _i++)
        _newstr += chr(ord(string_char_at(arg0, _i)) - arg1);
    
    return _newstr;
}
