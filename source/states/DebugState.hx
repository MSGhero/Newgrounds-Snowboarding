package states;

import haxe.ds.Vector;
import openfl.system.System;
import openfl.text.TextField;
import openfl.display.DisplayObjectContainer;
import msg.utils.states.IState;

class DebugState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "debug"; }
	
	var container:DisplayObjectContainer;
	var stats:TextField;
	var rollingFPS:Vector<Int>;
	
	// debug option
	
	public function new(container:DisplayObjectContainer) {
		this.container = container;
		rollingFPS = new Vector(10); // rolling average count
	}
	
	public function init():Void {
		
		for (i in 0...rollingFPS.length) rollingFPS[i] = 0;
		
		stats = new TextField();
		stats.selectable = false;
		stats.wordWrap = false;
		stats.background = true;
		stats.backgroundColor = 0xffffff;
		stats.width = 70;
		stats.height = 70;
		stats.x = Global.WIDTH - stats.width - 10; // 10 margin
		stats.y = 10; // 10 margin
	}
	
	public function destroy():Void {
		
		stats = null;
		container = null;
	}
	
	public function enter():Void {
		container.addChild(stats);
	}
	
	public function exit():Void {
		container.removeChild(stats);
	}
	
	public function suspend():Void {
		
	}
	
	public function revive():Void {
		
	}
	
	public function update(dt:Float):Void {
		
		Vector.blit(rollingFPS, 1, rollingFPS, 0, 9);
		rollingFPS[9] = Math.round(1 / dt);
		
		if (dt == 0) return;
		
		// i assume the params I want to put here are all inside global debug
		// rather than trying to calculate them here
		
		// update every update or after elapsed?
		stats.text = 
			'FPS: ${getFPS(dt)}\n' + 
			'RAM: ${getMemory()} MB';
	}
	
	function getFPS(dt:Float):String {
		
		var sum = 0;
		for (fps in rollingFPS) sum += fps;
		
		return Std.string(Math.round(sum / rollingFPS.length));
	}
	
	function getMemory():String {
		var mem = Std.int(System.totalMemory / 1024 / 1000);
		return Std.string(mem);
	}
}