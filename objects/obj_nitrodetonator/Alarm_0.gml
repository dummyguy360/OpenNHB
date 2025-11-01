instance_destroy(obj_destroyablenitro);
finish_explosion_chains();
var _rooms = [];

for (var i = 0; i < (array_length(global.levelrooms) - 2); i++)
{
    if (global.levelrooms[i] == room)
    {
        trace(string("room {0} has the nitro detonator, skipping", room_get_name(global.levelrooms[i])));
    }
    else
    {
        var _hasnitros = count_in_room(global.levelrooms[i], function(arg0, arg1)
        {
            return (arg0.object_index == "obj_destroyablenitro" && !in_saveroom(arg0.id, global.respawnroom)) || (arg0.object_index == "obj_destroyablenitroarrow" && in_saveroom(string("{0}_ARROW", real(arg0.id)), global.respawnroom) && !in_saveroom(string("{0}_NITRO", real(arg0.id)), global.respawnroom));
        }) > 0;
        
        if (!_hasnitros)
            trace(string("room {0} has no nitros, skipping", room_get_name(global.levelrooms[i])));
        else
            array_push(_rooms, global.levelrooms[i]);
    }
}

with (instance_create_depth(x, y, 0, obj_nitrodetonatorcutscene))
{
    startingroom = room;
    rooms = _rooms;
}
