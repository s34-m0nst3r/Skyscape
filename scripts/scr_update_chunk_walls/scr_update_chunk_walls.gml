function scr_update_chunk_walls() {
	cx = argument0;
	cy = argument1;
    var chunk_w = min(global.chunk_size, global.world_width - cx*global.chunk_size);
    var chunk_h = min(global.chunk_size, global.world_height - cy*global.chunk_size);
	
	

    // Create new surface
	var surfPadding = 16;
	var paddingOffset = 8;

    //Reuse old surface (previously freed them)
    if (!surface_exists(global.chunk_wall_surfaces[cx][cy])) {
		global.chunk_wall_surfaces[cx][cy] = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
		var surf = global.chunk_wall_surfaces[cx][cy];
	}
	else
	{
	    var surf = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
	    global.chunk_wall_surfaces[cx][cy] = surf;
	}

	surface_set_target(surf);
	//draw_clear_alpha(c_black, 0);
	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	
	for (var xx = 0; xx < chunk_w; xx++) {
        for (var yy = 0; yy < chunk_h; yy++) {
            var wx = cx*global.chunk_size + xx;
            var wy = cy*global.chunk_size + yy;
			
			if (global.walls[# wx, wy] != 0)
			{
				draw_sprite(global.blocks[global.walls[# wx, wy]].sprite, 0, xx*8+paddingOffset, yy*8+paddingOffset);

			}
		}
	}

    surface_reset_target();

}
