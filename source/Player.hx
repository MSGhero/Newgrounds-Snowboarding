package;

import tink.core.Pair;
import tink.core.Signal;
import tink.core.Signal.SignalTrigger;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import msg.utils.states.IState;
import msg.utils.states.FSM;

class Player extends Sprite {
	
	public var fsm:FSM;
	public var superFSM:FSM;
	
	public var velX:Float;
	public var velY:Float;
	public var velR:Float;
	public var maxVelR:Float;
	public var accR:Float;
	
	public var grinding:Bool;
	public var tumbles:Float;
	public var tumbleCount:Int;
	
	public var pointTrigger:SignalTrigger<Pair<String, Int>>;
	
	public var animation(default, null):Animation;
	var display:BitmapData;
	var displayBM:Bitmap;
	
	var tumbleBMD:BitmapData;
	var tumbleSp:Sprite;
	
	var boardBM:Bitmap;
	
	public var dontDecrCombo:Bool; // lol
	
	public var projectile(default, set):Bool;
	function set_projectile(b:Bool):Bool {
		
		projectile = b;
		if (fsm != null) fsm.swapStates(b ? "air" : "ground");
		if (superFSM != null) superFSM.swapStates("none");
		
		if (b) grinding = false;
		
		return b;
	}
	
	public var heading(default, set):Float;
	function set_heading(f:Float):Float {
		heading = f;
		rotation = Math.atan(f) / Math.PI * 180;
		return f;
	}
	
	public function new(name:Chars) {
		super();
		
		animation = PlayerAnims.setAnim(name);
		animation.play("default");
		
		velX = velY = velR = accR = 0;
		tumbles = -1;
		tumbleCount = 3;
		
		grinding = false;
		projectile = false;
		heading = Math.POSITIVE_INFINITY;
		
		// scaleX = scaleY = scaleFactor;
		
		pointTrigger = Signal.trigger();
		Global.POINT_SIGNAL = pointTrigger;
		
		fsm = new FSM();
		
		fsm.addState(new GroundState(this));
		fsm.addState(new AirState(this)); //, ["ground", "rotateout"]);
		fsm.addState(new RotateInState(this)); //, ["air"]);
		fsm.addState(new RotateState(this)); //, ["rotatein"]);
		fsm.addState(new RotateOutState(this)); //, ["rotate"]);
		
		fsm.initAll();
		fsm.swapStates("ground");
		
		superFSM = new FSM();
		
		superFSM.addState(new DefaultState(this));
		superFSM.addState(new TrickInState(this));
		superFSM.addState(new TrickState(this));
		superFSM.addState(new TrickOutState(this));
		superFSM.addState(new TumbleState(this));
		
		superFSM.initAll();
		superFSM.swapStates("none");
		
		var boardAnim = PlayerAnims.getBoardAnim();
		boardAnim.play(Std.string(Global.DEBUG.SELECTED_BOARD));
		
		var bb = boardAnim.getBMDOfCurrent();
		boardBM = new Bitmap(bb);
		boardBM.scaleX = boardBM.scaleY = 138 / boardBM.width;
		boardBM.x = -bb.width / 2;
		boardBM.y = -bb.height + 2;
		addChild(boardBM);
		
		display = new BitmapData(animation.maxWidth, animation.maxHeight, true, 0x0);
		displayBM = new Bitmap(display);
		displayBM.smoothing = true;
		addChild(displayBM);
		
		var xOff = switch (name) {
			case PICO: -77;
			case JOHNY: -55;
			case KING: -65;
			case CHOCO: -85;
			case BOOG: -75;
			case GOAT: -70;
			case CAPTAIN: -63;
			case PHIL: -50;
			case ELLIE: -70;
			case HENRY: -70;
			case CHIBI: -79;
			case GF: -77;
			case ROGUE: -80;
			case SMILEY: -55;
			case NENE: -60;
			case CORDELIA: -65;
			case SHOTGUN: -75;
			case TRICKY: -74;
			case KERRIGAN: -73;
			case JOSH: -60;
			case NONE: 0;
		}
		
		var yOff = switch (name) {
			case PICO: -115;
			case JOHNY: -113;
			case KING: -137;
			case CHOCO: -138;
			case BOOG: -134;
			case GOAT: -124;
			case CAPTAIN: -125;
			case PHIL: -124;
			case ELLIE: -149;
			case HENRY: -149;
			case CHIBI: -89;
			case GF: -122;
			case ROGUE: -121;
			case SMILEY: -118;
			case NENE: -115;
			case CORDELIA: -143;
			case SHOTGUN: -157;
			case TRICKY: -132;
			case KERRIGAN: -142;
			case JOSH: -130;
			case NONE: 0;
		}
		
		displayBM.x = xOff;
		displayBM.y = yOff;
		
		tumbleSp = new Sprite();
		addChild(tumbleSp);
		var tumbleAnim = PlayerAnims.getTumbleAnim();
		tumbleBMD = new BitmapData(tumbleAnim.maxWidth, tumbleAnim.maxHeight, true, 0x0);
		var tumbleBM = new Bitmap(tumbleBMD);
		tumbleBM.smoothing = true;
		tumbleSp.visible = false;
		tumbleSp.addChild(tumbleBM);
		tumbleAnim.play(Std.string(name).toLowerCase());
		tumbleAnim.blit(tumbleBMD);
		
		tumbleBM.x = -tumbleBM.width / 2;
		tumbleBM.y = -tumbleBM.height / 2;
		
		dontDecrCombo = false;
	}
	
