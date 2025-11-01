function DotobjTryCache(arg0)
{
    var _sha1 = sha1_file(arg0);
    var _cacheFilename = "dotobj" + _sha1 + ".dat";
    
    if (file_exists(_cacheFilename))
    {
        return DotobjModelRawLoad(_cacheFilename);
    }
    else
    {
        var _model = DotobjModelLoadFile(arg0);
        DotobjModelRawSave(_model, _cacheFilename);
        return _model;
    }
}
