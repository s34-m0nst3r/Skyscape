function is_solid_at(px, py, moving_up)
{
	var gx = floor(px / 8);
    var gy = floor(py / 8);

    if (gx < 0 || gy < 0 || gx >= global.world_width || gy >= global.world_height) {
        return false;
    }

    var block_id = global.world[# gx, gy];
	
	//Check for platform
	if (global.blocks[block_id].type == "platform")
	{
		if (obj_player.platformFalling)
			return false;
		var player_bottom = obj_player.y + 12; // center origin 24px sprite
        var block_top = gy * 8;
		var yDistance = abs(((gy * 8)+4) - obj_player.y)
		
		if (obj_player.y > block_top)
			return false;

        // Only solid if moving downwards and player's bottom is above the block
        if (!moving_up && player_bottom > block_top && yDistance > 10) {
            return true;
        } else {
            return false;
        }
	}
	
    return (block_id != 0 && global.blocks[block_id].solid);
}