	function integrate(dt:Float):Void {
		
		if (velX > Global.DEBUG.MAX_VELX) velX = Global.DEBUG.MAX_VELX;
		
		y += velY * dt;
		if (projectile && (velR != 0 || accR != 0)) {
			
			maxVelR = Global.DEBUG.ROT_VEL * (1 + Global.DEBUG.ROT_MULT * (velR < 0 ? -Global.DEBUG.ROT_MULT_DIR : Global.DEBUG.ROT_MULT_DIR));
			velR += accR * dt;
			
			if (velR < 0 && velR < -maxVelR) velR = -maxVelR;
			else if (velR > 0 && velR > maxVelR) velR = maxVelR;
			
			if (accR == 0) velR = 0; // no momentum after letting go of arrow key
			
			rotation += velR * dt;
			while (rotation > 180) rotation -= 360;
			while (rotation < -180) rotation += 360;
		}
	}
	
	public function update(dt:Float):Void {
		
		fsm.update(dt);
		superFSM.update(dt);
		
		integrate(dt);
		
		animation.update(dt);
		animation.blit(display);
	}
	
	public function tumble():Void {
		
		tumbleSp.visible = true;
		displayBM.visible = false;
		boardBM.visible = false;
	}
	
	public function incrTumble(dt:Float):Void {
		tumbleSp.rotation += 360 * dt;
	}
	
	public function stopTumble():Void {
		
		tumbleSp.visible = false;
		displayBM.visible = true;
		boardBM.visible = true;
	}
}

private class GroundState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "ground"; }
	
	var player:Player;
	
	var grindTime:Float;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		
		player.animation.play("default");
		player.velR = 0;
		grindTime = -1;
	}
	
	public function exit():Void {
		
		if (grindTime != -1) {
			player.pointTrigger.trigger(new Pair("", Math.floor(grindTime * 75)));
			grindTime = -1;
		}
		
		player.dontDecrCombo = false;
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.grinding) {
			
			// in case we are already in this state when grinding begins, ie when you set grinding to true after swapping states. less thinking if I keep it this way...
			if (grindTime == -1) {
				grindTime = 0;
				player.pointTrigger.trigger(new Pair("Grind", 1));
				player.dontDecrCombo = true;
			}
			
			grindTime += dt;
			
			if (grindTime * 75 >= 1) {
				// accrue points over time, don't discard decimals that wouldn't make it otherwise
				var mod = Std.int(grindTime * 75);
				grindTime -= mod / 75;
				player.pointTrigger.trigger(new Pair("", Math.floor(mod)));
			}
		}
	}
}

private class AirState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "air"; }
	
	var player:Player;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		//player.animation.play("default");
	}
	
	public function exit():Void { }
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.tumbles >= 0) return;
		
		var l = Global.INPUT.pressed.getAction(L);
		var r = Global.INPUT.pressed.getAction(R);
		
		if ((l || r) && !(l && r)) player.fsm.swapStates("rotatein");
	}
}

private class RotateBaseState implements IState {
	
	public var name(get, never):String;
	function get_name():String { return "rotatebase"; }
	
	var player:Player;
	var isLeft:Bool;
	var isRight:Bool;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void {
		isLeft = true;
	}
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		
		isLeft = Global.INPUT.pressed.getAction(L);
		isRight = Global.INPUT.pressed.getAction(R);
		
		var curr4 = player.animation.current.substr(0, 4);
		if (curr4 != "tric" && curr4 != "tail" && curr4 != "nose") player.animation.play(isLeft ? "leftin" : "rightin");
		
