function src_place_big_block(mx,my,selected_item,swingingTool){
	// place a block if space is empty (and if floating check is valid)
	// NOTE: Since this is a big block, we must check the xsize and ysize locations for placement
	if (global.world[# mx, my] == 0) 
	&& (global.blocks[global.items[selected_item.item].block_id].floating  || global.world[# mx, my+global.blocks[global.items[selected_item.item].block_id].ysize] != 0)
	&& scr_check_big_block_space(mx,my,global.items[selected_item.item].block_id)
	{
		//Set the source block
	    global.world[# mx, my] = global.items[selected_item.item].block_id; 
				
		//Set the reserved blocks
		for (var i = 0; i <= global.blocks[global.items[selected_item.item].block_id].xsize-1; i++)
		{
			for (var j = 0; j <= global.blocks[global.items[selected_item.item].block_id].ysize-1; j++)
			{
				if (global.world[# mx+i, my+j] == 0)
				{
					global.world[# mx+i, my+j] = 13; //Set to reserved block
					global.blockPointers[# mx+i, my+j] = {xcord: mx, ycord: my}; //Set pointer
				}
			}
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
		//Check bottom right blocks border chunks
		scr_update_border_chunks(mx+global.blocks[global.items[selected_item.item].block_id].xsize,my+global.blocks[global.items[selected_item.item].block_id].ysize);
				
		if (!swingingTool) {
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			other.swingingTool = true;
		}
			
	}
}