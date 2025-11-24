function scr_update_border_chunks(mx, my){
	
	//Starting chunk
	var cx = floor(mx / global.chunk_size);
	var cy = floor(my / global.chunk_size);
	var xDistance = 0;
	var yDistance = 0;
	if (global.blocks[global.world[# mx, my]].type = "big block")
	{
		xDistance = global.blocks[global.world[# mx, my]].xsize-1;
		yDistance = global.blocks[global.world[# mx, my]].xsize-1;
	}
	
	//show_message(string(mx % global.chunk_size));
	//LEFT BORDER
	if (mx % global.chunk_size <= 0+xDistance)
	{
		//show_message("LEFT BORDER");
		scr_update_chunk(cx-1,cy);
	}
		
	//RIGHT BORDER
	if (mx % global.chunk_size >= 31-xDistance)
	{
		//show_message("RIGHT BORDER");
		scr_update_chunk(cx+1,cy);
	}
		
	//TOP BORDER
	if (my % global.chunk_size <= 0+yDistance)
		scr_update_chunk(cx,cy-1);
		
	//BOTTOM BORDER
	if (my % global.chunk_size >= 31-yDistance)
		scr_update_chunk(cx,cy+1);
		
		
	


}