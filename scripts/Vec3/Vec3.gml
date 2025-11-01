function Vec2(arg0, arg1) constructor
{
    static Add = function(arg0)
    {
        return new Vec2(x + arg0.x, y + arg0.y);
    };
    
    static Subtract = function(arg0)
    {
        return new Vec2(x - arg0.x, y - arg0.y);
    };
    
    static Multiply = function(arg0)
    {
        return new Vec2(x * arg0, y * arg0);
    };
    
    static Divide = function(arg0)
    {
        return new Vec2(x / arg0, y / arg0);
    };
    
    static Length = function()
    {
        return sqrt((x * x) + (y * y));
    };
    
    static Normalize = function()
    {
        return Divide(Length());
    };
    
    x = arg0;
    y = arg1;
}

function Vec3(arg0, arg1, arg2) constructor
{
    static Add = function(arg0)
    {
        return new Vec3(x + arg0.x, y + arg0.y, z + arg0.z);
    };
    
    static Subtract = function(arg0)
    {
        return new Vec3(x - arg0.x, y - arg0.y, z - arg0.z);
    };
    
    static Multiply = function(arg0)
    {
        return new Vec3(x * arg0, y * arg0, z * arg0);
    };
    
    static Divide = function(arg0)
    {
        return new Vec3(x / arg0, y / arg0, z / arg0);
    };
    
    static Length = function()
    {
        return sqrt((x * x) + (y * y) + (z * z));
    };
    
    static Normalize = function()
    {
        return Divide(Length());
    };
    
    static Cross = function(arg0)
    {
        return new Vec3((y * arg0.z) - (z * arg0.y), (z * arg0.x) - (x * arg0.z), (x * arg0.y) - (y * arg0.x));
    };
    
    x = arg0;
    y = arg1;
    z = arg2;
}
