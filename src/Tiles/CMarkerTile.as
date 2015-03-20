package Tiles 
{
	import Entities.CEntity;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CMarkerTile implements ITile
	{
		
		public function CMarkerTile() 
		{
			
		}
		
		public function get Walkable():Boolean 
		{
			return true;
		}
		public function OnSteppedOn(p_entity:CEntity):void
		{
			
		}
		
		public function Draw():BitmapData 
		{
			return new BitmapData(CMain.tile_width, CMain.tile_height, false, 0xFFFF0000);
		}
		
	}

}