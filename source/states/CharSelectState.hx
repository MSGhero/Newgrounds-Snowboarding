package states;

import io.newgrounds.NG;
import openfl.net.URLRequest;
import openfl.Lib;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.utils.Assets;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.display.DisplayObjectContainer;
import msg.utils.states.IState;

class CharSelectState implements IState {
	
	public var name(get, never):String;
	inline function get_name():String { return "charsel"; }
	
	var container:DisplayObjectContainer;
	var bg:Bitmap;
	var moverArea:Sprite;
	
	var heads:BitmapData;
	
	var nameField:TextField;
	var descField:TextField;
	
	var buttons:Array<Sprite>;
	var locks:Array<BitmapBoolean>;
	var prevButtonIndex:Int;
	var buttonIndex:Int;
	
	var linkArea:Sprite;
	var linkAnim:Animation;
	var linkPic:BitmapData;
	var linkText:TextField;
	
	var previewAnim:Animation;
	var charPreview:BitmapData;
	var charPreviewBM:Bitmap;
	var playButton:BitmapButton;
	var buyButton:BitmapButton;
	
	var pointsText:TextField;
	var costText:TextField;
	
	var nextCost:Int;
	
	var boardAnim:Animation;
	var boardBM:Bitmap;
	var boardCost:Int = 5000;
	var lockedBoards:Array<Bool>;
	var leftButton:BitmapButton;
	var rightButton:BitmapButton;
	
	public function new(container:DisplayObjectContainer) {
		this.container = container;
	}
	
