// Apply gravity
if (abs(vsp) < 0.2)
	vsp += random_range(grav/3,grav/2);

if (moveLeft && (vsp > 0.05 || vsp < -0.05) && hsp < 0.3)
	hsp += random_range(0.001,0.03);
else if (vsp > 0.05 || vsp < -0.05) && (hsp > -0.3)
	hsp -= random_range(0.001,0.03);


if (is_solid_at(x, y + vsp,true)) {
    vsp = 0;
} else {
    y += vsp;
}

// Horizontal collision (if you want them to slide)
if (is_solid_at(x + hsp,y,true)) {
   hsp = 0;
}
else
{
	x += hsp;
}


// Countdown
life--;
if (life <= 0) {
    image_alpha -=0.01;
}


//Destroy leaf if it's hspd is too low
if (vsp < 0.01 && vsp > -0.01)
{
	image_speed = 0;
	image_alpha -=0.01;
}
else if (image_speed == 0)
{
	image_speed=random_range(0.1,0.2);
}


if (image_alpha <= 0)
	instance_destroy(self);