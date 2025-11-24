if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}



// Anchor to player
x = owner.x;
y = owner.y + offsetY;

if (moveUp)
	offsetY-=0.32;
else
	offsetY+=0.32;

if (!mouse_check_button(mb_left))
{
	owner.eat = 0;
	owner.foodItem = false;
	instance_destroy(self);
}
image_alpha-=0.0025;
	
eat_time--;

if (eat_time <= 0)
{
	for (var i = 0; i < 8; i++)
	{
		var particle = instance_create_depth(x,y,-1,obj_food_particle);
		if (irandom_range(0,1) == 1)
			particle.image_blend = food_color_1;
		else
			particle.image_blend = food_color_2;	
		
	}
	obj_stat_manager.hunger+=hunger;
		
	instance_destroy(self);
}