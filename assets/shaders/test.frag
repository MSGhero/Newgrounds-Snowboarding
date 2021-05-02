#ifdef GL_ES
precision mediump float;
#endif

void main() {
	if (openfl_TextureCoordv.x < .5)
		gl_FragColor = vec4(0.357, 0.369, 0.525, 1.0); // rgba
	else
		gl_FragColor = vec4(1);
}