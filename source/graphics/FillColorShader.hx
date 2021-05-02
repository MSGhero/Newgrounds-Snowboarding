package graphics;

import openfl.display.GraphicsShader;

class FillColorShader extends GraphicsShader {
	
	@:glFragmentSource("
		#pragma header
		
		uniform vec4 color;
		
		void main(void) {
			gl_FragColor = color;
		}
	")
	
	public function new() {
		super();
	}
}