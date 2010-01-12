package tests.factorylabs.orange.core.math{	import com.factorylabs.orange.core.math.MathMethods;	import org.hamcrest.assertThat;	import org.hamcrest.object.equalTo;	/**	 * Generate the test cases for the MathMethods class. 	 * 	 * <hr /> 	 * <p>Copyright 2004-2010 by <a href="http://www.factorylabs.com/">Factory Design Labs</a></p> 	 * 	 * Permission is hereby granted, free of charge, to any person obtaining 	 * a copy of this software and associated documentation files (the	 * "Software"), to deal in the Software without restriction, including	 * without limitation the rights to use, copy, modify, merge, publish,	 * distribute, sublicense, and/or sell copies of the Software, and to	 * permit persons to whom the Software is furnished to do so, subject to	 * the following conditions:<br /><br />	 *	 * The above copyright notice and this permission notice shall be	 * included in all copies or substantial portions of the Software.<br /><br />	 *	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,	 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND	 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE	 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION	 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION	 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 	 *	 * @author		Matthew Kitt	 * @version		1.0.0 :: Nov 26, 2009	 */	public class MathMethodsTests 	{				[BeforeClass]		public static function runBeforeClass() :void		{					}				[AfterClass]		public static function runAfterClass() :void		{					}				[Before]		public function runBeforeEachTest() :void		{					}				[After]		public function runAfterEachTest() :void		{					}				[Test]		public function degreesToRadians() :void		{			assertThat( MathMethods.degreesToRadians( 180 ), equalTo( 3.141592653589793 ) );			assertThat( MathMethods.degreesToRadians( 90 ), equalTo( 1.5707963267948966 ) );		}				[Test]		public function radiansToDegress() :void		{			assertThat( Math.round( MathMethods.radiansToDegrees( 3.14 ) ), equalTo( 180 ) );			assertThat( Math.round( MathMethods.radiansToDegrees( 1.57 ) ), equalTo( 90 ) );		}				[Test]		public function percentToDegrees() :void		{			assertThat( MathMethods.percentToDegrees( 1 ), equalTo( 360 ) );			assertThat( MathMethods.percentToDegrees( .5 ), equalTo( 180 ) );			assertThat( MathMethods.percentToDegrees( .25 ), equalTo( 90 ) );		}				[Test]		public function degreesToPercent() :void		{			assertThat( MathMethods.degreesToPercent( 360 ), equalTo( 1 ) );			assertThat( MathMethods.degreesToPercent( 180 ), equalTo( .5 ) );			assertThat( MathMethods.degreesToPercent( 90 ), equalTo( .25 ) );		}				[Test]		public function randRange() :void		{			var random :Number = MathMethods.randRange( 0, 10 );			var inBounds :Boolean = ( random >= 0 && random <= 10 ) ? true : false;			assertThat( inBounds, equalTo( true ) );		}				[Test]		public function randRangeDecimal() :void		{			var random :Number = MathMethods.randRangeDecimel( 0, 10 );			var inBounds :Boolean = ( random >= 0 && random <= 10 ) ? true : false;			assertThat( inBounds, equalTo( true ) );		}				[Test]		public function sums() :void		{			var array :Array = [ 5, 10, 15, 20 ];			assertThat( MathMethods.sums( array ), equalTo( 50 ) );		}				[Test]		public function average() :void		{			var array :Array = [ 5, 10, 15, 20 ];			assertThat( MathMethods.average( array ), equalTo( 12.5 ) );		}				[Test]		public function getPercentWithinRange() :void		{			assertThat( MathMethods.getPercentWithinRange( 50, 150, 100 ), equalTo( 50 ) );		}				[Test]		public function interp() :void		{			assertThat( MathMethods.interp( 10, 20, .5 ), equalTo( 15 ) );		}				[Test]		public function remap() :void		{			assertThat( MathMethods.remap( 10, 0, 20, 1, 2 ), equalTo( 1.5 ) );		}	}}