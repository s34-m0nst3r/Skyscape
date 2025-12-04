// Apply gravity
vsp += grav;
if (hsp > 0-0.065)
	hsp -=0.0045;
else if (hsp < 0+0.65)
	hsp +=0.0045;
else
	hsp = 0;

// Countdown
life--;
if (life <= 0) {
    instance_destroy();
}

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
