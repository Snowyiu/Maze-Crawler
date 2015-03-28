package Entities
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CPlayer extends CEntityLiving
	{	
		public function CPlayer(p_level:CLevel)
		{
			super(p_level, 2);
			
			if (p_level != null)
			{
				var p_start_pos:CPoint = p_level.GetPlayerStartPos();
				m_x = p_start_pos.X;
				m_y = p_start_pos.Y;
			}
			
			m_p_image.SwitchImage(CResources.s_p_player);
		}
		
		public function SwitchLevel(p_new_level:CLevel):void
		{
			m_p_level = p_new_level;
			m_p_level.AddEntity(this);
			
			var p_start_pos:CPoint = m_p_level.GetPlayerStartPos();
			m_x = p_start_pos.X;
			m_y = p_start_pos.Y;
			m_draw_x = m_x;
			m_draw_y = m_y;
		}
		
		public override function DoTurn(turn_type:int):void
		{
			switch(turn_type)
			{
				case ETurnTypes.move_up:
					MoveUp();
					break;
				case ETurnTypes.move_down:
					MoveDown();
					break;
				case ETurnTypes.move_left:
					MoveLeft();
					break;
				case ETurnTypes.move_right:
					MoveRight();
					break;
			}
		}
		
		protected override function OnDeath():void 
		{
			m_p_level.m_p_root.GameOver();
		}
		
		private function TryAttackOn(targ_x:int, targ_y:int):Boolean
		{
			var p_entities:Vector.<CEntity> = m_p_level.GetEntitiesOn(targ_x, targ_y);
			for (var i:int = 0; i < p_entities.length; ++i)
			{
				var p_entity_living:CEntityLiving = p_entities[i] as CEntityLiving;
				if (p_entity_living != null && p_entity_living.IsAlive)
				{
					p_entity_living.TakeDamage();
					return true;
				}
			}
			return false;
		}
		public override function MoveUp():void 
		{
			if (TryAttackOn(m_x, m_y - 1))
				return;
			
			super.MoveUp();
		}
		public override function MoveDown():void 
		{
			if (TryAttackOn(m_x, m_y + 1))
				return;
			
			super.MoveDown();
		}
		public override function MoveLeft():void 
		{
			if (TryAttackOn(m_x - 1, m_y))
				return;
			
			super.MoveLeft();
		}
		public override function MoveRight():void 
		{
			if (TryAttackOn(m_x + 1, m_y))
				return;
			
			super.MoveRight();
		}
	}
}