function DotobjMaterialLoadFile(arg0)
{
    if (ds_map_exists(global.__dotobjMtlFileLoaded, arg0))
    {
        show_debug_message("DotobjMaterialLoadFile(): \"" + arg0 + "\" already loaded");
        return ds_map_find_value(global.__dotobjMtlFileLoaded, arg0);
    }
    else
    {
        show_debug_message("DotobjMaterialLoadFile(): Loading \"" + arg0 + "\"");
        
        if (!file_exists(arg0))
        {
            show_debug_message("DotobjMaterialLoadFile(): \"" + arg0 + "\" could not be found");
        }
        else
        {
            var _buffer = buffer_load(arg0);
            var _result = DotobjMaterialLoad(arg0, _buffer, filename_dir(arg0));
            buffer_delete(_buffer);
            ds_map_set(global.__dotobjMtlFileLoaded, arg0, _result);
            return _result;
        }
    }
}
