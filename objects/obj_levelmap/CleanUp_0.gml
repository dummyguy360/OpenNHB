for (var _s = 0; _s < array_length(map_surf); _s++)
{
    if (surface_exists(map_surf[_s]))
        surface_free(map_surf[_s]);
}

if (surface_exists(main_surf))
    surface_free(main_surf);

array_foreach(vBuffMap, function(arg0, arg1)
{
    if (array_get_undefined(vBuffMap, arg1) != undefined && vBuffMap[arg1] != -1)
        vertex_delete_buffer(vBuffMap[arg1]);
});
