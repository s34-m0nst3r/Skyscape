function get_sky_color(time) {
    var midnight = c_black;
    var sunrise  = make_color_rgb(250, 120, 168);
    var day      = make_color_rgb(35, 88, 247); 
    var sunset   = make_color_rgb(247, 81, 27);
    var night    = make_color_rgb(9, 9, 10);

    var sunrise_start = 0.15;
    var sunrise_end   = 0.25;
    var sunset_start  = 0.65;
    var sunset_end    = 0.75;

    if (time < sunrise_start) {// midnight - night before sunrise
        return merge_color(night, night, 0);
    }
    else if (time < sunrise_end) {// night - sunrise
        return merge_color(night, sunrise, (time - sunrise_start) / (sunrise_end - sunrise_start));
    }
    else if (time < sunset_start) {// sunrise - full day
        return merge_color(sunrise, day, (time - sunrise_end) / (sunset_start - sunrise_end));
    }
    else if (time < sunset_end) { // day →-sunset
        return merge_color(day, sunset, (time - sunset_start) / (sunset_end - sunset_start));
    }
    else {// sunset - night
        return merge_color(sunset, night, (time - sunset_end) / (1 - sunset_end));
    }
}


function merge_color(c1, c2, t){
    //Linear interpolate RGB components
    var r = lerp((c1 >> 16) & 0xFF, (c2 >> 16) & 0xFF, t);
    var g = lerp((c1 >> 8) & 0xFF, (c2 >> 8) & 0xFF, t);
    var b = lerp(c1 & 0xFF, c2 & 0xFF, t);
    return make_color_rgb(r, g, b);
}

function lerp(a, b, t){
    return a + (b-a)*t;
}
