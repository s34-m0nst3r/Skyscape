function scr_item_definitions(){
	// global.items[item_id] = struct
	global.items = [];

	global.items[0] = { name: "Dirt Block", sprite: spr_dirt_item, stackable: true, max_stack: 9999, type: "block", block_id: 1, description: "Placeable"};
	global.items[1] = { name: "Mistral Pickaxe", sprite: spr_mistral_pickaxe, stackable: false, type: "pickaxe", mining_power: 1, melee_damage: 1};
	global.items[2] = { name: "Level Reader", sprite: spr_level_reader_item, stackable: true, max_stack: 9999, type: "block", block_id: 2, description: "Displays the level of \nthe CUBE when placed\nPlaceable"};
	global.items[3] = { name: "Biome Reader", sprite: spr_biome_reader_item, stackable: true, max_stack: 9999, type: "block", block_id: 3, description: "Displays biome information \nwhen placed\nPlaceable"};
	global.items[4] = { name: "Dirt Bomb", sprite: spr_dirt_bomb, stackable: true, max_stack: 9999, type: "bomb", description: "Consumable", block_id: 1};
	global.items[5] = { name: "Mistral Axe", sprite: spr_mistral_axe, stackable: false, type: "axe", woodcutting_power: 1, melee_damage: 1};
	global.items[6] = { name: "Mistral Acorn", sprite: spr_mistral_acorn, stackable: true, max_stack: 9999, type: "block", block_id: 4, description: "Grows into a Mistral tree\nwhen planted on soil\nPlaceable" };
	global.items[7] = { name: "Gunpowder", sprite: spr_gunpowder, stackable: true, max_stack: 9999, type: "material"};
	global.items[8] = { name: "Mistral Wood Block", sprite: spr_mistral_wood_item, stackable: true, max_stack: 9999, type: "block", block_id: 5, description: "Placeable"};
	global.items[9] = { name: "Workbench", sprite: spr_workbench_item, stackable: true, max_stack: 9999, type: "big block", block_id: 12, description: "Crafts basic items\nPlaceable"};
	global.items[10] = { name: "Mistral Table", sprite: spr_mistral_table_item, stackable: true, max_stack: 9999, type: "big block", block_id: 14, description:"Placeable"};
	global.items[11] = { name: "Blueprint", sprite: spr_blueprint, stackable: false, type: "blueprint", description: "Learn this recipe!\nIf you already have the recipe\nCUBE xp will be rewarded instead\nConsumable" };
	global.items[12] = { name: "Mistral Platform", sprite: spr_mistral_platform_item, stackable: true, max_stack: 9999, type: "block", block_id: 15, description:"Placeable"};
	global.items[13] = { name: "Mistral Hammer", sprite: spr_mistral_hammer, stackable: false, type: "hammer", hammer_power: 1, melee_damage: 2};
	global.items[14] = { name: "Mistral Wall", sprite: spr_mistral_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 16, description: "Placeable"};
	global.items[15] = { name: "Mistral Planks", sprite: spr_mistral_planks_item, stackable: true, max_stack: 9999, type: "block", block_id: 17, description: "Placeable"};
	global.items[16] = { name: "Mistral Sword", sprite: spr_mistral_sword, stackable: false, type: "sword", melee_damage: 3};
	global.items[17] = { name: "Mistral Hoe", sprite: spr_mistral_hoe, stackable: false, type: "hoe", melee_damage: 1,description: "Till soil into farmland to plant crops"};
	global.items[18] = { name: "Mistral Chair", sprite: spr_mistral_chair_item, stackable: true, max_stack: 9999, type: "big block", block_id: 18, description: "Placeable"};
	global.items[19] = { name: "Mistral Door", sprite: spr_mistral_door_item, stackable: true, max_stack: 9999, type: "big block", block_id: 19, description: "Placeable"};
	global.items[20] = { name: "Grass Seeds", sprite: spr_grass_seeds, stackable: true, max_stack: 9999, type: "seed", seed_id: 0, description: "Plants grass on dirt blocks\nConsumable"};
	global.items[21] = { name: "Cloud Block", sprite: spr_cloud_block_item, stackable: true, max_stack: 9999, type: "block", block_id: 30, description: "Placeable"};
	global.items[22] = { name: "Coal", sprite: spr_coal, stackable: true, max_stack: 9999, type: "material"};
	global.items[23] = { name: "Torch", sprite: spr_torch_item, stackable: true, max_stack: 9999, type: "block", block_id: 31, left_block: 33, right_block: 35, description: "Placeable"};
	global.items[24] = { name: "Copper Torch", sprite: spr_copper_torch_item, stackable: true, max_stack: 9999, type: "block", block_id: 32, left_block: 34, right_block: 36, description: "Placeable"};
	global.items[25] = { name: "Cloud Bomb", sprite: spr_cloud_bomb, stackable: true, max_stack: 9999, type: "bomb", description: "Consumable", block_id: 30, second_block_id: 37};
	global.items[26] = { name: "Rainy Cloud Block", sprite: spr_rainy_cloud_block_item, stackable: true, max_stack: 9999, type: "block", block_id: 37, description: "Placeable"};
	global.items[27] = { name: "Cloud Wall", sprite: spr_cloud_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 38, description: "Placeable"};
	global.items[28] = { name: "Rainy Cloud Wall", sprite: spr_rainy_cloud_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 39, description: "Placeable"};
	global.items[29] = { name: "Dirt Wall", sprite: spr_dirt_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 40, description: "Placeable"};
	global.items[30] = { name: "Grass Wall", sprite: spr_grass_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 41, description: "Placeable"};
	global.items[31] = { name: "Red Mushroom", sprite: spr_red_mushroom_item, stackable: true, max_stack: 9999, type: "block", block_id: 42, description: "Placeable"};
	global.items[32] = { name: "Blue Mushroom", sprite: spr_blue_mushroom_item, stackable: true, max_stack: 9999, type: "block", block_id: 43, description: "Placeable"};
	global.items[33] = { name: "Stone Block", sprite: spr_stone_item, stackable: true, max_stack: 9999, type: "block", block_id: 44, description: "Placeable"};
	global.items[34] = { name: "Stone Wall", sprite: spr_stone_wall_item, stackable: true, max_stack: 9999, type: "wall", block_id: 45, description: "Placeable"};
	global.items[35] = { name: "Soup Pot", sprite: spr_soup_pot_item, stackable: true, max_stack: 9999, type: "big block", block_id: 46, description: "Cooks soups over an open flame\nPlaceable"};
	global.items[36] = { name: "Mushroom Soup", sprite: spr_mushroom_soup, stackable: true, max_stack: 9999, type: "food", food_color_1: c_red, food_color_2: c_blue, hunger: 15, eat_time: 120, description: "Consumable"};
	global.items[37] = { name: "Water Bomb", sprite: spr_water_bomb, stackable: true, max_stack: 9999, type: "bomb", description: "Consumable", block_id: 47};
	global.items[38] = { name: "Raw Copper", sprite: spr_raw_copper, stackable: true, max_stack: 9999, type: "material"};
	global.items[39] = { name: "Stone Platform", sprite: spr_stone_platform_item, stackable: true, max_stack: 9999, type: "block", block_id: 57, description:"Placeable"};
	global.items[40] = { name: "Furnace", sprite: spr_furnace_item, stackable: true, max_stack: 9999, type: "big block", block_id: 58, description: "Smelts raw materials\nPlaceable"};
	global.items[41] = { name: "Copper Ingot", sprite: spr_copper_ingot, stackable: true, max_stack: 9999, type: "material"};
	global.items[42] = { name: "Copper Anvil", sprite: spr_copper_anvil_item, stackable: true, max_stack: 9999, type: "big block", block_id: 59, description: "Forges tools and armor\nPlaceable"};
	global.items[43] = { name: "Copper Sword", sprite: spr_copper_sword, stackable: false, type: "sword", melee_damage: 5};
	global.items[44] = { name: "Copper Pickaxe", sprite: spr_copper_pickaxe, stackable: false, type: "pickaxe", mining_power: 1.2, melee_damage: 2};
	global.items[45] = { name: "Copper Axe", sprite: spr_copper_axe, stackable: false, type: "axe", woodcutting_power: 1.2, melee_damage: 2};
	global.items[46] = { name: "Copper Hammer", sprite: spr_copper_hammer, stackable: false, type: "hammer", hammer_power: 1.2, melee_damage: 4};
	global.items[47] = { name: "Copper Bucket", sprite: spr_copper_bucket, stackable: false, type: "bucket", max_water: 3};
	global.items[48] = { name: "Drain Basin", sprite: spr_drain_basin_item, stackable: true, max_stack: 9999, type: "big block", block_id: 60, description: "Holds water from buckets\nDrains water out to... somewhere?\nPlaceable"};
	global.items[49] = { name: "Stone Door", sprite: spr_stone_door_item, stackable: true, max_stack: 9999, type: "big block", block_id: 61, description: "Placeable"};
	global.items[50] = { name: "Stone Table", sprite: spr_stone_table_item, stackable: true, max_stack: 9999, type: "big block", block_id: 63, description:"Placeable"};
	global.items[51] = { name: "Stone Chair", sprite: spr_stone_chair_item, stackable: true, max_stack: 9999, type: "big block", block_id: 64, description:"Placeable"};
	global.items[52] = { name: "Tree Nut", sprite: spr_tree_nut, stackable: true, max_stack: 9999, type: "food", food_color_1: c_orange, food_color_2: c_yellow, hunger: 5, eat_time: 60, description: "Consumable"};
	
	
	
}