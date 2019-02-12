Shader "Caio/BasicLambert2"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_SpecColor("Spec Color", Color) = (1,1,1,1)
		_Spec("Specular", Range(0,1)) = 0.5 //size of specular
		_Gloss("Gloss", Range(0,1)) = 0.5 //'pow'er of specular
	}
	SubShader
	{
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf BlinnPhong

		float4 _Color;
		//Dont add SpecColor because its already defined in the include files Unity builds this code togheter when compiling it. if you redefine it will get an error saying its redefined
		half _Spec;
		fixed _Gloss;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
			o.Specular = _Spec;
			o.Gloss = _Gloss;
		}
		ENDCG
	}
	FallBack "Diffuse"
}