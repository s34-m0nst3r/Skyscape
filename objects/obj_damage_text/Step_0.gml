// Apply gravity
vsp += grav;
if (hsp > 0.1)
	hsp -=0.015;
	
if (hsp < 0.1)
	hsp +=0.015;
	
grav -= 0.0001;

y += vsp;
x += hsp;

// Countdown
life--;
if (life <= 0) {
    image_alpha-=0.02;
}

if (image_alpha <= 0)
	instance_destroy(self);