__input_initialize();

function __input_initialize()
{
    static _initialized = false;
    
    if (_initialized)
        exit;
    
    _initialized = true;
    var _global = __input_global();
    _global.__debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
    __input_trace("Welcome to Input by Juju Adams and Alynne Keith! This is version ", "8.0.3", ", ", "2025-01-16");
    
    if (is_undefined(infinity))
        __input_error("Error!\nGM constant 'infinity' is undefined. Please file a bug with YoYoGames.");
    
    var _use_split_and_trim;
    
    try
    {
        var _split = array_equals(string_split("Juju\nwaz\nere", "\n", true), ["Juju", "waz", "ere"]);
        var _trim = string_trim("         you can't catch me          ") == "you can't catch me";
        _use_split_and_trim = _split && _trim;
    }
    catch (_error)
    {
        _use_split_and_trim = false;
    }
    
    if (!_use_split_and_trim)
        __input_error("Error!\nGM extended string functions are unavailable. Please update GameMaker.");
    
    var _native_split;
    
    try
    {
        if (is_real(string_split))
            _native_split = real(string_split) < 100000;
        else
            _native_split = is_struct(string_split);
    }
    catch (_error)
    {
        _native_split = false;
    }
    
    if (!_native_split)
        __input_trace_loud("Warning!\nFound indirection for GM native \"string_split\" function. Overriding \"string_split\" degrades load performance.");
    
    if (false || os_type == os_gxgames)
    {
        _global.__use_is_instanceof = false;
    }
    else
    {
        try
        {
            var _instance_of = is_instanceof(input_binding_empty(), __input_class_binding);
            _global.__use_is_instanceof = _instance_of;
        }
        catch (_error)
        {
            _global.__use_is_instanceof = false;
        }
    }
    
    __input_trace(_global.__use_is_instanceof ? "Using is_instanceof() for comparisons" : "is_instanceof() unavailable, using legacy comparisons");
    _global.__use_gp_extended = false;
    
    try
    {
        _global.__use_gp_extended = is_numeric(gp_home) && is_numeric(gp_extra1) && is_numeric(gp_paddler) && is_numeric(gp_paddlel) && is_numeric(gp_paddlerb) && is_numeric(gp_paddlelb) && is_numeric(gp_touchpadbutton);
    }
    catch (_error)
    {
        _global.__use_gp_extended = false;
    }
    
    if (_global.__use_gp_extended)
    {
        _global.__gp_guide = gp_home;
        _global.__gp_misc1 = gp_extra1;
        _global.__gp_touchpad = gp_touchpadbutton;
        _global.__gp_paddle1 = gp_paddler;
        _global.__gp_paddle2 = gp_paddlel;
        _global.__gp_paddle3 = gp_paddlerb;
        _global.__gp_paddle4 = gp_paddlelb;
        __input_trace("Using native extended gamepad values");
    }
    else
    {
        _global.__gp_guide = 32889;
        _global.__gp_misc1 = 32890;
        _global.__gp_touchpad = 32891;
        _global.__gp_paddle1 = 32892;
        _global.__gp_paddle2 = 32893;
        _global.__gp_paddle3 = 32894;
        _global.__gp_paddle4 = 32895;
        __input_trace("Native extended gamepad values unavailable");
    }
    
    if ((false || os_type == os_gxgames) || ((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch))
    {
        _global.__use_debug_overlay_status = false;
    }
    else
    {
        try
        {
            var _overlay_open = is_debug_overlay_open();
            _global.__use_debug_overlay_status = is_bool(_overlay_open);
        }
        catch (_error)
        {
            _global.__use_debug_overlay_status = false;
        }
    }
    
    __input_trace(_global.__use_debug_overlay_status ? "Using debug overlay status to block input" : "Debug overlay status is unavailable");
    
    if (false || os_type == os_gxgames)
    {
        _global.__allow_gamepad_tester = false;
    }
    else
    {
        try
        {
            ref_create(
            {
                x: 32
            }, "x");
            _global.__allow_gamepad_tester = true;
        }
        catch (_error)
        {
            _global.__allow_gamepad_tester = false;
        }
    }
    
    __input_trace(_global.__allow_gamepad_tester ? "Allowing native gamepad tester" : "Native gamepad tester is unavailable");
    
    if (_global.__allow_gamepad_tester)
        __input_gamepad_tester_init();
    
    _global.__allow_gamepad_enumerate = false;
    
    if (os_type == os_android)
    {
        try
        {
            gamepad_enumerate();
            _global.__allow_gamepad_enumerate = true;
        }
        catch (_error)
        {
            _global.__allow_gamepad_enumerate = false;
        }
        
        __input_trace(_global.__allow_gamepad_enumerate ? "Using gamepad enumeration" : "Gamepad enumeration is unavailable");
    }
    
    _global.__time_source = time_source_create(0, 1, 1, function()
    {
        static _created = false;
        
        if (!instance_exists(input_controller_object))
        {
            instance_activate_object(input_controller_object);
            
            if (instance_exists(input_controller_object))
            {
                __input_trace("Warning! input_controller_object has been deactivated. Please ensure that input_controller_object is never deactivated. You may need to use instance_activate_object(input_controller_object)");
            }
            else
            {
                if (!_created)
                    _created = true;
                else if (__input_restart_get())
                    __input_trace("Warning! Please consider an alternative method to reset game state: avoid using \"game_restart()\"");
                else
                    __input_trace("Warning! input_controller_object has been destroyed. Please ensure that input_controller_object is never destroyed");
                
                instance_create_depth(0, -16001, 16001, input_controller_object);
            }
        }
        
        if (!input_controller_object.persistent)
        {
            __input_trace("Warning! input_controller_object has been set as non-persistent. Please ensure that input_controller_object is always persistent");
            input_controller_object.persistent = true;
        }
        
        if (input_controller_object.depth != 16001)
        {
            __input_trace("Warning! input_controller_object depth has been changed (expected ", 16001, ", got ", input_controller_object.depth, ")\nPlease ensure that input_controller_object is never manually created and depth is not manually set");
            input_controller_object.depth = 16001;
        }
    }, [], -1);
    time_source_start(_global.__time_source);
    
    if (string_pos("127.0.0.1", parameter_string(0)) > 0 || string_pos("localhost", parameter_string(0)) > 0)
        show_message("Due to changes in security policy, some browsers may not permit the use of gamepads when testing locally.\n \nPlease host on a remote web service (itch.io, GX.games, etc.) if you are encountering problems.");
    
    _global.__frame = 0;
    _global.__current_time = current_time;
    _global.__previous_current_time = current_time;
    _global.__restart_time = -infinity;
    _global.__enumeration_time = -infinity;
    _global.__cleared = false;
    _global.__window_focus = true;
    _global.__overlay_focus = false;
    _global.__game_input_allowed = true;
    _global.__use_native_focus = os_type == os_windows || (false || os_type == os_gxgames);
    _global.__toggle_momentary_dict = {};
    _global.__toggle_momentary_state = false;
    _global.__cooldown_dict = {};
    _global.__cooldown_state = false;
    _global.__tap_presses = 0;
    _global.__tap_releases = 0;
    _global.__tap_click = false;
    _global.__pointer_index = 0;
    _global.__pointer_index_previous = 0;
    _global.__pointer_pressed = false;
    _global.__pointer_released = false;
    _global.__pointer_pressed_index = undefined;
    _global.__pointer_coord_space = UnknownEnum.Value_0;
    _global.__pointer_held_time = array_create(11, -1);
    _global.__pointer_held_buffer = array_create(11, false);
    _global.__pointer_x = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_y = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_dx = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_dy = array_create(UnknownEnum.Value_3, 0);
    _global.__pointer_moved = false;
    _global.__mouse_capture = false;
    _global.__mouse_capture_blocked = false;
    _global.__mouse_capture_sensitivity = 1;
    _global.__mouse_capture_frame = 0;
    _global.__on_desktop = os_type == os_windows || os_type == os_macosx || os_type == os_linux || os_type == os_gxgames;
    _global.__on_mobile = os_type == os_android || (os_type == os_ios || os_type == os_tvos);
    
    if (os_type == os_gxgames)
    {
        var _map = os_get_info();
        
        if (ds_exists(_map, ds_type_map))
        {
            if (ds_map_find_value(_map, "mobile"))
            {
                _global.__on_mobile = true;
                _global.__on_desktop = false;
                __input_trace("Browser indicates OperaGX mobile");
            }
            
            ds_map_destroy(_map);
        }
    }
    
    _global.__strict_binding_check = false;
    _global.__any_keyboard_binding_defined = false;
    _global.__any_mouse_binding_defined = false;
    _global.__any_touch_binding_defined = false;
    _global.__any_gamepad_binding_defined = false;
    _global.__gamepad_allowed = (__input_global().__on_desktop && true) || (__input_global().__on_mobile && true) || ((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch);
    _global.__keyboard_allowed = (__input_global().__on_desktop && true) || (os_type == os_switch && false) || (__input_global().__on_mobile && false && (false || os_type == os_gxgames)) || (os_type == os_android && false);
    _global.__mouse_allowed = (__input_global().__on_desktop && true) || (os_type == os_switch && false) || (__input_global().__on_mobile && false);
    _global.__touch_allowed = __input_global().__on_mobile || (os_type == os_switch && false);
    _global.__vibration_allowed = false;
    
    if (_global.__gamepad_allowed)
        _global.__vibration_allowed = (os_type == os_windows && true) || (os_type == os_switch && true) || ((os_type == os_xboxone || os_type == os_gdk) && true) || (os_type == os_ps4 && true) || (os_type == os_ps5 && true);
    
    if (_global.__mouse_allowed && _global.__touch_allowed)
        _global.__touch_allowed = false;
    
    _global.__window_focus_block_mouse = false;
    _global.__window_focus_frame = -infinity;
    _global.__cursor_verbs_valid = false;
    _global.__all_verb_dict = {};
    _global.__all_verb_array = [];
    _global.__basic_verb_dict = {};
    _global.__basic_verb_array = [];
    _global.__chord_verb_dict = {};
    _global.__chord_verb_array = [];
    _global.__key_name_dict = {};
    _global.__ignore_key_dict = {};
    _global.__ignore_gamepad_types = {};
    _global.__virtual_array = [];
    _global.__virtual_background = input_virtual_create().__set_as_background();
    _global.__virtual_order_dirty = false;
    _global.__touch_player = undefined;
    var _max_gamepads = 4;
    
    if (!(false || os_type == os_gxgames))
    {
        if (os_type == os_windows)
            _max_gamepads = 12;
        else if (os_type == os_switch)
            _max_gamepads = 9;
        else if (os_type == os_xboxone || os_type == os_gdk)
            _max_gamepads = 8;
        else if (os_type == os_ios || os_type == os_tvos)
            _max_gamepads = 5;
        else if (os_type == os_linux || os_type == os_android)
            _max_gamepads = gamepad_get_device_count();
    }
    
    _global.__players_status = 
    {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __players: array_create(1, UnknownEnum.Value_0)
    };
    _global.__gamepads_status = 
    {
        __any_changed: false,
        __new_connections: [],
        __new_disconnections: [],
        __gamepads: array_create(_max_gamepads, UnknownEnum.Value_0)
    };
    _global.__default_player = new __input_class_player();
    _global.__players = array_create(1, undefined);
    var _p = 0;
    
    repeat (1)
    {
        with (new __input_class_player())
        {
            _global.__players[_p] = self;
            __index = _p;
        }
        
        _p++;
    }
    
    _global.__source_mode = undefined;
    _global.__previous_source_mode = UnknownEnum.Value_2;
    _global.__hotswap_callback = undefined;
    _global.__join_player_min = 1;
    _global.__join_player_max = 1;
    _global.__join_leave_verb = "cancel";
    _global.__join_abort_callback = undefined;
    _global.__join_drop_down = true;
    _global.__gamepads = array_create(_max_gamepads, undefined);
    _global.__gamepad_connections_native = array_create(_max_gamepads, false);
    _global.__gamepad_connections_internal = array_create(_max_gamepads, false);
    _global.__sdl2_database = 
    {
        by_guid: {},
        by_vendor_product: {},
        by_description: {}
    };
    _global.__sdl2_look_up_table = 
    {
        a: 32769,
        b: 32770,
        x: 32771,
        y: 32772,
        dpup: 32781,
        dpdown: 32782,
        dpleft: 32783,
        dpright: 32784,
        leftx: 32785,
        lefty: 32786,
        rightx: 32787,
        righty: 32788,
        leftshoulder: 32773,
        rightshoulder: 32774,
        lefttrigger: 32775,
        righttrigger: 32776,
        leftstick: 32779,
        rightstick: 32780,
        start: 32778,
        back: 32777,
        guide: __input_global().__gp_guide,
        misc1: __input_global().__gp_misc1,
        touchpad: __input_global().__gp_touchpad,
        paddle1: __input_global().__gp_paddle1,
        paddle2: __input_global().__gp_paddle2,
        paddle3: __input_global().__gp_paddle3,
        paddle4: __input_global().__gp_paddle4
    };
    
    if (!(!(false || os_type == os_gxgames) && (__input_global().__on_desktop || os_type == os_android)) || 0)
    {
        __input_trace("Skipping loading SDL database");
    }
    else
    {
        if (file_exists("Libraries/sdl2.txt"))
            __input_load_sdl2_from_file("Libraries/sdl2.txt");
        else
            __input_trace("Warning! \"", "Libraries/sdl2.txt", "\" not found in Included Files");
        
        var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");
        
        if (_external_string != "")
        {
            if (!extension_exists("Steamworks") && false && environment_get_variable("SteamEnv") == "1" && environment_get_variable("EnableConfiguratorSupport") != "0" && !gamepad_is_connected(0))
                __input_trace("Warning! Steam Input may block gamepads when GameMaker IDE is run through Steam.");
            
            __input_trace("External SDL2 string found");
            
            try
            {
                __input_load_sdl2_from_string(_external_string);
            }
            catch (_error)
            {
                __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", "8.0.3", "   @jujuadams and @offalynne ", "2025-01-16");
            }
        }
    }
    
    __input_define_gamepad_types();
    _global.__raw_type_dictionary = {};
    
    if (((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch) || os_type == os_gxgames || (os_type == os_ios || os_type == os_tvos))
        __input_trace("Skipping loading controller type database");
    else if (file_exists("Libraries/controllertypes.csv"))
        __input_load_type_csv("Libraries/controllertypes.csv");
    else
        __input_trace("Warning! \"", "Libraries/controllertypes.csv", "\" not found in Included Files");
    
    _global.__blacklist_dictionary = {};
    
    if (!(!(false || os_type == os_gxgames) && (__input_global().__on_desktop || os_type == os_android)))
        __input_trace("Skipping loading controller blacklist database");
    else if (file_exists("Libraries/controllerblacklist.csv"))
        __input_load_blacklist_csv("Libraries/controllerblacklist.csv");
    else
        __input_trace("Warning! \"", "Libraries/controllerblacklist.csv", "\" not found in Included Files");
    
    var _dict = {};
    variable_struct_set(_dict, "ps5", [[false, false, true, false, false], [false, true, false, true, false], [true, false, true, false, true], [true, true, false, true, true]]);
    variable_struct_set(_dict, "switch", [[true, false, false, false], [true, true, false, false], [true, true, true, false], [true, true, true, true], [true, false, false, true], [true, false, true, false], [true, false, true, true], [false, true, true, false]]);
    variable_struct_set(_dict, "xbox 360", [[true, false, false, false], [false, true, false, false], [false, false, true, false], [false, false, false, true]]);
    _global.__gamepad_led_pattern_dict = _dict;
    _global.__ps_region_swap = false;
    
    if (false && os_type == os_ps4)
    {
        var _map = os_get_info();
        
        if (ds_exists(_map, ds_type_map))
        {
            if (ds_map_find_value(_map, "enter_button_assign") == 0)
                _global.__ps_region_swap = true;
            
            ds_map_destroy(_map);
        }
    }
    
    _global.__keyboard_locale = "QWERTY";
    var _locale = os_get_language() + "-" + os_get_region();
    
    switch (_locale)
    {
        case "ar-DZ":
        case "ar-MA":
        case "ar-TN":
        case "br-FR":
        case "co-FR":
        case "ff-SN":
        case "fr-BE":
        case "fr-CD":
        case "fr-CI":
        case "fr-CM":
        case "fr-FR":
        case "fr-HT":
        case "fr-MA":
        case "fr-MC":
        case "fr-ML":
        case "fr-RE":
        case "nl-BE":
        case "oc-FR":
        case "wo-SN":
        case "tzm-DZ":
        case "mg-":
        case "gsw-FR":
            _global.__keyboard_locale = "AZERTY";
            break;
        
        case "cs-CZ":
        case "de-AT":
        case "de-CH":
        case "de-DE":
        case "de-LI":
        case "de-LU":
        case "fr-CH":
        case "fr-LU":
        case "sq-AL":
        case "hr-BA":
        case "hr-HR":
        case "hu-HU":
        case "lb-LU":
        case "rm-CH":
        case "sk-SK":
        case "sl-SI":
        case "dsb-DE":
        case "sr-BA":
        case "hsb-DE":
            _global.__keyboard_locale = "QWERTZ";
            break;
    }
    
    __input_key_name_set(!(os_type == os_macosx) ? ((os_type == os_linux) ? 223 : 192) : 50, "`");
    __input_key_name_set(((os_type == os_macosx || os_type == os_switch) && !(false || os_type == os_gxgames)) ? 109 : 189, "-");
    __input_key_name_set((os_type == os_macosx && !(false || os_type == os_gxgames)) ? 24 : 187, "=");
    __input_key_name_set(186, ";");
    __input_key_name_set(((os_type == os_macosx || os_type == os_linux) && !(false || os_type == os_gxgames)) ? 192 : 222, "'");
    __input_key_name_set(188, ",");
    __input_key_name_set((os_type == os_switch) ? 110 : 190, ".");
    __input_key_name_set(221, "]");
    __input_key_name_set(219, "[");
    __input_key_name_set(191, "/");
    __input_key_name_set(220, "\\");
    __input_key_name_set(145, "scroll lock");
    __input_key_name_set(20, "caps lock");
    __input_key_name_set(((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 12 : 144, "num lock");
    __input_key_name_set((os_type == os_macosx) ? 92 : 91, "left meta");
    __input_key_name_set((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92, "right meta");
    __input_key_name_set(12, "clear");
    __input_key_name_set(93, "menu");
    __input_key_name_set(44, "print screen");
    __input_key_name_set(19, "pause break");
    __input_key_name_set(27, "escape");
    __input_key_name_set(8, "backspace");
    __input_key_name_set(32, "space");
    __input_key_name_set(13, "enter");
    __input_key_name_set(38, "arrow up");
    __input_key_name_set(40, "arrow down");
    __input_key_name_set(37, "arrow left");
    __input_key_name_set(39, "arrow right");
    __input_key_name_set(9, "tab");
    __input_key_name_set(165, "right alt");
    __input_key_name_set(164, "left alt");
    __input_key_name_set(18, "alt");
    __input_key_name_set(161, "right shift");
    __input_key_name_set(160, "left shift");
    __input_key_name_set(16, "shift");
    __input_key_name_set(163, "right ctrl");
    __input_key_name_set(162, "left ctrl");
    __input_key_name_set(17, "ctrl");
    __input_key_name_set(112, "f1");
    __input_key_name_set(113, "f2");
    __input_key_name_set(114, "f3");
    __input_key_name_set(115, "f4");
    __input_key_name_set(116, "f5");
    __input_key_name_set(117, "f6");
    __input_key_name_set(118, "f7");
    __input_key_name_set(119, "f8");
    __input_key_name_set(120, "f9");
    __input_key_name_set(121, "f10");
    __input_key_name_set(122, "f11");
    __input_key_name_set(123, "f12");
    __input_key_name_set(111, "numpad /");
    __input_key_name_set(106, "numpad *");
    __input_key_name_set(109, "numpad -");
    __input_key_name_set(107, "numpad +");
    __input_key_name_set(110, "numpad .");
    __input_key_name_set(96, "numpad 0");
    __input_key_name_set(97, "numpad 1");
    __input_key_name_set(98, "numpad 2");
    __input_key_name_set(99, "numpad 3");
    __input_key_name_set(100, "numpad 4");
    __input_key_name_set(101, "numpad 5");
    __input_key_name_set(102, "numpad 6");
    __input_key_name_set(103, "numpad 7");
    __input_key_name_set(104, "numpad 8");
    __input_key_name_set(105, "numpad 9");
    __input_key_name_set(46, "delete");
    __input_key_name_set(45, "insert");
    __input_key_name_set(36, "home");
    __input_key_name_set(33, "page up");
    __input_key_name_set(34, "page down");
    __input_key_name_set(35, "end");
    __input_key_name_set(10, variable_struct_get(_global.__key_name_dict, 13));
    
    if (os_type == os_switch || os_type == os_linux || os_type == os_macosx)
    {
        __input_key_name_set(128, "f11");
        __input_key_name_set(129, "f12");
    }
    
    if (os_type == os_switch)
    {
        for (var _i = 2; _i <= 7; _i++)
            __input_key_name_set(_i, __input_key_get_name(ord(_i)));
    }
    
    if (os_type == os_windows || (false || os_type == os_gxgames))
    {
        for (var _i = 13; _i <= 32; _i++)
            __input_key_name_set((_i + 112) - 1, "f" + string(_i));
        
        __input_key_name_set(226, (false || os_type == os_gxgames) ? "\\" : "<");
        
        switch (__input_global().__keyboard_locale)
        {
            case "QWERTY":
                __input_key_name_set(223, "`");
                break;
            
            case "AZERTY":
                __input_key_name_set(223, "!");
                break;
            
            case "QWERTZ":
                __input_key_name_set(223, "$");
                break;
        }
    }
    
    input_ignore_key_add(18);
    input_ignore_key_add(165);
    input_ignore_key_add(164);
    input_ignore_key_add((os_type == os_macosx) ? 92 : 91);
    input_ignore_key_add((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92);
    input_ignore_key_add(255);
    
    if (os_type == os_windows)
        input_ignore_key_add(230);
    
    if (os_type == os_android)
        input_ignore_key_add(8);
    
    if (__input_global().__on_mobile && (os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)))
        input_ignore_key_add(124);
    
    if (false || os_type == os_gxgames)
    {
        if (os_type == os_macosx || (os_type == os_ios || os_type == os_tvos))
        {
            input_ignore_key_add(121);
            input_ignore_key_add(20);
        }
        else
        {
            input_ignore_key_add(122);
        }
    }
    
    input_ignore_key_add(((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 12 : 144);
    input_ignore_key_add(145);
    
    if ((false || os_type == os_gxgames) || os_type == os_windows)
    {
        input_ignore_key_add(21);
        input_ignore_key_add(22);
        input_ignore_key_add(23);
        input_ignore_key_add(24);
        input_ignore_key_add(25);
        input_ignore_key_add(26);
        input_ignore_key_add(28);
        input_ignore_key_add(29);
        input_ignore_key_add(30);
        input_ignore_key_add(31);
        input_ignore_key_add(229);
        input_ignore_key_add(166);
        input_ignore_key_add(167);
        input_ignore_key_add(168);
        input_ignore_key_add(169);
        input_ignore_key_add(170);
        input_ignore_key_add(171);
        input_ignore_key_add(172);
        input_ignore_key_add(173);
        input_ignore_key_add(174);
        input_ignore_key_add(175);
        input_ignore_key_add(176);
        input_ignore_key_add(177);
        input_ignore_key_add(178);
        input_ignore_key_add(179);
        input_ignore_key_add(180);
        input_ignore_key_add(181);
        input_ignore_key_add(182);
        input_ignore_key_add(183);
        input_ignore_key_add(251);
    }
    
    _global.__steam_switch_labels = false;
    _global.__using_steamworks = false;
    _global.__on_steam_deck = false;
    _global.__on_wine = false;
    _global.__steam_handles = [];
    _global.__steam_type_to_raw = {};
    _global.__steam_type_to_name = {};
    _global.__steam_trigger_mode = {};
    
    if (((os_type == os_linux || os_type == os_windows) && !(false || os_type == os_gxgames)) && true && extension_exists("Steamworks"))
    {
        try
        {
            _global.__using_steamworks = steam_input_init(true);
            _global.__on_steam_deck = steam_utils_is_steam_running_on_steam_deck();
        }
        catch (_error)
        {
            __input_trace("Steamworks extension unavailable");
        }
        
        if (_global.__using_steamworks && string(steam_get_app_id()) == "480")
            __input_trace_loud("Error!\nSteamworks extension incorrectly configured (Application ID 480).\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, set Application ID.\n\nInput ", "8.0.3", "   @jujuadams and @offalynne ", "2025-01-16");
    }
    
    if (!_global.__on_steam_deck)
    {
        var _deck_envar = environment_get_variable("SteamDeck");
        
        if (_deck_envar != "")
        {
            _global.__on_steam_deck = _deck_envar == "1";
        }
        else
        {
            var _map = os_get_info();
            
            if (ds_exists(_map, ds_type_map))
            {
                var _identifier = undefined;
                
                if (os_type == os_linux)
                    _identifier = ds_map_find_value(_map, "gl_renderer_string");
                
                if (os_type == os_windows)
                    _identifier = ds_map_find_value(_map, "video_adapter_description");
                
                if (_identifier != undefined && __input_string_contains(_identifier, "AMD Custom GPU 0"))
                    _global.__on_steam_deck = true;
                
                ds_map_destroy(_map);
            }
        }
    }
    
    var _switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
    
    if (_switch_labels != "")
        _global.__steam_switch_labels = _switch_labels == "1";
    else
        _global.__steam_switch_labels = _global.__on_steam_deck;
    
    if (_global.__using_steamworks)
    {
        _global.__on_wine = environment_get_variable("WINEDLLPATH") != "";
        __input_steam_type_set(steam_input_type_xbox_360_controller, "XBox360Controller", "Xbox 360 Controller");
        __input_steam_type_set(steam_input_type_xbox_one_controller, "XBoxOneController", "Xbox One Controller");
        __input_steam_type_set(steam_input_type_ps3_controller, "PS3Controller", "PS3 Controller");
        __input_steam_type_set(steam_input_type_ps4_controller, "PS4Controller", "PS4 Controller");
        __input_steam_type_set(steam_input_type_ps5_controller, "PS5Controller", "PS5 Controller");
        __input_steam_type_set(steam_input_type_steam_controller, "SteamController", "Steam Controller");
        __input_steam_type_set(steam_input_type_steam_deck_controller, "SteamControllerNeptune", "Steam Deck Controller");
        __input_steam_type_set(steam_input_type_mobile_touch, "MobileTouch", "Steam Link");
        
        if (_global.__steam_switch_labels)
        {
            __input_steam_type_set(steam_input_type_switch_pro_controller, "XBox360Controller", "Switch Pro Controller");
            __input_steam_type_set(steam_input_type_switch_joycon_single, "XBox360Controller", "Joy-Con");
            __input_steam_type_set(steam_input_type_switch_joycon_pair, "XBox360Controller", "Joy-Con Pair");
        }
        else
        {
            __input_steam_type_set(steam_input_type_switch_pro_controller, "SwitchProController", "Switch Pro Controller");
            __input_steam_type_set(steam_input_type_switch_joycon_single, "SwitchJoyConSingle", "Joy-Con");
            __input_steam_type_set(steam_input_type_switch_joycon_pair, "SwitchJoyConPair", "Joy-Con Pair");
        }
        
        __input_steam_type_set("unknown", "UnknownNonSteamController", "Controller");
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_0), steam_input_sce_pad_trigger_effect_mode_off);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_1), steam_input_sce_pad_trigger_effect_mode_feedback);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_2), steam_input_sce_pad_trigger_effect_mode_weapon);
        variable_struct_set(_global.__steam_trigger_mode, string(UnknownEnum.Value_3), steam_input_sce_pad_trigger_effect_mode_vibration);
    }
    
    if (os_type == os_macosx || os_type == os_linux)
    {
        var _os = (os_type == os_macosx) ? "macos" : "linux";
        var _id = (os_type == os_macosx) ? "030000005e0400008e02000001000000" : "03000000de280000ff11000001000000";
        var _blacklist_os = is_struct(_global.__blacklist_dictionary) ? variable_struct_get(_global.__blacklist_dictionary, _os) : undefined;
        var _blacklist_id = is_struct(_blacklist_os) ? variable_struct_get(_blacklist_os, "guid") : undefined;
        
        if (is_struct(_blacklist_os) && _blacklist_id == undefined)
        {
            variable_struct_set(_blacklist_os, "guid", {});
            _blacklist_id = is_struct(_blacklist_os) ? variable_struct_get(_blacklist_os, "guid") : undefined;
        }
        
        if (is_struct(_blacklist_id))
            variable_struct_set(_blacklist_id, _id, true);
        
        var _steam_environ = environment_get_variable("SteamEnv");
        var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
        
        if (os_type == os_linux && ((_steam_environ != "" && _steam_environ == "1") || _global.__using_steamworks) && _steam_configs != "" && _steam_configs == string_digits(_steam_configs))
        {
            if (is_struct(_blacklist_id))
                variable_struct_remove(_blacklist_id, _id);
            
            var _bitmask = real(_steam_configs);
            var _steam_ps = _bitmask & 1;
            var _steam_xbox = _bitmask & 2;
            var _steam_generic = _bitmask & 4;
            var _steam_switch = _bitmask & 8;
            var _ignore_list = [];
            
            if (_global.__using_steamworks || environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == "")
            {
                if (_steam_ps)
                    array_push(_ignore_list, "psx", "ps4", "ps5");
                
                if (_steam_xbox)
                    array_push(_ignore_list, "xbox 360", "xbox one");
                
                if (_steam_switch)
                    array_push(_ignore_list, "switch", "switch joycon left", "switch joycon right");
                
                if (_steam_generic)
                    array_push(_ignore_list, "gamecube", "unknown");
                
                var _i = 0;
                
                repeat (array_length(_ignore_list))
                {
                    variable_struct_set(_global.__ignore_gamepad_types, array_get(_ignore_list, _i), true);
                    _i++;
                }
            }
            
            if (!_steam_generic && !_steam_ps && (!_steam_switch || _global.__steam_switch_labels))
            {
                variable_struct_set(_global.__simple_type_lookup, "UnknownNonSteamController", "xbox one");
                __input_trace("Steam Input configuration indicates Xbox-like identity for virtual controllers");
            }
        }
    }
    
    if (((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch) || ((false || os_type == os_gxgames) && !__input_global().__on_desktop))
    {
        _global.__keyboard_type = "async";
    }
    else if (__input_global().__on_mobile)
    {
        _global.__keyboard_type = "virtual";
        
        if (os_type == os_android)
        {
            var _map = os_get_info();
            
            if (ds_exists(_map, ds_type_map))
            {
                var _device = string(ds_map_find_value(_map, "DEVICE"));
                
                if (string_pos("_cheets", _device) > 1 || (string_pos("cheets_", _device) > 0 && string_pos("cheets_", _device) < (string_length(_device) - 6)))
                    _global.__keyboard_type = "keyboard";
                
                ds_map_destroy(_map);
            }
        }
    }
    else
    {
        _global.__keyboard_type = "keyboard";
    }
    
    if (__input_global().__on_steam_deck || os_type == os_switch || __input_global().__on_mobile || (os_type == os_windows && _global.__touch_allowed))
        _global.__pointer_type = "touch";
    else if ((os_type == os_xboxone || os_type == os_gdk) || (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch)
        _global.__pointer_type = "none";
    else
        _global.__pointer_type = "mouse";
    
    _global.__gamepad_motion_support = (os_type == os_ps4 || os_type == os_ps5) || os_type == os_switch || _global.__using_steamworks;
    device_mouse_dbclick_enable(false);
    _global.__profile_array = undefined;
    _global.__profile_dict = undefined;
    _global.__default_profile_dict = undefined;
    _global.__verb_to_group_dict = {};
    _global.__group_to_verbs_dict = {};
    _global.__verb_group_array = [];
    _global.__icons = {};
    _global.__source_keyboard = new __input_class_source(UnknownEnum.Value_0);
    _global.__source_mouse = __input_global().__source_keyboard;
    _global.__source_touch = new __input_class_source(UnknownEnum.Value_3);
    _global.__source_gamepad = array_create(_max_gamepads, undefined);
    var _g = 0;
    
    repeat (_max_gamepads)
    {
        _global.__source_gamepad[_g] = new __input_class_source(UnknownEnum.Value_2, _g);
        _g++;
    }
    
    __input_finalize_default_profiles();
    __input_finalize_verb_groups();
    input_source_mode_set(UnknownEnum.Value_2);
    __input_validate_macros();
    return true;
}
