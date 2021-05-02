package graphics;

import openfl.display.BitmapData;
import path.Path;

abstract DebugPathGraphics(BitmapData) to BitmapData {
	
	public function new(width:Int, height:Int, transparent:Bool = true, bgColor:Int = 0x0) {
		this = new BitmapData(width, height, transparent, bgColor);
	}
	
	public function redraw(path:Path, referenceX:Float):Void {
		
		this.lock();
		this.fillRect(this.rect, 0x0);
		
		for (i in 320...640) {
			this.setPixel32(i, Std.int(path.y(referenceX + i)), 0xff000000);
		}
		
		this.unlock();
	}
	
	public function scroll(path:Path, by:Int, referenceX:Int):Void {
		
		this.lock();
		
		this.scroll(-by, 0);
		
		for (i in 0...by) {
			this.setPixel32(this.width - by + i, Std.int(path.y(referenceX + i - by)), 0x0);
			this.setPixel32(this.width - by + i, Std.int(path.y(referenceX + i)), 0xff000000);
		}
		
		this.unlock();
	}
}