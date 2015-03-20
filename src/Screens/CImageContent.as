package Screens 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CImageContent extends CScreenContent
	{
		
		public function CImageContent(p_pos:CPoint, p_bitmap:BitmapData) 
		{
			super(p_pos, p_bitmap.width, p_bitmap.height, new CDynamicImage(p_bitmap), 0xFF000000);
		}
		
	}

}