global.buffer = buffer_create(1024, buffer_grow, 1);
global.player_id = 0;

network_set_config(network_config_use_non_blocking_socket, 1);
network_set_config(network_config_connect_timeout, 6000);

global.spawns = ds_map_create();