if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}

if (!moveUp)
{
	// Advance swing
	swing_progress += swing_speed;
}
else
{
	// Advance swing
	swing_progress -= swing_speed;
}
if (swing_progress >= 1)
{
	if (!returnUp)
	{
		instance_destroy();
		owner.swingingTool = false;
	}
	else
	{
		moveUp = true;	
	}

}
else if (moveUp && swing_progress <= 0)
{
	instance_destroy();
	owner.swingingTool = false;
}


// Anchor to player
x = owner.x;
y = owner.y;

// Compute arc position
var swing_angle = lerp(start_angle, end_angle, swing_progress);

// Flip horizontally if facing left
if (facing == 0) swing_angle = 180 - swing_angle;

// Store world position of pickaxe
swing_x = x + lengthdir_x(radius, swing_angle);
swing_y = y + lengthdir_y(radius, swing_angle);
swing_angle_draw = swing_angle; // save for drawing rotation
