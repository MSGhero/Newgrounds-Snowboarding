package path;

class Line extends Segment {
	
	var x1:Float;
	var y1:Float;
	
	var slope:Float;
	
	public function new(x0:Float, y0:Float, x1:Float, y1:Float) {
		super(y0, x0);
		
		this.x1 = x1;
		this.y1 = y1;
		
		recalc();
	}
	
	public static function fromDelta(dely:Float, delx:Float):Line {
		return new Line(0, 0, delx, dely);
	}
	
	public static function fromSlope(slope:Float, delx:Float):Line {
		return new Line(0, 0, delx, slope * delx);
	}
	
	override function resetInit(y0:Float, x0:Float) {
		
		x1 -= this.x0;
		y1 -= this.y0;
		
		x1 += x0;
		y1 += y0;
		
		super.resetInit(y0, x0);
	}
	
	override function recalc():Void {
		
		if (x0 == x1) throw "Slope cannot be infinite";
		
		slope = (y1 - y0) / (x1 - x0);
		length = Math.sqrt((y1 - y0) * (y1 - y0) + (x1 - x0) * (x1 - x0));
	}
	
	override function clone():Line {
		var line = new Line(x0, y0, x1, y1);
		line.hasGrind = hasGrind;
		return line;
	}
	
	override function y(x:Float):Float {
		
		return
			if (x <= x0) y0;
			else if (x >= x1) y1;
			else y0 + (x - x0) * slope;
	}
	
	override function dy(x:Float):Float {
		return slope;
	}
	
	override function xf():Float {
		return x1;
	}
	
	override function x(y:Float):Float {
		if (slope == 0) return x0;
		return (y - y0) / slope + x0;
	}
	
	public function toString():String {
		return 'Line{$x0,$y0,$x1,$y1}';
	}
}