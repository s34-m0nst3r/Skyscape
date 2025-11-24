//Save the world

var save_file = "save1.json";

//Convert grid to 2D array for JSON
var blocks_array = array_create(global.world_width);
for (var xx = 0; xx < global.world_width; xx++) {
    blocks_array[xx] = array_create(global.world_height);
    for (var yy = 0; yy < global.world_height; yy++) {
        blocks_array[xx][yy] = global.world[# xx, yy];
    }
}

//Convert grid to 2D array for JSON
var pointers_array = array_create(global.world_width);
for (var xx = 0; xx < global.world_width; xx++) {
    pointers_array[xx] = array_create(global.world_height);
    for (var yy = 0; yy < global.world_height; yy++) {
        pointers_array[xx][yy] = global.blockPointers[# xx, yy];
    }
}

//Convert grid to 2D array for JSON
var walls_array = array_create(global.world_width);
for (var xx = 0; xx < global.world_width; xx++) {
    walls_array[xx] = array_create(global.world_height);
    for (var yy = 0; yy < global.world_height; yy++) {
        walls_array[xx][yy] = global.walls[# xx, yy];
    }
}

var liquids_array = array_create(global.world_width);
for (var xx = 0; xx < global.world_width; xx++) {
    liquids_array[xx] = array_create(global.world_height);
    for (var yy = 0; yy < global.world_height; yy++) {
        liquids_array[xx][yy] = global.liquids[# xx, yy];
    }
}


// Convert inventory to JSON array
var inv_array = array_create(array_length(obj_player.inventory));
for (var i = 0; i < array_length(obj_player.inventory); i++) {
    var slot = obj_player.inventory[i];
    if (slot != noone) {
		if (variable_instance_exists(obj_player.inventory[i],"blueprint"))
		{
			inv_array[i] = {
	            "item": slot.item,
	            "count": slot.count,
				"blueprint": slot.blueprint
	        };
		}
		else if (variable_instance_exists(obj_player.inventory[i],"water_level"))
		{
			inv_array[i] = {
	            "item": slot.item,
	            "count": slot.count,
				"water_level": slot.water_level
	        };
		}
		else
		{
	        inv_array[i] = {
	            "item": slot.item,
	            "count": slot.count
	        };
		}
    } else {
        inv_array[i] = -1;
    }
}

//Build recipes
var recipes = [];
for (var i = 0; i < array_length(global.recipes); i++)
	array_push(recipes,global.recipes[i].unlocked)

// Create data structure
var data = {
    "world_width": global.world_width,
    "world_height": global.world_height,
    "blocks": blocks_array,
	"blockPointers": pointers_array,
	"walls" : walls_array,
	"liquids" : liquids_array,
    "player_x": obj_player.x,
    "player_y": obj_player.y,
	"inventory": inv_array,
	"recipes": recipes
};

data.cube_level        = global.cube_level;
data.cube_blocks_mined = global.cube_blocks_mined;
data.cube_next_level = global.cube_next_level;

data.mistral_level        = global.mistral_level;
data.mistral_blocks_mined = global.mistral_blocks_mined;
data.mistral_next_level = global.mistral_next_level;

data.time_of_day = global.time_of_day;

//STAT MANAGER
data.hp = obj_stat_manager.hp;
data.maxHp = obj_stat_manager.maxHp;
data.hunger = obj_stat_manager.hunger;
data.maxHunger = obj_stat_manager.maxHunger;
data.mana = obj_stat_manager.mana;
data.maxMana = obj_stat_manager.maxMana;
data.air = obj_stat_manager.air;
data.maxAir = obj_stat_manager.maxAir;

data.regenRate = obj_stat_manager.regenRate;
data.hungerRate = obj_stat_manager.hungerRate;
data.airLossRate = obj_stat_manager.airLossRate;


//Convert to JSON
var json_text = json_stringify(data);

//Write to file
var file = file_text_open_write(save_file);
file_text_write_string(file, json_text);
file_text_close(file);
