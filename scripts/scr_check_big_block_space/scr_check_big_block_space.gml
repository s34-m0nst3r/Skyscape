function scr_check_big_block_space(){
	var mx = argument0;
	var my = argument1;
	var block_id = argument2;
	
	
	for (var i = 0; i <= global.blocks[block_id].xsize-1; i++)
	{
		for (var j = 0; j <= global.blocks[block_id].ysize-1; j++)
		{
			if (global.world[# mx + i, my + j] != 0)
			{
				return false;	
			}
		}
	}
	
	
	return true;

}