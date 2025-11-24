if (facing == 1)
	x+=random_range(0,0.05);
else
	x-=random_range(0,0.05);
	
	
if (distance_to_object(obj_player) > 300)
	image_alpha-=0.002;
	
if (image_alpha <= 0 && reachedTargetAlpha)
	instance_destroy(self);
	
if (image_alpha < targetAlpha && !reachedTargetAlpha)
	image_alpha+=0.002;	
else
	reachedTargetAlpha = true;