Shader "Custom/PropertiesChallenge4" {
	Properties{
		_DiffuseTex("Diffuse", 2D) = "white" {}
		
		//set this texture to black to stop the white
		//overwhelming the effect if no emission texture
		//is present
		_EmissionTex("Emission", 2D) = "black" {}
	}
		SubShader{
			CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _DiffuseTex;
			sampler2D _EmissionTex;

			struct Input {
				float2 uv_DiffuseTex;
				float2 uv_EmissionTex;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_DiffuseTex, IN.uv_DiffuseTex).rgb;
				o.Emission = tex2D(_EmissionTex, IN.uv_EmissionTex).rgb;
			}
			ENDCG
	}
		FallBack "Diffuse"
}
