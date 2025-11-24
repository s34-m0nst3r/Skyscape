var cam = view_camera[0];
var tile_size = 8;
var chunk_pixel = global.chunk_size * tile_size;

// How many chunks around the camera to include
var padding_chunks = 4; // increase this to expand the update range
var padding_range = 150;

// Get camera bounds
var cam_x = camera_get_view_x(cam)-padding_range;
var cam_y = camera_get_view_y(cam)-padding_range;
var cam_w = camera_get_view_width(cam)+padding_range*2;
var cam_h = camera_get_view_height(cam)+padding_range*2;

// Determine visible chunks with padding
var start_cx = max(0, floor(cam_x / chunk_pixel) - padding_chunks);
var start_cy = max(0, floor(cam_y / chunk_pixel) - padding_chunks);
var end_cx   = min(global.chunks_w, ceil((cam_x + cam_w) / chunk_pixel) + padding_chunks);
var end_cy   = min(global.chunks_h, ceil((cam_y + cam_h) / chunk_pixel) + padding_chunks);

// Store in queue
for (var cx = start_cx; cx < end_cx; cx++) {
    for (var cy = start_cy; cy < end_cy; cy++) {
        ds_queue_enqueue(visible_chunk_queue, [cx, cy]);
    }
}

alarm[5] = 15;
