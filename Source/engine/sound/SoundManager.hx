package engine.sound;

import flash.events.Event;
import flash.Lib;
import openfl.media.Sound;
import engine.sound.SoundPool;
import engine.sound.SoundPool.MySound;
import openfl.Assets;

class SoundManager {

	public static inline var SOUNDS:Int=1;
	public static inline var MUTE:Int=0;
	
	private static var sounds:Map<String,SoundPool>;
	public static var state(default, null):Int=2;

	private static var stopped:Bool = true;
	private static var playing:String="";
	private static var doneLoading:Bool=false;
	
	static var statePreviousToDeactivate : Int;

	private static function loadSound(cantidad:Int, id:String, fileName:String=null) {
		var sound:SoundPool = new SoundPool(id, cantidad, fileName==null?id:fileName);
		sounds.set(id,sound);
	}

	private static function addSounds(cantidad:Int, id:String, sonido:String) {
		SoundManager.sounds.get(id).load(cantidad, sonido);
	}

	public static function init(){
		if(sounds!=null) return;
		sounds=new Map<String,SoundPool>();

		finishLoading();

		#if blackberry
		statePreviousToDeactivate = -1;
		Lib.current.stage.addEventListener(Event.ACTIVATE, onActivate);
		Lib.current.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
		#end

	}

	#if blackberry
	static function onActivate(_) {
		if (statePreviousToDeactivate>=0) {
			setState(statePreviousToDeactivate);
		}
	}

	static function onDeactivate(_) {
		statePreviousToDeactivate = state;
	}
	#end

	private static function finishLoading() {
		for(sp in sounds) while ( sp.realLoad() ) continue;
	}

	public static function play(id:String):MySound {
		if(!sounds.exists(id)){
			trace("Quisiste pasar el sonido "+id+" que no esta cargado!");
			return null;
		}
		if(state!=0) return sounds.get(id).play();
		return null;
	}


	public static function setState(newState:Int) {
		state=(newState==1)?1:0;
		//Reg.soundState = state;
		//Reg.saveSoundState();

	}

	public static function update(_) {
		// ESTO ES UN PARCHE PARA ANDROID! (la clase MediaPlayer, también!)
		SoundPool.update();
	}

}