function scr_grass_grow_onto_block(gx,gy){

	//GX & GY give game space coords for the block to become grass
	
	//Check if tall grass can be added on top
	if (irandom_range(0,100) > 60 && global.world[# gx, gy-1] == 0 
		&& !variable_instance_exists(global.blockPointers[# gx, gy],"nogrow"))
	{
		global.world[# gx, gy-1] = irandom_range(65,71);
		scr_update_chunk_hot_code(gx,gy);
	}
	else
	{
		global.blockPointers[# gx, gy] = {xcord: -1, ycord: -1, nogrow: true}
	}
	
	//Check if we have an all situation
	if (!global.blocks[global.world[# gx, gy-1]].solid
		&& !global.blocks[global.world[# gx-1, gy]].solid
		&& !global.blocks[global.world[# gx+1, gy]].solid)
	{
		if (global.world[# gx, gy] == 29)
			return;
		//Block becomes a double all grass
		global.world[# gx, gy] = 29;
		scr_update_chunk_hot_code(gx,gy);
		return;
		
		
		
	}
	
	//Check if there is a solid block above it 
	if (global.blocks[global.world[# gx, gy-1]].solid)
	{
		//If both blocks left and right are not air then set a nub
		if (global.blocks[global.world[# gx-1, gy]].solid && global.blocks[global.world[# gx+1, gy]].solid)
		{
		
			if (!global.blocks[global.world[# gx-1, gy-1]].solid 
			&& !global.blocks[global.world[# gx+1, gy-1]].solid)
			{
				if (global.world[# gx, gy] == 28)
					return;
				//Block becomes a double nub
				global.world[# gx, gy] = 28;
				scr_update_chunk_hot_code(gx,gy);
				return;
			}
			else if (!global.blocks[global.world[# gx-1, gy-1]].solid)
			{
				if (global.world[# gx, gy] == 24)
					return;
				//Block becomes a left nub
				global.world[# gx, gy] = 24;
				scr_update_chunk_hot_code(gx,gy);
				return;
			}
			else if (!global.blocks[global.world[# gx+1, gy-1]].solid)
			{
				if (global.world[# gx, gy] == 27)
					return;
				//Block becomes a right nub
				global.world[# gx, gy] = 27;
				scr_update_chunk_hot_code(gx,gy);
				return;
			}
		}
		else
		{
			//One of the blocks on the left or right is free, meaning this should become a left or right side
			if (!global.blocks[global.world[# gx-1, gy]].solid)
			{
				if (global.world[# gx, gy] == 22)
					return;
				//Block becomes a left side
				global.world[# gx, gy] = 22;
				scr_update_chunk_hot_code(gx,gy);
				return;
			}
			else if (!global.blocks[global.world[# gx+1, gy]].solid)
			{
				if (global.world[# gx, gy] == 25)
					return;
				//Block becomes a left side
				global.world[# gx, gy] = 25;
				scr_update_chunk_hot_code(gx,gy);
				return;
			}
			
		}
	}
	else
	{
	
		//Check if there are blocks to the left and right
		if (global.blocks[global.world[# gx-1, gy]].solid && global.blocks[global.world[# gx+1, gy]].solid)
		{
			if (global.world[# gx, gy] == 21)
				return;
			//Block becomes a top	
			global.world[# gx, gy] = 21;
			scr_update_chunk_hot_code(gx,gy);
			return;
		}
		else if (!global.blocks[global.world[# gx-1, gy]].solid)
		{
			if (global.world[# gx, gy] == 23)
				return;
			//Block becomes a left corner	
			global.world[# gx, gy] = 23;
			scr_update_chunk_hot_code(gx,gy);
			return;
		}
		else if (!global.blocks[global.world[# gx+1, gy]].solid)
		{
			if (global.world[# gx, gy] == 26)
				return;
			//Block becomes a right corner	
			global.world[# gx, gy] = 26;
			scr_update_chunk_hot_code(gx,gy);
			return;
		}
	}
	
	if (global.blocks[global.world[# gx, gy-1]].solid
		&& global.blocks[global.world[# gx-1, gy]].solid
		&& global.blocks[global.world[# gx+1, gy]].solid
		)
	{
		
		if (global.world[# gx, gy] == 1)
			return;
	
	
		//If the block somehow got to this point, it becomes dirt
		global.world[# gx, gy] = 1;
		//UPDATE CHUNK
		var cx = floor(gx / global.chunk_size);
		var cy = floor(gy / global.chunk_size);
		scr_update_chunk(cx, cy); // update the affected chunk surface
				
		//Check if nearby chunks should be updated
		scr_update_border_chunks(gx,gy);
		return;
		
	}
	
	
	

}

function scr_update_chunk_hot_code(gx, gy)
{
	//UPDATE CHUNK
	var cx = floor(gx / global.chunk_size);
	var cy = floor(gy / global.chunk_size);
	scr_update_chunk(cx, cy); // update the affected chunk surface
				
	//Check if nearby chunks should be updated
	scr_update_border_chunks(gx,gy);

	if (!scr_growth_block_exists(gx,gy))
	{
		var growthBlock = {
				xp: gx,
				yp: gy
			};
		array_push(global.growthBlocks,growthBlock);
	}

}
