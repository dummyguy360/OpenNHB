scr_define_collide();
grav = 0.5;
triggerNitros = true;
instance_create_depth(x, y, depth, obj_playercape);
move = 0;
movespeed = 0;
terminalVelocity = 20;
depth += 5;
z = depth;
nonplatZ = z;
state = states.actor;
afterimagetime = 0;
mach4mode = 0;
dir = image_xscale;
image_speed = 0.35;
hp = 1;
angle = 0;
jumpstop = 0;
hurt = 0;
decel = 0;
momentum = 0;
lastslipperyplat = -4;
landanim = 0;
palettespr = spr_noisepalette;
curpalette = 1;
onslipperyplat = false;
particlecooldown1 = 0;
particlecooldown2 = 0;
particlecooldown3 = 0;
particlecooldown4 = 0;
particlecooldown5 = 0;
particlecooldown6 = 0;
coyotetime = 7;
speedlinesobj = -4;
jumpbuffer = 0;
attackbuffer = 0;
slidebuffer = 0;
movestop = 0;
nextpunch = 0;
lastpunch = 0;
punchair = 1;
cartwheelcooldown = 0;
mach3crashtimer = 0;
hitstuntime = 0;
walljumptimer = 0;
wallslidecanceltimer = 0;
targetdoor = 0;
targetroom = -4;
firstroom = Patch1;
firstx = x;
firsty = y;
levelstarty = y;
hovering = 0;
hovered = 0;
dontcling = 0;
debugstate = UnknownEnum.Value_0;
ropeID = -4;
movingplatID = -4;
ondeathplatform = -4;
beforedeathroute = 
{
    room: Patch3A,
    path: pth_deathroutealt
};
targetouthouse = -4;
canchangedir = 1;
turning = 0;
platformspin = 45;
showturnsprite = false;
platformtargetpos = 0;
platformstartpos = 0;
slidetime = 18;
crouchjump = 0;
xprev = x;
bouncecombo = 0;
ropexstartpos = 0;
ropeystartpos = 0;
ropel = 0;
nointro = false;
sendtocheckpoint = false;
diddeathroute = false;
lightlevel = 1;
fakewalktime = 0;
outofhallway = true;
verticalhallway = false;
verticalhallwayposoffset = 0;
wrathofcortex = false;
hovertime = 0;
hovermaxtime = 165;
holdingdown = false;
slopfootsteptime = 0;
stepped = false;
tornadobuffer = 0;
tornadoendbuffer = 0;
jumpnum = 0;
walljumpnum = 0;
randomidletime = 240;
standstillrun = 0;
longjumptimer = 0;
outhousestartx = 0;
outhousestarty = 0;
outhousegoin = true;
playersavedstate = 
{
    state: state,
    sprite_index: sprite_index,
    mask_index: mask_index,
    image_index: image_index,
    image_speed: image_speed,
    movespeed: movespeed,
    hsp: hsp,
    vsp: vsp
};
currcheckpoint = 
{
    id: -4,
    object_index: -4,
    room: 0,
    x: 0,
    y: 0,
    collect: 0,
    destroyedcount: 0,
    pumpkins: -4,
    gems: -4,
    saveroom: -4,
    switchstate: true,
    respawnroom: ds_map_create()
};
states = [];
states[UnknownEnum.Value_0] = scr_player_normal;
states[UnknownEnum.Value_1] = scr_player_jump;
states[UnknownEnum.Value_2] = scr_player_standstillrun;
states[UnknownEnum.Value_3] = scr_player_sprint;
states[UnknownEnum.Value_4] = scr_player_sprintjump;
states[UnknownEnum.Value_5] = scr_player_machslide;
states[UnknownEnum.Value_6] = scr_player_hurt;
states[UnknownEnum.Value_7] = scr_player_bump;
states[UnknownEnum.Value_8] = scr_player_cartwheel;
states[UnknownEnum.Value_9] = scr_player_punch;
states[UnknownEnum.Value_10] = scr_player_wall;
states[UnknownEnum.Value_11] = scr_player_downslide;
states[UnknownEnum.Value_12] = scr_player_hitstun;
states[UnknownEnum.Value_13] = scr_player_wallslide;
states[UnknownEnum.Value_14] = scr_player_crouch;
states[UnknownEnum.Value_15] = scr_player_levelintro;
states[UnknownEnum.Value_16] = scr_player_noclip;

