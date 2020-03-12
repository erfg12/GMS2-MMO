
    if ds_map_find_value(async_load, "status") >= 0 // less than 0 means err
    {
        result = ds_map_find_value(async_load, "result" );
        if (is_undefined(result)){
            show_message("connection to login server was not successful.");
        } else {
            if (result != "FAILED") {
				show_debug_message("RESULT:" + string(result))
				if (result == "") {
					show_message("Missing Account ID")
				} else {
	                global.socket = network_create_socket(network_socket_tcp);
	                network_connect_raw(global.socket, "127.0.0.1", 13000);
					global.acc_id = result; // found acc, set our ID for client game
					show_debug_message("Connecting to server...");
					// the rest is done in Async - Networking
				}
            } else {
                show_message("Login Failed! Could not find account.");
            }
        }
    }
    else
    {
        show_message("connection to login server was not successful.");
    }


