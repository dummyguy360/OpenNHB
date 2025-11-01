var _max_channels = 1024;
var _flags_core = UnknownEnum.Value_0;
var _flags_studio = UnknownEnum.Value_1;
fmod_studio_system_create();
show_debug_message("fmod_studio_system_create: " + string(fmod_last_result()));
fmod_studio_system_init(_max_channels, _flags_studio, _flags_core);
show_debug_message("fmod_studio_system_init: " + string(fmod_last_result()));
fmod_main_system = fmod_studio_system_get_core_system();
var banks = ["Data/Audio/Master.strings.bank", "Data/Audio/Master.bank", "Data/Audio/Music.bank", "Data/Audio/SFX.bank"];
var i = array_length(banks) - 1;

while (i >= 0)
{
    bank[i] = fmod_studio_system_load_bank_file(fmod_path_bundle(banks[i]), UnknownEnum.Value_0);
    fmod_studio_bank_load_sample_data(bank[i]);
    i--;
}

z = 0;
show_debug_message(string("Listener Status: {0}; Position: {1}, {2}, {3}", listener_setPosition(0, x, y, z), x, y, z));
attenuationwait = 0;
soundtestmute = 0;
soundtestmuted = false;
channels = 2;
resolution = 128;
global.dsp = fmod_system_create_dsp_by_type(UnknownEnum.Value_26);
global.dspbuff = buffer_create(128, buffer_fixed, 1);
global.dspval = array_create(0);
dsp_init = false;
soundtestbus = fmod_studio_system_get_bus("bus:/Soundtest");
fmod_studio_bus_lock_channel_group(soundtestbus);