states[UnknownEnum.Value_17] = function()
{
};

states[UnknownEnum.Value_18] = scr_player_dead;
states[UnknownEnum.Value_19] = scr_player_rope;
states[UnknownEnum.Value_20] = scr_player_platformlocked;
states[UnknownEnum.Value_21] = scr_player_falllocked;
states[UnknownEnum.Value_22] = scr_player_fakewalk;
states[UnknownEnum.Value_23] = scr_player_groundpound;
states[UnknownEnum.Value_24] = scr_player_grimace;
states[UnknownEnum.Value_25] = scr_player_tornado;
states[UnknownEnum.Value_26] = scr_player_endplatform;

states[UnknownEnum.Value_27] = function()
{
};

states[UnknownEnum.Value_28] = scr_player_outhouse;
states[UnknownEnum.Value_29] = scr_player_mirror;

states[UnknownEnum.Value_30] = function()
{
};

jumpsnd = event_instance("event:/sfx/player/jump");
landsnd = event_instance("event:/sfx/player/land");
hurtsnd = event_instance("event:/sfx/player/hurt");
machsnd = event_instance("event:/sfx/player/mach");
skidsnd = event_instance("event:/sfx/player/skid");
splatsnd = event_instance("event:/sfx/player/splat");
groundpoundstartsnd = event_instance("event:/sfx/player/groundpoundstart");
groundpoundsnd = event_instance("event:/sfx/player/groundpound");
slamsnd = event_instance("event:/sfx/player/slam");
cartwheelsnd = event_instance("event:/sfx/player/cartwheel");
punchsnd = event_instance("event:/sfx/player/punch");
bitesnd = event_instance("event:/sfx/player/bite");
runinplacesnd = event_instance("event:/sfx/player/runinplace");
slidesnd = event_instance("event:/sfx/player/slide");
grimacesnd = event_instance("event:/sfx/player/grimace");
tornadosnd = event_instance("event:/sfx/player/tornado");
wallslidesnd = event_instance("event:/sfx/player/wallslide");
hoverstartsnd = event_instance("event:/sfx/player/hoverstart");
longjumpsnd = event_instance("event:/sfx/player/longjump");
ropegrabsnd = event_instance("event:/sfx/player/ropegrab");
slopfootstepsnd = event_instance("event:/sfx/player/slopfootstep");
grassfootstepsnd = event_instance("event:/sfx/player/grassfootstep");
woodfootstepsnd = event_instance("event:/sfx/player/woodfootstep");
genericfootstep = event_instance("event:/sfx/player/genericfootstep");
metalfootstepsnd = event_instance("event:/sfx/player/metalfootstep");
voicerandom = event_instance("event:/sfx/player/voice/random");
voicehurt = event_instance("event:/sfx/player/voice/hurt");
levelintropopoutsnd = event_instance("event:/sfx/player/levelintropopout");
deadblowsnd = event_instance("event:/sfx/player/deadblow");
deadpopsnd = event_instance("event:/sfx/player/deadpop");
deadblinksnd = event_instance("event:/sfx/player/deadblink");
deaddisintergratesnd = event_instance("event:/sfx/player/disintergrate");
standingsurface = standingsurface.grass;

function jump()
{
    state = (state == states.sprint || state == states.standstillrun || state == states.sprintjump) ? states.sprintjump : states.jump;
    vsp = -12;
    
    if (jumpnum == 2 && move == 0)
        jumpnum = 0;
    
    switch (jumpnum++)
    {
        case 0:
            if (state == states.sprintjump)
            {
                if (movespeed <= 11)
                {
                    sprite_index = spr_player_mach2jump;
                }
                else
                {
                    sprite_index = spr_player_mach2fastjumpstart;
                    vsp = -13;
                }
            }
            else
            {
                sprite_index = spr_player_jump;
            }
            
            break;
        
        case 1:
            sprite_index = spr_player_secondjump;
            vsp = -14;
            break;
        
        case 2:
            sprite_index = spr_player_cartwheel;
            scr_fmod_soundeffect(cartwheelsnd, x, y);
            jumpnum = 0;
            vsp = -15;
            break;
    }
    
    canchangedir = 1;
    jumpstop = 0;
    image_speed = 0.35;
    image_index = 0;
    onslipperyplat = false;
    lastslipperyplat = false;
    scr_fmod_soundeffect(jumpsnd, x, y);
    scr_createparticle(true, x, y, z + 4, spr_jumpcloud, image_xscale, 1, 0, 0.35, 0, 0, platspeedH, platspeedV);
}

