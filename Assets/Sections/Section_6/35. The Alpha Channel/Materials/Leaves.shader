﻿Shader "Caio/Leaves"
{
    Properties
    {
        _MainTex ("MainTex)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
		
        void surf (Input IN, inout SurfaceOutput o)
        {
			fixed4 color = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = color.rgb;
			o.Alpha = color.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
