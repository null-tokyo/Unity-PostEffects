#define PI 3.14159265359
#define TWO_PI 6.28318530718

float4 PEMixColor (float2 st, float4 col) {
    float3 colorA = float3(0.98, 0.4, 0.2);
    float3 colorB = float3(0.88, 0.88, 0.2);
    float3 colorC = float3(0.2, 0.4, 0.98);

    st = st * 0.2;
    float rn = snoise(float2(snoise(st + _Time.y * 0.01), st.y * 0.5));
    float gn = snoise(float2(snoise(st + _Time.y * 0.07), st.y * 0.5));
    float bn = snoise(float2(snoise(st + _Time.y * 0.03), st.y * 0.5));

    float3 color = col.rgb; 

    color += smoothstep(0.0, 1.0, lerp(color, colorA, rn));
    color += smoothstep(0.0, 1.0, lerp(color, colorB, gn));
    color += smoothstep(0.0, 1.0, lerp(color, colorC, bn));

    col.rgb = color + 0.2;

    return col;
}