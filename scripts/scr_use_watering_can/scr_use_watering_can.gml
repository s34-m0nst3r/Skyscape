function scr_use_watering_can(mx,my,selected_item,swingingTool){

	
	//ADD WATER TO WATERING CAN
	if ((global.blocks[global.liquids[# mx, my]].type == "water") && selected_item.water_level != global.items[selected_item.item].max_water && !swingingTool)
	{				
		selected_item.water_level=global.items[selected_item.item].max_water;

		//SWINGING TOOL
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		other.swingingTool = true;

		
		for (var i = 0; i < irandom_range(5,9); i++)
			instance_create_depth((mx*8)+4,(my*8)+6,-100,obj_water_particle);
					
	}
	//POUR WATER FROM WATERING CAN
	else if (!swingingTool)
	{
		
		if (selected_item.water_level != 0)
		{
			//SWINGING TOOL
			var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
			swing.owner = id;
			swing.item_id = selected_item.item;
			swing.facing = facing; // 0 left, 1 right
			swing.returnUp = true;
			other.swingingTool = true;
			swing.start_angle = 35;
			swing.end_angle = - 70;
			
			selected_item.water_level-=1;
			for (var i = 0; i < irandom_range(2,5); i++)
			{
				var seed = instance_create_depth(swing.x,swing.y-5,-1,obj_watering_can_particle);

				if (obj_player.facing == 0)
					seed.hsp = -0.5 - random_range(0.3,1.5);
				if (obj_player.facing == 1)
					seed.hsp = 0.5 + random_range(0.3,1.5);
					
				seed.vsp= -2 + random_range(0.3,1.5);
				
			}
		}
		else if (selected_item.water_level != global.items[selected_item.item].max_water)
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
			else if (selected_item.water_level == 0 && !swingingTool)
			{
				//SWINGING TOOL
				var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
				swing.owner = id;
				swing.item_id = selected_item.item;
				swing.facing = facing; // 0 left, 1 right
				swing.returnUp = true;
				other.swingingTool = true;
				swing.start_angle = 35;
				swing.end_angle = - 70;
			}
		}
	}
}