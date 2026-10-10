if (irandom(99) > 80)
{
	if (irandom_range(0,1) == 1)
		x+=random_range(-0.5,0.5);
}

if (irandom_range(0,1) == 1)
	y-=random_range(0,0.5);


// Countdown
life--;
if (life <= 0)
	image_alpha-=0.01;
if (image_alpha <= 0)
	instance_destroy(self);

