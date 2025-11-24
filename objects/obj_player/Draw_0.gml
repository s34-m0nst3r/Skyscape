
if (alive)
{
	var mx = mouse_x div 8;
	var my = mouse_y div 8;
	if (quickSelect)
	{
		var blockData = scr_get_quick_select_block();
		mx = blockData.mx;
		my = blockData.my;
	}
	//DRAW ITEM PICKUPS
	var base_x = x;
	var base_y = y-20;
	for (var i = 0; i < array_length(pickup_messages); i++) {
	    var msg = pickup_messages[i];
	    var yy = base_y - (array_length(pickup_messages) - 1 - i) * 10;

	    draw_set_halign(fa_center);
	    draw_set_valign(fa_middle);

	    draw_set_alpha(msg.alpha);
	    draw_set_color(c_white);
		if (msg.count > 1)
			draw_text_ext_transformed(base_x, yy, msg.text + "(" + string(msg.count) + ")",10,500,0.5,0.5,0);
		else
			draw_text_ext_transformed(base_x, yy, msg.text,10,500,0.5,0.5,0);
		draw_set_alpha(1);
	}
	draw_set_alpha(1); // reset

	//If hover over a block with a right click
	var mxstart = mx;
	var mystart = my;
	//Check for reserved block
	if (global.world[# mx, my] == 13)
	{
		var mx2 = global.blockPointers[# mx, my].xcord;
		var my2 = global.blockPointers[# mx, my].ycord;	
		mx = mx2;
		my = my2;
	}
	var dist_x = abs(mx*8 - x);
	var dist_y = abs(my*8 - y);
	var block_in_reach = (dist_x <= block_reach*8 && dist_y <= block_reach*8);
	
		//On right click run the hover script
	if (block_in_reach && mouse_check_button_pressed(mb_right) && variable_instance_exists(global.blocks[global.world[# mx, my]], "hoverScript"))
	{
		if (variable_instance_exists(global.blocks[global.world[# mx, my]], "hoverScriptCoords") && variable_instance_exists(global.blocks[global.world[# mx, my]], "hoverParam"))
		{
			global.blocks[global.world[# mx, my]].hoverScript(mx,my,global.blocks[global.world[# mx, my]].hoverParam);
		}
		else if (variable_instance_exists(global.blocks[global.world[# mx, my]], "hoverParam"))
			global.blocks[global.world[# mx, my]].hoverScript(global.blocks[global.world[# mx, my]].hoverParam);
		else
			global.blocks[global.world[# mx, my]].hoverScript();
	}
	
	if (variable_instance_exists(global.blocks[global.world[# mx, my]], "hover") 
	&& block_in_reach && global.block_damage[# mx, my] == 0 && dragging_item == noone)
	{
		gpu_set_fog(true,c_white,0,0);
		draw_sprite_ext(global.blocks[global.world[# mx, my]].sprite,-1,mx*8-1,my*8-1,1,1,0,c_gray,1)
		draw_sprite_ext(global.blocks[global.world[# mx, my]].sprite,-1,mx*8+1,my*8+1,1,1,0,c_gray,1)
		draw_sprite_ext(global.blocks[global.world[# mx, my]].sprite,-1,mx*8+1,my*8-1,1,1,0,c_gray,1)
		draw_sprite_ext(global.blocks[global.world[# mx, my]].sprite,-1,mx*8-1,my*8+1,1,1,0,c_gray,1)
		gpu_set_fog(false,c_white,0,0);
		
		draw_sprite_ext(global.blocks[global.world[# mx, my]].sprite,-1,mx*8,my*8,1,1,0,c_white,1)
		if (variable_instance_exists(global.blocks[global.world[# mx, my]], "hoverText"))
		{
			draw_set_color(c_white);
			draw_text_ext_transformed((mx-1)*8,(my-2)*8,global.blocks[global.world[# mx, my]].hoverText,12,150,0.5,0.5,0);	
		}
		
	}
	else
	{
		mx = mxstart;
		my = mystart;
		var selected_item = inventory[hotbar_index];
		if (dragging_item != noone)
		{
			selected_item = dragging_item;	
		}
		if (selected_item != noone && global.items[selected_item.item].type == "big block" &&  (scr_inv_slot_from_mouse() == -1 && !point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), workstation_x, 250, workstation_x+475, 250+300))) {
			var spr;
			var scale;
			var sw;
			var sh;
			var block;
			block = global.blocks[global.items[selected_item.item].block_id]

			spr = block.sprite;	
			sw = sprite_get_width(spr);
			sh = sprite_get_height(spr);
			scale = 1;
			mx = floor(mouse_x / 8)*8;
			my = floor(mouse_y / 8)*8;
			if (quickSelect)
			{
				var blockData = scr_get_quick_select_block();
				mx = blockData.mx;
				my = blockData.my;
			}
			if (variable_instance_exists(block,"rotable") && facing == 0)
				draw_sprite_ext(spr, 0, mx+8, my, scale*-1, scale, 0, c_white, 1);
			else
				draw_sprite_ext(spr, 0, mx, my, scale, scale, 0, c_white, 1);
	
			if (global.items[selected_item.item].stackable && selected_item.count > 1) {
				draw_set_color(c_white);
				draw_text(device_mouse_x_to_gui(0)-16, device_mouse_y_to_gui(0)+4, string(selected_item.count));
			}
	
			//Draw bigger box
			mx = mouse_x div 8;
			my = mouse_y div 8;
			if (quickSelect)
			{
				var blockData = scr_get_quick_select_block();
				mx = blockData.mx;
				my = blockData.my;
			}

			// Draw block highlight for reach
			dist_x = abs(mx*8 - x);
			dist_y = abs(my*8 - y);
			block_in_reach = (dist_x <= block_reach*8 && dist_y <= block_reach*8);
			if (block_in_reach) {
				var bx = mx * 8;
				var by = my * 8;
				if (!quickSelect)
					draw_set_color(c_white);
				else
					draw_set_color(c_aqua);
				draw_set_alpha(1);
	
				draw_rectangle(bx, by, bx+(8*global.blocks[global.items[selected_item.item].block_id].xsize), by+(8*global.blocks[global.items[selected_item.item].block_id].ysize), true); // outline
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
	

		}
		else
		{

			mx = mouse_x div 8;
			my = mouse_y div 8;
			if (quickSelect)
			{
				var blockData = scr_get_quick_select_block();
				mx = blockData.mx;
				my = blockData.my;
			}

			// Draw block highlight for reach
			var dist_x = abs(mx*8 - x);
			var dist_y = abs(my*8 - y);
			var block_in_reach = (dist_x <= block_reach*8 && dist_y <= block_reach*8);
			if (block_in_reach) {
				var bx = mx * 8;
				var by = my * 8;
				if (!quickSelect)
					draw_set_color(c_white);
				else
					draw_set_color(c_aqua);
				draw_set_alpha(1);
	
				draw_rectangle(bx, by, bx+8, by+8, true); // outline
				draw_set_color(c_white);
				draw_set_alpha(1);
			}
		}
	}



	if (dragging_item != noone && global.items[dragging_item.item].type != "big block")
	{
		mx = mouse_x div 8;
		my = mouse_y div 8;
		if (quickSelect)
		{
			var blockData = scr_get_quick_select_block();
			mx = blockData.mx;
			my = blockData.my;
		}

		// Draw block highlight for reach
		var dist_x = abs(mx*8 - x);
		var dist_y = abs(my*8 - y);
		var block_in_reach = (dist_x <= block_reach*8 && dist_y <= block_reach*8);
		if (block_in_reach) {
			var bx = mx * 8;
			var by = my * 8;
			draw_set_color(c_white);
			draw_set_alpha(1);
	
			draw_rectangle(bx, by, bx+8, by+8, true); // outline
			draw_set_alpha(1);
		}
	}
	draw_set_color(c_white);
	//draw_self();
}

