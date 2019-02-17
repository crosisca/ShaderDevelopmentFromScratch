Shader "Caio/BasicBlinnPhongLightningModel" 
{
	Properties{
		_Colour("Colour", Color) = (1,1,1,1)
	}
	SubShader{
		Tags{
			"Queue" = "Geometry"
		}


		CGPROGRAM
		#pragma surface surf BasicBlinnPhong

		half4 LightingBasicBlinnPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h = normalize(lightDir + viewDir);//halfway = halfway between lightvector and viewvector

			half diff = max(0, dot(s.Normal, lightDir));//diffuse value..size of the angle between the surface normal and the light direction, the closer they are together, the stronger the point will be. min = 0

			float nh = max(0, dot(s.Normal, h));
			float spec = pow(nh, 48.0); // 48 is what unity uses

			half4 c;
	        c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
	        c.a = s.Alpha;
	        return c;

		}
		float4 _Colour;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Colour.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"

}
