//Initalize definitions
scr_block_definitions();
scr_item_definitions();

draw_set_font(fnt_main);
surface_depth_disable(true);

scr_world_init();

camera_set_view_size(view_camera[0], 640, 480);
camera_set_view_pos(view_camera[0], 0, 0);

chunkSurfaces = false;

global.chunk_size = 32; // blocks per chunk
global.chunks_w = ceil(global.world_width / global.chunk_size);
global.chunks_h = ceil(global.world_height / global.chunk_size);

global.chunk_surfaces = array_create(global.chunks_w);
for (var cx = 0; cx < global.chunks_w; cx++) {
    global.chunk_surfaces[cx] = array_create(global.chunks_h);
    for (var cy = 0; cy < global.chunks_h; cy++) {
        global.chunk_surfaces[cx][cy] = -1;
        scr_update_chunk(cx, cy);
    }
}

surface_depth_disable(false);

//WORLD GROWTH
global.block_timers = ds_grid_create(global.world_width, global.world_height);
ds_grid_clear(global.block_timers, 0);


//GROWTH AND REGEN UPDATES
alarm[1]=1;
//PARTICLE updates
alarm[2]=10;

//Cloud updates
alarm[3]=13;

//Light updates
alarm[4]=1


tile_size = 8;
pad_tiles = 8;
pad_pixels = pad_tiles * tile_size;

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);

global.u_pixelSize = shader_get_uniform(sh_light_blur, "pixelSize");




//Draw surface aligned with camera
draw_x = floor(cam_x / tile_size) * tile_size - pad_pixels;
draw_y = floor(cam_y / tile_size) * tile_size - pad_pixels;


//display_set_timing_method(tm_sleep);
//game_set_speed(60, gamespeed_fps);


//TIME
global.time_of_day = 0.5; // 0–1, where 0 = midnight, 0.25 = 6 AM, 0.5 = noon, 0.75 = 6 PM
global.time_speed = 0.00002; // speed per step, tweak for length of day
orbit_radius = 220; // how far the sun/moon is from player

sun_alpha = scr_get_sun_alpha();
moon_alpha = scr_get_moon_alpha();
sunx = room_width/2;
suny = room_height/2;

moonx_real = room_width/2;
moony_real = room_height/2;
sx=0;
sy=0;
moonx=0;
moony=0;

sky_top = get_sky_color(global.time_of_day);
sky_bottom = make_color_rgb(3, 13, 84);

surface_depth_disable(true);
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);

sky_surface = surface_create(room_width,room_height);
visible_chunk_queue = ds_queue_create();
alarm[5]=1;

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

// Determine visible chunks
start_cx = max(0, floor(cam_x / (global.chunk_size*8)));
start_cy = max(0, floor(cam_y / (global.chunk_size*8)));
end_cx = min(global.chunks_w, ceil((cam_x + cam_w) / (global.chunk_size*8)));
end_cy = min(global.chunks_h, ceil((cam_y + cam_h) / (global.chunk_size*8)));
paddingOffset = 8;