function punch()
{
    hit_horizontal = -1;
    hit_vertical = -1;
    state = states.punch;
    image_index = 0;
    
    if (move != 0)
        image_xscale = move;
    
    if (!input_check("up"))
    {
        if (movespeed < 4)
            movespeed = 4;
        
        if (grounded)
        {
            if (lastpunch == 0)
                sprite_index = spr_player_punch1;
            else if (lastpunch == 1)
                sprite_index = spr_player_punch2;
            else if (lastpunch == 2)
                sprite_index = spr_player_punch3;
        }
        else
        {
            sprite_index = spr_player_airpunch;
        }
    }
    else
    {
        movespeed = abs(movespeed);
        
        if (grounded)
            sprite_index = spr_player_uppunch;
        else
            sprite_index = spr_player_upairpunch;
    }
    
    nextpunch = 20;
    scr_fmod_soundeffect(punchsnd, x, y);
}

function attack()
{
    if (attackbuffer > 0)
    {
        attackbuffer = 0;
        
        if ((state == states.sprint || state == states.downslide) && grounded && vsp >= 0)
        {
            if (cartwheelcooldown <= 0)
            {
                cartwheelcooldown = 5;
                
                if (move != 0)
                    image_xscale = move;
                
                image_index = 0;
                sprite_index = spr_player_tornado;
                scr_fmod_soundeffect(tornadosnd, x, y);
                
                if (state == states.downslide)
                    movespeed = 16;
                else
                    movespeed = 14;
                
                state = states.cartwheel;
                longjumptimer = 30;
                
                if (grounded)
                    scr_createparticle(true, x, y, z + 4, spr_jumpdust, image_xscale);
            }
        }
        else
        {
            punch();
        }
    }
}

function groundpoundstart()
{
    state = states.groundpound;
    sprite_index = spr_player_groundpoundstart;
    image_index = 0;
    vsp = -5;
    scr_fmod_soundeffect(groundpoundstartsnd, x, y);
    scr_fmod_soundeffect(groundpoundsnd, x, y);
}

function downslide()
{
    if (slidebuffer > 0 && vsp >= 0)
    {
        slidebuffer = 0;
        slidetime = 18;
        
        if (move != 0)
            image_xscale = move;
        
        if (state == states.punch)
            event_stop(punchsnd, 1);
        
        if (state == states.cartwheel)
            event_stop(cartwheelsnd, 1);
        
        state = states.downslide;
        scr_createparticle(true, x, y, z + 4, spr_jumpdust, image_xscale);
        
        if (grounded)
        {
            sprite_index = spr_player_downslide;
            scr_fmod_soundeffect(slidesnd, x, y);
        }
        else
        {
            sprite_index = spr_player_downslidedive;
            vsp = 10;
        }
        
        image_index = 0;
        holdingdown = true;
        
        if (movespeed < 14)
            movespeed = 14;
    }
}

function slide()
{
    if (slidebuffer > 0 && vsp >= 0 && grounded)
    {
        slidebuffer = 0;
        slidetime = 18;
        
        if (move != 0)
            image_xscale = move;
        
        if (state == states.punch)
            event_stop(punchsnd, 1);
        
        if (state == states.cartwheel)
            event_stop(cartwheelsnd, 1);
        
        state = states.downslide;
        scr_createparticle(true, x, y, z + 4, spr_jumpdust, image_xscale);
        sprite_index = spr_player_downslide;
        scr_fmod_soundeffect(slidesnd, x, y);
        image_index = 0;
        holdingdown = true;
        
        if (movespeed < 14)
            movespeed = 14;
    }
}

