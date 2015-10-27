package engine;

import openfl.display.Stage;
import openfl.display.Sprite;

class StateManager extends Sprite{
	public var currentState:State;
	public var mainStage:Stage;
	
	public function new (mainStage:Stage) {
		super();
		this.mainStage = mainStage;
		currentState=null;
	}
	
	public function switchState(state:State) {
		if(this.currentState!=null){
			this.currentState.end(function(){setState(state);});
			return;
		}
		setState(state);		
	}
	
	private function setState(state:State){
		if(currentState!=null) this.removeChild(currentState);
		currentState=state;
		this.addChild(state);
		currentState.init();
		mainStage.focus = state;
	}
	
	public function update(time){
		if(this.currentState!=null){
			this.currentState.update(time);
		}
	}
}