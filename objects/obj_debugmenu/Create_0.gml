optionstack = ds_stack_create();
var _debug = false;

#region Check Game Launch Parameters
for (var i = 0; i < parameter_count(); i++)
{
    var _param = string_lower(parameter_string(i));
    
    if (_param == "-debug" || _param == "--debug" || _param == "-devmode")
    {
        _debug = true;
        break;
    }
}

if (!_debug)
{
    global.visiblesolids = false;
    instance_destroy();
    exit;
}
#endregion
#region Debug Menu Functions
function DEBUGMenuItem(arg0, arg1) constructor
{
    static draw = function(arg0, arg1, arg2)
    {
        var _c = c_white;
        
        if (arg2)
            _c = 0;
        
        __draw_text_colour_hook(round(arg0), round(arg1), name, _c, _c, _c, _c, 1);
    };
    
    static jump = function(arg0, arg1)
    {
        func(arg0, arg1);
    };
    
    static atk = function(arg0, arg1) { };
    
    name = arg0;
    func = arg1;
    parent = noone;
}

function DEBUGFolder(arg0, arg1) : DEBUGMenuItem(arg0) constructor
{
    static enterfolder = function(arg0)
    {
        var _memyselfandi = self;
        
        with (arg0)
            ds_stack_push(optionstack, _memyselfandi);
    };
    
    static exitfolder = function(arg0)
    {
        if (ds_stack_size(arg0.optionstack) > 1)
            ds_stack_pop(arg0.optionstack);
        else
            arg0.open = false;
    };
    
    static drawoptions = function()
    {
        var _gy = 32;
        var _maxoptions = 7;
        draw_sprite_stretched_ext(spr_1x1, 0, 0, 0, 220, 32, #D54368, 1);
        __draw_text_colour_hook(10, 16, name, c_white, c_white, c_white, c_white, 1);
        
        for (var _i = 0; _i < array_length(options); _i++)
        {
            var _scrollop = optionselected - 3;
            
            if (_scrollop < 0)
                _scrollop = 0;
            
            if (_scrollop > (array_length(options) - _maxoptions))
                _scrollop = array_length(options) - _maxoptions;
            
            if (_i < _scrollop || (_i - _scrollop) >= _maxoptions)
                continue;
            
            draw_sprite_stretched_ext(spr_1x1, 0, 0, _gy, 200, 32, (_i == optionselected) ? c_white : c_black, 1);
            
            if (_i == _scrollop && _i != 0)
                __draw_text_colour_hook(100, _gy + 16, "^", c_white, c_white, c_white, c_white, 1);
            else if ((_i - _scrollop) == (_maxoptions - 1) && _i != (array_length(options) - 1))
                __draw_text_colour_hook(100, _gy + 16, "v", c_white, c_white, c_white, c_white, 1);
            else
                options[_i].draw(5, _gy + 16, _i == optionselected);
            
            _gy += 32;
        }
    };
    
    static jump = function(arg0)
    {
        enterfolder(arg0);
    };
    
    static atk = function(arg0)
    {
        exitfolder(arg0);
    };
    
    optionselected = 0;
    name = arg0;
    options = arg1;
    array_foreach(options, function(arg0, arg1)
    {
        arg0.parent = self;
    });
}

var _roomoptions = array_create(0);

for (var i = 0; room_exists(i); i++)
{
    array_push(_roomoptions, new DEBUGMenuItem(room_get_name(i), function(arg0, arg1)
    {
        room_goto(asset_get_index(arg1.name));
        arg0.open = false;
        
        while (ds_stack_size(arg0.optionstack) > 1)
            ds_stack_pop(arg0.optionstack);
    }));
}
#endregion
#region Debug Options
var _baseoptions = new DEBUGFolder("DebugJr v0.1", [new DEBUGMenuItem("Toggle Collisions", function(arg0)
{
    global.visiblesolids = !global.visiblesolids;
    arg0.open = false;
}), new DEBUGMenuItem("Toggle Noclip", function(arg0)
{
    if (instance_exists(obj_jegplayer))
    {
        with (obj_jegplayer)
            noclip = !noclip;
    }
    else if (obj_player.state == states.noclip)
        obj_player.state = obj_player.debugstate;
    else
    {
        obj_player.debugstate = obj_player.state;
        obj_player.state = states.noclip;
        
        if (!game_paused())
            instance_destroy(obj_optionsmenu);
    }
    
    arg0.open = false;
}), new DEBUGFolder("Go to Room", _roomoptions), new DEBUGMenuItem("Toggle Debug Camera", function(arg0)
{
    if (obj_drawcontroller.debugcamcontrols)
    {
        obj_player.state = obj_player.debugstate;
        obj_drawcontroller.debugcam = false;
        obj_drawcontroller.debugcamcontrols = false;
    }
    else
    {
        obj_player.debugstate = obj_player.state;
        obj_player.state = states.debug;
        obj_drawcontroller.debugcam = true;
        obj_drawcontroller.debugcamcontrols = true;
        
        if (!game_paused())
            instance_destroy(obj_optionsmenu);
    }
    
    arg0.open = false;
}), new DEBUGMenuItem("Lock/Unlock Camera", function(arg0)
{
    if (obj_drawcontroller.debugcam && !obj_drawcontroller.debugcamcontrols)
    {
        obj_drawcontroller.debugcam = false;
        obj_drawcontroller.debugcamcontrols = false;
    }
    else
    {
        if (obj_player.state == states.debug)
            obj_player.state = obj_player.debugstate;
        
        obj_drawcontroller.debugcam = true;
        obj_drawcontroller.debugcamcontrols = false;
    }
    
    arg0.open = false;
}), new DEBUGMenuItem("Reset Player", function(arg0)
{
    if (room != Titlescreen)
        player_reset(false);
    
    arg0.open = false;
}), new DEBUGMenuItem("Reset Cycle", function(arg0)
{
    global.game_cycleF = 0;
    global.game_cycleMS = 0;
    arg0.open = false;
}), new DEBUGMenuItem("Give Masks", function(arg0)
{
    obj_player.hp = 3;
    arg0.open = false;
}), new DEBUGMenuItem("Destroy Crates", function(arg0)
{
    with (obj_destroyablenitroarrow)
    {
        instance_destroy(id, false);
        event_perform(ev_destroy, 0);
    }
    
    instance_destroy(par_crate);
    arg0.open = false;
}), new DEBUGMenuItem("Reveal Map", function(arg0)
{
    for (var i = 0; i < array_length(obj_levelmap.visitedrooms); i++)
        obj_levelmap.visitedrooms[i] = true;
    
    arg0.open = false;
}), new DEBUGMenuItem("Toggle GodMode", function(arg0)
{
    global.godmode = !global.godmode;
    arg0.open = false;
}), new DEBUGMenuItem("Toggle Switches", function(arg0)
{
    global.switchstate = !global.switchstate;
    arg0.open = false;
}), new DEBUGMenuItem("Give All Pumpkins", function(arg0)
{
    global.pumpkintotal = 10;
    arg0.open = false;
}), new DEBUGFolder("Kill Player", [new DEBUGMenuItem("Normal Death", function(arg0)
{
    with (obj_player)
        scr_hurtplayer(5);
    
    arg0.open = false;
    
    while (ds_stack_size(arg0.optionstack) > 1)
        ds_stack_pop(arg0.optionstack);
}), new DEBUGMenuItem("Explosion Death", function(arg0)
{
    scr_hurtplayer(5, playerdeath.gibdeath);
    instance_create_depth(obj_player.x, obj_player.y, 10, obj_explosion);
    arg0.open = false;
    
    while (ds_stack_size(arg0.optionstack) > 1)
        ds_stack_pop(arg0.optionstack);
}), new DEBUGMenuItem("Fire Death", function(arg0)
{
    with (obj_player)
        scr_hurtplayer(5, playerdeath.firedeath);
    
    arg0.open = false;
    
    while (ds_stack_size(arg0.optionstack) > 1)
        ds_stack_pop(arg0.optionstack);
})]), new DEBUGMenuItem("Give Points", function(arg0)
{
    global.collect += 1000;
    arg0.open = false;
}), new DEBUGMenuItem("Rank Test", function(arg0)
{
    room_goto(RankRoom);
    obj_player.state = states.actor;
    arg0.open = false;
}), new DEBUGMenuItem("Credits Test", function(arg0)
{
    room_goto(Credits);
    obj_player.state = states.actor;
    arg0.open = false;
}), new DEBUGMenuItem("Evil Teleport", function(arg0)
{
    with (obj_deathplatform)
    {
        if (!in_room())
            continue;
        
        obj_player.x = x;
        obj_player.y = y - 30;
    }
    
    arg0.open = false;
})]);
#endregion

_baseoptions.jump(id);
open = false;
depth = -15500;
