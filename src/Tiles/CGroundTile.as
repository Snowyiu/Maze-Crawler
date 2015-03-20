package Tiles 
{
	import Entities.CEntity;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CGroundTile implements ITile 
	{
		private static var _s_p_image:BitmapData = new BitmapData(1, 1, true, 0);
		
		public function CGroundTile() 
		{
			
		}
		
		/* INTERFACE Tiles.ITile */
		
		public function OnSteppedOn(p_entity:CEntity):void
		{
			
		}
		
		public function get Walkable():Boolean 
		{
			return true;
		}
		
		
		public function Draw():BitmapData
		{
			return CResources.s_p_ground;
		}
	}

}