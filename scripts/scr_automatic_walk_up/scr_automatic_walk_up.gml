function scr_automatic_walk_up(facing, moving_up){
	 //FACING: 0 == left, 1 == right
	
	if (facing == 1 && is_solid_at(x + 10, y + 11, moving_up) && !is_solid_at(x + 10, y, moving_up)
			&& !is_solid_at(x, y - 11, moving_up) && !is_solid_at(x + 10, y - 11, moving_up)
		)
	{
		y-=8;
		x+=1;
	}
	
	if (facing == 0 && is_solid_at(x - 9, y + 11, moving_up) && !is_solid_at(x - 9, y, moving_up)
			&& !is_solid_at(x, y - 11, moving_up) && !is_solid_at(x - 9, y - 11, moving_up)
		)
	{
		y-=8;
		x-=1;
	}



}