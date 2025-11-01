function fmod_path_bundle(arg0)
{
    static is_gmrt = -1;
    
    if (is_gmrt < 0)
    {
        try
        {
            is_gmrt = GM_runtime_type == "gmrt";
        }
        catch (_e)
        {
            var _version_parts = string_split("2023.11.1.160", ".");
            is_gmrt = array_length(_version_parts) == 4 && real(_version_parts[0]) < 2020;
        }
    }
    
    if (is_gmrt && os_type == os_windows)
        return string("{0}/assets/{1}", working_directory, arg0);
    
    if (os_type == os_switch)
        return string("rom:/{0}{1}", working_directory, arg0);
    else if (os_type == os_android)
        return string("file:///android_asset/{0}", arg0);
    
    return string("{0}{1}", working_directory, arg0);
}

function fmod_path_user(arg0)
{
    return string("{0}{1}", game_save_id, arg0);
}

function fmod_error_string(arg0 = fmod_last_result())
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "No errors.";
        
        case UnknownEnum.Value_1:
            return "Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound).";
        
        case UnknownEnum.Value_2:
            return "Error trying to allocate a channel.";
        
        case UnknownEnum.Value_3:
            return "The specified channel has been reused to play another sound.";
        
        case UnknownEnum.Value_4:
            return "DMA Failure.  See debug output for more information.";
        
        case UnknownEnum.Value_5:
            return "DSP connection error.  Connection possibly caused a cyclic dependency or connected dsps with incompatible buffer counts.";
        
        case UnknownEnum.Value_6:
            return "DSP return code from a DSP process query callback.  Tells mixer not to call the process callback and therefore not consume CPU.  Use this to optimize the DSP graph.";
        
        case UnknownEnum.Value_7:
            return "DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format, or a matrix may have been set with the wrong size if the target unit has a specified channel map.";
        
        case UnknownEnum.Value_8:
            return "DSP is already in the mixer's DSP network. It must be removed before being reinserted or released.";
        
        case UnknownEnum.Value_9:
            return "DSP connection error.  Couldn't find the DSP unit specified.";
        
        case UnknownEnum.Value_10:
            return "DSP operation error.  Cannot perform operation on this DSP as it is reserved by the system.";
        
        case UnknownEnum.Value_11:
            return "DSP return code from a DSP process query callback.  Tells mixer silence would be produced from read, so go idle and not consume CPU.  Use this to optimize the DSP graph.";
        
        case UnknownEnum.Value_12:
            return "DSP operation cannot be performed on a DSP of this type.";
        
        case UnknownEnum.Value_13:
            return "Error loading file.";
        
        case UnknownEnum.Value_14:
            return "Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format.";
        
        case UnknownEnum.Value_15:
            return "Media was ejected while reading.";
        
        case UnknownEnum.Value_16:
            return "End of file unexpectedly reached while trying to read essential data (truncated?).";
        
        case UnknownEnum.Value_17:
            return "End of current chunk reached while trying to read data.";
        
        case UnknownEnum.Value_18:
            return "File not found.";
        
        case UnknownEnum.Value_19:
            return "Unsupported file or audio format.";
        
        case UnknownEnum.Value_20:
            return "There is a version mismatch between the FMOD header and either the FMOD Studio library or the FMOD Low Level library.";
        
        case UnknownEnum.Value_21:
            return "A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere.";
        
        case UnknownEnum.Value_22:
            return "The specified resource requires authentication or is forbidden.";
        
        case UnknownEnum.Value_23:
            return "Proxy authentication is required to access the specified resource.";
        
        case UnknownEnum.Value_24:
            return "A HTTP server error occurred.";
        
        case UnknownEnum.Value_25:
            return "The HTTP request timed out.";
        
        case UnknownEnum.Value_26:
            return "FMOD was not initialized correctly to support this function.";
        
        case UnknownEnum.Value_27:
            return "Cannot call this command after System::init.";
        
        case UnknownEnum.Value_28:
            return "An error occurred that wasn't supposed to.  Contact support.";
        
        case UnknownEnum.Value_29:
            return "Value passed in was a NaN, Inf or denormalized float.";
        
        case UnknownEnum.Value_30:
            return "An invalid object handle was used.";
        
        case UnknownEnum.Value_31:
            return "An invalid parameter was passed to this function.";
        
        case UnknownEnum.Value_32:
            return "An invalid seek position was passed to this function.";
        
        case UnknownEnum.Value_33:
            return "An invalid speaker was passed to this function based on the current speaker mode.";
        
        case UnknownEnum.Value_34:
            return "The syncpoint did not come from this sound handle.";
        
        case UnknownEnum.Value_35:
            return "Tried to call a function on a thread that is not supported.";
        
        case UnknownEnum.Value_36:
            return "The vectors passed in are not unit length, or perpendicular.";
        
        case UnknownEnum.Value_37:
            return "Reached maximum audible playback count for this sound's soundgroup.";
        
        case UnknownEnum.Value_38:
            return "Not enough memory or resources.";
        
        case UnknownEnum.Value_39:
            return "Can't use FMOD_RESULT.OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_RESULT.CREATECOMPRESSEDSAMPLE was used.";
        
        case UnknownEnum.Value_40:
            return "Tried to call a command on a 2d sound when the command was meant for 3d sound.";
        
        case UnknownEnum.Value_41:
            return "Tried to use a feature that requires hardware support.";
        
        case UnknownEnum.Value_42:
            return "Couldn't connect to the specified host.";
        
        case UnknownEnum.Value_43:
            return "A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere.";
        
        case UnknownEnum.Value_44:
            return "The specified URL couldn't be resolved.";
        
        case UnknownEnum.Value_45:
            return "Operation on a non-blocking socket could not complete immediately.";
        
        case UnknownEnum.Value_46:
            return "Operation could not be performed because specified sound/DSP connection is not ready.";
        
        case UnknownEnum.Value_47:
            return "Error initializing output device, but more specifically, the output device is already in use and cannot be reused.";
        
        case UnknownEnum.Value_48:
            return "Error creating hardware sound buffer.";
        
        case UnknownEnum.Value_49:
            return "A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted.";
        
        case UnknownEnum.Value_50:
            return "Soundcard does not support the specified format.";
        
        case UnknownEnum.Value_51:
            return "Error initializing output device.";
        
        case UnknownEnum.Value_52:
            return "The output device has no drivers installed.  If pre-init, FMOD_RESULT.OUTPUT_NOSOUND is selected as the output mode.  If post-init, the function just fails.";
        
        case UnknownEnum.Value_53:
            return "An unspecified error has been returned from a plugin.";
        
        case UnknownEnum.Value_54:
            return "A requested output, dsp unit type or codec was not available.";
        
        case UnknownEnum.Value_55:
            return "A resource that the plugin requires cannot be allocated or found. (ie the DLS file for MIDI playback)";
        
        case UnknownEnum.Value_56:
            return "A plugin was built with an unsupported SDK version.";
        
        case UnknownEnum.Value_57:
            return "An error occurred trying to initialize the recording device.";
        
        case UnknownEnum.Value_58:
            return "Reverb properties cannot be set on this channel because a parent channelgroup owns the reverb connection.";
        
        case UnknownEnum.Value_59:
            return "Specified instance in FMOD_RESULT.REVERB_PROPERTIES couldn't be set. Most likely because it is an invalid instance number or the reverb doesn't exist.";
        
        case UnknownEnum.Value_60:
            return "The error occurred because the sound referenced contains subsounds when it shouldn't have, or it doesn't contain subsounds when it should have.  The operation may also not be able to be performed on a parent sound.";
        
        case UnknownEnum.Value_61:
            return "This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first.";
        
        case UnknownEnum.Value_62:
            return "Shared subsounds cannot be replaced or moved from their parent stream, such as when the parent stream is an FSB file.";
        
        case UnknownEnum.Value_63:
            return "The specified tag could not be found or there are no tags.";
        
        case UnknownEnum.Value_64:
            return "The sound created exceeds the allowable input channel count.  This can be increased using the 'maxinputchannels' parameter in System::setSoftwareFormat.";
        
        case UnknownEnum.Value_65:
            return "The retrieved string is too long to fit in the supplied buffer and has been truncated.";
        
        case UnknownEnum.Value_66:
            return "Something in FMOD hasn't been implemented when it should be! contact support!";
        
        case UnknownEnum.Value_67:
            return "This command failed because System::init or System::setDriver was not called.";
        
        case UnknownEnum.Value_68:
            return "A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified.";
        
        case UnknownEnum.Value_69:
            return "The version number of this file format is not supported.";
        
        case UnknownEnum.Value_70:
            return "The specified bank has already been loaded.";
        
        case UnknownEnum.Value_71:
            return "The live update connection failed due to the game already being connected.";
        
        case UnknownEnum.Value_72:
            return "The live update connection failed due to the game data being out of sync with the tool.";
        
        case UnknownEnum.Value_73:
            return "The live update connection timed out.";
        
        case UnknownEnum.Value_74:
            return "The requested event, parameter, bus or vca could not be found.";
        
        case UnknownEnum.Value_75:
            return "The Studio::System object is not yet initialized.";
        
        case UnknownEnum.Value_76:
            return "The specified resource is not loaded, so it can't be unloaded.";
        
        case UnknownEnum.Value_77:
            return "An invalid string was passed to this function.";
        
        case UnknownEnum.Value_78:
            return "The specified resource is already locked.";
        
        case UnknownEnum.Value_79:
            return "The specified resource is not locked, so it can't be unlocked.";
        
        case UnknownEnum.Value_80:
            return "The specified recording driver has been disconnected.";
        
        case UnknownEnum.Value_81:
            return "The length provided exceeds the allowable limit.";
        
        default:
            return "Unknown error.";
    }
}

