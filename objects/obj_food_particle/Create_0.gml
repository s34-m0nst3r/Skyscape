// Physics
hsp = random_range(-2,2);
vsp = random_range(-0.1,-2);
grav = 0.1;

image_alpha = random_range(0.6,1);
image_index=irandom_range(0,4);
image_speed = 0;

var scale = random_range(0.5,1.5);
image_xscale=scale;
image_yscale=scale;

// Lifetime
life = room_speed* 3; // disappear after ~2 * 5 seconds

depth = -100;
