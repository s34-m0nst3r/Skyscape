function scr_crop_crossbreed_table(crops){

	//RED MUSHROOM STALK + BLUE MUSHROOM STALK = PURPLE MUSHROOM STALK
	if (scr_array_contains(crops,94) && scr_array_contains(crops,98))
	{
		for (var i = 0; i < scr_array_count(crops,98);i++)
			array_push(crops,103);
	}
		
	//CORN + RED/BLUE/PURPLE MUSHROOM STALK = HUITLACOCHE
	if (scr_array_contains(crops,81) && (scr_array_contains(crops,94) || scr_array_contains(crops,98) || scr_array_contains(crops,103)))
	{
		
		for (var i = 0; i < scr_array_count(crops,81);i++)
			array_push(crops,107);
	}	
	
	return crops;
}