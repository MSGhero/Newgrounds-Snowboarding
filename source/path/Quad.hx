package path;

class Quad extends Segment {
	
	var x1:Float;
	var y1:Float;
	
	var coef:Float;
	
	var xshift:Float;
	
	public function new(x0:Float, y0:Float, x1:Float, coef:Float, xshift:Float = 0) {
		
		this.x1 = x1 - xshift;
		this.coef = -coef;
		
		this.xshift = xshift;
		final yshift = coef * xshift * xshift;
		
		super(y0 - yshift, x0 - xshift);
		
		recalc();
	}
	
	public static function fromSlopes(slopeIn:Float, slopeOut:Float, delx:Float):Quad {
		
		final coef = (slopeOut - slopeIn) / 2 / delx;
		final xshift = slopeIn / 2 / coef;
		return new Quad(0, 0, delx, coef, xshift);
	}
	
	override function resetInit(y0:Float, x0:Float) {
		
		final yshift = coef * xshift * xshift;
		
		x1 += x0 - this.x0;
		
		super.resetInit(y0 - yshift, x0 - xshift);
	}
	
	override function recalc():Void {
		
		if (x0 == x1) throw "Slope cannot be infinite";
		
		y1 = y0 + coef * (x1 - x0) * (x1 - x0);
	}
	
	override function clone():Quad {
		return new Quad(x0, y0, x1, coef, xshift);
	}
	
	override function y(x:Float):Float {
		
		return
			if (x <= x0) y0;
			else if (x >= x1) y1;
			else y0 + coef * (x - x0) * (x - x0);
	}
	
	override function dy(x:Float):Float {
		return coef * (x - x0) * 2;
	}
	
	override function xf():Float {
		return x1;
	}
	
	public function toString():String {
		return 'Quad{y-$y0=$coef(x-$x0)^2}';
	}
}