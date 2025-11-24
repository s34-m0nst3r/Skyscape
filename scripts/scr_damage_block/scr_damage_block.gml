function scr_damage_block(){
	var mx = argument0;
	var my = argument1;
	var mining_power = argument2;
	var durability = argument3;
	var fraction = global.block_damage[# mx, my] / durability;
	var startframe = -1;
	if (fraction > 0.25 && fraction <= 0.5) startframe = 0;
	else if (fraction > 0.5 && fraction <= 0.75) startframe = 1;
	else if (fraction > 0.75) startframe = 2;
				
				
			
	global.block_damage[# mx, my] += mining_power;
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
			
	fraction = global.block_damage[# mx, my] / durability;
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
}