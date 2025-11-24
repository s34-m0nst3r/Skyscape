function scr_get_source(tile,sx,sy){
	//Given coordinates for a light source return the array from light_grid
	for (var i = 1; i < array_length(tile); i++)
		if (tile[i].sx == sx && tile[i].sy == sy)
			return i;
	return -1;
}