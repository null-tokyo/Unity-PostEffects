//線を描く
float plot (float2 st, float pct){
    return  smoothstep( pct - 0.1, pct, st.y) - smoothstep( pct, pct + 0.1, st.y);
}