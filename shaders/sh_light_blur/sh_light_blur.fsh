varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 pixelSize;

void main()
{
    vec4 sum = vec4(0.0);
    float totalAlpha = 0.0;

    // 5x5 box blur
    for (int x = -2; x <= 2; x++) {
        for (int y = -2; y <= 2; y++) {
            vec2 offset = vec2(float(x), float(y)) * pixelSize;
            vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord + offset);
            sum += sample * sample.a;
            totalAlpha += sample.a;
        }
    }

    if (totalAlpha > 0.0)
        sum /= totalAlpha;
    else
        sum = vec4(0.0);

    gl_FragColor = v_vColour * sum;
}
