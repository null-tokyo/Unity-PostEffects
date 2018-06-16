using System.Collections;
using System.Collections.Generic;
using UnityEngine;

class ShaderPropaty{
	public string key;
	public string name;
	public string type;

	public ShaderPropaty(string _key, string _name, string _type) {
		key = _key;
		name = _name;
		type =_type;
	}
}

public class PostEffectsController : MonoBehaviour {
	public Material material;
	private Dictionary<string, ShaderPropaty> shaderPropaties = new Dictionary<string, ShaderPropaty>();

	// Use this for initialization
	void Start () {
		shaderPropaties.Add("Effect1", new ShaderPropaty("_USE_MIRROR", "_UseMirror", "toggle"));
		shaderPropaties.Add("Effect2", new ShaderPropaty("_USE_NOISE", "_UseNoise", "toggle"));
		shaderPropaties.Add("Effect3", new ShaderPropaty("_USE_DOTS", "_UseDots", "toggle"));
		shaderPropaties.Add("Effect4", new ShaderPropaty("_USE_MIX_COLOR", "_UseMixColor", "toggle"));
		shaderPropaties.Add("Effect5", new ShaderPropaty("_USE_INVERT", "_UseInvert", "toggle"));
	}
	
	// Update is called once per frame
	void Update () {
		foreach(string key in shaderPropaties.Keys) {
			if(Input.GetButtonUp(key)) {
				setShaderValue(shaderPropaties[key]);
			}
		}
	}

	void setShaderValue(ShaderPropaty prop){
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
