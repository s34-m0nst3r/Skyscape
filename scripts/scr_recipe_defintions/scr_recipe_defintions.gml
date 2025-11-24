function scr_recipe_defintions(){
	global.recipes = [];

	// INGREDIENTS:  ingredients: [[8,25]] == 8 (MISTRAL ACORN), 25 (COUNT) (OUTER ARRAY CAN BE USED FOR ADDITIONAL ITEMS
	global.recipes[0] = { name: "Mistral Pickaxe", sprite: spr_mistral_pickaxe, item_id: 1, count: 1, ingredients: [[8,35]], unlocked: true, station: "workbench"};
	global.recipes[1] = { name: "Workbench", sprite: spr_workbench_item, item_id: 9, count: 1, ingredients: [[8,25]], unlocked: true, station: "basic"};
	global.recipes[2] = { name: "Mistral Axe", sprite: spr_mistral_axe, item_id: 5, count: 1, ingredients: [[8,35]], unlocked: true, station: "workbench"};
	global.recipes[3] = { name: "Mistral Table", sprite: spr_mistral_table_item, item_id: 10, count: 1, ingredients: [[8,30]], unlocked: false, station: "workbench"};
	global.recipes[4] = { name: "Dirt Bomb", sprite: spr_dirt_bomb, item_id: 4, count: 5, ingredients: [[0,15],[7,3]], unlocked: false, station: "workbench"};
	global.recipes[5] = { name: "Mistral Platform", sprite: spr_mistral_platform_item, item_id: 12, count: 2, ingredients: [[8,1]], unlocked: true, station: "basic"};
	global.recipes[6] = { name: "Mistral Hammer", sprite: spr_mistral_hammer, item_id: 13, count: 1, ingredients: [[8,35]], unlocked: true, station: "workbench"};
	global.recipes[7] = { name: "Mistral Wall", sprite: spr_mistral_wall_item, item_id: 14, count: 4, ingredients: [[8,1]], unlocked: true, station: "basic"};
	global.recipes[8] = { name: "Mistral Planks", sprite: spr_mistral_planks_item, item_id: 15, count: 4, ingredients: [[8,1]], unlocked: false, station: "basic"};
	global.recipes[9] = { name: "Mistral Sword", sprite: spr_mistral_sword, item_id: 16, count: 1, ingredients: [[8,35]], unlocked: false, station: "workbench"};
	global.recipes[10] = { name: "Mistral Hoe", sprite: spr_mistral_hoe, item_id: 17, count: 1, ingredients: [[8,35]], unlocked: false, station: "workbench"};
	global.recipes[11] = { name: "Mistral Chair", sprite: spr_mistral_chair_item, item_id: 18, count: 1, ingredients: [[8,20]], unlocked: false, station: "workbench"};
	global.recipes[12] = { name: "Mistral Door", sprite: spr_mistral_door_item, item_id: 19, count: 1, ingredients: [[8,25]], unlocked: false, station: "workbench"};
	global.recipes[13] = { name: "Torch", sprite: spr_torch_item, item_id: 23, count: 4, ingredients: [[8,1],[22,1]], unlocked: false, station: "basic"};
	global.recipes[14] = { name: "Cloud Bomb", sprite: spr_cloud_bomb, item_id: 25, count: 5, ingredients: [[21,15],[7,3]], unlocked: false, station: "workbench"};
	global.recipes[15] = { name: "Cloud Wall", sprite: spr_cloud_wall_item, item_id: 27, count: 4, ingredients: [[21,1]], unlocked: false, station: "basic"};
	global.recipes[16] = { name: "Rainy Cloud Wall", sprite: spr_rainy_cloud_wall_item, item_id: 28, count: 4, ingredients: [[26,1]], unlocked: false, station: "basic"};
	global.recipes[17] = { name: "Dirt Wall", sprite: spr_dirt_wall_item, item_id: 29, count: 4, ingredients: [[0,1]], unlocked: false, station: "basic"};
	global.recipes[18] = { name: "Grass Wall", sprite: spr_grass_wall_item, item_id: 30, count: 4, ingredients: [[20,1]], unlocked: false, station: "basic"};
	global.recipes[19] = { name: "Stone Wall", sprite: spr_stone_wall_item, item_id: 34, count: 4, ingredients: [[33,1]], unlocked: false, station: "basic"};
	global.recipes[20] = { name: "Soup Pot", sprite: spr_soup_pot_item, item_id: 35, count: 1, ingredients: [[33,15],[8,5],[22,3]], unlocked: false, station: "workbench"};
	global.recipes[21] = { name: "Mushroom Soup", sprite: spr_mushroom_soup, item_id: 36, count: 1, ingredients: [[31,1],[32,1],[8,3]], unlocked: true, station: "soup pot"};
	global.recipes[22] = { name: "Stone Platform", sprite: spr_stone_platform_item, item_id: 39, count: 2, ingredients: [[33,1]], unlocked: false, station: "basic"};
	global.recipes[23] = { name: "Furnace", sprite: spr_furnace_item, item_id: 40, count: 1, ingredients: [[33,20],[8,5],[22,5]], unlocked: false, station: "workbench"};
	global.recipes[24] = { name: "Copper Ingot", sprite: spr_copper_ingot, item_id: 41, count: 1, ingredients: [[38,2],[22,1]], unlocked: true, station: "furnace"};
	global.recipes[25] = { name: "Copper Torch", sprite: spr_copper_torch_item, item_id: 24, count: 4, ingredients: [[8,1],[38,1]], unlocked: false, station: "basic"};
	global.recipes[26] = { name: "Copper Anvil", sprite: spr_copper_anvil_item, item_id: 42, count: 1, ingredients: [[41,5]], unlocked: false, station: "workbench"};
	global.recipes[27] = { name: "Copper Sword", sprite: spr_copper_sword, item_id: 43, count: 1, ingredients: [[41,35],[8,5]], unlocked: true, station: "anvil"};
	global.recipes[28] = { name: "Copper Pickaxe", sprite: spr_copper_pickaxe, item_id: 44, count: 1, ingredients: [[41,35],[8,5]], unlocked: true, station: "anvil"};
	global.recipes[29] = { name: "Copper Axe", sprite: spr_copper_axe, item_id: 45, count: 1, ingredients: [[41,35],[8,5]], unlocked: true, station: "anvil"};
	global.recipes[30] = { name: "Copper Hammer", sprite: spr_copper_hammer, item_id: 46, count: 1, ingredients: [[41,35],[8,5]], unlocked: true, station: "anvil"};
	global.recipes[31] = { name: "Copper Bucket", sprite: spr_copper_bucket, item_id: 47, count: 1, ingredients: [[41,25]], unlocked: true, station: "anvil"};
	global.recipes[32] = { name: "Biome Reader", sprite: spr_biome_reader_item, item_id: 3, count: 1, ingredients: [[33,15],[6,3]], unlocked: false, station: "workbench"};
	global.recipes[33] = { name: "Level Reader", sprite: spr_level_reader_item, item_id: 2, count: 1, ingredients: [[33,10],[38,3]], unlocked: false, station: "workbench"};
	global.recipes[34] = { name: "Drain Basin", sprite: spr_drain_basin_item, item_id: 48, count: 1, ingredients: [[33,25]], unlocked: false, station: "workbench"};
	global.recipes[35] = { name: "Stone Door", sprite: spr_stone_door_item, item_id: 49, count: 1, ingredients: [[33,25]], unlocked: false, station: "workbench"};
	global.recipes[36] = { name: "Stone Table", sprite: spr_stone_table_item, item_id: 50, count: 1, ingredients: [[33,30]], unlocked: false, station: "workbench"};
	global.recipes[37] = { name: "Stone Chair", sprite: spr_stone_chair_item, item_id: 51, count: 1, ingredients: [[33,20]], unlocked: false, station: "workbench"};
	global.recipes[38] = { name: "Stone Brick", sprite: spr_stone_brick_item, item_id: 53, count: 2, ingredients: [[33,4]], unlocked: false, station: "workbench"};
	global.recipes[39] = { name: "Stone Brick Wall", sprite: spr_stone_brick_wall_item, item_id: 54, count: 4, ingredients: [[53,1]], unlocked: false, station: "workbench"};
	
}