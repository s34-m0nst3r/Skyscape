function src_use_bomb(selected_item){
	// Throw a bomb
		var bomb = instance_create_layer(x, y, "Instances", obj_projectile_bomb);
		bomb.owner = id;
		bomb.item_id = selected_item.item;
		bomb.blockid =global.items[selected_item.item].block_id;
		if (variable_instance_exists(global.items[selected_item.item],"second_block_id"))
			bomb.secondblockid=global.items[selected_item.item].second_block_id;

		// Calculate direction towards mouse
		var dir = point_direction(x, y, mouse_x, mouse_y);
		var bombspd = 2.5; // tweak for strength
		bomb.hsp = lengthdir_x(bombspd, dir);
		bomb.vsp = lengthdir_y(bombspd, dir) - 4; // small upward arc
		bomb.sprite_index = global.items[selected_item.item].sprite;

		scr_reduce_count(selected_item);
}