package Screens 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CGameOverScreen extends CScreen
	{
		private var _m_p_retry_btn:CButtonContent;
		private var _m_p_main_menu_btn:CButtonContent;
		
		public function CGameOverScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			AddContent(new CImageContent(new CPoint(0, 0), CResources.s_p_game_over_screen));
		}
		
		private function OnAddedToStage(p_event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			_m_p_retry_btn = new CButtonContent(new CPoint(0, 0));
			_m_p_retry_btn.Text = "Retry";
			_m_p_main_menu_btn = new CButtonContent(new CPoint(0, 0));
			_m_p_main_menu_btn.Text = "Main Menu";
			_m_p_retry_btn.addEventListener(MouseEvent.MOUSE_DOWN, OnRetryBtnClicked);
			_m_p_main_menu_btn.addEventListener(MouseEvent.MOUSE_DOWN, OnMainMenuBtnClicked);
			AddContent(_m_p_retry_btn);
			AddContent(_m_p_main_menu_btn);
			
			_m_p_retry_btn.x = stage.stageWidth / 2 - _m_p_retry_btn.width / 2;
			_m_p_retry_btn.y = stage.stageWidth / 2 - _m_p_retry_btn.height / 2;
			
			_m_p_main_menu_btn.x = _m_p_retry_btn.x;
			_m_p_main_menu_btn.y = _m_p_retry_btn.y + _m_p_retry_btn.height + 5;
		}
		
		private function OnRetryBtnClicked(p_event:MouseEvent):void 
		{
			CMain(root).SwitchScreen(new CGameScreen());
		}
		
		private function OnMainMenuBtnClicked(p_event:MouseEvent):void 
		{
			CMain(root).SwitchScreen(new CMainMenuScreen());
		}
		
	}

}