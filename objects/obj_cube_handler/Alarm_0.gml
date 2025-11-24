alarm[0]=random_range(350,900);

//Reset random cube blocks

var cx = global.cube_center_x;
var cy = global.cube_center_y;

for (var i = 0; i <= 5; i++)
{
	cx = global.cube_center_x;
	cy = global.cube_center_y;

	cx+=irandom_range(-1,1);
	cy+=irandom_range(-1,1);

	if (global.block_damage[# cx, cy] == 0)
		global.world[# cx, cy] = scr_get_cube_level_blocks(global.cube_level);
}


//UPDATE CHUNKS
var cx2 = floor(cx / global.chunk_size);
var cy2 = floor(cy / global.chunk_size);
scr_update_chunk(cx2, cy2); // update the affected chunk surface
			