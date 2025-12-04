function scr_get_cube_loot(level){
	//Loot table: {item_id, chance, min_level}
	var loot_table = [
	    { item: 2, chance: 300, min_level: 1 }, //  LEVEL READER
		{ item: 3, chance: 300, min_level: 2 }, // BIOME READER
		{ item: 1, chance: 250, min_level: 1 }, // MISTRAL PICKAXE
		{ item: 5, chance: 200, min_level: 1 }, // MISTRAL AXE
		{ item: 7, chance: 150, min_level: 5 }, // GUNPOWDER
		{ item: 20, chance: 75, min_level: 2 }, // GRASS SEEDS
		{ item: 17, chance: 400, min_level: 4 }, // FARMER'S HOE
		{ item: 22, chance: 100, min_level: 4 }, // COAL
		{ item: 23, chance: 125, min_level: 4 }, // TORCH
		{ item: 24, chance: 85, min_level: 2 }, // COPPER TORCH
		{ item: 25, chance: 135, min_level: 1 }, // CLOUD BOMB
		{ item: 38, chance: 350, min_level: 5 }, // RAW COPPER
		{ item: 11, blueprint: 42, chance: 225, min_level: 3 }, //COPPER ANVIL BLUEPRINT
		{ item: 57, chance: 495, min_level: 5 }, // MAGIC CRYSTAL
		
		//TO REMOVE LATER
		{ item: 38, chance: 2, min_level: 5 }, // RAW COPPER
		{ item: 22, chance: 2, min_level: 4 }, // COAL
		{ item: 33, chance: 2, min_level: 4 }, // STONE
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