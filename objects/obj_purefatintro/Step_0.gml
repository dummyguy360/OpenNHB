if (input_check_pressed("jump"))
{
    if (event_isplaying(introaudio))
        event_stop(introaudio, true);
    
    input_verb_consume("jump");
    room_goto(Titlescreen);
}

if (introstate == UnknownEnum.Value_7)
{
    if (logofade <= 0 && !event_isplaying(introaudio))
        room_goto(Titlescreen);
}
