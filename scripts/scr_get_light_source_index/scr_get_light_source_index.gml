function scr_get_light_source_index(){
	var xp = argument0;
	var yp = argument1;

	for (var i = 0; i < array_length(global.light_sources); i++) {
	    if (global.light_sources[i].xp == xp && global.light_sources[i].yp == yp) {
	        return i;
	    }
	}
	return -1;
}