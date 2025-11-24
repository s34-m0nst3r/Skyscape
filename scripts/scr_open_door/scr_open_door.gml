function scr_open_door(mx,my, state){

	//Grab the source block 
	var block = global.world[# mx, my];
	if (block == 13)
	{
		px = global.blockPointers[# mx, my].xcord;
		py = global.blockPointers[# mx, my].ycord
		block = global.world[# px, py];
		mx = px;
		my = py;
	}
	
	
	//Check state
	if (state == "closed")
	{
		//Check which way the player is trying to open the door
		if (obj_player.x > mx*8) //Open from the right
		{
			//Check if there is space
			var space = true;
			for (var i = 0; i < 3; i++)
			{
				if (global.world[# mx-1, my+i] != 0 || global.blocks[global.world[# mx-1, my+i]].type != "plant")
				{
					space = false;	
				}
				
			}
			//There is space so set the appropriate blocks
			if (space)
			{
				for (var i = 0; i < 2; i++)
				{
					for (var j = 0; j < 3; j++)
					{
						if (j == 0 && i == 0)
						{
							global.world[# mx-1, my] = global.blocks[block].open_id;	
							global.blockPointers[# mx-1, my] = {xcord: mx, ycord: my, pos: "left"};
						}
						else
						{
							global.world[# mx+i-1, my+j] = 13; //Set to reserved block
							global.blockPointers[# mx+i-1, my+j] = {xcord: mx-1, ycord: my}; //Set pointer
						}
					}
				}
			}
			//UPDATE CHUNK
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); 
			scr_update_border_chunks(mx,my);

		}
		else  //Open from the left
		{
			//Check if there is space
			var space = true;
			for (var i = 0; i < 3; i++)
			{
				if (global.world[# mx+1, my+i] != 0  || global.blocks[global.world[# mx+1, my+i]].type != "plant")
				{
					space = false;	
				}
				
			}
			if (space)
			{
				for (var i = 0; i < 2; i++)
				{
					for (var j = 0; j < 3; j++)
					{
						if (j == 0 && i == 0)
						{
							global.world[# mx, my] = global.blocks[block].open_id;	
							global.blockPointers[# mx, my] = {xcord: mx, ycord: my, pos: "right"};
						}
						else
						{
							global.world[# mx+i, my+j] = 13; //Set to reserved block
							global.blockPointers[# mx+i, my+j] = {xcord: mx, ycord: my}; //Set pointer
						}
					}
				}
			}
			//UPDATE CHUNK
			var cx = floor(mx / global.chunk_size);
			var cy = floor(my / global.chunk_size);
			scr_update_chunk(cx, cy); 
			scr_update_border_chunks(mx,my);
		}
		
	}
	
	else if (state == "open")
	{
		var posDoor = global.blockPointers[# mx, my].pos;
		var closeDoor = global.blocks[global.world[# mx, my]].closed_id;
		//Reset every block the door had
		for (var i = 0; i < 2; i++)
		{
			for (var j = 0; j < 3; j++)
			{

				global.world[# mx+i, my+j] = 0; //Set to air
				global.blockPointers[# mx+i, my+j] = {xcord: mx, ycord: my}; //Reset pointer

			}
		}
		
		//If pos is left, move back one block
		if (posDoor == "left")
			mx++;
		
		//Set the source block
		global.world[# mx, my] = closeDoor;
		
		for (var i = 1; i < 3; i++)
		{
			global.world[# mx, my+i] = 13; //Set to reserved block
			global.blockPointers[# mx, my+i] = {xcord: mx, ycord: my}; //Set pointer
		}
		
		//UPDATE CHUNK
		var cx = floor(mx / global.chunk_size);
		var cy = floor(my / global.chunk_size);
		scr_update_chunk(cx, cy); 
		scr_update_border_chunks(mx,my);
		
		
	}
	
}