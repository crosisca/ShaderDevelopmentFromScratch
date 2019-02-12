Shader "Caio/DotProduct"
{
	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float3 viewDir;
			};

			sampler2D _MainTex;

			void surf(Input IN, inout SurfaceOutput o)
			{
				half dotp = dot(IN.viewDir, o.Normal);
				//half dotp = 1 - dot(IN.viewDir, o.Normal);
				//o.Albedo = float3(dotp, 1, 1);
				//Albedo = float3(1, dotp, 1);

				//blue with light blue outline
				//o.Albedo = float3(0, 1 - dot(IN.viewDir, o.Normal), 1);

				//yellow middle, green middle, blueish outline	
				//o.Albedo = float3(dot(IN.viewDir, o.Normal), 1, 1 - dot(IN.viewDir, o.Normal)	);

				//black red outline
				//o.Albedo.r = 1 - dot(IN.viewDir, o.Normal);

				//Black green outline
				o.Albedo.gb = float2(1 - dot(IN.viewDir, o.Normal), 0);
			}
		ENDCG
	}
	Fallback "Diffuse"
}