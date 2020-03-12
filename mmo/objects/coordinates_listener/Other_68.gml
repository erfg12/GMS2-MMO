var type_event = async_load[? "type"]; //Grabbing the type from async_load using an accessor, then store that value in type_event

switch (type_event){       
    case network_type_disconnect:
        show_message("disconnected from server");
		global.acc_id = "";
        room_goto(login_room);
        break;
       
    case network_type_data: //If we are receiving data
        //Handle the data.
        var localbuffer = async_load[? "buffer"]; //Create a temporary buffer.
        buffer_seek(localbuffer,buffer_seek_start,0) //Looks at the beginning of the buffer.
        scr_received_packet(localbuffer); //Executes our script scr_recieved_packet, and pass the buffer to our script.
        break;
}