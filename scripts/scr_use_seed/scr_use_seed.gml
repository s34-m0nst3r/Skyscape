function scr_use_seed(mx,my,selected_item,swingingTool){
	if (!swingingTool) {
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		other.swingingTool = true;
	}
			
	//Run seed script
	scr_seed_item(selected_item.item,global.items[selected_item.item].seed_id);
			
	//UPDATE CHUNK
	var cx = floor(mx / global.chunk_size);
	var cy = floor(my / global.chunk_size);
	scr_update_chunk(cx, cy); // update the affected chunk surface
			
	scr_reduce_count(selected_item);
				
	//Check if nearby chunks should be updated
	scr_update_border_chunks(mx,my);
}