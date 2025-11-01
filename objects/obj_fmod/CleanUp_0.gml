var _events = ds_map_keys_to_array(global.sound_map);

for (var i = 0; i < array_length(_events); i++)
{
    ds_list_destroy(ds_map_find_value(global.sound_map, array_get(_events, i)));
    ds_map_set(global.sound_map, array_get(_events, i), -1);
}

ds_map_destroy(global.sound_map);
global.sound_map = -1;
