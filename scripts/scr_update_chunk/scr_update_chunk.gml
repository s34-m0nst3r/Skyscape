function scr_update_chunk() {
	cx = argument0;
	cy = argument1;
    var chunk_w = min(global.chunk_size, global.world_width - cx*global.chunk_size);
    var chunk_h = min(global.chunk_size, global.world_height - cy*global.chunk_size);
	
	//Update walls
	scr_update_chunk_walls(cx,cy);

    //Create new surface
	var surfPadding = 32;
	var paddingOffset = 8;

    //Reuse old surface (previously freed them)
    if (!surface_exists(global.chunk_surfaces[cx][cy])) {
		global.chunk_surfaces[cx][cy] = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
		var surf = global.chunk_surfaces[cx][cy];
		var surf_water = global.chunk_water_surfaces[cx][cy];
	}
	else
	{
	    var surf = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
		var surf_water = surface_create(chunk_w*8+surfPadding, chunk_h*8+surfPadding);
	    global.chunk_surfaces[cx][cy] = surf;
		global.chunk_water_surfaces[cx][cy] = surf_water;
	}

	surface_set_target(surf);
	var current = surf;
	//draw_clear_alpha(c_black, 0);
	draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	

    for (var xx = 0; xx < chunk_w; xx++) {
        for (var yy = 0; yy < chunk_h; yy++) {
            var wx = cx*global.chunk_size + xx;
            var wy = cy*global.chunk_size + yy;

            var block_id = global.world[# wx, wy];
            var block = global.blocks[block_id];
			

            // Draw block sprite
            if (block.sprite != -1 && !variable_instance_exists(block,"animated")) {
				
				//QUICK FIX IF BLOCK IS GRASS ADD IT TO THE GROWTH LIST
				if (string_pos("dirt grass ", block.name) > 0)
				{
					if (!scr_growth_block_exists(wx,wy))
					{
						var growthBlock = {
								xp: wx,
								yp: wy
							};
						array_push(global.growthBlocks,growthBlock);
					}
				}
				

				
				//DRAW BLOCK SPRITE
				if (variable_instance_exists(block,"rotable") && variable_instance_exists(global.blockPointers[# wx, wy],"rotable"))
				{
					current = switch_target(surf,surf_water,block,current);
					draw_sprite_ext(block.sprite, 0, xx*8+paddingOffset+8, yy*8+paddingOffset,-1,1,0,c_white,1);
				}
				else
				{
					if (block.type != "water")
					{
						current = switch_target(surf,surf_water,block,current);
						draw_sprite(block.sprite, 0, xx*8+paddingOffset, yy*8+paddingOffset);
					}
					else
					{
						current = switch_target(surf,surf_water,block,current);
						draw_sprite(block.sprite, 0, xx*8+paddingOffset, yy*8+paddingOffset);	
					}
				}
				
				//DRAW OUTLINE
				var ox = cx * global.chunk_size + xx;
			    var oy = cy * global.chunk_size + yy;
				var size = 8; // tile size
				var bx = xx * size;
				var by = yy * size;

			    draw_set_color(c_black);
				

			    // Check each neighbor, if air then draw a line on that side
			    // Only draw outline if neighbor is not "block" or "soil"
				if (global.blocks[global.world[# wx, wy]].type == "block" || global.blocks[global.world[# wx, wy]].type == "soil")
				{
					if (wx > 0) {
						var neighbor_id = global.world[# wx-1, wy];
						if (neighbor_id == 0 || !(global.blocks[neighbor_id].type == "block" || global.blocks[neighbor_id].type == "soil")) {
						    draw_line(bx+paddingOffset, by+paddingOffset-1, bx+paddingOffset, by+paddingOffset + size); // left edge
						}
					}

					if (wx < global.world_width-1) {
						var neighbor_id = global.world[# wx+1, wy];
						if (neighbor_id == 0 || !(global.blocks[neighbor_id].type == "block" || global.blocks[neighbor_id].type == "soil")) {
						    draw_line(bx+size+paddingOffset, by+paddingOffset-1, bx+size+paddingOffset, by+size+paddingOffset); // right edge
						}
					}

					if (wy > 0) {
						var neighbor_id = global.world[# wx, wy-1];
						if (neighbor_id == 0 || !(global.blocks[neighbor_id].type == "block" || global.blocks[neighbor_id].type == "soil")) {
						    draw_line(bx+paddingOffset-1, by+paddingOffset, bx+size+paddingOffset, by+paddingOffset); // top edge
						}
					}

					if (wy < global.world_height-1) {
						var neighbor_id = global.world[# wx, wy+1];
						if (neighbor_id == 0 || !(global.blocks[neighbor_id].type == "block" || global.blocks[neighbor_id].type == "soil")) {
						    draw_line(bx+paddingOffset, by+size+paddingOffset, bx+size+paddingOffset, by+size+paddingOffset); // bottom edge
						}
					}
				}

            }
			

            // Draw damage overlay
            var dmg = global.block_damage[# wx, wy];
			var fraction = 0;
            if (dmg > 0 && (global.world[# wx, wy] != 0 || global.walls[# wx, wy] != 0)) {
				
				for (var j = 0; j < array_length(global.regenBlocks); j++)
				{
					if (global.regenBlocks[j].xp==wx &&	global.regenBlocks[j].yp==wy)
					{
						if (variable_instance_exists(global.regenBlocks[j],"wall"))
							fraction = dmg / global.blocks[global.walls[# wx, wy]].durability;
						else
						    fraction = dmg / block.durability;
					}
				}
				
                var frame = -1;
                if (fraction > 0.25 && fraction <= 0.5) frame = 0;
                else if (fraction > 0.5 && fraction <= 0.75) frame = 1;
                else if (fraction > 0.75) frame = 2;
                if (frame != -1) draw_sprite_part(
				        spr_block_break, frame,
				        0,0, 8,8,      // clip to 8x8 block size
				        xx*8+paddingOffset, yy*8+paddingOffset
				    );
            }

            // Draw cube zone overlays
            if (scr_is_cube_core(wx, wy)) {
                draw_sprite(spr_cube_core_border, 0, xx*8+paddingOffset, yy*8+paddingOffset);
            }
			if (scr_is_cube_border(wx, wy)) {
                draw_sprite(spr_cube_air_border, 0, xx*8+paddingOffset, yy*8+paddingOffset);
            }
        }
    }

    surface_reset_target();
	scr_update_chunk_liquids(cx,cy);
	scr_update_sky_light_chunk(cx,cy);
	


}

function switch_target(surf,surf_water,block,current)
{
	var target = (block.type == "water") ? surf_water : surf;

	if (target != current) {
	    current = target;
	    surface_set_target(current);
	}	
	return current;
}