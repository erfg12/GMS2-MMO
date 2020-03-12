if ds_map_find_value(async_load, "status") >= 0 // less than 0 means err
    {
        result = ds_map_find_value(async_load, "result" );
        if (is_undefined(result)){
            show_message("connection to server was not successful.");
        } else {
            if (result != "FAILED") {
				//show_debug_message("RESULT:" + string(result))
				if (result == "SUCCESS") {
	                room_goto(character_room)
				}
            } else {
                show_message("Character Creation Failed!");
            }
        }
    }