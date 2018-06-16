float4 PEDots (float2 st, float4 col){
    float2 fpos = frac(st * 120);
    float2 ipos = floor(st * 120) / 120;
    float d = circle(fpos - float2(0.5, 0.5), 0.20 * (col.r + col.g + col.b) * 0.3333);
    col.rgb = col.rgb * d;
    return col;
}