package Screens 
{
	import Entities.CPlayer;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CGUIContent extends CScreenContent
	{
		private var _m_p_gui:CGUI;
		
		public function CGUIContent(p_pos:CPoint, width:int, height:int, p_player:CPlayer) 
		{
			_m_p_gui = new CGUI(p_player);
			
			super(p_pos, width, height, _m_p_gui, 0xFF000000);
		}
		
	}

}