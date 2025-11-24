// obj_player: Key Press <Any Key>
if (search_active) {

    // Enter closes focus
    if (keyboard_key == vk_enter) {
        search_active = false;
    }
    // Printable characters
    else {
        // A–Z
        if (keyboard_key >= ord("A") && keyboard_key <= ord("Z")) {
            var letter = chr(keyboard_key);

            // Apply shift for uppercase, otherwise lowercase
            if (keyboard_check(vk_shift)) {
                search_text += string_upper(letter);
            } else {
                search_text += string_lower(letter);
            }
        }

        // Spacebar allowed too
        else if (keyboard_key == vk_space) {
            search_text += " ";
        }
    }
}
