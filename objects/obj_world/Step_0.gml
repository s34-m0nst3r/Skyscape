//DAY/NIGHT CYCLE
global.time_of_day += global.time_speed;
if (global.time_of_day > 1) global.time_of_day -= 1;


//Draw sun
// Convert time to an angle (full circle = 1 day)
var sun_angle = lerp(270, -90, global.time_of_day); 
// 270° = below (midnight), -90° = back below again, going counterclockwise

// Get radians

// Orbit around player
orbit_radius = 220 + (obj_camera.cam_w-(320*2))/4;
if (orbit_radius < 220)
	orbit_radius = 220;
var moon_alpha_target = scr_get_moon_alpha();
var sun_alpha_target = scr_get_sun_alpha();

if (moon_alpha_target > moon_alpha)
	moon_alpha+=0.001;
else if (moon_alpha_target < moon_alpha)
	moon_alpha-=0.001;	
	
if (sun_alpha_target > sun_alpha)
	sun_alpha+=0.001;
else if (sun_alpha_target < sun_alpha)
	sun_alpha-=0.001;	

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

// Determine visible chunks
start_cx = max(0, floor(cam_x / (global.chunk_size*8)));
start_cy = max(0, floor(cam_y / (global.chunk_size*8)));
end_cx = min(global.chunks_w, ceil((cam_x + cam_w) / (global.chunk_size*8)));
end_cy = min(global.chunks_h, ceil((cam_y + cam_h) / (global.chunk_size*8)));

var center_x = cam_x + (cam_w/2);
var center_y = cam_y + (cam_h/2);

sx = center_x + orbit_radius * dcos(sun_angle);
sy = center_y + orbit_radius * dsin(sun_angle);

//Draw moon
var moon_angle = lerp(270, -90, 1-global.time_of_day); 
moonx = center_x + orbit_radius * dcos(moon_angle);
moony = center_y - orbit_radius * dsin(moon_angle);

sky_top = get_sky_color(global.time_of_day);


//UPDATE LIGHT CHUNKS
for (var i = 0; i < camera_get_view_width(view_camera[0])/640; i++)
{
	if (!ds_queue_empty(visible_chunk_queue)) 
	{
		// Get the next chunk to update
		var chunk_data = ds_queue_dequeue(visible_chunk_queue);
		var cx = chunk_data[0];
		var cy = chunk_data[1];

		// Update lighting for this chunk
		scr_update_chunk_light(cx, cy);
	}
}
	