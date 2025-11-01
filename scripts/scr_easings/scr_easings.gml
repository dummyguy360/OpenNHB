function ease(arg0, arg1 = "linear")
{
    return variable_struct_get(__easings(), arg1)(clamp(arg0, 0, 1));
}

function tween(arg0, arg1, arg2, arg3 = "linear")
{
    return arg0 + ((arg1 - arg0) * ease(arg2, arg3));
}

function __easings()
{
    static __instance = new function() constructor
    {
        var _set = function(arg0, arg1, arg2 = self)
        {
            variable_struct_set(arg2, arg0, arg1);
            return variable_struct_get(arg2, arg0);
        };
        
        __sqrt = function(arg0)
        {
            return (sign(arg0) == 1) ? sqrt(arg0) : 0;
        };
        
        _set("linear", function(arg0)
        {
            return arg0;
        });
        _set("in quad", function(arg0)
        {
            return power(arg0, 2);
        });
        _set("in cubic", function(arg0)
        {
            return power(arg0, 3);
        });
        _set("in quart", function(arg0)
        {
            return power(arg0, 4);
        });
        _set("in quint", function(arg0)
        {
            return power(arg0, 5);
        });
        _set("out quad", function(arg0)
        {
            return 1 - power(1 - arg0, 2);
        });
        _set("out cubic", function(arg0)
        {
            return 1 - power(1 - arg0, 3);
        });
        _set("out quart", function(arg0)
        {
            return 1 - power(1 - arg0, 4);
        });
        _set("out quint", function(arg0)
        {
            return 1 - power(1 - arg0, 5);
        });
        _set("in out quad", function(arg0)
        {
            return (arg0 < 0.5) ? (power(arg0, 2) * 2) : (1 - (power((-2 * arg0) + 2, 2) / 2));
        });
        _set("in out cubic", function(arg0)
        {
            return (arg0 < 0.5) ? (power(arg0, 3) * 4) : (1 - (power((-2 * arg0) + 2, 3) / 2));
        });
        _set("in out quart", function(arg0)
        {
            return (arg0 < 0.5) ? (power(arg0, 4) * 8) : (1 - (power((-2 * arg0) + 2, 4) / 2));
        });
        _set("in out quint", function(arg0)
        {
            return (arg0 < 0.5) ? (power(arg0, 5) * 16) : (1 - (power((-2 * arg0) + 2, 5) / 2));
        });
        _set("in sine", function(arg0)
        {
            return 1 - cos((arg0 * pi) / 2);
        });
        _set("out sine", function(arg0)
        {
            return sin((arg0 * pi) / 2);
        });
        _set("in out sine", function(arg0)
        {
            return -(cos(arg0 * pi) - 1) / 2;
        });
        _set("in expo", function(arg0)
        {
            return (arg0 == 0) ? 0 : power(2, (10 * arg0) - 10);
        });
        _set("out expo", function(arg0)
        {
            return (arg0 == 1) ? 1 : (1 - power(2, -10 * arg0));
        });
        _set("in out expo", function(arg0)
        {
            if (arg0 == 0)
                return 0;
            
            if (arg0 == 1)
                return 1;
            
            if (arg0 >= 0.5)
                return (2 - power(2, (-20 * arg0) + 10)) / 2;
            
            return power(2, (20 * arg0) - 10) / 2;
        });
        __out_bounce = _set("out bounce", function(arg0)
        {
            if (arg0 < 0.36363636363636365)
            {
                return 7.5625 * arg0 * arg0;
            }
            else if (arg0 < 0.7272727272727273)
            {
                arg0 -= 0.5454545454545454;
                return (7.5625 * arg0 * arg0) + 0.75;
            }
            else if (arg0 < 0.9090909090909091)
            {
                arg0 -= 0.8181818181818182;
                return (7.5625 * arg0 * arg0) + 0.9375;
            }
            
            arg0 -= 0.9545454545454546;
            return (7.5625 * arg0 * arg0) + 0.984375;
        });
        _set("in out bounce", function(arg0)
        {
            if (arg0 < 0.5)
                return (1 - __out_bounce(1 - (2 * arg0))) / 2;
            
            return (1 + __out_bounce((2 * arg0) - 1)) / 2;
        });
        _set("in bounce", function(arg0)
        {
            return 1 - __out_bounce(1 - arg0);
        });
        _set("in circ", function(arg0)
        {
            return 1 - __sqrt(1 - power(arg0, 2));
        });
        _set("out circ", function(arg0)
        {
            return __sqrt(1 - power(arg0 - 1, 2));
        });
        _set("in out circ", function(arg0)
        {
            if (arg0 >= 0.5)
                return (1 + __sqrt(1 - power((-2 * arg0) + 2, 2))) / 2;
            
            return (1 - __sqrt(1 - power(2 * arg0, 2))) / 2;
        });
        _set("in back", function(arg0)
        {
            return (2.70158 * power(arg0, 3)) - (1.70158 * power(arg0, 2));
        });
        _set("out back", function(arg0)
        {
            return 1 + (2.70158 * power(arg0 - 1, 3)) + (1.70158 * power(arg0 - 1, 2));
        });
        _set("in out back", function(arg0)
        {
            if (arg0 >= 0.5)
                return ((power((2 * arg0) - 2, 2) * ((3.5949095 * ((arg0 * 2) - 2)) + 2.5949095)) + 2) / 2;
            
            return (power(2 * arg0, 2) * ((3.5949095 * (arg0 * 2)) - 2.5949095)) / 2;
        });
        _set("in elastic", function(arg0)
        {
            static __c = 2.0943951023931953;
            
            if (arg0 == 0)
                return 0;
            
            if (arg0 == 1)
                return 1;
            
            return -power(2, (10 * arg0) - 10) * sin(((arg0 * 10) - 10.75) * __c);
        });
        _set("out elastic", function(arg0)
        {
            static __c = 2.0943951023931953;
            
            if (arg0 == 0)
                return 0;
            
            if (arg0 == 1)
                return 1;
            
            return (power(2, -10 * arg0) * sin(((arg0 * 10) - 0.75) * __c)) + 1;
        });
        _set("in out elastic", function(arg0)
        {
            static __c = 1.3962634015954636;
            
            if (arg0 == 0)
                return 0;
            
            if (arg0 == 1)
                return 1;
            
            if (arg0 >= 0.5)
                return ((power(2, (-20 * arg0) + 10) * sin(((20 * arg0) - 11.125) * __c)) / 2) + 1;
            
            return -(power(2, (20 * arg0) - 10) * sin(((20 * arg0) - 11.125) * __c)) / 2;
        });
        _set("smootheststep", function(arg0)
        {
            return (((-20 * power(arg0, 7)) + (70 * power(arg0, 6))) - (84 * power(arg0, 5))) + (35 * power(arg0, 4));
        });
        _set("smootherstep", function(arg0)
        {
            return arg0 * arg0 * arg0 * ((arg0 * ((arg0 * 6) - 15)) + 10);
        });
        _set("smoothstep", function(arg0)
        {
            return arg0 * arg0 * (3 - (2 * arg0));
        });
    }();
    
    return __instance;
}
