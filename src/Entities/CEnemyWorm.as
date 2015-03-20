package Entities 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CEnemyWorm extends CEntityLiving
	{
		private var _m_p_current_path:Vector.<CPoint>;
		private var _m_current_path_pos:int;
		
		private var _m_attacking:Boolean;
		
		public function CEnemyWorm(p_level:CLevel) 
		{
			super(p_level, 1);
		}
		
		public override function DoTurn(turn_type:int):void 
		{
			if (!IsAlive)
			{
				return;
			}
			
			if (m_p_level.DistanceToPlayer(m_x, m_y) < 5)
			{
				_m_p_current_path = m_p_level.GetPath(new CPoint(m_x, m_y), m_p_level.GetPlayerPos());
				if (_m_p_current_path.length > 2)
				{
					_m_attacking = false;
					MoveTo(_m_p_current_path[1].X - m_x, _m_p_current_path[1].Y - m_y);
				}
				else
				{
					// Possibly attacking logic here
					if (_m_attacking)
					{
						_m_attacking = false;
						m_p_level.GetPlayer().TakeDamage();
					}
					else
					{
						_m_attacking = true;
					}
				}
			}
			else
			{
				_m_attacking = false;
				++_m_current_path_pos;
				if (_m_p_current_path == null || _m_current_path_pos >= _m_p_current_path.length)
				{
					var p_target:CPoint;
					var p_pos:CPoint = new CPoint(m_x, m_y);
					do
					{
						p_target = m_p_level.GetWalkableTileCloseTo(m_x + Math.random() * 10 - 5, m_y + Math.random() * 10 - 5);
					}
					while (p_pos.Equals(p_target));
					
					_m_p_current_path = m_p_level.GetPath(new CPoint(m_x, m_y), p_target);
					_m_current_path_pos = 1;
				}
				
				if (!MoveTo(_m_p_current_path[_m_current_path_pos].X - m_x, _m_p_current_path[_m_current_path_pos].Y - m_y))
				{
					_m_p_current_path = null;
				}
			}
		}
		
		public override function DrawAlive():BitmapData 
		{
			return CResources.s_p_opponent_worm;
		}
		public override function DrawDead():BitmapData 
		{
			return CResources.s_p_opponent_worm_dead;
		}
	}

}