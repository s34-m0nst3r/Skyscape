function src_block_updates() {
	
	blockUpdateRate=8;
	
	//UPDATE BLOCKS THAT NEED REGEN
	for (var i = 0; i < array_length(global.regenBlocks);i++)
	{
		var xx = global.regenBlocks[i].xp;
		var yy = global.regenBlocks[i].yp;
		var wall = false;
		if (variable_instance_exists(global.regenBlocks[i],"wall"))
			wall = true;
		
		if (global.block_damage[# xx, yy] > 0) {
			
			if (!wall)
				var fraction = global.block_damage[# xx, yy] / global.blocks[global.world[# xx, yy]].durability;
			else
				fraction = global.block_damage[# xx, yy] / global.blocks[global.walls[# xx, yy]].durability;
			
			var startframe = -1;
			if (fraction > 0.25 && fraction <= 0.5) startframe = 0;
			else if (fraction > 0.5 && fraction <= 0.75) startframe = 1;
			else if (fraction > 0.75) startframe = 2;
			
		    global.block_damage[# xx, yy] = max(0, global.block_damage[# xx, yy] - 0.1); 
			
			if (!wall)
				var fraction = global.block_damage[# xx, yy] / global.blocks[global.world[# xx, yy]].durability;
			else
				fraction = global.block_damage[# xx, yy] / global.blocks[global.walls[# xx, yy]].durability;
				
			var frame = -1;
			if (fraction > 0.25 && fraction <= 0.5) frame = 0;
			else if (fraction > 0.5 && fraction <= 0.75) frame = 1;
			else if (fraction > 0.75) frame = 2;
			
			if (startframe != frame)
			{
				//UPDATE CHUNKS
				var cx = floor(xx / global.chunk_size);
				var cy = floor(yy / global.chunk_size);
				scr_update_chunk(cx, cy); // update the affected chunk surface
			}


		}
		else
		{
			//REMOVE FROM REGEN LIST	
			array_delete(global.regenBlocks,i,1);
			i--;
		}
	}
	
	//UPDATE BLOCKS THAT NEED GROWTH
	for (var i = 0; i < array_length(global.growthBlocks);i++)
	{
		var xx = global.growthBlocks[i].xp;
		var yy = global.growthBlocks[i].yp;
		
		 if (global.blocks[global.world[# xx, yy]].name == "mistral acorn") {		
                // Countdown
                if (global.block_timers[# xx, yy] <= 0) {
                    global.block_timers[# xx, yy] = irandom_range(1000/blockUpdateRate, 8000/blockUpdateRate); // 
                } 
				else {

                    global.block_timers[# xx, yy]--;
					
					if (global.block_timers[# xx, yy] == 0)
					{
						i = scr_grow_mistral_tree(xx, yy,i);
					}
                }
         }
		if (string_pos("dirt grass ", global.blocks[global.world[# xx, yy]].name) > 0) {		
            // Countdown
            if (global.block_timers[# xx, yy] <= 0) {
                global.block_timers[# xx, yy] = irandom_range(100/blockUpdateRate, 1000/blockUpdateRate); // 
            } 
			else {

                global.block_timers[# xx, yy]--;
					
				if (global.block_timers[# xx, yy] == 0)
				{
					for (var  j = -1; j <= 1; j++)
					{
						for (var k = -1; k <= 1; k++)
						{
							if (global.world[# xx+j, yy+k] == 1 || string_pos("dirt grass ", global.blocks[global.world[# xx+j, yy+k]].name) > 0)
							{
								scr_grass_grow_onto_block(xx+j,yy+k);	
							}
						}
					}
					array_delete(global.growthBlocks,i,1);
					i--;
				}
            }
        }

	}
	
	scr_remove_growth_duplicates();
	
	

}

function scr_remove_growth_duplicates() {
    var unique = [];
    
    for (var i = 0; i < array_length(global.growthBlocks); i++) {
        var entry = global.growthBlocks[i];
        var duplicate = false;

        // Check for existing entry with same xp and yp
        for (var j = 0; j < array_length(unique); j++) {
            if (unique[j].xp == entry.xp && unique[j].yp == entry.yp) {
                duplicate = true;
                break;
            }
        }

        if (!duplicate) {
            array_push(unique, entry);
        }
    }

    // Replace global array with filtered one
    global.growthBlocks = unique;
}