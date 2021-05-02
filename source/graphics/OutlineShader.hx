package graphics;

import openfl.display.DisplayObjectShader;

class OutlineShader extends DisplayObjectShader {
	
	@:glFragmentSource("
		#pragma header
		
		uniform vec4 baseline;
		
		void main(void) {
			
			vec2 lineThickness = 2.0 / openfl_TextureSize;
			vec4 lineColor = vec4(0.145, 0.2, 0.365, 1.0);
			
			vec4 color = texture2D(openfl_Texture, openfl_TextureCoordv);
			
			if (length(color - baseline) < 0.1) {
				
				// if any of the surrounding pixels are not the same as this && this is the baseline color, outline
				vec4 outline = texture2D(openfl_Texture, openfl_TextureCoordv + vec2(-lineThickness.x, 0)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(0, lineThickness.y)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(lineThickness.x, 0)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(0, -lineThickness.y)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(-lineThickness.x, lineThickness.y)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(lineThickness.x, lineThickness.y)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(-lineThickness.x, -lineThickness.y)) - baseline;
				outline += texture2D(openfl_Texture, openfl_TextureCoordv + vec2(lineThickness.x, -lineThickness.y)) - baseline;
				
				if (length(outline) > 0.1) gl_FragColor = lineColor;
				else gl_FragColor = color;
			}
			
			else {
				gl_FragColor = color;
			}
		}
	")
	
	public function new() {
		super();
	}
}