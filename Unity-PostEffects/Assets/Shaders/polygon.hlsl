//多角形を書く
float polygon (float2 st, float2 p, int N) {
    st.x += p.x;
    st.y += p.y;
    float r = TWO_PI / float(N);
    float a = atan2(st.y, st.x) + (PI / N) + (PI / N) * 0.5;
    float d = cos(floor(0.5 + a / r) * r - a) * length(st);
    return d;
}