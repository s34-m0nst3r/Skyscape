function scr_get_ambient_light() {
    // Example: global.time_of_day between 0..1 where 0=midnight, 0.5=noon
    var t = clamp(global.time_of_day, 0, 1);
    // Smoothday curve: low at night, high at noon
    return clamp(0.05 + 0.9 * (1 - abs(t - 0.5) * 2), 0.05, 1);
}