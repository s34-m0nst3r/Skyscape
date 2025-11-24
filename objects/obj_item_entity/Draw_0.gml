
var spr = global.items[item_id].sprite;
draw_sprite(spr, 0, x, y + hover_y - 8);
if (blueprint != -1)
	draw_sprite_ext(global.items[blueprint].sprite, 0, x, y + hover_y - 8,1,1,0,c_white,0.8);
