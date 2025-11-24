// Physics
hsp = 0;
vsp = 0;
grav = 0.06;
moveLeft = true;

if (irandom_range(0,1) == 1)
	moveLeft = false;

alarm[0]=irandom_range(10,500);
image_speed=random_range(0.1,0.2);

// Lifetime
life = room_speed * random_range(10,25); // disappear after ~2 * 5 seconds

item_id = 0;
depth = -100;

seedtype = -1;