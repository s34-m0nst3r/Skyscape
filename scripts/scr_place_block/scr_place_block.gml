function scr_place_block(mx, my, selected_item){
	 // place a block if space is empty (and if floating check is valid)
	var valid = false;
	var attach = 1
    if (global.world[# mx, my] == 0) 
	{
		if (global.blocks[global.items[selected_item.item].block_id].floating  || (global.blocks[global.world[# mx, my+1]].floatingPlace))
		{
			valid = true;
			attach = 1;
		}
		
		else if (variable_instance_exists(global.blocks[global.items[selected_item.item].block_id],"wall_attach") && global.walls[# mx,my] != 0)
		{
			valid = true;
			attach = 1;
		}
		
		else if (variable_instance_exists(global.blocks[global.items[selected_item.item].block_id],"wall_attach") 
			&& variable_instance_exists(global.items[selected_item.item],"right_block") && global.blocks[global.world[# mx+1,my]].solid)
		{
			valid = true;
			attach = 2;
		}
		else if (variable_instance_exists(global.blocks[global.items[selected_item.item].block_id],"wall_attach") 
			&& variable_instance_exists(global.items[selected_item.item],"left_block") && global.blocks[global.world[# mx-1,my]].solid)
		{
			valid = true;
			attach = 3;
		}
		
		if (valid)
		{
			if (attach == 1)
				global.world[# mx, my] = global.items[selected_item.item].block_id; //The global.blocks blckid
			else if (attach == 2)
			{
				global.world[# mx, my] = global.items[selected_item.item].left_block;
			}
			else if (attach == 3)
			{
				global.world[# mx, my] = global.items[selected_item.item].right_block;
			}
			scr_block_place_check(global.world[# mx, my],mx,my);
				
			// REDO LIGHTING
			if (global.blocks[global.world[# mx, my]].solid)
			{
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

				
			//UPDATE CHUNK
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
			scr_reduce_count(selected_item);
				
			//Check if nearby chunks should be updated
			scr_update_border_chunks(mx,my);
				
			if (!swingingTool) {
				var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
				swing.owner = id;
				swing.item_id = selected_item.item;
				swing.facing = facing; // 0 left, 1 right
				swingingTool = true;
			}
		}
    }
}