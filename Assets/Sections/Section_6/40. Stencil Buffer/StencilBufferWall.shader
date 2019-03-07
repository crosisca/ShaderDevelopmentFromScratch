Shader "Caio/StencilBufferWall"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
       
		Stencil
		{
			Ref 1
			//If you find a 1 in the stencil buffer for this pixel, then dont draw it
			Comp notequal
			//But if it's not equal to 1, then draw it.
			Pass keep
		}

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
