package engine;
import openfl.display.Stage;


class State extends GameElement{

	public var sm:StateManager;
	
	public function new (sm:StateManager) {
		super();
		this.sm = sm;
	}
	
	public function init(){
	}
	
	public function end(onComplete:Dynamic){
		onComplete();
	}

	public function onBack(_){

	}

	public function redraw(){
	/*	var stage:Stage=sm.mainStage;
		var stageW=stage.stageWidth;
		var stageH=stage.stageHeight;//-marginTop;
		var scale:Float=Math.min(stageW,stageH);
		this.scaleX=this.scaleY=scale;*/
	}
	
}