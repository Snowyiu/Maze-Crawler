package  
{
	import flash.globalization.DateTimeFormatter;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CIncrementalPointsTraverser 
	{
		private var _m_p_tiles:Vector.<Vector.<Boolean>>;
		
		private var _m_p_start:CPoint;
		private var _m_width:int;
		private var _m_height:int;
		
		private var _m_p_points:Vector.<CPoint>;
		private var _m_p_rng:CRandom;
		
		private var _m_total_points:int;
		
		private var _m_p_nearest_point:CPoint;
		
		private var _m_finished:Boolean;
		
		public function get Progress():Number
		{
			var points_pct:Number = Number(_m_p_points.length) / Number(_m_total_points);
			return 1.0 - (points_pct * points_pct); // points-traversal is O(n^2) so progress bar has to reflect that
		}
		public function get IsFinished():Boolean
		{
			return _m_finished;
		}
		public function get Result():Vector.<Vector.<Boolean>>
		{
			if (!_m_finished)
				return null;
			
			return _m_p_tiles;
		}
		
		public function CIncrementalPointsTraverser(p_start:CPoint, width:int, height:int, p_points:Vector.<CPoint>, seed:uint) 
		{
			_m_finished = false;
			
			_m_p_tiles = new Vector.<Vector.<Boolean>>();
			for (var i:int = 0; i < width; ++i)
			{
				_m_p_tiles.push(new Vector.<Boolean>());
				for (var j:int = 0; j < height; ++j)
				{
					_m_p_tiles[i].push(false);
				}
			}
			_m_p_tiles[p_start.X][p_start.Y] = true;
			
			_m_p_start = p_start;
			_m_width = width;
			_m_height = height;
			_m_p_points = p_points;
			_m_total_points = _m_p_points.length;
			
			_m_p_rng = new CRandom(seed);
		}
		
		public function Traverse(max_time:Number):void
		{
			var time_started:Number = new Date().getTime();
			while (_m_p_points.length > 0)
			{
				if (_m_p_nearest_point == null)
				{
					var p_closest_points:Array = [];
					var p_near_indices:Array = [];
					var dist0:int = int.MAX_VALUE, dist1:int = int.MAX_VALUE, dist2:int = int.MAX_VALUE;
					
					for (var i:int = 0; i < _m_p_points.length; i++)
					{
						var dist:int = _m_p_start.DistanceTo(_m_p_points[i]);
						if (dist < dist0)
						{
							dist2 = dist1;
							dist1 = dist0;
							dist0 = dist;
							
							p_closest_points[2] = p_closest_points[1];
							p_closest_points[1] = p_closest_points[0];
							p_closest_points[0] = _m_p_points[i];
							
							p_near_indices[2] = p_near_indices[1];
							p_near_indices[1] = p_near_indices[0];
							p_near_indices[0] = i;
						}
						else if (dist < dist1)
						{
							dist2 = dist1;
							dist1 = dist;
							
							p_closest_points[2] = p_closest_points[1];
							p_closest_points[1] = _m_p_points[i];
							
							p_near_indices[2] = p_near_indices[1];
							p_near_indices[1] = i;
						}
						else if (dist < dist2)
						{
							dist2 = dist;
							
							p_closest_points[2] = _m_p_points[i];
							
							p_near_indices[2] = i;
						}
					}
					
					var point_index:int = int(_m_p_rng.GetNextNumber() * 3);
					
					if (point_index >= p_closest_points.length)
					{
						point_index = 0;
					}
					if (point_index >= _m_p_points.length)
					{
						point_index = _m_p_points.length - 1;
					}
					_m_p_nearest_point = p_closest_points[point_index];
					
					_m_p_points.splice(p_near_indices[point_index], 1);
					
					if ((new Date().getTime() - time_started) > max_time)
					{
						return;
					}
				}
				
				while (true)
				{
					if (_m_p_start.X == _m_p_nearest_point.X && _m_p_start.Y == _m_p_nearest_point.Y)
						break;

					if (_m_p_start.X != _m_p_nearest_point.X)
					{
						if (_m_p_start.X < _m_p_nearest_point.X)
						{
							_m_p_start.X ++;
						}
						else
						{
							_m_p_start.X--;
						}
					}
					else if (_m_p_start.Y != _m_p_nearest_point.Y)
					{
						if (_m_p_start.Y < _m_p_nearest_point.Y)
						{
							_m_p_start.Y ++;
						}
						else
						{
							_m_p_start.Y--;
						}
					}
					
					if (_m_p_start.X < 0)
						_m_p_start.X = 0;
					else if (_m_p_start.X >= _m_width)
						_m_p_start.X = _m_width - 1;
					else if (_m_p_start.Y < 0)
						_m_p_start.Y = 0;
					else if (_m_p_start.Y >= _m_height)
						_m_p_start.Y = _m_height - 1;
					
					_m_p_tiles[_m_p_start.X][_m_p_start.Y] = true;
				}
				
				_m_p_nearest_point = null;
					
				if ((new Date().getTime() - time_started) > max_time)
				{
					return;
				}
			}
			_m_finished = true;
		}
	}

}