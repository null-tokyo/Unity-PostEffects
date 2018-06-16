//円を描く
float circle (float2 p, float radius) {
    return smoothstep(
        0.0,
        1.0,
        1.0 - (step(0.01, length(p) - radius) + smoothstep(0.008, 0.01, length(p) - radius))
    );
}