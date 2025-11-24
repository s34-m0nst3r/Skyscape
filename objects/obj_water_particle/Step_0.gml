// Apply gravity
vsp += grav;
if (hsp > 0)
	hsp -=0.035;
	
if (hsp < 0)
	hsp +=0.035;

x+=hsp;
y+=vsp;
// Countdown
life--;
if (life <= 0) {
    instance_destroy();
}