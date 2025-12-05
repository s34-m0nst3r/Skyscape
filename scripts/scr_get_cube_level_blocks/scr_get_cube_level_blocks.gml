function scr_get_cube_level_blocks(level){
	//Loot table: {item_id, chance, min_level}
	var loot_table = [
	    { block: 30, chance: 20, min_level: 1 }, //Cloud Block
		{ block: 37, chance: 35, min_level: 4 }, //Rainy Cloud Block
		{ block: 44, chance: 30, min_level: 3 }, //Stone Block
		{ block: 44, chance: 12, min_level: 5 }, //Stone Block
		{ block: 44, chance: 8, min_level: 6 }, //Stone Block
		{ block: 78, chance: 80, min_level: 5 }, //Copper Ore
		{ block: 79, chance: 140, min_level: 6 }, //Magic Crystal Ore
		{ block: 85, chance: 40, min_level: 5 }, //Clay Block
	];

	// Loop through unlocked items
	for (var i = 0; i < array_length(loot_table); i++) {
	    var entry = loot_table[i];
	    if (level >= entry.min_level) {
	        if (irandom(entry.chance) == 0) {
	            return entry.block;
	        }
	    }
	}

	return 1; // return dirt block
}