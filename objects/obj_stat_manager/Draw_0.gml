//Draw AIR BUBBLES
if (air != maxAir)
{
	var halign = draw_get_halign();
	draw_set_halign(fa_center);
	
	var bubbles_to_draw = ceil(maxAir / symbol_value);

	if (bubbles_to_draw > 10) bubbles_to_draw = 10;
	var max_value = 10 * symbol_value;
	//Bonus bubbles_to_draw
	var bonus_to_draw = (air - max_value)/symbol_value;
	//Regular hearts bubbles draw
	var regular_bubbles_to_draw = (air)/symbol_value;
	var bubble_offset = 10 - bubbles_to_draw;
	if (bubble_offset < 0)
		bubble_offset = 0;
	for (var i = 0; i < bubbles_to_draw; i++)
	{
	    var col = i mod 10;

	    var xx = obj_player.x - (90 - (10*bubble_offset)) + col * 20;
	    var yy = obj_player.y - 20;

		var spr = spr_oxygen_empty;
		if (bonus_to_draw > 0)
		{
			bonus_to_draw--;
			spr = spr_oxygen_bonus;
		}
		else if (regular_bubbles_to_draw > 0)
		{
			regular_bubbles_to_draw--;
			spr = spr_oxygen;
		}
	    draw_sprite(spr, 0, xx, yy);
	}


	draw_set_halign(halign);

}