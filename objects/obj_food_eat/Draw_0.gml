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
        x,
        y,
        scale  * (facing == 0 ? -1 : 1),
        scale,
        0,
        c_white,
        image_alpha
    );
}
