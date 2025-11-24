if (!landed)
{
	y+=1;
	x+=image_angle/40;
}

if (is_solid_at(x, y + 2,true) && !alive) {
    landed = true;
	alive = true;
	image_index=1;
	alarm[0]=15;
	image_angle=0;
} 

