global.light_refresh_timer++;
var updates_per_tick = 1; //How many to process per tick
for (var k = 0; k < updates_per_tick; k++)
{
	if (global.light_refresh_timer >= global.light_refresh_delay) {
	    global.light_refresh_timer = 0;

	    var tiles_per_tick = 256;  //How many tiles per light per tick

		//Check if current light has been selected
	    if (!variable_global_exists("current_light_rebuild")) {
	        global.current_light_rebuild = noone;
	    }

	    //If currently rebuilding a light, continue that
	    if (global.current_light_rebuild != noone) {
			gridUpdate = false;
		    var light = global.current_light_rebuild;
		    var radius = 20;

		    var processed = 0;

			 for (var dx = scan_x; dx <= radius; dx++) 
			 {
		        for (var dy = (dx == scan_x ? scan_y : -radius); dy <= radius; dy++) 
				{
		            var nx = light.xp;
		            var ny = light.yp;
				

		            // Skip out-of-bounds tiles
		            if (nx+dx < 0 || nx+dx >= global.world_width) continue;
		            if (ny+dy < 0 || ny+dy >= global.world_height) continue;

		            var new_power = tempGrid[nx+dx,ny+dy];		

		            // Per-source logic
		            var idx = scr_get_source(global.light_grid[nx+dx][ny+dy], light.xp, light.yp);
		            if (idx == -1) {
		                array_push(global.light_grid[nx+dx][ny+dy], {
		                    sx: light.xp,
		                    sy: light.yp,
		                    l: new_power,
		                    r: light.r,
		                    g: light.g,
		                    b: light.b
		                });
		            } else {
		                global.light_grid[nx+dx][ny+dy][idx].l = new_power;
		            }

		            scr_source_light_total(global.light_grid[nx+dx][ny+dy]);

		            processed++;
		            if (processed >= tiles_per_tick) {
		                // Save progress for next frame
						scan_x = dx;
						scan_y = dy + 1; // Continue with next tile
		                return; // Stop this frame
		            }
				
		        }
		    }
			global.current_light_rebuild = noone;
			processedTiles=0;
			update=noone;
			var key = string(light.xp) + "," + string(light.yp);
			if (ds_map_exists(global.light_update_lookup,key))
				ds_map_delete(global.light_update_lookup,key);

		}

		//No light has been selected, if light can be selected, select it.
		else if (!ds_queue_empty(global.light_update_queue) && !gridUpdate) {
	        // Start next light source rebuild
	        update = ds_queue_dequeue(global.light_update_queue);
	        var sx = update.sx;
	        var sy = update.sy;

	        var source_index = scr_get_light_source_index(sx, sy);
	        if (source_index != -1) {
	            var light = global.light_sources[source_index];
			

	            // Initialize temp grid + queue for async rebuild
				tempGrid = array_create(global.world_width);
			    for (var i = 0; i < global.world_width; i++) {
			        tempGrid[i] = array_create(global.world_height);
			    }
				processedTiles = 0;

			    scr_update_lighting_start_temp(global.light_sources[source_index], source_index);

			    gridUpdate = true;
	        }
	    }
		else if (gridUpdate)
		{
			var sx = update.sx;
	        var sy = update.sy;
		
			var source_index = scr_get_light_source_index(sx, sy);
			if (source_index != -1)
			{
				scr_update_lighting_start_temp(global.light_sources[source_index], source_index);

				if (gridUpdate == false)
				{
					var light = global.light_sources[source_index];

			        global.current_light_rebuild = light;
					var radius = 20;
				    scan_x = radius*-1;
				    scan_y = radius*-1;
				}
			}
		}
	}
}
