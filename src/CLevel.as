package  
{
	import adobe.utils.CustomActions;
	import Entities.CEnemyWorm;
	import Entities.CEntity;
	import Entities.CEntityLiving;
	import Entities.CPlayer;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import Screens.CLevelContent;
	import Screens.IDrawable;
	import Tiles.CGroundTile;
	import Tiles.CLadderTile;
	import Tiles.CMarkerTile;
	import Tiles.CWallTile;
	import Tiles.ITile;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CLevel implements IDrawable
	{
		private var _m_p_grid:Vector.<Vector.<ITile>>;
		private var _m_grid_width:int;
		private var _m_grid_height:int;
		
		public var m_p_root:CLevelContent;
		private var _m_p_rng:CRandom;
		
		private var _m_is_generating:Boolean;
		private var _m_p_traverser:CIncrementalPointsTraverser;
		
		public function get PixelWidth():int
		{
			return _m_grid_width * CMain.tile_width;
		}
		public function get PixelHeight():int
		{
			return _m_grid_height * CMain.tile_height;
		}
		
		public function get HasGenerated():Boolean { return !_m_is_generating; }
		
		public var m_level_num:int;
		
		private var _m_p_entities:Vector.<CEntity>;
		private var _m_p_player:CPlayer;
		
		private var _m_p_next_level:CLevel;
		
		public var m_camera_x:Number;
		public var m_camera_y:Number;
		public var m_scale:Number;
		
		public var m_animation_time_left:int;
		public var m_next_level:Boolean;
		
		public function CLevel(p_root:CLevelContent, num:int, seed:uint) 
		{
			trace("Created Level " + num);
			_m_p_rng = new CRandom(seed);
			_m_p_entities = new Vector.<CEntity>();
			m_p_root = p_root;
			m_level_num = num;
			MakeMaze(num);
			
			m_scale = 1.0;
		}
		
		public function GetPath(p_start:CPoint, p_goal:CPoint):Vector.<CPoint>
		{
			var p_paths:Vector.<Vector.<CPoint>> = new Vector.<Vector.<CPoint>>();
			var p_visited:Dictionary = new Dictionary();
			p_paths.push(new <CPoint>[p_start]);
			
			p_visited[p_start.toString()] = true;
			
			var max_steps:int = 1000;
			while (true)
			{
				for (var i:int = p_paths.length - 1; i > -1; --i)
				{
					var p_last:CPoint = p_paths[i][p_paths[i].length - 1];
					var p_next:CPoint;
					
					if (p_last.Equals(p_goal))
						return p_paths[i];
					
					var needs_new_branch:Boolean = false;
					var has_ended:Boolean = true;
					
					if (IsWalkable(p_last.X, p_last.Y - 1))
					{
						p_next = new CPoint(p_last.X, p_last.Y - 1);
						if (!Boolean(p_visited[p_next.toString()]))
						{
							p_paths[i].push(p_next);
							p_visited[p_next.toString()] = true;
							needs_new_branch = true;
							has_ended = false;
						}
					}
					if (IsWalkable(p_last.X, p_last.Y + 1))
					{
						p_next = new CPoint(p_last.X, p_last.Y + 1);
						if (!Boolean(p_visited[p_next.toString()]))
						{
							if (needs_new_branch)
							{
								var p_new_path:Vector.<CPoint> = new Vector.<CPoint>();
								for (var j:int = 0; j < p_paths[i].length - 1; ++j)
								{
									p_new_path.push(p_paths[i][j]);
								}
								p_new_path.push(p_next);
								p_paths.push(p_new_path);
								
								p_visited[p_next.toString()] = true;
							}
							else
							{
								p_paths[i].push(p_next);
								p_visited[p_next.toString()] = true;
								needs_new_branch = true;
								has_ended = false;
							}
						}
					}
					if (IsWalkable(p_last.X - 1, p_last.Y))
					{
						p_next = new CPoint(p_last.X - 1, p_last.Y);
						if (!Boolean(p_visited[p_next.toString()]))
						{
							if (needs_new_branch)
							{
								var p_new_path:Vector.<CPoint> = new Vector.<CPoint>();
								for (var j:int = 0; j < p_paths[i].length - 1; ++j)
								{
									p_new_path.push(p_paths[i][j]);
								}
								p_new_path.push(p_next);
								p_paths.push(p_new_path);
								
								p_visited[p_next.toString()] = true;
							}
							else
							{
								p_paths[i].push(p_next);
								p_visited[p_next.toString()] = true;
								needs_new_branch = true;
								has_ended = false;
							}
						}
					}
					if (IsWalkable(p_last.X + 1, p_last.Y))
					{
						p_next = new CPoint(p_last.X + 1, p_last.Y);
						if (!Boolean(p_visited[p_next.toString()]))
						{
							if (needs_new_branch)
							{
								var p_new_path:Vector.<CPoint> = new Vector.<CPoint>();
								for (var j:int = 0; j < p_paths[i].length - 1; ++j)
								{
									p_new_path.push(p_paths[i][j]);
								}
								p_new_path.push(p_next);
								p_paths.push(p_new_path);
								
								p_visited[p_next.toString()] = true;
							}
							else
							{
								p_paths[i].push(p_next);
								p_visited[p_next.toString()] = true;
								needs_new_branch = true;
								has_ended = false;
							}
						}
					}
					
					if (has_ended)
					{
						p_paths.splice(i, 1);
					}
				}
			}
			return null;
		}
		public function MarkPath(p_start:CPoint, p_goal:CPoint):void
		{
			for (var x:int = 0; x < _m_p_grid.length; ++x)
			{
				var p_column:Vector.<ITile> = _m_p_grid[x];
				for (var y:int = 0; y < p_column.length; ++y)
				{
					if (p_column[y] is CMarkerTile)
					{
						p_column[y] = new CGroundTile();
					}
				}
			}
			var p_path:Vector.<CPoint> = GetPath(p_start, p_goal);
			for (var i:int = 0; i < p_path.length; ++i)
			{
				_m_p_grid[p_path[i].X][p_path[i].Y] = new CMarkerTile();
			}
		}
		
		private function SpawnLadder():void
		{
			var angle:Number = _m_p_rng.GetNextNumber() * Math.PI * 2;
			var dist:Number = _m_grid_height / 4 + _m_p_rng.GetNextNumber() * _m_grid_height / 4;
			var ladder_x:int = Math.cos(angle) * dist;
			var ladder_y:int = Math.sin(angle) * dist;
			var p_ladder_pos:CPoint = GetWalkableTileCloseTo(_m_grid_width / 2 + ladder_x, _m_grid_height / 2 + ladder_y);
			_m_p_grid[p_ladder_pos.X][p_ladder_pos.Y] = new CLadderTile();
			
			trace("Ladder at " + p_ladder_pos.X + "/" + p_ladder_pos.Y);
		}
		
		private function PopulateLevel():void
		{
			var spawn_tries:uint = (_m_grid_width * _m_grid_height) / 30;
			var p_player_start:CPoint = GetPlayerStartPos();
			
			for (var i:uint = 0; i < spawn_tries; ++i)
			{
				var p_spawn_point:CPoint = new CPoint(_m_p_rng.GetNextNumber() * _m_grid_width, _m_p_rng.GetNextNumber() * _m_grid_height);
				if (!IsWalkable(p_spawn_point.X, p_spawn_point.Y) || p_spawn_point.DistanceTo(p_player_start) < 10)
				{
					continue;
				}
				var p_worm:CEnemyWorm = new CEnemyWorm(this);
				p_worm.m_x = p_spawn_point.X;
				p_worm.m_y = p_spawn_point.Y;
				p_worm.m_draw_x = p_worm.m_x;
				p_worm.m_draw_y = p_worm.m_y;
			}
		}
		
		public function NextLevel():void
		{
			if (m_animation_time_left > 0)
			{
				m_next_level = true;
				return;
			}
			if (_m_p_next_level == null)
			{
				_m_p_next_level = new CLevel(m_p_root, m_level_num + 1, _m_p_rng.GetNext());
			}
			m_p_root.StartLevel(_m_p_next_level);
		}
		
		public function UpdateTraverser(max_time:Number):void
		{
			if (_m_p_traverser == null)
			{
				if (_m_p_next_level == null)
				{
					_m_p_next_level = new CLevel(m_p_root, m_level_num + 1, _m_p_rng.GetNext());
				}
				if (!_m_p_next_level.HasGenerated)
				{
					_m_p_next_level.UpdateTraverser(max_time);
				}
				return;
			}
			
			_m_p_traverser.Traverse(max_time);
			
			if (_m_p_traverser.IsFinished)
			{
				var p_tiles:Vector.<Vector.<Boolean>> = _m_p_traverser.Result;
				
				var p_grid:Vector.<Vector.<ITile>> = new Vector.<Vector.<ITile>>();
				for (var i:int = 0; i < _m_grid_width; ++i)
				{
					var p_column:Vector.<ITile> = new Vector.<ITile>();
					for (var j:int = 0; j < _m_grid_height; ++j)
					{
						p_column.push(null);
					}
					p_grid.push(p_column);
				}
				
				for (var x:int = 0; x < p_tiles.length; ++x)
				{
					var p_tile_column:Vector.<Boolean> = p_tiles[x];
					for (var y:int = 0; y < p_tile_column.length; ++y)
					{
						if (p_tile_column[y])
						{
							p_grid[x][y] = new CGroundTile();
						}
						else
						{
							p_grid[x][y] = new CWallTile();
						}
					}
				}
				_m_p_grid = p_grid;
				SpawnLadder();
				PopulateLevel();
				
				_m_p_traverser = null;
				_m_is_generating = false;
			}
		}
		
		public function DoTurn(turn_type:int):void
		{
			if (m_animation_time_left > 0)
				return;
			
			m_animation_time_left = 1;
			for (var i:int = _m_p_entities.length - 1; i > -1; --i)
			{
				_m_p_entities[i].DoTurn(turn_type);
			}
			
			var max_anim_duration:int = 0;
			for (var i:int = 0; i < _m_p_entities.length; ++i)
			{
				var duration:int = _m_p_entities[i].GetAnimationDuration();
				if (duration > max_anim_duration)
					max_anim_duration = duration;
				
				_m_p_entities[i].PlayAllAnimations();
			}
			m_animation_time_left = max_anim_duration;
		}
		
		public function GetPlayer():CPlayer
		{
			return _m_p_player;
		}
		public function GetPlayerPos():CPoint
		{
			return new CPoint(_m_p_player.m_x, _m_p_player.m_y);
		}
		public function DistanceToPlayer(tile_x:int, tile_y:int):int
		{
			if (_m_p_player == null)
			{
				return int.MAX_VALUE;
			}
			
			return new CPoint(_m_p_player.m_x, _m_p_player.m_y).DistanceTo(new CPoint(tile_x, tile_y));
		}
		
		public function AddEntity(p_entity:CEntity):void
		{
			if (p_entity is CPlayer)
				_m_p_player = CPlayer(p_entity);
			
			_m_p_entities.push(p_entity);
		}
		public function MoveEntity(p_entity:CEntity, targ_x:int, targ_y:int):Boolean
		{
			if (!IsWalkable(targ_x, targ_y))
				return false;
			
			var p_entities_on_targ:Vector.<CEntity> = GetEntitiesOn(targ_x, targ_y);
			for (var i:int = 0; i <  p_entities_on_targ.length; ++i)
			{
				var p_entity_on_targ:CEntity = p_entities_on_targ[i];
				if (p_entity_on_targ != null)
				{
					var p_living_on_targ:CEntityLiving = p_entity_on_targ as CEntityLiving;
					if(p_living_on_targ == null || p_living_on_targ.IsAlive)
					{
						return false;
					}
				}
			}
			
			p_entity.m_x = targ_x;
			p_entity.m_y = targ_y;
			_m_p_grid[targ_x][targ_y].OnSteppedOn(p_entity);
			return true;
		}
		public function GetEntitiesOn(tile_x:int, tile_y:int):Vector.<CEntity>
		{
			var p_entities:Vector.<CEntity> = new Vector.<CEntity>();
			for (var i:int = 0; i < _m_p_entities.length; ++i)
			{
				if (_m_p_entities[i].m_x == tile_x && _m_p_entities[i].m_y == tile_y)
				{
					p_entities.push(_m_p_entities[i]);
				}
			}
			return p_entities;
		}
		
		public function GetPlayerStartPos():CPoint
		{
			return GetWalkableTileCloseTo(_m_grid_width / 2, _m_grid_height / 2);
		}
		
		public function HasLineOfSight(p_entity1:CEntity, p_entity2:CEntity):Boolean
		{
			//Cannot have line of sight if both axes are different
			if (p_entity1.m_x != p_entity2.m_x && p_entity1.m_y != p_entity2.m_y)
			{
				return false;
			}
			if (p_entity1.m_y != p_entity2.m_y)
			{
				var result:Boolean = true;
				var dy:int = p_entity1.m_y - p_entity2.m_y;
				if (dy > 0)
				{
					for ( var i:uint = 1; i < dy; i++)
					{
						if ( _m_p_grid[p_entity2.m_x][p_entity2.m_y + i].Walkable != true)
						{
							return false;
						}
					}
				}
				else
				{
					for ( var i:uint = 1; i < dy; i++)
					{
						if ( _m_p_grid[p_entity1.m_x][p_entity1.m_y + i].Walkable != true)
						{
							return false;
						}
					}
				}
			}
			else if (p_entity1.m_x != p_entity2.m_x)
			{
				var result:Boolean = true;
				var dx:int = p_entity1.m_x - p_entity2.m_x;
				if (dx > 0)
				{
					for ( var i:uint = 1; i < dx; i++)
					{
						if ( _m_p_grid[p_entity2.m_x + i][p_entity2.m_y].Walkable != true)
						{
							return false;
						}
					}
				}
				else
				{
					for ( var i:uint = 1; i < dx; i++)
					{
						if ( _m_p_grid[p_entity1.m_x + i][p_entity1.m_y].Walkable != true)
						{
							return false;
						}
					}
				}
			}
			//Will immediately return true if both m_x and m_y are the same.
			return true;
		}
		
		public function GetWalkableTileCloseTo(tile_x:int, tile_y:int):CPoint
		{
			if (IsWalkable(tile_x, tile_y))
				return new CPoint(tile_x, tile_y);
			
			var distance:int = 1;
			var offset:int = 0;
			while (true)
			{
				while (offset <= distance)
				{
					if (IsWalkable(tile_x + offset, tile_y - distance))
						return new CPoint(tile_x + offset, tile_y - distance);
					else if (IsWalkable(tile_x + distance, tile_y - offset))
						return new CPoint(tile_x + distance, tile_y - offset);
					else if (IsWalkable(tile_x + distance, tile_y + offset))
						return new CPoint(tile_x + distance, tile_y + offset);
					else if (IsWalkable(tile_x + offset, tile_y + distance))
						return new CPoint(tile_x + offset, tile_y + distance);
					else if (IsWalkable(tile_x - offset, tile_y + distance))
						return new CPoint(tile_x - offset, tile_y + distance);
					else if (IsWalkable(tile_x - distance, tile_y + offset))
						return new CPoint(tile_x - distance, tile_y + offset);
					else if (IsWalkable(tile_x - distance, tile_y - offset))
						return new CPoint(tile_x - distance, tile_y - offset);
					else if (IsWalkable(tile_x - offset, tile_y - distance))
						return new CPoint(tile_x - offset, tile_y - distance);
					++offset;
				}
				++distance;
				if (distance >= _m_grid_width || distance >= _m_grid_height)
					throw new Error("Could not find a free tile.");
			}
			
			return null;
		}
		public function IsWalkable(tile_x:int, tile_y:int):Boolean
		{
			if (tile_x < 0 || tile_y < 0 || tile_x >= _m_grid_width || tile_y >= _m_grid_height)
				return false;
			
			return _m_p_grid[tile_x][tile_y].Walkable;
		}
		
		public function DrawTo(p_bitmap_data:BitmapData):void
		{
			if (m_next_level && m_animation_time_left == 1)
			{
				if (_m_p_next_level == null)
				{
					_m_p_next_level = new CLevel(m_p_root, m_level_num + 1, _m_p_rng.GetNext());
				}
				m_p_root.StartLevel(_m_p_next_level);
			}
			
			--m_animation_time_left;
			if (_m_p_player != null)
			{
				m_camera_x = -_m_p_player.m_draw_x * CMain.tile_width * m_scale + p_bitmap_data.width * 0.5;
				m_camera_y = -_m_p_player.m_draw_y * CMain.tile_height * m_scale + p_bitmap_data.height * 0.5;
				
				if (m_camera_x > 0)
					m_camera_x = 0;
				else if (m_camera_x < -(PixelWidth * m_scale - p_bitmap_data.width))
					m_camera_x = -(PixelWidth * m_scale - p_bitmap_data.width);
				if (m_camera_y > 0)
					m_camera_y = 0;
				else if (m_camera_y < -(PixelHeight * m_scale - p_bitmap_data.height))
					m_camera_y = -(PixelHeight * m_scale - p_bitmap_data.height);
					
				m_camera_x = int(m_camera_x + 0.5);
				m_camera_y = int(m_camera_y + 0.5);
			}
			
			if (_m_p_traverser != null)
			{
				var bar_height:int = 25;
				var bar_width:int = p_bitmap_data.width / 2;
				var bar_x:int = p_bitmap_data.width / 4;
				var bar_y:int = p_bitmap_data.height / 2 - bar_height / 2;
				
				p_bitmap_data.fillRect(new Rectangle(bar_x, bar_y, bar_width, bar_height), 0xFF990000);
				
				bar_width *= _m_p_traverser.Progress;
				
				p_bitmap_data.fillRect(new Rectangle(bar_x, bar_y, bar_width, bar_height), 0xFF009900);
				
				return;
			}
			
			var left_tile:int = -m_camera_x / (CMain.tile_width * m_scale);
			var top_tile:int = -m_camera_y / (CMain.tile_height * m_scale);
			var right_tile:int = (-m_camera_x + (CMain.tile_width * m_scale) + p_bitmap_data.width) / (CMain.tile_width * m_scale);
			var bottom_tile:int = (-m_camera_y + (CMain.tile_height * m_scale) + p_bitmap_data.height) / (CMain.tile_height * m_scale);
			
			if (left_tile < 0)
				left_tile = 0;
			
			if (top_tile < 0)
				top_tile = 0;
			
			if (left_tile > _m_p_grid.length)
				return;
			else if (top_tile > _m_p_grid[0].length)
				return;
			
			for (var x:int = left_tile; x < right_tile && x < _m_p_grid.length; ++x)
			{
				var p_column:Vector.<ITile> = _m_p_grid[x];
				for (var y:int = top_tile; y < bottom_tile && y < p_column.length; ++y)
				{
					p_bitmap_data.draw(p_column[y].Draw(), new Matrix(m_scale, 0, 0, m_scale, m_camera_x + x * CMain.tile_width * m_scale, m_camera_y + y * CMain.tile_height * m_scale));
				}
			}
			
			for (var i:int = 0; i < _m_p_entities.length; ++i)
			{
				p_bitmap_data.draw(_m_p_entities[i].Draw(), new Matrix(m_scale, 0, 0, m_scale, m_camera_x + _m_p_entities[i].m_draw_x * CMain.tile_width * m_scale, m_camera_y + _m_p_entities[i].m_draw_y * CMain.tile_height * m_scale));
			}
		}
		
		private function MakeMaze(maze_level:int):void
		{
			_m_is_generating = true;
			
			var grid_width:int = CMain.visible_grid_width + maze_level * 4;
			var grid_height:int = CMain.visible_grid_height + maze_level * 4;
			_m_grid_width = grid_width;
			_m_grid_height = grid_height;
			
			var p_points:Vector.<CPoint> = new Vector.<CPoint>();
			for (var i:int = 1; i < (grid_width - 1); i += 2)
			{
				for (var j:int = 1; j < (grid_height - 1); j += 2)
				{
					if (_m_p_rng.GetNextNumber() < 0.85)
					{
						p_points.push(new CPoint(i, j));
					}
				}
			}
			
			_m_p_traverser = CTraverser.GetIncrementalPointsTraverser(
				new CPoint(grid_width / 2, grid_height / 2), 
				grid_width, 
				grid_height, 
				p_points,
				_m_p_rng.GetNext()
			);
		}
	}

}