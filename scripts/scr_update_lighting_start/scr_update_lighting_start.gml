function scr_update_lighting_start(light,source_index) {
    var q = ds_queue_create();
    var start_x = light.xp;
    var start_y = light.yp;
    var start_power = light.pow;
	var red = light.r;
	var green = light.g;
	var blue = light.b

    ds_queue_enqueue(q, [start_x, start_y, start_power]);
    //global.light_grid[# start_x, start_y] = start_power;
	array_push(global.light_grid[start_x][start_y],{sx: light.xp, sy: light.yp, l: start_power,r: red, g: green, b: blue});
	array_push(global.light_sources[source_index].tiles,{xp: light.xp, yp: light.yp});
	scr_source_light_total(global.light_grid[start_x][start_y]);

    while (!ds_queue_empty(q)) {
        var node = ds_queue_dequeue(q);
        var xx = node[0];
        var yy = node[1];
        var pow = node[2];

        if (pow <= 0) continue;

        //Loop through 8 neighbors instead of 4 (to obtain better shape)
        for (var nx_off = -1; nx_off <= 1; nx_off++) {
            for (var ny_off = -1; ny_off <= 1; ny_off++) {
                if (nx_off == 0 && ny_off == 0) continue; // skip self

                var nx = xx + nx_off;
                var ny = yy + ny_off;

                if (nx < 0 || nx >= global.world_width) continue;
                if (ny < 0 || ny >= global.world_height) continue;

                // Slightly higher attenuation for diagonals
                var is_diagonal = (nx_off != 0 && ny_off != 0);
                var attenuation = is_diagonal ? 0.07 : 0.05;

                if (global.blocks[global.world[# nx, ny]].solid)
                    attenuation += 0.15;

                var new_power = pow - attenuation;
                //if (new_power > global.light_grid[# nx, ny]) {
				
				//Get array for this source block
				var index = scr_get_source(global.light_grid[nx][ny],start_x,start_y);
				if index == -1
				{
					array_push(global.light_grid[nx][ny],{sx: start_x, sy: start_y, l: 0,r: red, g: green, b: blue})
					index = array_length(global.light_grid[nx][ny])-1
				}
				
				if (new_power > global.light_grid[nx][ny][index].l) {
                    global.light_grid[nx][ny][index].l = new_power;
					//Add tile to blocks
					array_push(global.light_sources[source_index].tiles,{xp: nx, yp: ny});
					scr_source_light_total(global.light_grid[nx][ny]);
                    ds_queue_enqueue(q, [nx, ny, new_power]);
                }
            }
        }
    }

    ds_queue_destroy(q);
}

