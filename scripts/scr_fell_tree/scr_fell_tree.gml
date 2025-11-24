function scr_fell_tree(){
	var mx = argument0; //starting x block
	var my = argument1; //starting block y
	var range = argument2; //range horizontal distance from trunk

	var block_id = global.world[# mx, my];
	if (block_id == 0) exit;
	if (global.blocks[block_id].type != "tree") exit;

	var cx, cy, drop_item_id;

	//start from the broken block’s y
	for (var yy = my; yy >= 0; yy--) {
	    var found = false;

	    for (var xx = mx - range; xx <= mx + range; xx++) {
	        if (xx < 0 || xx >= global.world_width) continue;
	        var bid = global.world[# xx, yy];
	        if (bid != 0 && global.blocks[bid].type == "tree") {
	            found = true;

	            //break block
	            scr_block_break_check(bid, xx, yy);
				
				//If block was leaf, create leaf particles
				if (variable_instance_exists(global.blocks[global.world[# xx, yy]],"particle"))
				{
					if (irandom_range(0,2) == 1)
						instance_create_depth(xx*8+random_range(0,8),yy*8+random_range(0,8),-30,global.blocks[global.world[# xx, yy]].particle);
				
					//Chance for tree nuts

		            if (random_range(0,100) < 5) {
		                var inst = instance_create_depth(xx*8, yy*8, -5, obj_item_entity);
		                inst.item_id = 52;
		            }
				}

	            global.world[# xx, yy] = 0;
	            global.block_damage[# xx, yy] = 0;


	            drop_item_id = global.blocks[bid].item_id;
	            if (drop_item_id != -1) {
	                var inst = instance_create_depth(xx*8, yy*8, -5, obj_item_entity);
	                inst.item_id = drop_item_id;
	            }
	        }
	    }

	    //if we didn’t find any tree blocks at this level, stop looping
	    if (!found) break;
	}
	
	//update all touched chunks
	var minX = mx - 4; // trunk + leaves
	var maxX = mx + 4;
	var minY = my - 20 - 4;
	var maxY = my + 1;

	
	var start_cx = floor(minX / global.chunk_size);
	var end_cx   = floor(maxX / global.chunk_size);
	var start_cy = floor(minY / global.chunk_size);
	var end_cy   = floor(maxY / global.chunk_size);

	for (var cx = start_cx; cx <= end_cx; cx++) {
	    for (var cy = start_cy; cy <= end_cy; cy++) {
	        scr_update_chunk(cx, cy);
	    }
	}

}