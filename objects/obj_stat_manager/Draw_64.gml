var cursor_x = device_mouse_x_to_gui(0);
var cursor_y = device_mouse_y_to_gui(0);


/// DRAW HEALTH
start_x         = 1000;
start_y         = 20;
//Number of hearts to draw 
var hearts_to_draw = ceil(maxHp / symbol_value);
if (hearts_to_draw > max_symbols) hearts_to_draw = max_symbols;
//Bonus hearts_to_draw
var bonus_to_draw = (hp - total_max_value)/symbol_value;
//Regular hearts to draw
var regular_hearts_to_draw = (hp)/symbol_value;
for (var i = 0; i < hearts_to_draw; i++)
{
    var row = i div symbols_per_row;
    var col = i mod symbols_per_row;

    //Flip horizontal direction (right to left)
    var flipped_col = (symbols_per_row - 1) - col;

    var xx = start_x + flipped_col * 20;
    var yy = start_y + row * row_height;

	var spr = spr_heart_empty;
	if (bonus_to_draw > 0)
	{
		bonus_to_draw--;
		spr = spr_heart_bonus;
	}
	else if (regular_hearts_to_draw > 0)
	{
		regular_hearts_to_draw--;
		spr = spr_heart;
	}
    draw_sprite(spr, 0, xx, yy);
}

	

	
	

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,false);
draw_set_color(c_red);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,true);

draw_set_alpha(1);
draw_set_color(c_white);
draw_text_ext_transformed(start_x+280+20,start_y,string(int64((hp/maxHp)*100)) + "%",10,100,1.4,1.4,0);

start_y+=45;

//Number of bread to draw 
var bread_to_draw = ceil(maxHunger / symbol_value);
if (bread_to_draw > max_symbols) bread_to_draw = max_symbols;
//Bonus bread
var bonus_bread__to_draw = (hunger - total_max_value)/symbol_value;
//Regular bread to draw
var regular_bread_to_draw = (hunger)/symbol_value;
for (var i = 0; i < bread_to_draw; i++)
{
    var row = i div symbols_per_row;
    var col = i mod symbols_per_row;

    //Flip horizontal direction (right to left)
    var flipped_col = (symbols_per_row - 1) - col;

    var xx = start_x + flipped_col * 20;
    var yy = start_y + row * row_height;

	var spr = spr_bread_empty;
	if (bonus_bread__to_draw > 0)
	{
		bonus_bread__to_draw--;
		spr = spr_bread_bonus;
	}
	else if (regular_bread_to_draw > 0)
	{
		regular_bread_to_draw--;
		spr = spr_bread;
	}
    draw_sprite(spr, 0, xx, yy);
}

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,false);
draw_set_color(c_yellow);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,true);

draw_set_alpha(1);
draw_set_color(c_white);
draw_text_ext_transformed(start_x+280+20,start_y,string(int64((hunger/maxHunger)*100)) + "%",10,100,1.4,1.4,0);

start_y+=45;

//Number of mana to draw 
var mana_to_draw = ceil(maxMana / symbol_value);
if (mana_to_draw > max_symbols) mana_to_draw = max_symbols;
//Bonus mana_to_draw
var bonus_mana__to_draw = (mana - total_max_value)/symbol_value;
//Regular mana to draw
var regular_mana_to_draw = (mana)/symbol_value;
for (var i = 0; i < mana_to_draw; i++)
{
    var row = i div symbols_per_row;
    var col = i mod symbols_per_row;

    //Flip horizontal direction (right to left)
    var flipped_col = (symbols_per_row - 1) - col;

    var xx = start_x + flipped_col * 20;
    var yy = start_y + row * row_height;

	var spr = spr_mana_empty;
	if (bonus_mana__to_draw > 0)
	{
		bonus_mana__to_draw--;
		spr = spr_mana_bonus;
	}
	else if (regular_mana_to_draw > 0)
	{
		regular_mana_to_draw--;
		spr = spr_mana;
	}
    draw_sprite(spr, image_index, xx, yy);
}

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,false);
draw_set_color(c_purple);
draw_rectangle(start_x+280+20,start_y,start_x+280+70,start_y+30,true);

draw_set_alpha(1);
draw_set_color(c_white);
draw_text_ext_transformed(start_x+280+20,start_y,string(int64((mana/maxMana)*100)) + "%",10,100,1.4,1.4,0);



//HEALTH & HUNGER & MANA HOVER OVER DISPLAYS
var info;
var hover = false;
if (cursor_x > 1000 && cursor_x < 1500 &&
		        cursor_y > 20 - 15 && cursor_y < 20 + 65)
{
	info = "Health: " + string(hp) + "/" + string(maxHp);
	hover = true;	
}
if (cursor_x > 1000 && cursor_x < 1500 &&
		        cursor_y > 20 + (45) - 15 && cursor_y < 20 + (45) + 65)
{
	info = "Hunger: " + string(hunger) + "/" + string(maxHunger);
	hover = true;	
}

if (cursor_x > 1000 && cursor_x < 1500 &&
		        cursor_y > 20 + (45*2) - 15 && cursor_y < 20 + (45*2) + 65)
{
	info = "Mana: " + string(mana) + "/" + string(maxMana);
	hover = true;	
}

if (hover)
{
	var halign = draw_get_halign();
	var valign = draw_get_valign();
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_set_color(c_black);
	draw_rectangle(cursor_x-2, cursor_y-2, cursor_x+200, cursor_y+string_height(info)+2, false);
	draw_set_color(c_white);
	draw_text(cursor_x, cursor_y, info);
			
	draw_set_halign(halign);
	draw_set_valign(valign);
}