	public function init():Void {
		
		nameField = new TextField();
		nameField.selectable = false;
		nameField.wordWrap = true;
		nameField.x = 24; nameField.y = 211;
		nameField.width = 332; nameField.height = 200;
		nameField.defaultTextFormat = new TextFormat(Assets.getFont("assets/ui/FeaturedItem.ttf").name, 72, 0xffffff, null, null, null, null, null, CENTER);
		#if debug
		nameField.border = true;
		nameField.borderColor = 0x0;
		#end
		nameField.text = "Pico";
		
		descField = new TextField();
		descField.selectable = false;
		descField.wordWrap = true;
		descField.x = 53; descField.y = 382;
		descField.width = 778; descField.height = 230;
		descField.defaultTextFormat = new TextFormat("Arial", 24, 0xffffff);
		#if debug
		descField.border = true;
		descField.borderColor = 0x0;
		#end
		
		heads = Assets.getBitmapData("assets/images/charsel/head_ss.png");
		
		bg = new Bitmap(Assets.getBitmapData("assets/images/charsel/bg.png"));
		
		previewAnim = PlayerAnims.getPoseAnim();
		charPreview = new BitmapData(previewAnim.maxWidth, previewAnim.maxHeight, true, 0x0);
		charPreviewBM = new Bitmap(charPreview, true);
		charPreviewBM.x = 950; charPreviewBM.y = 240;
		
		buttons = [];
		buttonIndex = prevButtonIndex = 0;
		
		locks = [];
		
		var i = 0;
		var baseX = 230;
		var baseY = 15;
		var step = 102;
		
		createButton(PICO, baseX + i++ * step, baseY);
		createButton(NENE, baseX + i++ * step, baseY);
		createButton(CAPTAIN, baseX + i++ * step, baseY);
		createButton(TRICKY, baseX + i++ * step, baseY);
		createButton(HENRY, baseX + i++ * step, baseY);
		createButton(ELLIE, baseX + i++ * step, baseY);
		createButton(CHOCO, baseX + i++ * step, baseY);
		createButton(KING, baseX + i++ * step, baseY);
		createButton(KERRIGAN, baseX + i++ * step, baseY);
		createButton(GOAT, baseX + i++ * step, baseY);
		i = 0;
		createButton(PHIL, baseX + i++ * step, baseY + step);
		createButton(SMILEY, baseX + i++ * step, baseY + step);
		createButton(JOHNY, baseX + i++ * step, baseY + step);
		createButton(BOOG, baseX + i++ * step, baseY + step);
		createButton(GF, baseX + i++ * step, baseY + step);
		createButton(ROGUE, baseX + i++ * step, baseY + step);
		createButton(CHIBI, baseX + i++ * step, baseY + step);
		createButton(SHOTGUN, baseX + i++ * step, baseY + step);
		createButton(CORDELIA, baseX + i++ * step, baseY + step);
		createButton(JOSH, baseX + i++ * step, baseY + step);
		
		moverArea = new Sprite();
		/*
		moverArea.graphics.beginFill(0x0, 0.01);
		moverArea.graphics.drawRect(baseX - 30, baseY - 30, step * 9 + 97 + 60, step + 97 + 60);
		moverArea.graphics.endFill();
		*/
		
		for (button in buttons) moverArea.addChild(button);
		moverArea.addEventListener(MouseEvent.MOUSE_OUT, onOutChar);
		
		playButton = new BitmapButton("assets/images/charsel/playb_out.png", "assets/images/charsel/playb_over.png", "assets/images/charsel/playb_down.png");
		playButton.scaleX = playButton.scaleY = 0.65;
		playButton.x = Global.WIDTH - playButton.width - 15; playButton.y = Global.HEIGHT - playButton.height - 25;
		playButton.addEventListener(MouseEvent.CLICK, initPlayerAndStart);
		
		buyButton = new BitmapButton("assets/images/charsel/buyb_out.png", "assets/images/charsel/buyb_over.png", "assets/images/charsel/buyb_down.png");
		buyButton.scaleX = buyButton.scaleY = 0.65;
		buyButton.x = Global.WIDTH - buyButton.width - 15; buyButton.y = Global.HEIGHT - buyButton.height - 25;
		buyButton.addEventListener(MouseEvent.CLICK, onBuy);
		
		linkAnim = PlayerAnims.getLinkAnim();
		linkArea = new Sprite();
		linkArea.x = 364; linkArea.y = 236;
		linkPic = new BitmapData(linkAnim.maxWidth, linkAnim.maxHeight, true, 0x0);
		var bm = new Bitmap(linkPic);
		bm.x = 20; bm.y = 20;
		
		linkArea.graphics.beginFill(0x0, 0.01);
		linkArea.graphics.drawRect(0, 0, 500, 132);
		linkArea.graphics.endFill();
		linkArea.buttonMode = true;
		linkArea.addEventListener(MouseEvent.CLICK, onLink);
		
		linkText = new TextField();
		linkText.wordWrap = true;
		linkText.selectable = false;
		linkText.width = 350; linkText.height = 100;
		linkText.x = 116; linkText.y = 28;
		linkText.defaultTextFormat = new TextFormat("Arial", 24, 0xffffff, null, null, null, null, null, CENTER);
		
		linkArea.addChild(bm);
		linkArea.addChild(linkText); // add back when text is known
		
		nextCost = Global.SHARED_OBJ.data.nextCost;
		
		pointsText = new TextField();
		pointsText.wordWrap = false;
		pointsText.selectable = false;
		pointsText.width = 250; pointsText.height = 70;
		pointsText.x = 72; pointsText.y = 626;
		pointsText.defaultTextFormat = new TextFormat("Arial", 36, 0xffffff, null, null, null, null, null, RIGHT);
		
		costText = new TextField();
		costText.wordWrap = false;
		costText.selectable = false;
		costText.width = 250; costText.height = 70;
		costText.x = 72; costText.y = 660;
		costText.defaultTextFormat = new TextFormat("Arial", 28, 0xff3366, null, null, null, null, null, RIGHT);
		
		// I hate how long this is
		boardAnim = PlayerAnims.getBigBoardAnim();
		boardAnim.play("0");
		boardBM = new Bitmap(boardAnim.getBMDOfCurrent());
		boardBM.x = 943; boardBM.y = 515;
		
		leftButton = new BitmapButton("assets/images/charsel/leftb_out.png", "assets/images/charsel/leftb_over.png", "assets/images/charsel/leftb_down.png");
		rightButton = new BitmapButton("assets/images/charsel/rightb_out.png", "assets/images/charsel/rightb_over.png", "assets/images/charsel/rightb_down.png");
		leftButton.x = 873; leftButton.y = 506;
		rightButton.x = 1229; rightButton.y = 506;
		
		leftButton.addEventListener(MouseEvent.CLICK, onLeftBoard);
		rightButton.addEventListener(MouseEvent.CLICK, onRightBoard);
		
		lockedBoards = Global.SHARED_OBJ.data.boards;
		lockedBoards[0] = false; // 0th board is unlocked by default
	}
	
