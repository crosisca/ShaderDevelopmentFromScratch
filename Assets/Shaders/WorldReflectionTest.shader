Shader "Caio/WorldReflectionTest" {
	
	SubShader {
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = IN.worldRefl;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
