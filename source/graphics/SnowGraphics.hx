package graphics;

import graphics.ShadowShader.ShadowShaderSmall;
import openfl.display.Shape;
import graphics.ShadowShader.ShadowShaderLarge;
import openfl.filters.ShaderFilter;
import openfl.Vector;
import openfl.display.BitmapData;

class SnowGraphics extends Shape {
	
	var shadowShader:ShadowShaderLarge;
	var hardShadowShader:ShadowShaderSmall;
	var snowShader:FillColorShader;
	
	var outline:ShaderFilter;
	var fxaaFilter:ShaderFilter;
	var fxaa:FXAAShader;
	
	public function new() {
		super();
		
		graphics.beginFill(0x0);
		graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
		graphics.endFill();
		
		snowShader = new FillColorShader();
		snowShader.color.value = [0.839, 0.941, 1.0, 1.0];
		snowShader.bitmap.input = new BitmapData(1, 1, true, 0x0); // it crashes after a few seconds without this...
		
		shadowShader = new ShadowShaderLarge();
		shadowShader.bitmap.input = new BitmapData(1, 1, true, 0x0);
		
		hardShadowShader = new ShadowShaderSmall();
		hardShadowShader.bitmap.input = new BitmapData(1, 1, true, 0x0);
		
		var outShader = new OutlineShader();
		outShader.baseline.value = [0.839, 0.941, 1.0, 1.0];
		outline = new ShaderFilter(outShader);
		
		fxaa = new FXAAShader();
		fxaa.enabled.value = [true];
		fxaaFilter = new ShaderFilter(fxaa);
	}
	
	public function clear():Void {
		graphics.clear();
	}
	
	public function draw(shadowVerts:Vector<Float>, shadowIndices:Vector<Int>, snowVerts:Vector<Float>, snowIndices:Vector<Int>):Void {
		
		graphics.beginShaderFill(shadowShader);
		graphics.drawTriangles(shadowVerts, shadowIndices);
		
		graphics.beginShaderFill(hardShadowShader);
		graphics.drawTriangles(snowVerts, snowIndices);
		
		graphics.beginShaderFill(snowShader);
		graphics.drawTriangles(snowVerts, snowIndices);
		
		graphics.endFill();
		
		filters = [outline, fxaaFilter];
	}
}