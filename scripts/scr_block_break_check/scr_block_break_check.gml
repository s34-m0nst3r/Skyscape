function scr_block_break_check(_id, mx, my){

	//Check if level reader broken
	if _id == 2
		global.levelReader--;
	if _id == 3
		global.biomeReader--;
	
		
	if (variable_instance_exists(global.blocks[_id],"light_power"))
	{
		for (var i = 0; i < array_length(global.light_sources); i++) {
		    var light = global.light_sources[i];
		    if (light.xp == mx && light.yp == my) {
		        array_delete(global.light_sources, i, 1);
			
				//Find all light tiles within a radius that have this block as a source block
				var xmin = light.xp-20;
				var xmax = light.xp+20;
				var ymin = light.yp-20;
				var ymax = light.yp+20;
				
				if (xmin < 0) xmin = 0;
				if (xmax > global.world_width) xmax = global.world_width;
				if (ymin < 0) ymin = 0;
				if (ymax > global.world_height) ymax = global.world_height;
				
				for (var xx = xmin; xx <= xmax; xx++) 
				{ 
					for (var yy = ymin; yy <= ymax; yy++) 
					{ 
						var index = scr_get_source(global.light_grid[xx][yy],light.xp,light.yp);
						if (index != -1)
						{
							array_delete(global.light_grid[xx][yy],index,1);
							scr_source_light_total(global.light_grid[xx][yy]);
						}
					} 
				}
				
				// Determine visible chunks with padding		
				var cx = floor(mx / global.chunk_size);
				var cy = floor(my / global.chunk_size);
		
				var start_cx = cx-2;
				var start_cy = cy-2;
				var end_cx   = cx+2;
				var end_cy   = cy+2;

				// Store in queue
				for (var cx = start_cx; cx < end_cx; cx++) {
				    for (var cy = start_cy; cy < end_cy; cy++) {
						if (cx = start_cx && cy = start_cy) continue;
						if (cx = end_cx && cy = start_cy) continue;
						if (cx = start_cx && cy = end_cy) continue;
						if (cx = end_cx && cy = end_cy) continue;
						scr_update_chunk_light(cx,cy);
				    }
				}
		   
				
		        break;
		    }
		}
	}
	
	//Check for water above, below, left and right
	if (my != 0)
	{
		var above = global.blocks[global.liquids[# mx, my-1]];
		if (above.type == "water" && above != 55)
			array_push(obj_liquid_spread_handler.liquidBlocks,{xx: mx, yy: my-1, liquid: "water"});
	}
		
	if (my != global.world_height-1)
	{
		var below = global.blocks[global.liquids[# mx, my+1]];
		if (below.type == "water" && below != 55)
			array_push(obj_liquid_spread_handler.liquidBlocks,{xx: mx, yy: my+1, liquid: "water"});
	}
		
	if (mx != global.world_width-1)
	{
		var right = global.blocks[global.liquids[# mx+1, my]];
		if (right.type == "water" && right != 55)
				array_push(obj_liquid_spread_handler.liquidBlocks,{xx: mx+1, yy: my, liquid: "water"});
	}
		
	if (mx != 0)
	{
		var left = global.blocks[global.liquids[# mx-1, my]];
		if (left.type == "water" && left != 55)
				array_push(obj_liquid_spread_handler.liquidBlocks,{xx: mx-1, yy: my, liquid: "water"});
	}

	global.blockPointers[# mx, my] = {xcord: -1, ycord: -1};
		
	
}