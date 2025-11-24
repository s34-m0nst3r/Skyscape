for (var i = 0; i <= 5; i++)
{
	if (array_length(liquidBlocks) != 0)
	{
	
		//Process first block
		var liquid = liquidBlocks[0];
		var block = global.liquids[# liquid.xx, liquid.yy];
		var strength = global.blocks[block].strength;
	
		var blockBelow = global.blocks[global.liquids[# liquid.xx, liquid.yy+1]];
		var blockLeft = global.blocks[global.liquids[# liquid.xx-1, liquid.yy]];
		var blockRight = global.blocks[global.liquids[# liquid.xx+1, liquid.yy]];
	
		if !((blockBelow == 47|| blockBelow == 55) && blockLeft.strength <= strength && blockRight.strength <= strength)
		{
			//47 == source water block
			var blockAbove = global.blocks[global.liquids[# liquid.xx, liquid.yy-1]];
			if (block == 47 && (blockAbove.type != "water" || blockAbove == 54 || blockAbove == 53))
			{
				global.liquids[# liquid.xx, liquid.yy] = 56;
				var animatedBlock = {
					xp: liquid.xx,
					yp: liquid.yy	
				}
				array_push(global.animatedBlocks,animatedBlock);

			}


			//Spread water beneath
			if (!global.blocks[global.world[# liquid.xx, liquid.yy+1]].solid) && (global.liquids[# liquid.xx, liquid.yy+1] == 0 || global.blocks[global.liquids[# liquid.xx, liquid.yy+1]].type == "water")
			{
				global.liquids[# liquid.xx, liquid.yy+1] = 47;
				//Check the 8 blocks above it
				var falling = true;
				for (var i = 0; i < 8; i++)
				{
					if (global.blocks[global.liquids[# liquid.xx, liquid.yy-i]].type != "water")
					{
						falling = false;
					}
				}
				if (falling)
				{
					global.liquids[# liquid.xx, liquid.yy+1] = 55;
					var animatedBlock = {
						xp: liquid.xx,
						yp: liquid.yy+1	
					}
					array_push(global.animatedBlocks,animatedBlock)
				}
				else
					array_push(liquidBlocks,{xx: liquid.xx, yy: liquid.yy+1, liquid: "water"});
			}
	
			//Check left
			if (!global.blocks[global.world[# liquid.xx-1, liquid.yy]].solid) && ((global.liquids[# liquid.xx-1, liquid.yy] == 0 || (global.blocks[global.liquids[# liquid.xx-1, liquid.yy]].type == "water") && global.blocks[global.liquids[# liquid.xx-1, liquid.yy]].strength <= global.blocks[global.liquids[# liquid.xx, liquid.yy]].strength-2)    && (global.blocks[global.world[# liquid.xx, liquid.yy+1]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+2]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+3]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+4]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+5]].solid)  )
			{
				if (strength == 8)
					global.liquids[# liquid.xx-1, liquid.yy] = 48;
				else if (strength == 7)
					global.liquids[# liquid.xx-1, liquid.yy] = 49;
				else if (strength == 6)
					global.liquids[# liquid.xx-1, liquid.yy] = 50;
				else if (strength == 5)
					global.liquids[# liquid.xx-1, liquid.yy] = 51;
				else if (strength == 4)
					global.liquids[# liquid.xx-1, liquid.yy] = 52;
				else if (strength == 3)
					global.liquids[# liquid.xx-1, liquid.yy] = 53;
				else if (strength == 2)
					global.liquids[# liquid.xx-1, liquid.yy] = 54;
			
				var animatedBlock = {
					xp: liquid.xx-1,
					yp: liquid.yy	
				}
				array_push(global.animatedBlocks,animatedBlock);
			
				if (strength != 1)
				{
					array_push(liquidBlocks,{xx: liquid.xx-1, yy: liquid.yy, liquid: "water"});
				}
			}
	
			//Check right
			if (!global.blocks[global.world[# liquid.xx+1, liquid.yy]].solid) && ((global.liquids[# liquid.xx+1, liquid.yy] == 0 || (global.blocks[global.liquids[# liquid.xx+1, liquid.yy]].type == "water") && global.blocks[global.liquids[# liquid.xx+1, liquid.yy]].strength <= global.blocks[global.liquids[# liquid.xx, liquid.yy]].strength-2)  && (global.blocks[global.world[# liquid.xx, liquid.yy+1]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+2]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+3]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+4]].solid || global.blocks[global.world[# liquid.xx, liquid.yy+5]].solid)  )
			{
				if (strength == 8)
					global.liquids[# liquid.xx+1, liquid.yy] = 48;
				else if (strength == 7)
					global.liquids[# liquid.xx+1, liquid.yy] = 49;
				else if (strength == 6)
					global.liquids[# liquid.xx+1, liquid.yy] = 50;
				else if (strength == 5)
					global.liquids[# liquid.xx+1, liquid.yy] = 51;
				else if (strength == 4)
					global.liquids[# liquid.xx+1, liquid.yy] = 52;
				else if (strength == 3)
					global.liquids[# liquid.xx+1, liquid.yy] = 53;
				else if (strength == 2)
					global.liquids[# liquid.xx+1, liquid.yy] = 54;
			
				var animatedBlock = {
					xp: liquid.xx+1,
					yp: liquid.yy	
				}
				array_push(global.animatedBlocks,animatedBlock);

			
				if (strength != 1)
				{
					array_push(liquidBlocks,{xx: liquid.xx+1, yy: liquid.yy, liquid: "water"});
				}
			}

	
			var cx = floor(liquid.xx / global.chunk_size);
			var cy = floor(liquid.yy / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
		}
		array_delete(liquidBlocks,0,1);
	


	}
}
alarm[0]=1;
