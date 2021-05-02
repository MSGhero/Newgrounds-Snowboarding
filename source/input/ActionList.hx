package input;

import utils.ListEnumAbstract;
import haxe.ds.Vector;

@:forward
abstract ActionList(Vector<Bool>) {
	
	public function new() {
		
		// int instead of vec int?
		this = new Vector(ListEnumAbstract.count(Actions));
		
		for (i in 0...this.length) this[i] = false;
	}

	public function copyFrom(al:ActionList):Void {
		
		for (i in 0...this.length) {
			this[i] = al[i];
		}
	}
	
	public function getAction(action:Actions):Bool {
		return this[action];
	}
	
	public function setAction(action:Actions, b:Bool):Bool {
		return this[action] = b;
	}
	
	@:op([]) public inline function get(index:Int):Bool {
		return this.get(index);
	}
	
	@:op([]) public inline function set(index:Int, val:Bool):Bool {
		return this.set(index, val);
	}
}