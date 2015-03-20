package Tiles 
{
	import Entities.CEntity;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public interface ITile
	{
		function get Walkable():Boolean;
		
		function OnSteppedOn(p_entity:CEntity):void;
		
		function Draw():BitmapData;
	}

}