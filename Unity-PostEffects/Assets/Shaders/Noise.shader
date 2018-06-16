Shader "PostEffects/Noise"
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

			float2 noise(float2 st, float power) {
				st.x += step(power, (fbm(float2(st.x, floor(st.x * 5.0)) + _Time.y * 10.0))) * 0.01;

				st.y += step(power, (fbm(float2(st.y, floor(st.y * 5.0)) + _Time.y * 10.0))) * 0.01;

				return st;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				float2 st = i.uv;
				float r = tex2D(_MainTex, noise(st, 0.4)).r;
				float g = tex2D(_MainTex, noise(st, 0.5)).g;
				float b = tex2D(_MainTex, noise(st, 0.6)).b;

				float3 col = float3(r, g, b);
				return float4(col, 1.0);
			}
			ENDCG
		}
	}
}
