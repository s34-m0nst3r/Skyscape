function scr_inventory_left_click(total_size,dragging_item,inventory){
	var clicked_index = scr_inv_slot_from_mouse();
	if (clicked_index != -1 && clicked_index < total_size) {
		if (keyboard_check(vk_shift) && other.storage != noone && inventory[clicked_index] != noone)
		{
			var firstSpace = -1;
			for (var i = 0; i < array_length(other.storage); i++)
			{
				if (firstSpace == -1 && other.storage[i] == noone)	
					firstSpace = i;
				else if (other.storage[i] != noone && other.storage[i].item == inventory[clicked_index].item && global.items[other.storage[i].item].stackable && other.storage[i].count + inventory[clicked_index].count <= global.items[other.storage[i].item].max_stack)
				{
					//Shift click item from inventory into storage (item already exists in storage)
					other.storage[i].count += inventory[clicked_index].count;
					other.inventory[clicked_index] = noone;
					firstSpace = -1;
					break;
				}
			}
			
			if (firstSpace != -1)
			{
				//Shift click item from inventory into first available storage space
				other.storage[firstSpace] = inventory[clicked_index]
				other.inventory[clicked_index] = noone;
			}
		}
	    else if (dragging_item == noone) {
	        //Pick up item
	        other.dragging_item = inventory[clicked_index];
	        other.inventory[clicked_index] = noone;
	        other.dragging_index = clicked_index;
	    } else {
	        // --- Place / Merge / Swap ---
	        if (inventory[clicked_index] == noone) {
	            //Empty slot -> place
	            other.inventory[clicked_index] = dragging_item;
	            other.dragging_item = noone;

	        } else if (inventory[clicked_index].item == dragging_item.item
	                    && global.items[dragging_item.item].stackable) {
	            //Merge stacks
	            var max_stack = global.items[dragging_item.item].max_stack;
	            var space = max_stack - inventory[clicked_index].count;
	            var to_add = min(space, dragging_item.count);

	            other.inventory[clicked_index].count += to_add;
	            other.dragging_item.count -= to_add;

	            if (dragging_item.count <= 0) other.dragging_item = noone;

	        } else {
	            //Different item -> swap
	            var temp = inventory[clicked_index];
	            other.inventory[clicked_index] = dragging_item;
	            other.dragging_item = temp;
	        }
	    }
	}
	//STORAGE
	else if (clicked_index >= total_size)
	{		
		var storage_index = clicked_index - total_size;
		if (keyboard_check(vk_shift) && other.storage != noone && storage[storage_index] != noone)
		{
			var firstSpace = -1;
			for (var i = 0; i < total_size; i++)
			{
				if (firstSpace == -1 && other.inventory[i] == noone)	
					firstSpace = i;
				else if (other.inventory[i] != noone && other.inventory[i].item == storage[storage_index].item && global.items[other.inventory[i].item].stackable && other.inventory[i].count + storage[storage_index].count <= global.items[other.inventory[i].item].max_stack)
				{
					//Shift click item from storage into inventory (item already exists in inventory)
					other.inventory[i].count += storage[storage_index].count;
					other.storage[storage_index] = noone;
					firstSpace = -1;
					break;
				}
			}
			
			if (firstSpace != -1)
			{
				//Shift click item from storage into first available inventory space
				other.inventory[firstSpace] = storage[storage_index]
				other.storage[storage_index] = noone;
			}
		}
		else if (dragging_item == noone) {
	        // Pick up item
	        other.dragging_item = storage[storage_index];
	        other.storage[storage_index] = noone;
			other.dragging_index = clicked_index;
	    } else {
	        // --- Place / Merge / Swap ---
	        if (storage[storage_index] == noone) {
	            //Empty slot -> place
	            other.storage[storage_index] = dragging_item;
				 other.dragging_item = noone;

	        } else if (storage[storage_index].item == dragging_item.item
	                    && global.items[dragging_item.item].stackable) {
	            //Merge stacks
	            var max_stack = global.items[dragging_item.item].max_stack;
	            var space = max_stack - storage[storage_index].count;
	            var to_add = min(space, dragging_item.count);

	            other.storage[storage_index].count += to_add;
				other.dragging_item.count -= to_add;

	            if (dragging_item.count <= 0) other.dragging_item = noone;

	        } else {
	            //Different item -> swap
	            var temp = storage[storage_index];
	            other.storage[storage_index] = dragging_item;
				other.dragging_item = temp;
	        }
	    }
	}
}