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
//CROPS
else
{
	var gx = floor(x / 8);
	var gy = floor((y + 3) / 8);
	if ((global.world[# gx, gy] == 76 || global.world[# gx, gy] == 77) && global.world[# gx,gy-1] == 0) //Dry farmland
	{
		var valid = true;
		if (global.blocks[seedtype].type == "big block")
		{
			for (var i = 0; i < global.blocks[seedtype].ysize; i++)
			{
				if (global.world[# gx, gy-i-1] != 0)
					valid = false;
			}
			//CHECK IF WE CAN PLACE BIG BLOCK
			if (valid)
			{
				//Set reserved blocks
				for (var j = 0; j < global.blocks[seedtype].ysize; j++)
				{
					global.world[# gx, gy-j-1] = 13; //Set to reserved block
					global.blockPointers[# gx, gy-j-1] = {xcord: gx, ycord: gy-global.blocks[seedtype].ysize}; //Set pointer
				}
				//Change top reserved block to crop
				global.world[# gx, gy -global.blocks[seedtype].ysize] = seedtype;
				//UPDATE CHUNK
				var cx = floor(gx / global.chunk_size);
				var cy = floor((gy-global.blocks[seedtype].ysize) / global.chunk_size);
				scr_update_chunk(cx, cy); // update the affected chunk surface
				//Check if nearby chunks should be updated
				scr_update_border_chunks(gx,gy-global.blocks[seedtype].ysize);

				//Check bottom right blocks border chunks
				scr_update_border_chunks(gx,gy+global.blocks[seedtype].ysize);
				
				//Check block
				scr_block_place_check(seedtype,gx,gy-global.blocks[seedtype].ysize);
				
			}
		}
		else
		{
			//Set the seed  (not big block)
			global.world[# gx, gy -1] = seedtype;
			
			//UPDATE CHUNK
			var cx = floor(gx / global.chunk_size);
			var cy = floor(gy-1 / global.chunk_size);
			scr_update_chunk(cx, cy); // update the affected chunk surface
			//Check if nearby chunks should be updated
			scr_update_border_chunks(gx,gy-1);
		}

	}
	
}
