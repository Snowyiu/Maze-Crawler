package Animations 
{
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CSpriteSheetAnimation implements IAnimation
	{
		private var _m_p_image:CImage;
		private var _m_p_sheet:BitmapData;
		private var _m_p_anim_timer:Timer;
		
		private var _m_cur_x:int;
		private var _m_cur_y:int;
		
		private var _m_duration:int;
		
		private var _m_current_frame:int;
		
		public function CSpriteSheetAnimation(p_img:CImage, p_sheet:BitmapData, ms_per_frame:int) 
		{
			_m_current_frame = 0;
			_m_cur_x = 0;
			_m_cur_y = 0;
			_m_p_image = p_img;
			_m_p_sheet = p_sheet;
			_m_p_image.SwitchImage(_m_p_sheet, false);
			
			_m_p_anim_timer = new Timer(ms_per_frame, 0);
			_m_p_anim_timer.addEventListener(TimerEvent.TIMER, OnTimerTick);
			
			var num_ticks:int = (_m_p_sheet.width / _m_p_image.Width) * (_m_p_sheet.height / _m_p_image.Height);
			_m_duration = Number(num_ticks) / (1000.0 / ms_per_frame) * CMain.frame_rate;
		}
		
		private function OnTimerTick(p_event:TimerEvent):void 
		{
			if (!NextFrame())
			{
				_m_p_anim_timer.stop();
				_m_p_anim_timer.removeEventListener(TimerEvent.TIMER, OnTimerTick);
				_m_p_anim_timer = null;
				_m_p_image = null;
				_m_p_sheet = null;
			}
		}
		
		private function NextFrame():Boolean
		{
			_m_cur_x += _m_p_image.Width;
			if (_m_cur_x >= _m_p_sheet.width)
			{
				_m_cur_x = 0;
				_m_cur_y += _m_p_image.Height;
				if (_m_cur_y >= _m_p_sheet.height)
					return false;
			}
			
			_m_p_image.SwitchMatrix(new Matrix(1, 0, 0, 1, -_m_cur_x, -_m_cur_y));
			return true;
		}
		
		/* INTERFACE Animations.IAnimation */
		
		public function get Duration():int 
		{
			return _m_duration;
		}
		
		public function Start():void 
		{
			if (_m_p_anim_timer == null)
				return;
			
			_m_p_anim_timer.start();
		}
		
		public function Stop():void 
		{
			if (_m_p_anim_timer == null)
				return;
			
			_m_p_anim_timer.stop();
			_m_p_anim_timer.removeEventListener(TimerEvent.TIMER, OnTimerTick);
		}
		
	}

}