if (string(char_name_input_obj.char_name_input) == "")
{
	show_message("error: character name blank");
	return 0
}

var str = "create_character&accid=" + string(global.acc_id) + "&name=" + string(char_name_input_obj.char_name_input) + "&race=0&sex=0";
http_post_string("https://account.newagesoldier.com/api_game.php", str);

//room_goto(level1_room);