if (game_paused() || !player_collideable() || pow)
    exit;

if (image_index < 9)
{
    with (other.id)
        scr_hurtplayer(1, UnknownEnum.Value_1);
    
    shakecam(80, 7);
}
