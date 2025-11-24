function scr_spawn_clouds(){

	//LINE 1
	for (var i = -500; i < 500; i+=15)
	{
		//J IS EACH CLOUD LAYER HORIZONTALLY
		for (var j = 0; j <= 1; j++)
		{
			var nearestCloud = instance_nearest(obj_player.x+i, room_height/2-250-(200*j), obj_cloud);
			if (nearestCloud != noone)
			{
			    var dist = point_distance(obj_player.x+i, room_height/2-250-(200*j), nearestCloud.x, nearestCloud.y);
				if (dist > 70)
					instance_create_depth(obj_player.x+i+random_range(-80,80),room_height/2-250-(200*j)+random_range(-100,80),10,obj_cloud);
			}
			else
			{
			    //NO CLOUD EXISTS
				instance_create_depth(obj_player.x+i+random_range(-80,80),room_height/2-250-(200*j)+random_range(-100,80),10,obj_cloud);
			}
		}
		
	}
}