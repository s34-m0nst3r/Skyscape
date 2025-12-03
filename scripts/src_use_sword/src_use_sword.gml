function src_use_sword(mx,my,selected_item,swingingTool,block_in_reach){
	if (!swingingTool) {
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		swing.swing_speed = 0.05;
		swing.start_angle = 90;
		swing.end_angle = - 90;
		swing.scaleSize = 1.5;
		swing.radius = 18;
		obj_player.swingingTool = true;
	}
	
	if (global.world[# mx, my] != 0 && block_in_reach
		&& (global.blocks[global.world[# mx,my]].type == "plant")) {
		var block_id = global.world[# mx, my];
		var block = global.blocks[block_id];
				
		// Increase damage
		var fraction = global.block_damage[# mx, my] / global.blocks[global.world[# mx, my]].durability;
		var startframe = -1;
		if (fraction > 0.25 && fraction <= 0.5) startframe = 0;
		else if (fraction > 0.5 && fraction <= 0.75) startframe = 1;
		else if (fraction > 0.75) startframe = 2;
			
		global.block_damage[# mx, my] += 1;
		//ADD BLOCK TO REGENLIST (if not in list
		for (var j = 0; j < array_length(global.regenBlocks)+1; j++)
		{
			if (j == array_length(global.regenBlocks))
			{
					var regenBlock = {
					xp: mx,
					yp: my
				};
				array_push(global.regenBlocks,regenBlock);
			}
			if (global.regenBlocks[j].xp == mx && global.regenBlocks[j].yp == my)
			{
				break;	
			}
		}

			
		fraction = global.block_damage[# mx, my] / global.blocks[global.world[# mx, my]].durability;
		var frame = -1;
		if (fraction > 0.25 && fraction <= 0.5) frame = 0;
		else if (fraction > 0.5 && fraction <= 0.75) frame = 1;
		else if (fraction > 0.75) frame = 2;
			
		if (startframe != frame)
		{
			//UPDATE CHUNKS
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
		}

		// Break block if fully damaged
		if (global.block_damage[# mx, my] >= block.durability 
			&& (global.world[# mx, my-1] == 0 || (global.blocks[global.world[# mx, my-1]].floating))) {
		           
			scr_block_break_check(global.world[# mx, my],mx,my);

			global.world[# mx,my] = 0;
				
			// Spawn item drop
			var drop_item_id = block.item_id;
			if (drop_item_id != -1) {
			    var inst = instance_create_depth(mx*8, my*8, -5, obj_item_entity);
			    inst.item_id = drop_item_id;
			}
				
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
			

		}
		
	}
}