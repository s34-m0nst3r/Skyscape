function scr_update_chunk_liquids() {
	cx = argument0;
	cy = argument1;
    var chunk_w = min(global.chunk_size, global.world_width - cx*global.chunk_size);
    var chunk_h = min(global.chunk_size, global.world_height - cy*global.chunk_size);
	
	

    // Create new surface
	var surfPadding = 16;
	var paddingOffset = 8;

    //Reuse old surface (previously freed them)
    if (!surface_exists(global.chunk_liquid_surfaces[cx][cy])) {
		global.chunk_liquid_surfaces[cx][cy] = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
		var surf = global.chunk_liquid_surfaces[cx][cy];
	}
	else
	{
	    var surf = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
	    global.chunk_liquid_surfaces[cx][cy] = surf;
	}

	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	
	for (var xx = 0; xx < chunk_w; xx++) {
        for (var yy = 0; yy < chunk_h; yy++) {
            var wx = cx*global.chunk_size + xx;
            var wy = cy*global.chunk_size + yy;
			
			var liquid = global.liquids[# wx, wy]
			
			if (liquid != 0 && !variable_instance_exists(global.blocks[liquid],"animated"))
			{
				draw_sprite(global.blocks[global.liquids[# wx, wy]].sprite, 0, xx*8+paddingOffset, yy*8+paddingOffset);

			}
		}
	}

    surface_reset_target();

}
