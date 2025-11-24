function scr_check_search_bar(){
	var mx = device_mouse_x_to_gui(0);
	var my = device_mouse_y_to_gui(0);
	var xx = argument0;
	var yy = argument1;

	//Search bar bounds (match the draw code)
	var sb_x1 = xx+ 10;         // xx+10
	var sb_y1 = yy + 30;        // yy+30
	var sb_x2 = xx + 475 - 10;   // xx+w-10
	var sb_y2 = yy + 50;        // yy+50

	if (mouse_check_button_pressed(mb_left)) {
	    if (point_in_rectangle(mx, my, sb_x1, sb_y1, sb_x2, sb_y2)) {
	        obj_player.search_active = true;
			//show_message("");
	    } else {
	        obj_player.search_active = false;
	    }
	}
	


}