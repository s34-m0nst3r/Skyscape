function scr_open_workstation(workstation){

	//Open the inventory if it is not already open
	obj_player.inv_open = true;
	obj_player.craftingMinimized = false;
	obj_player.workstation = workstation;
	obj_player.workstation_x = 60;
}