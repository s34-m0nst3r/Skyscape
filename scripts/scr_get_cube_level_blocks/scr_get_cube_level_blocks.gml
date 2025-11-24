function scr_get_cube_level_blocks(level){
	//Loot table: {item_id, chance, min_level}
	var loot_table = [
	    { block: 30, chance: 20, min_level: 1 }, //Cloud Block
		{ block: 37, chance: 35, min_level: 4 }, //Rainy Cloud Block
		{ block: 44, chance: 15, min_level: 5 }, //Stone Block
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