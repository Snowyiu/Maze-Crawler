package Tiles {
	import Entities.CEntity;
	import Entities.CPlayer;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CLadderTile implements ITile
	{
		private var _m_p_bitmap:BitmapData;
		
		public function CLadderTile() 
		{
			
		}
		
		public function Draw():BitmapData 
		{
			if (_m_p_bitmap == null)
			{
				_m_p_bitmap = new BitmapData(CMain.tile_width, CMain.tile_height, true, 0);
				_m_p_bitmap.draw(CResources.s_p_ground);
				_m_p_bitmap.draw(CResources.s_p_ladder);
			}
			return _m_p_bitmap;
		}
		
		/* INTERFACE Tiles.ITile */
		
		public function OnSteppedOn(p_entity:CEntity):void
		{
			if (p_entity is CPlayer)
				p_entity.m_p_level.NextLevel();
		}
		
		public function get Walkable():Boolean 
		{
			return true;
		}
	}

}