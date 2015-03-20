package Screens 
{
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CGameScreen extends CScreen
	{
		
		public function CGameScreen() 
		{
			var p_level_content:CLevelContent = new CLevelContent(new CPoint(0, 0), CMain.visible_grid_width * CMain.tile_width, CMain.visible_grid_height * CMain.tile_height);
			AddContent(p_level_content);
			var p_gui_content:CGUIContent = new CGUIContent(new CPoint(0, p_level_content.height), 768, 576 - p_level_content.height, p_level_content.m_p_player);
			AddContent(p_gui_content);
		}
		
	}

}