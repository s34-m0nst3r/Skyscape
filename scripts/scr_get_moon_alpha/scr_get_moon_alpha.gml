function scr_get_moon_alpha(){

	//Midnight -> 6AM (0.25)
	if (global.time_of_day >= 0 && global.time_of_day <= 0.1)
		return 1;
		
	if (global.time_of_day >= 0.1 && global.time_of_day <= 0.2)
		return 0.4;
		
	//6AM (0.25) -> Noon
	if (global.time_of_day >= 0.2 && global.time_of_day <= 0.5)
		return 0;
		
	//Noon -> 6PM
	if (global.time_of_day >= 0.5 && global.time_of_day <= 0.75)
		return 0;
		
	//6PM -> Midnight
	if (global.time_of_day >= 0.75 && global.time_of_day <= 1)
		return 1;

}