package;

import openfl.geom.Point;
import haxe.Json;
import openfl.geom.Rectangle;
import haxe.ds.StringMap;
import openfl.display.BitmapData;

class Animation {
	
	var source:BitmapData;
	var jsonData:StringMap<Frame>;
	var anims:StringMap<Anim>;
	
	public var current(default, null):String;
	var currentFrames:Anim;
	public var index(default, null):Int = 0;
	var counter:Float = 0;
	
	var paused:Bool;
	
	public var maxWidth(default, null):Int = 0;
	public var maxHeight(default, null):Int = 0;
	
	public var isStopped(get, never):Bool;
	inline function get_isStopped():Bool { return paused || index == currentFrames.frames.length && !currentFrames.shouldLoop; }
	
	public function new(source:BitmapData, jsonString:String) {
		
		this.source = source;
		
		jsonData = new StringMap();
		
		var js = Json.parse(jsonString);
		
		var fr:Frame, ww:Int, hh:Int;
		for (frame in Lambda.array(js.frames)) {
			
			fr = { name : frame.filename, offset : new Point(frame.spriteSourceSize.x, frame.spriteSourceSize.y), rect : new Rectangle(frame.frame.x, frame.frame.y, frame.frame.w, frame.frame.h) };
			jsonData.set(fr.name, fr);
			
			ww = Std.int(frame.sourceSize.w);
			hh = Std.int(frame.sourceSize.h);
			
			if (ww > maxWidth) {
				maxWidth = Std.int(frame.sourceSize.w);
			}
			
			if (hh > maxHeight) {
				maxHeight = Std.int(frame.sourceSize.h);
			}
		}
		
		paused = false;
		
		anims = new StringMap();
		current = "";
		currentFrames = null;
	}
	
	public function addSingle(name:String, base:String):Void {
		
		anims.set(name, { name : name, frames : [jsonData.get(base)], shouldLoop : false });
	}
	
	public function addSequence(name:String, loop:Bool, base:String, start:Int, end:Int):Void {
		
		var fr:Array<Frame> = [];
		
		for (i in start...end + 1) {
			fr.push(jsonData.get('${base}${i < 10 ? "0" + i : "" + i}'));
		}
		
		anims.set(name, { name : name, frames : fr, shouldLoop : loop });
	}
	
	public function play(name:String, force:Bool = true, startAt:Int = 0):Void {
		
		if (!force && current.length > 0) return;
		
		current = name;
		currentFrames = anims.get(name);
		
		index = startAt;
		counter = 0;
		paused = false;
	}
	
	public function stop():Void {
		paused = true;
	}
	
	public function resume():Void {
		paused = false;
	}
	
	public function blit(onto:BitmapData):Void {
		onto.fillRect(onto.rect, 0x0);
		onto.copyPixels(source, currentFrames.frames[index].rect, currentFrames.frames[index].offset, null, null, true);
	}
	
	public function blitAt(onto:BitmapData, dstPos:Point):Void {
		dstPos = dstPos.add(currentFrames.frames[index].offset);
		onto.copyPixels(source, currentFrames.frames[index].rect, dstPos, null, null, true);
	}
	
	public function getBMDOfCurrent():BitmapData {
		
		var bmd = new BitmapData(maxWidth, maxHeight, true, 0x0);
		blit(bmd);
		return bmd;
	}
	
	public function update(dt:Float):Void {
		
		if (!paused && (currentFrames.shouldLoop || index < currentFrames.frames.length)) {
			
			if (index < 0) index = 0;
			
			else {
				
				final dur = 1 / 24;
				
				if (counter >= dur) {
					index++;
					if (currentFrames.shouldLoop) index %= currentFrames.frames.length;
					else if (index == currentFrames.frames.length) {
						paused = true;
						index--; // so blitting will still work
					}
					counter -= dur;
				}
			}
			
			counter += dt;
		}
	}
}

@:structInit
private class Frame {
	public var name:String;
	public var offset:Point;
	public var rect:Rectangle;
}

@:structInit
private class Anim {
	public var name:String;
	public var frames:Array<Frame>;
	public var shouldLoop:Bool;
}