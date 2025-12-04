function scr_use_bucket(mx,my,selected_item,swingingTool,facing){
	//DRAIN BASIN
	if ((global.world[# mx, my] == 60 || (global.world[# mx, my] == 13 && global.world[# global.blockPointers[# mx,my].xcord, global.blockPointers[# mx, my].ycord] == 60)) && selected_item.water_level != 0)
	{
		selected_item.water_level-=1;
		if (!swingingTool) {
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			swingingTool = true;
		}
		
		if (global.world[# mx, my] == 60)
		{
			for (var i = 0; i < irandom_range(5,9); i++)
				instance_create_depth((mx*8)+8,(my*8)+3,-100,obj_water_particle);
		}
		else
		{
			var xx = global.blockPointers[# mx, my].xcord;
			var yy = global.blockPointers[# mx, my].ycord;
			for (var i = 0; i < irandom_range(5,9); i++)
				instance_create_depth((xx*8)+8,(yy*8)+3,-100,obj_water_particle);
		}
	}
	//Pick up water
	else if (global.blocks[global.liquids[# mx, my]].type == "water" && selected_item.water_level != global.items[selected_item.item].max_water)
	{
		selected_item.water_level+=1;
		global.liquids[# mx, my] = 0;
		global.liquids[# mx+1, my] = 0;
		global.liquids[# mx-1, my] = 0;
					
		//UPDATE CHUNK
		var cx = floor(mx / global.chunk_size);
		var cy = floor(my / global.chunk_size);
		scr_update_chunk(cx, cy); // update the affected chunk surface
				
		//Check if nearby chunks should be updated
		scr_update_border_chunks(mx,my);
		scr_block_break_check(selected_item.item,mx,my);
		scr_block_break_check(global.liquids[# mx+1, my],mx+1,my);
		scr_block_break_check(global.liquids[# mx-1, my],mx-1,my);
					
		if (!swingingTool) {
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			swingingTool = true;
		}
		
		for (var i = 0; i < irandom_range(5,9); i++)
			instance_create_depth((mx*8)+4,(my*8)+6,-100,obj_water_particle);
					
	}
	//Place water
	else if (global.liquids[# mx, my] == 0 && selected_item.water_level != 0)
	{
		selected_item.water_level-=1;
		global.liquids[# mx, my] = 47; //47 == WATER SOURCE BLOCK
					
		//UPDATE CHUNK
		var cx = floor(mx / global.chunk_size);
		var cy = floor(my / global.chunk_size);
		scr_update_chunk(cx, cy); // update the affected chunk surface
				
		//Check if nearby chunks should be updated
		scr_update_border_chunks(mx,my);
		scr_block_place_check(selected_item.item,mx,my);
					
		if (!swingingTool) {
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			swingingTool = true;
		}
		
		for (var i = 0; i < irandom_range(5,9); i++)
			instance_create_depth((mx*8)+4,(my*8)+6,-100,obj_water_particle);
					
	}
	else
	{
		var block = -1;
		if variable_instance_exists(global.blocks[global.world[# mx,my]],"water_source")
		{
			block =	global.blocks[global.world[# mx,my]];
		}
		else if  (variable_instance_exists(global.blocks[global.world[# mx,my]],"water_source") || (global.blockPointers[# mx,my].xcord != -1 && variable_instance_exists(global.blocks[global.world[# global.blockPointers[# mx,my].xcord,global.blockPointers[# mx,my].ycord]],"water_source")))
		{
			block = global.blocks[global.world[# global.blockPointers[# mx,my].xcord,global.blockPointers[# mx,my].ycord]];	
		}
		if (block != -1)
		{
		
			selected_item.water_level=global.items[selected_item.item].max_water;

			//SWINGING TOOL
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			other.swingingTool = true;
		
			for (var i = 0; i < irandom_range(5,9); i++)
				instance_create_depth((mx*8)+(8*block.xsize)/2,(my*8)+(8*block.ysize)/2,-100,obj_water_particle);
		}
		
	}
}