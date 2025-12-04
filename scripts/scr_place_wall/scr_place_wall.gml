function scr_place_wall(mx,my,selected_item,swingingTool){
	// place a block if space is empty (and if floating check is valid)
	if (global.walls[# mx, my] == 0) && (global.blocks[global.items[selected_item.item].block_id].floating  || global.walls[# mx, my+1] != 0) {
	    global.walls[# mx, my] = global.items[selected_item.item].block_id; //The global.blocks blckid
				
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
			other.swingingTool = true;
		}
	}
}