Shader "Caio/BumpedEnvChallenge" {
	Properties {
		_myNormal("Normal Map", 2D) = "bump" {}
		_myCube("Cube map", CUBE) = "white" {}
		_NormalMultiplier("Normal Multiplier", Range(0,2)) = 0.3
	}
		SubShader{

			CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myNormal;
			samplerCUBE _myCube;
			half _NormalMultiplier;

		struct Input {
			float2 uv_MainTex;
			float2 uv_myNormal;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * _NormalMultiplier;//0.3
			o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
