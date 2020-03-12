grid_x = x - (room_width/2);
grid_y = y - (room_height/2);

show_debug_message("creating player as acc_id:" + string(global.acc_id) + " spawn_id:" + string(player_obj.id));

send_pkt("spawn|" + string(global.acc_id) + "," + string(grid_x) + "," + string(grid_y));

global.congood = true;
alarm[0] = room_speed * 10; // set alarm

charspd = 5