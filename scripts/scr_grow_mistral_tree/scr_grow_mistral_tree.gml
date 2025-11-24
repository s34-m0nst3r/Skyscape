function scr_grow_mistral_tree(xx,yy,i){
	var height = irandom_range(8, 20); //Random trunk height

    // Check if space is clear
    for (var j = 1; j <= height+2; j++) {
		for (var k = -2; k <= 2; k++)
		{
			if (global.world[# xx+k, yy-j] != 0) return i; // not enough space
		}
    }

    // Grow trunk
    for (var j = 0; j < height; j++) {
        global.world[# xx, yy-j] = 6; //MISTRAL TREE
		
		if (j != 0)
		{
			if (irandom(100) < 10) //Left Branch
			{
				global.world[# xx-1, yy-j] = 10;
				scr_block_place_check(10,xx-1,yy-j);
			}
			if (irandom(100) < 10) //Right Branch
			{
				global.world[# xx+1, yy-j] = 11;
				scr_block_place_check(11,xx+1,yy-j);
			}
		}
    }

    // Replace acorn with wood
    global.world[# xx, yy] = 6;
	scr_block_place_check(6,xx,yy);
	
	//Add adjacent stumps
	if (irandom(100) < 75)
	{
		global.world[# xx+1, yy] = 9;
		scr_block_place_check(9,xx+1,yy);
	}
	if (irandom(100) < 75)
	{
		global.world[# xx-1, yy] = 8;
		scr_block_place_check(8,xx-1,yy);
	}
	
	
	

    // Add leaves in a rough ball
    var topY = yy - height;
    for (var dx = -3; dx <= 3; dx++) {
        for (var dy = -3; dy <= 3; dy++) {
            var dist = point_distance(0,0,dx,dy);
            if (dist <= 3 && irandom(100) < 95) {
                var gx = xx + dx;
                var gy = topY + dy;
                if (gx >= 0 && gx < global.world_width && gy >= 0 && gy < global.world_height) {
                    if (global.world[# gx, gy] == 0 || global.world[# gx, gy] == 6) {
						
                        global.world[# gx, gy] = 7;
						scr_block_place_check(7,gx+1,gy);
						
						//Spawn particle
						if (irandom_range(0,2) == 1)
							instance_create_depth(gx*8+random_range(0,8),gy*8+random_range(0,8),-30,obj_leaf);
                    }
                }
            }
        }
    }
	
	// ounding box of the tree
	var minX = xx - 4; // trunk + leaves
	var maxX = xx + 4;
	var minY = yy - height - 4;
	var maxY = yy + 1;

	//clamp to world
	minX = max(minX, 0);
	maxX = min(maxX, global.world_width-1);
	minY = max(minY, 0);
	maxY = min(maxY, global.world_height-1);

	//update all touched chunks
	var start_cx = floor(minX / global.chunk_size);
	var end_cx   = floor(maxX / global.chunk_size);
	var start_cy = floor(minY / global.chunk_size);
	var end_cy   = floor(maxY / global.chunk_size);

	for (var cx = start_cx; cx <= end_cx; cx++) {
	    for (var cy = start_cy; cy <= end_cy; cy++) {
	        scr_update_chunk(cx, cy);
	    }
	}
	
	//REMOVE FROM GROWTH LIST
	array_delete(global.growthBlocks,i,1);
	
	
	return i-1;

}