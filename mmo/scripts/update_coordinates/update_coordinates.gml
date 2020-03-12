if (keyboard_check(vk_up) || keyboard_check(vk_down) || keyboard_check(vk_left) || keyboard_check(vk_right)) {
    send_pkt("move|" + string(global.acc_id) + "," + string(player_obj.grid_x) + "," + string(player_obj.grid_y) + "," + string(player_obj.direction));
}