		// will keep rotating after stopping
		player.accR = isLeft ? -Global.DEBUG.ROT_ACC : isRight ? Global.DEBUG.ROT_ACC : 0;
	}
	
	public function exit():Void {
		
		var fc = player.animation.current.charAt(0);
		if (fc == "l" || fc == "r") player.animation.stop();
		player.accR = 0;
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.tumbles >= 0) return;
		
		var lnp = !Global.INPUT.pressed.getAction(L);
		var rnp = !Global.INPUT.pressed.getAction(R);
		
		if (isLeft && lnp || !isLeft && rnp) {
			player.fsm.swapStates("rotateout");
			return;
		}
		
		if (!lnp && !rnp) {
			player.fsm.swapStates("rotateout");
		}
	}
}

private class RotateInState extends RotateBaseState {
	
	override function get_name():String { return "rotatein"; }
	
	public function new(player:Player) {
		super(player);
	}
	
	override function enter() {
		super.enter();
		var curr4 = player.animation.current.substr(0, 4);
		if (curr4 != "tric" && curr4 != "tail" && curr4 != "nose") player.animation.play(isLeft ? "leftin" : "rightin");
	}
	
	override public function update(dt:Float):Void {
		
		if (player.tumbles >= 0) return;
		
		var lnp = !Global.INPUT.pressed.getAction(L);
		var rnp = !Global.INPUT.pressed.getAction(R);
		
		if (isLeft && lnp || !isLeft && rnp) {
			player.fsm.swapStates("rotateout");
			return;
		}
		
		if (!lnp && !rnp) {
			player.fsm.swapStates("rotateout");
			return;
		}
		
		if (player.animation.isStopped) player.fsm.swapStates("rotate");
	}
}

private class RotateState extends RotateBaseState {
	
	override function get_name():String { return "rotate"; }
	
	var angleSum:Float;
	
	public function new(player:Player) {
		super(player);
		angleSum = 0;
	}
	
	override function enter() {
		super.enter();
		if (player.animation.current.charAt(0) == "l") player.animation.play("lefthold");
		else if (player.animation.current.charAt(0) == "r") player.animation.play("righthold");
		player.accR = isLeft ? -Global.DEBUG.ROT_ACC : isRight ? Global.DEBUG.ROT_ACC : 0;
		
		player.dontDecrCombo = true;
		
		angleSum = 0;
	}
	
	override function exit() {
		super.exit();
		
		player.dontDecrCombo = false;
		
		if (player.tumbles == -1) {
			var flips = Math.round(Math.abs(angleSum) / 360);
			if (flips > 0) player.pointTrigger.trigger(new Pair('Flip x$flips', flips * (flips + 1) * 100)); // some kind of service or something to deal with points
		}
	}
	
	override function update(dt:Float) {
		super.update(dt);
		
		if (player.tumbles > -1) angleSum = 0;
		else angleSum += player.velR * dt;
	}
}

private class RotateOutState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "rotateout"; }
	
	var player:Player;
	var outLabel:String;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		if (player.animation.current.charAt(0) == "l") player.animation.play("leftout");
		else if (player.animation.current.charAt(0) == "r") player.animation.play("rightout");
	}
	
	public function exit():Void {
		var fc = player.animation.current.charAt(0);
		if (fc == "l" || fc == "r") player.animation.stop();
		player.accR = 0;
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.tumbles >= 0) return;
		
		if (player.animation.isStopped) player.fsm.swapStates("air");
		
		var isLeft = Global.INPUT.pressed.getAction(L);
		var isRight = Global.INPUT.pressed.getAction(R);
		
		player.accR = isLeft ? -Global.DEBUG.ROT_ACC : isRight ? Global.DEBUG.ROT_ACC : 0;
	}
}

private class DefaultState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "none"; }
	
	var player:Player;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		// player.animation.stop();
	}
	
	public function exit():Void { }
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.fsm.getCurr().name == "ground") return;
		
		if (Global.INPUT.pressed.getAction(TAIL) || Global.INPUT.pressed.getAction(TRICK) || Global.INPUT.pressed.getAction(NOSE)) {
			player.superFSM.swapStates("trickin");
		}
	}
}

private class TrickInState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "trickin"; }
	
	var player:Player;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		
		if (Global.INPUT.pressed.getAction(TAIL)) {
			player.animation.play("tailin");
			Global.DEBUG.ROT_MULT_DIR = -1;
		}
		
		else if (Global.INPUT.pressed.getAction(TRICK)) {
			player.animation.play("trickin");
			Global.DEBUG.ROT_MULT_DIR = 0;
		}
		
		else if (Global.INPUT.pressed.getAction(NOSE)) {
			player.animation.play("nosein");
			Global.DEBUG.ROT_MULT_DIR = 1;
		}
	}
	
	public function exit():Void {
		Global.DEBUG.ROT_MULT_DIR = 0;
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		if (player.tumbles >= 0) return;
		if (player.animation.isStopped) player.superFSM.swapStates("trick");
	}
}

