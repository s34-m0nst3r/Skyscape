//DRAW SKY
draw_set_alpha(1);
// Draw vertical gradient
var camy = camera_get_view_y(view_camera[0]);
var camh = camera_get_view_height(view_camera[0]);
var camEnd = camy + camh;
var camx = camera_get_view_x(view_camera[0]);
for (var yy = camy; yy < camEnd; yy+=2){
	var t = yy / room_height;
	var color = merge_color(sky_top, sky_bottom, t);
	draw_set_color(color);
	draw_rectangle(camx, yy,camx + camera_get_view_width(view_camera[0]), yy+2,false);
}

//DRAW SUN/MOON
draw_sprite_ext(spr_moon,-1,sx,sy,1,1,0,c_white,moon_alpha);
draw_sprite_ext(spr_sun,-1,moonx,moony,1,1,0,c_white,sun_alpha);

with (obj_cloud)
{
	draw_self();	
}

gpu_set_blendmode(bm_normal);



//Draw visible chunk walls
for (var cx = start_cx; cx < end_cx; cx++) {
    for (var cy = start_cy; cy < end_cy; cy++) {
        var surf = global.chunk_wall_surfaces[cx][cy];
        if (surface_exists(surf)) {
            draw_surface(surf, cx*global.chunk_size*8 - paddingOffset, cy*global.chunk_size*8 - paddingOffset);
        
		}
    }
}
//Draw animated objects
for (var i = 0; i < array_length(global.animatedBlocks); i++) {
	var b = global.animatedBlocks[i];
	if (!variable_instance_exists(global.blocks[global.world[# b.xp, b.yp]],"animated") && !variable_instance_exists(global.blocks[global.liquids[# b.xp, b.yp]],"animated"))
	{
		array_delete(global.animatedBlocks,i,1);
		i--;	
	}
	var block = global.blocks[global.world[# b.xp, b.yp]];
	if block.type == "water" continue;
		
	if (point_distance(obj_player.x,obj_player.y,b.xp*8,b.yp*8) < 800)
	{
		draw_set_color(c_black);
	    var bx = b.xp * 8;
	    var by = b.yp * 8;
		if (block.name != "air" && block.sprite != -1)
		{
			if (block.type != "water")
				draw_sprite(block.sprite, floor(current_time / 100) mod sprite_get_number(block.sprite), bx, by);
		}
	}
}

// Draw only visible chunks
for (var cx = start_cx; cx < end_cx; cx++) {
    for (var cy = start_cy; cy < end_cy; cy++) {
        var surf = global.chunk_surfaces[cx][cy];
        if (surface_exists(surf)) {
            draw_surface(surf, cx*global.chunk_size*8 - paddingOffset, cy*global.chunk_size*8 - paddingOffset);
        
		}
    }
}

with(obj_player)
{
	if (alive)
		draw_self();
}
	
//Draw visible liquids 
for (var cx = start_cx; cx < end_cx; cx++) {
    for (var cy = start_cy; cy < end_cy; cy++) {
        var surf = global.chunk_liquid_surfaces[cx][cy];
        if (surface_exists(surf)) {
			//gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
            draw_surface(surf, cx*global.chunk_size*8 - paddingOffset, cy*global.chunk_size*8 - paddingOffset);
			gpu_set_blendmode(bm_normal);
		}
    }
}