function dive()
{
    if (slidebuffer > 0 && vsp >= 0)
    {
        slidebuffer = 0;
        slidetime = 18;
        
        if (move != 0)
            image_xscale = move;
        
        if (state == states.punch)
            event_stop(punchsnd, 1);
        
        if (state == states.cartwheel)
            event_stop(cartwheelsnd, 1);
        
        state = states.downslide;
        scr_createparticle(true, x, y, z + 4, spr_jumpdust, image_xscale);
        sprite_index = spr_player_downslidedive;
        vsp = 10;
        image_index = 0;
        holdingdown = true;
        
        if (movespeed < 14)
            movespeed = 14;
    }
}

function wallslide(arg0)
{
    if ((sign(arg0) == sign(image_xscale) || (sign(arg0) == move && !canchangedir)) && !scr_solid(x + arg0, y, obj_nostickwall) && !scr_solid(x, y + 1, [obj_slope, obj_slopePlatform]) && ((move == image_xscale && state != states.sprint) || state == states.sprint || (state == states.jump && !canchangedir)) && !grounded && dontcling == 0)
    {
        image_xscale = sign(arg0);
        state = states.wallslide;
        wallslidecanceltimer = 10;
        
        if (vsp > 0)
        {
            vsp = 0;
            sprite_index = spr_player_wallslidedown;
        }
        else
        {
            vsp = -abs(movespeed);
            sprite_index = spr_player_wallslideup;
        }
        
        movespeed = 0;
        hsp = 0;
    }
}

function hover()
{
    if (state == states.falllocked)
        exit;
    
    if (!grounded && vsp >= 0 && jumpbuffer > 0 && jumpbuffer <= 6 && !hovering && hovertime < hovermaxtime)
    {
        if (hovertime > 0)
        {
            trace("hover penalty");
            hovertime = min(hovertime + 10, hovermaxtime);
        }
        
        if (hovertime >= hovermaxtime)
            exit;
        
        attackbuffer = 0;
        jumpbuffer = 0;
        momentum = 0;
        
        if (!canchangedir)
        {
            movespeed *= move;
            
            if (movespeed < 0)
                movespeed = 0;
            
            hsp = 0;
            canchangedir = true;
        }
        
        if (state != states.jump)
            state = states.jump;
        
        if (vsp > 0)
        {
            if (!hovered)
            {
                hovered = 1;
                vsp = -8;
            }
            else
            {
                vsp = vsp / 2;
            }
        }
        
        hovering = 1;
        scr_fmod_soundeffect(hoverstartsnd, x, y);
        image_index = 0;
        sprite_index = spr_player_hoverstart;
    }
}

function dashcloudparticle()
{
    if (particlecooldown1 > 0)
        particlecooldown1--;
    
    if (particlecooldown1 == 0)
    {
        particlecooldown1 = 15;
        scr_createparticle(true, x, y, z + 4, spr_slidecloud, image_xscale);
    }
}

function dashcloud2particle()
{
    if (particlecooldown2 > 0)
        particlecooldown2--;
    
    if (particlecooldown2 == 0)
    {
        particlecooldown2 = 15;
        scr_createparticle(true, x, y, z + 4, spr_dashcloud, image_xscale, undefined, undefined, 0.35);
    }
}

function dashcloudfastparticle()
{
    if (particlecooldown3 > 0)
        particlecooldown3--;
    
    if (particlecooldown3 == 0)
    {
        particlecooldown3 = 10;
        scr_createparticle(true, x, y, z + 4, spr_dashcloudfast, image_xscale, undefined, undefined, 0.5);
    }
}

function tornadodashcloud2particle()
{
    if (particlecooldown4 > 0)
        particlecooldown4--;
    
    if (particlecooldown4 == 0)
    {
        particlecooldown4 = 4;
        scr_createparticle(true, x, y, z + 4, spr_dashcloud, image_xscale, undefined, undefined, 0.35);
    }
}

function particlewithcooldown(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = 1, arg7 = 1, arg8 = 0, arg9 = 0.35, arg10 = 0, arg11 = 0, arg12 = 0, arg13 = 0, arg14 = 0)
{
    if (particlecooldown6 > 0)
        particlecooldown6--;
    
    if (particlecooldown6 == 0)
    {
        particlecooldown6 = arg0;
        scr_createparticle(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }
}
