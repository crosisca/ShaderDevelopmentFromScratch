Shader "Caio/ColorVF"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION; // planes have X and Z axis. not Y!!! (horizontal). Need to swap Y and Z on objects that are upright (vertical)
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float4 color: COLOR;
            };

			//This runs on every vertex. Which is then passed into the frag function (lighter).Colors shoudl be changed here when possible instad of on frag()
            v2f vert (appdata v)
            {
                v2f o; // this is the same as v2f i, declared as a parameter on the frag function (*1). It changes names because it's being returned (inside code)
                o.vertex = UnityObjectToClipPos(v.vertex); //Convert world data into clipping space structure. (Squashes data into 2D)
				//set red channel color to X coordinate coming in from the original data from the mesh. 
				//This means you can move the mesh and it wont effect how you color the surface. 
				//o.color.r = v.vertex.x; 
				//o.color.r = v.vertex.x + 5; // plane had 5 max coordinates
				//o.color.r = (v.vertex.x + 5) / 5; // smoothing/spread colors acrros the entire mesh
				//o.color.r = (v.vertex.x + 5) / 10; // smoothing/spread colors acrros the entire mesh
				//o.color.r = (v.vertex.x + 10) / 20; // smoothing/spread colors acrros the entire mesh
				//o.color.r = (v.vertex.x + 10) / 10; // blend
				//o.color.g = (v.vertex.z + 10) / 10; // blend
                return o;
            }


			//This runs on every pixel (heavier)
            fixed4 frag (v2f i) : SV_Target// *1
            {
				//fixed4 col = fixed4(0,1,0,1); //set color green
				//fixed4 col = i.color;
				fixed4 col;
				//col.r = (i.vertex.x + 10) / 10; // here vertex are on screenSpace so adding and dividing by 10 is not doing much
				//col.g = (i.vertex.x + 10) / 10;// here vertex are on screenSpace so adding and dividing by 10 is not doing much

				col.r = i.vertex.x / 1000; // here vertex are on screenSpace so adding and dividing by 10 is not doing much
				col.g = i.vertex.y / 1000;// here vertex are on screenSpace Z becomes Y

                return col;
            }
            ENDCG
        }
    }
}
