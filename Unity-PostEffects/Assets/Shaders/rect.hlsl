//四角形を描く
float rect (float2 st, float2 p, float w, float h) {
    float width = (1.0 - w) / 2.0;
    float height = (1.0 - h) / 2.0;

    float2 pos = (st + p) - float2(0.5, 0.5);

    float t = step(width, 1.0 - pos.x);
    float r = step(height, 1.0 - pos.y);
    float b = step(width, pos.x);
    float l = step(height, pos.y);
    return t * r * b * l;
}