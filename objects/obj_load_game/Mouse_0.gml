var save_file = "save1.json";

if (file_exists(save_file)) {
    var json_text = "";
    var file = file_text_open_read(save_file);
    while (!file_text_eof(file)) {
        json_text += file_text_read_string(file);
    }
    file_text_close(file);
	
	instance_create_depth(0,0, -1,obj_liquid_spread_handler);
	instance_create_depth(0,0, -1,obj_world);
	
	
	instance_create_depth(0,0, -1,obj_cube_handler);

	instance_create_depth(64,64, -1,obj_player);

	instance_create_depth(0,0,-1,obj_camera);
	
	instance_create_depth(0,0,-1,obj_stat_manager);
    
    // Parse JSON
    var data = json_parse(json_text);
    
    // Load world
    global.world_width = data.world_width;
	global.world_height = data.world_height;
	
	global.time_of_day = data.time_of_day;
	
	//Stats
	obj_stat_manager.hp = data.hp;
	obj_stat_manager.maxHp = data.maxHp;
	obj_stat_manager.hunger = data.hunger;
	obj_stat_manager.maxHunger = data.maxHunger;
	obj_stat_manager.mana = data.mana;
	obj_stat_manager.maxMana = data.maxMana;
	obj_stat_manager.air = data.air;
	obj_stat_manager.maxAir = data.maxAir;
	
	obj_stat_manager.regenRate = data.regenRate;
	obj_stat_manager.hungerRate = data.hungerRate;
	obj_stat_manager.airLossRate = data.airLossRate;
	
	//Set up recipes
	scr_recipe_defintions();
	for (var i = 0; i < array_length(data.recipes); i++)
	{
		global.recipes[i].unlocked = data.recipes[i];
	}
    
    //Recreate blocks grid
    global.world = ds_grid_create(global.world_width, global.world_height);
    for (var xx = 0; xx < global.world_width; xx++) {
        for (var yy = 0; yy < global.world_height; yy++) {
            global.world[# xx, yy] = data.blocks[xx][yy];
        }
    }
	
	//Recreate pointers grid
    global.blockPointers = ds_grid_create(global.world_width, global.world_height);
    for (var xx = 0; xx < global.world_width; xx++) {
        for (var yy = 0; yy < global.world_height; yy++) {
            global.blockPointers[# xx, yy] = data.blockPointers[xx][yy];
        }
    }
	
	//Recreate walls grid
    global.walls = ds_grid_create(global.world_width, global.world_height);
    for (var xx = 0; xx < global.world_width; xx++) {
        for (var yy = 0; yy < global.world_height; yy++) {
            global.walls[# xx, yy] = data.walls[xx][yy];
        }
    }
	
	//Recreate liquids grid
    global.liquids = ds_grid_create(global.world_width, global.world_height);
    for (var xx = 0; xx < global.world_width; xx++) {
        for (var yy = 0; yy < global.world_height; yy++) {
            global.liquids[# xx, yy] = data.liquids[xx][yy];
        }
    }
    
    
    // Load player position
	obj_player.x = data.player_x;
	obj_player.y = data.player_y;
	
	// Load inventory
	for (var i = 0; i < array_length(data.inventory); i++) {
	    var slot = data.inventory[i];
	    if (slot != -1) {
			if (variable_instance_exists(data.inventory[i],"blueprint"))
			{
		        obj_player.inventory[i] = {
		            item: slot.item,
		            count: slot.count,
					blueprint: slot.blueprint,
		        };
			}
			else if (variable_instance_exists(data.inventory[i],"water_level"))
			{
		        obj_player.inventory[i] = {
		            item: slot.item,
		            count: slot.count,
					water_level: slot.water_level,
		        };
			}
			else
			{
				obj_player.inventory[i] = {
		            item: slot.item,
		            count: slot.count
		        };
			}
	    } else {
	        obj_player.inventory[i] = noone;
	    }
	}

    
    room_goto(rm_world);
	global.levelReader = 0;
	global.biomeReader = 0;
	
	//BLOCK UPDATE STUFF
	global.block_timers = data.blockTimers;
	global.growthBlocks = data.growthBlocks;
	
	//Update all chunks
	for (var cx = 0; cx < global.chunks_w; cx++) {
	    for (var cy = 0; cy < global.chunks_h; cy++) {
	        scr_update_chunk(cx, cy);
	    }
	}

	//Check the placed stats for each block
	for (var xx = 0; xx < global.world_width; xx++) {
	    for (var yy = 0; yy < global.world_height; yy++) {
	        scr_block_place_check_world_start(global.world[# xx, yy],xx,yy);
		}
	}
	
	// Load cube progress
	if (variable_struct_exists(data, "cube_level")) {
	    global.cube_level         = data.cube_level;
	    global.cube_blocks_mined  = data.cube_blocks_mined;
	    global.cube_next_level = data.cube_next_level;
   
	} else {
	    //Default
	    global.cube_level = 0;
	    global.cube_blocks_mined = 0;
	    global.cube_next_level = 10; //BASE VALUE
	}
	if (variable_struct_exists(data, "mistral_level")) {
	    global.mistral_level         = data.mistral_level;
	    global.mistral_blocks_mined  = data.mistral_blocks_mined;
	    global.mistral_next_level = data.mistral_next_level;
   
	} else {
	    //Default
	    global.mistral_level = 0;
	    global.mistral_blocks_mined = 0;
	    global.mistral_next_level = 25; //BASE VALUE
	}
	


} else {
    show_message("No save file found!");
}
