package path;

import graphics.PathGraphics;

class PathManager {
	
	var path:Path;
	var availableLines:Array<Segment>;
	public var pathGraphics:PathGraphics;
	
	public var length(get, never):Float;
	inline function get_length():Float { return path.length; }
	
	public function new(initX:Float, initY:Float) {
		
		pathGraphics = new PathGraphics();
		
		availableLines = [
			Line.fromSlope(Math.tan(4 * 0 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 1 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 2 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 3 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 4 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 5 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 6 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 7 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 8 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 9 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 10 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 11 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 12 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 13 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 14 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 15 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 16 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 17 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 18 / 180 * Math.PI), Global.TILE_WIDTH),
			Line.fromSlope(Math.tan(4 * 19 / 180 * Math.PI), Global.TILE_WIDTH),
		];
		
		path = new Path();
		append(0, false).resetInit(initY, initX);
	}
	
	public function append(segIndex:Int, grind:Bool):Segment {
		
		var seg = availableLines[segIndex].clone();
		seg.hasGrind = grind;
		
		return path.append(seg);
	}
	
	public inline function dy(x:Float):Float {
		return path.dy(x);
	}
	
	public inline function y(x:Float, isGrinding:Bool):Float {
		return path.y(x) + (isGrinding ? Global.DEBUG.GRIND_HEIGHT : 0);
	}
	
	public inline function x0():Float {
		return path.x0();
	}
	
	public function hasGrind(x:Float):Bool {
		var seg = path.segment(x);
		return seg != null ? seg.hasGrind : false;
	}
	
	public function update(x:Float, y:Float):Void {
		
		while (path.pastFirstSeg(x)) {
			path.shift();
		}
		
		pathGraphics.drawPathTris(path, x, y);
	}
}

class PresetPaths {
	
	// something like this, maybe array array int, idk
	static var gentle:Array<Array<Int>> = [
		[9, 9, 9, 9, 7, 9, 9],
		[13, 13, 12, 13, 17, 13, 13],
		[11, 11, 8, 12, 12, 12, 10, 12],
		[6, 7, 7, 7, 6, 6, 6, 6, 7, 7, 7],
	];
	
	static var extreme:Array<Array<Int>> = [
		[19, 19, 1, 2, 1],
		[9, 12, 15, 18, 16, 14, 11, 8],
		[5, 5, 5, 18, 18, 17, 5, 5, 16, 17],
	];
	
	public static function getGentle():Array<Int> {
		return gentle[Std.random(gentle.length)];
	}
	
	public static function getExtreme():Array<Int> {
		return extreme[Std.random(extreme.length)];
	}
}