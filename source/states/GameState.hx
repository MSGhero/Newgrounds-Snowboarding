package states;

import openfl.filters.BitmapFilter;
import openfl.filters.BitmapFilterQuality;
import openfl.filters.GlowFilter;
import openfl.geom.Point;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import tink.core.Callback.CallbackLink;
import graphics.Background.SnowBackground;
import graphics.Background.TankBackground;
import graphics.Background.IBackground;
import tink.CoreApi.Pair;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.display.DisplayObjectContainer;
import path.PathManager;
import msg.utils.states.IState;

class GameState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "game"; }
	
	var container:DisplayObjectContainer;
	var bg:IBackground;
	
	var camera:Sprite;
	var player:Player;
	var path:PathManager;
	
	var distance:Float;
	
	var trickPointText:TextField;
	var trickText:TextField;
	var pointsText:TextField;
	var pointsLink:CallbackLink;
	var textOutline:BitmapFilter;
	var comboPoints:Int;
	var comboTimer:Float;
	
	var lives:Array<BitmapBoolean>;
	var backButton:BitmapButton;
	var wipeOut:Animation;
	var wipeOutBMD:BitmapData;
	var wipeOutBM:Bitmap;
	var wipeOutText:Animation;
	var wipeOutArea:Sprite;
	
	#if debug
	var velText:TextField;
	#end
	
	public function new(container:DisplayObjectContainer) {
		this.container = container;
	}
	
	public function init():Void {
		
		trickText = new TextField();
		trickText.selectable = false;
		trickText.wordWrap = true;
		trickText.width = 400; trickText.height = 100;
		trickText.x = 20; trickText.y = Global.HEIGHT - trickText.height;
		trickText.defaultTextFormat = new TextFormat("Arial", 20, 0x0, true);
		
		trickPointText = new TextField();
		trickPointText.selectable = false;
		trickPointText.wordWrap = false;
		trickPointText.width = 400; trickPointText.height = 40;
		trickPointText.x = 20; trickPointText.y = trickText.y - trickPointText.height;
		trickPointText.defaultTextFormat = new TextFormat("Arial", 28, 0x0, true);
		
		pointsText = new TextField();
		pointsText.selectable = false;
		pointsText.wordWrap = false;
		pointsText.width = 400; pointsText.height = 40;
		pointsText.x = Global.WIDTH - pointsText.width - 35; pointsText.y = Global.HEIGHT - pointsText.height - 10;
		#if debug
		pointsText.border = true;
		pointsText.borderColor = 0x0;
		#end
		pointsText.defaultTextFormat = new TextFormat("Arial", 28, 0x0, true, null, null, null, null, RIGHT);
		
		backButton = new BitmapButton("assets/images/game/backbutton0001.png", "assets/images/game/backbutton0002.png", "assets/images/game/backbutton0003.png");
		backButton.x = Global.WIDTH - backButton.width - 20; backButton.y = 600;
		backButton.addEventListener(MouseEvent.CLICK, onMenu);
		
		lives = [];
		
		for (i in 0...3) {
			var bmb = new BitmapBoolean("assets/images/game/lives0001.png", "assets/images/game/lives0002.png", true);
			bmb.x = 1104 + i * 55; bmb.y = 34;
			lives.push(bmb);
		}
		
		wipeOut = new Animation(Assets.getBitmapData("assets/images/game/wipeout.png"), Assets.getText("assets/data/wipeout.json"));
		wipeOut.addSequence("default", false, "100", 1, 14);
		wipeOutBMD = new BitmapData(wipeOut.maxWidth, wipeOut.maxHeight, true, 0x0);
		wipeOutBM = new Bitmap(wipeOutBMD);
		wipeOutBM.x = (Global.WIDTH - wipeOutBM.width) / 2; wipeOutBM.y = 360;
		
		wipeOutText = new Animation(Assets.getBitmapData("assets/images/game/failtext.png"), Assets.getText("assets/data/failtext.json"));
		wipeOutText.addSequence("default", false, "100", 1, 50);
		wipeOutArea = new Sprite();
		wipeOutArea.graphics.beginFill(0x0, 0.01);
		wipeOutArea.graphics.drawRect(400, 480, Global.WIDTH - 400 * 2, 200);
		wipeOutArea.buttonMode = true;
		wipeOutArea.addEventListener(MouseEvent.CLICK, onWipeClick);
		
		textOutline = new GlowFilter(0x0, 1, 10, 10, 100, BitmapFilterQuality.LOW);
	}
	
	public function destroy():Void {
		
	}
	
	public function enter():Void {
		
		Global.MUSIC.loopGameTracks();
		
		path = new PathManager(0, 240);
		distance = 0;
		
		bg = Math.random() < 0.5 ? new TankBackground() : new SnowBackground();
		
		container.addChild(bg.display);
		container.addChild(path.pathGraphics);
		
		camera = new Sprite();
		container.addChild(camera);
		
		player = new Player(Global.DEBUG.SELECTED_CHAR);
		camera.addChild(player);
		
		pointsLink = Global.POINT_SIGNAL.handle(incrPoints);
		
		// start off calm
		for (i in 0...10) path.append(0, false);
		for (p in PresetPaths.getGentle()) path.append(p, false);
		for (p in PresetPaths.getGentle()) path.append(p, false);
		for (p in PresetPaths.getGentle()) path.append(p, false);
		for (p in PresetPaths.getGentle()) path.append(p, true);
		
		player.x = Global.DEBUG.PLAYER_X;
		// player falls from sky to begin
		player.y = -player.height * 1.5;
		player.projectile = true;
		player.heading = 0;
		player.velY = 240;
		
		camera.x = 0;
		camera.y = Global.DEBUG.CAMERA_Y - player.y;
		
		player.velX = Global.DEBUG.MIN_VELX;
		
		path.update(distance, camera.y);
		
		wipeOutBM.visible = false;
		wipeOutArea.visible = false;
		
		comboPoints = 0;
		comboTimer = -1;
		
		player.pointTrigger.trigger(new Pair("", 0));
		container.addChild(pointsText);
		container.addChild(trickPointText);
		container.addChild(trickText);
		
		container.addChild(backButton);
		container.addChild(wipeOutBM);
		container.addChild(wipeOutArea);
		
		for (life in lives) {
			life.state = true;
			container.addChild(life);
		}
		
		#if debug
		velText = new TextField();
		velText.x = 500; velText.y = 100;
		velText.selectable = velText.wordWrap = false;
		velText.width = 100; velText.height = 50;
		velText.text = '${Std.int(player.velX)} px/s';
		container.addChild(velText);
		#end
		
		trickText.text = trickPointText.text = "";
	}
	
	public function exit():Void {
		
		container.removeChild(camera);
		container.removeChild(bg.display);
		container.removeChild(path.pathGraphics);
		container.removeChild(pointsText);
		container.removeChild(trickPointText);
		container.removeChild(trickText);
		container.removeChild(backButton);
		container.removeChild(wipeOutBM);
		container.removeChild(wipeOutArea);
		
		if (lives != null) for (life in lives) container.removeChild(life);
		
		pointsLink.cancel();
		pointsLink = null;
		
		Global.SHARED_OBJ.data.points = Global.POINTS;
		
		#if debug
		container.removeChild(velText);
		#end
	}
	
	public function suspend():Void {
		
	}
	
	public function revive():Void {
		
	}
	
	public function update(dt:Float):Void {
		
		if (dt == 0) return;
		
		while (path.length <= 30) {
			
			// what's the logic for grinds?
			// random!
			
			var shouldGrind = Math.random() < 0.2;
			
			if (Math.random() < 0.15) {
				for (pp in PresetPaths.getExtreme()) path.append(pp, false);
			}
			
			else {
				for (pp in PresetPaths.getGentle()) path.append(pp, shouldGrind);
			}
		}
		
		#if debug
		velText.text = '${Std.int(player.velX)} px/s';
		#end
		
		player.update(dt);
		
		distance += player.velX * dt;
		
		var dy = path.dy(distance + player.x);
		
		if (Global.DEBUG.STICKY || player.grinding || !player.projectile && Math.atan(dy) <= Math.atan(player.heading) + Global.DEBUG.PROJ_ANGLE_EPS) {
			
			player.heading = dy;
			player.y = path.y(distance + player.x, player.grinding);
			
			// accelerate normally, faster down steeper slopes, less so if grinding
			player.velX += Global.DEBUG.GRAV_SLOPE / Math.sqrt(1 + dy * dy) * dt / (player.grinding ? 6 : 1);
			
			// short hop
			if (Global.INPUT.justPressed.getAction(U)) {
				player.velY = dy / 1.73 * player.velX - 200; // ugh the jump "height" changes based on your slope and velocity, good enough
				// player.velX *= .75;
				player.projectile = true;
			}
			
			if (player.grinding && !path.hasGrind(distance + player.x)) {
				player.projectile = true;
				player.velY = 200;
			}
		}
		
		else {
			
			// jump
			if (!player.projectile) {
				
				player.velY = player.velX * player.heading / Math.sqrt(player.heading * player.heading + 1) * Global.DEBUG.JUMP_BOOST;
				
				// prolly needs to be adjusted
				if (!Global.DEBUG.VECTOR_VEL) {
					//player.velX /= Math.sqrt(player.heading * player.heading + 1) * 1.2;
					if (player.velX < Global.DEBUG.MIN_VELX) player.velX = Global.DEBUG.MIN_VELX;
				}
				
				player.y = path.y(distance + player.x, player.grinding);
				player.projectile = true;
			}
			
			else {
				
				// do grinds save you from awkward landings?
				// ie do you need to be aligned to grind
				// if you're tumbling, you cannot interact with the grind rail
				
				// landing
				
				var canGrind = player.tumbles < 0 && path.hasGrind(distance + player.x);
				
				canGrind = canGrind && player.y < path.y(distance + player.x, false) + Global.DEBUG.GRIND_HEIGHT * .85;
				
				if (player.y > path.y(distance + player.x, canGrind)) {
					
					if (player.tumbles > 0) {
						if (player.tumbleCount > 0) player.tumbles -= dt;
					}
					
					else if (player.tumbles <= 0 && player.tumbles != -1) {
						
						player.heading = dy;
						player.projectile = false; // finally recover
						player.velX = 0; // gets set correctly later
						player.tumbles = -1;
						
						player.superFSM.swapStates("none");
					}
					
					else {
						
						if (canGrind) {
							player.heading = dy;
							player.projectile = false;
							player.grinding = true;
							player.velX *= .85;
						}
						
						else {
							
							// if heading and dy deltas are too high, causes a hard landing, affects vx I guess
							//player.velX *= 1 - Math.abs(player.heading - dy) / dy;
							var delta = Math.abs(player.rotation - Math.atan(dy) / Math.PI * 180);
							
							if (delta > Global.DEBUG.ROT_DELTA_CRASH) {
								
								player.tumbles = Global.DEBUG.NUM_TUMBLES;
								player.superFSM.swapStates("tumble");
								player.tumbleCount--;
								lives[lives.length - player.tumbleCount - 1].state = false;
								player.velX *= 0.5;
								
								if (player.tumbleCount <= 0) {
									// game over!
									wipeOutBM.visible = true;
									wipeOut.play("default");
								}
							}
							
							else {
								player.heading = dy;
								player.projectile = false;
							}
						}
					}
					
					player.y = path.y(distance + player.x, canGrind); // on hitting the ground, the position should be set, not necessarily rotation if you're tumbling still
					
					if (player.velX < Global.DEBUG.MIN_VELX) player.velX = Global.DEBUG.MIN_VELX;
				}
				
				// falling
				else {
					player.velY += Global.DEBUG.GRAV_Y * dt;
				}
			}
		}
		
		camera.y = Global.DEBUG.CAMERA_Y - player.y;
		
		bg.scroll(distance, camera.y);
		path.update(distance, camera.y); // not offset by player x since only the left border matters
		
		if (Global.INPUT.justPressed.getAction(BACK)) onMenu(null);
		
		if (wipeOutBM.visible) {
			
			if (!wipeOut.isStopped) {
				
				wipeOut.update(dt);
				wipeOut.blit(wipeOutBMD);
				
				if (wipeOut.isStopped) {
					
					wipeOutText.play("default", Std.random(50) + 1);
					wipeOutText.blitAt(wipeOutBMD, new Point(104, 40));
					wipeOutText.stop();
					
					wipeOutArea.visible = true;
				}
			}
		}
		
		if (comboTimer > 0 && !player.dontDecrCombo) {
			
			comboTimer -= dt;
			
			if (comboTimer <= 0) {
				comboTimer = -1;
				comboPoints = 0;
				trickText.text = "";
				trickPointText.text = "";
			}
		}
	}
	
	function incrPoints(pair:Pair<String, Int>):Void {
		
		var type = pair.a;
		var points = pair.b;
		
		Global.POINTS += points;
		pointsText.text = Std.string(Global.POINTS);
		//pointsText.filters = [textOutline]; // too much lag :(
		
		if (points > 0) {
			
			comboPoints += points;
			trickPointText.text = Std.string(comboPoints);
			//trickPointText.filters = [textOutline];
			
			if (type.length > 0) {
				if (trickText.length == 0) trickText.text = '$type';
				else {
					
					trickText.appendText(' + $type');
					
					// remove lines that scroll up past the bounds. prolly not excessively needed
					if (trickText.numLines > 4) {
						trickText.text = trickText.text.substring(0, trickText.getLineOffset(1));
					}
				}
			}
			
			//trickText.filters = [textOutline];
			
			comboTimer = 4;
		}
	}
	
	function onMenu(_):Void {
		Global.GAME_FSM.swapStates("charsel");
	}
	
	function onWipeClick(me:MouseEvent):Void {
		
		// multiple affronts to God here
		if (me.stageY - 480 < 100) {
			exit();
			enter();
		}
		
		else {
			Global.GAME_FSM.swapStates("charsel");
		}
	}
}