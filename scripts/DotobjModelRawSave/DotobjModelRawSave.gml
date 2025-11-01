function DotobjModelRawSave(arg0, arg1)
{
    var _buffer = buffer_create(1024, buffer_grow, 1);
    arg0.Serialize(_buffer);
    var _compressedBuffer = buffer_compress(_buffer, 0, buffer_tell(_buffer));
    buffer_save(_compressedBuffer, arg1);
    buffer_delete(_buffer);
    buffer_delete(_compressedBuffer);
}
