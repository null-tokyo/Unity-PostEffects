#define PI 3.14159265359
#define TWO_PI 6.28318530718

float4 PEMirror(float2 _st, sampler2D _MainTex) {
    float divide = 2.0;
    float2 st = _st * 2.0 - 1.0;
    float r = atan2(st.y, st.x);
    float index = floor((r / TWO_PI + TWO_PI / divide / 2) * divide) % 2;
    float ra = frac(r / TWO_PI * divide) * (TWO_PI / divide) + _Time.y * 0.4;
    float dist = distance(float2(0.0, 0.0), st);

    st.x = dist * cos(ra) * 0.5 + 0.5;
    st.y = dist * sin(ra) * 0.5 + 0.5;

    float3 col = tex2D(_MainTex, st);
    return float4(col, 1.0);
}