package Entities 
{
	import Animations.CSpriteSheetAnimation;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CEnemyWorm extends CEntityLiving
	{
		private var _m_p_current_path:Vector.<CPoint>;
		private var _m_current_path_pos:int;
		
		private var _m_attacking:Boolean;
		
		public function CEnemyWorm(p_level:CLevel) 
		{
			super(p_level, 1);
			m_p_image.SwitchImage(CResources.s_p_enemy_worm);
		}
		
		protected override function OnDeath():void 
		{
			super.OnDeath();
			m_p_image.SwitchImage(CResources.s_p_enemy_worm_dead);
		}
		
		public override function DoTurn(turn_type:int):void 
		{
			if (!IsAlive)
			{
				return;
			}
			
			if (m_p_level.DistanceToPlayer(m_x, m_y) < 5 || m_p_level.HasLineOfSight(this, m_p_level.GetPlayer()))
			{
				_m_current_path_pos = 1; // fixes worms teleporting
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
		
		protected override function MoveTo(relative_x:int, relative_y:int):Boolean 
		{
			if (super.MoveTo(relative_x, relative_y))
			{
				AddAnimation(new CSpriteSheetAnimation(m_p_image, CResources.s_p_enemy_worm_moving, 166));
				return true;
			}
			else
			{
				return false;
			}
		}
	}

}