function fmod_handle_async_events()
{
    static _async_buffer = buffer_create(2024, buffer_grow, 1);
    
    var _buffer_address = buffer_get_address(_async_buffer);
    var _buffer_size = buffer_get_size(_async_buffer);
    var _size = fmod_fetch_callbacks(_buffer_address, _buffer_size);
    
    if (_size < 0)
        return buffer_resize(_async_buffer, -_size * 2);
    
    buffer_seek(_async_buffer, buffer_seek_start, 0);
    var _map_array = ext_buffer_unpack(_async_buffer, true);
    var _array_size = array_length(_map_array);
    
    for (var _i = 0; _i < _array_size; _i++)
        event_perform_async(ev_async_social, _map_array[_i]);
}

function FmodVector() constructor
{
    x = 0;
    y = 0;
    z = 0;
}

function FmodCPUUsage() constructor
{
    dsp = 0;
    stream = 0;
    geometry = 0;
    update = 0;
    convolution1 = 0;
    convolution2 = 0;
}

function FmodCPUTimeUsage() constructor
{
    inclusive = 0;
    exclusive = 0;
}

function FmodLoopPoints() constructor
{
    loop_start = 0;
    loop_end = 0;
}

function FmodMinMaxDistance() constructor
{
    min_distance = 0;
    max_distance = 0;
}

