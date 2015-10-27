package engine.sound;

import openfl.media.Sound;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.SampleDataEvent;

class SoundPool
{
	private var sonidos: Array<MySound>;
	private var aCargar: Array<String>;
	private var name:String; // esta variable la tenemos para debug
	#if android
	private static var mustPlayQueue:Array<MySound>=new Array<MySound>();
	#end
	private static var playingQueue:Array<MySound>=new Array<MySound>();
	
	public function new(name:String, cant:Int, fileName:String) {
		sonidos = new Array<MySound>();
		aCargar = null;
		this.name=name;
		load(cant,fileName);
		realLoad();
	}

	public function load(cant:Int, fileName:String) {
		if(aCargar==null) aCargar = new Array<String>();
		for (i in 0...cant) {
			#if flash
			aCargar.push('assets/sounds/'+fileName+'.mp3');
			#else
			aCargar.push('assets/sounds/'+fileName+'.ogg');
			#end
		}
		aCargar=shuffleArray(aCargar);
	}

	function shuffleArray(arr:Array<String>):Array<String> {
    	var i:Int=arr.length-1;
    	while (i>=1) {   
	        var j:Int = Math.floor(Math.random() * i);//j ← random integer with 0 ≤ j ≤ i
	        var temp = arr[j];
	        arr[j] = arr[i];
	        arr[i] = temp;
	        i--;
	    }
	    return arr;
	}

	public inline function realLoad():Bool {
		if(aCargar==null) return false;
		var s = new MySound(aCargar.pop(),this);
		sonidos.push(s);
		if(aCargar.length==0) aCargar=null;
		return true;
	}
	
	public function play():MySound {
		if(sonidos.length==0) return null;
		var s:MySound=sonidos.shift();
		#if android
			if(playingQueue.length<=2){
				playingQueue.push(s.play());
			}else{
				mustPlayQueue.push(s);
			}
		#else
			playingQueue.push(s.play());
		#end
		return s;
	}

	public function onSoundComplete(s:MySound){
		sonidos.push(s);
		playingQueue.remove(s);
	}
	
	public static function update() {
		for(s in playingQueue) s.checkTimeout();
		#if android
			if(mustPlayQueue.length==0) return;
			playingQueue.push(mustPlayQueue.shift().play());
		#end
	}

}

class MySound {

	var _channel:openfl.media.SoundChannel;
	var pool:SoundPool;
	var sound:Sound;
	var file:String;
	var timer:Int=0;
	var lastPosition:Float=0;
	private static inline var CONTROL_TIMER:Int=30;

	public function new(file:String, pool:SoundPool) {
		this.pool=pool;
		sound = Assets.getSound(file);
		this.file=file;
	}

	public function play():MySound {
		timer = CONTROL_TIMER;
		lastPosition=0;
		_channel=sound.play();
		_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		return this;
	}

	public function checkTimeout() {
		if (timer-- > 0) return;
		if (_channel.position == lastPosition) {
			trace("CHECKING: "+file+" - POSITION: "+_channel.position);
			_channel.stop();
			onSoundComplete(null);
		} else {
			lastPosition = _channel.position;
			timer = CONTROL_TIMER;
		}
	}

	private function onSoundComplete(_) {
		if(_channel==null) return;
		_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		_channel=null;
		pool.onSoundComplete(this);
	}

	public function stop()
	{
		if(_channel==null) return;
		_channel.stop();
		onSoundComplete(null);
	}

}