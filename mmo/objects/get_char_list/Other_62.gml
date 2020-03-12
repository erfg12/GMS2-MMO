if ds_map_find_value(async_load, "status") >= 0 // less than 0 means err
    {
        result = ds_map_find_value(async_load, "result" );
        if (is_undefined(result)){
            show_message("connection to server was not successful.");
        } else {
            if (result != "FAILED") {
				show_debug_message("RETRIEVE CHARS LIST RESULT:" + string(result));
				mychars = iteration(string(result));
				button_placement = 250;
				for (var i = array_length_1d(mychars) - 1; i > -1; i--;)
				{
					inst = instance_create(50, button_placement, char_select_btn);
					button_placement = button_placement + 250;
					with (inst)
					{
					   inst.mytext = mychars[i];
					}
				}
            } else {
                show_message("Character Retrieving Failed!");
            }
        }
    }