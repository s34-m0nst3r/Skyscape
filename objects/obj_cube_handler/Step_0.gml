var cx = global.cube_center_x;
var cy = global.cube_center_y;

// Loop over the cube core (3x3 area)
for (var xx = -1; xx <= 1; xx++) {
    for (var yy = -1; yy <= 1; yy++) {
        var gx = cx + xx;
        var gy = cy + yy;
		//BLOCK BROKEN
        if (global.world[# gx, gy] == 0) { 
            //REPLACE AIR WITH DIRT
            global.world[# gx, gy] = scr_get_cube_level_blocks(global.cube_level); 
			
			//UPDATE CHUNKS
			var cx2 = floor(gx / global.chunk_size);
			var cy2 = floor(gy / global.chunk_size);
			scr_update_chunk(cx2, cy2); // update the affected chunk surface
			
			if (scr_is_cube_core(gx, gy) || scr_is_cube_border(gx, gy)) {
			    global.cube_blocks_mined += 1;
				if (global.biome == "Mistral Fields")
				{
					//Random MISTRAL loot
	                var loot = scr_get_mistral_level_loot(global.mistral_level);
	                if (loot != -1) {
	                    var inst = instance_create_depth(gx*8, gy*8, -5, obj_item_entity);
	                    inst.item_id = loot.item;
						if (variable_instance_exists(loot,"blueprint"))
							inst.blueprint = loot.blueprint;
	                    inst.count = 1;
	                }
					
					global.mistral_blocks_mined += 1;
				}
				
				//Random LEVEL loot
                var loot = scr_get_cube_loot(global.cube_level);
                if (loot != -1) {
                    var inst = instance_create_depth(gx*8, gy*8, -5, obj_item_entity);
                    inst.item_id = loot.item;
					if (variable_instance_exists(loot,"blueprint"))
							inst.blueprint = loot.blueprint;
                    inst.count = 1;
                }

			}

        }
    }
}

//Check for Level Up
if (global.cube_blocks_mined >= global.cube_next_level) {
					
	//Create UI popup
	if (global.levelReader >= 1)
	{
		var popup = instance_create_depth(0, 0, -50, obj_pop_up);
		popup.msg = "CUBE Level Up!";
		popup.sprite = spr_cube_level_up;
		popup.gradientColor = c_yellow
	}

					
	global.cube_level += 1;
	global.cube_blocks_mined = 0;
	global.cube_next_level = ceil(global.cube_next_level * 2.5); 
	// exponential growth

	// --- Drop reward ---
	var drop_item_id;
	switch (global.cube_level) {
		case 1: drop_item_id = 2; break; //Level Reader level 1
		case 2: drop_item_id = 5; break; //Mistral Axe level 2
		case 3: drop_item_id = 3; break; //Biome Reader level 3
		default: drop_item_id = 0; break; 
	}

	var inst = instance_create_depth(gx*8, gy*8-20, -5, obj_item_entity);
	inst.item_id = drop_item_id;
	inst.count = 1;

}

//Check for MISTRAL Level Up
if (global.mistral_blocks_mined >= global.mistral_next_level) {
						
	if (global.biomeReader >= 1)
	{
		var popup = instance_create_depth(0, 0, -50, obj_pop_up);
		popup.msg = "Mistral Fields Level Up!";
		popup.sprite = spr_mistral_level_up;
		popup.gradientColor = c_green
	}
						
	global.mistral_level += 1;
	global.mistral_blocks_mined = 0;
	global.mistral_next_level = ceil(global.mistral_next_level * 1.8); 

}