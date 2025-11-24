draw_set_alpha(alpha);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var xx = view_wport[0]/2;
var yy = view_hport[0]/2 + yOffset;

//Ignore feather warning (it works) (just always set sprite var to asset type)
if (sprite != "none")
	draw_sprite_ext((sprite),1,xx,yy,2,2,0,c_white,alpha);

draw_set_color(c_black);
for (var dx = -2; dx <= 2; dx++) {
    for (var dy = -2; dy <= 2; dy++) {
        if (dx != 0 || dy != 0) {
            draw_text_ext_transformed(xx + dx, yy + dy, msg, 1, 400, 4, 4, 0);
        }
    }
}

draw_set_color(c_white);

draw_text_ext_transformed_color(xx,yy, msg,1,400,4,4,0,c_white,c_white,gradientColor,gradientColor,alpha);


draw_set_alpha(1); // reset alpha
draw_set_halign(fa_left);
draw_set_valign(fa_top);
