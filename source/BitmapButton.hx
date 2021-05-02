package;

import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;

class BitmapButton extends Sprite {
	
	var out:BitmapData;
	var over:BitmapData;
	var down:BitmapData;
	
	var bmd:BitmapData;
	var blitPt:Point;
	
	public function new(outPath:String, overPath:String, downPath:String) {
		super();
		
		out = Assets.getBitmapData(outPath);
		over = Assets.getBitmapData(overPath);
		down = Assets.getBitmapData(downPath);
		
		blitPt = new Point();
		
		bmd = new BitmapData(out.width, out.height, true, 0x0);
		bmd.copyPixels(out, out.rect, blitPt);
		
		addChild(new Bitmap(bmd));
		
		addEventListener(MouseEvent.MOUSE_OVER, onOver);
		addEventListener(MouseEvent.MOUSE_OUT, onOut);
		addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		addEventListener(MouseEvent.MOUSE_UP, onUp);
		
		buttonMode = true;
	}
	
	function onOver(me:MouseEvent):Void {
		bmd.copyPixels(over, over.rect, blitPt);
	}
	
	function onOut(me:MouseEvent):Void {
		bmd.copyPixels(out, out.rect, blitPt);
	}
	
	function onDown(me:MouseEvent):Void {
		bmd.copyPixels(down, down.rect, blitPt);
	}
	
	function onUp(me:MouseEvent):Void {
		bmd.copyPixels(over, over.rect, blitPt);
	}
}