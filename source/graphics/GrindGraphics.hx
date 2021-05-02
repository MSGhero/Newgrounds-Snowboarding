package graphics;

import openfl.Assets;
import openfl.filters.ShaderFilter;
import openfl.display.Shape;
import openfl.Vector;
import openfl.display.BitmapData;

class GrindGraphics extends Shape {
	
	public var tileWidth(get, never):Int;
	inline function get_tileWidth():Int { return tile.width; }
	
	public var tileHeight(get, never):Int;
	inline function get_tileHeight():Int { return tile.height; }
	
	var greyShader:FillColorShader;
	var rail:ShaderFilter;
	var fxaaFilter:ShaderFilter;
	var fxaa:FXAAShader;
	
	var tile:BitmapData;
	
	public function new() {
		super();
		
		graphics.beginFill(0x0);
		graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
		graphics.endFill();
		
		greyShader = new FillColorShader();
		greyShader.color.value = [0.4, 0.4, 0.4, 1.0];
		greyShader.bitmap.input = new BitmapData(1, 1, true, 0x0); // it crashes after a few seconds without this...
		
		rail = new ShaderFilter(new RailShader());
		
		fxaa = new FXAAShader();
		fxaa.enabled.value = [true];
		fxaaFilter = new ShaderFilter(fxaa);
		
		tile = Assets.getBitmapData("assets/images/Rail_strut_loop.png");
	}
	
	public function clear():Void {
		graphics.clear();
	}
	
	public function draw(verts:Vector<Float>, uvs:Vector<Float>):Void {
		
		graphics.beginBitmapFill(tile);
		graphics.drawTriangles(verts, null, uvs);
		
		graphics.endFill();
		
		filters = [rail, fxaaFilter];
	}
}