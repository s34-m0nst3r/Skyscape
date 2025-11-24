function scr_automatic_open(facing,moving_up){
	var mx = (x + 11)/8;
	var my = (y)/8;
	//MOVING RIGHT
	if (facing == 1) 
	{
		//OPENING
		if (global.blockPointers[# mx, my].xcord != -1 && variable_instance_exists(global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]], "automatic_open"))
		{
			var block = global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]]

			if (block.hoverParam = "closed")
			{
				//Open block
				if (variable_instance_exists(block, "hoverScriptCoords") && variable_instance_exists(block, "hoverParam"))
				{
					block.hoverScript(mx,my,block.hoverParam);
				}
				else if (variable_instance_exists(block, "hoverParam"))
					block.hoverScript(block.hoverParam);
				else
					block.hoverScript();
			}
		}
		mx = (x - 24)/8;
		my = (y)/8;
		//CLOSING
		if (global.blockPointers[# mx, my].xcord != -1 && variable_instance_exists(global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]], "automatic_open"))
		{
			var block = global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]]

			if (block.hoverParam = "open")
			{
				//Open block
				if (variable_instance_exists(block, "hoverScriptCoords") && variable_instance_exists(block, "hoverParam"))
				{
					block.hoverScript(mx,my,block.hoverParam);
				}
				else if (variable_instance_exists(block, "hoverParam"))
					block.hoverScript(block.hoverParam);
				else
					block.hoverScript();
			}
		}


	}
	var mx = (x - 10)/8;
	var my = (y)/8;
	//MOVING LEFT
	if (facing == 0) 
	{
		//OPENING
		if (global.blockPointers[# mx, my].xcord != -1 && variable_instance_exists(global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]], "automatic_open"))
		{
			var block = global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]]

			if (block.hoverParam = "closed")
			{
				//Open block
				if (variable_instance_exists(block, "hoverScriptCoords") && variable_instance_exists(block, "hoverParam"))
				{
					block.hoverScript(mx,my,block.hoverParam);
				}
				else if (variable_instance_exists(block, "hoverParam"))
					block.hoverScript(block.hoverParam);
				else
					block.hoverScript();
			}
		}
		mx = (x + 24)/8;
		my = (y)/8;
		//CLOSING
		if (global.blockPointers[# mx, my].xcord != -1 && variable_instance_exists(global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]], "automatic_open"))
		{
			var block = global.blocks[global.world[# global.blockPointers[# mx, my].xcord, global.blockPointers[# mx, my].ycord]]

			if (block.hoverParam = "open")
			{
				//Open block
				if (variable_instance_exists(block, "hoverScriptCoords") && variable_instance_exists(block, "hoverParam"))
				{
					block.hoverScript(mx,my,block.hoverParam);
				}
				else if (variable_instance_exists(block, "hoverParam"))
					block.hoverScript(block.hoverParam);
				else
					block.hoverScript();
			}
		}


	}
	

	



	

	
	
}