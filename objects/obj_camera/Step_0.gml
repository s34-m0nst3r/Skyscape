//Follow target
var target_x = obj_player.x - cam_w/2;
var target_y = obj_player.y - cam_h/2;

//Smooth lerp
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

target_x = lerp(cam_x, target_x, 0.1);
target_y = lerp(cam_y, target_y, 0.1);

//Clamp to room bounds
target_x = clamp(target_x, 0, room_width - cam_w);
target_y = clamp(target_y, 0, room_height - cam_h);

//Apply
camera_set_view_pos(cam, target_x, target_y);

//Camera Zoom
var zoom_speed1 = 20; // how fast the camera zooms
var zoom_speed2 = 11.25; // how fast the camera zooms
var new_w = cam_w - mouse_wheel_up() * zoom_speed1 + mouse_wheel_down() * zoom_speed1;
var new_h = cam_h - mouse_wheel_up() * zoom_speed2 + mouse_wheel_down() * zoom_speed2;

// Clamp zoom limits
new_w = clamp(new_w, 320, 320*5);
new_h = clamp(new_h, 180, 180*5);

// Update camera size
cam_w = new_w;
cam_h = new_h;
camera_set_view_size(cam, cam_w, cam_h);
