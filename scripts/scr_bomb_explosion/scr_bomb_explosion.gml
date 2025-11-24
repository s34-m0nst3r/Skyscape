function scr_bomb_explosion(){
	/// scr_dirt_bomb_explode(x, y)
	var px = argument0 div 8;
	var py = argument1 div 8;
	var blockid = argument2
	var secondblockid = argument3;
	var lastCx = -1;
	var lastCy = -1;

	var radius = 4; // radius in blocks

	for (var xx = -radius; xx <= radius; xx++) {
	    for (var yy = -radius; yy <= radius; yy++) {
	        var gx = px + xx;
	        var gy = py + yy;

	        // Check inside radius
	        if (point_distance(0,0,xx,yy) <= radius) {
	            // Random chance for irregular shape
	            if (irandom(100) < 65) {
	                if (global.world[# gx, gy] == 0 && !scr_is_cube_border(gx, gy)) {
						var placeID = blockid;
						if (global.blocks[blockid].type == "water")
							global.liquids[# gx, gy] = blockid;
						else
							global.world[# gx, gy] = blockid;
						instance_create_depth(gx*8+random_range(-4,4),gy*8+random_range(-4,4),-1,obj_smoke);
						
						if (secondblockid != -1 && random_range(0,100) > 85)
						{
							global.world[# gx, gy] = secondblockid;
							placeID = secondblockid;
						}
						
						// Update chunk
						var cx = floor(gx / global.chunk_size);
						var cy = floor(gy / global.chunk_size);
						
						if (cx != lastCx || cy != lastCy)
						{
							if (lastCx != -1)
								scr_update_chunk(lastCx, lastCy);
							lastCx=cx;
							lastCy=cy;
							scr_update_chunk(cx, cy);
						}
						
						scr_block_place_check(placeID, gx,gy);
	                }
	            }
	        }
	    }
	}
	var cx = floor(px / global.chunk_size);
	var cy = floor(py / global.chunk_size);
	scr_update_chunk(cx, cy);
	


}