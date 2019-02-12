Shader "Caio/RimLightning"
{
    Properties
    {
		_RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_RimPow("Rim Pow", Range(0.5, 8)) = 3
    }
    SubShader
    {
        
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        struct Input
        {
			float3 viewDir;
        };

	float4 _RimColor;
	float _RimPow;
        void surf (Input IN, inout SurfaceOutput o)
        {
			//half rim = 1 - dot(normalize(IN.viewDir), o.Normal);
			//o.Emission = _RimColor.rgb * rim;
			
			//saturate returns a value between 0 and 1...old rim was -1 to 1
			//half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//o.Emission = _RimColor.rgb * rim;

			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPow);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
