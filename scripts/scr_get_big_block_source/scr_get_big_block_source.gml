function scr_get_big_block_source(mx,my){
	//Given a coordinate determines whether a big block
	//or a reserved block is present and returns the coordinates
	//of where the big block source block is located.	
	
	if (global.world[# mx,my] == 13)
	{
		return {xcord: global.blockPointers[# mx,my].xcord,	ycord: global.blockPointers[# mx,my].ycord};
	}
	else if (global.blocks[global.world[# mx,my]].type == "big block")
	{
		return {xcord: mx, ycord: my};	
	}


	return { xcord: -1, ycord: -1};
	
	// USAGE EXAMPLE

	//var mx = mouse_x div 8;
	//var my = mouse_y div 8;
	//var source = scr_get_big_block_source(mx,my);
	//var gx = source.xcord;
	//var gy = source.ycord;
	
	//NOTE: UPDATE ALL FUNCTIONS TO LOOK THIS GOOD
}