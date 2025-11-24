item_id = -1; // what item this entity represents (link to global.items index)
count   = 1;  // how many items in this stack
hover_offset = 0 // random starting offset for hover effect
hover_y = 0;
hover_speed = 0.05;

hover_range = 2;
vsp = 0;
grav = 0.1;
frict = 0.1;

// Initial random impulse (only lasts briefly)
impulse_time = 15; // 15 frames (~1/2 second)
hsp = lengthdir_x(random_range(0, 1), irandom(359));
vsp = lengthdir_y(random_range(0, 1), irandom(359));
canBePickedUp = true;
depth = -30;

blueprint = -1;
water_level = -1;