//Draw animated objects
for (var i = 0; i < array_length(global.animatedBlocks); i++) {
	var b = global.animatedBlocks[i];
	var block = global.blocks[global.liquids[# b.xp, b.yp]];
	if block.type != "water" continue;
	
	if (point_distance(obj_player.x,obj_player.y,b.xp*8,b.yp*8) < 800)
	{
		draw_set_color(c_black);
	    var bx = b.xp * 8;
	    var by = b.yp * 8;
		draw_sprite(block.sprite, floor(current_time / 100) mod sprite_get_number(block.sprite), bx, by);
	}
}






