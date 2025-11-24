if (obj_player.alive)
{
	hp-=5;
	decay_damage=false;
	var text = instance_create_depth(obj_player.x,obj_player.y,-1,obj_damage_text);
	text.val = 5;
	text.draw_color = c_red;
	for (var i = 0; i < irandom_range(2,4); i++)
	{
		instance_create_depth(obj_player.x,obj_player.y,-1,obj_blood);	
	}
}