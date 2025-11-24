function scr_reduce_count(selected_item){
	
	if (obj_player.dragging_item != noone)
	{
		obj_player.dragging_item.count--;	
		if (obj_player.dragging_item.count <= 0) dragging_item = noone;
	}
	else if (global.items[selected_item.item].stackable) {
		//Reduce this instance of the item by 1
        selected_item.count -= 1;
        if (selected_item.count <= 0) inventory[hotbar_index] = noone;
    }
	else if (!global.items[selected_item.item].stackable)
	{
		inventory[hotbar_index] = noone;
	}

}