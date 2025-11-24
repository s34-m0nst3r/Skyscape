function scr_get_sun_alpha(){

	//Midnight -> 6AM (0.25)
	if (global.time_of_day >= 0 && global.time_of_day <= 0.2)
		return 0;
		
	if (global.time_of_day >= 0.2 && global.time_of_day <= 0.25)
		return 0.7;
		
	//6AM -> Noon
	if (global.time_of_day >= 0.25 && global.time_of_day <= 0.5)
		return 1;
		
	//Noon -> 6PM
	if (global.time_of_day >= 0.5 && global.time_of_day <= 0.75)
		return 1;
		
	//6PM -> Midnight
	if (global.time_of_day >= 0.75 && global.time_of_day <= 1)
		return 0;

}