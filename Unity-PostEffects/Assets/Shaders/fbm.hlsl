// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
#define OCTAVES 3
float fbm (float2 st) {
    // Initial values
    float value = 0.0;
    
    float lacunarity = 2.0;
    float gain = 0.5;

    float amplitude = 0.5;
    float frequency = 0.5;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * snoise(st * frequency);
        st *= lacunarity;
        amplitude *= gain;
    }
    return value;
}
