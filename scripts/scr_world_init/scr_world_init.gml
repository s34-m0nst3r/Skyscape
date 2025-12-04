

function scr_world_init(){
    //World Init
    global.world_width = 300;
    global.world_height = 300;
    global.world = ds_grid_create(global.world_width,global.world_height);
	global.walls = ds_grid_create(global.world_height,global.world_height);
	ds_grid_clear(global.walls,0);
	global.liquids = ds_grid_create(global.world_height,global.world_height);
	ds_grid_clear(global.liquids,0);

    ds_grid_clear(global.world, 0); // air
    global.block_damage = ds_grid_create(global.world_width, global.world_height);
    ds_grid_clear(global.block_damage, 0);
	
	global.growthBlocks = [];
	global.regenBlocks = [];
	global.particleBlocks = [];
	global.animatedBlocks = [];
	
	//LIGHTING
	global.light_sources = []; // array of structs { xp, yp, power }

	

	global.light_grid = array_create(global.world_width);

	for (var xx = 0; xx < global.world_width; xx++) {
	    global.light_grid[xx] = array_create(global.world_height);
	    for (var yy = 0; yy < global.world_height; yy++) {
	        // Each cell starts with one entry at index 0 for total light
	        global.light_grid[xx][yy] = [{ sx: -1, sy: -1, l: 0, r: 0, g: 0, b: 0}];
	    }
	}
	
	global.sky_light_grid = ds_grid_create(global.world_width, global.world_height);
	ds_grid_clear(global.sky_light_grid, {l: 0, sky_expose: false}); // 1 == full access to sky
	
	global.light_update_queue = ds_queue_create();
	global.light_update_lookup = ds_map_create();
	global.light_update_processing = false;
	
	global.light_surface = -1;
	global.light_surface_w = 0;
	global.light_surface_h = 0;

	// incremental update indices for lighting (tile index linear)
	global._light_update_active = false;   // true while we are rebuilding
	global._light_update_idx = 0;          // linear index into region being updated
	global._light_update_total = 0;
	global._light_update_region = [0,0,0,0]; // vx0, vy0, tile_w, tile_h

	// tuning: how many tiles to update per frame when chunking lighting rebuild
	global.light_tiles_per_frame = 2048; // try 2048..8192 depending on CPU

	// precomputed color lookup table small helper (optional)
	global._color_cache = ds_map_create();
	// note: ds_map used as simple cache for numeric colors if you wish


    //------------------------------------
    // CUBE ZONE SETUP
    //------------------------------------
    var cx = global.world_width div 2;
    var cy = global.world_height div 2;

    // Store cube zone center
    global.cube_center_x = cx;
    global.cube_center_y = cy;

    // Cube core (3x3 region)
    global.cube_core = ds_grid_create(3, 3);
    for (var xx = -1; xx <= 1; xx++) {
        for (var yy = -1; yy <= 1; yy++) {
            global.world[# cx+xx, cy+yy] = 1; // start with dirt
        }
    }

    // Spawn player here
    global.spawn_x = cx*8;
    global.spawn_y = (cy-50)*8;

    // Dirt path under cube zone
    for (var xx = -6; xx <= 6; xx++) {
        global.world[# cx+xx, cy+4] = 1;
    }
	
	//------------------------------------
    // CHUNK SYSTEM
    //------------------------------------
    global.chunk_size = 32;
    global.chunk_cols  = ceil(global.world_width / global.chunk_size);
    global.chunk_rows  = ceil(global.world_height / global.chunk_size);

    // Nested array for chunk surfaces
    global.chunk_surfaces = [];
    for (var i = 0; i < global.chunk_cols; i++) {
        global.chunk_surfaces[i] = [];
        for (var j = 0; j < global.chunk_rows; j++) {
            global.chunk_surfaces[i][j] = -1; // initialize
        }
    }
	
	// Nested array for wall surfaces
    global.chunk_wall_surfaces = [];
    for (var i = 0; i < global.chunk_cols; i++) {
        global.chunk_wall_surfaces[i] = [];
        for (var j = 0; j < global.chunk_rows; j++) {
            global.chunk_wall_surfaces[i][j] = -1; // initialize
        }
    }
	
	// Nested array for liquid surfaces
    global.chunk_liquid_surfaces = [];
    for (var i = 0; i < global.chunk_cols; i++) {
        global.chunk_liquid_surfaces[i] = [];
        for (var j = 0; j < global.chunk_rows; j++) {
            global.chunk_liquid_surfaces[i][j] = -1; // initialize
        }
    }
	
	// Nested array for light surfaces
    global.chunk_light_surfaces = [];
    for (var i = 0; i < global.chunk_cols; i++) {
        global.chunk_light_surfaces[i] = [];
        for (var j = 0; j < global.chunk_rows; j++) {
            global.chunk_light_surfaces[i][j] = -1; // initialize
        }
    }
	
	global.chunk_water_surfaces = [];
    for (var i = 0; i < global.chunk_cols; i++) {
        global.chunk_water_surfaces[i] = [];
        for (var j = 0; j < global.chunk_rows; j++) {
            global.chunk_water_surfaces[i][j] = -1; // initialize
        }
    }


    // Pre-render all chunks
    for (var cx = 0; cx < global.chunk_cols; cx++) {
        for (var cy = 0; cy < global.chunk_rows; cy++) {
            scr_update_chunk(cx, cy);
        }
    }
	
	//Pointer grid
	global.blockPointers = ds_grid_create(global.world_width, global.world_height);
    ds_grid_clear(global.blockPointers, {xcord: -1, ycord: -1});
	
	
}

function scr_is_cube_core(xx, yy) {
    var cx = global.cube_center_x;
    var cy = global.cube_center_y;
    return (xx >= cx-1 && xx <= cx+1 && yy >= cy-1 && yy <= cy+1);
}

function scr_is_cube_top_left(xx,yy){
	var cx = global.cube_center_x;
    var cy = global.cube_center_y;
    return (xx == cx-1 && yy == cy-1);
}

function scr_is_cube_border(xx, yy) {
    var cx = global.cube_center_x;
    var cy = global.cube_center_y;
    return (xx >= cx-3 && xx <= cx+3 && yy >= cy-3 && yy <= cy+3)
        && !(xx >= cx-1 && xx <= cx+1 && yy >= cy-1 && yy <= cy+1);
}
