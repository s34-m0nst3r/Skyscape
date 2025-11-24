/// scr_update_lighting_start_temp(light, source_index, tiles_per_frame)
/// light = light source struct
/// source_index = index of the source in light_sources (can be ignored if you just want the grid)
/// tiles_per_frame = how many tiles to process per step (optional; default 64)

function scr_update_lighting_start_temp(light, source_index) {

    var tiles_per_frame = 104;
	obj_light_handler.processedTiles=0;
	
	if (obj_light_handler.gridUpdate == false)
	{
	    // BFS queue
		obj_light_handler.queue = ds_queue_create();
	    ds_queue_enqueue(obj_light_handler.queue, [light.xp, light.yp, light.pow]);
		array_push(obj_light_handler.tile_queue,{xp: light.xp, yp: light.yp});

	    obj_light_handler.tempGrid[light.xp][light.yp] = light.pow;
	}


    while (!ds_queue_empty(obj_light_handler.queue) && obj_light_handler.processedTiles < tiles_per_frame) {
        var node = ds_queue_dequeue(obj_light_handler.queue);
        var xx = node[0];
        var yy = node[1];
        var pow = node[2];

        if (pow <= 0) continue;

        // Loop through 8 neighbors
        for (var nx_off = -1; nx_off <= 1; nx_off++) {
            for (var ny_off = -1; ny_off <= 1; ny_off++) {
                if (nx_off == 0 && ny_off == 0) continue;

                var nx = xx + nx_off;
                var ny = yy + ny_off;

                if (nx < 0 || nx >= global.world_width) continue;
                if (ny < 0 || ny >= global.world_height) continue;

                var is_diagonal = (nx_off != 0 && ny_off != 0);
                var attenuation = is_diagonal ? 0.07 : 0.05;
                if (global.blocks[global.world[# nx, ny]].solid)
                    attenuation += 0.15;

                var new_power = pow - attenuation;

                if (new_power > obj_light_handler.tempGrid[nx][ny]) {
                    obj_light_handler.tempGrid[nx][ny] = new_power;
                    ds_queue_enqueue(obj_light_handler.queue, [nx, ny, new_power]);
                }
            }
        }

        obj_light_handler.processedTiles++;
    }

	if (ds_queue_empty(obj_light_handler.queue))
		obj_light_handler.gridUpdate = false;
}
