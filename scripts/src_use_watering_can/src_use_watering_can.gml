function src_use_watering_can(mx,my,selected_item,swingingTool){

	
	//ADD WATER TO WATERING CAN
	if (global.blocks[global.liquids[# mx, my]].type == "water" && selected_item.water_level != global.items[selected_item.item].max_water && !swingingTool)
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
	else if (selected_item.water_level != 0 && !swingingTool)
	{
		selected_item.water_level-=1;

		//SWINGING TOOL
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		swing.returnUp = true;
		other.swingingTool = true;
		swing.start_angle = 35;
		swing.end_angle = - 70;
		
		for (var i = 0; i < irandom_range(2,5); i++)
		{
			var seed = instance_create_depth(obj_player.x,obj_player.y-5,-1,obj_watering_can_particle);

			if (obj_player.facing == 0)
				seed.hsp = -0.5 - random_range(0.3,1.5);
			if (obj_player.facing == 1)
				seed.hsp = 0.5 + random_range(0.3,1.5);
					
			seed.vsp= -2 + random_range(0.3,1.5);
				
		}
		
	}
}