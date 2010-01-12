package tests.factorylabs.orange.helpers {	import flash.display.Sprite;			/**	 * Basic necessities to mock a class.	 *	 * <hr />	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p>	 *	 * Permission is hereby granted, free of charge, to any person obtaining	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: May 26, 2009	 */	public class MockBaseClass		implements IMockInterface	{		private var _var		:int;		private var _isTrue		:Boolean = true;		private var _param1		:Number;		private var _param2		:Sprite;		private var _param3		:Array;		public var baseVar   	:Sprite;				public function set testVar( $var :int ) :void		{			_var = $var;		}				public function get isTrue() :Boolean { return _isTrue; }		public function set isTrue( $isTrue :Boolean ) :void		{			_isTrue = $isTrue;		}				public function MockBaseClass()		{			shouldNotShow();		}				public function toString() :String 		{			return 'tests.factorylabs.orange.helpers.MockBaseClass';		}				public function method( $param1 :Number = NaN, $param2 :Sprite = null, $param3 :Array = null ) :void		{			_param1 = $param1;			_param2 = $param2;			_param3 = $param3;		}				protected function shouldBeProtected() :void		{			shouldNotShow();		}				public function method1() :Boolean		{			return true;		}				public static function staticMethod() :Sprite		{			return new Sprite();		}				private function shouldNotShow() :void		{			method1();		}	}}