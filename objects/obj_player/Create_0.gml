spd = 2;          // horizontal speed
grav = 0.4;       // gravity
gravMax = 3;	  // fastest gravity can make you fall
jump_spd = -6;    // jump velocity
vsp = 0;          // vertical speed
hsp = 0;          // horizontal speed
on_ground = false;
facing = -1 // 0 == left, 1 == right

sprite_index = spr_player_left; 
image_speed = 0;      
depth = -10;
swingingTool = false;
foodItem = false;


//Inventory
hotbar_size = 10;
main_size   = 50;
total_size  = hotbar_size + main_size;

pickup_messages = [];

// Build slots
inventory = array_create(total_size, noone);


// Hotbar selection
hotbar_index = 0;

// Inventory toggle
inv_open = false;

dragging_item = noone;
dragging_index = -1;

block_reach = 9;
magnet = 12; //pickup distance

x = global.spawn_x;
y = global.spawn_y;

global.crafting_scroll  = 0;
craftingHover = -1;
displayCraftingHover = false;

search_text = "";
search_active = false;
waitDelete = false;
workstation = "basic";

platformFalling = false;
workstation_x = 60;
clipFix = false;

mouseToggle=false;
craftingMinimized = false;
alarm[3]=1;

alive = true;
deathMessage = "You died!";
fallDistance = 0;
fallDamage = 2;


eat = 0;
craftDelay = false;
quickSelect = false;

moveSpeedMultiplier = 1;
canBreathe = true;