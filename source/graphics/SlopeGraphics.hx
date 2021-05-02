package graphics;

import openfl.display.Shape;
import openfl.utils.Assets;
import openfl.Vector;
import openfl.display.BitmapData;

class SlopeGraphics extends Shape {
	
	public var tileWidth(get, never):Int;
	inline function get_tileWidth():Int { return tile.width; }
	
	public var tileHeight(get, never):Int;
	inline function get_tileHeight():Int { return tile.height; }
	
	var tile:BitmapData;
	
	public function new() {
		super();
		
		graphics.beginFill(0x0);
		graphics.drawRect(0, 0, Global.WIDTH, Global.HEIGHT);
		graphics.endFill();
		
		tile = Assets.getBitmapData("assets/images/Mountain_Loop_scaled.png");
	}
	
	public inline function clear():Void {
		graphics.clear();
	}
	
	public function draw(verts:Vector<Float>, indices:Vector<Int>, uvs:Vector<Float>):Void {
		
		graphics.beginBitmapFill(tile);
		graphics.drawTriangles(verts, indices, uvs);
		graphics.endFill();
	}
}