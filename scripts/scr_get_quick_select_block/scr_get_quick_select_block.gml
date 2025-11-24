function scr_get_quick_select_block(){
	//mouse tile
	var mtx = mouse_x div 8;
	var mty = mouse_y div 8;


	// --- CONFIG ---
	var max_dist_tiles = obj_player.block_reach;     // same distance as your normal reach
	var step = 8;                         // 1 tile per step (8 pixels)
	var cone_angle = 0.55;                // radians; 0.55 ≈ 32 degrees cone

	// --- direction from player to mouse ---
	var dir = point_direction(x, y, mouse_x, mouse_y);
	var dir_rad = degtorad(dir);

	// --- raycast loop ---
	var px = x; 
	var py = y;

	for (var d = 0; d <= max_dist_tiles; d++)
	{
	    // move ray forward
	    px += lengthdir_x(step, dir);
	    py += lengthdir_y(step, dir);

	    var tx = px div 8;
	    var ty = py div 8;

	    // Bounds safety
	    if (tx < 0 || ty < 0 || tx >= global.world_width || ty >= global.world_height)
	        break;

	    var block_id = global.world[# tx, ty];

	    // Skip empty tiles
	    if (block_id <= 0) continue;

	    //var b = global.blocks[block_id];

	    // Block must exist and be solid
	    if (block_id == 0) continue;

	    // --- OPTIONAL CONE CHECK ---
	    // Angle between mouse direction and the vector to this tile
	    var ang_to_tile = point_direction(x, y, tx * 8 + 4, ty * 8 + 4); 
	    var diff = abs(angle_difference(dir, ang_to_tile));

	    if (diff > radtodeg(cone_angle))
	        continue;

	    // --- FOUND FIRST VALID BLOCK ---
		return {mx: tx, my: ty};
	}
	return  {mx: mouse_x div 8, my: mouse_y div 8};

}