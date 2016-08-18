Shader "Custom/Banded" {
	Properties {
		_SandColor ("SandColor", Color) = (1,1,1,1)
		_GrassColor ("GrassColor", Color) = (1,1,1,1)
		_MountainColor ("MountainColor", Color) = (1,1,1,1)
		_SnowColor ("SnowColor", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
		
		struct Input {
			float3 localPos;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _WaterColor;
		fixed4 _SandColor;
		fixed4 _GrassColor;
		fixed4 _MountainColor;
		fixed4 _SnowColor;

		void vert (inout appdata_full v, out Input o) {
		   UNITY_INITIALIZE_OUTPUT(Input,o);
		   o.localPos = v.vertex.xyz;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = _SandColor;
			half len = length(IN.localPos);
			if(len >= 1.8){
				c = _SnowColor;
			}
			else if(len >= 1.6){
				c = _MountainColor;
			}
			else if(len >= 1.45){
				c = _GrassColor;
			}

			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
