Shader "Caio/LogicalCutoffsChallenge"
{
    Properties
    {
		_MainTex("Diffuse", 2D) = "white" {}
		_RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
		_StripeSize("Stripe Size", Range(1, 50)) = 0.5
    }

    SubShader
    {
        
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        struct Input
        {
			float3 viewDir;
			float3 worldPos;
			float2 uv_MainTex;
        };

		float4 _RimColor;
		float _StripeSize;
		sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
			//using .rgb after albedo and tex2D return does not make a difference
			//o.Albedo.rgb = tex2D(_MainTex, IN.uv_MainTex).rgb;
			//o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);

			//half rim = 1 - dot(normalize(IN.viewDir), o.Normal);
			//o.Emission = _RimColor.rgb * rim;
			
			//saturate returns a value between 0 and 1...old rim was -1 to 1
			//half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//o.Emission = _RimColor.rgb * rim;

			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//original color multiplied by rim
			//o.Emission = _RimColor.rgb * rim > 0.5 ? rim : 0;

			//original color at full (multiplied by 1)
			//o.Emission = _RimColor.rgb * rim > 0.5 ? 1 : 0;

			//change color to full red
			//o.Emission =  rim > 0.5 ? float3(1,0,0) : 0;

			//nested conditions: red > green
			//o.Emission = rim > 0.5 ? float3(1, 0, 0) : rim > 0.3 ? float3(0, 1, 0) : 0;

			//World position
			//o.Emission = IN.worldPos.y > 1 ? float3(0, 1, 0) : float3(1,0,0);

			//frac tira os inteiros e retorna o resto(decimal)..usar 0.4 ao inves de 0.5 por causa da perda de fraçao(0.5 pode vir como 0.499999)
			//o.Emission = frac(IN.worldPos.y * 10 / 2) > 0.4 ? float3(0, 1, 0) : float3(1, 0, 0);

			//multiplicado por "rim" eu volto a colocar o depth da normal
			o.Emission = frac(IN.worldPos.y * _StripeSize * 0.5) > 0.4 ? float3(0, 1, 0) * rim : float3(1, 0, 0) * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
