function scr_add_item(item_id, count,blueprint,water_level){

//First try stacking
for (var i = 0; i < array_length(inventory); i++) {
    var slot = inventory[i];
    if (slot != noone) {
        if (slot.item == item_id && global.items[item_id].stackable) {
            var can_add = min(global.items[item_id].max_stack - slot.count, count);
            slot.count += can_add;
            count -= can_add;
            inventory[i] = slot;
            if (count <= 0) exit;
        }
    }
}

//Put in empty slots
for (var i = 0; i < array_length(inventory); i++) {
    if (inventory[i] == noone) {
		var new_slot;
		if (blueprint != -1)
			new_slot = { item: item_id, count: count, blueprint: blueprint };
		else if (water_level != -1)
			new_slot = { item: item_id, count: count, water_level: water_level};
		else
			new_slot = { item: item_id, count: count };
        inventory[i] = new_slot;
        count = 0;
        break;
    }
}

}