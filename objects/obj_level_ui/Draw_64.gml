draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (global.levelReader >= 1 && !obj_player.inv_open) {
    var x1 = 100;
    var y1 = 85;

    draw_set_color(c_white);
    draw_text_transformed(x1-70, y1, "CUBE Level: " + string(global.cube_level) + " | " + string(global.cube_blocks_mined) + "/" + string(global.cube_next_level),0.8,0.8,0);

    // --- Progress bar ---
    var w = 100;
    var h = 10;
    var progress = global.cube_blocks_mined / global.cube_next_level;

    draw_set_color(c_gray);
    draw_rectangle(x1-50, y1+20, x1+w-50, y1+20+h, true);

    draw_set_color(c_green);
    draw_rectangle(x1-50, y1+20, x1+(w*progress)-50, y1+20+h, false);
	    
		
	draw_set_color(c_white);
		
}

if (global.biomeReader >= 1 && !obj_player.inv_open) {
    var x1 = 100;
    var y1 = 85+30;

    draw_set_color(c_white);
    draw_text_transformed(x1-70, y1, "Mistral Fields Level: " + string(global.mistral_level) + " | " + string(global.mistral_blocks_mined) + "/" + string(global.mistral_next_level),0.8,0.8,0);

    // --- Progress bar ---
    var w = 100;
    var h = 10;
    var progress = global.mistral_blocks_mined / global.mistral_next_level;

    draw_set_color(c_gray);
    draw_rectangle(x1-50, y1+20, x1+w-50, y1+20+h, true);

    draw_set_color(c_blue);
    draw_rectangle(x1-50, y1+20, x1+(w*progress)-50, y1+20+h, false);
	    
		
	draw_set_color(c_white);
		
}

