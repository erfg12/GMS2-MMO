text = argument0;
char_string = 0;

if string_pos(",", text) != 0
{
	var cc = string_count(",",text);
	for (i = 0; i <= cc; i += 1) {
		if (i < cc) {
			char_string[i] = string_copy(text, 0, string_pos(",", text)-1 );
			text = string_copy(text, string_pos(",", text)+1, string_length(text) );
		}
		else
			char_string[i] = text;
	}
	return char_string;
}
else
	return text