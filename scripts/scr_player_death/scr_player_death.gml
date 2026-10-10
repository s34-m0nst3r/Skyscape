function scr_player_death(){
    with(obj_player)
    {
        alive=false;
        alarm[4]=250;

        for (var i = 0; i < irandom_range(8,12); i++)
        {
            instance_create_depth(x,y,-1,obj_blood);
            var index = irandom_range(0,total_size-1);
            var item = inventory[index]
            if (item != noone)
            {
                var drop_id   = item.item;
                var drop_type = global.items[drop_id];
                var xx = obj_player.x;
                var yy = obj_player.y - 8; // spawn slightly above player
                var inst = instance_create_layer(xx, yy, "Instances", obj_item_entity);

                inst.item_id = drop_id;
                inst.count   = item.count;
                inst.canBePickedUp = false;
                if (variable_instance_exists(item,"blueprint"))
                    inst.blueprint = item.blueprint;
                if (variable_instance_exists(item,"water_level"))
                    inst.water_level = item.water_level;
                inst.alarm[0] = 55;
                var itemhsp = random_range(-1,1);
                var itemvsp = random_range(-0.1,-0.9);
                inst.hsp = itemhsp;
                inst.vsp = itemvsp;
                inst.impulse_time = 25;

                inventory[index] = noone;
            }
        }

        //Convert player x and y to worldspace
        var gx = x div 8;
        var gy = y div 8;

        //Try to place gravestone
        for (var i = 0; i < 8; i++)
        {
            for (var j = 0; j < 8; j++)
            {
                for (var n = 0; n < 2; n++)
                {
                    //On second loop, check the other direction
                    if (n == 1)
                    {
                        i*=-1;
                        j*=-1;
                    }
                    //Check if region is valid
                    var block1 = global.blocks[global.world[# gx+i, gy+j]];
                    var block2 = global.blocks[global.world[# gx+i+1, gy+j]];
                    var block3 = global.blocks[global.world[# gx+i, gy+j+1]];
                    var block4 = global.blocks[global.world[# gx+i+1, gy+j+1]];
                    if (block1.type == "air" || block1.type == "plant") 
                        && (block2.type == "air" || block2.type == "plant") 
                        && (block3.type == "air" || block3.type == "plant") 
                        && (block4.type == "air" || block4.type == "plant") 
                        && global.blocks[global.world[# gx+i, gy+j+2]].solid
                        && global.blocks[global.world[# gx+i+1, gy+j+2]].solid
                    {
                        //Place a gravestone
                        //Set the source block
                        global.world[# gx+i, gy+j] = irandom_range(119,120); 

                        //Game space cords
                        var px = ((gx+i+1)*8)
                        var py = ((gy+j+1)*8)

                        //Create skull particles
                        for (var p = 0; p < irandom_range(4,9); p++)
                        {
                            instance_create_depth(px+random_range(-12,12),py+random_range(-16,4),-1,obj_skull_particle);    
                        }

                        //Set the reserved blocks
                        for (var xx = 0; xx < 2; xx++)
                        {
                            for (var yy = 0; yy < 2; yy++)
                            {
                                if (global.world[# gx+i+xx, gy+j+yy] != 119 && global.world[# gx+i+xx, gy+j+yy] != 120)
                                {
                                    global.world[# gx+i+xx, gy+j+yy] = 13; //Set to reserved block
                                    global.blockPointers[# gx+i+xx, gy+j+yy] = {xcord: gx+i, ycord: gy+j}; //Set pointer
                                }
                            }
                        }

                        scr_block_place_check(global.world[# gx+i, gy+j],gx+i,gy+j);

                        //UPDATE CHUNK
                        var cx = floor((gx+i) / global.chunk_size);
                        var cy = floor((gy+j) / global.chunk_size);
                        scr_update_chunk(cx, cy); // update the affected chunk surface

                        //Check if nearby chunks should be updated
                        scr_update_border_chunks(gx+i,gy+j);
                        //Check bottom right blocks border chunks
                        scr_update_border_chunks(gx+i+2,gy+j+2);

                        return;
                    }
                    if (n == 1)
                    {
                        i*=-1;
                        j*=-1;
                    }

                }

            }
        }

    }
}