if (game_paused() || !player_collideable())
    exit;

with (other.id)
    scr_hurtplayer(1, UnknownEnum.Value_2);
