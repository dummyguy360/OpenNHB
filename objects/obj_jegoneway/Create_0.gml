event_inherited();

canCollide = function(arg0, arg1, arg2)
{
    if (sign(image_yscale > 0))
        return arg0.bbox_bottom <= bbox_top;
    else
        return arg0.bbox_top >= bbox_bottom;
};

height = depth;