function FmodReverbProperties() constructor
{
    decay_time = 1500;
    early_delay = 7;
    late_delay = 11;
    hf_reference = 5000;
    hf_decay_ratio = 50;
    diffusion = 50;
    density = 100;
    low_shelf_frequency = 250;
    low_shelf_gain = 0;
    high_cut = 200000;
    early_late_mix = 0;
    wet_level = -6;
}

function Fmod3DConeSettings() constructor
{
    inside_cone_angle = 0;
    outside_cone_angle = 0;
    outside_volume = 0;
}

function Fmod3DAttributes() constructor
{
    position = new FmodVector();
    velocity = new FmodVector();
    forward = new FmodVector();
    up = new FmodVector();
}

function FmodMemoryStats() constructor
{
    current_alloced = 0;
    max_alloced = 0;
}

function fmod_memory_get_stats(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_memory_get_stats_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_debug_initialize(arg0, arg1 = UnknownEnum.Value_0, arg2 = pointer_null)
{
    return fmod_debug_initialize_multiplatform(arg0, arg1, arg2);
}

function FmodSystemCreateSoundExInfo() constructor
{
    length = 0;
    file_offset = 0;
    num_channels = 0;
    default_frequency = 0;
    format = 0;
    decode_buffer_size = 0;
    initial_subsound = 0;
    num_subsounds = 0;
    inclusion_list_num = 0;
    dls_name = pointer_null;
    encryption_key = pointer_null;
    max_polyphony = 64;
    suggested_sound_type = 0;
    file_buffer_size = 0;
    channel_order = 0;
    initial_seek_position = 0;
    initial_seek_pos_type = 0;
    ignore_set_filesystem = 0;
    audio_queue_policy = 0;
    min_midi_granularity = 512;
    non_block_thread_id = 0;
}

function fmod_system_create_sound(arg0, arg1, arg2 = {})
{
    var _args = [[arg2, undefined]];
    
    if (!is_string(arg0))
        arg0 = buffer_get_address(arg0);
    
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_create_sound_multiplatform(arg0, arg1, _args_buffer_address);
}

function fmod_system_create_stream(arg0, arg1, arg2 = {})
{
    var _args = [[arg2, undefined]];
    
    if (!is_string(arg0))
        arg0 = buffer_get_address(arg0);
    
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_create_stream_multiplatform(arg0, arg1, _args_buffer_address);
}

function FmodSystemAdvancedSettings() constructor
{
    max_mpeg_codecs = 32;
    max_adpcm_codecs = 32;
    max_xma_codecs = 32;
    max_vorbis_codecs = 32;
    max_at9_codecs = 32;
    max_fadpcm_codecs = 32;
    max_pcm_codecs = 32;
    asio_num_channels = 0;
    vol0_virtual_vol = 0;
    default_decode_buffer_size = 400;
    profile_port = 9264;
    geometry_max_fade_time = 500;
    distance_filter_center_freq = 1500;
    reverb_3d_instance = 0;
    dsp_buffer_pool_size = 8;
    resampler_method = 0;
    random_seed = 0;
    max_convolution_threads = 3;
    max_opus_codecs = 32;
}

function fmod_system_set_advanced_settings(arg0)
{
    var _args = [[arg0, undefined]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_set_advanced_settings_multiplatform(_args_buffer_address);
}

function fmod_system_get_advanced_settings()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_advanced_settings_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_system_play_sound(arg0, arg1, arg2 = undefined)
{
    arg2 ??= fmod_system_get_master_channel_group();
    return fmod_system_play_sound_multiplatform(arg0, arg2, arg1);
}

function fmod_system_play_dsp(arg0, arg1, arg2 = undefined)
{
    arg2 ??= fmod_system_get_master_channel_group();
    return fmod_system_play_dsp_multiplatform(arg0, arg2, arg1);
}

function fmod_system_get_default_mix_matrix(arg0, arg1, arg2)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_default_mix_matrix_multiplatform(arg0, arg1, arg2, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemDriverInfo() constructor
{
    index = 0;
    name = "";
    guid = "";
    system_rate = 0;
    speaker_mode = 0;
    speaker_mode_channels = 0;
}

function fmod_system_get_driver_info(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_driver_info_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemSoftwareFormat() constructor
{
    sample_rate = 0;
    speaker_mode = 0;
    num_raw_speakers = 0;
}

function fmod_system_get_software_format()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_software_format_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemDSPBufferSize() constructor
{
    buff_size = 0;
    num_buffers = 0;
}

function fmod_system_get_dsp_buffer_size()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_dsp_buffer_size_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemStreamBufferSize() constructor
{
    file_buffer_size = 0;
    file_buffer_size_type = 0;
}

function fmod_system_get_stream_buffer_size()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_stream_buffer_size_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemSpeakerPosition() constructor
{
    x = 0;
    y = 0;
    active = false;
}

function fmod_system_get_speaker_position(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_speaker_position_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystem3DSettings() constructor
{
    doppler_scale = 0;
    distance_factor = 0;
    rolloff_scale = 0;
}

function fmod_system_get_3d_settings()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_3d_settings_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemChannelsPlaying() constructor
{
    doppler_scale = 0;
    distance_factor = 0;
    rolloff_scale = 0;
}

function fmod_system_get_channels_playing()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_channels_playing_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_system_get_cpu_usage()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_cpu_usage_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemFileUsage() constructor
{
    sample_bytes_read = 0;
    stream_bytes_read = 0;
    other_bytes_read = 0;
}

function fmod_system_get_file_usage()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_file_usage_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
}

function fmod_system_set_3d_listener_attributes(arg0, arg1, arg2, arg3, arg4)
{
    var _args = [[arg1, 8], [arg2, 8], [arg3, 8], [arg4, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_set_3d_listener_attributes_multiplatform(arg0, _args_buffer_address);
}

function fmod_system_get_3d_listener_attributes(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_3d_listener_attributes_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_system_attach_channel_group_to_port(arg0, arg1, arg2, arg3 = true)
{
    var _args = [[arg0, 6], [arg1, 12], [arg2, 12], [arg3, 10]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_attach_channel_group_to_port_multiplatform(_args_buffer_address);
}

function FmodSystemRecordNumDrivers() constructor
{
    num_drivers = 0;
    num_connected = 0;
}

function fmod_system_get_record_num_drivers()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_record_num_drivers_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemRecordDriverInfo() constructor
{
    name = "";
    guid = "";
    system_rate = 0;
    speaker_mode = 0;
    speaker_mode_channels = 0;
    state = 0;
}

function fmod_system_get_record_driver_info(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_record_driver_info_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodSystemGeometryOcclusion() constructor
{
    direct = 0;
    reverb = 0;
    listener = new FmodVector();
    source = new FmodVector();
}

function fmod_system_get_geometry_occlusion()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_geometry_occlusion_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_system_set_reverb_properties(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_set_reverb_properties_multiplatform(arg0, _args_buffer_address);
}

function fmod_system_get_reverb_properties(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_system_get_reverb_properties_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_system_load_geometry(arg0, arg1)
{
    var _args = [[arg0, 253]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_system_load_geometry_multiplatform(_args_buffer_address, arg1);
}

function fmod_system_update()
{
    fmod_handle_async_events();
    return fmod_system_update_multiplatform();
}

function fmod_channel_get_loop_points(arg0, arg1, arg2)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_get_loop_points_multiplatform(arg0, arg1, arg2, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_group_add_group(arg0, arg1, arg2 = true)
{
    return fmod_channel_group_add_group_multiplatform(arg0, arg1, arg2);
}

function fmod_channel_control_set_3d_attributes(arg0, arg1, arg2)
{
    var _args = [[arg1, 8], [arg2, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_3d_attributes_multiplatform(arg0, _args_buffer_address);
}

function FmodControl3DAttributes() constructor
{
    pos = new FmodVector();
    vel = new FmodVector();
}

function fmod_channel_control_get_3d_attributes(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_attributes_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_set_3d_cone_orientation(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_3d_cone_orientation_multiplatform(arg0, _args_buffer_address);
}

function fmod_channel_control_get_3d_cone_orientation(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_cone_orientation_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_get_3d_cone_settings(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_cone_settings_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_set_3d_custom_rolloff(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_3d_custom_rolloff_multiplatform(arg0, _args_buffer_address);
}

function fmod_channel_control_get_3d_custom_rolloff(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_custom_rolloff_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function FmodControl3DDistanceFilter() constructor
{
    custom = false;
    custom_level = 0;
    center_freq = 0;
}

function fmod_channel_control_get_3d_distance_filter(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_distance_filter_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodControl3DMinMaxDistance() constructor
{
    min_dist = 0;
    max_dist = 0;
}

function fmod_channel_control_get_3d_min_max_distance(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_min_max_distance_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodControl3DOcclusion() constructor
{
    direct = 0;
    reverb = 0;
}

function fmod_channel_control_get_3d_occlusion(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_3d_occlusion_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_set_mix_levels_input(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_mix_levels_input_multiplatform(arg0, _args_buffer_address);
}

function fmod_channel_control_set_mix_matrix(arg0, arg1, arg2, arg3, arg4 = 0)
{
    var _args = [[arg1 ?? [], 8], [arg2, 6], [arg3, 6], [arg4, 6]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_mix_matrix_multiplatform(arg0, _args_buffer_address);
}

function FmodControlMixMatrix() constructor
{
    matrix = [];
    out_channels = 0;
    in_channels = 0;
}

function fmod_channel_control_get_mix_matrix(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_mix_matrix_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function FmodControlDSPClock() constructor
{
    dsp_clock = 0;
    parent_clock = 0;
}

function fmod_channel_control_get_dsp_clock(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_dsp_clock_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_set_delay(arg0, arg1 = 0, arg2 = 0, arg3 = true)
{
    var _args = [[arg1, 12], [arg2, 12], [arg3, 10]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_delay_multiplatform(arg0, _args_buffer_address);
}

function FmodControlDelay() constructor
{
    dsp_clock_start = 0;
    dsp_clock_end = 0;
    stop_channels = false;
}

function fmod_channel_control_get_delay(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_delay_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_channel_control_add_fade_point(arg0, arg1, arg2)
{
    var _args = [[arg1, 12], [clamp(arg2, 0, infinity), 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_add_fade_point_multiplatform(arg0, _args_buffer_address);
}

function fmod_channel_control_set_fade_point_ramp(arg0, arg1, arg2)
{
    var _args = [[arg1, 12], [clamp(arg2, 0, infinity), 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_set_fade_point_ramp_multiplatform(arg0, _args_buffer_address);
}

function fmod_channel_control_remove_fade_points(arg0, arg1, arg2)
{
    var _args = [[arg1, 12], [arg2, 12]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_channel_control_remove_fade_points_multiplatform(arg0, _args_buffer_address);
}

function FmodControlFadePoints() constructor
{
    num_points = 0;
    point_dsp_clock = [];
    point_volume = [];
}

function fmod_channel_control_get_fade_points(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_channel_control_get_fade_points_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_dsp_add_input(arg0, arg1, arg2 = UnknownEnum.Value_0)
{
    return fmod_dsp_add_input_multiplatform(arg0, arg1, arg2);
}

function FmodDSPConnectionData() constructor
{
    dsp_ref = 0;
    dsp_connection_ref = 0;
}

function fmod_dsp_get_input(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_input_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_dsp_get_output(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_output_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_dsp_set_parameter_data(arg0, arg1, arg2, arg3 = undefined)
{
    arg3 ??= buffer_get_size(arg2);
    fmod_dsp_set_parameter_data_multiplatform(arg0, arg1, buffer_get_address(arg2), arg3);
}

function fmod_dsp_get_parameter_data(arg0, arg1, arg2, arg3 = undefined)
{
    arg3 ??= buffer_get_size(arg2);
    return fmod_dsp_get_parameter_data_multiplatform(arg0, arg1, buffer_get_address(arg2), arg3);
}

function FmodDspParameterDescValue() constructor
{
    default_val = 0;
    maximum = 0;
    minimum = 0;
}

function FmodDspParameterDesc() constructor
{
    type = 0;
    name = "";
    label = "";
    description = "";
    int_value = new FmodDspParameterDescValue();
    float_value = new FmodDspParameterDescValue();
    bool_value = new FmodDspParameterDescValue();
}

function fmod_dsp_get_parameter_info(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_parameter_info_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDspParameterDesc();
}

function FmodDSPChannelFormat() constructor
{
    channel_mask = 0;
    num_channels = 0;
    speaker_mode = 0;
}

function fmod_dsp_get_channel_format(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_channel_format_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPChannelFormat();
}

function fmod_dsp_get_output_channel_format(arg0, arg1, arg2, arg3)
{
    var _args = [[arg1, 5], [arg2, 6], [arg3, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_output_channel_format_multiplatform(arg0, _args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPChannelFormat();
}

function FmodDSPMeteringInfo() constructor
{
    num_samples = 0;
    peak_level = [];
    rms_level = [];
    num_channels = 0;
}

function FmodDSPInOutMeteringInfo() constructor
{
    in = new FmodDSPMeteringInfo();
    out = new FmodDSPMeteringInfo();
}

function fmod_dsp_get_metering_info(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_metering_info_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPInOutMeteringInfo();
}

function FmodDSPMeteringEnableInfo() constructor
{
    enabled_in = false;
    enabled_out = false;
}

function fmod_dsp_get_metering_enabled(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_metering_enabled_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPMeteringEnableInfo();
}

function FmodDSPWetDryMixInfo() constructor
{
    pre_wet = 0;
    post_wet = 0;
    dry = 0;
}

function fmod_dsp_get_wet_dry_mix(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_wet_dry_mix_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? FmodDSPWetDryMixInfo();
}

function FmodDSPInfo() constructor
{
    name = "";
    version = 0;
    channels = 0;
    config_width = 0;
    config_height = 0;
}

function fmod_dsp_get_info(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_info_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPInfo();
}

function fmod_dsp_get_cpu_usage(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_get_cpu_usage_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodCPUTimeUsage();
}

function fmod_dsp_disconnect_from(arg0, arg1 = 0, arg2 = 0)
{
    return fmod_dsp_disconnect_from_mutliplatform(arg0, arg1, arg2);
}

function fmod_dsp_connection_set_mix_matrix(arg0, arg1, arg2, arg3, arg4 = 0)
{
    var _args = [[arg1, 8], [arg2, 6], [arg3, 6], [arg4, 6]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_dsp_connection_set_mix_matrix_multiplatform(arg0, _args_buffer_address);
}

function FmodDSPConnectionMixMatrix() constructor
{
    matrix = [];
    out_channels = 0;
    in_channels = 0;
}

function fmod_dsp_connection_get_mix_matrix(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_dsp_connection_get_mix_matrix_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodDSPConnectionMixMatrix();
}

function FmodGeometryPolygonAttributes() constructor
{
    direct_occlusion = 0;
    reverb_occlusion = 0;
    double_sided = false;
}

function fmod_geometry_get_polygon_attributes(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_polygon_attributes_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodGeometryPolygonAttributes();
}

function fmod_geometry_set_polygon_vertex(arg0, arg1, arg2, arg3)
{
    var _args = [[arg3, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_set_polygon_vertex_multiplatform(arg0, arg1, arg2, _args_buffer_address);
}

function fmod_geometry_get_polygon_vertex(arg0, arg1, arg2)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_polygon_vertex_multiplatform(arg0, arg1, arg2, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodVector();
}

function fmod_geometry_set_position(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_set_position_multiplatform(arg0, _args_buffer_address);
}

function fmod_geometry_get_position(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_position_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodVector();
}

function fmod_geometry_set_rotation(arg0, arg1, arg2)
{
    var _args = [[arg1, 8], [arg2, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_set_rotation_multiplatform(arg0, _args_buffer_address);
}

function FmodGeometryRotation() constructor
{
    forward = new FmodVector();
    up = new FmodVector();
}

function fmod_geometry_get_rotation(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_rotation_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodGeometryRotation();
}

function fmod_geometry_set_scale(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_set_scale_multiplatform(arg0, _args_buffer_address);
}

function fmod_geometry_get_scale(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_scale_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodVector();
}

function fmod_geometry_add_polygon(arg0, arg1, arg2, arg3, arg4)
{
    var _args = [[arg1, 8], [arg2, 8], [arg3, 10], [arg4, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_add_polygon_multiplatform(arg0, _args_buffer_address);
}

function FmodMaxPolygonsInfo() constructor
{
    max_polygons = 0;
    max_vertices = 0;
}

function fmod_geometry_get_max_polygons(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_geometry_get_max_polygons_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodMaxPolygonsInfo();
}

function fmod_geometry_save(arg0, arg1)
{
    var _args = [[arg1, 253]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_geometry_save_multiplatform(arg0, _args_buffer_address);
}

function fmod_reverb_3d_set_3d_attributes(arg0, arg1, arg2, arg3)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_reverb_3d_set_3d_attributes_multiplatform(arg0, _args_buffer_address, arg2, arg3);
}

function FmodReverb3DAttributes() : FmodMinMaxDistance() constructor
{
    position = new FmodVector();
}

function fmod_reverb_3d_get_3d_attributes(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_reverb_3d_get_3d_attributes_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodReverb3DAttributes();
}

function fmod_reverb_3d_get_properties(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_reverb_3d_get_properties_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodReverbProperties();
}

function FmodSoundFormat() constructor
{
    type = UnknownEnum.Value_0;
    format = UnknownEnum.Value_0;
    channels = 0;
    bits = 0;
}

function fmod_sound_get_format(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_format_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundFormat();
}

function FmodSoundNumTags() constructor
{
    num_tags = 0;
    num_tags_updated = 0;
}

function fmod_sound_get_num_tags(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_num_tags_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundNumTags();
}

function FmodSoundTag() constructor
{
    name = "";
    type = 0;
    update = 0;
    data_len = 0;
    data_type = 0;
}

function fmod_sound_get_tag(arg0, arg1, arg2)
{
    var _args = [[arg2, 253]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_tag_multiplatform(arg0, arg1, _args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundTag();
}

function fmod_sound_get_3d_cone_settings(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_3d_cone_settings_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new Fmod3DConeSettings();
}

function fmod_sound_set_3d_custom_rolloff(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_sound_set_3d_custom_rolloff_multiplatform(arg0, _args_buffer_address);
}

function fmod_sound_get_3d_custom_rolloff(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_3d_custom_rolloff_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function fmod_sound_get_3d_min_max_distance(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_3d_min_max_distance_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodMinMaxDistance();
}

function FmodSoundDefaults() constructor
{
    frequency = 0;
    priority = 0;
}

function fmod_sound_get_defaults(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_defaults_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundDefaults();
}

function fmod_sound_get_loop_points(arg0, arg1, arg2)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_loop_points_multiplatform(arg0, arg1, arg2, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodLoopPoints();
}

function FmodSoundOpenState() constructor
{
    open_state = 0;
    percent_buffered = 0;
    starving = false;
    disk_busy = false;
}

function fmod_sound_get_open_state(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_open_state_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundOpenState();
}

function fmod_sound_read_data(arg0, arg1, arg2, arg3)
{
    var _args = [[arg1, 253], [arg2, 5], [arg3, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_sound_read_data_multiplatform(arg0, _args_buffer_address);
}

function FmodSoundLockChunck() constructor
{
    length = 0;
    patch_address = pointer_null;
}

function FmodSoundLock() constructor
{
    buffer1 = new FmodSoundLockChunck();
    buffer2 = new FmodSoundLockChunck();
}

function fmod_sound_lock(arg0, arg1, arg2, arg3, arg4)
{
    var _args = [[arg1, 5], [arg2, 5], [arg3, 253], [arg4, 253]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_lock_multiplatform(arg0, _args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSoundLock();
}

function fmod_sound_unlock(arg0, arg1, arg2, arg3, arg4 = undefined, arg5 = undefined, arg6 = undefined)
{
    var _args = [[arg1, 253], [arg2, 5], [arg3, 252], [arg4, 253], [arg5, 5], [arg6, 252]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_sound_unlock_multiplatform(arg0, _args_buffer_address);
}

function FmodSyncPoint() constructor
{
    name = "";
    offset = 0;
}

function fmod_sound_get_sync_point(arg0, arg1, arg2)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_sound_get_sync_point_multiplatform(arg0, arg1, arg2, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodSyncPoint();
}

function FmodStudioMemoryUsage() constructor
{
    inclusive = 0;
    exclusive = 0;
    sample_data = 0;
}

function FmodStudioParameter() constructor
{
    value = 0;
    final_value = 0;
}

function FmodStudioParameterId() constructor
{
    data1 = 0;
    data2 = 0;
}

function fmod_studio_bus_set_port_index(arg0, arg1)
{
    var _args = [[arg1, 12]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_bus_set_port_index_multiplatform(arg0, _args_buffer_address);
}

function fmod_studio_bus_get_port_index(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bus_get_port_index_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_studio_bus_get_cpu_usage(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bus_get_cpu_usage_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodCPUUsage();
}

function fmod_studio_bus_get_memory_usage(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bus_get_memory_usage_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioMemoryUsage();
}

function FmodCommandReplayCurrentCommand() constructor
{
    command_index = 0;
    command_time = 0;
}

function fmod_studio_command_replay_get_current_command(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_command_replay_get_current_command_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodCommandReplayCurrentCommand();
}

function FmodCommandReplayCommandInfo() constructor
{
    command_name = "";
    parent_command_index = 0;
    frame_time = 0;
    instance_type = 0;
    output_type = 0;
    instance_handle = 0;
    output_handle = 0;
}

function fmod_studio_command_replay_get_command_info(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_command_replay_get_command_info_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodCommandReplayCommandInfo();
}

function fmod_studio_event_description_get_min_max_distance(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_min_max_distance_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodMinMaxDistance();
}

function FmodStudioUserProperty() constructor
{
    name = "";
    type = UnknownEnum.Value_1;
    string_value = "";
    int_value = 0;
    bool_value = false;
    float_value = 1;
}

function fmod_studio_event_description_get_user_property(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_user_property_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioUserProperty();
}

function fmod_studio_event_description_get_user_property_by_index(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_user_property_by_index_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioUserProperty();
}

function FmodStudioEventInstanceVolume() constructor
{
    volume = 0;
    final_volume = 0;
}

function fmod_studio_event_instance_get_volume(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_volume_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioEventInstanceVolume();
}

function fmod_studio_event_instance_set_3d_attributes(arg0, arg1)
{
    var _args = [[arg1, 8]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_event_instance_set_3d_attributes_multiplatform(arg0, _args_buffer_address);
}

function fmod_studio_event_instance_get_3d_attributes(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_3d_attributes_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new Fmod3DAttributes();
}

function fmod_studio_event_instance_get_min_max_distance(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_min_max_distance_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodMinMaxDistance();
}

function fmod_studio_event_instance_get_parameter_by_name(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_parameter_by_name_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameter();
}

function fmod_studio_event_instance_set_parameter_by_name(arg0, arg1, arg2, arg3 = false)
{
    return fmod_studio_event_instance_set_parameter_by_name_multiplatform(arg0, arg1, arg2, arg3);
}

function fmod_studio_event_instance_set_parameter_by_id(arg0, arg1, arg2, arg3 = false)
{
    var _args = [[arg1, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_event_instance_set_parameter_by_id_multiplatform(arg0, _args_buffer_address, arg2, arg3);
}

function fmod_studio_event_instance_set_parameter_by_id_with_label(arg0, arg1, arg2, arg3 = false)
{
    var _args = [[_paramater_id, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_event_instance_set_parameter_by_id_with_label_multiplatform(arg0, _args_buffer_address, arg2, arg3);
}

function fmod_studio_event_instance_get_parameter_by_id(arg0, arg1)
{
    var _args = [[arg1, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_parameter_by_id_multiplatform(arg0, _args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameter();
}

function fmod_studio_event_instance_get_cpu_usage(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_cpu_usage_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodCPUUsage();
}

function fmod_studio_event_instance_get_memory_usage(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_instance_get_memory_usage_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioMemoryUsage();
}

function fmod_studio_system_load_bank_memory(arg0, arg1, arg2, arg3)
{
    return fmod_studio_system_load_bank_memory_multiplatform(buffer_get_address(arg0), arg1, arg2, arg3);
}

function fmod_studio_system_set_listener_attributes(arg0, arg1, arg2 = undefined)
{
    var _args = [[arg1, 8]];
    
    if (!is_undefined(arg2))
        array_push(_args, [arg2, 8]);
    
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_system_set_listener_attributes_multiplatform(arg0, _args_buffer_address);
}

function FmodStudioListenerAttributes() constructor
{
    attributes = new Fmod3DAttributes();
    attenuation = new FmodVector();
}

function fmod_studio_system_get_listener_attributes(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_listener_attributes_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioListenerAttributes();
}

function fmod_studio_system_get_parameter_by_id(arg0)
{
    var _args = [[arg0, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_parameter_by_id_multiplatform(_args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value;
}

function fmod_studio_system_set_parameter_by_id(arg0, arg1, arg2)
{
    var _args = [[arg0, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_system_set_parameter_by_id_multiplatform(_args_buffer_address, arg1, arg2);
}

function fmod_studio_system_set_parameter_by_id_with_label(arg0, arg1, arg2 = false)
{
    var _args = [[arg0, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_system_set_parameter_by_id_with_label_multiplatform(_args_buffer_address, arg1, arg2);
}

function fmod_studio_system_get_parameter_by_name(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_parameter_by_name_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameter();
}

function fmod_studio_system_get_parameter_label_by_id(arg0, arg1)
{
    var _args = [[arg0, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_system_get_parameter_label_by_id_multiplatform(_args_buffer_address, arg1);
}

function FmodStudioBufferInfo() constructor
{
    current_usage = 0;
    peak_usage = 0;
    capacity = 0;
    stall_count = 0;
    stall_time = 0;
}

function FmodStudioBufferUsage() constructor
{
    command_queue = FmodStudioBufferInfo();
}

function fmod_studio_system_get_buffer_usage()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_buffer_usage_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioBufferUsage();
}

function fmod_studio_system_get_memory_usage()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_memory_usage_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioMemoryUsage();
}

function FmodStudioCPUUsage() constructor
{
    core = new FmodCPUUsage();
    studio = 
    {
        update: 0
    };
}

function fmod_studio_system_get_cpu_usage()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_cpu_usage_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioCPUUsage();
}

function fmod_studio_system_get_bank_list()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_bank_list_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function fmod_studio_system_get_parameter_description_by_name(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_parameter_description_by_name_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameterDescription();
}

function fmod_studio_system_get_parameter_description_by_id(arg0)
{
    var _args = [[arg0, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_parameter_description_by_id_multiplatform(_args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameterDescription();
}

function fmod_studio_system_get_parameter_description_list()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_parameter_description_list_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function FmodStudioAdvancedSettings() constructor
{
    command_queue_size = 32768;
    handle_initial_size = 65536;
    studio_update_period = 20;
    idle_sampledata_pool_size = 262144;
    streaming_schedule_delay = 8192;
    encryption_key = pointer_null;
}

function fmod_studio_system_set_advanced_settings(arg0)
{
    var _args = [[arg0.command_queue_size, 5], [arg0.handle_initial_size, 5], [arg0.studio_update_period, 6], [arg0.idle_sample_data_pool_size, 6], [arg0.streaming_schedule_delay, 5], [arg0.encryption_key, 11]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_system_set_advanced_settings_multiplatform(_args_buffer_address);
}

function fmod_studio_system_get_advanced_settings()
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_advanced_settings_multiplatform(_return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioAdvancedSettings();
}

function FmodStudioSoundInfo() constructor
{
    ext_info = new FmodSystemCreateSoundExInfo();
    name_or_data = "";
    mode = 0;
    sub_sound_index = 0;
}

function fmod_studio_system_get_sound_info(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_system_get_sound_info_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioSoundInfo();
}

function fmod_studio_system_set_parameter_by_name(arg0, arg1, arg2 = false)
{
    return fmod_studio_system_set_parameter_by_name_multiplatform(arg0, arg1, arg2);
}

function fmod_studio_system_set_parameter_by_name_with_label(arg0, arg1, arg2 = false)
{
    return fmod_studio_system_set_parameter_by_name_with_label_multiplatform(arg0, arg1, arg2);
}

function fmod_studio_system_update()
{
    fmod_handle_async_events();
    return fmod_studio_system_update_multiplatform();
}

function fmod_studio_bank_get_event_description_list(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bank_get_event_description_list_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function fmod_studio_bank_get_bus_list(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bank_get_bus_list_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function fmod_studio_bank_get_vca_list(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bank_get_vca_list_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function FmodStudioStringInfo() constructor
{
    path = "";
    guid = "";
}

function fmod_studio_bank_get_string_info(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_bank_get_string_info_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioStringInfo();
}

function FmodStudioParameterDescription() constructor
{
    name = "";
    parameter_id = new FmodStudioParameterId();
    minimum = 0;
    maximum = 0;
    default_value = 0;
    type = 0;
    flags = 0;
    guid = 0;
}

function fmod_studio_event_description_get_instance_list(arg0)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_instance_list_multiplatform(arg0, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? [];
}

function fmod_studio_event_description_get_parameter_description_by_id(arg0, arg1)
{
    var _args = [[arg1, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_parameter_description_by_id_multiplatform(arg0, _args_buffer_address, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameterDescription();
}

function fmod_studio_event_description_get_parameter_label_by_id(arg0, arg1, arg2)
{
    var _args = [[arg1, 5]];
    var _args_buffer_address = ext_pack_args(_args);
    return fmod_studio_event_description_get_parameter_label_by_id_multiplatform(arg0, _args_buffer_address, arg2);
}

function fmod_studio_event_description_get_parameter_description_by_index(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_parameter_description_by_index_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameterDescription();
}

function fmod_studio_event_description_get_parameter_description_by_name(arg0, arg1)
{
    var _return_buffer_address = ext_return_buffer_address();
    fmod_studio_event_description_get_parameter_description_by_name_multiplatform(arg0, arg1, _return_buffer_address);
    var _return_value = ext_buffer_unpack(ext_return_buffer());
    return _return_value ?? new FmodStudioParameterDescription();
}
