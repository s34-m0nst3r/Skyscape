function src_use_blueprint(selected_item,swingingTool){
	if (!swingingTool) {
		var swing = instance_create_layer(x, y, "Instances", obj_tool_swing);
		swing.owner = id;
		swing.item_id = selected_item.item;
		swing.facing = facing; // 0 left, 1 right
		swingingTool = true;
		swing.blueprint = global.items[selected_item.blueprint].sprite;
	}
	//Grab recipe
	for (var i = 0; i < array_length(global.recipes); i++)
	{
		if (global.recipes[i].item_id == selected_item.blueprint)
		{
			//Check if locked or unlocked
			if (global.recipes[i].unlocked)
			{
				//Add cube XP
				global.cube_blocks_mined += 15;
			}
			else
			{
				global.recipes[i].unlocked = true;
				var msg = {
						text  : "Learned " + global.recipes[i].name +" recipe",
						alpha : 1,
						count : 1
					};
				array_push(pickup_messages, msg);
			}
		}
	}
	scr_reduce_count(selected_item);
}