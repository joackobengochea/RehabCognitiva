package engine;

import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;

class ImageButton extends Button{
	
	private var icon:Bitmap;
	private var iconPath:String;
	private var iconScale:Float;
		
	public function new (w:Int,h:Int,color:Int,onClick:Int->Void,param:Int,iconPath:String, iconScale:Float=0.9) {
		this.iconPath=iconPath;
		this.icon=null;
		this.iconScale=iconScale;
		super(w,h,color,onClick,param,null);
	}
	
	override public function init(w:Int,h:Int,newColor:Int,text:String=null){
		super.init(w,h,newColor,text);
		this.setIcon(this.iconPath);
	}
	
	override public function setColor(newColor:Int){
		this.color=newColor;
		var buttonColor=color;
		graphics.clear();
		graphics.beginFill(buttonColor);
		graphics.drawRect(0,0,w,h);
		graphics.endFill();
		this.htmlUpdate();
		if(this.icon!=null)	this.icon.alpha=(this.disabled?0.35:1);
	}

	public function setIcon(path:String){
		if(icon==null && path==null) return;
		if(path!=null && path!=this.iconPath){
			if(icon!=null) this.removeChild(icon);
			this.icon=null;
			this.iconPath=path;
		}
		if(icon==null){
			icon=new Bitmap(Assets.getBitmapData(this.iconPath,true), flash.display.PixelSnapping.AUTO, true);
			this.addChild(icon);
		}
		icon.alpha=this.disabled?0.35:1;
		icon.scaleX=icon.scaleY=1;
		var h:Float=this.h;
		var scale=Math.min(w*iconScale/icon.width,h*iconScale/icon.height);
		icon.smoothing=true;
		icon.cacheAsBitmap=true;
		icon.scaleX=icon.scaleY=scale;
		icon.x=(w-icon.width)/2;
		icon.y=(h-icon.height)/2;
	}

}
