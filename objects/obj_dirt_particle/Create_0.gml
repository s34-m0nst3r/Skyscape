// Physics
hsp = random_range(-0.8,0.8);
vsp = random_range(-0.8,-0.4);
grav = 0.035;

image_alpha = random_range(0.9,1);
image_index=irandom_range(0,4);
image_speed = 0;

var scale = random_range(0.3,0.8);
image_xscale=scale;
image_yscale=scale;


// Lifetime
life = room_speed* 1; // disappear after ~2 * 5 seconds

depth = -100;

image_angle+=90*irandom_range(0,4);
