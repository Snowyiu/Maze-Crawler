package Screens 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CDynamicImage implements IDrawable
	{
		private var _m_p_bitmap:BitmapData;
		
		public function CDynamicImage(p_bitmap:BitmapData) 
		{
			_m_p_bitmap = p_bitmap;
		}
		
		public function SwitchBitmap(p_bitmap:BitmapData)
		{
			_m_p_bitmap = p_bitmap;
		}
		
		/* INTERFACE Screens.IDrawable */
		
		public function DrawTo(p_bitmap_data:BitmapData):void 
		{
			p_bitmap_data.draw(_m_p_bitmap);
		}
	}

}