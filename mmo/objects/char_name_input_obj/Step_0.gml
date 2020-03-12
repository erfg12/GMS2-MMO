if (char_focus) {
    char_name_input = keyboard_string;
}
if (keyboard_check(vk_tab)){
    char_name_input_obj.char_focus = true;
    keyboard_string = char_name_input_obj.char_name_input;
}

