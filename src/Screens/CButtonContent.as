package Screens 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CButtonContent extends CScreenContent
	{
		private var _m_p_out_bitmap:BitmapData;
		private var _m_p_over_bitmap:BitmapData;
		
		private var _m_is_in_out_state:Boolean;
		
		private var _m_p_image:CDynamicImage;
		private var _m_p_tf:TextField;
		
		public function set Text(p_value:String):void
		{
			_m_p_tf.text = p_value;
			while(_m_p_tf.textWidth > (_m_p_tf.width - 10))
			{
				var p_orig_format:TextFormat = _m_p_tf.getTextFormat();
				var p_format:TextFormat = new TextFormat(p_orig_format.font, Number(p_orig_format.size) - 1, p_orig_format.color);
				
				_m_p_tf.setTextFormat(p_format);
			}
		}
		public function get Text():String
		{
			return _m_p_tf.text;
		}
		
		public function CButtonContent(p_pos:CPoint, p_out_bitmap:BitmapData = null, p_over_bitmap:BitmapData = null)
		{
			_m_is_in_out_state = true;
			if (p_out_bitmap == null)
			{
				p_out_bitmap = CResources.s_p_button_inactive;
			}
			if (p_over_bitmap == null)
			{
				p_over_bitmap = CResources.s_p_button_hover;
			}
			_m_p_out_bitmap = p_out_bitmap;
			_m_p_over_bitmap = p_over_bitmap;
			
			var width:int = Math.max(p_out_bitmap.width, p_over_bitmap.width);
			var height:int = Math.max(p_out_bitmap.height, p_over_bitmap.height);
			
			_m_p_image = new CDynamicImage(p_out_bitmap);
			super(p_pos, width, height, _m_p_image, 0);
			
			_m_p_tf = new TextField();
			var p_format:TextFormat = new TextFormat("PixelFont", 15, 0xE7E7E7);
			_m_p_tf.defaultTextFormat = p_format;
			_m_p_tf.antiAliasType = AntiAliasType.NORMAL;
			_m_p_tf.embedFonts = true;
			_m_p_tf.text = "Caption";
		}
		
		protected override function OnAttachedToRoot():void 
		{
			super.OnAttachedToRoot();
			
			m_p_root.MakeClickable(this, OnClicked);
		}
		
		private function OnClicked(p_event:MouseEvent):void
		{
			dispatchEvent(p_event);
		}
		
		private function SetState(is_in_out_state:Boolean):void
		{
			if (is_in_out_state == _m_is_in_out_state)
				return;
			
			_m_is_in_out_state = is_in_out_state;
			if (is_in_out_state)
			{
				_m_p_tf.filters = [];
			}
			else
			{
				_m_p_tf.filters = [new DropShadowFilter(0.6, 45, 0xFFFF00, 1, 5, 5, 0.5)];
			}
		}
		
		public override function Update():void 
		{
			if (hitTestPoint(parent.mouseX, parent.mouseY, false))
			{
				SetState(false);
			}
			else
			{
				SetState(true);
			}
			
			if (_m_is_in_out_state)
			{
				_m_p_image.SwitchBitmap(_m_p_out_bitmap);
			}
			else
			{
				_m_p_image.SwitchBitmap(_m_p_over_bitmap);
			}
			
			super.Update();
			bitmapData.draw(_m_p_tf, new Matrix(1, 0, 0, 1, (width - _m_p_tf.textWidth) / 2 - 2, height / 2 - _m_p_tf.textHeight / 2 - 3));
		}
	}

}