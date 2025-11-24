// Apply gravity
vsp += grav;
if (hsp > 0)
	hsp -=0.005;
	
if (hsp < 0)
	hsp +=0.005;

if (is_solid_at(x, y + vsp,true)) {
    vsp = 0;
} else {
    y += vsp;
}

// Horizontal collision (if you want them to slide)
if (is_solid_at(x + hsp, y,true)) {
   hsp = 0;
}
else
{
	x += hsp;
}
//Stuck inside block
if (is_solid_at(x, y,true)) {
    hsp = irandom_range(-1, 1);   // random horizontal push
    vsp = -irandom_range(1, 2);  // small upward push
    impulse_time = 7;            // optional: temporarily ignore gravity
}

// Spin
image_angle += spin_speed;

// Countdown
life--;
if (life <= 0) {
	scr_bomb_explosion(x, y,blockid,secondblockid);
    instance_destroy();
}
