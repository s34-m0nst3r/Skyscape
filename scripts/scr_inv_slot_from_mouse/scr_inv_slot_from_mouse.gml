function scr_inv_slot_from_mouse() {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var slot_size = 32;
    var padding = 4;
    
    // Check hotbar
    for (var i = 0; i < hotbar_size; i++) {
         var xx = 20 + i * (slot_size + padding);
		 var yy = 20; 
        if (point_in_rectangle(mx, my, xx, yy, xx+slot_size, yy+slot_size)) {
            return i;
        }
    }
    
    // Check main inv
    if (inv_open) {
        for (var i = 0; i < main_size; i++) {
            var col = i mod 10;
            var row = i div 10;
            var xx = 20 + col * (slot_size + padding);
            var yy = 20 + slot_size + padding + row * (slot_size + padding);
            if (point_in_rectangle(mx, my, xx, yy, xx+slot_size, yy+slot_size)) {
                return hotbar_size + i;
            }
        }
    }
    
    return -1;
}

