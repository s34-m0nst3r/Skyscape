function scr_eat_food(foodItem,eat,selected_item){
	if (!foodItem) {
		eat = instance_create_layer(x, y, "Instances", obj_food_eat);
		eat.owner = id;
		eat.item_id = selected_item.item;
		eat.selected_item = selected_item;
		eat.facing = facing; // 0 left, 1 right
		eat.food_color_1 = global.items[selected_item.item].food_color_1;
		eat.food_color_2 = global.items[selected_item.item].food_color_2;
		eat.eat_time = global.items[selected_item.item].eat_time;
		eat.hunger = global.items[selected_item.item].hunger;
		other.eat = eat;
		other.foodItem = true;
	}
	else if (foodItem && !instance_exists(eat))
	{
		var text = instance_create_depth(x,y,-1,obj_damage_text);
		text.val = global.items[selected_item.item].hunger;
		text.draw_color = make_color_rgb(252, 240, 124);

		other.eat = 0;
		other.foodItem = false;
		scr_reduce_count(selected_item);
	}
}