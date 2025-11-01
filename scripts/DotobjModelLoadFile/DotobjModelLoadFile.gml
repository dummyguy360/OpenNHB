function DotobjModelLoadFile(arg0)
{
    var _buffer = buffer_load(arg0);
    var _result = DotobjModelLoad(_buffer, filename_dir(arg0));
    buffer_delete(_buffer);
    return _result;
}
