function scr_array_count(array,val){
	var count = 0;
	for (var i = 0; i < array_length(array); i++)
	{
		if (array[i] == val)
			count++;
	}
	return count;
}