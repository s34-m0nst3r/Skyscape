function scr_harvest_crop(harvest){
	var harvestArray = harvest();
	
	var mx = mouse_x div 8;
	var my = mouse_y div 8;
	
	//Harvest crops
	for (var i = 0; i < array_length(harvestArray); i++)
	{
		// Spawn item drop
		var dropCount = harvestArray[i][1];
		for (var j = 0; j < dropCount; j++)
		{
			var drop_item_id = harvestArray[i][0];
			if (drop_item_id != -1) {
				var inst = instance_create_depth(mx*8+random_range(-4,4), my*8+random_range(-4,4), -5, obj_item_entity);
				inst.item_id = drop_item_id;
			}
		}	
	}
	
	var gx = mx;
	var gy = my;
	var ysize = 1;
	//Remove the crop & update
	if (global.world[# mx, my] == 13)
	{
		gx = global.blockPointers[# mx, my].xcord;
		gy = global.blockPointers[# mx, my].ycord;
		ysize = global.blocks[global.world[# gx,gy]].ysize;
	}
	else if (global.blocks[global.world[# mx,my]].type == "big block")
	{
		ysize = global.blocks[global.world[# mx,my]].ysize;
	}
	
	var crops = [global.blocks[global.world[# gx, gy]].base_crop];
	
	//REMOVE AIR
	for (var i = 0; i < ysize; i++)
	{
		global.world[# gx, gy+i] = 0;
	}
	
	
	//FIND NEARBY CROPS & ADD THEM TO ARRAY
	//(For now just check the crops around it and replant)
	for (var ix = -8; ix <= 8; ix++)
	{
		for (var iy = -8; iy <= 8; iy++)
		{
			if (variable_instance_exists(global.blocks[global.world[# gx+ix,gy+iy]],"base_crop"))
				array_push(crops,global.blocks[global.world[# gx+ix,gy+iy]].base_crop);
		}
	}
	
	//Place new crop (random crop array
	var newCrop = crops[irandom_range(0,array_length(crops)-1)];
	//Get ground cords
	var groundY = gy+ysize;
	
	var valid = true;
	if (global.blocks[newCrop].type == "big block")
	{
		for (var i = 0; i < global.blocks[newCrop].ysize; i++)
		{
			if (global.world[# gx, groundY-i-1] != 0)
				valid = false;
		}
		//CHECK IF WE CAN PLACE BIG BLOCK
		if (valid)
		{
			//Set reserved blocks
			for (var j = 0; j < global.blocks[newCrop].ysize; j++)
			{
				global.world[# gx, groundY-j-1] = 13; //Set to reserved block
				global.blockPointers[# gx, groundY-j-1] = {xcord: gx, ycord: groundY-global.blocks[newCrop].ysize}; //Set pointer
			}
			//Change top reserved block to crop
			global.world[# gx, groundY -global.blocks[newCrop].ysize] = newCrop;
			scr_block_place_check(newCrop,gx,groundY -global.blocks[newCrop].ysize-1);
			//UPDATE CHUNK
			var cx = floor(gx / global.chunk_size);
			var cy = floor((groundY-global.blocks[newCrop].ysize) / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
			//Check if nearby chunks should be updated
			scr_update_border_chunks(gx,groundY-global.blocks[newCrop].ysize);

			//Check bottom right blocks border chunks
			scr_update_border_chunks(gx,groundY+global.blocks[newCrop].ysize);
				
			//Check block
			scr_block_place_check(newCrop,gx,groundY-global.blocks[newCrop].ysize);
				
		}
	}
	else
	{
		//Set the seed  (not big block)
		global.world[# gx, groundY-1] = newCrop;
		scr_block_place_check(newCrop,gx,groundY-1);
			
		//UPDATE CHUNK
		var cx = floor(gx / global.chunk_size);
		var cy = floor(groundY-1 / global.chunk_size);
		scr_update_chunk(cx, cy); // update the affected chunk surface
		//Check if nearby chunks should be updated
		scr_update_border_chunks(gx,groundY-1);
	}
	
	
	
	/*
	//UPDATE CHUNK
	var cx = floor(gx / global.chunk_size);
	var cy = floor((gy) / global.chunk_size);
	scr_update_chunk(cx, cy); // update the affected chunk surface
	//Check if nearby chunks should be updated
	scr_update_border_chunks(gx,gy);

	//Check bottom right blocks border chunks
	scr_update_border_chunks(gx,gy+ysize);
	*/
				
	//Check block

}