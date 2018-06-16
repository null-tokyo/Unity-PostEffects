Shader "PostEffects/dots"
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
			#include "circle.hlsl"

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
				float2 fpos = frac(i.uv * 120);
				float2 ipos = floor(i.uv * 120) / 120;
				fixed4 col = tex2D(_MainTex, ipos);
				float d = circle(fpos - float2(0.5, 0.5), 0.20 * (col.r + col.g + col.b) * 0.3333);
				// just invert the colors
				col.rgb = col.rgb * d;
				return col;
			}
			ENDCG
		}
	}
}
