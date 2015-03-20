package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Alice Sparkuhl
	 */
	public class CResources 
	{
		[Embed(source = "../assets/ground.png")]
		private static var _s_p_ground_class:Class;
		private static var _s_p_ground_bitmap:Bitmap = new _s_p_ground_class();
		public static var s_p_ground:BitmapData = _s_p_ground_bitmap.bitmapData;
		
		[Embed(source="../assets/ladder.png")]
		private static var _s_p_ladder_class:Class;
		private static var _s_p_ladder_bitmap:Bitmap = new _s_p_ladder_class();
		public static var s_p_ladder:BitmapData = _s_p_ladder_bitmap.bitmapData;
		
		[Embed(source="../assets/player.png")]
		private static var _s_p_player_class:Class;
		private static var _s_p_player_bitmap:Bitmap = new _s_p_player_class();
		public static var s_p_player:BitmapData = _s_p_player_bitmap.bitmapData;
		
		[Embed(source = "../assets/player_x.png")]
		private static var _s_p_player_x_class:Class;
		private static var _s_p_player_x_bitmap:Bitmap = new _s_p_player_x_class();
		public static var s_p_player_x:BitmapData = _s_p_player_x_bitmap.bitmapData;
		
		[Embed(source="../assets/wall.png")]
		private static var _s_p_wall_class:Class;
		private static var _s_p_wall_bitmap:Bitmap = new _s_p_wall_class();
		public static var s_p_wall:BitmapData = _s_p_wall_bitmap.bitmapData;
		
		[Embed(source = "../assets/opponent_worm.png")]
		private static var _s_p_opponent_worm_class:Class;
		private static var _s_p_opponent_worm_bitmap:Bitmap = new _s_p_opponent_worm_class();
		public static var s_p_opponent_worm:BitmapData = _s_p_opponent_worm_bitmap.bitmapData;
	
		[Embed(source = "../assets/opponent_worm_x.png")]
		private static var _s_p_opponent_worm_x_class:Class;
		private static var _s_p_opponent_worm_x_bitmap:Bitmap = new _s_p_opponent_worm_x_class();
		public static var s_p_opponent_worm_dead:BitmapData = _s_p_opponent_worm_x_bitmap.bitmapData;
		
		[Embed(source = "../assets/heart_full.png")]
		private static var _s_p_heart_full_class:Class;
		private static var _s_p_heart_full_bitmap:Bitmap = new _s_p_heart_full_class();
		public static var s_p_heart_full:BitmapData = _s_p_heart_full_bitmap.bitmapData;
		
		
		private static var _s_p_bmp:Bitmap = new Bitmap(CResources.s_p_heart_full, "auto", false);
		_s_p_bmp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 0.75)];
		public static var s_p_glowing_heart_full:BitmapData = new BitmapData(_s_p_bmp.width + 2, _s_p_bmp.height + 2, true, 0);
		s_p_glowing_heart_full.draw(_s_p_bmp, new Matrix(1, 0, 0, 1, 1, 1));
		
		[Embed(source = "../assets/heart_empty.png")]
		private static var _s_p_heart_empty_class:Class;
		private static var _s_p_heart_empty_bitmap:Bitmap = new _s_p_heart_empty_class();
		public static var s_p_heart_empty:BitmapData = _s_p_heart_empty_bitmap.bitmapData;
		
		[Embed(source = "../assets/game_over_screen.png")]
		private static var _s_p_game_over_screen_class:Class;
		private static var _s_p_game_over_screen_bitmap:Bitmap = new _s_p_game_over_screen_class();
		public static var s_p_game_over_screen:BitmapData = _s_p_game_over_screen_bitmap.bitmapData;
		
		[Embed(source = "../assets/main_menu_screen.png")]
		private static var _s_p_main_menu_screen_class:Class;
		private static var _s_p_main_menu_screen_bitmap:Bitmap = new _s_p_main_menu_screen_class();
		public static var s_p_main_menu_screen:BitmapData = _s_p_main_menu_screen_bitmap.bitmapData;
		
		[Embed(source = "../assets/button_hover.png")]
		private static var _s_p_button_hover_class:Class;
		private static var _s_p_button_hover_bitmap:Bitmap = new _s_p_button_hover_class();
		public static var s_p_button_hover:BitmapData = _s_p_button_hover_bitmap.bitmapData;
		
		[Embed(source = "../assets/button_inactive.png")]
		private static var _s_p_button_inactive_class:Class;
		private static var _s_p_button_inactive_bitmap:Bitmap = new _s_p_button_inactive_class();
		public static var s_p_button_inactive:BitmapData = _s_p_button_inactive_bitmap.bitmapData;
		
		[Embed(source = "../assets/pixel_emulator.otf", fontName = "PixelFont", mimeType = "application/x-font", advancedAntiAliasing = "false", embedAsCFF = "false")]
		private static var _s_p_pixel_font_class:Class;
		
		public function CResources() 
		{
			throw new Error("Cannot instantiate resources. Plis!");
		}
		
	}

}