	public function destroy():Void {
		
		container = null;
		bg = null;
		buttons = null;
		playButton = null;
		moverArea = null;
		// remove listeners?
		// screw it
	}
	
	public function enter():Void {
		
		Global.MUSIC.loopMenuTracks();
		Global.DEBUG.SELECTED_CHAR = NONE;
		
		container.addChild(bg);
		container.addChild(nameField);
		container.addChild(descField);
		
		container.addChild(boardBM);
		container.addChild(charPreviewBM);
		
		container.addChild(linkArea);
		container.addChild(moverArea);
		container.addChild(playButton);
		container.addChild(buyButton);
		container.addChild(pointsText);
		container.addChild(costText);
		container.addChild(leftButton);
		container.addChild(rightButton);
		
		showInfo(PICO);
	}
	
	public function exit():Void {
		
		container.removeChild(bg);
		container.removeChild(nameField);
		container.removeChild(descField);
		
		container.removeChild(boardBM);
		container.removeChild(charPreviewBM);
		
		container.removeChild(linkArea);
		container.removeChild(moverArea);
		container.removeChild(playButton);
		container.removeChild(buyButton);
		container.removeChild(pointsText);
		container.removeChild(costText);
		container.removeChild(leftButton);
		container.removeChild(rightButton);
	}
	
	public function suspend():Void {
		
	}
	
	public function revive():Void {
		
	}
	
	public function update(dt:Float):Void {
		if (dt == 0) return;
		
		if (Global.INPUT.justPressed.getAction(L) || Global.INPUT.justPressed.getAction(TAIL)) {
			
			buttonIndex = switch (buttonIndex) {
				case 0: 9;
				case 10: 19;
				default: buttonIndex - 1;
			}
			
			prevButtonIndex = buttonIndex;
			showInfo(getCharFromIndex(buttonIndex));
		}
		
		else if (Global.INPUT.justPressed.getAction(R) || Global.INPUT.justPressed.getAction(NOSE)) {
			
			buttonIndex = switch (buttonIndex) {
				case 9: 0;
				case 19: 10;
				default: buttonIndex + 1;
			}
			
			prevButtonIndex = buttonIndex;
			showInfo(getCharFromIndex(buttonIndex));
		}
		
		else if (Global.INPUT.justPressed.getAction(U) || Global.INPUT.justPressed.getAction(D)) {
			
			buttonIndex = switch (buttonIndex) {
				case _ if (buttonIndex < 10): buttonIndex + 10;
				default: buttonIndex - 10;
			}
			
			prevButtonIndex = buttonIndex;
			showInfo(getCharFromIndex(buttonIndex));
		}
		
		/*
		// this bypasses the whole shop thing we added, oh well
		if (Global.INPUT.justPressed.getAction(SELECT)) {
			initPlayerAndStart(null);
		}
		*/
	}
	
	function createButton(name:Chars, x:Float, y:Float):Sprite {
		
		var slice:BitmapData = new BitmapData(97, 97, true, 0x0);
		
		var rect = switch (name) {
			case PICO: new Rectangle(1, 1, 97, 97);
			case NENE: new Rectangle(1, 99, 97, 97);
			case CAPTAIN: new Rectangle(1, 197, 97, 97);
			case TRICKY: new Rectangle(1, 295, 97, 97);
			case HENRY: new Rectangle(1, 393, 97, 97);
			case ELLIE: new Rectangle(99, 1, 97, 97);
			case CHOCO: new Rectangle(99, 99, 97, 97);
			case KING: new Rectangle(99, 197, 97, 97);
			case KERRIGAN: new Rectangle(99, 295, 97, 97);
			case GOAT: new Rectangle(99, 393, 97, 97);
			case PHIL: new Rectangle(197, 1, 97, 97);
			case SMILEY: new Rectangle(197, 99, 97, 97);
			case JOHNY: new Rectangle(197, 197, 97, 97);
			case BOOG: new Rectangle(197, 295, 97, 97);
			case GF: new Rectangle(197, 393, 97, 97);
			case ROGUE: new Rectangle(295, 1, 97, 97);
			case CHIBI: new Rectangle(295, 99, 97, 97);
			case SHOTGUN: new Rectangle(295, 197, 97, 97);
			case CORDELIA: new Rectangle(295, 295, 97, 97);
			case JOSH: new Rectangle(295, 393, 97, 97);
			case NONE: new Rectangle(1, 1, 97, 97);
		}
		
		slice.copyPixels(heads, rect, new Point());
		
		var bm = new Bitmap(slice);
		var sp = new Sprite();
		sp.x = x; sp.y = y;
		sp.addChild(bm);
		
		if (name != NONE) {
			sp.buttonMode = true;
			sp.addEventListener(MouseEvent.MOUSE_OVER, onOverChar.bind(name));
			sp.addEventListener(MouseEvent.CLICK, onClickChar.bind(name));
		}
		
		buttons.push(sp);
		
		var locked = Global.SHARED_OBJ.data.chars[getIndexFromChar(name)];
		var bmb = new BitmapBoolean("assets/images/charsel/lock.png", "assets/images/charsel/unlock.png", locked);
		
		sp.addChild(bmb);
		
		locks.push(bmb);
		
		return sp;
	}
	
