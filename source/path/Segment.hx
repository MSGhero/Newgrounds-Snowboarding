package path;

import msg.utils.LinkedList.ILinked;

class Segment implements ILinked<Segment> {
	
	public var y0:Float;
	public var x0:Float;
	
	public var length:Float;
	
	public var hasGrind:Bool;
	
	public var prev:Segment;
	public var next:Segment;
	
	public function new(y0:Float, x0:Float) {
		
		this.y0 = y0;
		this.x0 = x0;
		
		length = 0;
		
		hasGrind = false;
		
		prev = next = null;
	}
	
	public function resetInit(y0:Float, x0:Float):Void {
		this.y0 = y0;
		this.x0 = x0;
		recalc();
	}
	
	public function recalc():Void {
		
	}
	
	public function clone():Segment {
		var seg = new Segment(y0, x0);
		seg.hasGrind = hasGrind;
		return seg;
	}
	
	public function y(x:Float):Float {
		// override
		return y0;
	}
	
	public function dy(x:Float):Float {
		// override
		return 0;
	}
	
	public inline function yf():Float {
		return y(xf());
	}
	
	public function xf():Float {
		return x0;
	}
	
	public function x(y:Float):Float {
		return x0;
	}
}