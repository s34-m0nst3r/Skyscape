function src_format_one_dec(n) {
    var dec = frac(n);                //fractional part
    var d1 = round(dec * 10);         //first decimal digit
    if (d1 == 0) return string(floor(n));
    return string_format(n, 1, 1);    //one decimal place
}