// Apply gravity
vsp += grav;
if (hsp > 0)
	hsp -=0.05;
	
if (hsp < 0)
	hsp +=0.05;


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
	if (item_id == 4)
		scr_bomb_explosion(x, y);
    instance_destroy();
}


//Destroy seed if it's hspd is too low
if (hsp < 0.1 && hsp > -0.1 && vsp < 0.1 && vsp > -0.1)
	instance_destroy(self);

//SEED IDs
if (seedtype == 0) //Grass
{

	var gx = floor(x / 8);
	var gy = floor((y + 3) / 8);
	if (global.world[# gx, gy] == 1) //Dirt block
	{
		scr_grass_grow_onto_block(gx,gy);	
	}

}