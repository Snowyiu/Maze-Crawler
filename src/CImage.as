package  
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author default0
	 */
	public class CImage
	{
		private var _m_p_image:BitmapData;
		private var _m_p_matrix_transform:Matrix;
		private var _m_p_size:CPoint;
		
		private var _m_p_cached:BitmapData;
		
		public function get Width():int { return _m_p_size.X; }
		public function get Height():int { return _m_p_size.Y; }
		
		public function CImage(p_size:CPoint, p_image:BitmapData, p_matrix_transform:Matrix) 
		{
			_m_p_image = p_image;
			_m_p_size = p_size;
			_m_p_matrix_transform = p_matrix_transform;
		}
		
		public function SwitchImage(p_img:BitmapData, auto_resize:Boolean = true):void
		{
			_m_p_image = p_img;
			if (auto_resize)
			{
				_m_p_size = new CPoint(_m_p_image.width, _m_p_image.height);
			}
			RebuildCache();
		}
		public function SwitchMatrix(p_matrix:Matrix):void
		{
			_m_p_matrix_transform = p_matrix;
			RebuildCache();
		}
		
		private function RebuildCache():void
		{
			_m_p_cached = new BitmapData(_m_p_size.X, _m_p_size.Y, true, 0);
			_m_p_cached.draw(_m_p_image, _m_p_matrix_transform);
		}
		
		public function Get():BitmapData
		{
			return _m_p_cached;
		}
	}

}