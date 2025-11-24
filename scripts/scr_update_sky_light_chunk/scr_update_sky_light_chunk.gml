function scr_update_sky_light_chunk(cx, cy)
{
    var chunk_size = global.chunk_size;
    var world_w = global.world_width;
    var world_h = global.world_height;
    var pad = 4;

    // Fixed falloff values
    var vertical_falloff = 0.1;
    var side_falloff = 0.1;
    var diagonal_falloff = 0.1; // slightly stronger decay for diagonal propagation

    var x_start = max(cx * chunk_size - pad, 0);
    var y_start = max(cy * chunk_size - pad, 0);
    var x_end   = min((cx + 1) * chunk_size + pad, world_w);
    var y_end   = min((cy + 1) * chunk_size + pad, world_h);

    // -------------------------
    // Pass 1: mark sky-exposed cells
    // -------------------------
    for (var xx = x_start; xx < x_end; xx++) {
        for (var yy = 0; yy < y_end; yy++) {
            if (yy < y_start || yy >= y_end) continue;

            if (global.sky_light_grid[# xx, yy] == undefined) {
                global.sky_light_grid[# xx, yy] = { l: 0, sky_expose: false };
            }

            var block = global.blocks[ global.world[# xx, yy] ];

            if (yy == 0) {
                global.sky_light_grid[# xx, yy] = { l: 1, sky_expose: true };
                continue;
            }
			else
			{
	            var above = global.sky_light_grid[# xx, yy - 1];
	            if (above.sky_expose && !block.solid) {
	                global.sky_light_grid[# xx, yy] = { l: 1, sky_expose: true };
	            } else {
	                 global.sky_light_grid[# xx, yy] = { l: 0, sky_expose: false };
					
	            }
			}
        }
    }
	
	//PASS 1B WRAP AROUND
	for (var xx = x_start; xx < x_end; xx++) {
        for (var yy = y_start; yy < y_end; yy++) {
			if (yy <= global.world_height/2 && !global.sky_light_grid[# xx, yy].sky_expose && (global.sky_light_grid[# xx+1, yy].sky_expose || global.sky_light_grid[# xx-1, yy].sky_expose))
			{
				var valid = true;
				for (var i = 1; i < 8; i++)
				{
					if (global.sky_light_grid[# xx, yy-i].sky_expose)
					{
						valid = false;
						break;
					}
				}
				if (valid)
				{
					var j = 0;
					while (!global.blocks[global.world[# xx, yy + j]].solid)
					{
						global.sky_light_grid[# xx, yy+j] = {l: 1, sky_expose: true}
						j++;
					}
				}
			}
		}
	}


    // -------------------------
    // Pass 2: iterative light relaxation
    // -------------------------
    var passes = 4; // few passes to stabilize
    for (var p = 0; p < passes; p++) {
        for (var xx = x_start; xx < x_end; xx++) {
            for (var yy = y_start; yy < y_end; yy++) {
                var cell = global.sky_light_grid[# xx, yy];
                if (cell.sky_expose) continue;

                var best = 0;
                var n;

                // Vertical neighbors (up/down)
                if (yy > 0) {
                    n = global.sky_light_grid[# xx, yy - 1];
					var m = n.l - vertical_falloff
					//show_debug_message("M: " + string(m) + " best" + string(best) + "max: " + string(max(best,m)));
                    best = max(best, m);
                }
                if (yy + 1 < world_h) {
                    n = global.sky_light_grid[# xx, yy + 1];
					var m = n.l - vertical_falloff;
                    best = max(best, m);
                }

                // Horizontal neighbors (left/right)
                if (xx > 0) {
                    n = global.sky_light_grid[# xx - 1, yy];
					var m = n.l - side_falloff
                    best = max(best, m);
                }
                if (xx + 1 < world_w) {
                    n = global.sky_light_grid[# xx + 1, yy];
					var m = n.l - side_falloff
                    best = max(best, m);
                }



                // Clamp
                best = clamp(best, 0, 1);

                cell.l = best;
                global.sky_light_grid[# xx, yy] = cell;
            }
        }
    }
}
