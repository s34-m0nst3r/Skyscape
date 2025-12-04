function scr_use_pickaxe(mx,my,selected_item,swingingTool,block_in_reach){
	if (!swingingTool) {
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		other.swingingTool = true;
	}
	if (global.world[# mx, my] != 0  && block_in_reach
		&& global.blocks[global.world[# mx,my]].type != "tree"
		&& global.blocks[global.world[# mx,my]].type != "wall"
		&& global.blocks[global.world[# mx,my]].type != "water"){
		//Check if we have a reserved block, if so use source block instead
		if (global.world[# mx, my] == 13) //RESERVERED
		{
			var mx2 = mx;
			var my2= my;
			mx = global.blockPointers[# mx2, my2].xcord;
			my = global.blockPointers[# mx2, my2].ycord;
			global.blocks[13].durability = global.blocks[global.world[# mx, my]].durability;
		}
					
		var block_id = global.world[# mx, my];
		var block = global.blocks[block_id];
		var mining_power = global.items[selected_item.item].mining_power;
		var durability = global.blocks[global.world[# mx, my]].durability;

		//INCREASE DAMAGE
		//Check if big block
		if (global.blocks[global.world[# mx, my]].type == "big block") //BIG BLOCK
		{				
			//DAMAGE THE BLOCKS IN adjacent regions
			for (var k = 0; k <= global.blocks[global.world[# mx, my]].xsize-1; k++)
			{
				for (var h = 0; h <= global.blocks[global.world[# mx, my]].ysize-1; h++)
				{
					//SET ALL RESERVED BLOCKS TO USE THIS DURABILITY
					if (global.world[# mx+k, my+h] == 13)
						scr_damage_block(mx+k,my+h,mining_power,durability);	
				} 
			}
		}
		//DAMAGE BLOCK ITSELF
		scr_damage_block(mx,my,mining_power,durability);	
		
				

		// Break block if fully damaged
		if (global.block_damage[# mx, my] >= block.durability && (global.world[# mx, my-1] == 0 || (global.blocks[global.world[# mx, my-1]].floating))) {
			//IF BIG BLOCK DESTROY RESERVED SPACE
			if (global.blocks[global.world[# mx, my]].type == "big block")
			{
				for (var k = 0; k <= global.blocks[global.world[# mx, my]].xsize-1; k++)
				{
					for (var h = 0; h <= global.blocks[global.world[# mx, my]].ysize-1; h++)
					{
						//CHECK RESERVED
						if (global.world[# mx+k, my+h] == 13)
						{
							scr_block_break_check(global.world[# mx+k, my+h],mx+k,my+h);
							//REDO LIGHTING
							if (global.blocks[global.world[# mx+k, my+h]].solid)
							{
								global.world[# mx+k, my+h] = 0;

								// Push every source block to be updated
								var grid = global.light_grid[mx+k][my+h];
								var grid_len = array_length(grid);

								for (var p = 1; p < grid_len;k++) {
									var sx = grid[p].sx;
									var sy = grid[p].sy;

									// Use coordinate string as unique key
									var key = string(sx) + "," + string(sy);

									// Only enqueue if not already in queue
									if (!ds_map_exists(global.light_update_lookup, key)) {
										var update = { sx: sx, sy: sy };
										ds_queue_enqueue(global.light_update_queue, update);
										ds_map_add(global.light_update_lookup, key, true);
									}
								}
							}
				
							global.world[# mx+k, my+h] = 0;
							global.block_damage[# mx+k, my+h] = 0;
									
						}
					}
				}	
			}
					
			scr_block_break_check(global.world[# mx, my],mx,my);
					
			if (block.type == "big block")
				scr_update_border_chunks(mx,my);
					
			// REDO LIGHTING
			if (global.blocks[global.world[# mx, my]].solid)
			{
				global.world[# mx, my] = 0;

				// Push every source block to be updated
				var grid = global.light_grid[mx][my];
				var grid_len = array_length(grid);

				for (var k = 1; k < grid_len; k++) {
					var sx = grid[k].sx;
					var sy = grid[k].sy;

					// Use coordinate string as unique key
					var key = string(sx) + "," + string(sy);

					// Only enqueue if not already in queue
					if (!ds_map_exists(global.light_update_lookup, key)) {
						var update = { sx: sx, sy: sy };
						ds_queue_enqueue(global.light_update_queue, update);
						ds_map_add(global.light_update_lookup, key, true);
					}
				}
			}

				
			global.world[# mx, my] = 0;
			global.block_damage[# mx, my] = 0;
					
			//UPDATE CHUNKS
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface

			// Spawn item drop
			var dropCount = is_method(block.dropCount) ? block.dropCount() : block.dropCount;
			for (var i = 0; i < dropCount; i++)
			{
				var drop_item_id = is_method(block.item_id) ? block.item_id() : block.item_id;
				if (drop_item_id != -1) {
				    var inst = instance_create_depth(mx*8+random_range(-1,1), my*8+random_range(-1,1), -5, obj_item_entity);
				    inst.item_id = drop_item_id;
				}
			}
					
					

		}
	}
}