	function getCharFromIndex(index:Int):Chars {
		
		return switch (index) {
			case 0: PICO;
			case 1: NENE;
			case 2: CAPTAIN;
			case 3: TRICKY;
			case 4: HENRY;
			case 5: ELLIE;
			case 6: CHOCO;
			case 7: KING;
			case 8: KERRIGAN;
			case 9: GOAT;
			case 10: PHIL;
			case 11: SMILEY;
			case 12: JOHNY;
			case 13: BOOG;
			case 14: GF;
			case 15: ROGUE;
			case 16: CHIBI;
			case 17: SHOTGUN;
			case 18: CORDELIA;
			case 19: JOSH;
			default: NONE;
		}
	}
	
	function getIndexFromChar(char:Chars):Int {
		
		return switch (char) {
			case PICO: 0;
			case NENE: 1;
			case CAPTAIN: 2;
			case TRICKY: 3;
			case HENRY: 4;
			case ELLIE: 5;
			case CHOCO: 6;
			case KING: 7;
			case KERRIGAN: 8;
			case GOAT: 9;
			case PHIL: 10;
			case SMILEY: 11;
			case JOHNY: 12;
			case BOOG: 13;
			case GF: 14;
			case ROGUE: 15;
			case CHIBI: 16;
			case SHOTGUN: 17;
			case CORDELIA: 18;
			case JOSH: 19;
			default: 0;
		}
	}
	
	function onOverChar(charName:Chars, me:MouseEvent):Void {
		
		buttonIndex = getIndexFromChar(charName);
		showInfo(charName);
	}
	
	function onOutChar(me:MouseEvent):Void {
		
		buttonIndex = prevButtonIndex;
		showInfo(getCharFromIndex(buttonIndex));
	}
	
	function onClickChar(charName:Chars, me:MouseEvent):Void {
		
		prevButtonIndex = buttonIndex = getIndexFromChar(charName);
		showInfo(charName);
	}
	
