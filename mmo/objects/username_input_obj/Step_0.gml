if (user_focus) {
    user_input = keyboard_string;
}
if (keyboard_check(vk_tab)){
    user_focus = false;
    password_input_obj.pass_focus = true;
    keyboard_string = password_input_obj.pass_input;
}

