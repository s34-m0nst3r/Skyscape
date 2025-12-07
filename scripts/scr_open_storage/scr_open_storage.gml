function scr_open_storage(storage_size){
	var mx = mouse_x div 8;
	var my = mouse_y div 8;
	var source = scr_get_big_block_source(mx,my);
	var gx = source.xcord;
	var gy = source.ycord;
	
	//If no storage variable for block
	if (!variable_instance_exists(global.blockPointers[# gx,gy],"storage"))
	{
		global.blockPointers[# gx, gy].storage = array_create(storage_size, noone);
		global.blockPointers[# gx,gy].storageIcon = -1;
	}
	
	
	//Open player inventory
	obj_player.inv_open = true;
	obj_player.storage = global.blockPointers[# gx,gy].storage;
	obj_player.storageX = gx;
	obj_player.storageY = gy;
	obj_player.storageName = global.items[global.blocks[global.world[# gx,gy]].item_id].name;
	if (variable_instance_exists(global.blockPointers[# gx,gy],"storageIcon"))
		obj_player.storageIcon = global.blockPointers[# gx,gy].storageIcon;
}