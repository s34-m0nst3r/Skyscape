function scr_update_chunk_light(cx, cy) {
	var chunk_size = global.chunk_size;
    var chunk_w = min(chunk_size, global.world_width - cx * chunk_size);
    var chunk_h = min(chunk_size, global.world_height - cy * chunk_size);
    var tile_size = 8;
    var padding = 0;

    // Create/reuse surface
    if (!surface_exists(global.chunk_light_surfaces[cx][cy])) {
        global.chunk_light_surfaces[cx][cy] = surface_create(chunk_w * tile_size + padding, chunk_h * tile_size + padding);
    }
    var surf = global.chunk_light_surfaces[cx][cy];

    surface_set_target(surf);
    draw_clear_alpha(c_black, 1); // full darkness
	draw_set_color(c_white);

    var ambient = scr_get_ambient_light();
    var grid = global.light_grid;
    var sky_grid = global.sky_light_grid;

    // Loop over all tiles in this chunk
    for (var xx = 0; xx < chunk_w; xx++) {
        for (var yy = 0; yy < chunk_h; yy++) {
            var wx = cx * chunk_size + xx;
            var wy = cy * chunk_size + yy;

            var cell = grid[wx][wy][0];
            var skyLight = ambient * sky_grid[# wx, wy].l;

            if (cell.l <= 0 && skyLight <= 0) continue;

            // Combined per-channel light
            var r = 1 - ((1 - skyLight) * (1 - cell.r));
            var g = 1 - ((1 - skyLight) * (1 - cell.g));
            var b = 1 - ((1 - skyLight) * (1 - cell.b));

            var col = make_color_rgb(floor(r*255), floor(g*255), floor(b*255));

            draw_rectangle_color(
                xx * tile_size, yy * tile_size,
                (xx + 1) * tile_size, (yy + 1) * tile_size,
                col, col, col, col, false
            );
        }
    }
    surface_reset_target();
}
