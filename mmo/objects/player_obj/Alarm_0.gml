alarm[0] = room_speed * 10;
if (global.congood){
    show_debug_message("connection is good");
    global.congood = false; // reset
} else {
    show_message("connection to server died");
    room_goto(login_room);
}

