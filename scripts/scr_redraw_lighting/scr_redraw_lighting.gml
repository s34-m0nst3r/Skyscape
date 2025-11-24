function scr_redraw_lighting() {
    var tile_size = 8;
    var pad_tiles = 8; // padding in tiles

    // ---- Camera ----
    var cam = view_camera[0];
    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);
    var cam_w = camera_get_view_width(cam);
    var cam_h = camera_get_view_height(cam);

    // ---- Surface size (camera + padding) ----
	var surf_w = (cam_w) + pad_tiles * tile_size * 2;
	var surf_h = (cam_h) + pad_tiles * tile_size * 2;

    // ---- Create / reuse surface only when needed ----
    if (!surface_exists(global.light_surface) ||
        global.light_surface_w != surf_w ||
        global.light_surface_h != surf_h)
    {
        if (surface_exists(global.light_surface)) {
            surface_free(global.light_surface);
        }
        global.light_surface = surface_create(surf_w, surf_h);
        global.light_surface_w = surf_w;
        global.light_surface_h = surf_h;
    }

    // ---- Top-left tile coordinates in the world (padded) ----
    var vx0 = (floor(cam_x / tile_size) - pad_tiles);
    var vy0 = (floor(cam_y / tile_size) - pad_tiles);

    // ---- Width/height in tiles including padding ----
    var tile_w = (cam_w div tile_size) + pad_tiles * 2;
    var tile_h = (cam_h div tile_size) + pad_tiles * 2;

    // ---- Clamp loop bounds to world ----
    var x_start = max(0, vx0);
    var y_start = max(0, vy0);
    var x_end   = min(global.world_width, vx0 + tile_w);
    var y_end   = min(global.world_height, vy0 + tile_h);

    // Quick out if nothing visible
    if (x_end <= x_start || y_end <= y_start) {
        return;
    }

    // ---- Precompute ambient and cache the grids ----
    var ambient = scr_get_ambient_light();
    var grid = global.light_grid;
    var sky_grid = global.sky_light_grid;

    // ---- Draw to surface (full redraw, exactly like before) ----
    surface_set_target(global.light_surface);
    draw_clear_alpha(c_black, 1); // full darkness (same as original)

    // local frequently used values for inner loop
    var tileSize_local = tile_size;
    var vx0_local = vx0;
    var vy0_local = vy0;
    var make_color_local = make_color_rgb; // local alias (micro)

    // Outer loop over Y then X (same ordering as original)
    for (var yy = y_start; yy < y_end; yy++) {
        // compute y offset once
        var y_off = (yy - vy0_local) * tileSize_local;
        for (var xx = x_start; xx < x_end; xx++) {
            // local cell reference - keep same indexing as your original data layout
            // grid[xx][yy][0] expected to be valid in your codebase
            var cell = grid[xx][yy][0];
			if (cell.l <= 0 && sky_grid[# xx, yy] <= 0) continue;
            var sourceLight = cell.l;
            var sourceRed   = cell.r;
            var sourceGreen = cell.g;
            var sourceBlue  = cell.b;

            // Sky contribution 
            var skyLight = ambient * sky_grid[# xx, yy].l;

            // Combined light (0–1)
            var l = 1 - ((1 - skyLight) * (1 - sourceLight));
            if (l <= 0) continue;

            // Per-channel
            var r = 1 - ((1 - skyLight) * (1 - sourceRed));
            var g = 1 - ((1 - skyLight) * (1 - sourceGreen));
            var b = 1 - ((1 - skyLight) * (1 - sourceBlue));

            // Reduce calls: compute byte components manually
            var r255 = floor(255 * r);
            var g255 = floor(255 * g);
            var b255 = floor(255 * b);

            var col = make_color_local(r255, g255, b255);

            // compute x offset and draw
            var x_off = (xx - vx0_local) * tileSize_local;
            draw_rectangle_color(
                x_off, y_off,
                x_off + tileSize_local, y_off + tileSize_local,
                col, col, col, col, false
            );
        }
    }

    surface_reset_target();
}
