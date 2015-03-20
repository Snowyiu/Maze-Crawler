package Entities 
{
	import Animations.CTweenAnimation;
	import Animations.IAnimation;
	import fl.motion.easing.Bounce;
	import fl.motion.easing.Quadratic;
	import fl.transitions.Transition;
	import fl.transitions.Tween;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CEntity
	{
		public var m_x:int;
		public var m_y:int;
		
		public var m_draw_x:Number;
		public var m_draw_y:Number;
		
		public var m_p_level:CLevel;
		
		private var _m_p_animations:Vector.<IAnimation>;
		
		public function CEntity(p_level:CLevel) 
		{
			_m_p_animations = new Vector.<IAnimation>();
			
			m_p_level = p_level;
			if (p_level != null)
				m_p_level.AddEntity(this);
		}
		
		public function AddAnimation(p_anim:IAnimation)
		{
			_m_p_animations.push(p_anim);
		}
		public function GetAnimationDuration():int
		{
			var max_anim_length:int = 0;
			for (var i:int = 0; i < _m_p_animations.length; ++i)
			{
				if (_m_p_animations[i].Duration > max_anim_length)
					max_anim_length = _m_p_animations[i].Duration;
			}
			return max_anim_length;
		}
		public function PlayAllAnimations():void
		{
			for (var i:int = 0; i < _m_p_animations.length; ++i)
			{
				_m_p_animations[i].Start();
			}
			_m_p_animations.splice(0, _m_p_animations.length);
		}
		
		public function DoTurn(turn_type:int):void
		{
			// virtual
		}
		
		public function Draw():BitmapData
		{
			return null;
		}
		
		public function MoveUp():void
		{
			MoveTo(0, -1);
		}
		public function MoveDown():void
		{
			MoveTo(0, 1);
		}
		public function MoveLeft():void
		{
			MoveTo( -1, 0);
		}
		public function MoveRight():void
		{
			MoveTo(1, 0);
		}
		protected function MoveTo(relative_x:int, relative_y:int):Boolean
		{
			if(m_p_level.MoveEntity(this, m_x + relative_x, m_y + relative_y))
			{
				AddAnimation(new CTweenAnimation(new Tween(this, "m_draw_x", Quadratic.easeInOut, m_x - relative_x, m_x, 15, false)));
				AddAnimation(new CTweenAnimation(new Tween(this, "m_draw_y", Quadratic.easeInOut, m_y - relative_y, m_y, 15, false)));
				return true;
			}
			return false;
		}
	}

}