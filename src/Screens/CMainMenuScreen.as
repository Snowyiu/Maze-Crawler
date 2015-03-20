package Screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CMainMenuScreen extends CScreen
	{
		private var _m_p_start_btn:CButtonContent;
		
		public function CMainMenuScreen()
		{
			AddContent(new CImageContent(new CPoint(0, 0), CResources.s_p_main_menu_screen));
			
			_m_p_start_btn = new CButtonContent(new CPoint(0, 0));
			_m_p_start_btn.Text = "Start";
			_m_p_start_btn.addEventListener(MouseEvent.MOUSE_DOWN, OnStartButtonClicked);
			AddContent(_m_p_start_btn);
			
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}
		
		private function OnAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			_m_p_start_btn.x = stage.stageWidth / 2 - _m_p_start_btn.width / 2;
			_m_p_start_btn.y = stage.stageHeight / 2 - _m_p_start_btn.height / 2;
		}
		
		
		
		private function OnStartButtonClicked(p_event:MouseEvent):void 
		{
			CMain(root).SwitchScreen(new CGameScreen());
		}
	}

}