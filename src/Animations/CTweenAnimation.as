package Animations 
{
	import fl.transitions.Tween;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CTweenAnimation implements IAnimation
	{
		private var _m_p_tween:Tween;
		
		public function CTweenAnimation(p_tween:Tween) 
		{
			_m_p_tween = p_tween;
			if (_m_p_tween.useSeconds)
			{
				_m_p_tween.useSeconds = false;
				_m_p_tween.duration *= 30;
			}
			
			_m_p_tween.stop();
		}
		
		/* INTERFACE Animations.IAnimation */
		
		public function get Duration():int 
		{
			return _m_p_tween.duration;
		}
		
		public function Start():void 
		{
			_m_p_tween.start();
		}
		
		public function Stop():void 
		{
			_m_p_tween.stop();
		}
		
	}

}