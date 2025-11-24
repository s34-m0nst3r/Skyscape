// Physics
hsp = 0;
vsp = 0;
grav = 0.04;

// Lifetime
life = room_speed* 1; 

depth = -30;

image_index = irandom_range(0,2);

var scale = random_range(1,4);
image_xscale=scale;
image_yscale=scale;
vsp = random_range(-0.5,-2);
hsp = random_range(-1,1);
val = 0;

draw_color = c_white;

var valPercent = (val/obj_stat_manager.maxHp)*100
if (valPercent > 30)
{
	draw_color = c_maroon;
}
else if (valPercent > 20)
{
	draw_color = c_red;
}
else if (valPercent > 10)
{
	draw_color = c_orange
}
else if (valPercent > 2)
{
	draw_color = c_yellow;
}
