//Random cloud sprite
var i = irandom_range(0,3);
if i == 0
	sprite_index = spr_cloud_1;
if i == 1
	sprite_index = spr_cloud_2;
if i == 2
	sprite_index = spr_cloud_3;
	
facing = 1;

if (irandom_range(0,1) == 0)
	facing = 0;
	
depth = -1;

image_alpha = 0;

targetAlpha = random_range(0.4,0.9);

if (irandom_range(0,1) == 0)
	targetAlpha = 0.9;
	
reachedTargetAlpha = false;

scale = random_range(1,1.5);
image_xscale=scale;
image_yscale=scale;

if (irandom_range(0,1) == 0)
	image_xscale*=-1;