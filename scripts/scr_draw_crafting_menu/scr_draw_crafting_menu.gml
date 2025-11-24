function scr_draw_crafting_menu(){
    var xx = argument0;
    var yy = argument1;
	var workstation = argument2;
    var w;
	var h;
	if (!obj_player.craftingMinimized)
	{
		h = 300;
		w = 475;
	}
	else
	{
		h = 30;
		w = 200;
	}

    //Background box
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_rectangle(xx, yy, xx+w, yy+h, false);
    draw_set_alpha(0.9);
    draw_set_color(c_aqua);
    draw_rectangle(xx, yy, xx+w, yy+h, true);
    draw_set_alpha(1);

	//Title
	draw_set_color(c_white);
	draw_text(xx+10, yy+10, string_upper(workstation) + " CRAFTING");

	
	//Draw minimize button
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_rectangle(xx+w-20, yy, xx+w, yy+10, false);
	draw_set_color(c_white);
	draw_rectangle(xx+w-20, yy, xx+w, yy+10, true);
	draw_text(xx+w-15, yy-5,"-");
	draw_set_alpha(1);
	
	//Toggle minimize
	if (mouse_check_button_pressed(mb_left) && point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),xx+w-20-10,yy-10,xx+w+10,yy+10+10))
		obj_player.craftingMinimized = !obj_player.craftingMinimized

	if (!obj_player.craftingMinimized)
	{

		//Search bar
		var display = "Search: " + obj_player.search_text;
		if (obj_player.search_active)
		{
			draw_set_color(c_white);
			display += "|";
		}
		else
			draw_set_color(c_gray);
		draw_rectangle(xx+10, yy+30, xx+w-10, yy+50, false);
		draw_set_color(c_black);
		draw_text(xx+14, yy+30, display);
		draw_set_color(c_white);

		// draw caret if active
		if (obj_player.search_active) {
			var caret_x = xx+14 + string_width(display) + 2;
			draw_line(caret_x, yy+34, caret_x, yy+46);
		}


		// === Recipe Grid ===
		var cols = 10;           // how many per row
		var slot_size = 40;      // slot width/height
		var padding = 6;         // spacing between slots
		var start_x = xx + 10;   // left margin inside box
		var start_y = yy + 60;   // top margin inside box
		var slot = 0;
		
		var mx = device_mouse_x_to_gui(0);
		var my = device_mouse_y_to_gui(0);

		for (var r = 0; r < array_length(global.recipes); r++) {
			if (!scr_recipe_visible(r, workstation)) continue;

			var recipe = global.recipes[r];
			var clr = recipe.unlocked ? c_white : c_gray;

			// grid position
			var col = slot mod cols;
			var row = slot div cols;

			var slot_x = start_x + col * (slot_size + padding);
			var slot_y = start_y + row * (slot_size + padding);

			// slot background 
			draw_set_alpha(0.6);
			draw_set_color(c_black);
			draw_rectangle(slot_x, slot_y, slot_x + slot_size, slot_y + slot_size, false);


			// recipe icon, centered inside slot
			var spr = recipe.sprite;
			var sw = sprite_get_width(spr);
			var sh = sprite_get_height(spr);
			var scale = min((slot_size-6) / sw, (slot_size-6) / sh);

			draw_set_alpha(1);
			draw_sprite_ext(spr, 0, slot_x + slot_size/2, slot_y + slot_size/2, scale, scale, 0, c_white, 1);
			if (recipe.count != 1)
			{
				draw_set_color(c_white);
				draw_set_alpha(1);
				draw_text_transformed(slot_x+slot_size/2-15,slot_y+slot_size/2,recipe.count,1,1,0);
			}
			draw_set_alpha(0.2);

			//slot border
			draw_set_color(c_aqua);
			if (point_in_rectangle(mx, my, slot_x, slot_y, slot_x+slot_size, slot_y+slot_size)) {
				obj_player.craftingHover = r;
				obj_player.displayCraftingHover = true;
				draw_set_color(c_lime);
			}
			draw_rectangle(slot_x, slot_y, slot_x + slot_size, slot_y + slot_size, true);
			slot++;
		}
	}


}