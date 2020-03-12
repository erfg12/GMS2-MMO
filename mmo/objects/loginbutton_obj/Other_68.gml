var type_event = async_load[? "type"];

switch (type_event){
    case network_type_non_blocking_connect:
            global.socket = async_load[? "socket"];
			var sucTest = async_load[? "succeeded"];
			if (sucTest >= 1) { // if client found and connected to server successfully
				room_goto(character_room);
				//show_message("CONNECTED! Your acc ID is: " + string(global.acc_id))
			} else {
				show_message("ERROR: Could not find game server.");
			}
        break;
}