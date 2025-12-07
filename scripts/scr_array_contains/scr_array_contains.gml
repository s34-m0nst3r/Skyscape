function scr_array_contains(array,value){
	for (var i = 0; i < array_length(array); i++)
	{
		if (array[i] == value)
			return true;
	}
	return false;
}