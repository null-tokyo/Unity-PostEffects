using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class ShaderProp{
	public string key;
	public string name;
	public string type;

	public ShaderProp(string _key, string _name, string _type) {
		key = _key;
		name = _name;
		type =_type;
	}
}

public class PostEffectsManager : MonoBehaviour {
	public Material material;
	private Dictionary<string, ShaderProp> shaderPropaties = new Dictionary<string, ShaderProp>();

	// Use this for initialization
	void Start () {
		shaderPropaties.Add("Effect1", new ShaderProp("_USE_MIRROR", "_UseMirror", "toggle"));
		shaderPropaties.Add("Effect2", new ShaderProp("_USE_NOISE", "_UseNoise", "toggle"));
		shaderPropaties.Add("Effect3", new ShaderProp("_USE_DOTS", "_UseDots", "toggle"));
		shaderPropaties.Add("Effect4", new ShaderProp("_USE_MIX_COLOR", "_UseMixColor", "toggle"));
		shaderPropaties.Add("Effect5", new ShaderProp("_USE_INVERT", "_UseInvert", "toggle"));
	}
	
	// Update is called once per frame
	void Update () {
		foreach(string key in shaderPropaties.Keys) {
			if(Input.GetButtonUp(key)) {
				setShaderValue(shaderPropaties[key]);
			}
		}
	}

	void setShaderValue(ShaderProp prop){
		if(prop.type == "toggle") {
			float val = material.GetFloat(prop.name);
			if(val > 0.0f) {
				material.DisableKeyword(prop.key);
				material.SetFloat(prop.name, 0.0f);
			} else {
				material.EnableKeyword(prop.key);
				material.SetFloat(prop.name, 1.0f);
			}
		}	
	}

	void OnRenderImage(RenderTexture src, RenderTexture dest) {
		Graphics.Blit(src, dest, material);
	}
}
