package graphics;

import openfl.display.DisplayObjectShader;

class FXAAShader extends DisplayObjectShader {
	
	// https://github.com/mattdesl/glsl-fxaa/blob/master/fxaa.glsl
	
	@:glFragmentSource("
		#pragma header
		
		#ifndef FXAA_REDUCE_MIN
			#define FXAA_REDUCE_MIN   (1.0/ 128.0)
		#endif
		#ifndef FXAA_REDUCE_MUL
			#define FXAA_REDUCE_MUL   (1.0 / 8.0)
		#endif
		#ifndef FXAA_SPAN_MAX
			#define FXAA_SPAN_MAX     4.0
		#endif
		
		uniform bool enabled;
		
		vec4 fxaa(sampler2D tex, vec2 fragCoord, vec2 invReso) {
			vec4 color;
			
			vec4 middle = texture2D(tex, fragCoord);
			vec3 luma = vec3(0.299, 0.587, 0.114);
			float lumaNW = dot(luma, texture2D(tex, fragCoord + vec2(-invReso.x, -invReso.y)).rgb);
			float lumaNE = dot(luma, texture2D(tex, fragCoord + vec2(invReso.x, -invReso.y)).rgb);
			float lumaSW = dot(luma, texture2D(tex, fragCoord + vec2(-invReso.x, invReso.y)).rgb);
			float lumaSE = dot(luma, texture2D(tex, fragCoord + vec2(invReso.x, invReso.y)).rgb);
			float lumaM = dot(luma, middle.rgb);
			float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    			float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));
			    
			vec2 dir = vec2(
				-((lumaNW + lumaNE) - (lumaSW + lumaSE)),
				((lumaNW + lumaSW) - (lumaNE + lumaSE))
			);
			
			float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) * 0.25 * FXAA_REDUCE_MUL, FXAA_REDUCE_MIN);
			float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
			dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX), max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX), dir * rcpDirMin)) * invReso;
			
			vec3 rgbA = 0.5 * (
				texture2D(tex, fragCoord + dir * (1.0 / 3.0 - 0.5)).rgb +
				texture2D(tex, fragCoord + dir * (2.0 / 3.0 - 0.5)).rgb);
			vec3 rgbB = rgbA * 0.5 + 0.25 * (
				texture2D(tex, fragCoord + dir * -0.5).rgb +
				texture2D(tex, fragCoord + dir * 0.5).rgb);
			
			float lumaB = dot(rgbB, luma);
			
			if (lumaB < lumaMin || lumaB > lumaMax)
				color = vec4(rgbA, middle.a);
			else
				color = vec4(rgbB, middle.a);
			
			return color;
		}
		
		void main(void) {
			
			if (enabled) {
				gl_FragColor = fxaa(openfl_Texture, openfl_TextureCoordv, 1.0 / openfl_TextureSize);
			}
			
			else {
				gl_FragColor = texture2D(openfl_Texture, openfl_TextureCoordv);
			}
		}
	")
	
	public function new() {
		super();
	}
}