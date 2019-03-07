Shader "Caio/StencilBufferHole"
{
    Properties
    {
        _MainTex ("Diffuse", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry-1" } //Geometry -1 means it gets to the stencil buffer first
		
		ColorMask 0 // Turn off color writting
		ZWrite Off //Dont draw it to the depth buffer
		
			Stencil
		{
			Ref 1 //writes 1 to the stencil buffer
			Comp always //compare what was previously in the stencil buffer

			//what we want to do to the pixel that belongs to this geometry in relation on how to draw it to the frame buffer
			Pass replace //replace anything that is in the frame buffer with this pixel pass
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
