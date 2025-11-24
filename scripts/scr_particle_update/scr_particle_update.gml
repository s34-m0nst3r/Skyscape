function scr_particle_update(){

	for (var i = 0; i < array_length(global.particleBlocks); i++)
	{
		//Check if block is still valid
		if (!variable_instance_exists(global.blocks[global.world[# global.particleBlocks[i].xp, global.particleBlocks[i].yp]],"particle"))
		{
			array_delete(global.particleBlocks,i,1);
			i--;
		}
		//Spawn particle on a chance
		else if (irandom_range(0,2000/global.particleBlocks[i].particle_rate) == 2 && abs(global.particleBlocks[i].xp*8-obj_player.x) < 300 && abs(global.particleBlocks[i].yp*8-obj_player.y) < 300)
		{
			instance_create_depth
			(global.particleBlocks[i].xp*8+random_range(0,8)
			,global.particleBlocks[i].yp*8+random_range(0,8)
			,-30,global.blocks[global.world[# global.particleBlocks[i].xp, global.particleBlocks[i].yp]].particle);
			
		}
		
	}

}