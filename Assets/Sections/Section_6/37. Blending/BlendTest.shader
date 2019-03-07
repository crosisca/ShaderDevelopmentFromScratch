Shader "Caio/BlendTest"
{
    Properties
    {
		_MainTex("Texture", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
		Blend One One //makes black/white texture show whites and make transparent holes on blacks
		//Blend SrcAlpha OneMinusSrcAlpha //Default Transparency shader blend
		//Blend DstColor Zero //Soft Additive blend, makes black/white texture show blacks and make transparent holes on whites
		Pass{
			SetTexture [_MainTex] { combine texture }
		}
    }
}
//Blend Modes
//One
//Zero
//SrcColor
//SrcAlpha
//DstColor
//DstAlpha
//OneMinusSrcColor
//OneMinusSrcAlpha
//OneMinusDstColor
//OneMinusDstAlpha