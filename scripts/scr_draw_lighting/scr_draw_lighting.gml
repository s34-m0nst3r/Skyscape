function scr_draw_lighting() {
    var cam = view_camera[0];
    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);
    var cam_w = camera_get_view_width(cam);
    var cam_h = camera_get_view_height(cam);

    var tile_size = 8;

    // Compute visible chunks
    var x0 = floor(cam_x / (global.chunk_size * tile_size));
    var y0 = floor(cam_y / (global.chunk_size * tile_size));
    var x1 = ceil((cam_x + cam_w) / (global.chunk_size * tile_size));
    var y1 = ceil((cam_y + cam_h) / (global.chunk_size * tile_size));


    for (var cx = x0; cx < x1; cx++) {
        for (var cy = y0; cy < y1; cy++) {
            if (!surface_exists(global.chunk_light_surfaces[cx][cy])) continue;
            var surf = global.chunk_light_surfaces[cx][cy];
            draw_surface(
                surf,
                cx * global.chunk_size * tile_size,
                cy * global.chunk_size * tile_size
            );
        }
    }
}
