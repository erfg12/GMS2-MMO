var msg = string(buffer_read(argument[0],buffer_string)); //string to split
var splitBy = ","; //string to split the first string by
var slot = 0;
var splits; //array to hold all splits
var str2 = ""; //var to hold the current split we're working on building

// packet processor
var i;
for (i = 1; i < (string_length(msg)+1); i++) {
    var currStr = string_copy(msg, i, 1);
    if (currStr == splitBy) {
        splits[slot] = str2; //add this split to the array of all splits
        slot++;
        str2 = "";
    } else {
        str2 = str2 + currStr;
        splits[slot] = str2;
    }
}

// check what type of packet it is
switch (splits[0]){
    case "move":
        if (splits[1] != 0) {
            spawn_id = ds_map_find_value(global.spawns,splits[1]); //get spawn ID from acc ID
            if (is_undefined(spawn_id) && splits[1] != global.acc_id) { // spawn in the player if he doesnt exist
                fake_x = real(splits[2]) + (room_width/2);
                fake_y = real(splits[3]) + (room_height/2);
                inst = instance_create(fake_x, fake_y, otherplayer_obj);
                ds_map_add(global.spawns,splits[1],inst.id); // add spawned player to the global spawns array with packet ID and inst obj ID
                show_debug_message ("spawning player (and moving) acc_id:" + string(splits[1]) + " spawn_id:" + string(inst.id));
                break;
            } else if (splits[1] != global.acc_id){ //dont move me
                fake_x = real(splits[2]) + (room_width/2);
                fake_y = real(splits[3]) + (room_height/2);
				fake_h = real(splits[4]);
                (spawn_id).x = fake_x;
                (spawn_id).y = fake_y;
				//(spawn_id).move_towards_point(fake_x,fake_y,5);
				(spawn_id).direction = fake_h;
				if (fake_h == 0)
				{
					(spawn_id).sprite_index = player_sprite_right
				} else if (fake_h == 90)
				{
					(spawn_id).sprite_index = player_sprite_down
				} else if (fake_h == 180)
				{
					(spawn_id).sprite_index = player_sprite_left
				} else if (fake_h == 270)
				{
					(spawn_id).sprite_index = player_sprite_up
				}
				(spawn_id).image_speed = 0.20;
				(spawn_id).image_index = 0;
                //with (instance_id[spawn_id])
                //    move_towards_point(fake_x, fake_y, 2);
                show_debug_message("moving player acc_id:" + string(splits[1]) + " spawn_id:" + string(spawn_id) + " X:" + string(fake_x) + " Y:" + string(fake_y) + " SP_X:" + string((spawn_id).x) + " SP_Y:" + string((spawn_id).y));
            }
			// test: stop image, doesn't work...
			/*if (!is_undefined(spawn_id) && splits[1] != global.acc_id) {
				(spawn_id).image_speed = 0;
			}*/
        }
        break;
    case "spawn":
        if (splits[1] != 0) {
            spawn_id = ds_map_find_value(global.spawns,splits[1]); // check if spawnid exists first
            if is_undefined(spawn_id) {
                if (splits[1] != global.acc_id) { //dont spawn a duplicate me
                    fake_x = real(splits[2]) + (room_width/2);
                    fake_y = real(splits[3]) + (room_height/2);
                    inst = instance_create(fake_x, fake_y, otherplayer_obj);
                    ds_map_add(global.spawns,splits[1],inst.id); // add spawned player to the global spawns array with packet ID and inst obj ID
                    show_debug_message ("spawning player acc_id:" + string(splits[1]) + " spawn_id:" + string(inst.id));
                }
            }
        }
        break;
    case "tick":
        global.congood = true;
        break;
    case "disconnected":
        show_debug_message("received disconnected client id: #" + string(splits[1]));
        if (splits[1] != 0) {
            spawn_id = ds_map_find_value(global.spawns,splits[1]); // check if spawnid exists first
            if !is_undefined(spawn_id) {
                ds_map_delete(global.spawns,splits[1]); // remove from our array
                instance_destroy(spawn_id);
            }
        }
        break;
}
