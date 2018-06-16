
float4 PEInvert (float4 col){
    // just invert the colors
    col.rgb = 1 - col.rgb;
    return col;
}