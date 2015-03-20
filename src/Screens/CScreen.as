package Screens 
{
	import flash.display.Sprite;
	import Screens.CScreenContent;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CScreen extends Sprite
	{
		private var _m_p_content:Vector.<CScreenContent>;
		
		public function CScreen() 
		{
			_m_p_content = new Vector.<CScreenContent>();
		}
		
		protected function AddContent(p_content:CScreenContent):void
		{
			_m_p_content.push(p_content);
			addChild(p_content);
		}
		
		public function Update():void
		{
			for (var i:int = 0; i < _m_p_content.length; ++i)
			{
				_m_p_content[i].Update();
			}
		}
	}

}