zoom = 2;
cam_w = 320*zoom;
cam_h = 180*zoom;


//Create camera
cam = camera_create_view(0, 0, cam_w, cam_h, 0, -1, -1, -1, cam_w/2, cam_h/2);

view_camera[0] = cam;
view_visible[0] = true;