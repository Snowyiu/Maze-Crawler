package Screens
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CScreenContent extends Bitmap
	{
		private var _m_p_content:IDrawable;
		private var _m_back_ground_color:uint;
		
		private var _m_p_listeners:Array;
		
		protected var m_p_root:CMain;
		
		public function CScreenContent(p_pos:CPoint, width:int, height:int, p_content:IDrawable, back_ground_color:uint) 
		{
			_m_back_ground_color = back_ground_color;
			_m_p_content = p_content;
			
			addEventListener(Event.REMOVED_FROM_STAGE, OnRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, function(p_event:Event):void
			{
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				m_p_root = CMain(root);
				OnAttachedToRoot();
			});
			
			super(new BitmapData(width, height, true, _m_back_ground_color));
			
			this.width = width;
			this.height = height;
			
			x = p_pos.X;
			y = p_pos.Y;
		}
		
		protected function SetContent(p_content:IDrawable):void
		{
			_m_p_content = p_content;
		}
		
		protected function OnAttachedToRoot():void
		{
			
		}
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			if (_m_p_listeners == null)
				_m_p_listeners = [];
			
			_m_p_listeners[type] = listener;
			super.addEventListener(type, listener, useCapture, priority, true);
		}
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			delete _m_p_listeners[type];
			super.removeEventListener(type, listener, useCapture);
		}
		
		private function OnRemovedFromStage(p_event:Event):void
		{
			for (var k:String in _m_p_listeners)
			{
				super.removeEventListener(k, _m_p_listeners[k]);
			}
		}
		
		public function Update():void
		{
			bitmapData.fillRect(new Rectangle(0, 0, width, height), _m_back_ground_color);
			_m_p_content.DrawTo(bitmapData);
		}
	}

}