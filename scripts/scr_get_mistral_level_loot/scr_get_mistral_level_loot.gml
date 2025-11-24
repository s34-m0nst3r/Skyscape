function scr_get_mistral_level_loot(level){
	//Loot table: {item_id, chance, min_level}
	var loot_table = [
	    { item: 4, chance: 45, min_level: 1 }, // DIRT BOMB
		{ item: 6, chance: 25, min_level: 0 }, // MISTRAL ACORN
		{ item: 31, chance: 30, min_level: 1 }, // RED MUSHROOM
		{ item: 32, chance: 30, min_level: 1 }, // BLUE MUSHROOM
		{ item: 11, blueprint: 35, chance: 150, min_level: 2 }, // SOUP POT BLUEPRINT
		{ item: 36, chance: 225, min_level: 1 }, // MUSHROOM SOUP
		{ item: 37, chance: 115, min_level: 4 }, // WATER BOMB
		{ item: 11, blueprint: 40, chance: 150, min_level: 3 } //FURNACE BLUEPRINT
	];

	// Loop through unlocked items
	for (var i = 0; i < array_length(loot_table); i++) {
	    var entry = loot_table[i];
	    if (level >= entry.min_level) {
	        if (irandom(entry.chance) == 0) {
	            return entry;
	        }
	    }
	}

	return -1; // nothing dropped
}