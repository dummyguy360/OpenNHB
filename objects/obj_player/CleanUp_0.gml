ds_map_destroy(currcheckpoint.respawnroom);
currcheckpoint.respawnroom = -1;

if (currcheckpoint.saveroom != -4)
{
    ds_map_destroy(currcheckpoint.saveroom);
    currcheckpoint.saveroom = -4;
}
