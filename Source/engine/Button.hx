package engine;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;
import engine.sound.SoundManager;
import openfl.text.TextField;

class Button extends Sprite{
	
	private var font:String;
	private var label:TextField;
	private var w:Int;
	private var h:Int;
	private var color:Int;
	private var text:String;
	private var disabled:Bool;
	public	var audioResourceName:String;
	public  var onClick(default,null):Int->Void;
	#if html5
	private var htmlLink:js.html.AnchorElement;
	private var htmlDiv:js.html.DivElement;
	#end
		
	public function new (w:Int,h:Int,color:Int,onClick:Int->Void,param:Int,text:String=null, font:String = null) {
		super();
		//this.font = (font==null)?Puralax.DEFAULT_FONT:font;
		audioResourceName="button";
		this.disabled=false;
		if(onClick!=null){
			this.onClick=function(e:Dynamic=null){if(disabled) return; SoundManager.play(audioResourceName); onClick(param);};
			this.addEventListener(openfl.events.MouseEvent.CLICK,this.onClick);
		}
		this.init(w,h,color,text);
		#if html5
		htmlDiv=null;
		htmlLink=null;
		#end
	}
	
	public function init(w:Int,h:Int,newColor:Int,text:String=null){
		this.w=w;
		this.h=h;
		this.text=text;
		//this.setColor(newColor!=-1?newColor:this.color);
	}
	
	public function setColor(newColor:Int){
		this.color=newColor;
		var buttonColor=(this.disabled)?0xF0F0F0:color;
		var dark:Int=0xbbbbbb;
		graphics.clear();
		graphics.beginFill(buttonColor);
		graphics.drawRect(0,0,w,h*0.98);
		graphics.endFill();
		graphics.beginFill(dark);
		graphics.drawRect(0,h*0.98,w,h*0.02);
		graphics.endFill();
		this.setText(text);
		this.htmlUpdate();
	}
	
	private function htmlUpdate(){
		#if html5
		if(htmlDiv!=null){
			htmlDiv.style.top=""+Math.round(this.y)+"px";
			htmlDiv.style.left=""+Math.round(this.x)+"px";
			htmlDiv.style.width=""+w+"px";
			htmlDiv.style.height=""+h+"px";
		}
		#end
	}
	
	public function htmlShow(){
		#if html5
		if(htmlDiv==null){
			htmlLink=js.Browser.document.createAnchorElement();
			htmlDiv=js.Browser.document.createDivElement();
			htmlLink.appendChild(htmlDiv);
			htmlDiv.style.position="absolute";
			htmlDiv.style.border="none";
			htmlLink.onclick=this.onClick;
			js.Browser.document.body.appendChild(htmlLink);
		}
		htmlDiv.style.display="block";
		this.htmlUpdate();
		#end
	}
	
	public function htmlHide(){
		#if html5
		if(htmlDiv==null) return;
		htmlDiv.style.display="none";
		#end
	}
	
	public function disable(){
		if(disabled) return;
		disabled=true;
		setColor(this.color);
	}

	public function enable(){
		if(!disabled) return;
		disabled=false;
		setColor(this.color);
	}
	
	public function free(){
		if(this.onClick==null) return;
		this.removeEventListener(flash.events.MouseEvent.CLICK,this.onClick);
		this.onClick=null;
	}
	
	public function setText(text:String){
		if(text==null) return;
		if(label==null){
			label=new TextField();
		}else{
			this.removeChild(label);
		}
		var numerico:Bool=(Std.parseInt(text)!=null);
		label.scaleX = label.scaleY = 1;
		label.width = w*2;
		label.text = text;//localization.Localization.get(text);
		label.width = w;
		if(label.textWidth>w*0.9){
			label.scaleX = label.scaleY = 0.7;
			label.width *= 1/label.scaleX;
		}

		label.y=(this.height*0.94-label.height*label.scaleY)/2-(!numerico?this.height*0.04:0);
		this.addChild(label);		
	}

}
