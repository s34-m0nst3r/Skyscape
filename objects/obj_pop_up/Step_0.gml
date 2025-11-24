//Rise up
yOffset += speed_y;

//Fade 0ut
if (lifetime < fade_time) {
    alpha = lifetime / fade_time;
}

//Count down
lifetime--;
if (lifetime <= 0) {
    instance_destroy();
}
