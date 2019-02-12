Shader "Caio/BumpDiffuse" {
	Properties {
		_myDiffuse("Diffuse Textyre", 2D) = "white" {}
		_myBump("Bump Textyre", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myBrightness("Brightness Amount", Range(0,10)) = 1
	}

	SubShader {
		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _myDiffuse;
		sampler2D _myBump;
		half _mySlider;
		half _myBrightness;

		struct Input {
			float2 uv_myDiffuse;
			float2 uv_myBump;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
			o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
			o.Normal *= float3(_mySlider, _mySlider, 1);
			//o.Albedo *= _myBrightness;//bad
		}

		ENDCG
	}
	FallBack "Diffuse"
}
