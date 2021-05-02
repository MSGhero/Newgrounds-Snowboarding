package input;

import openfl.geom.Point;
import openfl.ui.Mouse;
import openfl.events.MouseEvent;

class MouseInput extends InputDevice {
	
	var lDown:Bool;
	var mDown:Bool;
	var rDown:Bool;
	var moved:Bool;
	
	public var prevPos:Point;
	
	public function new() {
		super("mouse");
	}
	
	override function init() {
		super.init();
		
		// Mouse.hide();
		
		moved = lDown = mDown = rDown = false;
		
		prevPos = new Point();
		
		Global.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		Global.STAGE.addEventListener(MouseEvent.MOUSE_UP, onUp);
		Global.STAGE.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleDown);
		Global.STAGE.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleUp);
		Global.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		
		// cont.addEventListener(MouseEvent.RELEASE_OUTSIDE, onOutside);
	}
	
	override function getStatus(action:Actions):Bool {
		
		return switch(action) {
			// case SELECT: lDown;
			case MOVE: moved;
			case L_DOWN: lDown;
			case M_DOWN: mDown;
			case R_DOWN: rDown;
			default: false;
		}
	}
	
	function onDown(me:MouseEvent):Void {
		// if target is game, ok
		// if target is not stage, ignore somehow
		// if target is stage, released out of bounds address somehow
		lDown = true;
	}
	
	function onUp(me:MouseEvent):Void {
		lDown = false;
	}
	
	function onMiddleDown(me:MouseEvent):Void {
		mDown = true;
	}
	
	function onMiddleUp(me:MouseEvent):Void {
		mDown = false;
	}
	
	function onMove(me:MouseEvent):Void {
		moved = true;
	}
	
	function onOutside(me:MouseEvent):Void {
		// trace("K");
	}
}