	function showInfo(charName:Chars):Void {
		
		switch (charName) {
			case PICO:
				nameField.text = "Pico";
				descField.text = "Description\nFor an elementary school student, Pico is as badass as they come! Really, he puts most adults to shame as well. His rise to fame came after saving his school from rampaging goth kids who attempted to shoot them up. He's done very little with that success in the time since, but has randomly decided it's time to return to the spotlight and shred up the slopes on Fulp Mountain.";
			case NENE:
				nameField.text = "Nene";
				descField.text = "Description\nShe has been known to kill herself one or two times. Maybe even killed by others a few times? It's hard to keep track. You'd think once would be more than enough, yet it never seems to slow her down. After a very dark time in her life, she has found a renewed sense of purpose in snowboarding.";
			case CAPTAIN:
				nameField.text = 'John Captain';
				descField.text = "Description\nThe Tankman may not know where his Tank is, but he knows where his skills are. This foul-mouthed combat vet is here to prove that he is neither a sissy nor a poor leader. Steve doesn't think he has what it takes, but who cares what Steve thinks!? That dude always reeks like swamp ass anyways.";
			case TRICKY:
				nameField.text = "Tricky the Clown";
				descField.text = "Description\nTricky likes doing tricks. Get it? Normally we wouldn't know what to expect from this unpredictable force of chaos. But even malevolent killers need a hobby. Hank was invited to join this event, but it was \"lost\" in the mail, and Tricky has taken his place instead.";
			case HENRY:
				nameField.text = "Henry Stickmin";
				descField.text = "Description\nWith an endless bag of tricks at his disposal, it only makes sense that he would have a few snowboarding tricks up his sleeve as well. That makes sense, right? I think if you try to make sense of any of that Stickmin logic, you're bound to make your head hurt. A wanted criminal and anti-hero, Henry can always be relied on to get the job done. You better just hope you're on his side when he does it.";
			case ELLIE:
				nameField.text = "Ellie Rose";
				descField.text = "Description\nA mysterious character whose origins are left completely unknown. She was a captive of The Wall, and regardless of whether help was given, was able to bust her way out. She can be either your greatest friend, or greatest enemy depending on how you treat her. And believe me, she may forgive, but she never forgets.";
			case CHOCO:
				nameField.text = "Chocolate Man";
				descField.text = "Description\nAnd also Cripple Boy. What an unlikely pair of friends! Although it largely seems like Cripple Boy is simply along for the ride. He truly doesn't have much choice in the matter. Their friendship absolutely knows bounds. It seems like they can barely tolerate each other. But lucky for both of them, they are strapped together for some on-the-slopes therapy! At least CB can't break any limbs out here?";
			case KING:
				nameField.text = "King Pete";
				descField.text = "Description\nYou may question the authority of a man who chose to make his castle entirely edible. But the edible life chose this funky ol' fool, not the other way around. Although, if given the option, he absolutely would have chosen it. He may seem silly and incompetent... Yeah. There is no \"but\" there. This guy's a doofus.";
			case KERRIGAN:
				nameField.text = "Kerrigan";
				descField.text = "Description\nDo you know what Kerrigan loves most? Muffins! Ok, yeah. But how about second on the list! Inventing. Probably. Then her best bud Ark. Then frogs. Then a bunch of other stuff. But somewhere down the line, I'm sure snowboarding is on the list. Just 1 or 2 below skiing. But this isn't Newgrounds Skiing, alright!? It's much more RAD then that!";
			case GOAT:
				nameField.text = "Goat";
				descField.text = "Description\nHe's just hoping there's some nice plump grass at the bottom of this hill.";
			case PHIL:
				nameField.text = "Phil Eggtree";
				descField.text = "Description\nAfter years spent trying to escape school, both in his dreams and reality, it's time to answer the question of what Phil intended to do with that newly earned freedom. Bet you wouldn't have guessed it was all to go snowboarding!? You'd think a toque, beanie, or some other head cover would be necessary? He actually is wearing one. It just happens to look a heck of a lot like his actual head.";
			case SMILEY:
				nameField.text = "Smiley Sundae";
				descField.text = "Description\nA character who always has a new lease on life. Every day is a gift, and every night is a treasure. There really is no keeping her down! Even after faceplanting down the slope 100 times or so, she'll never stop smiling. It sounds unsettling, but you can't help but smile along with her :slight_smile:";
			case JOHNY:
				nameField.text = "Johny Magic";
				descField.text = "Description\nSkateboarding is SO last decade. After not only conquering the pavement, but also outsmarting and outskating all sorts of challengers, Johny knew it was time for a challenge. He answered that challenge by attempting to skateboard without wheels, thinking he was \"unlocking\" the board's \"true potential.\" That didn't go so well. But he did accidentally create a fresh new snowboard for himself!";
			case BOOG:
				nameField.text = "The Boogley";
				descField.text = "Description\nThis rubberized creature is as daring as they come. With a body that is able to flex and morph in ways that might make the average person's stomach twist, it's that very bendability that makes them impervious to injury! Not impervious to wipeouts. That's bound to happen still. A lot. Are they a dog? A bear? Other? Nope. They're the one and only Boogley!";
			case GF:
				nameField.text = "Girlfriend";
				descField.text = "Description\nLeft flip. Right flip. Left flip. Right flip. Always groovin' and funkin', this flirty little firecracker is out here to break hearts, not bones! Well. At least not her bones. If you make her angry, you may bring out a dark side that's not quite so cheery...";
			case ROGUE:
				nameField.text = "Rogue Soul";
				descField.text = "Description\nHailing from an alternate universe filled with Souls, it took Rogue a bit of time to adjust to using Gold instead of Soulons. The exchange rates are brutal! Once adjusted, they were able to put their detached limbs and acrobatic skills to use. Turns out flipping, jumping, and rolling around is a heck of a lot more fun when nobody is fighting back. But keep an eye out. They may still try to steal a couple extra bucks if left alone.";
			case CHIBI:
				nameField.text = "Chibi Knight";
				descField.text = "Description\nAfter saving the world, the Chibi Knight started taking boarding lessons from the Ice Pengu on Mahou Island. The ultra-low center of gravity certainly helps her out, as well as that youthful confidence and lack of fear in the face of danger. But take care! Shredding foes and shredding the slopes are very different, little knight!";
			case SHOTGUN:
				nameField.text = "Shotgun Man";
				descField.text = "Description\nDecades ago, this violent maniac acted as an Assassin for hire. No contract was off limits, and nobody was safe! They seem to have retired, as none of their murderous activities have been reported for quite some time now. Although they may still be lurking where they are least expected... LIKE HERE!! Didn't see that coming, eh?";
			case CORDELIA:
				nameField.text = "Cordelia the Witch";
				descField.text = "Description\nYou've heard the phrase \"cold as a witch's tit,\" right? Well, this is that witch, those are the tits, and you better believe it's cold out! But that's the appeal of having cold witch-tits like the phrase states. It means you don't have to compromise your rockin' outfit when you're totally cold-immune! Relatively new on the scene, this Dead Estate resident has already made a splash and is sure to stick around.";
			case JOSH:
				nameField.text = "Josh Onarres";
				descField.text = "Description\nA boy with the world's most intense mother, and possibly an unchecked fascination with explosive bowling balls. A prisoner of his own house for 17 long years. And now, after walking though his front door for the first time in his life, his gut reaction is to go snowboarding...? Never underestimate the determination of a young man with his mind absolutely focused on dropping some PHATT SNOWBOARD TRICKS.";
			case NONE:
				nameField.text = "Uh oh!";
				descField.text = "Description\nYou shouldn't be seeing this!";
		}
		
		descField.setTextFormat(new TextFormat("Arial", 30, 0xffcc00, true), 0, 11); // "Description"
		
		linkText.text = "Click for more games and movies with " + nameField.text + "!";
		
		if (charName != NONE) {
			
			var char = Std.string(charName).toLowerCase();
			
			previewAnim.play(char);
			previewAnim.blit(charPreview);
			
			linkAnim.play(char);
			linkAnim.blit(linkPic);
			
			pointsText.text = '${Global.POINTS}';
			
			var locked = locks[getIndexFromChar(charName)].state;
			var boardLocked = lockedBoards[Global.DEBUG.SELECTED_BOARD];
			
			if (locked) {
				playButton.visible = false;
				buyButton.visible = true;
				costText.text = 'Buy for ${nextCost}';
				boardAnim.play("0");
			}
			
			else if (boardLocked) {
				
				playButton.visible = false;
				buyButton.visible = true;
				costText.text = 'Buy board for $boardCost';
				boardAnim.play(Std.string(Global.DEBUG.SELECTED_BOARD));
			}
			
			else {
				
				playButton.visible = true;
				buyButton.visible = false;
				costText.text = '';
				
				boardAnim.play(Std.string(Global.DEBUG.SELECTED_BOARD));
			}
			
			boardAnim.blit(boardBM.bitmapData);
		}
	}
	
