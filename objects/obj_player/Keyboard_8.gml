if (string_length(search_text) > 0 && !waitDelete) {
    search_text = string_delete(search_text, string_length(search_text), 1);
	waitDelete = true;
	alarm[0]=7;
}