private class TrickState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "trick"; }
	
	var player:Player;
	var trick:Int;
	
	var holdTime:Float;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void {
		trick = -1;
	}
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		
		holdTime = 0;
		
		trick =
			Global.INPUT.pressed.getAction(TAIL) ? 0 :
			Global.INPUT.pressed.getAction(TRICK) ? 1 :
			2;
		
		Global.DEBUG.ROT_MULT_DIR = trick - 1;
		player.dontDecrCombo = false; // in case it was set from somewhere else, would jank up my checks in update
		
		player.animation.play(trick == 0 ? "tailhold" : trick == 1 ? "trickhold" : "nosehold");
	}
	
	public function exit():Void {
		
		player.dontDecrCombo = false;
		Global.DEBUG.ROT_MULT_DIR = 0;
		
		if (trick == 1 && player.tumbles == -1 && holdTime > 0.5) {
			player.pointTrigger.trigger(new Pair("", Math.floor(holdTime * 75)));
			holdTime = 0;
		}
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		
		if (player.tumbles >= 0) return;
		
		holdTime += dt;
		
		// hold for 0.5 secs before it counts
		if (holdTime > 0.5 && !player.dontDecrCombo) {
			
			var trickName = "";
			
			if (trick == 0) trickName = "Tailgrab";
			else if (trick == 2) trickName = "Nosegrab";
			else if (trick == 1) {
				
				trickName = switch (Global.DEBUG.SELECTED_CHAR) {
					case PICO: "Method";
					case NENE: "Roulette";
					case CAPTAIN: "Stiffy";
					case TRICKY: "Headstand";
					case HENRY: "Mute";
					case ELLIE: "Mute (pickpocket)";
					case CHOCO: "Rocket";
					case KING: "Lemon";
					case KERRIGAN: "Froggy";
					case GOAT: "360";
					case PHIL: "UFO";
					case SMILEY: "UFO";
					case JOHNY: "Mule Kick";
					case BOOG: "Rubber";
					case GF: "Sick";
					case ROGUE: "Truck Driver";
					case CHIBI: "Alright!";
					case SHOTGUN: "Boomstick";
					case CORDELIA: "Hoverboard";
					case JOSH: "Mule Kick";
					case NONE: "404";
				}
			}
			player.dontDecrCombo = true;
			player.pointTrigger.trigger(new Pair(trickName, 1));
		}
		
		else if (player.dontDecrCombo && holdTime * 75 >= 1) {
			// accrue points over time, don't discard decimals that wouldn't make it otherwise
			var mod = Std.int(holdTime * 75);
			holdTime -= mod / 75;
			player.pointTrigger.trigger(new Pair("", Math.floor(mod)));
		}
		
		var np = 
			trick == 0 ? !Global.INPUT.pressed.getAction(TAIL) :
			trick == 1 ? !Global.INPUT.pressed.getAction(TRICK) :
			!Global.INPUT.pressed.getAction(NOSE);
		
		if (np) {
			player.superFSM.swapStates("trickout");
		}
	}
}

private class TrickOutState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "trickout"; }
	
	var player:Player;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		
		// tail, trick, nose
		if (player.animation.current.charAt(1) == "a") player.animation.play("tailout");
		else if (player.animation.current.charAt(1) == "r") player.animation.play("trickout");
		else if (player.animation.current.charAt(1) == "o") player.animation.play("noseout");
	}
	
	public function exit():Void {
		player.animation.stop();
		Global.DEBUG.ROT_MULT_DIR = 0;
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		if (player.tumbles >= 0) return;
		if (player.animation.isStopped) player.superFSM.swapStates("none");
	}
}

private class TumbleState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "tumble"; }
	
	var player:Player;
	
	public function new(player:Player) {
		this.player = player;
	}
	
	public function init():Void { }
	
	public function destroy():Void {
		player = null;
	}
	
	public function enter():Void {
		// player.animation.play("trickhold"); // will eventually be "crash" or something anim
		// player.velR = Global.DEBUG.ROT_VEL * 1; // natural looking? or needs to be scaled based on delta angle?
		// Global.DEBUG.ROT_MULT_DIR = 1; // natural looking? or needs to be adjusted based on delta angle?
		Global.DEBUG.ROT_MULT_DIR = 0;
		player.tumble();
	}
	
	public function exit():Void {
		// player.animation.stop();
		// Global.DEBUG.ROT_MULT_DIR = 0;
		player.stopTumble();
	}
	
	public function suspend():Void { }
	public function revive():Void { }
	
	public function update(dt:Float):Void {
		player.incrTumble(dt);
	}
}