	function initPlayerAndStart(me:MouseEvent):Void {
		
		if (Global.DEBUG.SELECTED_CHAR == NONE) {
			Global.DEBUG.SELECTED_CHAR = getCharFromIndex(prevButtonIndex);
			popNSwapGame();
		}
	}
	
	function popNSwapGame():Void {
		
		if (Global.GAME_FSM.getCurr().name == "debug") {
			Global.GAME_FSM.pop();
			Global.GAME_FSM.swapStates("game");
			Global.GAME_FSM.push("debug");
		}
		
		else {
			Global.GAME_FSM.swapStates("game");
		}
	}
	
	function onBuy(me:MouseEvent):Void {
		
		// if char is locked, they are what is being bought
		if (locks[prevButtonIndex].state) {
			
			if (Global.POINTS >= nextCost) {
				
				locks[prevButtonIndex].state = false;
				
				Global.POINTS -= nextCost;
				nextCost += 1500;
				
				Global.SHARED_OBJ.data.nextCost = nextCost;
				Global.SHARED_OBJ.data.points = Global.POINTS;
				Global.SHARED_OBJ.data.chars[prevButtonIndex] = false;
				
				Global.SHARED_OBJ.flush();
				
				showInfo(getCharFromIndex(prevButtonIndex));
				
				if (Global.MEDALS_READY) {
					
					// easier to read
					var medalId = switch(getCharFromIndex(prevButtonIndex)) {
						case PICO: 63143;
						case NENE: 63144;
						case CAPTAIN: 63145;
						case TRICKY: 63146;
						case HENRY: 63147;
						case ELLIE: 63148;
						case CHOCO: 63149;
						case KING: 63150;
						case KERRIGAN: 63151;
						case GOAT: 63152;
						case PHIL: 63153;
						case SMILEY: 63156;
						case JOHNY: 63157;
						case BOOG: 63158;
						case GF: 63159;
						case ROGUE: 63160;
						case CHIBI: 63161;
						case SHOTGUN: 63162;
						case CORDELIA: 63163;
						case JOSH: 63164;
						case NONE: -1;
					}
					
					if (medalId > -1) {
						var medal = NG.core.medals.get(medalId);
						
						if (!medal.unlocked) {
							medal.onUnlock.addOnce(() -> trace('${medal.name} unlocked'));
							medal.sendUnlock();
						}
					}
				}
			}
		}
		
		else if (lockedBoards[Global.DEBUG.SELECTED_BOARD]) {
			
			if (Global.POINTS >= boardCost) {
				
				lockedBoards[Global.DEBUG.SELECTED_BOARD] = false;
				
				Global.POINTS -= boardCost;
				
				Global.SHARED_OBJ.data.points = Global.POINTS;
				Global.SHARED_OBJ.data.boards[Global.DEBUG.SELECTED_BOARD] = false;
				
				Global.SHARED_OBJ.flush();
				
				showInfo(getCharFromIndex(prevButtonIndex));
			}
		}
	}
	
