package  
{
	/**
	 * ...
	 * @author Alice Sparkuhl / Cedric Schneider
	 */
	public class CRandom 
	{
		private static const N:uint = 624;
		private static const M:uint = 397;
		private static const HI:uint = 0x80000000
		private static const LO:uint = 0x7fffffff
		
		private var _m_A:Array = [0, 0x9908b0df];
		private var _m_y:Array = [];
		private var _m_index:int = N + 1;
		private var _m_seed:uint;
		private var _m_e:uint; 
		
		public function CRandom(seed:uint) 
		{
			_m_seed = seed;
		}
		
		public function GetNextNumber():Number
		{
			var num:Number = Number(GetNext());
			return num / int.MAX_VALUE;
		}
		public function GetNext():uint
		{
			if (_m_index > N)
			{
				_m_y[0] = _m_seed;
				
				for (var i:int = 1; i < N; ++i)
				{
					_m_y[i] = (1812433253 * (_m_y[i - 1] ^ (_m_y[i - 1] >> 30)) + i);
				}
			}
			
			if (_m_index >= N)
			{
				var h:uint;
				var i:int;
				
				for (i = 0; i < N - M; ++i)
				{
					h = (_m_y[i] & HI) | (_m_y[i + 1] & LO);
					_m_y[i] = _m_y[i + M] ^ (h >> 1) ^ _m_A[h & 1];
				}
				for ( ; i < N - 1; ++i) 
				{
					h = (_m_y[i] & HI) | (_m_y[i+1] & LO);
					_m_y[i] = _m_y[i+(M-N)] ^ (h >> 1) ^ _m_A[h & 1];
				}
				
				h = (_m_y[N - 1] & HI) | (_m_y[0] & LO);
				_m_y[N - 1] = _m_y[M - 1] ^ (h >> 1) ^ _m_A[h & 1];
				_m_index = 0;
			}
			
			_m_e = _m_y[_m_index++];
			
			_m_e ^= (_m_e >> 11);
			_m_e ^= (_m_e <<  7) & 0x9d2c5680;
			_m_e ^= (_m_e << 15) & 0xefc60000;
			_m_e ^= (_m_e >> 18);
			
			return _m_e;
		}
		
	}

}