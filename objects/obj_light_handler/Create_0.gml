// Controller Create event
global.light_refresh_index = 0;
global.light_refresh_delay = 1; // frames between each light update
global.light_refresh_timer = 0;

gridUpdate = false;
tempGrid = array_create(global.world_width);
for (var i = 0; i < global.world_width; i++) {
	tempGrid[i] = array_create(global.world_height,0);
}
processedTiles = 0;
queue = ds_queue_create();
update = noone;
tile_queue = [];

// Per light tracking
scan_x = -20;
scan_y = -20;
