//Light updates
alarm[4]=19;
cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);

//Draw surface aligned with camera
draw_x = floor(cam_x / tile_size) * tile_size - pad_pixels;
draw_y = floor(cam_y / tile_size) * tile_size - pad_pixels;

