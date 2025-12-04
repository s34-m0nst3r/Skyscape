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

// Countdown
life--;
if (life <= 0) {
    instance_destroy();
}


//Destroy seed if it's hspd is too low
if (hsp < 0.1 && hsp > -0.1 && vsp < 0.1 && vsp > -0.1)
	instance_destroy(self);

//MAKE DRY FARMLAND WET
var gx = floor(x / 8);
var gy = floor((y + 3) / 8);
if (global.world[# gx, gy] == 76) // DRY FARMLAND
{
	global.world[# gx, gy] = 77; // WET FARMLAND
	
	var growthBlock = {
		xp: gx,
		yp: gy
	};
	array_push(global.growthBlocks,growthBlock);	
	
	//UPDATE CHUNK
	var cx = floor(gx / global.chunk_size);
	var cy = floor(gy / global.chunk_size);
	scr_update_chunk(cx, cy); // update the affected chunk surface
				
	//Check if nearby chunks should be updated
	scr_update_border_chunks(gx,gy);
}

