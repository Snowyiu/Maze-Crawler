package Entities 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CEntityLiving extends CEntity
	{
		public var m_health:int;
		public var m_max_health:int;
		
		public function get IsAlive():Boolean
		{
			return m_health > 0;
		}
		
		public function CEntityLiving(p_level:CLevel, health:int) 
		{
			if (health < 0)
				health = 0;
			
			m_health = health;
			m_max_health = health;
			super(p_level);
		}
		
		protected function OnDeath():void
		{
			// virtual
		}
		
		public function TakeDamage():void
		{
			var is_killing_blow:Boolean;
			if (m_health == 1)
			{
				is_killing_blow = true;
			}
			else
			{
				is_killing_blow = false;
			}
			--m_health;
			if (is_killing_blow)
				OnDeath();
			
			if (m_health < 0)
				m_health = 0;
		}
		public function Heal():void
		{
			++m_health;
			if (m_health > m_max_health)
				m_health = m_max_health;
		}
		
		public function DrawAlive():BitmapData
		{
			return null;
		}
		public function DrawDead():BitmapData
		{
			return null;
		}
		public override function Draw():BitmapData 
		{
			if (IsAlive)
			{
				return DrawAlive();
			}
			else
			{
				return DrawDead();
			}
		}
	}

}