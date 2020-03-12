password_input_obj.pass_focus = false;
username_input_obj.user_focus = false;

var str = "newage_login=" + string(username_input_obj.user_input) + "&newage_password=" + string(password_input_obj.pass_input);
http_post_string("https://account.newagesoldier.com/api_login.php", str);

//show_message("user=" + string(username_input_obj.user_input) + " pass=" + string(password_input_obj.pass_input));

