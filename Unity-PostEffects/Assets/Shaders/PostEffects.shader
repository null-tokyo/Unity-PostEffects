Shader "PostEffects/PostEffect"
{
	Properties
	{
		[Toggle(_USE_MIRROR)]_UseMirror("Use Mirror", Float) = 0
		[Toggle(_USE_NOISE)]_UseNoise("Use Noise", Float) = 0
		[Toggle(_USE_DOTS)]_UseDots("Use Dots", Float) = 0
		[Toggle(_USE_MIX_COLOR)]_UseMixColor("Use MixColor", Float) = 0
		[Toggle(_USE_INVERT)]_UseInvert("Use Invert", Float) = 0	
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

			#pragma multi_compile _ _USE_MIRROR
			#pragma multi_compile _ _USE_NOISE
			#pragma multi_compile _ _USE_DOTS
			#pragma multi_compile _ _USE_MIX_COLOR
			#pragma multi_compile _ _USE_INVERT
			
			#include "UnityCG.cginc"
			#include "circle.hlsl"
			#include "snoise.hlsl"
			#include "fbm.hlsl"

			#include "PEMirror.hlsl"
			#include "PENoise.hlsl"
			#include "PEDots.hlsl"
			#include "PEMixColor.hlsl"
			#include "PEInvert.hlsl"

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
				fixed4 col = tex2D(_MainTex, i.uv);

				#if _USE_MIRROR
				col = PEMirror(i.uv, _MainTex);
				#endif
				
				#if _USE_NOISE
				col = PENoise(i.uv, _MainTex);
				#endif

				#if _USE_MIX_COLOR
				col = PEMixColor(i.uv, col);
				#endif

				#if _USE_DOTS
				col = PEDots(i.uv, col);
				#endif

				#if _USE_INVERT
				col = PEInvert(col);
				#endif

				return col;
			}
			ENDCG
		}
	}
	
	CustomEditor "PostEffectsInspector"
}