moveUp = !moveUp;
alarm[0]=8;
var particle = instance_create_depth(x,y,-1,obj_food_particle);
if (irandom_range(0,1) == 1)
	particle.image_blend = food_color_1;
else
	particle.image_blend = food_color_2;