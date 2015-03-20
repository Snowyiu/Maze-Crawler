package Screens 
{
	import Entities.CPlayer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CLevelContent extends CScreenContent
	{
		public var m_p_player:CPlayer;
		private var _m_p_level:CLevel;
		
		public var m_turn_type:int;
		
		public function CLevelContent(p_pos:CPoint, width:int, height:int) 
		{
			m_p_player = new CPlayer(null);
			_m_p_level = new CLevel(this, 1, Math.random() * uint.MAX_VALUE);
			
			super(p_pos, width, height, _m_p_level, 0);
		}
		
		public function GameOver():void
		{
			CMain(root).SwitchScreen(new CGameOverScreen());
		}
		
		protected override function OnAttachedToRoot():void 
		{
			super.OnAttachedToRoot();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			
			//m_p_root.MakeClickable(this, OnClicked);
		}
		
		private function OnClicked(p_event:MouseEvent):void
		{
			var tile_pos_x:int = (p_event.stageX - _m_p_level.m_camera_x) / CMain.tile_width;
			var tile_pos_y:int = (p_event.stageY - _m_p_level.m_camera_y) / CMain.tile_height;
			_m_p_level.MarkPath(new CPoint(tile_pos_x, tile_pos_y), _m_p_level.GetPlayerPos());
		}
		
		public function StartLevel(p_level:CLevel)
		{
			_m_p_level = p_level;
			SetContent(_m_p_level);
		}
		
		private function DoTurn():void
		{
			_m_p_level.DoTurn(m_turn_type);
		}
		private function OnKeyDown(p_event:KeyboardEvent):void
		{
			var is_turn:Boolean = false;
			switch(p_event.keyCode)
			{
				case Keyboard.W:
				case Keyboard.UP:
					m_turn_type = ETurnTypes.move_up;
					is_turn = true;
					break;
				case Keyboard.S:
				case Keyboard.DOWN:
					m_turn_type = ETurnTypes.move_down;
					is_turn = true;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					m_turn_type = ETurnTypes.move_left;
					is_turn = true;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					m_turn_type = ETurnTypes.move_right;
					is_turn = true;
					break;
			}
			if (is_turn)
			{
				DoTurn();
			}
		}
		private function OnKeyUp(p_event:KeyboardEvent):void
		{
		}
		
		
		public override function Update():void 
		{
			_m_p_level.UpdateTraverser(1000 / (stage.frameRate * 1.5));
			if (_m_p_level.HasGenerated)
			{
				if (m_p_player.m_p_level != _m_p_level)
				{
					m_p_player.SwitchLevel(_m_p_level);
				}
			}
			
			super.Update();
		}
	}

}