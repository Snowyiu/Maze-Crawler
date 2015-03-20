package  
{
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CPoint extends Object
	{
		private var _m_x:int;
		private var _m_y:int;
		
		public function get X():int { return _m_x; }
		public function get Y():int { return _m_y; }
		
		public function set X(value:int):void { _m_x = value; }
		public function set Y(value:int):void { _m_y = value; }
		
		public function CPoint(x:int = 0, y:int = 0) 
		{
			_m_x = x;
			_m_y = y;
		}
		
		public function Equals(p_target:CPoint):Boolean
		{
			return _m_x == p_target._m_x && _m_y == p_target._m_y;
		}
		public function DistanceTo(p_target:CPoint):int
		{
			var xdist:int = _m_x - p_target._m_x;
			var ydist:int = _m_y - p_target._m_y;
			
			if (xdist < 0)
			{
				xdist *= -1;
			}
			if (ydist < 0)
			{
				ydist *= -1;
			}
			return xdist + ydist;
		}
		
		public static function CompareDistance(p_reference_point:CPoint):Function
		{
			return function(p_left:CPoint, p_right:CPoint)
			{
				var dist1:int = p_left.DistanceTo(p_reference_point);
				var dist2:int = p_right.DistanceTo(p_reference_point);
				
				if (dist1 < dist2)
					return -1;
				else if (dist1 == dist2)
					return 0;
				else
					return 1;
			};
		}
		
		public function toString():String
		{
			return "x = " + _m_x + ", y = " + _m_y;
		}
	}

}