
if (alive)
{
	//Check if in slowdown blocks
	var left_x = clamp((x-8) div 8,0,global.world_width-1);
	var right_x = clamp((x+8) div 8,0,global.world_width-1);
	var below_y = clamp((y+12) div 8,0,global.world_height-1);
	
	var blockLeft = global.blocks[global.liquids[# left_x, below_y]];
	var blockRight = global.blocks[global.liquids[# right_x, below_y]];
	
	if (variable_instance_exists(blockLeft, "slowdown"))
	{
		if (blockLeft.type == "water" && moveSpeedMultiplier != blockLeft.slowdown && vsp != 0)
		{
			for (var i = 0; i < irandom_range(5,9); i++)
				instance_create_depth(x,y+8,-100,obj_water_particle);
		}
		moveSpeedMultiplier = blockLeft.slowdown;
		fallDistance = 0;
	}
	else if (variable_instance_exists(blockRight, "slowdown"))
	{
		if (blockRight.type == "water" && moveSpeedMultiplier != blockRight.slowdown && vsp != 0)
		{
			for (var i = 0; i < irandom_range(5,9); i++)
				instance_create_depth(x,y+8,-100,obj_water_particle);
		}
		moveSpeedMultiplier = blockRight.slowdown;
		fallDistance = 0;
	}
	else
		moveSpeedMultiplier = 1;
	
	//Check if you can breathe
	var above_y = clamp((y-10) div 8,0,global.world_height-1);
	
	blockLeft = global.blocks[global.liquids[# left_x, above_y]];
	blockRight = global.blocks[global.liquids[# right_x, above_y]];
	if (!blockLeft.canBreathe || !blockRight.canBreathe)
		obj_player.canBreathe = false;
	else
		obj_player.canBreathe = true;
	
	//Apply gravity
	if (vsp < gravMax)
		vsp += grav*moveSpeedMultiplier;
	
	//Horizontal movement
	if (!search_active)
	{
		hsp = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * (spd*moveSpeedMultiplier);

		//direction facing
		if (keyboard_check(ord("D")))
		{
			facing = 1; //right
			sprite_index = spr_player_right
		}
		if (keyboard_check(ord("A")))
		{
			facing = 0; //left
			sprite_index = spr_player_left
		}
	
		//Jumping
		if (on_ground && keyboard_check_pressed(vk_space)) {
		    vsp = jump_spd*moveSpeedMultiplier;
		}
	}



	//When you fall off world
	if y > room_height
	 y = 0; 
 
	//Check for floating
	var yp = floor((y + 13));
	if (vsp == 0 && yp % 8 != 0 && !clipFix)
	{
		//Check for clipping
		clipFix = true;
		alarm[2] = 2;	
	}
 
	// Horizontal move
	x += hsp;
	var moving_up = (vsp < 0);
	if (is_solid_at(x - 7, y - 11,moving_up) || is_solid_at(x - 7, y + 12,moving_up) || // left side
		is_solid_at(x + 8, y,moving_up) || is_solid_at(x - 7, y,moving_up) || // middle
		is_solid_at(x + 8, y - 6,moving_up) || is_solid_at(x - 7, y - 6,moving_up) || // middle half
		is_solid_at(x + 8, y + 6,moving_up) || is_solid_at(x - 7, y + 6,moving_up) || // middle half
	    is_solid_at(x + 8, y - 11,moving_up) || is_solid_at(x + 8, y + 12,moving_up)) { // right side
	    // undo movement
	    x -= hsp;
	    hsp = 0;
	}
 
	 // Vertical move 
	y += vsp;
	fallDistance += vsp;
	on_ground = false;
	if (is_solid_at(x - 7, y - 11,moving_up) || is_solid_at(x - 7, y + 12,moving_up) || // left side
		is_solid_at(x, y+12,moving_up) || is_solid_at(x, y-12,moving_up) || // middle
		is_solid_at(x + 8, y - 6,moving_up) || is_solid_at(x - 7, y - 6,moving_up) || // middle half
		is_solid_at(x + 8, y + 6,moving_up) || is_solid_at(x - 7, y + 6,moving_up) || // middle half
	    is_solid_at(x + 8, y - 11,moving_up) || is_solid_at(x + 8, y + 12,moving_up)) { // right side
	    if (vsp > 0) on_ground = true;
	    // undo movement
	    y -= vsp;
	    vsp = 0;
		//Apply fallDamage
		if (fallDistance >= 150)
		{
			var damage =  floor((fallDistance/20) * fallDamage);
			obj_stat_manager.hp -= damage;	
			var text = instance_create_depth(x,y,-1,obj_damage_text);
			text.val = damage;
			deathMessage = "Fell from a great height!";
			for (var i = 0; i < irandom_range(8,12); i++)
			{
				instance_create_depth(x,y,-1,obj_blood);	
			}
		}
		
		fallDistance = 0;
	
		scr_automatic_walk_up(facing,moving_up);
		scr_automatic_open(facing,moving_up);
	}

	//Drop down from platform
	if (keyboard_check(ord("S")))
	{
		var valid = true;
		for (var j = -1; j <= 1; j++)
		{
			var gx = floor(x / 8);
		    var gy = floor((y + 13) / 8); // bottom of player
		    var block_id = global.world[# gx+j, gy];
		    var blk = global.blocks[block_id];
		    if (blk.type != "platform" || blk.solid) && (block_id != 0) {
				valid = false;
		    }
		}
		if (valid)
		{
			//y += 10;
			//vsp += grav;
			platformFalling = true;
			alarm[1]=10;
		}
	}



	//Inventory
	// Toggle inventory
	if (keyboard_check_pressed(vk_escape)) {
	    inv_open = !inv_open;
		workstation = "basic";
		workstation_x = 60;
	
		if (!inv_open)
		{
			search_active = false;
			search_text = "";
		}
	
		if (!inv_open && dragging_item != noone)
		{
			var drop_id   = dragging_item.item;
		    var drop_type = global.items[drop_id];

		    // --- Spawn item entity ---
		    var xx = obj_player.x;
		    var yy = obj_player.y - 8; // spawn slightly above player
		    var inst = instance_create_layer(xx, yy, "Instances", obj_item_entity);
        
		    inst.item_id = drop_id;
		    inst.count   = dragging_item.count;
			if (variable_instance_exists(dragging_item,"blueprint"))
				inst.blueprint = dragging_item.blueprint;
			if (variable_instance_exists(dragging_item,"water_level"))
				inst.water_level = dragging_item.water_level;
			inst.canBePickedUp = false;
			inst.alarm[0] = 25;


		    // Launch based on facing (0 = left, 1 = right)
		    var itemhsp = (obj_player.facing == 0) ? -1 : 1;
		    var itemvsp = -0.5; // small upward throw
		    inst.hsp = itemhsp;
		    inst.vsp = itemvsp;
			inst.impulse_time = 25;
		
			dragging_item = noone;
		
		}
	}

	// Hotbar scroll (mouse wheel)
	if (keyboard_check_pressed(ord("0")))
		hotbar_index = 9;
	if (keyboard_check_pressed(ord("1")))
		hotbar_index = 0;
	if (keyboard_check_pressed(ord("2")))
		hotbar_index = 1;
	if (keyboard_check_pressed(ord("3")))
		hotbar_index = 2;
	if (keyboard_check_pressed(ord("4")))
		hotbar_index = 3;
	if (keyboard_check_pressed(ord("5")))
		hotbar_index = 4;
	if (keyboard_check_pressed(ord("6")))
		hotbar_index = 5;
	if (keyboard_check_pressed(ord("7")))
		hotbar_index = 6;
	if (keyboard_check_pressed(ord("8")))
		hotbar_index = 7;
	if (keyboard_check_pressed(ord("9")))
		hotbar_index = 8;

	//Left Press
	if (inv_open && mouse_check_button_pressed(mb_left)) {
	    var clicked_index = scr_inv_slot_from_mouse();
	    if (clicked_index != -1) {
	        if (dragging_item == noone) {
	            // Pick up item
	            dragging_item = inventory[clicked_index];
	            inventory[clicked_index] = noone;
	            dragging_index = clicked_index;
	        } else {
	           // --- Place / Merge / Swap ---
	            if (inventory[clicked_index] == noone) {
	                // Empty slot → place
	                inventory[clicked_index] = dragging_item;
	                dragging_item = noone;

	            } else if (inventory[clicked_index].item == dragging_item.item
	                       && global.items[dragging_item.item].stackable) {
	                //Merge stacks
	                var max_stack = global.items[dragging_item.item].max_stack;
	                var space = max_stack - inventory[clicked_index].count;
	                var to_add = min(space, dragging_item.count);

	                inventory[clicked_index].count += to_add;
	                dragging_item.count -= to_add;

	                if (dragging_item.count <= 0) dragging_item = noone;

	            } else {
	                // Different item → swap
	                var temp = inventory[clicked_index];
	                inventory[clicked_index] = dragging_item;
	                dragging_item = temp;
	            }
	        }
	    }
	}
	// Right Press (Split / Merge / Place)
	if (inv_open && mouse_check_button_pressed(mb_right)) {
	    var clicked_index = scr_inv_slot_from_mouse();
	    if (clicked_index != -1) {
	        if (dragging_item == noone) {
	            // --- Split stack in half ---
	            if (inventory[clicked_index] != noone) {
	                var itemClicked = inventory[clicked_index];
	                if (global.items[itemClicked.item].stackable && itemClicked.count > 1) {
	                    var half = floor(itemClicked.count / 2);
	                    dragging_item = { item: itemClicked.item, count: half };
	                    inventory[clicked_index].count -= half;
	                }
	            }
	        } 
			//Right click empty slot to place one item
			else if (dragging_item != noone) 
			{
				if (inventory[clicked_index] == noone)
				{
					inventory[clicked_index] = { item: dragging_item.item, count: 1 };
					dragging_item.count--;
					if (dragging_item.count == 0)
						dragging_item = noone;
				}
				else if (inventory[clicked_index].item == dragging_item.item)
				{
					inventory[clicked_index].count++;
					dragging_item.count--;
					if (dragging_item.count == 0)
						dragging_item = noone;
				}
			}
	    }
	}


	//USE HOTBAR ITEM
	var selected_item = inventory[hotbar_index];
	if (dragging_item != noone)
	{
		selected_item = dragging_item;	
	}
	var mx = mouse_x div 8;
	var my = mouse_y div 8;
	if (quickSelect)
	{
		var blockData = scr_get_quick_select_block();
		mx = blockData.mx;
		my = blockData.my;
	}
	
	if (mouse_check_button(mb_left)) {
		if (selected_item != noone && (!inv_open || (scr_inv_slot_from_mouse() == -1 && !point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), workstation_x, 250, workstation_x+475, 250+300)))) {
	    // Left Click Action
			var dist_x = abs(mx*8 - x);
			var dist_y = abs(my*8 - y);
			var block_in_reach = (dist_x <= block_reach*8 && dist_y <= block_reach*8);
			var blockdist = point_distance(mx*8, my*8, x,y )
		
		

	        if (global.items[selected_item.item].type == "block" 
			&& block_in_reach && (scr_check_place_block_on_self(mx,my) || !global.blocks[global.items[selected_item.item].block_id].solid)
			&& !scr_is_cube_border(mx, my)
			&& (global.blocks[global.items[selected_item.item].block_id].type != "acorn" || global.blocks[global.world[# mx, my+1]].type == "soil")
		
			)
			{
	           scr_place_block(mx,my,selected_item);
	        }
	        else if (global.items[selected_item.item].type == "pickaxe") {
				scr_use_pickaxe(mx,my,selected_item,swingingTool,block_in_reach);
			}
			else if (global.items[selected_item.item].type == "bomb" && mouse_check_button_pressed(mb_left)) {
			    src_use_bomb(selected_item);
			}
			else if (global.items[selected_item.item].type == "axe") {
				scr_use_axe(mx,my,selected_item,swingingTool,block_in_reach);
			}
			else if (global.items[selected_item.item].type == "big block" 
			&& block_in_reach && scr_check_place_block_on_self(mx,my) 
			&& !scr_is_cube_border(mx, my)
			&& (global.blocks[global.items[selected_item.item].block_id].type != "acorn" || global.blocks[global.world[# mx, my+1]].type == "soil")
			)
			{
	           scr_place_big_block(mx,my,selected_item,swingingTool);
	        }
			//BLUEPRINT
			else if (global.items[selected_item.item].type == "blueprint")
			{
				src_use_blueprint(selected_item,swingingTool);
			}
			//HAMMER
			else if (global.items[selected_item.item].type == "hammer")
			{
				src_use_hammer(mx,my,selected_item,swingingTool,block_in_reach);
			}
			else if (global.items[selected_item.item].type == "wall" 
			&& block_in_reach && (scr_check_place_block_on_self(mx,my) || !global.blocks[global.items[selected_item.item].block_id].solid)
			)
			{
	            scr_place_wall(mx,my,selected_item,swingingTool);
	        }
			else if (global.items[selected_item.item].type == "sword")
			{
				scr_use_sword(mx,my,selected_item,swingingTool,block_in_reach);
			}
			else if (global.items[selected_item.item].type == "hoe" && block_in_reach)
			{
				scr_use_hoe(mx,my,selected_item,swingingTool,block_in_reach);
			}
			else if (global.items[selected_item.item].type == "seed" && mouse_check_button_pressed(mb_left))
			{
				scr_use_seed(mx,my,selected_item,swingingTool);
			}
			else if (global.items[selected_item.item].type == "food" && mouse_check_button(mb_left))
			{
				scr_eat_food(foodItem,eat,selected_item);
			}
			else if (global.items[selected_item.item].type == "bucket" && mouse_check_button_pressed(mb_left) && block_in_reach)
			{
				scr_use_bucket(mx,my,selected_item,swingingTool,facing);
			}
			else if (global.items[selected_item.item].type == "watering can" && mouse_check_button_pressed(mb_left))
			{
				scr_use_watering_can(mx,my,selected_item,swingingTool)
			}
		}
	}

	// Drop item (Q)
	if (keyboard_check_pressed(ord("Q"))) {
		if (!inv_open)
		{
		    selected_item = inventory[hotbar_index];

		    if (selected_item != noone) {
		        var drop_id   = selected_item.item;
		        var drop_type = global.items[drop_id];

		        // --- Spawn item entity ---
		        var xx = obj_player.x;
		        var yy = obj_player.y - 8; // spawn slightly above player
		        var inst = instance_create_layer(xx, yy, "Instances", obj_item_entity);
        
		        inst.item_id = drop_id;
		        inst.count   = 1;
				inst.canBePickedUp = false;
				if (variable_instance_exists(selected_item,"blueprint"))
					inst.blueprint = selected_item.blueprint;
				if (variable_instance_exists(selected_item,"water_level"))
					inst.water_level = selected_item.water_level;
				inst.alarm[0] = 25;


		        // Launch based on facing (0 = left, 1 = right)
		        var itemhsp = (obj_player.facing == 0) ? -1 : 1;
		        var itemvsp = -0.5; // small upward throw
		        inst.hsp = itemhsp;
		        inst.vsp = itemvsp;
				inst.impulse_time = 25;

		        // --- Adjust inventory ---
		        if (drop_type.stackable) {
		            selected_item.count -= 1;
		            if (selected_item.count <= 0) {
		                inventory[hotbar_index] = noone;
		            }
		        } else {
		            inventory[hotbar_index] = noone;
		        }
		    }
		}
		else if (dragging_item != noone)
		{
		    var drop_id   = dragging_item.item;
		    var drop_type = global.items[drop_id];

		    // --- Spawn item entity ---
		    var xx = obj_player.x;
		    var yy = obj_player.y - 8; // spawn slightly above player
		    var inst = instance_create_layer(xx, yy, "Instances", obj_item_entity);
        
		    inst.item_id = drop_id;
		    inst.count   = dragging_item.count;
			inst.canBePickedUp = false;
			if (variable_instance_exists(dragging_item,"blueprint"))
				inst.blueprint = dragging_item.blueprint;
			if (variable_instance_exists(dragging_item,"water_level"))
				inst.water_level = dragging_item.water_level;
			inst.alarm[0] = 25;


		    // Launch based on facing (0 = left, 1 = right)
		    var itemhsp = (obj_player.facing == 0) ? -1 : 1;
		    var itemvsp = -0.5; // small upward throw
		    inst.hsp = itemhsp;
		    inst.vsp = itemvsp;
			inst.impulse_time = 25;


		    dragging_item = noone;

		}
	
	}


	//PICK UP MESSAGE UPDATE (ignore feather warning)
	//pickup_messages = [];
	for (var i = 0; i < array_length(pickup_messages); i++) {
	    pickup_messages[i].alpha -= 0.01; // fade speed
	}

	// remove fully transparent messages
	pickup_messages = array_filter(pickup_messages, function(m) {
	    return m.alpha > 0;
	});

	//Search bar check
	scr_check_search_bar(60,250)
}

if (obj_stat_manager.hp <= 0 && alive)
{
	alive=false;
	alarm[4]=250;
	
	for (var i = 0; i < irandom_range(8,12); i++)
	{
		instance_create_depth(x,y,-1,obj_blood);
		var index = irandom_range(0,total_size-1);
		var item = inventory[index]
		if (item != noone)
		{
			var drop_id   = item.item;
			var drop_type = global.items[drop_id];

			var xx = obj_player.x;
			var yy = obj_player.y - 8; // spawn slightly above player
			var inst = instance_create_layer(xx, yy, "Instances", obj_item_entity);
        
			inst.item_id = drop_id;
			inst.count   = item.count;
			inst.canBePickedUp = false;
			if (variable_instance_exists(item,"blueprint"))
				inst.blueprint = item.blueprint;
			if (variable_instance_exists(item,"water_level"))
				inst.water_level = item.water_level;
			inst.alarm[0] = 25;


			var itemhsp = random_range(-1,1);
			var itemvsp = random_range(-0.1,-0.9);
			inst.hsp = itemhsp;
			inst.vsp = itemvsp;
			inst.impulse_time = 25;
			
			inventory[index] = noone;
		}
	}
	
	
}
