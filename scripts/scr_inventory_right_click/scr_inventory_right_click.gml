function scr_inventory_right_click(total_size,dragging_item,inventory){
	var clicked_index = scr_inv_slot_from_mouse();
	if (clicked_index != -1 && clicked_index < total_size) {
	    if (dragging_item == noone) {
	        // --- Split stack in half ---
	        if (inventory[clicked_index] != noone) {
	            var itemClicked = inventory[clicked_index];
	            if (global.items[itemClicked.item].stackable && itemClicked.count > 1) {
	                var half = floor(itemClicked.count / 2);
	                other.dragging_item = { item: itemClicked.item, count: half };
	                other.inventory[clicked_index].count -= half;
	            }
	        }
	    } 
		//Right click empty slot to place one item
		else if (dragging_item != noone) 
		{
			if (inventory[clicked_index] == noone)
			{
				other.inventory[clicked_index] = { item: dragging_item.item, count: 1 };
				other.dragging_item.count--;
				if (other.dragging_item.count == 0)
					other.dragging_item = noone;
			}
			else if (inventory[clicked_index].item == dragging_item.item)
			{
				other.inventory[clicked_index].count++;
				other.dragging_item.count--;
				if (other.dragging_item.count == 0)
					other.dragging_item = noone;
			}
		}
	}
	//STORAGE
	else if (clicked_index >= total_size)
	{
		var storage_index = clicked_index - total_size;
		
		if (dragging_item == noone) {
	        // --- Split stack in half ---
	        if (storage[storage_index] != noone) {
	            var itemClicked = storage[storage_index];
	            if (global.items[itemClicked.item].stackable && itemClicked.count > 1) {
	                var half = floor(itemClicked.count / 2);
	                other.dragging_item = { item: itemClicked.item, count: half };
	                other.storage[storage_index].count -= half;
					//global.blockPointers[# other.storageX,other.storageY].storage[storage_index].count -= half;
	            }
	        }
	    } 
		//Right click empty slot to place one item
		else if (dragging_item != noone) 
		{
			if (storage[storage_index] == noone)
			{
				other.storage[storage_index] = { item: dragging_item.item, count: 1 };
				//global.blockPointers[# other.storageX,other.storageY].storage[storage_index] = { item: dragging_item.item, count: 1 };
				other.dragging_item.count--;
				if (other.dragging_item.count == 0)
					other.dragging_item = noone;
			}
			else if (storage[storage_index].item == dragging_item.item)
			{
				other.storage[storage_index].count++;
				//global.blockPointers[# other.storageX,other.storageY].storage[storage_index].count++;
				
				other.dragging_item.count--;
				if (other.dragging_item.count == 0)
					other.dragging_item = noone;
			}
		}
	}
}