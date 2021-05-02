package graphics;

import openfl.display.DisplayObjectShader;

class RailShader extends DisplayObjectShader {
	
	@:glFragmentSource("
		#pragma header
		
		void main(void) {
			
			vec2 lineThickness = 10.0 / openfl_TextureSize;
			vec4 lineColor = vec4(0.1, 0.1, 0.1, 1.0);
			
			vec4 color = texture2D(openfl_Texture, openfl_TextureCoordv);
			
			if (color != vec4(0.0) && texture2D(openfl_Texture, openfl_TextureCoordv + vec2(0, -lineThickness.y)) == vec4(0.0)) gl_FragColor = lineColor;
			else gl_FragColor = color;
		}
	")
	
	public function new() {
		super();
	}
}