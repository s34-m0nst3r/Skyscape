function scr_growth_block_exists() {
    for (var i = 0; i < array_length(global.growthBlocks); i++) {
        var entry = global.growthBlocks[i];
        if (entry.xp == argument0 && entry.yp == argument1) {
            return true;
        }
    }
    return false;
}
