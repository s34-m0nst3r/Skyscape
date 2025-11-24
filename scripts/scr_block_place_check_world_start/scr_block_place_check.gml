function scr_block_place_check(_id, mx,my){

	//Check if level reader broken
	if _id == 2
		global.levelReader++;
	if _id == 3
		global.biomeReader++;
		
	//ADD GROWTH LIST
	if global.blocks[_id].type == "acorn"
	{
		var growthBlock = {
			xp: mx,
			yp: my
		};
		array_push(global.growthBlocks,growthBlock);	
	}
	
	if (string_pos("dirt grass ", global.blocks[_id].name) > 0) {	
		var growthBlock = {
			xp: mx,
			yp: my
		};
		array_push(global.growthBlocks,growthBlock);	
	}
	if (variable_instance_exists(global.blocks[_id],"particle"))
	{
		var particleBlock = {
			xp: mx,
			yp: my,
			particle_rate: global.blocks[_id].particle_rate
		}
		array_push(global.particleBlocks,particleBlock);
	}
	if (variable_instance_exists(global.blocks[_id],"animated"))
	{
		var animatedBlock = {
			xp: mx,
			yp: my	
		}
		array_push(global.animatedBlocks,animatedBlock);
	}
	if (variable_instance_exists(global.blocks[_id],"light_power"))
	{
		var lightSource = {
			xp: mx,
			yp: my,
			pow: global.blocks[global.world[# mx, my]].light_power,
			r: global.blocks[global.world[# mx, my]].red,
			g: global.blocks[global.world[# mx, my]].green,
			b: global.blocks[global.world[# mx, my]].blue,
			tiles: []
		}
		array_push(global.light_sources,lightSource);
		scr_update_lighting_start(lightSource,array_length(global.light_sources)-1);
		scr_redraw_lighting();

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
	}
	if (variable_instance_exists(global.blocks[_id],"rotable") && obj_player.facing == 0)
	{
		global.blockPointers[# mx, my].rotable = true;
	}
	
	
	//Check liquid
	
	if (global.blocks[_id].type == "water" && _id != 55)
	{
		array_push(obj_liquid_spread_handler.liquidBlocks,{xx: mx, yy: my, liquid: "water"});
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

	
	
}