	function onLeftBoard(me:MouseEvent):Void {
		
		if (!locks[prevButtonIndex].state) {
			Global.DEBUG.SELECTED_BOARD--;
			if (Global.DEBUG.SELECTED_BOARD < 0) Global.DEBUG.SELECTED_BOARD = lockedBoards.length - 1;
		}
		
		showInfo(getCharFromIndex(prevButtonIndex));
	}
	
	function onRightBoard(me:MouseEvent):Void {
		
		if (!locks[prevButtonIndex].state) {
			Global.DEBUG.SELECTED_BOARD++;
			if (Global.DEBUG.SELECTED_BOARD >= lockedBoards.length) Global.DEBUG.SELECTED_BOARD = 0;
		}
		
		showInfo(getCharFromIndex(prevButtonIndex));
	}
	
	function onLink(me:MouseEvent):Void {
		
		var req = switch (getCharFromIndex(prevButtonIndex)) {
			case BOOG: "https://www.newgrounds.com/portal/view/395645";
			case CAPTAIN: "https://www.newgrounds.com/collection/tankmen";
			case CHIBI: "https://www.newgrounds.com/portal/view/661076";
			case CHOCO: "https://www.newgrounds.com/collection/nameless";
			case CORDELIA: "https://www.newgrounds.com/portal/view/770002";
			case ELLIE: "https://www.newgrounds.com/collection/henrystickmin";
			case GF: "https://www.newgrounds.com/portal/view/770371";
			case GOAT: "https://www.newgrounds.com/portal/view/472834";
			case HENRY: "https://www.newgrounds.com/collection/henrystickmin";
			case JOHNY: "https://www.newgrounds.com/portal/view/400326";
			case JOSH: "https://www.newgrounds.com/portal/view/782776";
			case KERRIGAN: "https://www.newgrounds.com/portal/view/62693";
			case KING: "https://www.newgrounds.com/collection/ediblecastle";
			case NENE: "https://www.newgrounds.com/collection/pico";
			case PHIL: "https://www.newgrounds.com/portal/view/314680";
			case PICO: "https://www.newgrounds.com/collection/pico";
			case ROGUE: "https://www.newgrounds.com/portal/view/604080";
			case SHOTGUN: "https://www.newgrounds.com/collection/assassin";
			case SMILEY: "https://www.newgrounds.com/portal/view/571729";
			case TRICKY: "https://www.newgrounds.com/collection/madness";
			case NONE: "https://www.newgrounds.com/";
		}
		
		Lib.navigateToURL(new URLRequest(req));
	}
}