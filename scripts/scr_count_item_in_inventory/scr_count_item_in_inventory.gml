function scr_count_item_in_inventory(item){
	var _id = item;
	var total = 0;
    for (var i = 0; i < array_length(inventory); i++) {
        var slot = inventory[i];
        if (slot != noone) {
            if (slot.item == _id) total += slot.count;
        }
    }
    return total;
}