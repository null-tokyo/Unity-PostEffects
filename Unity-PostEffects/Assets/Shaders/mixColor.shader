Shader "PostEffects/mixColor"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
            #include "snoise.hlsl"
			#include "fbm.hlsl"

            #define PI 3.14159265359
			#define TWO_PI 6.28318530718

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
                float3 colorA = float3(0.98, 0.4, 0.2);
                float3 colorB = float3(0.88, 0.88, 0.2);
                float3 colorC = float3(0.2, 0.4, 0.98);

                float2 st = i.uv * 0.2;
                float rn = snoise(float2(snoise(st + _Time.y * 0.01), st.y * 0.5));
                float gn = snoise(float2(snoise(st + _Time.y * 0.07), st.y * 0.5));
                float bn = snoise(float2(snoise(st + _Time.y * 0.03), st.y * 0.5));

				fixed4 col = tex2D(_MainTex, i.uv);
                float3 color = col.rgb; 

                color += smoothstep(0.0, 1.0, lerp(color, colorA, rn));
                color += smoothstep(0.0, 1.0, lerp(color, colorB, gn));
                color += smoothstep(0.0, 1.0, lerp(color, colorC, bn));

                col.rgb = color + 0.2;

				return col;
			}
			ENDCG
		}
	}
}
