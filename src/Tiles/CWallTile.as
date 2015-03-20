package Tiles 
{
	import Entities.CEntity;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CWallTile implements ITile
	{
		private var _m_p_bitmap:BitmapData;
		
		public function get Walkable():Boolean { return false; }
		
		public function CWallTile() 
		{
			
		}
		
		public function OnSteppedOn(p_entity:CEntity):void
		{
			
		}
		
		public function Draw():BitmapData
		{
			if(_m_p_bitmap == null)
				_m_p_bitmap = CResources.s_p_wall;// new BitmapData(CMain.tile_width, CMain.tile_height, false, 0);
			
			return _m_p_bitmap;
		}
	}

}