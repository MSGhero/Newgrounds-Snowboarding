package input;

class InputManager {
	
	var devices:Array<InputDevice>;
	
	var prevActions:ActionSet;
	public var actions(default, null):ActionSet;
	
	public var pressed(get, never):ActionList;
	inline function get_pressed():ActionList { return actions.pressed; }
	public var justPressed(get, never):ActionList;
	inline function get_justPressed():ActionList { return actions.justPressed; }
	public var justReleased(get, never):ActionList;
	inline function get_justReleased():ActionList { return actions.justReleased; }
	
	public function new() {
		
		devices = [];
		
		prevActions = new ActionSet();
		actions = new ActionSet();
	}
	
	// reset on focus lost or something?
	
	public function addDevice(id:InputDevice):Void {
		devices.push(id);
	}
	
	public function getDevice(name:String):InputDevice {
		for (id in devices) if (id.name == name) return id;
		return null;
	}
	
	public function update():Void {
		
		prevActions.copyFrom(actions);
		
		for (i in 0...pressed.length) pressed[i] = false;
		
		for (device in devices) {
			
			device.update();
			
			for (i in 0...pressed.length) {
				pressed[i] = pressed[i] || device.getStatus(i);
			}
		}
		
		actions.updateJust(prevActions);
	}
}