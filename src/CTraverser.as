package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CTraverser 
	{
		public static function GetIncrementalPointsTraverser(p_start:CPoint, width:int, height:int, p_points:Vector.<CPoint>, seed:uint):CIncrementalPointsTraverser
		{
			return new CIncrementalPointsTraverser(p_start, width, height, p_points, seed);
		}
		public static function TraversePoints(p_start:CPoint, width:int, height:int, p_points:Vector.<CPoint>, p_rng:CRandom):Vector.<Vector.<Boolean>>
		{
			var p_tiles:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
			for (var i:int = 0; i < width; ++i)
			{
				p_tiles.push(new Vector.<Boolean>());
				for (var j:int = 0; j < height; ++j)
				{
					p_tiles[i].push(false);
				}
			}
			p_tiles[p_start.X][p_start.Y] = true;
			
			while (p_points.length > 0)
			{
				var p_nearest_point:CPoint;
				var p_closest_points:Array = [];
				var p_near_indices:Array = [];
				var dist0:int = int.MAX_VALUE, dist1:int = int.MAX_VALUE, dist2:int = int.MAX_VALUE;
				
				for (var i:int = 0; i < p_points.length; i++)
				{
					var dist:int = p_start.DistanceTo(p_points[i]);
					if (dist < dist0)
					{
						dist2 = dist1;
						dist1 = dist0;
						dist0 = dist;
						
						p_closest_points[2] = p_closest_points[1];
						p_closest_points[1] = p_closest_points[0];
						p_closest_points[0] = p_points[i];
						
						p_near_indices[2] = p_near_indices[1];
						p_near_indices[1] = p_near_indices[0];
						p_near_indices[0] = i;
					}
					else if (dist < dist1)
					{
						dist2 = dist1;
						dist1 = dist;
						
						p_closest_points[2] = p_closest_points[1];
						p_closest_points[1] = p_points[i];
						
						p_near_indices[2] = p_near_indices[1];
						p_near_indices[1] = i;
					}
					else if (dist < dist2)
					{
						dist2 = dist;
						
						p_closest_points[2] = p_points[i];
						
						p_near_indices[2] = i;
					}
				}
				
				var point_index:int = int(p_rng.GetNextNumber() * 3);
				
				if (point_index >= p_closest_points.length)
				{
					point_index = 0;
				}
				if (point_index >= p_points.length)
				{
					point_index = p_points.length - 1;
				}
				p_nearest_point = p_closest_points[point_index];
				
				p_points.splice(p_near_indices[point_index], 1);
				
				while (true)
				{
					if (p_start.X == p_nearest_point.X && p_start.Y == p_nearest_point.Y)
						break;

					if (p_start.X != p_nearest_point.X)
					{
						if (p_start.X < p_nearest_point.X)
						{
							p_start.X ++;
						}
						else
						{
							p_start.X--;
						}
					}
					else if (p_start.Y != p_nearest_point.Y)
					{
						if (p_start.Y < p_nearest_point.Y)
						{
							p_start.Y ++;
						}
						else
						{
							p_start.Y--;
						}
					}
					
					if (p_start.X < 0)
						p_start.X = 0;
					else if (p_start.X >= width)
						p_start.X = width - 1;
					else if (p_start.Y < 0)
						p_start.Y = 0;
					else if (p_start.Y >= height)
						p_start.Y = height - 1;
					
					p_tiles[p_start.X][p_start.Y] = true;
				}
			
			}
			
			return p_tiles;	
		}
		
		public static function Traverse(x:int, y:int, width:int, height:int, num_steps:int, p_rng:CRandom):Vector.<Vector.<Boolean>>
		{
			var p_tiles:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
			for (var i:int = 0; i < width; ++i)
			{
				p_tiles.push(new Vector.<Boolean>());
				for (var j:int = 0; j < height; ++j)
				{
					p_tiles[i].push(false);
				}
			}
			p_tiles[x][y] = true;
			
			while (--num_steps > -1)
			{
				var step_val:Number = p_rng.GetNextNumber();
				if (step_val < 0.25)
				{
					++x;
				}
				else if (step_val < 0.5)
				{
					--x;
				}
				else if (step_val < 0.75)
				{
					++y;
				}
				else
				{
					--y;
				}
				
				if (x < 0)
					x = 0;
				else if (x >= width)
					x = width - 1;
				else if (y < 0)
					y = 0;
				else if (y >= height)
					y = height - 1;
				
				p_tiles[x][y] = true;
			}
			
			return p_tiles;
		}
		
		
	}

}