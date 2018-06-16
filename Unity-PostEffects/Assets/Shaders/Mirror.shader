Shader "PostEffects/Mirror"
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
				float divide = 2.0;
				float2 st = i.uv * 2.0 - 1.0;
				float r = atan2(st.y, st.x);
				float index = floor((r / TWO_PI + TWO_PI / divide / 2) * divide) % 2;
				float ra = frac(r / TWO_PI * divide) * (TWO_PI / divide) + _Time.y * 0.4;
				float dist = distance(float2(0.0, 0.0), st);

				st.x = dist * cos(ra) * 0.5 + 0.5;
				st.y = dist * sin(ra) * 0.5 + 0.5;
			
				float3 col = tex2D(_MainTex, st);
				return float4(col, 1.0);
			}
			ENDCG
		}
	}
}
