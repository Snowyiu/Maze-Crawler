package 
{
	import Entities.CPlayer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import Screens.CMainMenuScreen;
	import Screens.CScreen;
	import Tiles.CGroundTile;
	import Tiles.CMarkerTile;
	import Tiles.CWallTile;
	import Tiles.ITile;
	
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CMain extends Sprite 
	{
		public static const visible_grid_width:int = 32;
		public static const visible_grid_height:int = 20;
		
		public static const tile_width:int = 24;
		public static const tile_height:int = 24;
		
		public var m_p_maze_bmp:Bitmap;
		public var m_p_gui_bmp:Bitmap;
		
		public var m_p_level:CLevel;
		public var m_p_gui:CGUI;
		
		public var m_camera_x:int;
		public var m_camera_y:int;
		
		public var m_is_mouse_down:Boolean;
		public var m_p_last_mouse_pos:CPoint;
		
		public var m_scale:Number;
		
		public var m_is_turn_input:Boolean;
		public var m_turn_type:int;
		public var m_next_turn_timer:int;
		
		public var m_p_player:CPlayer;
		
		public var m_p_level_tf:TextField;
		
		public var m_p_active_screen:CScreen;
		
		private var _m_p_clickables:Vector.<Object>;
		
		public function CMain():void 
		{
			if (stage) 
				Init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(p_event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			// entry point
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			_m_p_clickables = new Vector.<Object>();
			
			m_p_active_screen = new CMainMenuScreen();
			addChild(m_p_active_screen);
			
			/*m_p_gui_bmp = new Bitmap(
				new BitmapData(stage.stageWidth, (stage.stageHeight - visible_grid_height * tile_height), true, 0xFF000000),
				"auto",
				false
			);
			m_p_gui_bmp.y = m_p_maze_bmp.height;
			addChildAt(m_p_gui_bmp, 0);*/
			
			m_scale = 1.0;
			m_is_turn_input = true;
		}
		
		public function SwitchScreen(p_new_screen:CScreen):void
		{
			if (m_p_active_screen != null)
				removeChild(m_p_active_screen);
			
			m_p_active_screen = p_new_screen;
			addChild(m_p_active_screen);
		}
		
		public function MakeClickable(p_obj:DisplayObject, p_call_back:Function):void
		{
			p_obj.addEventListener(Event.REMOVED_FROM_STAGE, RemovedClickableObj);
			_m_p_clickables.push({ "obj" : p_obj, "call_back" : p_call_back } );
		}
		private function RemovedClickableObj(p_event:Event):void
		{
			var p_obj:DisplayObject = DisplayObject(p_event.currentTarget);
			p_obj.removeEventListener(Event.REMOVED_FROM_STAGE, RemovedClickableObj);
			for (var i:int = _m_p_clickables.length - 1; i > -1; --i)
			{
				if (_m_p_clickables[i].obj == p_obj)
				{
					_m_p_clickables.splice(i, 1);
					return;
				}
			}
		}
		
		private function OnMouseDown(p_event:MouseEvent):void
		{
			m_is_mouse_down = true;
			m_p_last_mouse_pos = new CPoint(p_event.stageX, p_event.stageY);
			for (var i:int = 0; i < _m_p_clickables.length; ++i)
			{
				var p_obj:DisplayObject = _m_p_clickables[i].obj as DisplayObject;
				if (p_obj == null)
					continue;
				
				if (p_obj.hitTestPoint(p_event.stageX, p_event.stageY, true))
				{
					_m_p_clickables[i].call_back(p_event);
				}
			}
		}
		private function OnMouseUp(p_event:MouseEvent):void
		{
			m_is_mouse_down = false;
		}
		
		
		private function OnEnterFrame(p_event:Event):void
		{
			m_p_active_screen.Update();
			
			/*m_p_gui_bmp.bitmapData.fillRect(new Rectangle(0, 0, m_p_gui_bmp.width, m_p_gui_bmp.height), 0xFF000000);
			
			m_p_gui.DrawTo(m_p_gui_bmp.bitmapData);*/
		}
	}
	
}