package  
{
	import Entities.CPlayer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import Screens.IDrawable;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CGUI implements IDrawable
	{
		private var _m_p_player:CPlayer;
		
		public function CGUI(p_player:CPlayer) 
		{
			_m_p_player = p_player;
		}
		
		public function DrawTo(p_bitmap_data:BitmapData):void
		{
			for (var i:int = 0; i < _m_p_player.m_health; ++i)
			{
				p_bitmap_data.draw(CResources.s_p_glowing_heart_full, new Matrix(2, 0, 0, 2, -2 + CMain.tile_width + i * CMain.tile_width * 3, -2 + CMain.tile_height), null, null, null, false);
			}
			for (var i:int = _m_p_player.m_health; i < _m_p_player.m_max_health; ++i)
			{
				p_bitmap_data.draw(CResources.s_p_heart_empty, new Matrix(2, 0, 0, 2, CMain.tile_width + i * CMain.tile_width * 3, CMain.tile_height), null, null, null, false);
			}
		}
	}

}