

// Multiply surface over the world
gpu_set_blendmode_ext(bm_dest_color, bm_zero); // multiply

var w = surface_get_width(global.light_surface);
var h = surface_get_height(global.light_surface);

//Set shader
var sha = sh_light_blur;
gpu_set_tex_mip_enable(mip_on); // turn mipmapping on
//gpu_set_tex_filter(tf_anisotropic); // anisotropic so its not chunky
shader_set(sha);
shader_set_uniform_f(global.u_pixelSize, 1 / surface_get_width(global.light_surface), 1 / surface_get_height(global.light_surface));


//Draw Surface
scr_draw_lighting();

//Reset shader
shader_reset();
gpu_set_tex_mip_enable(mip_off); // turn off mipmapping



gpu_set_blendmode(bm_normal);
















//Draw world ambient light


/*
gpu_set_blendmode_ext(bm_dest_colour, bm_zero);
draw_set_color(make_color_hsv(60, 30, scr_get_ambient_light() * 255));
draw_rectangle(0,0,room_width,room_height,false);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);
*/

