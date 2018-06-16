float2 noise(float2 st, float power) {
    st.x += step(power, (fbm(float2(st.x, floor(st.x * 5.0)) + _Time.y * 10.0))) * 0.01;

    st.y += step(power, (fbm(float2(st.y, floor(st.y * 5.0)) + _Time.y * 10.0))) * 0.01;

    return st;
}
			
float4 PENoise(float2 st, sampler2D _MainTex) {
    float r = tex2D(_MainTex, noise(st, 0.4)).r;
    float g = tex2D(_MainTex, noise(st, 0.5)).g;
    float b = tex2D(_MainTex, noise(st, 0.6)).b;

    float3 col = float3(r, g, b);
    return float4(col, 1.0);
}