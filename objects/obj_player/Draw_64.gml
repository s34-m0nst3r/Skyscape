/// === Inventory GUI Draw ===
if (alive)
{
    var _draw_old_color  = draw_get_color();
    var _draw_old_alpha  = draw_get_alpha();

    // Config
    var slot_size = 32;
    var padding   = 4;
    var slot_step = slot_size + padding;           // CACHE: used repeatedly
    var border_cyan = make_color_rgb(0, 200, 200);
    var border_green = c_lime;

    // small offsets used for stack count drawing (defined once)
    var xoff = -20;
    var yoff = -5;

    // === Cache GUI mouse coords used often ===
    // CACHE: avoid repeated device_mouse_x_to_gui()/y calls
    var gui_mx = device_mouse_x_to_gui(0);
    var gui_my = device_mouse_y_to_gui(0);

    // === Draw Hotbar ===
    for (var i = 0; i < hotbar_size; i++) {
        var xx = 20 + i * slot_step;
        var yy = 20; // top left corner of screen

        // Normal slot background (transparent gray fill)
        draw_set_alpha(0.3);
        draw_rectangle_color(xx, yy, xx+slot_size, yy+slot_size, c_black, c_black, c_black, c_black, false);

        // Cyan border
        draw_set_alpha(0.8);
        draw_rectangle_color(xx, yy, xx+slot_size, yy+slot_size, border_cyan, border_cyan, border_cyan, border_cyan, true);

        // Highlight if selected
        if (i == hotbar_index) {
            var expand = 3; // makes slot slightly larger
            draw_set_alpha(1);
            draw_rectangle_color(xx-expand, yy-expand, xx+slot_size+expand, yy+slot_size+expand, border_green, border_green, border_green, border_green, true);
        }

        // Draw item inside slot
        var item = inventory[i];
        if (item != noone) {
            var spr = global.items[item.item].sprite;

            // CACHE: query sprite sizes once
            var sw = sprite_get_width(spr);
            var sh = sprite_get_height(spr);

            // scale sprite to fit slot
            var scale = min(slot_size / sw, slot_size / sh);

            draw_set_alpha(1);
            // DRAW ITEM SPRITE
            draw_sprite_ext(spr, 0, xx+slot_size/2, yy+slot_size/2, scale, scale, 0, c_white, 1);

            // CACHE: blueprint check only once per item
            if (variable_instance_exists(item,"blueprint"))
                draw_sprite_ext(global.items[item.blueprint].sprite, 0, xx+slot_size/2, yy+slot_size/2, scale, scale, 0, c_white, 0.8);

            // draw stack count
            if (global.items[item.item].stackable && item.count > 1) {
                draw_set_alpha(1);
                draw_set_color(c_white);
                draw_text(xx+slot_size-12+xoff, yy+slot_size-12+yoff, string(item.count));
            }
        }
    }

    // === Draw Main Inventory if open ===
    if (inv_open) {
        for (var i = 0; i < main_size; i++) {
            var col = i mod 10;
            var row = i div 10;

            var xx = 20 + col * slot_step;
            var yy = 20 + slot_size + padding + row * slot_step; // stacked under hotbar

            // Background
            draw_set_alpha(0.3);
            draw_rectangle_color(xx, yy, xx+slot_size, yy+slot_size, c_black, c_black, c_black, c_black, false);

            // Cyan border
            draw_set_alpha(0.8);
            draw_rectangle_color(xx, yy, xx+slot_size, yy+slot_size, border_cyan, border_cyan, border_cyan, border_cyan, true);

            // Item
            var item = inventory[hotbar_size + i];
            if (item != noone) {
                var spr = global.items[item.item].sprite;

                // CACHE: query sprite sizes once
                var sw = sprite_get_width(spr);
                var sh = sprite_get_height(spr);

                var scale = min(slot_size / sw, slot_size / sh);
                draw_set_alpha(1);
                draw_sprite_ext(spr, 0, xx+slot_size/2, yy+slot_size/2, scale, scale, 0, c_white, 1);

                if (variable_instance_exists(item,"blueprint"))
                    draw_sprite_ext(global.items[item.blueprint].sprite, 0, xx+slot_size/2, yy+slot_size/2, scale, scale, 0, c_white, 0.8);

                if (global.items[item.item].stackable && item.count > 1) {
                    draw_set_color(c_white);
                    draw_text(xx+slot_size-12+xoff, yy+slot_size-12+yoff, string(item.count));
                }
            }
        }
    }


    // === Tooltip / Item Info ===

    // when inventory closed: show hotbar item name
    if (!inv_open) {
        var selected_item = inventory[hotbar_index];
        if (selected_item != noone) {
            var item_def = global.items[selected_item.item];

            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            var xx = 100 + hotbar_index * (slot_size+4) + 16; // center of slot
            var yy = display_get_gui_height() - 50 - 650; // above slot
            draw_set_color(c_white);

            if (variable_instance_exists(selected_item,"blueprint"))
            {
                draw_text(xx-40, yy, item_def.name + ": " + global.items[selected_item.blueprint].name);
            }
            else
            {
                draw_text(xx-40, yy, item_def.name);
            }
            draw_set_halign(fa_center);
            draw_set_valign(fa_top);
        }

    }

    //DRAW BAG
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    var bag_x = 10;
    var bag_y = 700;
    var bag_w = 64;
    var bag_h = 64;

    // Check if mouse is hovering over bag (use cached gui_mx/gui_my)
    var hover = (gui_mx > bag_x && gui_mx < bag_x + bag_w &&
                    gui_my > bag_y && gui_my < bag_y + bag_h);
    var spr_to_draw = hover ? spr_bag_ui_hover : spr_bag_ui;
    draw_sprite_ext(spr_to_draw, -1, bag_x, bag_y, 1, 1, 0, c_white, 1);
    if (hover) {
        draw_text(bag_x + bag_w/2, bag_y - 10, "Bag(ESC)");
        if (mouse_check_button_pressed(mb_left))
            inv_open = !inv_open;
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // when inventory open: hover tooltip
    if (inv_open) {
        var hover_index = scr_inv_slot_from_mouse();
        if (hover_index != -1) {
            var hover_item = inventory[hover_index];
            if (hover_item != noone) {
                var item_def = global.items[hover_item.item];

				var extraSpace = 0;
                var info = item_def.name;
                if (variable_instance_exists(hover_item,"blueprint"))
                    info += ": " + global.items[hover_item.blueprint].name;
                if (variable_instance_exists(item_def, "melee_damage")) {
                    info +=  "\n" + src_format_one_dec(item_def.melee_damage) + " Melee Damage";
                }
                if (variable_instance_exists(item_def, "description")) {
                    info += "\n" + item_def.description;
                }
                if (variable_instance_exists(item_def, "mining_power")) {
                    info += "\nMining Power: " + src_format_one_dec(item_def.mining_power);
                }
                if (variable_instance_exists(item_def, "woodcutting_power")) {
                    info += "\nWoodcutting Power: " + src_format_one_dec(item_def.woodcutting_power);
                }
                if (variable_instance_exists(item_def, "hammer_power")) {
                    info += "\nHammer Power: " + src_format_one_dec(item_def.hammer_power);
                }
                if (variable_instance_exists(item_def, "hunger")) {
                    info += "\nRestores " + string(item_def.hunger) + " hunger";
                }
				if (variable_instance_exists(item_def, "max_water")) {
                    extraSpace+=16;
                }

                // draw near mouse (use cached gui_mx/gui_my)
                var mx = gui_mx + 16;
                var my = gui_my + 16;
                var halign = draw_get_halign();
                var valign = draw_get_valign();
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);

                draw_set_color(c_black);
                draw_rectangle(mx-2, my-2, mx+300, my+string_height(info)+2+extraSpace, false);
                draw_set_color(c_white);
                draw_text(mx, my, info);
			
                draw_set_valign(fa_middle);
				
				// === Draw water info (if item has max_water) ===
                if (variable_instance_exists(item_def, "max_water"))
                {
                    var water_y = my + string_height(info) + 6;

                    // draw water drop sprite
                    draw_sprite_ext(spr_water_drop, 0, mx+8, water_y, 1, 1, 0, c_white, 1);

                    // draw max_water value
                    draw_text(mx + sprite_get_width(spr_water_drop) + 4, water_y, string(hover_item.water_level) + "/" + string(item_def.max_water));
                }


                draw_set_valign(valign);
            }
        }
    }
    if (inv_open)
    {
        displayCraftingHover = false;
        scr_draw_crafting_menu(workstation_x,250,workstation);

        // CACHE mouse pos for crafting tooltip work
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);

        var ingredientLocations = [];
        if (displayCraftingHover)
        {
            var recipe = global.recipes[craftingHover];
            var item_def = global.items[recipe.item_id];
			var extraSpace = 0;

            // === Collect info strings ===
            var baseInfo = item_def.name;
            if (variable_instance_exists(item_def, "melee_damage")) {
                baseInfo +=  "\n" + src_format_one_dec(item_def.melee_damage) + " Melee Damage";
            }
            if (variable_instance_exists(item_def, "description")) {
                baseInfo += "\n" + item_def.description;
            }
            if (variable_instance_exists(item_def, "mining_power")) {
                baseInfo += "\nMining Power: " + src_format_one_dec(item_def.mining_power);
            }
            if (variable_instance_exists(item_def, "woodcutting_power")) {
                baseInfo += "\nWoodcutting Power: " + src_format_one_dec(item_def.woodcutting_power);
            }
            if (variable_instance_exists(item_def, "hammer_power")) {
                baseInfo += "\nHammer Power: " + src_format_one_dec(item_def.hammer_power);
            }
            if (variable_instance_exists(item_def, "hunger")) {
                baseInfo += "\nRestores " + string(item_def.hunger) + " hunger";
            }
			if (variable_instance_exists(item_def, "max_water")) {
                extraSpace+=16;
            }

            // === Draw background box ===
            var box_w = 300;
            var line_h = 18; // spacing per line
            var box_h = string_height(baseInfo) + ((array_length(recipe.ingredients)+2) * line_h) + 16 + extraSpace;

            draw_set_color(c_black);
            draw_set_alpha(1);
            draw_rectangle(mx+14, my+14, mx+14+box_w, my+14+box_h, false);

            // === Draw main info ===
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(mx+16, my+16, baseInfo);
            draw_set_valign(fa_middle);
			
			// === Draw water info (if item has max_water) ===
            if (variable_instance_exists(item_def, "max_water"))
            {
                var water_y = my + string_height(baseInfo) + 6;

                // draw water drop sprite
                draw_sprite_ext(spr_water_drop, 0, mx+24, water_y+20, 1, 1, 0, c_white, 1);

                // draw max_water value
                draw_text(mx + sprite_get_width(spr_water_drop) + 4+16, water_y+20,string(0)+ "/" + string(item_def.max_water));
            }
            draw_set_valign(fa_top);
            // === Draw ingredient list ===
            var yy = my + 16 + string_height(baseInfo) + 8 + extraSpace;
            draw_text(mx+16, yy, "Ingredients:");
            yy += line_h;

            //Check if the player has the valid items for the recipe.
            var canCraft = false;

            // For each ingredient, search inventory - stop early when a matching slot is found
            for (var i = 0; i < array_length(recipe.ingredients); i++) {
                var ing = recipe.ingredients[i];
                var itemid = ing[0];
                var need = ing[1];
                var foundSlot = false;
                for (var j = 0; j < array_length(inventory); j++)
                {
                    if (inventory[j] != noone && inventory[j].item == itemid && inventory[j].count >= need)
                    {
                        array_push(ingredientLocations,{j,need});
                        foundSlot = true;
                        break; // CACHE: stop scanning inventory for this ingredient once found
                    }
                }
                // don't set canCraft true until we've collected all ingredientLocations
            }
            if (array_length(ingredientLocations) == array_length(recipe.ingredients))
                canCraft = true;

            for (var i = 0; i < array_length(recipe.ingredients); i++) {
                var ing = recipe.ingredients[i]; 
                // expecting {item_id, amount}
                var ing_def = global.items[ing[0]];

                // draw sprite
                draw_sprite_ext(ing_def.sprite, -1, mx+25, yy+12, 1, 1, 0, c_white, 1);

                // draw text (amount + name)
                var ing_text = string(ing[1]) + "x " + ing_def.name;
                draw_text(mx+40, yy, ing_text);

                yy += line_h;
            }
            if (canCraft)
            {
                draw_set_color(c_lime)
                draw_text(mx+16, yy, "Craftable");
            }
            else
            {
                draw_set_color(c_red)
                draw_text(mx+16, yy, "Not Craftable");
            }

            // restore align
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);

            if (canCraft && !craftingMinimized && (dragging_item == noone || dragging_item.item == recipe.item_id) && (mouse_check_button_pressed(mb_left) || (mouse_check_button(mb_right) && !craftDelay)))
            {
				craftDelay = true;
				alarm[5]=5;
                //SET RECIPE TO UNLOCKED
                global.recipes[craftingHover].unlocked = true;

                for (var i = 0; i < array_length(ingredientLocations); i++)
                {
                    inventory[ingredientLocations[i].j].count -= ingredientLocations[i].need;

                    if (inventory[ingredientLocations[i].j].count == 0)
                        inventory[ingredientLocations[i].j] = noone;
                }
                //set item to dragging
                if (dragging_item == noone)
				{
					if (variable_instance_exists(global.items[recipe.item_id],"max_water"))
						dragging_item = {item: recipe.item_id, count: recipe.count, water_level : 0};
					else
						dragging_item = {item: recipe.item_id, count: recipe.count };
				}
                else
                    dragging_item.count+=recipe.count;
            }
        }

    }


    // === Cursor Drawing ===
    var selected_item = inventory[hotbar_index];

    // Re-cache mouse pos for cursor drawing (use earlier cached gui_mx/gui_my where possible)
    var cursor_x = device_mouse_x_to_gui(0);
    var cursor_y = device_mouse_y_to_gui(0);

    if (dragging_item != noone && (global.items[dragging_item.item].type != "big block" ||  !(scr_inv_slot_from_mouse() == -1 && !point_in_rectangle(cursor_x, cursor_y, workstation_x, 250, workstation_x+475, 250+300)))) {
        draw_set_alpha(1);
        var spr = global.items[dragging_item.item].sprite;
        var sw = sprite_get_width(spr);
        var sh = sprite_get_height(spr);
        var scale = min(slot_size / sw, slot_size / sh);

        draw_sprite_ext(spr, 0, cursor_x, cursor_y, scale, scale, 0, c_white, 1);
        if (variable_instance_exists(dragging_item,"blueprint"))
            draw_sprite_ext(global.items[dragging_item.blueprint].sprite, 0, cursor_x, cursor_y, scale, scale, 0, c_white, 0.8);
            
		draw_set_color(c_white);
        if (global.items[dragging_item.item].stackable && dragging_item.count > 1) 
		{
            draw_text(cursor_x-16, cursor_y+4, string(dragging_item.count));
        }
		else if (variable_instance_exists(dragging_item,"water_level") && variable_instance_exists(global.items[dragging_item.item],"max_water"))
		{
			draw_sprite_ext(spr_water_drop,-1,cursor_x-16,cursor_y+13,1,1,0,c_white,1);
			draw_text(cursor_x-8, cursor_y+4, string(dragging_item.water_level) + "/" + string(global.items[dragging_item.item].max_water));
		}
    }
    else if (selected_item != noone && !inv_open) {
        draw_set_alpha(1);
        var spr;
        var scale;
        var sw;
        var sh;
        if (global.items[selected_item.item].type != "big block")
        {
            spr = global.items[selected_item.item].sprite;
            sw = sprite_get_width(spr);
            sh = sprite_get_height(spr);
            scale = min(slot_size / sw, slot_size / sh);
            draw_sprite_ext(spr, 0, cursor_x, cursor_y, scale, scale, 0, c_white, 1);
            //Blueprint drawing
            if (variable_instance_exists(selected_item,"blueprint"))
                draw_sprite_ext(global.items[selected_item.blueprint].sprite, 0, cursor_x, cursor_y, scale, scale, 0, c_white, 0.8);

            draw_set_color(c_white);
            if (global.items[selected_item.item].stackable && selected_item.count > 1) {
                draw_text(cursor_x-16, cursor_y+4, string(selected_item.count));
            }
			else if (variable_instance_exists(selected_item,"water_level"))
			{
				draw_sprite_ext(spr_water_drop,-1,cursor_x-16,cursor_y+13,1,1,0,c_white,1);
				draw_text(cursor_x-8, cursor_y+4, string(selected_item.water_level) + "/" + string(global.items[selected_item.item].max_water));
			}
        }


    }
    else if (dragging_item == noone){
        draw_set_alpha(1);
        draw_sprite(spr_cursor, 0, cursor_x, cursor_y);
    }

    draw_set_color(c_white);

    draw_set_color(_draw_old_color);
    draw_set_alpha(_draw_old_alpha);
}
if (!alive)
{
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_text_ext_transformed(700,300,deathMessage,10,500,4,4,0);    
    draw_set_color(c_black);
    draw_set_halign(fa_left);
}
