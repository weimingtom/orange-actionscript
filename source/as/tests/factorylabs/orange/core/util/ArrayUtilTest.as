package tests.factorylabs.orange.core.util{	import asunit.framework.TestCase;	import com.factorylabs.orange.core.util.ArrayUtil;	/** 	 * Test methods for the ArrayUtil test case. 	 *  	 * <p>Copyright 2004-2009 by Factory Design Labs</p>     *      * Permission is hereby granted, free of charge, to any person obtaining     * a copy of this software and associated documentation files (the     * "Software"), to deal in the Software without restriction, including     * without limitation the rights to use, copy, modify, merge, publish,     * distribute, sublicense, and/or sell copies of the Software, and to     * permit persons to whom the Software is furnished to do so, subject to     * the following conditions:     *      * The above copyright notice and this permission notice shall be     * included in all copies or substantial portions of the Software.     *      * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,     * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF     * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND     * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE     * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION     * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION     * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 * <a href="http://www.factorylabs.com/">www.factorylabs.com</a> 	 *  	 * @author		Matthew Kitt 	 * @version		1.0.0 :: Mar 16, 2009 	 */	public class ArrayUtilTest		extends TestCase	{				private var _array		:Array = [ 0, 1, 2, 3, 4, 5, 6 ];		private var _first		:int = 0;		private var _end		:int = _array.length - 1;		private var _middle		:int = Math.round( _end / 2 );			public function ArrayUtilTest()		{			super();		}				override public function toString() :String 		{			return "tests.factorylabs.orange.core.util.ArrayUtilTest";		}				[Test(description="Looking for a unique copy and not a pointer. Values need to be equal and position matters.", tracker_id="")]		public function test_copy() :void		{			assertFalse( _array == ArrayUtil.copy( _array ) );			assertEquals( _array[ _first ], ArrayUtil.copy( _array )[ _first ] );			assertEquals( _array[ _middle ], ArrayUtil.copy( _array )[ _middle ] );			assertEquals( _array[ _end ], ArrayUtil.copy( _array )[ _end ] );		}				[Test(description="Looking for a unique copy and not a pointer. Values need to be equal and position matters.", tracker_id="")]		public function test_clone() :void		{			assertFalse( _array == ArrayUtil.clone( _array ) );			assertEquals( _array[ _first ], ArrayUtil.clone( _array )[ _first ] );			assertEquals( _array[ _middle ], ArrayUtil.clone( _array )[ _middle ] );			assertEquals( _array[ _end ], ArrayUtil.clone( _array )[ _end ] );		}				[Test(description="", tracker_id="")]		public function test_search() :void		{			assertEquals( 0, ArrayUtil.clone( _array )[ _first ] );			assertEquals( _middle, ArrayUtil.clone( _array )[ _middle ] );			assertEquals( _end, ArrayUtil.clone( _array )[ _end ] );		}				[Test(description="Hard to test randomness, but we can test if its a legitimate value.", tracker_id="")]		public function test_random() :void		{			var random :int = int( ArrayUtil.random( _array ) );			assertNotNull( ArrayUtil.random( _array ) );			assertTrue( ArrayUtil.contains( _array, random ) );		}				[Test(description="Hard to test if its been shuffled, but we can test if its a legitimate value.", tracker_id="")]		public function test_shuffle() :void		{			var clone :Array = ArrayUtil.clone( _array );			assertFalse( clone == ArrayUtil.shuffle( clone, true ) );			assertTrue( clone == ArrayUtil.shuffle( clone, false ) );		}				[Test(description="Loops at the front, back and stays put everywhere else.", tracker_id="")]		public function test_loop() :void		{			assertEquals( 0, ArrayUtil.loop( _array, _end + 1 ) );			assertEquals( _middle, ArrayUtil.loop( _array, _middle ) );			assertEquals( _end, ArrayUtil.loop( _array, -1 ) );		}				[Test(description="", tracker_id="")]		public function test_contains() :void		{			assertTrue( 1 == ArrayUtil.contains( _array, 1 ) );			assertFalse( 666 == ArrayUtil.contains( _array, 1 ) );		}				[Test(description="There is some kludge in how you remove an array. - see todo in ArrayUtil", tracker_id="")]		public function test_remove() :void		{			var clone	:Array = ArrayUtil.clone( _array );			ArrayUtil.remove( clone, 5 );			var tmp		:Array = [ 0, 1, 2, 3, 4, 6 ];			var end		:int = tmp.length - 1;						assertFalse( tmp == clone );			assertEquals( tmp[ 0 ], clone[ 0 ] );			assertEquals( tmp[ 2 ], clone[ 2 ] );			assertEquals( tmp[ end ], clone[ end ] );		}	}}