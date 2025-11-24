function scr_source_light_total(tile){
	//Sets the first index of a tile on the light grid to hold the 
	//total source light from all it's sources
	var lightTotal = 0;
	var redTotal = 0;
	var greenTotal = 0;
	var blueTotal = 0;
	
	for (var i = 1; i < array_length(tile); i++)
	{
		//Get rgb values as range 0-1
		red = tile[i].r/255*tile[i].l;
		green = tile[i].g/255*tile[i].l;
		blue = tile[i].b/255*tile[i].l;
		
		
		lightTotal+=tile[i].l;
		redTotal+=red;
		greenTotal+=green;
		blueTotal+=blue;
	}
	
	if lightTotal > 1
		lightTotal = 1;
	if redTotal > 1
		redTotal = 1;
	if greenTotal > 1
		greenTotal = 1;
	if blueTotal > 1
		blueTotal = 1;
		
		
	tile[0].l = lightTotal;
	tile[0].r = redTotal;
	tile[0].g = greenTotal;
	tile[0].b = blueTotal;
}	