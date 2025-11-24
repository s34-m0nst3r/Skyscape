function scr_recipe_visible(_r, workstation) {
    var recipe = global.recipes[_r];
	var stat = workstation;
	
	//Check search
	if (obj_player.search_active && string_pos(string_upper(obj_player.search_text),string_upper(global.items[global.recipes[_r].item_id].name)) == 0 )
	{
		return false;	
	}
    
    // Skip if wrong station
     if (recipe.station == "basic") {
        //Only show basic recipes at basic or workbench stations
        if (stat != "basic" && stat != "workbench") return false;
    } else {
        if (recipe.station != stat) return false;
    }

    // Always show if unlocked
    if (recipe.unlocked) return true;
    
    // Otherwise: check if player has all ingredients
    var has_all = true;
    for (var i = 0; i < array_length(recipe.ingredients); i++) {
        var ing = recipe.ingredients[i];
        var itemid = ing[0];
        var need = ing[1];
        
        var have = scr_count_item_in_inventory(itemid);
        if (have < need) {
            has_all = false;
            break;
        }
    }
	
    return has_all;
}
