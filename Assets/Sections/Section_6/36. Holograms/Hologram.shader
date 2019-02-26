﻿Shader "Caio/Hologram"
{
    Properties
    {
		_RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_RimPower("Rim Pow", Range(0.5, 8)) = 3
    }
    SubShader
    {
		Tags {"Queue"="Transparent"}
        
		Pass
		{
			ZWrite On
			ColorMask 0
		}

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        struct Input
        {
			float3 viewDir;
        };

		float4 _RimColor;
		float _RimPower;

        void surf (Input IN, inout SurfaceOutput o)
        {
			//saturate returns a value between 0 and 1...old rim was -1 to 1
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow (rim, _RimPower) * 10;
			o.Alpha = pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
