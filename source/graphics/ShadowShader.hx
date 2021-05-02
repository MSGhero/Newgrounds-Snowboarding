package graphics;

import openfl.display.GraphicsShader;

class ShadowShaderLarge extends GraphicsShader {
	
	@:glVertexSource("
		#pragma header
		
		void main(void) {
			gl_Position = openfl_Matrix * (openfl_Position + vec4(-12.0, 0.0, 0.0, 0.0));
		}
	")
	
	@:glFragmentSource("
		#pragma header
		
		void main(void) {
			gl_FragColor = vec4(0.0, 0.188, 0.612, 1.0) * 0.15;
		}
	")
	
	public function new() {
		super();
	}
}

class ShadowShaderSmall extends GraphicsShader {
	
	@:glVertexSource("
		#pragma header
		
		void main(void) {
			gl_Position = openfl_Matrix * (openfl_Position + vec4(-6.0, 10.0, 0.0, 0.0));
		}
	")
	
	@:glFragmentSource("
		#pragma header
		
		void main(void) {
			gl_FragColor = vec4(0.0, 0.188, 0.612, 1.0) * 0.4;
		}
	")
	
	public function new() {
		super();
	}
}