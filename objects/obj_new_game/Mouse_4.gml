// Initialize blank world
instance_create_depth(0,0, -1,obj_liquid_spread_handler);
instance_create_depth(0,0, -1,obj_world);
with (obj_world)
{
	scr_world_init();
}
instance_create_depth(0,0, -1,obj_cube_handler);

instance_create_depth(64,64, -1,obj_player);

obj_player.inventory[0] = { item: 0, count: 5 }; // 20 dirt blocks
obj_player.inventory[1] = { item: 1, count: 1 };  // 1 wood pickaxe
obj_player.inventory[2] = { item: 23, count: 1 };  // 1 wood pickaxe

instance_create_depth(0,0,-1,obj_camera);
instance_create_depth(0,0,-1,obj_stat_manager);


room_goto(rm_world)

//Update all chunks
for (var cx = 0; cx < global.chunks_w; cx++) {
    for (var cy = 0; cy < global.chunks_h; cy++) {
        scr_update_chunk(cx, cy);
    }
}



//OTHER VARS
global.levelReader = 0;
global.biomeReader = 0;

scr_recipe_defintions();

alarm[0]=2;

scr_redraw_lighting();