Shader "Caio/ToonRamp" {
Properties{
		_Color("Color", Color) = (1,1,1,1)
		_RampTex("Ramp Texturue", 2D) = "white"{}
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
		#pragma surface surf ToonRamp
		
		float4 _Color;
		sampler2D _RampTex;

		float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float diff = dot(s.Normal, lightDir);
			float h = diff * 0.5 + 0.5f;//not halfway vector like blinn!!!.. h is used as the uuv value for pulling out the texture components in the ramp texture
			//diff/dot equals 1 mean 1,1 on the uv coordinates(white/right). while = 0 means 0,0 on uv coordinates(black/left)
			float2 rh = h;
			float3 ramp = tex2D(_RampTex, rh).rgb;

			float4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;
			return c; 
		}

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
