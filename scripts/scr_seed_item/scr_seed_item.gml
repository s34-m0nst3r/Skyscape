function scr_seed_item(seed_id){

	switch (seed_id)
	{
		case 0:
			//GRASS SEEDS
			for (var i = 0; i < irandom_range(2,5); i++)
			{
				var seed = instance_create_depth(obj_player.x,obj_player.y-5,-1,obj_seed);
				var scale = random_range(0.5,1.1);
				seed.image_xscale=scale;
				seed.image_yscale=scale;
				seed.image_blend = c_green;
				seed.seedtype = 0;
				if (obj_player.facing == 0)
					seed.hsp = -0.5 - random_range(0.3,1.5);
				if (obj_player.facing == 1)
					seed.hsp = 0.5 + random_range(0.3,1.5);
					
				seed.vsp= -2 + random_range(0.3,1.5);
				
			}
			
			break;
		
	}
}