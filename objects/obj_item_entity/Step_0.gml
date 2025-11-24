// Apply gravity
if (impulse_time > 0) {
    impulse_time--;
} else {
	vsp += grav;
	hsp = 0;
}

// Hovering (cosine bobbing)
hover_offset = sin(current_time / 200) * hover_range;

// Vertical collision with world
if (is_solid_at(x, y + vsp,false)) {
    vsp = 0;
} else {
    y += vsp;
}

// Horizontal collision (if you want them to slide)
if (is_solid_at(x + hsp, y,false)) {
   hsp = 0;
}
else
{
	x += hsp;
}
//Stuck inside block
if (is_solid_at(x, y,false)) {
    hsp = irandom_range(-1, 1);   // random horizontal push
    vsp = -irandom_range(1, 2);  // small upward push
    impulse_time = 7;            // optional: temporarily ignore gravity
}

//Hover bobbing for draw
hover_y = 2 * sin(degtorad(current_time/5 + hover_offset));

//Pickup by player
if (distance_to_object(obj_player) < obj_player.magnet && canBePickedUp && obj_player.alive) {
    with (obj_player) {
        scr_add_item(other.item_id, other.count, other.blueprint, other.water_level);
		// Add pickup message
		
		//NO ITEMS IN ARRAY, add new message
		if (array_length(pickup_messages) == 0)
		{
			var msg = {};
			if (other.blueprint != -1)
			{
				msg = {
			        text  : global.items[other.item_id].name + ": "+ global.items[other.blueprint].name,
			        alpha : 1,
					count : other.count,
					blueprint: other.blueprint
			    };
			}
			else
			{
				msg = {
			        text  : global.items[other.item_id].name,
			        alpha : 1,
					count : other.count
			    };
			}
			array_push(pickup_messages, msg);
		}
		//ITEMS IN ARRAY, CHECK IF COUNT SHOULD BE UPDATED
		else
		{
			for (var i = 0; i < array_length(pickup_messages); i++) {
			    if pickup_messages[i].text == global.items[other.item_id].name
				{
					pickup_messages[i].count++;
					pickup_messages[i].alpha = 1;
					break;
				}
				else if (i == array_length(pickup_messages)-1){
					var msg = {};
					if (other.blueprint != -1)
					{
						msg = {
					        text  : global.items[other.item_id].name + ": "+ global.items[other.blueprint].name,
					        alpha : 1,
							count : other.count,
							blueprint: other.blueprint
					    };
					}
					else
					{
						msg = {
					        text  : global.items[other.item_id].name,
					        alpha : 1,
							count : other.count
					    };
					}
					array_push(pickup_messages, msg);
					break;
				}
			}

		}



    }
    instance_destroy();
}
