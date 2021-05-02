package input;

class InputDevice {
	
	public var name(default, null):String;
	
	public function new(name:String) {
		this.name = name;
	}
	
	public function getStatus(action:Actions):Bool {
		return false;
	}
	
	public function update():Void { }
}