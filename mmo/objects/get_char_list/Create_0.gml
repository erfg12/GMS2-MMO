var str = "character_list&accid=" + string(global.acc_id);
http_post_string("https://account.newagesoldier.com/api_game.php", str);