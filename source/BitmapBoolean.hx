package;

import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.Bitmap;

class BitmapBoolean extends Bitmap {
	
	var yes:BitmapData;
	var no:BitmapData;
	
	var bmd:BitmapData;
	var blitPt:Point;
	
	public var state(default, set):Bool;
	function set_state(b:Bool):Bool {
		
		if (b) bmd.copyPixels(yes, yes.rect, blitPt);
		else bmd.copyPixels(no, no.rect, blitPt);
		
		return state = b;
	}
	
	public function new(yesPath:String, noPath:String, initState:Bool) {
		
		yes = Assets.getBitmapData(yesPath);
		no = Assets.getBitmapData(noPath);
		
		blitPt = new Point();
		
		bmd = new BitmapData(yes.width, yes.height, true, 0x0);
		
		super(bmd);
		
		state = initState;
	}
}