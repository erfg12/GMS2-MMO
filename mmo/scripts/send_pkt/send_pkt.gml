buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_string, string(argument[0]));
network_send_raw(global.socket, global.buffer, buffer_tell(global.buffer));
