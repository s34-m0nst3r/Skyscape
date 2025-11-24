var item = global.items[item_id];
if (item != undefined) {
    var spr = item.sprite;
    var size = 16 * scaleSize; // fixed visual size
    var sw = sprite_get_width(spr);
    var sh = sprite_get_height(spr);
    var scale = size / max(sw, sh);

    draw_sprite_ext(
        spr,
        0,
        swing_x,
        swing_y,
        scale,
        scale  * (facing == 0 ? -1 : 1),
        swing_angle_draw,
        c_white,
        1
    );
}
