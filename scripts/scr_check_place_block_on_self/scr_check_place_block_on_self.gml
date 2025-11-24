function scr_check_place_block_on_self(){
	var mx = argument0;
	var my = argument1;
	if (!position_meeting(mx*8, my*8, obj_player)  //Top left corner
	&& !position_meeting(mx*8+7, my*8, obj_player) //Top right corner
	&& !position_meeting(mx*8, my*8+7, obj_player) //Bottom right corner
	&& !position_meeting(mx*8+7, my*8+7, obj_player) //Bottom left corner
	)
		return true;
	
	return false;
	

}